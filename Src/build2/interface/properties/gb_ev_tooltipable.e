indexing
	description: "Objects that manipulate objects of type EV_TOOLTIPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TOOLTIPABLE

	-- The following properties from EV_TOOLTIPABLE are manipulated by `Current'.
	-- tooltip - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_TOOLTIPABLE_EDITOR_CONSTRUCTOR
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	CDATA_HANDLER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output
	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if not objects.first.tooltip.is_empty or uses_constant (Tooltip_string) then
				add_string_element (element, Tooltip_string, enclose_in_cdata (objects.first.tooltip))	
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Tooltip_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				for_all_objects (agent {EV_TOOLTIPABLE}.set_tooltip (strip_cdata (retrieve_and_set_string_value (Tooltip_string))))
			end
		end

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			escaped_text: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Tooltip_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				Result := info.name + ".set_tooltip (" + retrieve_string_setting (Tooltip_string) +")"
			end
			Result := strip_leading_indent (Result)
		end

end -- class GB_EV_TOOLTIPABLE
