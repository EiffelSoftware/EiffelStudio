note
	description: "Simple dialog that allows to edit a text."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_EDITOR_DIALOG

inherit
	PROPERTY_DIALOG [READABLE_STRING_32]
		redefine
			create_interface_objects,
			initialize,
			on_ok
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create text_editor
		end

	initialize
			-- Initialize.
		do
			Precursor {PROPERTY_DIALOG}
			element_container.extend (text_editor)

			show_actions.extend (agent text_editor.set_focus)
			data_change_actions.extend (agent text_editor.set_text ({READABLE_STRING_32}?))
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

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
