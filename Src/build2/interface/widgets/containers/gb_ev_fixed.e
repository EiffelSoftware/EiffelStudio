indexing
	description: "Objects that manipulate objects of type EV_FIXED"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FIXED

	-- The following properties from EV_FIXED are manipulated by `Current'.
	-- item_x_position - Performed on the real object and the display_object child.
	-- item_y_position - Performed on the real object and the display_object child
	-- item_width - Performed on the real object and the display_object child
	-- item_height - Performed on the real object and the display_object child

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


	ev_type: EV_FIXED
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_FIXED"
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
			create button.make_with_text ("Position items")
			Result := Precursor {GB_EV_ANY}
			Result.extend (button)
			button.select_actions.extend (agent show_layout_window)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_x_position_string, temp_y_position_string,
			temp_width_string, temp_height_string: STRING
			temp: STRING
		do
			temp_x_position_string := ""
			temp_y_position_string := ""
			temp_width_string := ""
			temp_height_string := ""
			from
				first.start
			until
				first.off
			loop
				temp_x_position_string := temp_x_position_string + add_leading_zeros (first.item.x_position.out)
				temp_y_position_string := temp_y_position_string + add_leading_zeros (first.item.y_position.out)
				temp_width_string := temp_width_string + add_leading_zeros (first.item.width.out)
				temp_height_string := temp_height_string + add_leading_zeros (first.item.height.out)
				first.forth
			end
			if not temp_x_position_string.is_empty then
				add_element_containing_string (element, x_position_string, temp_x_position_string)
			end
			if not temp_y_position_string.is_empty then
				add_element_containing_string (element, y_position_string, temp_y_position_string)
			end
			if not temp_width_string.is_empty then
				add_element_containing_string (element, width_string, temp_width_string)
			end
			if not temp_height_string.is_empty then
				add_element_containing_string (element, height_string, temp_height_string)
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
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (x_position_string)
			if element_info /= Void then
				temp_x_position_string := element_info.data
			end
			element_info := full_information @ (y_position_string)
			if element_info /= Void then
				temp_y_position_string := element_info.data
			end
			element_info := full_information @ (width_string)
			if element_info /= Void then
				temp_width_string := element_info.data
			end
			element_info := full_information @ (height_string)
			if element_info /= Void then
				temp_height_string := element_info.data
			end
			check
				strings_equal_in_length: temp_x_position_string.count = temp_y_position_string.count and
					temp_x_position_string.count = temp_width_string.count and
					temp_x_position_string.count = temp_height_string.count
				strings_divisible_by_4: temp_x_position_string.count \\ 4 = 0
				strings_correct_length: temp_x_position_string.count // 4 = first.count			
			end
			from
				counter := 1
			until
				counter = temp_x_position_string.count // 4 + 1
			loop
				lower := (counter - 1) * 4 + 1
				upper := (counter - 1) * 4 + 4
				current_child_name := children_names @ counter
				Result := Result + indent + a_name + ".set_item_x_position (" + current_child_name + ", " + temp_x_position_string.substring (lower, upper) + ")"
				Result := Result + indent + a_name + ".set_item_y_position (" + current_child_name + ", " + temp_y_position_string.substring (lower, upper) + ")"
				Result := Result + indent + a_name + ".set_item_width (" + current_child_name + ", " + temp_width_string.substring (lower, upper) + ")"
				Result := Result + indent + a_name + ".set_item_height (" + current_child_name + ", " + temp_height_string.substring (lower, upper) + ")"
				counter := counter + 1
			end			
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
			full_information := get_unique_full_info (element)
			element_info := full_information @ (x_position_string)
			if element_info /= Void then
				temp_x_position_string := element_info.data				
			end
			
			element_info := full_information @ (y_position_string)
			if element_info /= Void then
				temp_y_position_string := element_info.data				
			end
			
			element_info := full_information @ (width_string)
			if element_info /= Void then
				temp_width_string := element_info.data				
			end
			
			element_info := full_information @ (height_string)
			if element_info /= Void then
				temp_height_string := element_info.data				
			end
			
			check
				strings_equal_in_length: temp_x_position_string.count = temp_y_position_string.count and
					temp_x_position_string.count = temp_width_string.count and
					temp_x_position_string.count = temp_height_string.count
				strings_divisible_by_4: temp_x_position_string.count \\ 4 = 0
				strings_correct_length: temp_x_position_string.count // 4 = first.count
			end
			
			from
				first.start
			until
				first.off
			loop
					-- Read current x position data from `temp_x_position_string'.
				extracted_string := temp_x_position_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
				check
					value_is_integer: extracted_string.is_integer
				end
				set_x_position (first.item, extracted_string.to_integer)
					
					-- Read current y position data from `temp_y_position_string'.
				extracted_string := temp_y_position_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
				check
					value_is_integer: extracted_string.is_integer
				end
				set_y_position (first.item, extracted_string.to_integer)
				
					-- Read current width data from `temp_width_string'.
				extracted_string := temp_width_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
				check
					value_is_integer: extracted_string.is_integer
				end
				set_item_width (first.item, extracted_string.to_integer)
				
					-- Read current height data from `temp_height_string'.
				extracted_string := temp_height_string.substring ((first.index - 1) * 4 + 1, (first.index - 1) * 4 + 4)
				check
					value_is_integer: extracted_string.is_integer
				end
				set_item_height (first.item, extracted_string.to_integer)
				
				first.forth
			end	
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
			
			drawing_area.pointer_motion_actions.force_extend (agent track_movement (?, ?))
			drawing_area.pointer_button_press_actions.force_extend (agent button_pressed (?, ?, ?))
			drawing_area.pointer_button_release_actions.force_extend (agent button_released (?, ?, ?))
			create list
			
			create world
			create pixmap
			drawing_area.resize_actions.force_extend (agent update_pixmap_size)
			drawing_area.resize_actions.force_extend (agent draw_widgets)
			create projector.make_with_buffer (world, pixmap, drawing_area)
			
			create scrollable_area
			scrollable_area.set_minimum_size (200, 200)
			create ok_button.make_with_text ("OK")
			ok_button.select_actions.extend (agent Result.destroy)
			vertical_box.extend (ok_button)
			vertical_box.disable_item_expand (ok_button)
			horizontal_box.extend (scrollable_area)
			scrollable_area.extend (drawing_area)
			scrollable_area.resize_actions.force_extend (agent set_initial_area_size)
			
			create vertical_box
			horizontal_box.extend (vertical_box)
			horizontal_box.disable_item_expand (vertical_box)
				-- We do not build a new control if it already exists.
			if snap_button = Void then
				create snap_button.make_with_text ("Snap to grid")
			else
				snap_button.parent.prune_all (snap_button)
			end
			create grid_control_holder.make_with_text ("Grid properties")
			create vb1
			grid_control_holder.extend (vb1)
			vertical_box.extend (list)
			vertical_box.extend (grid_control_holder)
			vb1.extend (snap_button)
			vertical_box.disable_item_expand (grid_control_holder)
			if grid_visible_control = Void then
				create grid_visible_control.make_with_text ("Visible")
				grid_visible_control.enable_select
				grid_visible_control.select_actions.force_extend (agent draw_widgets)
			else
				grid_visible_control.parent.prune_all (grid_visible_control)
			end
			vb1.extend (grid_visible_control)
				-- We do not build a new control if it already exists.
				-- This allows us to keep the previous value.
			if (grid_size_control = Void) then
				create grid_size_control.make_with_value_range (create {INTEGER_INTERVAL}.make (5, 500))
				grid_size_control.change_actions.force_extend (agent draw_widgets)
				grid_size_control.set_value (20)
			else
				grid_size_control.parent.prune_all (grid_size_control)
			end
			vb1.extend (grid_size_control)
			from
				first.start
			until
				first.off
			loop
				create list_item.make_with_text (class_name (first.item))
				list_item.select_actions.extend (agent draw_widgets)
				list_item.set_data (first.item)
				list.extend (list_item)
				first.forth
			end
			set_initial_area_size
		end
		
	set_initial_area_size is
			-- Set initial size of `drawing_area' relative to `scrollable_area'
		local
			biggest_x, biggest_y: INTEGER
			widget: EV_WIDGET
		do
			from
				first.start
			until
				first.off
			loop
				widget := first.item
				if widget.x_position + widget.width > biggest_x then
					biggest_x := widget.x_position + widget.width
				end
				if widget.y_position + widget.height > biggest_y then
					biggest_y := widget.y_position + widget.height
				end
				first.forth
			end
			if biggest_x > scrollable_area.width then
				drawing_area.set_minimum_width (biggest_x)
			else
				drawing_area.set_minimum_width (scrollable_area.width)
			end
			if biggest_y > scrollable_area.height then
				drawing_area.set_minimum_height (biggest_y)
			else
				drawing_area.set_minimum_height (scrollable_area.height)
			end
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
		do
				-- Remove all previous figures from `world'.
			world.wipe_out
				-- We must  draw the grid if necessary.
			if grid_visible_control.is_selected then
				draw_grid	
			end	
			from
				first.start
			until
				first.off
			loop
				listi := list.selected_item
				if list.selected_item /= Void and then first.item = list.selected_item.data then
					selected_item_index := first.index
				else
					create relative_pointa.make_with_position (first.item.x_position, first.item.y_position)
					create relative_pointb.make_with_position (first.item.x_position + first.item.width, first.item.y_position + first.item.height)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.set_foreground_color (black)
					figure_rectangle.remove_background_color
					world.extend (figure_rectangle)
				end
				first.forth
			end
			
			if selected_item_index > 0 then
						first.go_i_th (selected_item_index)
						create relative_pointa.make_with_position (first.item.x_position, first.item.y_position)
						create relative_pointb.make_with_position (first.item.x_position + first.item.width, first.item.y_position + first.item.height)
						create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
						figure_rectangle.remove_background_color
						figure_rectangle.set_foreground_color (red)
						world.extend (figure_rectangle)
					end
					
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
		do
			-- Create a light green for the grid color.
			create color.make_with_8_bit_rgb (196, 244, 204)
		from
			counter := 0
		until
			counter > drawing_area.width
		loop
			create figure_line.make_with_positions (counter, 0, counter, drawing_area.height)
			figure_line.set_foreground_color (color)
			create relative_point.make_with_position (drawing_area.width, counter)
			world.extend (figure_line)
			counter := counter + grid_size	
		end
		from
			counter := 0
		until
			counter > drawing_area.height
		loop
			create figure_line.make_with_positions (0, counter, drawing_area.width, counter)
			figure_line.set_foreground_color (color)
			figure_line.set_foreground_color (color)
			world.extend (figure_line)
			counter := counter + grid_size
		end
		end
		
	set_x_position (widget: EV_WIDGET; x_pos: INTEGER) is
			-- Set x_position of `widget' in `first' to `x_pos'.
		do
			--| FIXME
			first.set_item_x_position (widget, x_pos)
			--second.set_item_x_position (widget, x_pos)
		end
		
	set_y_position (widget: EV_WIDGET; y_pos: INTEGER) is
			-- Set y_position of `widget' in `first' to `y_pos'.
		do
			--| FIXME
			first.set_item_y_position (widget, y_pos)										
			--second.set_item_y_position (widget, y_pos)
		end
		
	set_item_width (widget: EV_WIDGET; new_width: INTEGER) is
			-- Set width of `widget' in `first' to `new_width'.
		do
			--| FIXME
			first.set_item_width (widget, new_width)
			--second.set_item_width (widget, new_width)
		end
		
	set_item_height (widget: EV_WIDGET; new_height: INTEGER) is
			-- Set height of `widget' in `first' to `new_height'.
		do
			--| FIXME
			first.set_item_height (widget, new_height)
			--second.set_item_height (widget, new_height)
		end	
		

	track_movement (x, y: INTEGER) is
			-- Track `x', `y' position of cursor, and 
		local
			widget: EV_WIDGET
			old_width: INTEGER
			temp: INTEGER
			temp_x, temp_y: INTEGER
			new_x, new_y: INTEGER
		do
				-- Store `x' and `y' for use elsewhere.
			last_x := x
			last_y := y
				-- We only need to perform this operation if a widget representation
				-- is selected for manipulation.
			if selected_item_index > 0  then
				widget := first.i_th (selected_item_index)
				if close_to (x, y, widget.x_position + widget.width, widget.y_position + widget.height) or
					close_to (x, y, widget.x_position, widget.y_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenwse_cursor)	
					end
				elseif close_to (x, y, widget.x_position, widget.y_position + widget.height) or
					close_to (x, y, widget.x_position + widget.width, widget.y_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenesw_cursor)	
					end
				elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) or
					close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizens_cursor)	
					end
				elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) or
					close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizewe_cursor)	
					end
				elseif x > widget.x_position and x < widget.x_position + widget.width and y > widget.y_position and y < widget.y_position + widget.height then
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
				update_scrolling (x, y)
				temp_x := x				
				if snap_button.is_selected then
					new_x := temp_x + half_grid_size - ((temp_x + half_grid_size) \\ grid_size)
					new_y := y + half_grid_size - ((y + half_grid_size) \\ grid_size)	
				else
					new_x := temp_x
					new_y := y
				end
				widget := first.i_th (selected_item_index)

				if x_scale /= 0 then
				if x_offset = 0 then
					if new_x < widget.x_position + widget.width - widget.minimum_width then
						if widget.x_position + (new_x - widget.x_position) > 0 then
							set_item_width (widget, (widget.width - (new_x - widget.x_position)).max (widget.minimum_width))
							set_x_position (widget, (widget.x_position + (new_x - widget.x_position)))							
						else
							temp := widget.x_position
							set_item_width (widget, widget.width + temp)
							set_x_position (widget, (0))							
						end
					else
						temp := widget.width - widget.minimum_width
						set_item_width (widget, widget.width - temp)
						set_x_position (widget, widget.x_position + temp)
						end
				else
					set_item_width (widget, (new_x - widget.x_position).max (widget.minimum_width))
				end
				end
				
				if y_scale /= 0 then
				if y_offset = 0 then
					if new_y < widget.y_position + widget.height - widget.minimum_height then
						if widget.y_position + (new_y - widget.y_position) > 0 then
							set_item_height (widget, (widget.height - (new_y - widget.y_position)).max (widget.minimum_height))
							set_y_position (widget, (widget.y_position + (new_y - widget.y_position)))
						else
							temp := widget.y_position
							set_item_height (widget, widget.height + temp)
							set_y_position (widget, (0))
						end
					else
						temp := widget.height - widget.minimum_height
						set_item_height (widget, widget.height - temp)
						set_y_position (widget, widget.y_position + temp)
					end
				else
					set_item_height (widget, (new_y - widget.y_position).max (widget.minimum_height))
				end
				end								
				draw_widgets
			end
			if moving_widget then
					-- Update scrolling status.
				update_scrolling (x, y)
				if snap_button.is_selected then
					new_x := x - ((x - x_offset) \\ grid_size)
					new_y := y - ((y - y_offset) \\ grid_size)	
				else
					new_x := x
					new_y := y
				end
				if new_x - x_offset > 0 then	
					set_x_position (widget, new_x - x_offset)
				else
					set_x_position (widget, 0)
				end
				if new_y - y_offset > 0 then
					set_y_position (widget,  new_y - y_offset)	
				else
					set_y_position (widget, 0)
				end
				draw_widgets
			end
		end
		
	x_scrolling_velocity: INTEGER is
			-- `Result' is desired x scrolling velocity based on the last known position
			-- of the mouse pointer.
		do
			if last_x > drawing_area.width and scrolled_x_once and scrolling_x_start = x_right then
				Result := (last_x - drawing_area.width) // 20 + 1
			elseif last_x > scrollable_area.width + scrollable_area.x_offset and scrolling_x_start = x_center then
				Result := (last_x - scrollable_area.width - scrollable_area.x_offset) // 20 + 1		
			elseif last_x < scrollable_area.x_offset then
				Result := - ((scrollable_area.x_offset - last_x) //20 + 1)
			end
		end
		
	y_scrolling_velocity: INTEGER is
			-- `Result' is desired y scrolling velocity based on the last known position
			-- of the mouse pointer.
		do
			if last_y > drawing_area.height and scrolled_y_once and scrolling_y_start = y_bottom then
				Result := (last_y - drawing_area.height) // 20 + 1
			elseif last_y > scrollable_area.height + scrollable_area.y_offset and scrolling_y_start = y_center then
				Result := (last_y - scrollable_area.height - scrollable_area.y_offset) // 20 + 1		
			elseif last_y < scrollable_area.y_offset then
				Result := - ((scrollable_area.y_offset - last_y) //20 + 1)
			end
		end
		
		
	update_scrolling (x, y: INTEGER) is
			-- Update current scrolling to reflect mouse coordinates `x', `y'.
		do
				-- First deal with the x axis
			if (x > drawing_area.width) and not scrolled_x_once then
				scrolled_x_once := True
				scrolling_x_start := x_right
				start_x_scrolling
			elseif (x > drawing_area.width) and scrolled_x_once and scrolling_x_start = x_right then
				if not scrolling_x then
					start_x_scrolling
				end
			elseif scrolling_x_start = x_right then
				if scrolling_x then
					end_x_scrolling
				end
			end
			if (x > scrollable_area.width + scrollable_area.x_offset) and not scrolled_x_once then
				scrolled_x_once := True
				scrolling_x_start := x_center
				start_x_scrolling
			elseif (x > scrollable_area.width + scrollable_area.x_offset) and scrolled_x_once and scrolling_x_start = x_center then
				if not scrolling_x then
					start_x_scrolling
				end
			elseif scrolling_x_start = x_center then
				if scrolling_x then
					end_x_scrolling
				end
			end	
			if x < scrollable_area.x_offset then
				if not scrolling_x then
					start_x_scrolling
				end
			end
			
				-- Then Y axis.
			if (y > drawing_area.height) and not scrolled_y_once then
				scrolled_y_once := True
				scrolling_y_start := y_bottom
				start_y_scrolling
			elseif (y > drawing_area.height) and scrolled_y_once and scrolling_y_start = y_bottom then
				if not scrolling_y then
					start_y_scrolling
				end
			elseif scrolling_y_start = y_bottom then
				if scrolling_y then
					end_y_scrolling
				end
			end
			if (y > scrollable_area.height + scrollable_area.y_offset) and not scrolled_y_once then
				scrolled_y_once := True
				scrolling_y_start := y_center
				start_y_scrolling
			elseif (y > scrollable_area.height + scrollable_area.y_offset) and scrolled_y_once and scrolling_y_start = y_center then
				if not scrolling_y then
					start_y_scrolling
				end
			elseif scrolling_y_start = y_center then
				if scrolling_y then
					end_y_scrolling
				end
			end	
			if y < scrollable_area.y_offset then
				if not scrolling_y then
					start_y_scrolling
				end
			end
		end
		
	start_x_scrolling is
			-- Begin automatic scrolling on x axis.
		do
			if not scrolling_x then
				if not scrolling_y then
						-- Create a timeout which will repeatedly cause the scrolling to
						-- take place.
					create timeout.make_with_interval (25)
					timeout.actions.extend (agent scroll)	
				end
				scrolling_x := True
			end
		end
		
	start_y_scrolling is
			-- Begin automatic scrolling on y axis.
		do
			if not scrolling_y then
				if not scrolling_x then
						-- Create a timeout which will repeatedly cause the scrolling to
						-- take place.
					create timeout.make_with_interval (25)
					timeout.actions.extend (agent scroll)	
				end			
				scrolling_y := True
			end
		end
		
	end_x_scrolling is
			-- End scrolling on x axis.
		do
				-- Only destroy if not scrolling in either
				-- direction. `timeout' controls scrolling in
				-- both directions.
			if not scrolling_y then
				timeout.destroy
			end
			scrolling_x := False
		end
		
	end_y_scrolling is
			-- End scrolling on y axis.
		do
				-- Only destroy if not scrolling in either
				-- direction. `timeout' controls scrolling in
				-- both directions.
			if not scrolling_x then
				timeout.destroy
			end
			scrolling_y := False
		end
		
		
		
	scroll is
			--
		local
			current_velocity: INTEGER
		do
			current_velocity := x_scrolling_velocity
			if current_velocity > 0 then
				drawing_area.set_minimum_width (drawing_area.width + current_velocity)	
			end
				-- Max 0 ensures that if we are scrolling to the left, we do not
				-- move to less than position 0.
			scrollable_area.set_x_offset ((scrollable_area.x_offset + current_velocity).max (0))
			
			
			current_velocity := y_scrolling_velocity
			if current_velocity > 0 then
				drawing_area.set_minimum_height (drawing_area.height + current_velocity)
				
			end
				-- Max 0 ensures that if we are scrolling to the top, we do not
				-- move to less than position 0.
			scrollable_area.set_y_offset ((scrollable_area.y_offset + current_velocity).max (0))
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
		
	grid_size: INTEGER is
			-- Size of current grid from
			-- `grid_size_control'
		do
			Result := grid_size_control.value
		end
		
	half_grid_size: INTEGER is
			-- Half size of current grid.
		do
			Result := grid_size // 2
		end
	
	button_pressed (x, y, a_button: INTEGER) is
			-- A button has been pressed. If `a_button' = 1 then
			-- check for movement/resizing.
		local
			widget: EV_WIDGET
		do
			if selected_item_index > 0 then
				widget := first.i_th (selected_item_index)
				if a_button = 1 and not resizing_widget and not moving_widget then
						-- Unset this, if this is not the case, as we have 8 checks which would need it
						-- assigning otherwise
					resizing_widget := True
					if close_to (x, y, widget.x_position + widget.width, widget.y_position + widget.height) then
						x_offset := widget.width
						y_offset := widget.height
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, widget.x_position, widget.y_position) then
						x_offset := 0
						y_offset := 0
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, widget.x_position, widget.y_position + widget.height) then
						x_offset := 0
						y_offset := widget.height
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, widget.x_position + widget.width, widget.y_position) then
						x_offset := widget.width
						y_offset := 0
						x_scale := 1; y_scale := 1
					elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
						x_offset := x - widget.x_position
						y_offset := widget.height
						x_scale := 0; y_scale := 1
					elseif close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
						x_offset := x
						y_offset := 0
						x_scale := 0; y_scale := 1
					elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
						x_offset := 0
						y_offset := y
						x_scale := 1; y_scale := 0
					elseif close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
						x_offset := widget.width
						y_offset := y
						x_scale := 1; y_scale := 0
					elseif x > widget.x_position and x < widget.x_position + widget.width and y > widget.y_position and y < widget.y_position + widget.height then
						moving_widget := True
						resizing_widget := False
						x_offset := x - widget.x_position
						y_offset := y - widget.y_position
					else
						resizing_widget := False
					end
					if resizing_widget or moving_widget then
						drawing_area.enable_capture	
					end
				end
			end
		end
		
	button_released (x, y, a_button: INTEGER) is
			-- A button has been released on `drawing_area'
			-- If `a_button' = 1, check for end of resize/movement.
		do
			scrolled_x_once := False
			if a_button = 1 then
				if scrolling_x then
					end_x_scrolling
				end
				if resizing_widget then
					resizing_widget := False
					set_all_pointer_styles (standard_cursor)
					drawing_area.disable_capture
				elseif moving_widget then
					moving_widget := False
					set_all_pointer_styles (standard_cursor)
					drawing_area.disable_capture
				end
			set_initial_area_size
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

