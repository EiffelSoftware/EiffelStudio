indexing 
	description: "Eiffel Vision directory dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

create
	default_create

feature {NONE} -- Initialization

	create_implementation is
		do
			create {EV_DIRECTORY_DIALOG_IMP} implementation.make (Current)
		end

feature -- Access

	directory: STRING is
			-- Path of the current selected file
		do
			Result := implementation.directory
		ensure
			bridge_ok: Result /= Void implies
				Result.is_equal (implementation.directory)
		end

	start_directory: STRING is
			-- Base directory where browsing will start.
		do
			Result := implementation.start_directory
		ensure
			bridge_ok: Result.is_equal (implementation.start_directory)
		end

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		require
			a_path_not_void: a_path /= Void
		do
			implementation.set_start_directory (a_path)
		ensure
			assigned: start_directory.is_equal (a_path)
		end

feature {NONE} -- Implementation

	implementation: EV_DIRECTORY_DIALOG_I

end -- class EV_DIRECTORY_DIALOG

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
--| Revision 1.7  2000/02/14 11:40:50  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.4  2000/01/28 22:24:22  oconnor
--| released
--|
--| Revision 1.6.6.3  2000/01/28 01:13:06  brendel
--| Revised interface.
--| Added feature `start_dircetory'.
--|
--| Revision 1.6.6.2  2000/01/27 19:30:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
