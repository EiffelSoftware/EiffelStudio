indexing
	description: "Objects that manipulate objects of type EV_TABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TABLE

	-- The following properties from EV_TABLE are manipulated by `Current'.
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

feature -- Access


	ev_type: EV_TABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
			second: like ev_type
			check_button: EV_CHECK_BUTTON
			button: EV_BUTTON
		do
			Result := Precursor {GB_EV_ANY}
			create rows_entry.make (Current, Result, "Rows", agent set_rows (?), agent valid_row_value (?))
			create columns_entry.make (Current, Result, "Columns", agent set_columns (?), agent valid_column_value (?))
			create row_spacing_entry.make (Current, Result, "Row spacing", agent set_row_spacing (?), agent valid_spacing (?))
			create column_spacing_entry.make (Current, Result, "Column spacing", agent set_column_spacing (?), agent valid_spacing (?))
			create border_width_entry.make (Current, Result, "Border width", agent set_border_width (?), agent valid_spacing (?))
			create homogeneous_button.make_with_text ("Enable_homogeneous")
			homogeneous_button.select_actions.extend (agent toggle_homogeneous)
			Result.extend (homogeneous_button)
			create layout_button.make_with_text ("Position children")
			layout_button.select_actions.extend (agent show_layout_window)
			Result.extend (layout_button)
			selected_item_color := red
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			rows_entry.set_text (first.rows.out)
			columns_entry.set_text (first.columns.out)
			border_width_entry.set_text (first.border_width.out)
			column_spacing_entry.set_text (first.column_spacing.out)
			row_spacing_entry.set_text (first.row_spacing.out)
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
			temp: STRING
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
			
			
--			temp_x_position_string := ""
--			temp_y_position_string := ""
--			temp_width_string := ""
--			temp_height_string := ""
--			from
--				first.start
--			until
--				first.off
--			loop
--				temp_x_position_string := temp_x_position_string + add_leading_zeros (first.item.x_position.out)
--				temp_y_position_string := temp_y_position_string + add_leading_zeros (first.item.y_position.out)
--				temp_width_string := temp_width_string + add_leading_zeros (first.item.width.out)
--				temp_height_string := temp_height_string + add_leading_zeros (first.item.height.out)
--				first.forth
--			end
--			if not temp_x_position_string.is_empty then
--				add_element_containing_string (element, x_position_string, temp_x_position_string)
--			end
--			if not temp_y_position_string.is_empty then
--				add_element_containing_string (element, y_position_string, temp_y_position_string)
--			end
--			if not temp_width_string.is_empty then
--				add_element_containing_string (element, width_string, temp_width_string)
--			end
--			if not temp_height_string.is_empty then
--				add_element_containing_string (element, height_string, temp_height_string)
--			end
		end
		
--	add_leading_zeros (original_string: STRING): STRING is
--			-- Add leading zeros to `original_string',
--			-- so it is a valid 4 character, Integer representation.
--		require
--			original_string_length_ok: original_string.count >= 1 and original_string.count < 5
--		do
--			if original_string.count = 1 then
--				Result := "000" + original_string
--			elseif original_string.count = 2 then
--				Result := "00" + original_string
--			elseif original_string.count = 3 then
--				Result := "0" + original_string
--			end
--		ensure
--			Result_correct_length: Result.count = 4
--			Result_is_integer: Result.is_integer
--		end
		
		
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

	generate_code (element: XML_ELEMENT; a_name, a_type: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
			counter: INTEGER
			lower, upper: INTEGER
			current_child_name: STRING
		do
--			Result := ""
--			full_information := get_unique_full_info (element)
--			element_info := full_information @ (x_position_string)
--			if element_info /= Void then
--				temp_x_position_string := element_info.data
--			end
--			element_info := full_information @ (y_position_string)
--			if element_info /= Void then
--				temp_y_position_string := element_info.data
--			end
--			element_info := full_information @ (width_string)
--			if element_info /= Void then
--				temp_width_string := element_info.data
--			end
--			element_info := full_information @ (height_string)
--			if element_info /= Void then
--				temp_height_string := element_info.data
--			end
--			check
--				strings_equal_in_length: temp_x_position_string.count = temp_y_position_string.count and
--					temp_x_position_string.count = temp_width_string.count and
--					temp_x_position_string.count = temp_height_string.count
--				strings_divisible_by_4: temp_x_position_string.count \\ 4 = 0
--					-- Cannot check this, as `Current' will have been built especially
--					-- for code generation purposes, and `objects' will be empty,
--					-- hence `first' will be Void.
--				--strings_correct_length: temp_x_position_string.count // 4 = first.count			
--			end
--			Result := Result + indent + "%T-- Size and position all children of `" + a_name + "'."
--			from
--				counter := 1
--			until
--				counter = temp_x_position_string.count // 4 + 1
--			loop
--				lower := (counter - 1) * 4 + 1
--				upper := (counter - 1) * 4 + 4
--				current_child_name := children_names @ counter
--				Result := Result + indent + a_name + ".set_item_x_position (" + current_child_name + ", " + temp_x_position_string.substring (lower, upper) + ")"
--				Result := Result + indent + a_name + ".set_item_y_position (" + current_child_name + ", " + temp_y_position_string.substring (lower, upper) + ")"
--				Result := Result + indent + a_name + ".set_item_width (" + current_child_name + ", " + temp_width_string.substring (lower, upper) + ")"
--				Result := Result + indent + a_name + ".set_item_height (" + current_child_name + ", " + temp_height_string.substring (lower, upper) + ")"
--				counter := counter + 1
--			end			
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
			extracted_string: STRING
		do
--			full_information := get_unique_full_info (element)
--			element_info := full_information @ (x_position_string)
--			if element_info /= Void then
--				temp_x_position_string := element_info.data				
--			end
--			
--			element_info := full_information @ (y_position_string)
--			if element_info /= Void then
--				temp_y_position_string := element_info.data				
--			end
--			
--			element_info := full_information @ (width_string)
--			if element_info /= Void then
--				temp_width_string := element_info.data				
--			end
--			
--			element_info := full_information @ (height_string)
--			if element_info /= Void then
--				temp_height_string := element_info.data			
--			end
--			
--			check
--				strings_equal_in_length: temp_x_position_string.count = temp_y_position_string.count and
--					temp_x_position_string.count = temp_width_string.count and
--					temp_x_position_string.count = temp_height_string.count
--				strings_divisible_by_4: temp_x_position_string.count \\ 4 = 0
--				strings_correct_length: temp_x_position_string.count // 4 = first.count
--			end
--			
--			from
--				first.start
--			until
--				first.off
--			loop
--					-- Read current x position data from `temp_x_position_string'.
--				extracted_string := temp_x_position_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
--				check
--					value_is_integer: extracted_string.is_integer
--				end
--				set_x_position (first.item, extracted_string.to_integer)
--					
--					-- Read current y position data from `temp_y_position_string'.
--				extracted_string := temp_y_position_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
--				check
--					value_is_integer: extracted_string.is_integer
--				end
--				set_y_position (first.item, extracted_string.to_integer)
--				
--					-- Read current width data from `temp_width_string'.
--				extracted_string := temp_width_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
--				check
--					value_is_integer: extracted_string.is_integer
--				end
--				set_item_width (first.item, extracted_string.to_integer)
--				
--					-- Read current height data from `temp_height_string'.
--				extracted_string := temp_height_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
--				check
--					value_is_integer: extracted_string.is_integer
--				end
--				set_item_height (first.item, extracted_string.to_integer)
--				
--				first.forth
--			end	
		end

feature {NONE} -- Implementation

	layout_window: EV_DIALOG is
			-- Window for laying out children of fixed.
		local
			horizontal_box, hb: EV_HORIZONTAL_BOX
			vertical_box, vb, vb1: EV_VERTICAL_BOX
			ok_button: EV_BUTTON
			list_item: EV_LIST_ITEM
			grid_control_holder: EV_FRAME
		do
			create Result
			create vertical_box
			Result.extend (vertical_box)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create drawing_area
			drawing_area.set_minimum_size (200, 200)
			
			drawing_area.pointer_motion_actions.force_extend (agent track_movement (?, ?))
			drawing_area.pointer_button_press_actions.force_extend (agent button_pressed (?, ?, ?))
			drawing_area.pointer_button_release_actions.force_extend (agent button_released (?, ?, ?))
--			create list
--			
			create world
			create pixmap
			drawing_area.resize_actions.force_extend (agent update_pixmap_size)
			drawing_area.resize_actions.force_extend (agent draw_widgets)
			create projector.make_with_buffer (world, pixmap, drawing_area)
--			
			create scrollable_area
			scrollable_area.set_minimum_size (200, 200)
			create ok_button.make_with_text ("OK")
			ok_button.select_actions.extend (agent Result.destroy)
			vertical_box.extend (ok_button)
			vertical_box.disable_item_expand (ok_button)
			horizontal_box.extend (scrollable_area)
			scrollable_area.extend (drawing_area)
			scrollable_area.resize_actions.force_extend (agent set_initial_area_size)
--			
--			create vertical_box
--			horizontal_box.extend (vertical_box)
--			horizontal_box.disable_item_expand (vertical_box)
--				-- We do not build a new control if it already exists.
--			if snap_button = Void then
--				create snap_button.make_with_text ("Snap to grid")
--				snap_button.enable_select
--			else
--				snap_button.parent.prune_all (snap_button)
--			end
--			create grid_control_holder.make_with_text ("Grid properties")
--			create vb1
--			grid_control_holder.extend (vb1)
--			vertical_box.extend (list)
--			vertical_box.extend (grid_control_holder)
--			vb1.extend (snap_button)
--			vertical_box.disable_item_expand (grid_control_holder)
--			if grid_visible_control = Void then
--				create grid_visible_control.make_with_text ("Visible")
--				grid_visible_control.enable_select
--				grid_visible_control.select_actions.force_extend (agent draw_widgets)
--			else
--				grid_visible_control.parent.prune_all (grid_visible_control)
--			end
--			vb1.extend (grid_visible_control)
--				-- We do not build a new control if it already exists.
--				-- This allows us to keep the previous value.
--			if (grid_size_control = Void) then
--				create grid_size_control.make_with_value_range (create {INTEGER_INTERVAL}.make (5, 500))
--				grid_size_control.change_actions.force_extend (agent draw_widgets)
--				grid_size_control.set_value (20)
--			else
--				grid_size_control.parent.prune_all (grid_size_control)
--			end
--			vb1.extend (grid_size_control)
--			from
--				first.start
--			until
--				first.off
--			loop
--				create list_item.make_with_text (class_name (first.item))
--				list_item.select_actions.extend (agent draw_widgets)
--				list_item.set_data (first.item)
--				list.extend (list_item)
--				first.forth
--			end
--			set_initial_area_size
		end
		
	set_initial_area_size is
			-- Set initial size of `drawing_area' relative to `scrollable_area'
		local
			biggest_x, biggest_y: INTEGER
			widget: EV_WIDGET
		do
--			from
--				first.start
--			until
--				first.off
--			loop
--				widget := first.item
--				if widget.x_position + widget.width > biggest_x then
--					biggest_x := widget.x_position + widget.width
--				end
--				if widget.y_position + widget.height > biggest_y then
--					biggest_y := widget.y_position + widget.height
--				end
--				first.forth
--			end
--			if biggest_x > scrollable_area.width then
--				drawing_area.set_minimum_width (biggest_x)
--			else
				drawing_area.set_minimum_width (scrollable_area.width)
--			end
--			if biggest_y > scrollable_area.height then
--				drawing_area.set_minimum_height (biggest_y)
--			else
				drawing_area.set_minimum_height (scrollable_area.height)
--			end
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
			listi: EV_LIST_ITEM
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
					create relative_pointa.make_with_position ((first.item_column_position (widget) - 1) * grid_size, (first.item_row_position (widget) - 1) * grid_size)
					create relative_pointb.make_with_position ((first.item_column_position (widget) - 1) * grid_size + (first.item_column_span (widget)) * grid_size, (first.item_row_position (widget) - 1) * grid_size + (first.item_row_span (widget)) * grid_size)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.set_foreground_color (black)
					figure_rectangle.remove_background_color
					world.extend (figure_rectangle)
				end
				widgets.forth
			end
			if selected_item /= Void then
					create relative_pointa.make_with_position ((first.item_column_position (selected_item) - 1) * grid_size, (first.item_row_position (selected_item) - 1) * grid_size)
					create relative_pointb.make_with_position ((first.item_column_position (selected_item) - 1) * grid_size + (first.item_column_span (selected_item)) * grid_size, (first.item_row_position (selected_item) - 1) * grid_size + (first.item_row_span (selected_item)) * grid_size)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.remove_background_color
					figure_rectangle.set_foreground_color (selected_item_color)
					world.extend (figure_rectangle)
			end
--				listi := list.selected_item
--				if list.selected_item /= Void and then first.item = list.selected_item.data then
--					selected_item_index := first.index
--				else
--					create relative_pointa.make_with_position (first.item.x_position, first.item.y_position)
--					create relative_pointb.make_with_position (first.item.x_position + first.item.width, first.item.y_position + first.item.height)
--					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
--					figure_rectangle.set_foreground_color (black)
--					figure_rectangle.remove_background_color
--					world.extend (figure_rectangle)
--				end
--				first.forth
--			end
--			
--			if selected_item_index > 0 then
--						first.go_i_th (selected_item_index)
--						create relative_pointa.make_with_position (first.item.x_position, first.item.y_position)
--						create relative_pointb.make_with_position (first.item.x_position + first.item.width, first.item.y_position + first.item.height)
--						create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
--						figure_rectangle.remove_background_color
--						figure_rectangle.set_foreground_color (red)
--						world.extend (figure_rectangle)
--					end
--					
			projector.project
		end
		
	draw_grid is
			-- Draw snap to grid in `world'.
		local
			counter, counter2: INTEGER
			figure_line: EV_FIGURE_LINE
			figure_dot: EV_FIGURE_DOT
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
				create figure_line.make_with_positions (counter, 0, counter, rows_size)
				figure_line.set_foreground_color (color)
				create relative_point.make_with_position (drawing_area.width, counter)
				world.extend (figure_line)
				counter := counter + grid_size	
			end
			from
				counter := 0
			until
				counter > rows_size
			loop
				create figure_line.make_with_positions (0, counter, columns_size, counter)
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
			first.set_item_span (v, columns, rows)
				-- Now we need to get the widget represented in objects at the
				-- second place.
			second_widget := (objects @ 2).item (first.item_column_position (v), first.item_row_position (v))
			(objects @ 2).set_item_span (second_widget, columns, rows)
		end
		
	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, columns, rows: INTEGER) is
			-- Move `v' to `a_column', `a_row' and resize to `columns', `rows'.
		local
			second_widget: EV_WIDGET
		do
				-- Now we need to get the widget represented in objects at the
				-- second place. We must do this before we move the first widget.
			if a_column = 3 and a_row = 1 and columns = 1 and rows = 1 then
				do_nothing
			end
			second_widget := (objects @ 2).item (first.item_column_position (v), first.item_row_position (v))

			first.set_item_position_and_span (v, a_column, a_row, columns, rows)
			(objects @ 2).set_item_position_and_span (second_widget, a_column, a_row, columns, rows)
		end
		

	track_movement (x, y: INTEGER) is
			-- Track `x', `y' position of cursor, and 
		local
			widget: EV_WIDGET
			old_width: INTEGER
			temp: INTEGER
			temp_x, temp_y: INTEGER
			new_x, new_y: INTEGER
			column_position, row_position, end_row_position, end_column_position: INTEGER
			new_column, new_row: INTEGER
			end_position, current_x_position, current_y_position: INTEGER
		do
			if selected_item /= Void then
				column_position := (first.item_column_position (selected_item) - 1) * grid_size
				row_position := (first.item_row_position (selected_item) - 1) * grid_size
				end_column_position := column_position + first.item_column_span (selected_item) * grid_size
				end_row_position := row_position + first.item_row_span (selected_item) * grid_size				

--				-- Store `x' and `y' for use elsewhere.
--			last_x := x
--			last_y := y

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
--				elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) or
--					close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
--					if not resizing_widget then
--						set_all_pointer_styles (sizens_cursor)	
--					end
--				elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) or
--					close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
--					if not resizing_widget then
--						set_all_pointer_styles (sizewe_cursor)	
--					end
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
					-- Update scrolling status.
	--			update_scrolling (x, y)
				temp_x := x - column_position
				temp_y := y - row_position
				new_x := temp_x + half_grid_size - ((temp_x + half_grid_size) \\ grid_size)
				new_y := temp_y + half_grid_size - ((temp_y + half_grid_size) \\ grid_size)	
				
				if x_scale /= 0 then
					if x_offset = 0 then
						end_position := (original_column + original_column_span)
						current_x_position := (((x + half_grid_size) // grid_size + 1).max (1)).min (end_position - 1)
						if first.area_clear_excluding_widget (selected_item, current_x_position, first.item_row_position (selected_item), end_position - current_x_position, first.item_row_span (selected_item)) then
							--move_and_resize (selected_item, current_x_position, first.item_row_position (selected_item), end_position - current_x_position, first.item_row_span (selected_item))
							set_item_position_and_span (selected_item, current_x_position, first.item_row_position (selected_item), end_position - current_x_position, first.item_row_span (selected_item))
						else
							current_x_position := first_filled_horizontal_space (selected_item, end_position - 1, first.item_row_position (selected_item), first.item_row_span (selected_item))-- + 1
								-- We need to change the order depending on the movement that we are performing. This
								-- ensures that we stay within valid bounds.
						 	--move_and_resize (selected_item, current_x_position, first.item_row_position (selected_item) , end_position - current_x_position, first.item_row_position (selected_item))
						 	set_item_position_and_span (selected_item, current_x_position, first.item_row_position (selected_item) , end_position - current_x_position, first.item_row_position (selected_item))
						end
					else
						new_column := (new_x // grid_size).min (first.columns - first.item_column_position (selected_item) + 1).max (1)
						if first.item_column_span (selected_item)/= new_column and first.area_clear_excluding_widget (selected_item, first.item_column_position (selected_item), first.item_row_position (selected_item), new_column, first.item_row_span (selected_item)) then --new_column.max (1).min (first.columns - first.item_column_position (selected_item) + 1), first.item_row_span (selected_item)) then
							set_item_span (selected_item, new_column, first.item_row_span (selected_item))
						end
					end
				end
				
				if y_scale /= 0 then
					if y_offset = 0 then
						end_position := (original_row + original_row_span)
						current_y_position := ((y + half_grid_size) // grid_size + 1).max (1).min (end_position - 1)
						if first.area_clear_excluding_widget (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_span (selected_item), end_position - current_y_position) then
							--move_and_resize (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_span (selected_item), end_position - current_y_position)
							set_item_position_and_span (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_span (selected_item), end_position - current_y_position)
						else
							current_y_position := first_filled_vertical_space (selected_item, end_position - 1, first.item_column_position (selected_item), first.item_column_span (selected_item))-- + 1
							--move_and_resize (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_position (selected_item), end_position - current_x_position)
							set_item_position_and_span (selected_item, first.item_column_position (selected_item), current_y_position, first.item_column_position (selected_item), end_position - current_x_position)
						end
					else
						new_row := (new_y // grid_size).min (first.rows - first.item_row_position (selected_item) + 1).max (1)
						if first.item_row_span (selected_item) /= new_row and first.area_clear_excluding_widget (selected_item, first.item_column_position (selected_item), first.item_row_position (selected_item), first.item_column_span (selected_item), new_row) then --.max (1).min (first.rows - first.item_row_position (selected_item) + 1)) then
							set_item_span (selected_item, first.item_column_span (selected_item), new_row)	
						end
					end
				end				
									
				draw_widgets
			end
			if moving_widget then
					-- Update scrolling status.
	--			update_scrolling (x, y)
	
				new_x := x - ((x - x_offset) \\ grid_size)
				new_y := y - ((y - y_offset) \\ grid_size)	
				temp_x := ((new_x - x_offset) // grid_size + 1).min (first.columns - first.item_column_span (selected_item) + 1).max (1)
				temp_y := ((new_y - y_offset) // grid_size + 1).min (first.rows - first.item_row_span (selected_item) + 1).max (1)
				if (first.item_column_position (selected_item) /= temp_x or first.item_row_position (selected_item) /= temp_y) and
					first.area_clear_excluding_widget (selected_item, temp_x, temp_y, first.item_column_span (selected_item), first.item_row_span (selected_item)) then
					set_item_position_and_span (selected_item, temp_x, temp_y, first.item_column_span (selected_item), first.item_row_span (selected_item))
				end
				draw_widgets
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
--		
--	grid_size: INTEGER is
--			-- Size of current grid from
--			-- `grid_size_control'
--		do
--			Result := grid_size_control.value
--		end
--		
	half_grid_size: INTEGER is
			-- Half size of current grid.
		do
			Result := grid_size // 2
		end

original_column, original_row: INTEGER
original_column_span, original_row_span: INTEGER

	button_pressed (x, y, a_button: INTEGER) is
			-- A button has been pressed. If `a_button' = 1 then
			-- check for movement/resizing.
		local
			widget: EV_WIDGET
			widget_list: ARRAYED_LIST [EV_WIDGET]
			temp_x, temp_y: INTEGER
			column_position, row_position, column_span, row_span, end_column_position, end_row_position: INTEGER
		do
			--if selected_item = Void then
				
			--end
			if selected_item /= Void then
					-- We must store the original size and position of `selected_item'.
					-- This is necessary, as in `track_movement', we may move and re-size
					-- `selected_item', although still need to perform the calculations on
					-- the current cursor position against the position of `selected_item'
					-- when the resizing began.
				original_column := first.item_column_position (selected_item)
				original_row := first.item_column_position (selected_item)	
				original_column_span := first.item_column_span (selected_item)
				original_row_span := first.item_row_span (selected_item)
				column_position := (first.item_column_position (selected_item) - 1) * grid_size
				row_position := (first.item_row_position (selected_item) - 1) * grid_size
				end_column_position := column_position + first.item_column_span (selected_item) * grid_size
				end_row_position := row_position + first.item_row_span (selected_item) * grid_size
				row_span := first.item_row_span (selected_item) * grid_size
				column_span := first.item_column_span (selected_item) * grid_size
				--column_span := (first.item_row_span (selected_item) - 1) * grid_size
				
				
--				widget := first.i_th (selected_item_index)
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
--					elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
--						x_offset := x - widget.x_position
--						y_offset := widget.height
--						x_scale := 0; y_scale := 1
--					elseif close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
--						x_offset := x
--						y_offset := 0
--						x_scale := 0; y_scale := 1
--					elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
--						x_offset := 0
--						y_offset := y
--						x_scale := 1; y_scale := 0
--					elseif close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
--						x_offset := widget.width
--						y_offset := y
--						x_scale := 1; y_scale := 0
--					--elseif
					elseif x > column_position and x < end_column_position and y > row_position and y < end_row_position then
						moving_widget := True
						resizing_widget := False
						x_offset := x - column_position
						y_offset := y - row_position
					else
						resizing_widget := False
					end
					if resizing_widget or moving_widget then
	--					drawing_area.enable_capture	
					end
				end
			
			end
				-- We need to highlight a widget if the action is
				-- to select a widget.
			if a_button = 1 and not resizing_widget and not moving_widget then
				temp_x := x // grid_size + 1
				temp_y := y // grid_size + 1
					-- Only perform the query if valid coordinates.
				if temp_x <= first.columns and temp_y <= first.rows then
					selected_item := first.item (temp_x, temp_y)	
				end
				draw_widgets
			end
		end
--		
	button_released (x, y, a_button: INTEGER) is
			-- A button has been released on `drawing_area'
			-- If `a_button' = 1, check for end of resize/movement.
		do
--			scrolled_x_once := False
			if a_button = 1 then
--				if scrolling_x then
--					end_x_scrolling
--				end
				if resizing_widget then
					resizing_widget := False
					set_all_pointer_styles (standard_cursor)
--					drawing_area.disable_capture
				elseif moving_widget then
					moving_widget := False
					set_all_pointer_styles (standard_cursor)
--					drawing_area.disable_capture
				end
--			set_initial_area_size
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

	rows_entry, columns_entry, row_spacing_entry, column_spacing_entry, border_width_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets used.
		
	homogeneous_button: EV_BUTTON
		-- Toggles `is_homogeneous' for table.
		
	layout_button: EV_BUTTON
		-- Provides access to the layout window.

--	last_x, last_y: INTEGER
--		-- Last known cooridnates of mouse pointer.
--		
--	x_right, x_center: INTEGER is unique
--		-- Constants used with `scrolling_x_start'.
--		
--	y_bottom, y_center: INTEGER is unique
--		-- Constants used with `scrolling_y_start'.
--		
--	scrolling_x_start: INTEGER
--		-- Where did the scrolling operation start?
--			-- `x_right' if started when reached edge of `drawing_area'.
--			-- `x_center' if started when reached visible edge of `drawing_area'.
--			
--	scrolling_y_start: INTEGER
--		-- Where did the scrolling operation start?
--			-- `y_bottom' if started when reached the bottom of `drawing_area'.
--			-- `y_center' if started when reached visible edge of `drawing_area'.
--		
--	timeout: EV_TIMEOUT
--		-- Used to execute the timing of scrolling.
--		
--	scrolling_x: BOOLEAN
--		-- Are we currently scrolling onx axis??
--		
--	scrolling_y: BOOLEAN
--			-- Are we currently scrolling on y axis?
--		
--
--	scrolled_x_once: BOOLEAN
--		-- Have we scrolled in the x direction since the last
--		-- button 1 release?
--		
--	scrolled_y_once:BOOLEAN 
--		-- Have we scrolled in the y direction since the last
--		-- button 1 release?
--
--feature {NONE} -- Attributes
--
--	snap_button: EV_CHECK_BUTTON
--		-- Snap to grid enabled?
--	
--	grid_size_control: EV_SPIN_BUTTON
--		-- `value' is grid spacing.
--	
--	grid_visible_control: EV_CHECK_BUTTON
--		-- Is grid visible?
--	
--	grid_spacing: INTEGER
--		-- Spacing used for grid.
--	
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
		
--	selected_item_index: INTEGER
--		-- Index of item currently selected in 
--		
	drawing_area: EV_DRAWING_AREA
		-- Drawing area used to represent `world'
	
	scrollable_area: EV_SCROLLABLE_AREA
		-- A scrollable area which contains `drawing_area'.
	
--	grid_color: EV_COLOR is
--			-- Color used for grid.
--		do
--			create Result.make_with_8_bit_rgb (196, 244, 204)
--		end
--	
	accuracy_value: INTEGER is 3
			-- Value which determines how close pointer must be
			-- to lines/points for resizing.

--	list: EV_LIST
--		-- Contains all children of represented EV_FIXED.
--	
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
	
		
--	x_position_string: STRING is "Children_x_position"
--	
--	y_position_string: STRING is "Children_y_position"
--	
--	height_string: STRING is "Children_height"
--	
--	width_string: STRING is "Children_width"
			
end -- class GB_EV_TABLE
