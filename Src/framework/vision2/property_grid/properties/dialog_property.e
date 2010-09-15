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
			l_parent: EV_WINDOW
			l_default: G
		do
			update_text_on_deactivation
			l_parent := parent_window (parent)
			is_dialog_open := True
			if dialog = Void then
				create dialog
			end
			dialog.set_title (dialog_title (name))
			if value /= Void then
				dialog.set_value (value_twin (value))
			else
				dialog.set_value (l_default)
			end
			dialog.show_modal_to_window (l_parent)
			if dialog.is_ok and then is_valid_value (dialog.value) then
				set_value (dialog.value)
			end
			is_dialog_open := False
		end

feature {NONE} -- Implementation

	dialog: PROPERTY_DIALOG [G]
			-- Dialog to show to change the value.

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
		end

	value_twin (v: like value): like value
			-- Twin of `v'.
		do
			Result := v.twin
		end

end
