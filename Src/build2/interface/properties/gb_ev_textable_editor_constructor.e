indexing
	description: "Builds an attribute editor for modification of objects of type EV_TEXTABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		redefine
			ev_type
		end
	
	GB_CONSTANTS

feature -- Access

	ev_type: EV_TEXTABLE
		-- Vision2 type represented by `Current'.

	type: STRING is "EV_TEXTABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			line_entry_type: BOOLEAN
		do
			create Result
			
			if is_instance_of (first, dynamic_type_from_string ("EV_TEXT")) or is_instance_of (first, dynamic_type_from_string ("EV_LABEL")) then
				line_entry_type := multiple_line_entry	
			else
				line_entry_type := single_line_entry
			end
			initialize_attribute_editor (Result)
				create text_entry.make (Current, Result, text_string, Gb_ev_textable_text, Gb_ev_textable_text_tooltip,
				agent set_text (?), agent validate_true (?), line_entry_type)
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		ensure
			text_entry_not_void: text_entry /= Void
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.extend (agent set_text (?), text_string)
			validate_agents.extend (agent validate_true (?), text_string)
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			text_entry.set_text (first.text)
		end

	set_text (a_text: STRING) is
			-- Assign `text' of `text_entry' to all objects.
		do
			for_all_objects (agent {EV_TEXTABLE}.set_text (a_text))
			update_editors
		end
		
	text_entry: GB_STRING_INPUT_FIELD
		-- Input field for text.

	Text_string: STRING is "Text"
	
end -- class GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
