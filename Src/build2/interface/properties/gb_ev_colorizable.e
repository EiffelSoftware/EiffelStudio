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

	EV_DIALOG_CONSTANTS
		undefine
			default_create
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

end -- class GB_EV_SENSITIVE