note
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

	initialize
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

	show_dialog
			-- Show text editor.
		require
			parented: is_parented
			parent_window: parent_window (parent) /= Void
			popup_window: popup_window /= Void
			activated: is_activated
		local
			l_parent: EV_WINDOW
			l_dial: EV_DIRECTORY_DIALOG
			l_dir: DIRECTORY
		do
			update_text_on_deactivation
			l_parent := parent_window (parent)
			is_dialog_open := True
			create l_dial
			if value /= Void and then not value.is_empty then
				create l_dir.make (location_value)
				if l_dir.exists then
					l_dial.set_start_directory (l_dir.name)
				end
			end

			l_dial.ok_actions.extend (agent dialog_ok (l_dial))
			l_dial.show_modal_to_window (l_parent)
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_DIRECTORY_DIALOG)
			-- If dialog is closed with ok.
		do
			set_value (a_dial.directory)
		end

	location_value: STRING_32
			-- Location from the value (e.g. resolve variables).
		do
			if value /= Void then
				Result := value
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			Result := a_string.twin
			Result.replace_substring_all ("%%N", "%N")
		end

end