feature {NONE} -- Scrolling attributes.

	last_x, last_y: INTEGER
		-- Last known cooridnates of mouse pointer.
		
	x_right, x_center: INTEGER is unique
		-- Constants used with `scrolling_x_start'.
		
	y_bottom, y_center: INTEGER is unique
		-- Constants used with `scrolling_y_start'.
		
	scrolling_x_start: INTEGER
		-- Where did the scrolling operation start?
			-- `x_right' if started when reached edge of `drawing_area'.
			-- `x_center' if started when reached visible edge of `drawing_area'.
			
	scrolling_y_start: INTEGER
		-- Where did the scrolling operation start?
			-- `y_bottom' if started when reached the bottom of `drawing_area'.
			-- `y_center' if started when reached visible edge of `drawing_area'.
		
	timeout: EV_TIMEOUT
		-- Used to execute the timing of scrolling.
		
	scrolling_x: BOOLEAN
		-- Are we currently scrolling onx axis??
		
	scrolling_y: BOOLEAN
			-- Are we currently scrolling on y axis?
		

	scrolled_x_once: BOOLEAN
		-- Have we scrolled in the x direction since the last
		-- button 1 release?
		
	scrolled_y_once:BOOLEAN 
		-- Have we scrolled in the y direction since the last
		-- button 1 release?

