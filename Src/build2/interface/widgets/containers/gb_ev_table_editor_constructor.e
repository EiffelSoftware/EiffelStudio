indexing
	description: "Builds an attribute editor for modification of objects of type EV_TABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
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
			create Result
			initialize_attribute_editor (Result)
			create rows_entry.make (Current, Result, gb_ev_table_rows, gb_ev_table_rows_tooltip,
				agent set_rows (?), agent valid_row_value (?))
			create columns_entry.make (Current, Result, gb_ev_table_columns, gb_ev_table_columns_tooltip,
				agent set_columns (?), agent valid_column_value (?))
			create row_spacing_entry.make (Current, Result, gb_ev_table_row_spacing, gb_ev_table_row_spacing_tooltip,
				agent set_row_spacing (?), agent valid_spacing (?))
			create column_spacing_entry.make (Current, Result, gb_ev_table_column_spacing, gb_ev_table_column_spacing_tooltip,
				agent set_column_spacing (?), agent valid_spacing (?))
			create border_width_entry.make (Current, Result, gb_ev_table_border_width, gb_ev_table_border_width_tooltip, agent set_border_width (?), agent valid_spacing (?))
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
				update_prompt
				draw_widgets
			end
			homogeneous_button.select_actions.resume
		end
		
	table_items (table: EV_TABLE): ARRAYED_LIST [EV_WIDGET] is
			-- `Result' is all items in `table'. Ordered from
			-- top left, going down, before moving right to the
			-- next column.
		local
			counter: INTEGER
			item: EV_WIDGET
		do
			create Result.make (table.widget_count)
			from
				counter := 0
			until
				Result.count = table.widget_count
			loop
				item := table.item ((counter // table.columns) + 1, (counter \\ table.rows) + 1)
				if item /= Void then
					Result.extend (item)	
				end
				counter := counter + 1	
			end
		ensure
			count_correct: Result.count = table.widget_count
		end

feature {NONE} -- Implementation

	layout_window: EV_DIALOG is
			-- Window for laying out children of fixed.
		local
			horizontal_box, h1: EV_HORIZONTAL_BOX
			vertical_box: EV_VERTICAL_BOX
			ok_button: EV_BUTTON
			status_bar: EV_FRAME
			split_area: EV_HORIZONTAL_SPLIT_AREA
			table_content: ARRAYED_LIST [EV_WIDGET]
			list_item: EV_LIST_ITEM
			layout_rows_entry, layout_columns_entry: GB_INTEGER_INPUT_FIELD
			object: GB_OBJECT
		do
				-- Reset the selected item.
			selected_item := Void
			create Result
			set_default_icon_pixmap (Result)
			Result.set_minimum_size (300, 250)
			Result.show_actions.extend (agent initialize_sizing)
			Result.set_title ("EV_TABLE child positioner")
			create vertical_box
			Result.extend (vertical_box)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create drawing_area
			drawing_area.set_minimum_size (100, 100)
			
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
			create h1
			create status_bar
			status_bar.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_lowered)
			h1.extend (status_bar)
			
			create prompt_label
			update_prompt
			status_bar.extend (prompt_label)
			h1.extend (ok_button)
			h1.disable_item_expand (ok_button)
			vertical_box.extend (h1)
			vertical_box.disable_item_expand (h1)
			create split_area
			horizontal_box.extend (split_area)
			create vertical_box
			scrollable_area.set_minimum_width (100)
			split_area.extend (scrollable_area)
			split_area.enable_item_expand (scrollable_area)
			split_area.extend (vertical_box)
			create list
			list.set_minimum_width (100)
			vertical_box.extend (list)
			split_area.disable_item_expand (vertical_box)
			create layout_rows_entry.make (Current, vertical_box, gb_ev_table_rows, gb_ev_table_rows_tooltip,
				agent set_rows_and_draw (?), agent valid_row_value (?))
			create layout_columns_entry.make (Current, vertical_box, gb_ev_table_columns, gb_ev_table_columns_tooltip,
				agent set_columns_and_draw (?), agent valid_column_value (?))
			layout_rows_entry.set_text (first.rows.out)
			layout_columns_entry.set_text (first.columns.out)
			vertical_box.disable_item_expand (layout_rows_entry)
			vertical_box.disable_item_expand (layout_columns_entry)
			
			scrollable_area.extend (drawing_area)
				-- Now create a list item for all children.
			table_content ?= first.linear_representation
			from
				table_content.start
			until
				table_content.off
			loop
				-- Note that this is slow, as we have to loop through objects
					-- to get a match, while inside this loop.
				list_item := named_list_item_from_widget (table_content.item)
				list_item.set_data (table_content.item)
				list_item.select_actions.extend (agent item_selected (table_content.item))
				list_item.deselect_actions.extend (agent check_unselect)
				list.extend (list_item)
				table_content.forth
			end
		end
		
	initialize_sizing is
			-- Set up automatic re-sizing when window is re-sized.
			-- Also initialize size of scrollable area for the first time.
		do
			adjust_scrollable_area
			scrollable_area.resize_actions.force_extend (agent adjust_scrollable_area)
		end
		
		
	adjust_scrollable_area is
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
			if selected_item /= Void and not resizing_widget and not moving_widget then
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
					if selected_item /= Void then
						list.retrieve_item_by_data (selected_item, True).enable_select
					end
					update_prompt
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
		
	set_rows_and_draw (row_value: INTEGER) is
			-- Resize table to accomodate `row_value' rows.
		do
			for_all_objects (agent {EV_TABLE}.resize (first.columns, row_value))
			drawing_area.set_minimum_height (grid_size * row_value + diagram_border * 2)
			rows_entry.set_text (row_value.out)
			update_editors
			draw_widgets
			update_prompt
		end
		
	set_columns_and_draw (column_value: INTEGER) is
			-- Resize table to accomodate `column_value' columns.
		do
			for_all_objects (agent {EV_TABLE}.resize (column_value, first.rows))
			drawing_area.set_minimum_width (grid_size * column_value +  diagram_border * 2)
			columns_entry.set_text (column_value.out)
			update_editors
			draw_widgets
			update_prompt
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


	item_selected (widget: EV_WIDGET) is
			-- Item representing `widget' in `list' has
			-- become selected, so update_display to
			-- reflect this.
		do
			selected_item := widget
			draw_widgets
		end
		
	check_unselect is
			-- If no item is selected in `list' any more,
			-- then we must remove the highlighting from
			-- the display.
		do
			if list.selected_items.count = 0 then
				selected_item := Void
				draw_widgets
			end
		end
	
	table_minimal_full: BOOLEAN is
			-- Is table represented by `Current', 
			-- 1x1 and full?
		do
			Result := first.widget_count = 1 and first.rows = 1 and first.columns = 1			
		end
	
	update_prompt is
			-- Update `prompt_label'.
		do
			if table_minimal_full then
				prompt_label.set_text (full_prompt)
			elseif selected_item /= Void then
				prompt_label.set_text (position_prompt)
			else
				prompt_label.set_text (select_prompt)
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
		
	select_prompt: STRING is "Please select desired widget."
		-- Prompt to help user.
		
	full_prompt: STRING is "Child fills table. Resize table to manipulate."
		-- Prompt when table is full.
		
	position_prompt: STRING is "Position highlighted widget."
		-- Prompt when widget is selected.
		
	list: EV_LIST
		-- All children are contained in here.

end -- class GB_EV_TABLE_EDITOR_CONSTRUCTOR
