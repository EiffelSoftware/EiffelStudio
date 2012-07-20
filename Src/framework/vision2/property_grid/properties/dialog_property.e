note
	description: "Property where the value can be changed in a dialog."
	date: "$Date$"
	revision: "$Revision$"

class
	DIALOG_PROPERTY [G]

inherit
	ELLIPSIS_PROPERTY [G]
		redefine
			initialize
		end

create
	make,
	make_with_dialog

feature {NONE} -- Initialization

	make_with_dialog (a_name: like name; a_dialog: like dialog)
			-- Create with `a_name' and `a_dialog'.
		require
			a_name_ok: a_name /= Void
			a_dialog_ok: a_dialog /= Void
		do
			make (a_name)
			dialog := a_dialog
		ensure
			dialog_set: dialog = a_dialog
		end

	initialize
			-- Initialize.
		do
			Precursor
			ellipsis_actions.force_extend (agent show_dialog)
		end

feature -- Status

	is_dialog_open: BOOLEAN
			-- Is the extended dialog open?

feature {NONE} -- Agents

	show_dialog
			-- Show text editor.
		require
			parented: is_parented
			parent_window: parent_window (parent) /= Void
		local
			l_dialog: like dialog
			l_default_value: like value
		do
			update_text_on_deactivation
			is_dialog_open := True
			if dialog = Void then
				create dialog
			end
			dialog.set_title (dialog_title (name))
			if attached value as l_value then
				dialog.set_value (l_value.twin)
			else
				dialog.set_value (l_default_value)
			end
			check attached parent_window (parent) as l_parent then
				dialog.show_modal_to_window (l_parent)
			end
			if dialog.is_ok and then attached dialog.value as l_value and then is_valid_value (l_value) then
				set_value (l_value)
			end
			is_dialog_open := False
		end

feature {NONE} -- Implementation

	dialog: detachable PROPERTY_DIALOG [G] note option: stable attribute end
			-- Dialog to show to change the value.

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
