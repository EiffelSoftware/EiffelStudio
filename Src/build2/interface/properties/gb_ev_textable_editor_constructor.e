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
		do
			--Result := Precursor {GB_EV_ANY}
			create Result
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_textable_text)
			label.set_tooltip (gb_ev_textable_text_tooltip)
			Result.extend (label)
			if is_instance_of (first, dynamic_type_from_string ("EV_TEXT")) or is_instance_of (first, dynamic_type_from_string ("EV_LABEL")) then
				create text_entry
				text_entry.set_minimum_height (50)
				text_entry.set_tooltip (gb_ev_textable_text_tooltip)
				text_entry.change_actions.extend (agent set_text)
				text_entry.change_actions.extend (agent update_editors)
				Result.extend (text_entry)
			else
				create text_field_entry	
				text_field_entry.set_tooltip (gb_ev_textable_text_tooltip)
				text_field_entry.change_actions.extend (agent set_text)
				text_field_entry.change_actions.extend (agent update_editors)
				Result.extend (text_field_entry)
			end

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end

feature {NONE} -- Implementation

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			if text_entry /= Void then
				text_entry.change_actions.block
				text_entry.set_text (first.text)
				text_entry.change_actions.resume
			else
				text_field_entry.change_actions.block
				text_field_entry.set_text (first.text)
				text_field_entry.change_actions.resume
			end	
		end

	set_text is
			-- Assign `text' of `text_entry' to all objects.
		do
			if text_entry /= Void then
				for_all_objects (agent {EV_TEXTABLE}.set_text (text_entry.text))
			else
				for_all_objects (agent {EV_TEXTABLE}.set_text (text_field_entry.text))
			end
		end
		
		
	label: EV_LABEL
		-- Identifies `combo_box'.
		
	text_entry: EV_TEXT
	text_field_entry: EV_TEXT_FIELD

	Text_string: STRING is "Text"
	
invariant
	text_or_field_not_void: (text_entry /= Void or text_field_entry /= Void) and not (text_entry /= Void and text_field_entry /= Void)

end -- class GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
