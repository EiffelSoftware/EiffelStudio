note
	description: "Property to choose a file."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_PROPERTY

inherit
	ELLIPSIS_PROPERTY [READABLE_STRING_32]
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
			ellipsis_actions.extend (agent show_dialog)
			enable_text_editing
		end

feature -- Access

	filters: detachable ARRAYED_LIST [TUPLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]] note option: stable attribute end
			-- File extension filters for dialog.

feature -- Update

	add_filters (a_extension, a_description: READABLE_STRING_GENERAL)
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
			l_dial: EV_FILE_OPEN_DIALOG
			l_dir: DIRECTORY
		do
			update_text_on_deactivation
			is_dialog_open := True
			create l_dial
			if filters /= Void then
				l_dial.filters.append (filters)
			end
			if attached value as l_value and then not l_value.is_empty then
				create l_dir.make (directory_location_value)
				if l_dir.exists then
					l_dial.set_start_directory (l_dir.path.name)
				end
			end

			l_dial.open_actions.extend (agent dialog_ok (l_dial))
			check attached parent_window (parent) as l_parent then
				l_dial.show_modal_to_window (l_parent)
			end
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
			if attached value as l_value then
				i := l_value.last_index_of (operating_environment.directory_separator, l_value.count)
				if i > 1 then
					Result := l_value.substring (1, i - 1)
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
		local
			s32: STRING_32
		do
			create s32.make_from_string (a_string)
			s32.replace_substring_all ("%%N", "%N")
			Result := s32
		end

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
