indexing
	description: "Objects that manipulate objects of type EV_TEXTABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXTABLE
	
	-- The following properties from EV_TEXTABLE are manipulated by `Current'.
	-- Text - Performed on the real object and the display_object child.

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
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_TEXTABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXTABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text (text_string)
			Result.extend (label)
			create text_entry
			Result.extend (text_entry)
			text_entry.change_actions.extend (agent set_text)
			text_entry.change_actions.extend (agent update_editors)
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			text_entry.change_actions.block
			text_entry.set_text (first.text)
			text_entry.change_actions.resume
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			textable: EV_TEXTABLE
		do
			textable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			textable.default_create
			if not objects.first.text.is_empty then
				add_element_containing_string (element, text_string, objects.first.text)	
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				for_all_objects (agent {EV_TEXTABLE}.set_text (element_info.data))
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
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				Result := a_name + ".set_text (%"" + element_info.data + "%")"
			end
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation
		
	set_text is
			--
		do
			for_all_objects (agent {EV_TEXTABLE}.set_text (text_entry.text))
		end
		
	label: EV_LABEL
		-- Identifies `combo_box'.
		
	text_entry: EV_TEXT_FIELD

	Text_string: STRING is "Text"

end -- class GB_EV_TEXTABLE