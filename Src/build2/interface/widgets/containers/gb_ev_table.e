indexing
	description: "Objects that manipulate objects of type EV_TABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TABLE

	-- The following properties from EV_TABLE are manipulated by `Current'.
	-- columns - Performed on the real object and the display_object child.
	-- rows - Performed on the real object and the display_object child.
	-- border_width - Performed on the real object and the display_object child.
	-- row_spacing - Performed on the real object and the display_object child.
	-- column_spacing - Performed on the real object and the display_object child.
	-- is_homogeneous - Performed on the real object and the display_object child.

inherit
	
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	INTERNAL
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end
		
	EV_STOCK_COLORS
		rename
			implementation as stock_colors_implementation
		undefine
			default_create
		end
		
	EV_STOCK_PIXMAPS
		rename
			implementation as stock_pixmaps_implementation
		undefine
			default_create
		end
		
	GB_SHARED_OBJECT_HANDLER
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_TABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		once
			Result := Ev_table_string
		end
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			create rows_entry.make (Current, Result, "Rows", agent set_rows (?), agent valid_row_value (?))
			create columns_entry.make (Current, Result, "Columns", agent set_columns (?), agent valid_column_value (?))
			create row_spacing_entry.make (Current, Result, "Row spacing", agent set_row_spacing (?), agent valid_spacing (?))
			create column_spacing_entry.make (Current, Result, "Column spacing", agent set_column_spacing (?), agent valid_spacing (?))
			create border_width_entry.make (Current, Result, "Border width", agent set_border_width (?), agent valid_spacing (?))
			create homogeneous_button.make_with_text ("Is_homogeneous?")
			homogeneous_button.select_actions.extend (agent toggle_homogeneous)
			homogeneous_button.select_actions.extend (agent update_editors)
			Result.extend (homogeneous_button)
			create layout_button.make_with_text ("Position children...")
			if first.widget_count = 0 then
				layout_button.disable_sensitive
			end
			layout_button.select_actions.extend (agent show_layout_window)
			Result.extend (layout_button)
			selected_item_color := red
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			homogeneous_button.select_actions.block
			rows_entry.set_text (first.rows.out)
			columns_entry.set_text (first.columns.out)
			border_width_entry.set_text (first.border_width.out)
			column_spacing_entry.set_text (first.column_spacing.out)
			row_spacing_entry.set_text (first.row_spacing.out)
			if first.is_homogeneous then
				homogeneous_button.enable_select
				homogeneous_button.set_text ("Disable homogeneous")
			else
				homogeneous_button.disable_select
				homogeneous_button.set_text ("Enable homogeneous")
			end
				-- We cannot check whether layout_window.is_show_requested,
				-- which is what we really should be checking for, as
				-- checking this re-creates the window which is not good.
				-- If world /= Void, then the layout window has been shown 
				-- at least once, so this is a temporary fix.
			if world /= Void then
				selected_item := Void
				prompt_label.set_text (select_prompt)
				draw_widgets
			end
			homogeneous_button.select_actions.resume
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_column_positions_string, temp_row_positions_string,
			temp_widths_string, temp_heights_string: STRING
			item_list: ARRAYED_LIST [EV_WIDGET]
			an_object: GB_OBJECT
			layout_item, current_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			current_table_widget: EV_WIDGET
		do			
			if first.columns /= 1 then
				add_element_containing_integer (element, columns_string, first.columns)	
			end
			if first.rows /= 1 then
				add_element_containing_integer (element, rows_string, first.rows)	
			end
			if first.column_spacing /= 0 then
				add_element_containing_integer (element, column_spacing_string, first.column_spacing)
			end
			if first.row_spacing /= 0 then
				add_element_containing_integer (element, row_spacing_string, first.row_spacing)
			end
			
			if first.border_width /= 0 then
				add_element_containing_integer (element, border_width_string, first.border_width)
			end

			an_object := object_handler.object_from_display_widget (first)
			layout_item := an_object.layout_item
			
			temp_column_positions_string := ""
			temp_row_positions_string := ""
			temp_widths_string := ""
			temp_heights_string := ""
			from
				layout_item.start
			until
				layout_item.off
			loop
				current_layout_item ?= layout_item.item
				current_table_widget ?= current_layout_item.object.object
				temp_column_positions_string := temp_column_positions_string + add_leading_zeros (first.item_column_position (current_table_widget).out)--item_list.item).out)
				temp_row_positions_string := temp_row_positions_string + add_leading_zeros (first.item_row_position (current_table_widget).out)
				temp_widths_string := temp_widths_string + add_leading_zeros (first.item_column_span (current_table_widget).out)
				temp_heights_string := temp_heights_string + add_leading_zeros (first.item_row_span (current_table_widget).out)
				layout_item.forth
			end
			if not temp_column_positions_string.is_empty then
				add_element_containing_string (element, column_positions_string, temp_column_positions_string)
			end
			if not temp_row_positions_string.is_empty then
				add_element_containing_string (element, row_positions_string, temp_row_positions_string)
			end
			if not temp_widths_string.is_empty then
				add_element_containing_string (element, column_spans_string, temp_widths_string)
			end
			if not temp_heights_string.is_empty then
				add_element_containing_string (element, row_spans_string, temp_heights_string)
			end
		end
	
	add_leading_zeros (original_string: STRING): STRING is
			-- Add leading zeros to `original_string',
			-- so it is a valid 4 character, Integer representation.
		require
			original_string_length_ok: original_string.count >= 1 and original_string.count < 5
		do
			if original_string.count = 1 then
				Result := "000" + original_string
			elseif original_string.count = 2 then
				Result := "00" + original_string
			elseif original_string.count = 3 then
				Result := "0" + original_string
			end
		ensure
			Result_correct_length: Result.count = 4
			Result_is_integer: Result.is_integer
		end
		
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Columns_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.resize (element_info.data.to_integer, first.rows))
			end
			element_info := full_information @ (Rows_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.resize (first.columns, element_info.data.to_integer))
			end
			element_info := full_information @ (Column_spacing_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.set_column_spacing (element_info.data.to_integer))
			end
			element_info := full_information @ (Row_spacing_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.set_row_spacing (element_info.data.to_integer))
			end
			element_info := full_information @ (Border_width_string)
			if element_info /= Void then
				for_all_objects (agent {EV_TABLE}.set_border_width (element_info.data.to_integer))
			end
			
			
			
			
				-- All the building for an EV_FIXED needs to be deferred so
				-- we set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_column_positions_string, temp_row_positions_string,
			temp_column_spans_string, temp_row_spans_string: STRING
			counter: INTEGER
			lower, upper: INTEGER
			current_child_name: STRING
			rows, columns: STRING
			column_position, row_position, column_span, row_span: STRING
			children_names: ARRAYED_LIST [STRING]
		do

			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (columns_string)
			if element_info /= Void then
				columns := element_info.data
			else
				columns := "1"
			end
			element_info := full_information @ (rows_string)
			if element_info /= Void then
				rows := element_info.data
			else
				rows := "1"
			end
			
			Result := info.name + ".resize (" + columns + ", " + rows + ")"
			
			element_info := full_information @ (row_spacing_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_row_spacing (" + element_info.data + ")"
			end
			
			element_info := full_information @ (column_spacing_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_column_spacing (" + element_info.data + ")"
			end
			
			element_info := full_information @ (border_width_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_border_width (" + element_info.data + ")"
			end

			element_info := full_information @ (column_positions_string)
			if element_info /= Void then
				temp_column_positions_string := element_info.data
			end
			element_info := full_information @ (row_positions_string)
			if element_info /= Void then
				temp_row_positions_string := element_info.data
			end
			element_info := full_information @ (column_spans_string)
			if element_info /= Void then
				temp_column_spans_string := element_info.data
			end
			element_info := full_information @ (row_spans_string)
			if element_info /= Void then
				temp_row_spans_string := element_info.data
			end
			if temp_column_positions_string /= Void then
				check
					strings_equal_in_length: temp_column_positions_string.count = temp_row_positions_string.count and
						temp_column_positions_string.count = temp_row_spans_string.count and
						temp_column_positions_string.count = temp_column_spans_string.count
					strings_divisible_by_4: temp_column_positions_string.count \\ 4 = 0
						-- Cannot check this, as `Current' will have been built especially
						-- for code generation purposes, and `objects' will be empty,
						-- hence `first' will be Void.
					--strings_correct_length: temp_x_position_string.count // 4 = first.count			
				end
			end
			Result := Result + indent + "%T-- Insert and position all children of `" + info.name + "'."
			children_names := info.child_names 
			from
				counter := 1
			until
				counter = temp_column_positions_string.count // 4 + 1
			loop
				lower := (counter - 1) * 4 + 1
				upper := (counter - 1) * 4 + 4
				current_child_name := children_names @ counter
				column_position := temp_column_positions_string.substring (lower, upper)
				row_position := temp_row_positions_string.substring (lower, upper)
				column_span := temp_column_spans_string.substring (lower, upper)
				row_span := temp_row_spans_string.substring (lower, upper)
					-- Now remove all leading 0's from strings.
					-- 0's were added for storage in XML.
				column_position.prune_all_leading ('0')
				row_position.prune_all_leading ('0')
				column_span.prune_all_leading ('0')
				row_span.prune_all_leading ('0')
				Result := Result + indent + info.name + ".put (" + current_child_name + ", " + column_position + ", " +
					row_position + ", " + column_span + ", " + row_span + ")"			
				counter := counter + 1
			end			
			Result := strip_leading_indent (Result)
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_column_positions_string, temp_row_positions_string,
			temp_column_spans_string, temp_row_spans_string: STRING
			extracted_column, extracted_row, extracted_column_span, extracted_row_span: STRING
			first_items, second_items, temp_item_list: ARRAYED_LIST [EV_WIDGET]
			lower, upper: INTEGER
		do
				-- Only perfrom subsequent processing of children
				-- if there is one or more children.
			if first.widget_count > 0 then
				
				full_information := get_unique_full_info (element)

				element_info := full_information @ (column_positions_string)
				if element_info /= Void then
					temp_column_positions_string := element_info.data				
				end
				
				element_info := full_information @ (row_positions_string)
				if element_info /= Void then
					temp_row_positions_string := element_info.data				
				end
				
				element_info := full_information @ (column_spans_string)
				if element_info /= Void then
					temp_column_spans_string := element_info.data				
				end
				
				element_info := full_information @ (row_spans_string)
				if element_info /= Void then
					temp_row_spans_string := element_info.data			
				end
	
				check
					strings_equal_in_length: temp_column_positions_string.count = temp_row_positions_string.count and
						temp_column_positions_string.count = temp_row_spans_string.count and
						temp_column_positions_string.count = temp_column_spans_string.count
					strings_divisible_by_4: temp_column_positions_string.count \\ 4 = 0
					strings_correct_length: temp_column_positions_string.count // 4 = first.widget_count
				end
				
					-- We must now remove all the widgets contained in the tables.
					-- We store them, so they can be replaced, in the correct positions.
					-- It is not possible to move them, as any existing widgets that have not yet been
					-- moved to their correct positions may block the desired positions of the current
					-- widgets. It does not work, just to disable assertion checking here, as I already tried this.
					-- Julian.
				first_items := clone (first.item_list)
				second_items := clone ((objects @ 2).item_list)
				temp_item_list := first.item_list
				from
					temp_item_list.start
				until
					temp_item_list.off
				loop
					first.prune (temp_item_list.item)
					temp_item_list.forth
				end
				temp_item_list := (objects @ 2).item_list
				from
					temp_item_list.start
				until
					temp_item_list.off
				loop
					(objects @ 2).prune (temp_item_list.item)
					temp_item_list.forth
				end
				
				from
					first_items.start
				until
					first_items.off
				loop
						-- We now read all information from the strings retrieved form the XML.
					lower := (first_items.index - 1) * 4 + 1
					upper := (first_items.index - 1) * 4 + 4
					extracted_column := temp_column_positions_string.substring (lower, upper)
					check
						value_is_integer: extracted_column.is_integer
					end
					extracted_row := temp_row_positions_string.substring (lower, upper)
					check
						value_is_integer: extracted_row.is_integer
					end
					extracted_column_span := temp_column_spans_string.substring (lower, upper)
					check
						value_is_integer: extracted_column_span.is_integer
					end
					extracted_row_span := temp_row_spans_string.substring (lower, upper)
					check
						value_is_integer: extracted_row_span.is_integer
					end
					first.put (first_items.item, extracted_column.to_integer, extracted_row.to_integer, extracted_column_span.to_integer, extracted_row_span.to_integer)
					(objects @ 2).put (second_items @ first_items.index, extracted_column.to_integer, extracted_row.to_integer, extracted_column_span.to_integer, extracted_row_span.to_integer)
					
					first_items.forth
				end
			end
		end


feature {NONE} -- Implementation

	layout_window: EV_DIALOG is
			-- Window for laying out children of fixed.
		local
			horizontal_box, h1: EV_HORIZONTAL_BOX
			vertical_box: EV_VERTICAL_BOX
			ok_button: EV_BUTTON
			cell: EV_CELL
			status_bar: EV_FRAME
		do
			create Result
			Result.set_title ("EV_TABLE child positioner")
			create vertical_box
			Result.extend (vertical_box)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create drawing_area
			drawing_area.set_minimum_size (200, 200)
			
			drawing_area.pointer_motion_actions.force_extend (agent track_movement (?, ?))
			drawing_area.pointer_button_press_actions.force_extend (agent button_pressed (?, ?, ?))
			drawing_area.pointer_button_release_actions.force_extend (agent button_released (?, ?, ?))
			create world
			create pixmap
			drawing_area.resize_actions.force_extend (agent update_pixmap_size)
			drawing_area.resize_actions.force_extend (agent draw_widgets)
			create projector.make_with_buffer (world, pixmap, drawing_area)

			create ok_button.make_with_text ("Done")
			ok_button.select_actions.extend (agent Result.destroy)			
			create scrollable_area
			scrollable_area.set_minimum_size (200, 200)
			create h1
			create status_bar
			status_bar.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_lowered)
			h1.extend (status_bar)
			create prompt_label.make_with_text (select_prompt)
			status_bar.extend (prompt_label)
			h1.extend (ok_button)
			h1.disable_item_expand (ok_button)
			vertical_box.extend (h1)
			vertical_box.disable_item_expand (h1)

			horizontal_box.extend (scrollable_area)
			scrollable_area.extend (drawing_area)
			scrollable_area.resize_actions.force_extend (agent set_initial_area_size)
		end
		
	set_initial_area_size is
			-- Set initial size of `drawing_area' relative to `scrollable_area'
		do
			drawing_area.set_minimum_size (scrollable_area.width.max (first.columns * grid_size + diagram_border * 2),
				scrollable_area.height.max (first.rows * grid_size + diagram_border * 2))
		end
		
		
	update_pixmap_size (x, y, width, height: INTEGER) is
			-- Resize `pixmap' to `width', `height'.
		do
				-- A pixmap is 1x1 as default, 
				-- and you can not set the size to 0x0.
				-- Why is this?
			if width >= 1 and height >=1 then
				pixmap.set_size (width, height)	
			end
		end
		
	draw_widgets is
			-- Draw representation of all widgets and grid if shown.
		local
			relative_pointa, relative_pointb: EV_RELATIVE_POINT
			figure_rectangle: EV_FIGURE_RECTANGLE
			widgets: ARRAYED_LIST [EV_WIDGET]
			widget: EV_WIDGET
		do
				-- Remove all previous figures from `world'.
			world.wipe_out
				-- We must  draw the grid if necessary.
			draw_grid	
			
			widgets := first.item_list
			from
				widgets.start
			until
				widgets.off
			loop
				widget := widgets.item
				if widget /= selected_item then
					create relative_pointa.make_with_position ((first.item_column_position (widget) - 1) * grid_size + diagram_border, (first.item_row_position (widget) - 1) * grid_size + diagram_border)
					create relative_pointb.make_with_position ((first.item_column_position (widget) - 1) * grid_size + (first.item_column_span (widget)) * grid_size + diagram_border, (first.item_row_position (widget) - 1) * grid_size + (first.item_row_span (widget)) * grid_size + diagram_border)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.set_foreground_color (black)
					figure_rectangle.remove_background_color
					world.extend (figure_rectangle)
				end
				widgets.forth
			end
			if draw_greyed_widget then
					create relative_pointa.make_with_position (grey_x * grid_size + diagram_border, grey_y * grid_size + diagram_border)
					create relative_pointb.make_with_position (grey_x * grid_size + grey_x_span * grid_size + diagram_border, grey_y * grid_size + grey_y_span * grid_size + diagram_border)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.remove_background_color
					figure_rectangle.set_foreground_color (grey)
					world.extend (figure_rectangle)
			end
			if selected_item /= Void then
					create relative_pointa.make_with_position ((first.item_column_position (selected_item) - 1) * grid_size + diagram_border, (first.item_row_position (selected_item) - 1) * grid_size + diagram_border)
					create relative_pointb.make_with_position ((first.item_column_position (selected_item) - 1) * grid_size + (first.item_column_span (selected_item)) * grid_size + diagram_border, (first.item_row_position (selected_item) - 1) * grid_size + (first.item_row_span (selected_item)) * grid_size + diagram_border)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.remove_background_color
					figure_rectangle.set_foreground_color (selected_item_color)
					world.extend (figure_rectangle)
			end
			projector.project
		end
		
	draw_grid is
			-- Draw snap to grid in `world'.
		local
			counter: INTEGER
			figure_line: EV_FIGURE_LINE
			color: EV_COLOR
			relative_point: EV_RELATIVE_POINT
			rows_size, columns_size: INTEGER
		do
				-- Create a light green for the grid color.
			create color.make_with_8_bit_rgb (196, 244, 204)
			
				-- compute commonly requested values.
			rows_size := first.rows * grid_size
			columns_size := first.columns * grid_size
			
			from
				counter := 0
			until
				counter > columns_size
			loop
				create figure_line.make_with_positions (counter + diagram_border, diagram_border, counter + diagram_border, rows_size + diagram_border)
				figure_line.set_foreground_color (color)
				create relative_point.make_with_position (drawing_area.width + diagram_border, counter + diagram_border)
				world.extend (figure_line)
				counter := counter + grid_size	
			end
			from
				counter := 0
			until
				counter > rows_size
			loop
				create figure_line.make_with_positions (diagram_border, counter + diagram_border, columns_size + diagram_border, counter + diagram_border)
				figure_line.set_foreground_color (color)
				world.extend (figure_line)
				counter := counter + grid_size
			end
		end
		
		
	set_item_span (v: EV_WIDGET; columns, rows: INTEGER) is
			-- Adjust `v' so that it spans `columns', `rows' within
			-- objects.
		local
			second_widget: EV_WIDGET
		do
				-- Do nothing if span has not changed.
			if first.item_column_span (v) /= columns or first.item_row_span (v) /= rows then
				first.set_item_span (v, columns, rows)
					-- Now we need to get the widget represented in objects at the
					-- second place.
				second_widget := (objects @ 2).item (first.item_column_position (v), first.item_row_position (v))
				(objects @ 2).set_item_span (second_widget, columns, rows)
					-- Flag that notification is required for all corresponding editors.
				must_update_editors := True
					-- Update project.
				enable_project_modified
			end
		end
		
	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, columns, rows: INTEGER) is
			-- Move `v' to `a_column', `a_row' and resize to `columns', `rows'.
		local
			second_widget: EV_WIDGET
		do
				-- Do nothing it position and span has not changed.
			if first.item_column_position (v) /= a_column or first.item_row_position (v) /= a_row or
			 first.item_column_span (v) /= columns or first.item_row_span (v) /= rows then
					-- Now we need to get the widget represented in objects at the
					-- second place. We must do this before we move the first widget.
				second_widget := (objects @ 2).item (first.item_column_position (v), first.item_row_position (v))
	
				first.set_item_position_and_span (v, a_column, a_row, columns, rows)
				(objects @ 2).set_item_position_and_span (second_widget, a_column, a_row, columns, rows)
					-- Flag that notification is required for all corresponding editors.
				must_update_editors := True
					-- Update project.
				enable_project_modified		
			end
		end
		

	track_movement (x_position, y_position: INTEGER) is
			-- Track `x', `y' position of cursor, and position widgets
			-- as necessary.
		local
			new_x, new_y: INTEGER
			column_position, row_position, end_row_position, end_column_position: INTEGER
			new_column, new_row: INTEGER
			end_position, current_x_position, current_y_position: INTEGER
			x, y: INTEGER
		do
				-- Always reset here, as generally, we will not
				-- need to update. Only if a child is moved or resized.
			must_update_editors := False
				-- Transform coordinates to take into account offset of actual diagram.
			x := x_position - diagram_border
			y := y_position - diagram_border
			if selected_item /= Void then
				column_position := (first.item_column_position (selected_item) - 1) * grid_size
				row_position := (first.item_row_position (selected_item) - 1) * grid_size
				end_column_position := column_position + first.item_column_span (selected_item) * grid_size
				end_row_position := row_position + first.item_row_span (selected_item) * grid_size				

				if close_to (x, y, end_column_position, end_row_position) or
					close_to (x, y, column_position, row_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenwse_cursor)	
					end
				elseif close_to (x, y, column_position, end_row_position) or
					close_to (x, y, end_column_position, row_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenesw_cursor)	
					end
				elseif close_to_line (x, y, end_row_position, column_position + accuracy_value, end_column_position - accuracy_value) or
					close_to_line (x, y, row_position, column_position + accuracy_value, end_column_position - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizens_cursor)	
					end
				elseif close_to_line (y, x, column_position, row_position + accuracy_value, end_row_position - accuracy_value) or
					close_to_line (y, x, end_column_position, row_position + accuracy_value, end_row_position - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizewe_cursor)	
					end
				elseif x > column_position and x < end_column_position and y > row_position and y < end_row_position then
					if not resizing_widget then
						set_all_pointer_styles (sizeall_cursor)	
					end
				else
					if not resizing_widget or not moving_widget then
						set_all_pointer_styles (standard_cursor)
					end
				end
			end
			
			if resizing_widget then
				
				if x_scale /= 0 then
					if x_offset = 0 then
						end_position := (original_column + original_column_span)
						new_x := x + half_grid_size - ((x + half_grid_size) \\ grid_size)
						current_x_position := (((new_x // grid_size) + 1).max (1)).min (end_position - 1)
						if first.area_clear_excluding_widget (selected_item, current_x_position, first.item_row_position (selected_item), end_position - current_x_position, first.item_row_span (selected_item)) then
							set_item_position_and_span (selected_item, current_x_position, first.item_row_position (selected_item), end_position - current_x_position, first.item_row_span (selected_item))
						else
							current_x_position := first_filled_horizontal_space (selected_item, end_position - 1, first.item_row_position (selected_item), first.item_row_span (selected_item))-- + 1
								-- We need to change the order depending on the movement that we are performing. This
								-- ensures that we stay within valid bounds.
						 	set_item_position_and_span (selected_item, current_x_position, first.item_row_position (selected_item) , end_position - current_x_position, first.item_row_span (selected_item))
						end
					else
						x := x - column_position
						new_x := x + half_grid_size - ((x + half_grid_size) \\ grid_size)
						new_column := (new_x // grid_size).min (first.columns - first.item_column_position (selected_item) + 1).max (1)
						if first.item_column_span (selected_item)/= new_column and first.area_clear_excluding_widget (selected_item, first.item_column_position (selected_item), first.item_row_position (selected_item), new_column, first.item_row_span (selected_item)) then --new_column.max (1).min (first.columns - first.item_column_position (selected_item) + 1), first.item_row_span (selected_item)) then
							set_item_span (selected_item, new_column, first.item_row_span (selected_item))
						end
					end
				end
				
				if y_scale /= 0 then
					if y_offset = 0 then
						end_position := (original_row + original_row_span)
						new_y := y + half_grid_size - ((y + half_grid_size) \\ grid_size)
						current_y_position := (((new_y // grid_size) + 1).max (1)).min (end_position - 1)
						if first.area_clear_excluding_widget (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_span (selected_item), end_position - current_y_position) then
							set_item_position_and_span (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_span (selected_item), end_position - current_y_position)
						else
							current_y_position := first_filled_vertical_space (selected_item, end_position - 1, first.item_column_position (selected_item), first.item_column_span (selected_item))-- + 1
							set_item_position_and_span (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_span (selected_item), end_position - current_y_position)
						end
					else
						y := y - row_position
						new_y := y + half_grid_size - ((y + half_grid_size) \\ grid_size)
						new_row := (new_y // grid_size).min (first.rows - first.item_row_position (selected_item) + 1).max (1)
						if first.item_row_span (selected_item) /= new_row and first.area_clear_excluding_widget (selected_item, first.item_column_position (selected_item), first.item_row_position (selected_item), first.item_column_span (selected_item), new_row) then --.max (1).min (first.rows - first.item_row_position (selected_item) + 1)) then
							set_item_span (selected_item, first.item_column_span (selected_item), new_row)
						end
					end
				end				
									
				draw_widgets
			end
			if moving_widget then	
				new_x := x - ((x - x_offset) \\ grid_size)
				new_y := y - ((y - y_offset) \\ grid_size)	
				x := ((new_x - x_offset) // grid_size + 1).min (first.columns - first.item_column_span (selected_item) + 1).max (1)
				y := ((new_y - y_offset) // grid_size + 1).min (first.rows - first.item_row_span (selected_item) + 1).max (1)
				if (first.item_column_position (selected_item) /= x or first.item_row_position (selected_item) /= y) then
					if
						first.area_clear_excluding_widget (selected_item, x, y, first.item_column_span (selected_item), first.item_row_span (selected_item)) then
						set_item_position_and_span (selected_item, x, y, first.item_column_span (selected_item), first.item_row_span (selected_item))
						draw_greyed_widget := False
					else
						draw_greyed_widget := True
						grey_x := x - 1
						grey_y := y - 1
						grey_x_span := first.item_column_span (selected_item)
						grey_y_span := first.item_row_span (selected_item)
					end
				end
				draw_widgets
			end
			if must_update_editors then
				update_editors
			end
		end
		
	first_filled_horizontal_space (widget: EV_WIDGET; a_column, a_row, a_row_span: INTEGER): INTEGER is
			-- `Result' is lowest column value, counting down from `a_column' which has the rows
			-- `a_row' to `a_row' + `a_row_span' free from items.
		local
			row_counter, column_counter: INTEGER
		do
			from
				column_counter := a_column
			until
				column_counter = 0 or Result /= 0
			loop
				from
					row_counter := a_row
				until
					row_counter = a_row + a_row_span or Result /= 0
				loop
					if first.item (column_counter, row_counter) /= Void and first.item (column_counter, row_counter) /= widget then
						Result := column_counter + 1
					end
					row_counter := row_counter + 1
				end
				column_counter := column_counter - 1
			end
		end
		
	first_filled_vertical_space (widget: EV_WIDGET; a_row, a_column, a_column_span: INTEGER): INTEGER is
			-- `Result' is lowest row value, counting down from `a_row' which has the columns
			-- `a_column' to `a_column' + `a_column_span' free from items.
		local
			row_counter, column_counter: INTEGER
		do
			from
				row_counter := a_row
			until
				row_counter = 0 or Result /= 0
			loop
				from
					column_counter := a_column
				until
					column_counter = a_column + a_column_span or Result /= 0
				loop
					if first.item (column_counter, row_counter) /= Void and first.item (column_counter, row_counter) /= widget then
						Result := row_counter + 1
					end
					column_counter := column_counter + 1
				end
				row_counter := row_counter - 1
			end
		end

	close_to (current_x, current_y, desired_x, desired_y: INTEGER): BOOLEAN is
			-- Is position `current_x', `current_y' within `accuracy_value' of `desired_x', `desired_y'.
		do
			if (current_x - desired_x).abs < accuracy_value and (current_y - desired_y).abs < accuracy_value then
				Result := True
			end
		end

	close_to_line (coordinate_a, coordinate_b, line_offset, line_start, line_end: INTEGER): BOOLEAN is
		do
			if coordinate_a > line_start and coordinate_a < line_end and (coordinate_b - line_offset).abs < accuracy_value then
				Result := True
			end
		end
		
	half_grid_size: INTEGER is
			-- Half size of current grid.
		do
			Result := grid_size // 2
		end
		
	button_pressed (x_position, y_position, a_button: INTEGER) is
			-- A button has been pressed. If `a_button' = 1 then
			-- check for movement/resizing.
		local
			column_position, row_position, column_span, row_span,
			end_column_position, end_row_position: INTEGER
			x, y: INTEGER
		do
				-- We need to make `selected_item' Void and redraw it
				-- as black in all other editors referencing `Current'.
			update_editors
				-- Transform coordinates to take into account offset of actual diagram.
			x := x_position - diagram_border
			y := y_position - diagram_border
			if selected_item /= Void then
					-- We must store the original size and position of `selected_item'.
					-- This is necessary, as in `track_movement', we may move and re-size
					-- `selected_item', although still need to perform the calculations on
					-- the current cursor position against the position of `selected_item'
					-- when the resizing began.
				original_column := first.item_column_position (selected_item)
				original_row := first.item_row_position (selected_item)	
				original_column_span := first.item_column_span (selected_item)
				original_row_span := first.item_row_span (selected_item)
				
				
					-- Now perform some calculations just once ready for later.
				column_position := (first.item_column_position (selected_item) - 1) * grid_size
				row_position := (first.item_row_position (selected_item) - 1) * grid_size
				end_column_position := column_position + first.item_column_span (selected_item) * grid_size
				end_row_position := row_position + first.item_row_span (selected_item) * grid_size
				row_span := first.item_row_span (selected_item) * grid_size
				column_span := first.item_column_span (selected_item) * grid_size

				if a_button = 1 and not resizing_widget and not moving_widget then
						-- Unset this, if this is not the case, as we have 8 checks which would need it
						-- assigning otherwise
					resizing_widget := True
					if close_to (x, y, end_column_position, end_row_position) then
						x_offset := column_span
						y_offset := row_span
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, column_position, row_position) then
						x_offset := 0
						y_offset := 0
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, column_position, end_row_position) then
						x_offset := 0
						y_offset := row_span
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, end_column_position, row_position) then
						x_offset := column_span
						y_offset := 0
						x_scale := 1; y_scale := 1
					elseif close_to_line (x, y, end_row_position, column_position + accuracy_value, end_column_position - accuracy_value) then
						x_offset := x - column_position
						y_offset := row_span
						x_scale := 0; y_scale := 1
					elseif close_to_line (x, y, row_position, column_position + accuracy_value, end_column_position - accuracy_value) then
						x_offset := x
						y_offset := 0
						x_scale := 0; y_scale := 1
					elseif close_to_line (y, x, column_position, row_position + accuracy_value, end_row_position - accuracy_value) then
						x_offset := 0
						y_offset := y
						x_scale := 1; y_scale := 0
					elseif close_to_line (y, x, end_column_position, row_position + accuracy_value, end_row_position - accuracy_value) then
						x_offset := column_span
						y_offset := y
						x_scale := 1; y_scale := 0
					elseif x > column_position and x < end_column_position and y > row_position and y < end_row_position then
						moving_widget := True
						resizing_widget := False
						x_offset := x - column_position
						y_offset := y - row_position
					else
						resizing_widget := False
					end
					if resizing_widget or moving_widget then
						drawing_area.enable_capture	
					end
				end
			
			end
				-- We need to highlight a widget if the action is
				-- to select a widget.
			if a_button = 1 and not resizing_widget and not moving_widget then
				x := x // grid_size + 1
				y := y // grid_size + 1
					-- Only perform the query if valid coordinates.
				if x <= first.columns and y <= first.rows then
					selected_item := first.item (x, y)
					if selected_item = Void then
						prompt_label.set_text (select_prompt)
					else
						prompt_label.set_text ("Position highlighted widget")
					end
				end
				draw_widgets
			end
		end
		
	button_released (x, y, a_button: INTEGER) is
			-- A button has been released on `drawing_area'
			-- If `a_button' = 1, check for end of resize/movement.
		do
			draw_greyed_widget := False
			if a_button = 1 then
				if resizing_widget then
					resizing_widget := False
					set_all_pointer_styles (standard_cursor)
					drawing_area.disable_capture
				elseif moving_widget then
					moving_widget := False
					set_all_pointer_styles (standard_cursor)
					drawing_area.disable_capture
				end
			draw_widgets
			end
		end
		
	show_layout_window is
			-- Display window allowing placement of widgets.
		do
			layout_window.show_modal_to_window (parent_window (parent_editor))
		end
		
	set_all_pointer_styles (cursor: EV_CURSOR) is
			-- Assign a pointer style to all figures in
			-- `world' and `drawing_area'.
		do
			from
				world.start
			until
				world.off				
			loop
				world.item.set_pointer_style (cursor)
				world.forth
			end
			drawing_area.set_pointer_style (cursor)
		end

	set_rows (row_value: INTEGER) is
			-- Resize table to accomodate `row_value' rows.
		do
			for_all_objects (agent {EV_TABLE}.resize (first.columns, row_value))
		end
		
	set_columns (column_value: INTEGER) is
			-- Resize table to accomodate `column_value' columns.
		do
			for_all_objects (agent {EV_TABLE}.resize (column_value, first.rows))
		end
		
	set_border_width (border_width: INTEGER) is
			-- Assign `border_width' to border width of table.
		do
			for_all_objects (agent {EV_TABLE}.set_border_width (border_width))
		end
		
	set_row_spacing (row_spacing: INTEGER) is
			-- Assign `row_spacing' to row spacing of table.
		do
			for_all_objects (agent {EV_TABLE}.set_row_spacing (row_spacing))
		end
		
	set_column_spacing (column_spacing: INTEGER) is
			-- Assign `column_spacing' to column spacing of table.
		do
			for_all_objects (agent {EV_TABLE}.set_column_spacing (column_spacing))
		end
		
		
	valid_row_value (new_value: INTEGER): BOOLEAN is
			-- Is `new_value' a valid row size for table.
		do
			Result := first.rows_resizable_to (new_value)
		end
		
	valid_column_value (new_value: INTEGER): BOOLEAN is
			-- Is `new_value' a valid column size for table.
		do
			Result := first.columns_resizable_to (new_value)
		end
		
	valid_spacing (new_value: INTEGER): BOOLEAN is
			-- Is `new_value' a valid spacing value?
		do
			Result := new_value > 0
		end
		
	toggle_homogeneous is
			-- NOT `is_homogeneous' state.
		do
			if first.is_homogeneous then
				for_all_objects (agent {EV_TABLE}.disable_homogeneous)
				homogeneous_button.set_text ("Enable homogeneous")
			else
				for_all_objects (agent {EV_TABLE}.enable_homogeneous)
				homogeneous_button.set_text ("Disable homogeneous")
			end
		end


feature {NONE} -- Attributes

	prompt_label: EV_LABEL

	rows_entry, columns_entry, row_spacing_entry, column_spacing_entry, border_width_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets used.
		
	homogeneous_button: EV_CHECK_BUTTON
		-- Toggles `is_homogeneous' for table.
		
	layout_button: EV_BUTTON
		-- Provides access to the layout window.
		
	resizing_widget: BOOLEAN
		-- Is a widget currently being resized?
		
	moving_widget: BOOLEAN
		-- Is a widget currently being moved?
	
	x_offset, y_offset: INTEGER
		-- Offsets used to hold cursor distance from
		-- point being targeted.

	x_scale, y_scale: INTEGER
		-- Amount to scale movement in the X or Y axis by.
		-- Should be 1 or 0. 1 means full movement, 0 means
		-- that axis is ignored.

	drawing_area: EV_DRAWING_AREA
		-- Drawing area used to represent `world'
	
	scrollable_area: EV_SCROLLABLE_AREA
		-- A scrollable area which contains `drawing_area'.
	
	accuracy_value: INTEGER is 3
			-- Value which determines how close pointer must be
			-- to lines/points for resizing.

	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector used for `world'
	
	pixmap: EV_PIXMAP
		-- Pixmap for double buffering `world'.
			
	world: EV_FIGURE_WORLD
		-- Figure world containg all widget representations.
		
	grid_size: INTEGER is 20
		-- Size of grid representing the table.
		
	selected_item: EV_WIDGET
		-- Item that is currently selected for movement.
		
	selected_item_color: EV_COLOR
		-- Color used to draw `selected_item'.
		
	rows_string: STRING is "Rows"
	
	columns_string: STRING is "Columns"
	
	row_spacing_string: STRING is "Row_spacing"
	
	column_spacing_string: STRING is "Column_spacing"
	
	border_width_string: STRING is "Border_width"
	
	diagram_border: INTEGER is 25
		-- Size of border around table representation in diagram.
		
	Column_positions_string: STRING is "Column_positions"
	
	Row_positions_string: STRING is "Row_positions"
	
	Column_spans_string: STRING is "Column_spans"
	
	Row_spans_string: STRING is "Row_spans"
	
	draw_greyed_widget: BOOLEAN
		-- Should a greyed representation of the desired widget position/
		-- size be drawn
		
	must_update_editors: BOOLEAN
		-- Should we update all other editors?
		-- Used in `track_movement', so we can update other
		-- windows when widgets size and position changes.
	
	grey_x, grey_y, grey_x_span, grey_y_span: INTEGER
		-- Table coordinates for `draw_greyed_widget'.
		
	original_column, original_row, original_column_span, original_row_span: INTEGER
		-- Temporary variables used to keep original position of `selected_item'
		-- when button was pressed. These values are used in `track_movement' to
		-- calculate new size/position of `selected_item', based on the current mouse
		-- position.
		
	select_prompt: STRING is "Please select desired widget"
		-- Prompt to help user.

end -- class GB_EV_TABLE
