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
--			create check_buttons.make (0)
--			Result := Precursor {GB_EV_ANY}
--				-- We need the child of the display objects here,
--				-- not the actual object itself.
--			second := objects @ (2).item
--			
--			create is_homogeneous_check.make_with_text ("Is_homogeneous?")
--			Result.extend (is_homogeneous_check)
--			is_homogeneous_check.select_actions.extend (agent update_homogeneous)
--			is_homogeneous_check.select_actions.extend (agent update_editors)
--			
--			create padding_entry.make (Current, Result, "Padding", agent set_padding (?), agent valid_input (?))
--			create border_entry.make (Current, Result, "Border", agent set_border (?), agent valid_input (?))
--
--				-- We only add the is_expandable label if there are children
--			if not first.is_empty then
--				create label.make_with_text ("Is_item_expanded?")
--				Result.extend (label)			
--			end		
--			from
--				first.start
--				second.start
--			until
--				first.off or second.off
--			loop
--				create check_button.make_with_text (class_name (first.item))
--				check_button.set_pebble_function (agent retrieve_pebble (parent_editor.object.layout_item, first.index))
--				check_buttons.force (check_button)
--				check_button.select_actions.extend (agent update_widget_expanded (check_button, first.item))
--				check_button.select_actions.extend (agent update_widget_expanded (check_button, second.item))
--				check_button.select_actions.extend (agent update_editors)
--				Result.extend (check_button)
--				first.forth
--				second.forth
--			end
--			
--			update_attribute_editor
--
--			disable_all_items (Result)
--			align_labels_left (Result)
		end
		
--	retrieve_pebble (a_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM; child_index: INTEGER): ANY is
--			-- Retrieve pebble for transport.
--			-- A convenient was of setting up the drop
--			-- actions for GB_OBJECT.
--		local
--			environment: EV_ENVIRONMENT
--			object: GB_OBJECT
--			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
--			shared_tools: GB_SHARED_TOOLS
--		do
--			layout_item ?= a_layout_item.i_th (child_index)
--			check
--				layout_item_not_void: layout_item /= Void
--			end
--			object := layout_item.object
--			
--			--| FIXME This is currently identical to version in 
--			--| GB_OBJECT
--			create environment
--				-- If the ctrl key is pressed, then we must
--				-- start a new object editor for `Current', instead
--				-- of beginning the pick and drop.
--			if environment.application.ctrl_pressed then
--				new_object_editor (object)
--			else
--				create shared_tools
--				shared_tools.type_selector.update_drop_actions_for_all_children (object)
--				Result := object
--			end
--		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
--			check
--				counts_match: first.count = check_buttons.count
--			end
--			is_homogeneous_check.select_actions.block
--
--			if first.is_homogeneous then
--				is_homogeneous_check.enable_select
--			else
--				is_homogeneous_check.disable_select
--			end
--			border_entry.set_text (first.border_width.out)
--			padding_entry.set_text (first.padding_width.out)
--			
--			from
--				check_buttons.start
--			until
--				check_buttons.off
--			loop
--				check_buttons.item.select_actions.block
--				if first.is_item_expanded (first @ check_buttons.index) then
--					check_buttons.item.enable_select
--				else
--					check_buttons.item.disable_select
--				end
--				check_buttons.item.select_actions.resume
--				check_buttons.forth
--			end			
--			is_homogeneous_check.select_actions.resume
		end
		
		
	update_widget_expanded (check_button: EV_CHECK_BUTTON; w: EV_WIDGET) is
			-- Change the expanded status of `w'.
		local
			box_parent: EV_BOX
		do
--			box_parent ?= w.parent
--			check
--				parent_is_box: box_parent /= Void
--			end
--			if check_button.is_selected then
--				box_parent.enable_item_expand (w)
--			else
--				box_parent.disable_item_expand (w)
--			end
--			system_status.enable_project_modified
--			command_handler.update
		end
		
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			temp_string: STRING
		do
