note
	description: "Eiffel Vision file dialog. Cocoa implementation."
	author:	"Daniel Furrer"

deferred class
	EV_FILE_DIALOG_IMP

inherit
	EV_FILE_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			make
		end

feature {NONE} -- Initialization

	make
			-- Setup action sequences.
		do
			create filters.make (5)
			create internal_filename.make_empty
			create start_path.make_empty
			filter := "*.*"

			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (True)
		end

feature -- Access

	full_file_path: PATH
			-- Full name of currently selected file including path.
		do
			Result := internal_filename
		end

	filter: STRING_32
			-- Filter currently applied to file list.

	selected_filter_index: INTEGER
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		do
		end

	start_path: PATH
			-- Base directory where browsing will start.

feature -- Status report

	file_title: PATH
			-- `file_name' without its path.
		do
			if not full_file_path.is_empty and then attached full_file_path.entry as l_entry then
				Result := l_entry
			else
				create Result.make_empty
			end
		end

	file_path: PATH
			-- Path of `file_name'.
		do
			if not full_file_path.is_empty and then attached full_file_path.parent as l_parent then
				Result := l_parent
			else
				create Result.make_empty
			end
		end

feature -- Element change

	set_filter (a_filter: READABLE_STRING_GENERAL)
			-- Set `a_filter' as new filter.
		local
			filter_name: STRING_32
		do
			filter := a_filter.as_string_32.twin

			filter_name := a_filter.as_string_32.twin
			if
				filter_name.count >= 3 and
				filter_name.item (1) = '*' and
				filter_name.item (2) = '.'
			then
				filter_name.remove_head (2)
				filter_name.put (filter_name.item (1).upper, 1)
				filter_name.append (" Files (")
				filter_name.append_string_general (a_filter)
				filter_name.append (")")
			end

			if not a_filter.is_equal ("*.*") then
			end

		end

	set_start_path (a_path: like start_path)
			-- Make `a_path' the base directory.
		do
			start_path := a_path
			save_panel.set_directory_path (start_path)
		end

	set_full_file_path (a_path: PATH)
			-- Make `a_path' the selected file.
		do
			internal_filename := a_path
		end

feature {NONE} -- Implementation

	valid_file_name, valid_file_title (a_name: STRING_32): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
		do
			if a_name /= Void then
				Result := not a_name.has ('*')
			end
		end

	internal_filename: PATH

	save_panel: NS_SAVE_PANEL

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FILE_DIALOG note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_FILE_DIALOG_IMP
