indexing 
	description: "Eiffel Vision file open dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			set_title ("Open")
		end

feature {NONE} -- Implementation

	interface: EV_FILE_OPEN_DIALOG

end -- class EV_FILE_OPEN_DIALOG_IMP

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
--| Revision 1.8  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.1  2000/05/03 19:08:46  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/02/22 18:39:37  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.5  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.5.6.4  2000/01/27 23:56:09  brendel
--| Added redefine of implementation.
--| Now has title "Open" by default.
--|
--| Revision 1.5.6.3  2000/01/27 19:29:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/27 02:41:25  brendel
--| Revised. GTK platform makes no difference in save/open so little to
--| implement.
--|
--| Revision 1.5.6.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
