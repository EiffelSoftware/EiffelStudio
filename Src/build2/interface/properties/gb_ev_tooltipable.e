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
		redefine
			attribute_editor,
			ev_type
		end
		
	XML_UTILITIES
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_TOOLTIPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TOOLTIPABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text ("Tooltip")
			Result.extend (label)
			create tooltip_entry
			Result.extend (tooltip_entry)
			tooltip_entry.change_actions.extend (agent set_tooltip)
			tooltip_entry.change_actions.extend (agent update_editors)
			
			update_attribute_editor
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			tooltip_entry.change_actions.block
			
			tooltip_entry.set_text (first.tooltip)
			
			tooltip_entry.change_actions.resume
		end
		
feature {GB_XML_STORE} -- Output
	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if not objects.first.tooltip.is_empty then
				add_element_containing_string (element, Tooltip_string, objects.first.tooltip)	
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Tooltip_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				for_all_objects (agent {EV_TOOLTIPABLE}.set_tooltip (element_info.data))
			end
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
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Tooltip_string)
			if element_info /= Void then
				Result := a_name + ".set_tooltip (%"" + element_info.data + "%")"
			end
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

--	check_button: EV_CHECK_BUTTON
		-- Check button used for setting sensitive attribute.
	
	tooltip_entry: EV_TEXT_FIELD
		-- Holds the text to be used for the tooltip.
		
	set_tooltip is
			-- Assign text of `tooltip_entry' to tooltip of all objects.
		do
			if not tooltip_entry.text.is_empty then
				for_all_objects (agent {EV_TOOLTIPABLE}.set_tooltip (tooltip_entry.text))
			else
				for_all_objects (agent {EV_TOOLTIPABLE}.remove_tooltip)
			end
		end
		
	Tooltip_string: STRING is "Tooltip"

end -- class GB_EV_TOOLTIPABLE
