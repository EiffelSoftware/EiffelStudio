indexing
	description: "Objects that manipulate objects of type EV_FRAME"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FRAME

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type
		end
		
	GB_EV_FRAME_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			frame: EV_FRAME
		do
			frame ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			frame.default_create
			if frame.style /= objects.first.style then
				add_element_containing_integer (element, Style_string, objects.first.style)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Style_string)
			if element_info /= Void then
				check
					data_is_an_integer: element_info.data.is_integer
				end
				for_all_objects (agent {EV_FRAME}.set_style (element_info.data.to_integer))
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
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Style_string)
			if element_info /= Void then
				Result := info.name + ".set_style (" + element_info.data + ")"
				Result := strip_leading_indent (Result)
			end
		end

end -- class GB_EV_FRAME
