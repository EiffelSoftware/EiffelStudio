indexing 
	description:
		"Eiffel Vision file save dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG

inherit
	EV_FILE_DIALOG
		redefine
			implementation
		end

create
	default_create

feature {NONE} -- Implementation

	create_implementation is
		do
			create {EV_FILE_SAVE_DIALOG_IMP} implementation.make (Current)
		end

	implementation: EV_FILE_SAVE_DIALOG_I

end -- class EV_FILE_SAVE_DIALOG

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
--| Revision 1.10  2000/02/29 18:09:09  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.9  2000/02/22 18:39:50  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:50  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.4  2000/01/28 22:24:23  oconnor
--| released
--|
--| Revision 1.7.6.3  2000/01/27 19:30:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.2  2000/01/27 02:41:26  brendel
--| Revised. GTK platform makes no difference in save/open so little to
--| implement.
--|
--| Revision 1.7.6.1  1999/11/24 17:30:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
