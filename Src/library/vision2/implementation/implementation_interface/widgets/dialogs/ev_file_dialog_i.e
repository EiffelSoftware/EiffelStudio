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
			assigned: file_name.is_equal (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			a_path_not_void: a_path /= Void
		deferred
		ensure
			assigned: start_directory.is_equal (a_path)
		end

end -- class EV_FILE_DIALOG_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.1  2000/05/03 19:09:03  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.5  2000/02/04 04:07:01  oconnor
--| released
--|
--| Revision 1.5.6.4  2000/01/27 22:03:11  brendel
--| Improved contracts.
--| Removed feature default_extension.
--| Added features file_path and file_title.
--|
--| Revision 1.5.6.3  2000/01/27 19:29:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/27 02:40:11  brendel
--| Revised. Now has attributes: file_name, start_directory, default_extension,
--| filter.
--|
--| Revision 1.5.6.1  1999/11/24 17:30:08  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:39  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
