indexing
	description: "Objects that manipulate objects of type EV_COLORIZABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_COLORIZABLE
	
	-- The following properties from EV_COLORIZABLE are manipulated by `Current'.
	-- foreground_color - Performed on the real object and the display_object.
	-- background_color - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	EV_DIALOG_CONSTANTS
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end
		
	INTERNAL
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_COLORIZABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_COLORIZABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			first_object: EV_COLORIZABLE
			label: EV_LABEL
			bounding_frame: EV_FRAME
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_box: EV_VERTICAL_BOX
			button, button1: EV_BUTTON
			frame: EV_FRAME
			cell: EV_CELL
		do
			Result := Precursor {GB_EV_ANY}
			create color_dialog
			first_object := objects.first
			create bounding_frame.make_with_text (gb_ev_colorizable_background_color)
			Result.extend (bounding_frame)
			
			create horizontal_box
			create vertical_box
			bounding_frame.extend (vertical_box)
			vertical_box.extend (horizontal_box)
			create frame
			create b_area
			frame.set_minimum_width (40)
			b_area.set_tooltip (gb_ev_colorizable_background_color_tooltip)
			create button.make_with_text (Select_button_text)
			button.set_tooltip ("Select background color")
			background_color := first_object.background_color	
			frame.extend (b_area)
			horizontal_box.set_padding (2)
			create cell
			horizontal_box.extend (cell)
			horizontal_box.disable_item_expand (cell)
			horizontal_box.extend (frame)
			horizontal_box.extend (button)
			horizontal_box.disable_item_expand (button)
			horizontal_box.disable_item_expand (frame)
			b_area.expose_actions.force_extend (agent b_area.clear)
			button.select_actions.extend (agent update_background_color)
			create horizontal_box
			horizontal_box.set_border_width (2)
			create button1.make_with_text (gb_ev_colorizable_restore_color)
			button1.select_actions.extend (agent restore_background_color)
			horizontal_box.extend (button1)
			vertical_box.extend (horizontal_box)
			horizontal_box.disable_item_expand (button1)
				-- Add two for the padding of the box
			button1.set_minimum_width (button.minimum_width + frame.minimum_width + 2)
			
			

			create bounding_frame.make_with_text (gb_ev_colorizable_foreground_color)
			Result.extend (bounding_frame)

			create horizontal_box
			create vertical_box
			bounding_frame.extend (vertical_box)
			vertical_box.extend (horizontal_box)
			create frame
			create f_area
			frame.set_minimum_width (40)
			f_area.set_tooltip (gb_ev_colorizable_foreground_color_tooltip)
			create button.make_with_text (Select_button_text)
			button.set_tooltip ("Select foreground color")
			foreground_color := first_object.foreground_color	
			frame.extend (f_area)
			horizontal_box.set_padding (2)
			create cell
			horizontal_box.extend (cell)
			horizontal_box.disable_item_expand (cell)
			horizontal_box.extend (frame)
			horizontal_box.extend (button)
			horizontal_box.disable_item_expand (button)
			horizontal_box.disable_item_expand (frame)
			f_area.expose_actions.force_extend (agent f_area.clear)
			button.select_actions.extend (agent update_foreground_color)
			create horizontal_box
			horizontal_box.set_border_width (2)
			create button1.make_with_text (gb_ev_colorizable_restore_color)
			button1.select_actions.extend (agent restore_foreground_color)
			horizontal_box.extend (button1)
			vertical_box.extend (horizontal_box)
			horizontal_box.disable_item_expand (button1)
			button1.set_minimum_width (button.minimum_width + frame.minimum_width + 2)
			
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
		update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			update_background_display
			update_foreground_display
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			colorizable: EV_COLORIZABLE
			default_background, default_foreground: EV_COLOR
		do
			colorizable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			colorizable.default_create
			default_background := colorizable.background_color
			default_foreground := colorizable.foreground_color
			
			if not default_background.is_equal (objects.first.background_color) then
				add_element_containing_string (element, background_color_string, build_string_from_color (objects.first.background_color))
			end
			if not default_foreground.is_equal (objects.first.foreground_color) then
				add_element_containing_string (element, foreground_color_string, build_string_from_color (objects.first.foreground_color))
			end
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (background_color_string)
			if element_info /= Void then
				for_all_objects (agent {EV_COLORIZABLE}.set_background_color (build_color_from_string (element_info.data)))
			end
			element_info := full_information @ (foreground_color_string)
			if element_info /= Void then
				for_all_objects (agent {EV_COLORIZABLE}.set_foreground_color (build_color_from_string (element_info.data)))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			temp_color: EV_COLOR
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (background_color_string)
			if element_info /= Void then
				temp_color := build_color_from_string (element_info.data)
				Result := info.name + ".set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (" + temp_color.red_8_bit.out + ", " + temp_color.green_8_bit.out + ", " + temp_color.blue_8_bit.out + "))"
			end
			element_info := full_information @ (foreground_color_string)
			if element_info /= Void then
				temp_color := build_color_from_string (element_info.data)
				Result := Result + indent + info.name + ".set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (" + temp_color.red_8_bit.out + ", " + temp_color.green_8_bit.out + ", " + temp_color.blue_8_bit.out + "))"
			end
			Result := strip_leading_indent (Result)
		end


feature {NONE} -- Implementation

	restore_background_color is
			-- Restore `background_color' of objects to originals.
		local
			colorizable: EV_COLORIZABLE
		do
			colorizable ?= new_instance_of (dynamic_type (first))
			check
				correct_type: colorizable /= Void
			end
			colorizable.default_create
			for_all_objects (agent {EV_COLORIZABLE}.set_background_color (colorizable.background_color))
			update_editors
			update_background_display
		end
		
	restore_foreground_color is
			-- Restore `foreground_color' of objects to originals.
		local
			colorizable: EV_COLORIZABLE
		do
			colorizable ?= new_instance_of (dynamic_type (first))
			check
				correct_type: colorizable /= Void
			end
			colorizable.default_create
			for_all_objects (agent {EV_COLORIZABLE}.set_foreground_color (colorizable.foreground_color))
			update_editors
			update_foreground_display
		end
		

	update_background_color is
			-- Update `background_color' of objects through an EV_COLOR_DIALOG.
		local
			new_color: EV_COLOR
		do
			color_dialog.set_color (background_color)
			color_dialog.show_modal_to_window (parent_window (parent_editor))
			if color_dialog.selected_button.is_equal (ev_ok) then
				new_color := color_dialog.color
				for_all_objects (agent {EV_COLORIZABLE}.set_background_color (new_color))
				background_color := new_color
				update_editors
				update_background_display
			end
		end
		
	update_background_display is
			-- Update area displaying the background color of the EV_COLORIZABLE.
		do
			b_area.set_background_color (first.background_color)
			b_area.clear
		end
		
	update_foreground_display is
			-- Update area displaying the background color of the EV_COLORIZABLE.
		do
			f_area.set_background_color (first.foreground_color)
			f_area.clear
		end

	update_foreground_color is
			-- Update `foreground_color' of objects through an EV_COLOR_DIALOG.
		local
			new_color: EV_COLOR
		do
			color_dialog.set_color (foreground_color)
			color_dialog.show_modal_to_window (parent_window (parent_editor))
			if color_dialog.selected_button.is_equal (ev_ok) then
				new_color := color_dialog.color
				for_all_objects (agent {EV_COLORIZABLE}.set_foreground_color (new_color))
				foreground_color := new_color
				update_editors
				update_foreground_display	
			end
		end
		
	build_string_from_color (color: EV_COLOR): STRING is
			-- `Result' is string representation of `color'.
		require
			color_not_void: color /= Void
		do
			create Result.make (0)
			if color.red_8_bit.out.count < 3 then
				Result := Result + add_leading_zeros (3 - color.red_8_bit.out.count)
			end
			Result.append_string (color.red_8_bit.out)
			if color.green_8_bit.out.count < 3 then
				Result := Result + add_leading_zeros (3 - color.green_8_bit.out.count)
			end
			Result.append_string (color.green_8_bit.out)
			if color.blue_8_bit.out.count < 3 then
				Result := Result + add_leading_zeros (3 - color.blue_8_bit.out.count)
			end
			Result.append_string (color.blue_8_bit.out)
		end
		
	build_color_from_string (a_string: STRING): EV_COLOR is
			-- `Result' is an EV_COLOR built from contents of `a_string'.
		require
			string_correct_length: a_string.count = 9
			a_string_is_integer: a_string.is_integer
		do
			create Result
			Result.set_rgb_with_8_bit (a_string.substring (1, 3).to_integer,
				a_string.substring (4, 6).to_integer,
				a_string.substring (7, 9).to_integer)
		ensure
			Result_not_void: Result /= Void
		end
		
		
	add_leading_zeros (count: INTEGER): STRING is
			-- `Result' is `a_string' with `count' '0's added.
		require
			count_ok: count > 0 and count <= 2
		local
			counter: INTEGER
		do
			create Result.make (0)
			from
				counter := 0
			until
				counter = count
			loop
				Result.append_string ("0")
				counter := counter + 1
			end
		ensure
			Result_not_void: Result /= Void
			Result_correct_length: Result.count = count
		end
		

	foreground_color: EV_COLOR
	background_color: EV_COLOR
	
	b_area, f_area: EV_DRAWING_AREA
	
	color_dialog: EV_COLOR_DIALOG

	-- Constants for XML
	
	background_color_string: STRING is "Background_color"
	foreground_color_string: STRING is "Foreground_color"


end -- class GB_EV_SENSITIVE