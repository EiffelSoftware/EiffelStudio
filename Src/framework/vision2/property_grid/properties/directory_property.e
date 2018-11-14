note
	description: "Property to choose a directory."
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_PROPERTY

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
			l_dial: EV_DIRECTORY_DIALOG
			l_dir: DIRECTORY
		do
			update_text_on_deactivation
			is_dialog_open := True
			create l_dial
			if attached value as l_value and then not l_value.is_empty then
				create l_dir.make (location_value)
				if l_dir.exists then
					l_dial.set_start_directory (l_dir.path.name)
				end
			end

			l_dial.ok_actions.extend (agent dialog_ok (l_dial))
			check attached parent_window (parent) as l_parent then
				l_dial.show_modal_to_window (l_parent)
			end
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_DIRECTORY_DIALOG)
			-- If dialog is closed with ok.
		do
			set_value (a_dial.path.name)
		end

	location_value: STRING_32
			-- Location from the value (e.g. resolve variables).
		do
			if attached value as l_value then
				Result := l_value
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