feature {NONE} -- Attributes

	snap_button: EV_CHECK_BUTTON
		-- Snap to grid enabled?
	
	grid_size_control: EV_SPIN_BUTTON
		-- `value' is grid spacing.
	
	grid_visible_control: EV_CHECK_BUTTON
		-- Is grid visible?
	
	grid_spacing: INTEGER
		-- Spacing used for grid.
	
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
		
	selected_item_index: INTEGER
		-- Index of item currently selected in 
		
	drawing_area: EV_DRAWING_AREA
		-- Drawing area used to represent `world'
	
	scrollable_area: EV_SCROLLABLE_AREA
		-- A scrollable area which contains `drawing_area'.
	
	grid_color: EV_COLOR is
			-- Color used for grid.
		do
			create Result.make_with_8_bit_rgb (196, 244, 204)
		end
	
	accuracy_value: INTEGER is 3
			-- Value which determines how close pointer must be
			-- to lines/points for resizing.

	list: EV_LIST
		-- Contains all children of represented EV_FIXED.
	
	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector used for `world'
	
	pixmap: EV_PIXMAP
		-- Pixmap for double buffering `world'.
			
	world: EV_FIGURE_WORLD
		-- Figure world containg all widget representations.
		
	x_position_string: STRING is "Children_x_position"
	
	y_position_string: STRING is "Children_y_position"
	
	height_string: STRING is "Children_height"
	
	width_string: STRING is "Children_width"
			
end -- class GB_EV_BOX
