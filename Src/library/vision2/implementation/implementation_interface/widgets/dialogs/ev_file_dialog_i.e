indexing 
	description: "EiffelVision file selection dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
		deferred
		end

	filter: STRING is
			-- Filter currently applied to file list.
		deferred
		end
	
	filters: ARRAYED_LIST [TUPLE [STRING, STRING]]
			-- All filters currently applied to file list.
			-- First STRING represents the filter e.g "*.txt".
			-- Second STRING represents the displayed text
			-- e.g. "Text files (*.txt)".

	start_directory: STRING is
			-- Base directory where browsing will start.
		deferred
		end

feature -- Status report

	file_title: STRING is
			-- `file_name' without its path.
		deferred
		end

	file_path: STRING is
			-- Path of `file_name'.
		deferred
		end
		
	selected_filter_index: INTEGER is
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		deferred
		ensure
			result_zero_when_no_filters: filters.is_empty implies result = 0
			valid_result_when_filters_set: not filters.is_empty implies Result >= 1 and Result <= filters.count
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		require
			a_filter_not_void: a_filter /= Void
		deferred
		ensure
			assigned: filter.is_equal (a_filter)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		require
			a_name_not_void: a_name /= Void
		deferred
		ensure
			assigned: not file_name.is_empty implies file_name.is_equal (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			a_path_not_void: a_path /= Void
		deferred
		ensure
			assigned: start_directory.is_equal (a_path)
		end
		
feature {EV_FILE_DIALOG} -- Contract support

	valid_file_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid file_name on the current platform?
		deferred
		end
		
	valid_file_title (a_title: STRING): BOOLEAN is
			-- Is `a_title' a valid file title on the current platform?
		deferred
		end
		
invariant
	filters_not_void: filters /= Void

end -- class EV_FILE_DIALOG_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

