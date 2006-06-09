indexing
	description: "Property to choose a directory."
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_PROPERTY

inherit
	ELLIPSIS_PROPERTY [STRING_32]
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			Precursor
			ellipsis_actions.force_extend (agent show_dialog)
		end

feature -- Status

	is_dialog_open: BOOLEAN
			-- Is the extended dialog open?

feature {NONE} -- Agents

	show_dialog is
			-- Show text editor.
		require
			parent_window: parent_window /= Void
			popup_window: popup_window /= Void
			activated: is_activated
		local
			l_parent: EV_WINDOW
			l_dial: EV_DIRECTORY_DIALOG
		do
			update_text_on_deactivation
			l_parent := parent_window
			is_dialog_open := True
			create l_dial
			if value /= Void and then not value.is_empty then
				if (create {DIRECTORY}.make (value)).exists then
					l_dial.set_start_directory (value)
				end
			end

			l_dial.ok_actions.extend (agent dialog_ok (l_dial))
			l_dial.show_modal_to_window (l_parent)
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_DIRECTORY_DIALOG) is
			-- If dialog is closed with ok.
		do
			set_value (a_dial.directory)
		end

end
