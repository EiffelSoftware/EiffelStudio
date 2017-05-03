note
	description:
		"EiffelVision file selection dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

feature -- Access

	file_name: STRING_32
			-- Full name of currently selected file including path.
			-- `empty' if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			create Result.make_from_string (full_file_path.name)
		ensure
			file_name_not_void: Result /= Void
		end

	full_file_path: PATH
			-- Full path of currently selected file including path.
			-- `empty' is used did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.full_file_path
		ensure
			full_file_path_not_void: Result /= Void
			bridge_ok: not Result.is_empty implies Result ~ implementation.full_file_path
		end

	filter: STRING_32
			-- Filter currently applied to file list.
		obsolete "Use `filters' instead [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.filter
		ensure
			bridge_ok: Result.is_equal (implementation.filter)
		end

	filters: ARRAYED_LIST [TUPLE [filter, text: READABLE_STRING_GENERAL]]
			-- All filters currently applied to file list.
			-- First STRING represents the filter e.g "*.txt".
			-- Second STRING represents the displayed text
			-- e.g. "Text files (*.txt)".
			-- Multiple filters may be grouped as one
			-- Through separation by a semicolon e.g.
			-- pass "*.txt;*.rtf;*.doc" as the filter.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.filters
		ensure
			bridge_ok: Result = implementation.filters
		end

	start_directory: STRING_32
			-- Base directory where browsing will start.
		require
			not_destroyed: not is_destroyed
		do
			create Result.make_from_string (start_path.name)
		end

	start_path: PATH
			-- Base directory where browsing will start.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.start_path
		ensure
			bridge_ok: Result.is_equal (implementation.start_path)
		end

feature -- Status report

	file_title: STRING_32
			-- `file_name' without its path.
			-- is_empty if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			if attached full_file_path.entry as l_entry then
				create Result.make_from_string (l_entry.name)
			else
				create Result.make_empty
			end
		ensure
			file_title_not_void: Result /= Void
		end

	file_path: STRING_32
			-- Path of `file_name'.
			-- is_empty if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			create Result.make_from_string (full_file_path.parent.name)
		ensure
			file_path_not_void: Result /= Void
		end

	selected_filter_index: INTEGER
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_filter_index
		ensure
			result_zero_when_no_filters: filters.is_empty implies Result = 0
			valid_result_when_filters_set: not filters.is_empty implies Result >= 1 and Result <= filters.count
		end

feature -- Element change

	set_filter (a_filter: READABLE_STRING_GENERAL)
			-- Set `a_filter' as new filter.
		obsolete "Use `filters.extend ([%"*.`a_filter'%", %"Files of type ('a_filter')%"])' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
			a_filter_not_void: a_filter /= Void
		do
			implementation.set_filter (a_filter)
		ensure
			assigned: filter.same_string_general (a_filter)
		end

	set_file_name (a_name: READABLE_STRING_GENERAL)
			-- Make `a_name' the selected file.
		require
			not_destroyed: not is_destroyed
			a_name_not_void: a_name /= Void
			valid_file_name: valid_file_name (a_name)
		do
			set_full_file_path (create {PATH}.make_from_string (a_name))
		ensure
			assigned: not file_name.is_empty implies file_name.same_string_general (a_name)
		end

	set_full_file_path (a_path: PATH)
			-- Make `a_path' the selected file.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
		do
			implementation.set_full_file_path (a_path)
		end

	set_start_directory (a_path: READABLE_STRING_GENERAL)
			-- Make `a_path' the base directory.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
		do
			set_start_path (create {PATH}.make_from_string (a_path))
		ensure
			assigned: start_directory.same_string_general (a_path)
		end

	set_start_path (a_path: PATH)
			-- Make `a_path' the base directory.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
		do
			implementation.set_start_path (a_path)
		ensure
			assigned: start_path ~ a_path
		end

feature -- Contract Support

	valid_file_name (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
			-- Certain characters are not permissible and this is dependent
			-- on the current platform. The following characters are not permitted,
			-- and this list may not be exhaustive:
			-- Windows - " * < > ? |
			-- Linux - *
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.valid_file_name (a_name)
		end

	valid_file_title (a_title: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_title' a valid file title on the current platform?
			-- The following characters are not permitted,
			-- and this list may not be exhaustive:
			-- Windows - " * / : < > ? \ |
			-- Linux - *
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.valid_file_title (a_title)
		end

feature {EV_ANY, EV_ANY_I} -- implementation

	implementation: EV_FILE_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

invariant
	filters_not_void: filters /= Void
	start_directory_not_void: start_path /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_FILE_DIALOG

