indexing
	description: "Objects that manipulate objects of type EV_SENSITIVE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_SENSITIVE
	
	-- The following properties from EV_SENSITIVE are manipulated by `Current'.
	-- Is_sensitive - Performed on the real object only. Not the display object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_SENSITIVE_EDITOR_CONSTRUCTOR

feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
			-- Note that we must query the _I, as there is no way to know
			-- if the widget was really disabled by the user, or by its
			-- parent except in the interface.
		local
			sensitive_i: EV_SENSITIVE_I
		do
			sensitive_i ?= first.implementation
			check
				sensitive_i_not_void: sensitive_i /= Void
			end
			if sensitive_i.internal_non_sensitive then
				add_element_containing_boolean (element, is_sensitive_string, objects.first.is_sensitive)
			end
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_sensitive_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_first_object (agent {EV_SENSITIVE}.enable_sensitive)
				else
					for_first_object (agent {EV_SENSITIVE}.disable_sensitive)
				end
			end
		end
		
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
			element_info := full_information @ (is_sensitive_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := info.name + ".enable_sensitive"
				else
					Result := info.name + ".disable_sensitive"
				end
			end
		end

end -- class GB_EV_SENSITIVE
