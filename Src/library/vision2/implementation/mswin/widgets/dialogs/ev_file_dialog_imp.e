indexing 
	description:
		"Eiffel Vision file dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG_IMP

inherit
	EV_FILE_DIALOG_I

	EV_STANDARD_DIALOG_IMP

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
			set_filter ("*.*")
			start_directory := "."
		end

	initialize is
			-- Initialize `Current'.
		do
			is_initialized := True
		end

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
		do
			if selected then
				Result := wel_file_name
			else
				Result := ""
			end
		end

	filter: STRING
			-- Filter currently applied to file list.

	start_directory: STRING
			-- Base directory where browsing will start.

feature -- Status report

	file_title: STRING is
			-- `file_name' without its path.
		do
			Result := file_name
			if not Result.is_empty then
				Result := Result.substring (
					Result.last_index_of ('\', Result.count) + 1,
					Result.count)
			end
		end

	file_path: STRING is
			-- Path of `file_name'.
		do
			Result := file_name
			if not Result.is_empty then
				Result := Result.substring (
					1,
					Result.last_index_of ('\', Result.count) - 1)
			end
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		local
			filter_name: STRING
		do
			filter := clone (a_filter)
			filter_name := clone (a_filter)
			if
				filter_name.count >= 3 and
				filter_name.item (1) = '*' and
				filter_name.item (2) = '.'
			then
				filter_name.remove_head (2)
				filter_name.put (filter_name.item (1).upper, 1)
				filter_name.append (" Files (")
				filter_name.append (a_filter)
				filter_name.append (")")
			end
			if a_filter.is_equal ("*.*") then
				wel_set_filter (<<"All files">>, <<"*.*">>)
			else
				wel_set_filter (<<filter_name, "All files">>, <<a_filter, "*.*">>)
			end
			wel_set_filter_index (0)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		do
			wel_set_file_name (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			start_directory := clone (a_path)
			wel_set_initial_directory (a_path)
		end

feature -- Deferred

	wel_make is
		deferred
		end

	wel_file_name: STRING is
		deferred
		end

	wel_set_file_name (a_file_name: STRING) is
		deferred
		end

	wel_set_filter (filter_names, filter_patterns: ARRAY [STRING]) is
		deferred
		end

	wel_set_filter_index (a_filter_index: INTEGER) is
		deferred
		end

	wel_set_initial_directory (a_directory: STRING) is
		deferred
		end

end -- class EV_FILE_DIALOG_IMP

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

