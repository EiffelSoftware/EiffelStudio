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
				Result := Void
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
			if Result /= Void then
				Result := Result.substring (
					Result.last_index_of ('\', Result.count) + 1,
					Result.count)
			end
		end

	file_path: STRING is
			-- Path of `file_name'.
		do
			Result := file_name
			if Result /= Void then
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
				filter_name.tail (filter_name.count - 2)
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

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.8.7  2001/04/05 22:19:36  pichery
--| Fixed obvious bug with `file_title' (if `file_name' was "D:\Eiffel50\test.ace",
--| `file_title' was returning "Eiffel50\test.ace" instead of "test.ace")
--|
--| Revision 1.5.8.6  2001/03/27 21:16:41  manus
--| Made `set_filter_name' more user friendly in its output. If the user specifies
--| `*.ace' we will display in the filter field `Ace Files (*.ace)'. The next thing
--| to do will be to retrieve that information from the registry keys (not yet done).
--|
--| Revision 1.5.8.5  2001/02/06 02:13:12  manus
--| Improved efficiency of `file_title' and `file_path'.
--| In `file_path' does not include the final `\' because most routines
--| that check existence of directory will fail.
--|
--| Revision 1.5.8.4  2001/02/01 19:04:45  rogers
--| File name is now returned correctly.
--|
--| Revision 1.5.8.3  2000/12/22 23:32:37  rogers
--| Comments.
--|
--| Revision 1.5.8.2  2000/08/11 18:58:26  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.5.8.1  2000/05/03 19:09:21  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/03/07 01:53:25  brendel
--| Released
--|
--| Revision 1.6  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.10.4  2000/01/27 23:54:33  brendel
--| Removed feature default_extension.
--| Implemented file_title and file_path.
--|
--| Revision 1.5.10.3  2000/01/27 19:30:18  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.10.2  2000/01/27 18:09:21  brendel
--| Implemented in compliance with new interface.
--|
--| Revision 1.5.10.1  1999/11/24 17:30:24  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
