indexing
	description: "Objects that manipulate objects of type EV_DESELECTABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_DESELECTABLE
	
	-- The following properties from EV_DESELECTABLE are manipulated by `Current'.
	-- Is_selectable - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor,
			set_up_user_events
		end
		
	GB_EV_DESELECTABLE_EDITOR_CONSTRUCTOR
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			deselectable: EV_DESELECTABLE
		do
			deselectable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			deselectable.default_create
			if first.is_selected /= deselectable.is_selected then
				add_element_containing_boolean (element, is_selected_string, objects.first.is_selected)
			end
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_selected_string)
			if element_info /= Void then
					if element_info.data.is_equal (True_string) then
						if first.is_selectable then
								-- In the case of a item components, we will create it
								-- before inserting it into the parent. Therefore, `is_selectable'
								-- is not True. This is a very obscure case, but
								-- posible, hence the check here.
							for_all_objects (agent {EV_DESELECTABLE}.enable_select)	
						end
					else
						for_all_objects (agent {EV_DESELECTABLE}.disable_select)
				end
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
			element_info := full_information @ (is_selected_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := info.name + ".enable_select"
				else
					Result := info.name + ".disable_select"
				end
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_DESELECTABLE