--				-- Boxes are not homogeneous by default.
--			if objects.first.is_homogeneous = True then
--				add_element_containing_boolean (element, Is_homogeneous_string, objects.first.is_homogeneous)
--			end
--				-- Padding is 0 by default.
--			if objects.first.padding_width > 0 then
--				add_element_containing_integer (element, Padding_string, objects.first.padding_width)	
--			end
--				-- Border is 0 by default.
--			if objects.first.border_width > 0 then
--				add_element_containing_integer (element, Border_string, objects.first.border_width)
--			end
--			
--				-- If there are one or more children in the box, then we always
--				-- store the string of details. This could be changed to be made smarter
--				-- at some point, so we only store if one ore more are not expanded.
--				-- Initialize `temp_string' as empty.
--			temp_string := ""
--			from
--				first.start
--			until
--				first.off
--			loop
--						-- For each child that is expandable add "1" else add "0".
--					if first.is_item_expanded (first.item) then
--						temp_string := temp_string + "1"
--					else
--						temp_string := temp_string + "0"
--					end
--				first.forth
--			end
--			if not temp_string.is_empty then
--				add_element_containing_string (element, Is_item_expanded_string, temp_string)
--			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
--			full_information := get_unique_full_info (element)
--			
--			element_info := full_information @ (Is_homogeneous_string)
--			if element_info /= Void then
--				if element_info.data.is_equal (True_string) then
--					for_all_objects (agent {EV_BOX}.enable_homogeneous)
--				else
--					for_all_objects (agent {EV_BOX}.disable_homogeneous)
--				end
--			end
--
--			element_info := full_information @ (Padding_string)
--			if element_info /= Void then
--				for_all_objects (agent {EV_BOX}.set_padding_width (element_info.data.to_integer))
--			end
--			
--			element_info := full_information @ (Border_string)
--			if element_info /= Void then
--				for_all_objects (agent {EV_BOX}.set_border_width (element_info.data.to_integer))
--			end
--		
--		
--				-- We set up some deferred building now.
--			deferred_builder.defer_building (Current, element)
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
--			Result := ""
--			full_information := get_unique_full_info (element)
--			element_info := full_information @ (Is_homogeneous_string)
--			if element_info /= Void then
--				if element_info.data.is_equal (True_string) then
--					Result := a_name + ".enable_homgeneous"
--				else
--					Result := a_name + ".disable_homogeneous"
--				end
--			end
--			
--			
--			element_info := full_information @ (Padding_string)
--			if element_info /= Void then
--				Result := Result + indent + a_name + ".set_padding_width (" + element_info.data + ")"
--			end
--			
--			element_info := full_information @ (Border_string)
--			if element_info /= Void then
--				Result := Result + indent + a_name + ".set_border_width (" + element_info.data + ")"
--			end
--			
--				-- This is always saved, so there is no check.
--			element_info := full_information @ (Is_item_expanded_string)
--			check
--				consistent: children_names.count = element_info.data.count
--			end
--			from
--				children_names.start
--			until
--				children_names.off
--			loop
--					-- We only generate code for all the children that are disabled as they
--					-- are expanded by default.
--				if element_info.data @ children_names.index /= '1' then
--					Result := Result + indent + a_name + ".disable_item_expand (" + children_names.item + ")"
--				end
--				children_names.forth
--			end
--	
--			Result := strip_leading_indent (Result)
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			second: like ev_type
			temp_string: STRING
			box_parent1, box_parent2: EV_BOX
		do
--			full_information := get_unique_full_info (element)
--			element_info := full_information @ (Is_item_expanded_string)
--				-- We only stored the expanded information if there were
--				-- children.
--			if element_info /= Void then			
--				temp_string := element_info.data
--				second ?= (objects @ 2)
--				box_parent1 ?= first
--				box_parent2 ?= second
--				check
--					string_matches: temp_string.count = first.count
--				end
--				from
--					first.start
--					second.start
--				until
--					first.off
--				loop
--					if temp_string @ first.index = '1' then
--						box_parent1.enable_item_expand (first.item)
--						box_parent2.enable_item_expand (second.item)
--					else
--						box_parent1.disable_item_expand (first.item)
--						box_parent2.disable_item_expand (second.item)
--					end
--					first.forth
--					second.forth
--				end
--			end
		end
		

feature {NONE} -- Implementation

	layout_window: EV_DIALOG is
			-- Window for laying out children of fixed.
		local
			horizontal_box, hb: EV_HORIZONTAL_BOX
			vertical_box, vb: EV_VERTICAL_BOX
			scrollable_area: EV_SCROLLABLE_AREA
			ok_button: EV_BUTTON
			list_item: EV_LIST_ITEM
			frame: EV_FRAME
		do
			create Result
			Result.set_minimum_size (400, 300)
			create vertical_box
			Result.extend (vertical_box)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create drawing_area
			drawing_area.set_minimum_size (1000, 1000)
			drawing_area.pointer_motion_actions.force_extend (agent track_movement (?, ?))
			drawing_area.pointer_button_press_actions.force_extend (agent button_pressed (?, ?, ?))
			drawing_area.pointer_button_release_actions.force_extend (agent button_released (?, ?, ?))
			
			create list
			
			create world
			create pixmap
			drawing_area.resize_actions.force_extend (agent update_pixmap_size)
			pixmap.set_size (250, 250)
			create projector.make_with_buffer (world, pixmap, drawing_area)--make (world, drawing_area)--_with_buffer (world, pixmap, drawing_area)
			draw_widgets
			
			create scrollable_area
			create ok_button.make_with_text ("OK")
			ok_button.select_actions.extend (agent Result.destroy)
			vertical_box.extend (ok_button)
			vertical_box.disable_item_expand (ok_button)
			horizontal_box.extend (scrollable_area)
			scrollable_area.extend (drawing_area)
			create vertical_box
			horizontal_box.extend (vertical_box)
			horizontal_box.disable_item_expand (vertical_box)
			create snap_button.make_with_text ("Snap to grid")
			create hb
			vertical_box.extend (list)
			vertical_box.extend (snap_button)
			vertical_box.extend (hb)
			vertical_box.disable_item_expand (hb)
			vertical_box.disable_item_expand (snap_button)
			create grid_visible_control.make_with_text ("Visible")
			grid_visible_control.enable_select
			hb.extend (grid_visible_control)
			create grid_size_control
			hb.extend (grid_size_control)
			from
				first.start
			until
				first.off
			loop
				create list_item.make_with_text (class_name (first.item))
				list_item.select_actions.extend (agent draw_widgets)--draw_items)
				list_item.set_data (first.item)
				list.extend (list_item)
				first.forth
			end
		end
		
	update_pixmap_size (x, y, width, height: INTEGER) is
			--
		do
			pixmap.set_size (width, height)
		end
		
		
	draw_widgets is
			--
		local
			listi: EV_LIST_ITEM
		do
			world.wipe_out
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
						--drawing_area.set_foreground_color (red)
						--drawing_area.draw_rectangle (first.item.x_position, first.item.y_position,
						--first.item.width, first.item.height)				
					end

			projector.project
		end

	track_movement (x, y: INTEGER) is
			--
		local
			widget: EV_WIDGET
			old_width: INTEGER
			temp: INTEGER
		do
			io.putstring ("Resizing widget in `track_movement': " + resizing_widget.out + "%N")
			if selected_item_index > 0  then
				widget := first.i_th (selected_item_index)
				io.putstring ("Width : " + widget.width.out + "%N")
				io.putstring ("Height : " + widget.height.out + "%N")
				io.putstring ("X position : " + widget.x_position.out + "%N")
				io.putstring ("Y position : " + widget.y_position.out + "%N")
				io.putstring ("X : " + x.out + "%N")
				io.putstring ("Y : " + y.out + "%N")
				if close_to (x, y, widget.x_position + widget.width, widget.y_position + widget.height) or
					close_to (x, y, widget.x_position, widget.y_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenwse_cursor)	
					end
					io.putstring ("One%N")
				elseif close_to (x, y, widget.x_position, widget.y_position + widget.height) or
					close_to (x, y, widget.x_position + widget.width, widget.y_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenesw_cursor)	
					end
					io.putstring ("Two%N")
				elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) or
					close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizens_cursor)	
					end
					io.putstring ("Three%N")
				elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) or
					close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizewe_cursor)	
					end
					io.putstring ("Four%N")
				elseif x > widget.x_position and x < widget.x_position + widget.width and y > widget.y_position and y < widget.y_position + widget.height then
					if not resizing_widget then
						set_all_pointer_styles (sizeall_cursor)	
					end
					io.putstring ("Five%N")
				else
					if not resizing_widget or not moving_widget then
						set_all_pointer_styles (standard_cursor)
					end
				end
			end
			if resizing_widget then
				io.putstring ("Resizing widget")
				widget := first.i_th (selected_item_index)
				io.putstring ((x - widget.x_position + widget.width).out)

				if x_scale /= 0 then
				if x_offset = 0 then
					if x < widget.x_position + widget.width - widget.minimum_width then
						if widget.x_position + (x - widget.x_position) > 0 then
							first.set_item_width (widget, (widget.width - (x - widget.x_position)).max (widget.minimum_width))
							first.set_item_x_position (widget, (widget.x_position + (x - widget.x_position)))							
						else
							temp := widget.x_position
							first.set_item_width (widget, widget.width + temp)
							first.set_item_x_position (widget, (0))							
						end
					else
						temp := widget.width - widget.minimum_width
						first.set_item_width (widget, widget.width - temp)
						first.set_item_x_position (widget, widget.x_position + temp)
						end
				else
					first.set_item_width (widget, (x - widget.x_position).max (widget.minimum_width))
				end
				end
				
				if y_scale /= 0 then
				if y_offset = 0 then
					if y < widget.y_position + widget.height - widget.minimum_height then
						if widget.y_position + (y - widget.y_position) > 0 then
							first.set_item_height (widget, (widget.height - (y - widget.y_position)).max (widget.minimum_height))
							first.set_item_y_position (widget, (widget.y_position + (y - widget.y_position)))
						else
							temp := widget.y_position
							first.set_item_height (widget, widget.height + temp)
							first.set_item_y_position (widget, (0))
						end
					else
						temp := widget.height - widget.minimum_height
						first.set_item_height (widget, widget.height - temp)
						first.set_item_y_position (widget, widget.y_position + temp)
					end
				else
					first.set_item_height (widget, (y - widget.y_position).max (widget.minimum_height))
				end
				end								
				draw_widgets
			end
			if moving_widget then
				if x - x_offset > 0 then	
					first.set_item_x_position (widget, x - x_offset)
				else
					first.set_item_x_position (widget, 0)
				end
				if y - y_offset > 0 then
					first.set_item_y_position (widget,  y - y_offset)	
				else
					first.set_item_y_position (widget, 0)
				end
				draw_widgets
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
				io.putstring ("Close to line%N")
				Result := True
			end
		end
		
		
		
	button_pressed (x, y, a_button: INTEGER) is
			--
		local
			widget: EV_WIDGET
		do
			io.putstring ("Button pressed%N")
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
			--
		do
			io.putstring ("Button released%N")
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
			end
		end
		
	sizing_cursor: EV_CURSOR
		
	resizing_widget: BOOLEAN
		-- Is a widget currently being resized?
		
	moving_widget: BOOLEAN
		-- Is a widget currently being moved?
	
	x_offset, y_offset: INTEGER
	
	x_scale, y_scale: INTEGER
		
	show_layout_window is
			--
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


	snap_button: EV_CHECK_BUTTON
	
	grid_size_control: EV_SPIN_BUTTON
	
	grid_visible_control: EV_CHECK_BUTTON
		
		
	selected_item_index: INTEGER	
		
	drawing_area: EV_DRAWING_AREA
	
	accuracy_value: INTEGER is 3
			-- Value which determines how close pointer must be
			-- to lines for resizing.
		
	
	list: EV_LIST
	
			projector: EV_DRAWING_AREA_PROJECTOR
			pixmap: EV_PIXMAP
			world: EV_FIGURE_WORLD
			relative_pointa, relative_pointb: EV_RELATIVE_POINT
			figure_rectangle: EV_FIGURE_RECTANGLE


