note
	description: "Simple dialog that allows to edit a text."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_EDITOR_DIALOG

inherit
	PROPERTY_DIALOG [STRING_32]
		redefine
			initialize,
			on_ok
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		do
			Precursor {PROPERTY_DIALOG}
			create text_editor
			element_container.extend (text_editor)

			show_actions.extend (agent text_editor.set_focus)
			data_change_actions.extend (agent text_editor.set_text ({STRING_32}?))
		end

feature {NONE} -- GUI elements

	text_editor: EV_TEXT
			-- Text editor field.

feature {NONE} -- Agents

	on_ok
			-- Ok was pressed.
		do
			value := text_editor.text
			Precursor {PROPERTY_DIALOG}
		end

invariant
	value_set: is_ok implies value /= Void
	elements: is_initialized implies text_editor /= Void

end
