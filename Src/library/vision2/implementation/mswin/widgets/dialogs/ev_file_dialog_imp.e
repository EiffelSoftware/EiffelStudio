--| FIXME Not for release
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
			-- Initialize.
		do
			base_make (an_interface)
			wel_make
			set_filter ("*.*")
			start_directory := "."
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
		do
			if selected_button /= Void and then selected_button.is_equal ("OK") then
				Result := wel_file_name
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
			if file_name /= Void then
				Result := file_name.mirrored
				Result.head (Result.index_of ('\', 1) - 1)
				Result.mirror
			end
		end

	file_path: STRING is
			-- Path of `file_name'.
		do
			if file_name /= Void then
				Result := clone (file_name)
				Result.head (Result.count - Result.mirrored.index_of ('\', 1) + 1)
			end
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		do
			filter := clone (a_filter)
			if filter.is_equal ("*.*") then
				wel_set_filter (<<"All files">>, <<"*.*">>)
			else
				wel_set_filter (<<filter, "All files">>, <<filter, "*.*">>)
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
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
