indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
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
			-- `Void' if user did not click "OK".
		do
			Result := implementation.file_name
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.file_name)
		end

	filter: STRING is
			-- Filter currently applied to file list.
		do
			Result := implementation.filter
		ensure
			bridge_ok: Result.is_equal (implementation.filter)
		end

	start_directory: STRING is
			-- Base directory where browsing will start.
		do
			Result := implementation.start_directory
		ensure
			bridge_ok: Result.is_equal (implementation.start_directory)
		end

feature -- Status report

	file_title: STRING is
			-- `file_name' without its path.
			-- `Void' if user did not click "OK".
		do
			Result := implementation.file_title
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.file_title)
		end

	file_path: STRING is
			-- Path of `file_name'.
			-- `Void' if user did not click "OK".
		do
			Result := implementation.file_path
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.file_path)
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		require
			a_filter_not_void: a_filter /= Void
		do
			implementation.set_filter (a_filter)
		ensure
			assigned: filter.is_equal (a_filter)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		require
			a_name_not_void: a_name /= Void
		do
			implementation.set_file_name (a_name)
		ensure
			assigned: file_name.is_equal (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			a_path_not_void: a_path /= Void
		do
			implementation.set_start_directory (a_path)
		ensure
			assigned: start_directory.is_equal (a_path)
		end

feature {NONE} -- implementation

	implementation: EV_FILE_DIALOG_I

invariant
	filter_not_void: filter /= Void
	start_directory_not_void: start_directory /= Void
	file_name_not_void_implies_path_and_title_not_void: file_name /= Void
		implies (file_title /= Void and then file_path /= Void)
	path_plus_title_equals_name: file_name /= Void implies
		file_name.is_equal (file_path + file_title)

end -- class EV_FILE_DIALOG

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:50  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.7  2000/01/28 22:24:22  oconnor
--| released
--|
--| Revision 1.7.6.6  2000/01/27 23:45:26  brendel
--| Improved contracts.
--|
--| Revision 1.7.6.5  2000/01/27 22:03:11  brendel
--| Improved contracts.
--| Removed feature default_extension.
--| Added features file_path and file_title.
--|
--| Revision 1.7.6.4  2000/01/27 19:30:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.3  2000/01/27 18:54:55  brendel
--| Fixed bug in postconditions.
--|
--| Revision 1.7.6.2  2000/01/27 02:40:11  brendel
--| Revised. Now has attributes: file_name, start_directory, default_extension,
--| filter.
--|
--| Revision 1.7.6.1  1999/11/24 17:30:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.7.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
