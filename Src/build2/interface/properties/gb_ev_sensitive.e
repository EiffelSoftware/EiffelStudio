indexing
	description: "Objects that manipulate objects of type EV_SENSITIVE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_SENSITIVE
	
	-- The following properties from EV_SENSITIVE are manipulated by `Current'.
	-- Is_sensitive - Performed on the real object and the display_object.

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

feature -- Access


	ev_type: EV_SENSITIVE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_SENSITIVE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			create check_button.make_with_text ("Sensitive?")
			update_attribute_editor
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_sensitivity)
			check_button.select_actions.extend (agent update_editors)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.is_sensitive then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end
		
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			add_element_containing_boolean (element, is_sensitive_string, objects.first.is_sensitive)
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_sensitive_string)
			if element_info.data.is_equal (True_string) then
				for_all_objects (agent {EV_SENSITIVE}.enable_sensitive)
			else
				for_all_objects (agent {EV_SENSITIVE}.disable_sensitive)
			end
		end
		
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
			element_info := full_information @ (is_sensitive_string)
			if element_info.data.is_equal (True_string) then
				Result := a_name + ".enable_sensitive"
			else
				Result := a_name + ".disable_sensitive"
			end
		end

feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_sensitivity is
			-- Update sensitive state.
		do
			if check_button.is_selected then
				for_all_objects (agent {EV_SENSITIVE}.enable_sensitive)
			else
				for_all_objects (agent {EV_SENSITIVE}.disable_sensitive)
			end
		end


	-- Constants for XML
	
	is_sensitive_string: STRING is "Is_sensitive"


end -- class GB_EV_SENSITIVE
