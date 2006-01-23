indexing 
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

	file_name: STRING is
			-- Full name of currently selected file including path.
			-- `empty' if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_name
		ensure
			file_name_not_void: Result /= Void
			bridge_ok: not Result.is_empty implies
				Result.is_equal (implementation.file_name)
		end

	filter: STRING is
			-- Filter currently applied to file list.
		obsolete "Use `filters' instead"
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.filter
		ensure
			bridge_ok: Result.is_equal (implementation.filter)
		end
		
	filters: ARRAYED_LIST [TUPLE [STRING, STRING]] is
			-- All filters currently applied to file list.
			-- First STRING represents the filter e.g "*.txt".
			-- Second STRING represents the displayed text
			-- e.g. "Text files (*.txt)".
			-- Multiple filters may be grouped as one
			-- Through seperation by a semicolon e.g.
			-- pass "*.txt;*.rtf;*.doc" as the filter.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.filters
		ensure
			bridge_ok: Result = implementation.filters
		end

	start_directory: STRING is
			-- Base directory where browsing will start.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.start_directory
		ensure
			bridge_ok: Result.is_equal (implementation.start_directory)
		end

feature -- Status report

	file_title: STRING is
			-- `file_name' without its path.
			-- is_empty if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_title
		ensure
			file_title_not_void: Result /= Void
			bridge_ok: not Result.is_empty implies
				Result.is_equal (implementation.file_title)
		end

	file_path: STRING is
			-- Path of `file_name'.
			-- is_empty if user did not click "OK".
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.file_path
		ensure
			file_path_not_void: Result /= Void
			bridge_ok: not Result.is_empty implies
				Result.is_equal (implementation.file_path)
		end
		
	selected_filter_index: INTEGER is
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_filter_index
		ensure
			result_zero_when_no_filters: filters.is_empty implies result = 0
			valid_result_when_filters_set: not filters.is_empty implies Result >= 1 and Result <= filters.count
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		obsolete "Use `filters.extend ([%"*.`a_filter'%", %"Files of type ('a_filter')%"])' instead."
		require
			not_destroyed: not is_destroyed
			a_filter_not_void: a_filter /= Void
		do
			implementation.set_filter (a_filter)
		ensure
			assigned: filter.is_equal (a_filter)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		require
			not_destroyed: not is_destroyed
			a_name_not_void: a_name /= Void
			valid_file_name: valid_file_name (a_name)
		do
			implementation.set_file_name (a_name)
		ensure
			assigned: not file_name.is_empty implies file_name.is_equal (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			not_destroyed: not is_destroyed
			a_path_not_void: a_path /= Void
		do
			implementation.set_start_directory (a_path)
		ensure
			assigned: start_directory.is_equal (a_path)
		end
		
feature -- Contract Support

	valid_file_name (a_name: STRING): BOOLEAN is
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
		
	valid_file_title (a_title: STRING): BOOLEAN is
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
	start_directory_not_void: start_directory /= Void
	file_name_not_void_implies_path_and_title_not_void: file_name /= Void
		implies (file_title /= Void and then file_path /= Void)
	valid_file_name: file_name /= Void implies valid_file_name (file_name)
	valid_file_title: file_title /= Void implies valid_file_title (file_title)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FILE_DIALOG

