indexing
	description: "Objects that manipulate objects of type EV_TEXT_COMPONENT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_COMPONENT
	
	-- The following properties from EV_TEXT_COMPONENT are manipulated by `Current'.
	-- Is_editable - Performed on the real object and the display_object child.

inherit
	GB_EV_ANY
		undefine
			attribute_editor,
			set_up_user_events
		redefine
			ev_type
		end
		
	GB_EV_TEXT_COMPONENT_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if not first.is_editable then
				add_element_containing_string (element, Is_editable_string, False_string)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_editable_string)
			if element_info /= Void and then element_info.data.is_equal (False_string) then
				for_all_objects (agent {EV_TEXT_COMPONENT}.disable_edit)	
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
			element_info := full_information @ (Is_editable_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := info.name + ".enable_edit"
				else
					Result := info.name + ".disable_edit"
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_TEXT_COMPONENT