--	update_homogeneous is
--			-- Update homogeneous state of items in `objects' depending on
--			-- state of `is_homogeneous_check'.
--		do
--			if is_homogeneous_check.is_selected then
--				for_all_objects (agent {EV_BOX}.enable_homogeneous)
--			else
--				for_all_objects (agent {EV_BOX}.disable_homogeneous)
--			end
--		end
--
--	set_padding (value: INTEGER) is
--			-- Update property `padding' on all items in `objects'.
--		require
--			first_not_void: first /= Void
--		do
--			for_all_objects (agent {EV_BOX}.set_padding_width (value))
--		end
--		
--	valid_input (value: INTEGER): BOOLEAN is
--			-- Is `value' a valid padding?
--		do
--			Result := value >= 0
--		end
--		
--	set_border (value: INTEGER) is
--			-- Update property `border' on all items in `objects'.
--		require
--			first_not_void: first /= Void
--		do
--			for_all_objects (agent {EV_BOX}.set_border_width (value))
--		end
--		
--	is_homogeneous_check: EV_CHECK_BUTTON
--
--	border_entry, padding_entry: GB_INTEGER_INPUT_FIELD
--	
--	Is_homogeneous_string: STRING is "Is_homogeneous"
--	Padding_string: STRING is "Padding"
--	Border_string: STRING is "Border"
--	Is_item_expanded_string: STRING is "Is_item_expanded"
--	
--	check_buttons: ARRAYED_LIST [EV_CHECK_BUTTON]
--		-- All check buttons created to handle `disable_item_expand'.
	

end -- class GB_EV_BOX
