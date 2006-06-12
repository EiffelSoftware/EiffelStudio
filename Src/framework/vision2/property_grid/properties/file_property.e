indexing
	description: "Property to choose a file."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_PROPERTY

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
			enable_text_editing
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
			l_dial: EV_FILE_OPEN_DIALOG
			l_dir: DIRECTORY
		do
			update_text_on_deactivation
			l_parent := parent_window
			is_dialog_open := True
			create l_dial
			if value /= Void and then not value.is_empty then
				create l_dir.make (directory_location_value)
				if l_dir.exists then
					l_dial.set_start_directory (l_dir.name)
				end
			end

			l_dial.open_actions.extend (agent dialog_ok (l_dial))
			l_dial.show_modal_to_window (l_parent)
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_FILE_OPEN_DIALOG) is
			-- If dialog is closed with ok.
		do
			set_value (a_dial.file_name)
		end

	directory_location_value: STRING_32 is
			-- Directory location from the value (e.g. resolve variables).
		local
			i: INTEGER
		do
			if value /= Void then
				i := value.last_index_of (operating_environment.directory_separator, value.count)
				if i > 1 then
					Result := value.substring (1, i - 1)
				else
					create Result.make_empty
				end
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

end
