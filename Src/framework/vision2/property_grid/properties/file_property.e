note
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

	initialize
			-- Initialize.
		do
			Precursor
			ellipsis_actions.force_extend (agent show_dialog)
			enable_text_editing
		end

feature -- Access

	filters: ARRAYED_LIST [TUPLE [STRING_GENERAL, STRING_GENERAL]]
			-- File extension filters for dialog.

feature -- Update

	add_filters (a_extension, a_description: STRING_GENERAL)
			-- Add a filter with `a_extension' and `a_description'.
		require
			a_extension_ok: a_extension /= Void and then not a_extension.is_empty
			a_description_ok: a_description /= Void and then not a_description.is_empty
		do
			if filters = Void then
				create filters.make (1)
			end
			filters.force ([a_extension, a_description])
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
			l_dial: EV_FILE_OPEN_DIALOG
			l_dir: DIRECTORY
		do
			update_text_on_deactivation
			l_parent := parent_window (parent)
			is_dialog_open := True
			create l_dial
			if filters /= Void then
				l_dial.filters.append (filters)
			end
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

	dialog_ok (a_dial: EV_FILE_OPEN_DIALOG)
			-- If dialog is closed with ok.
		do
			set_value (a_dial.file_name)
		end

	directory_location_value: STRING_32
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

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			Result := a_string.twin
			Result.replace_substring_all ("%%N", "%N")
		end

end
