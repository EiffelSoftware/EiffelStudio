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
		undefine
			attribute_editor
		end

	GB_EV_COLORIZABLE_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end
		
	DEFAULT_OBJECT_STATE_CHECKER
		undefine
			default_create
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			colorizable: EV_COLORIZABLE
			default_background, default_foreground: EV_COLOR
		do
			colorizable ?= default_object_by_type (class_name (first))
			default_background := colorizable.background_color
			default_foreground := colorizable.foreground_color
			
			if not default_background.is_equal (objects.first.background_color) then
				add_element_containing_string (element, background_color_string, build_string_from_color (objects.first.background_color))
			end
			if not default_foreground.is_equal (objects.first.foreground_color) then
				add_element_containing_string (element, foreground_color_string, build_string_from_color (objects.first.foreground_color))
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
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

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			temp_color: EV_COLOR
		do
			create Result.make (2)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (background_color_string)
			if element_info /= Void then
				temp_color := build_color_from_string (element_info.data)
				Result.extend (info.name + ".set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (" + temp_color.red_8_bit.out + ", " + temp_color.green_8_bit.out + ", " + temp_color.blue_8_bit.out + "))")
			end
			element_info := full_information @ (foreground_color_string)
			if element_info /= Void then
				temp_color := build_color_from_string (element_info.data)
				Result.extend (info.name + "set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (" + temp_color.red_8_bit.out + ", " + temp_color.green_8_bit.out + ", " + temp_color.blue_8_bit.out + "))")
			end
		end

end -- class GB_EV_SENSITIVE