indexing 
	description:
		"Eiffel Vision horizontal separator. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_HORIZONTAL_SEPARATOR_I

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	interface: EV_HORIZONTAL_SEPARATOR
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_HORIZONTAL_SEPARATOR_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.8  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.7  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.4  2000/01/18 07:26:54  oconnor
--| spellink
--|
--| Revision 1.4.6.3  2000/01/18 07:22:41  oconnor
--| formatting, comments, redefined interface
--|
--| Revision 1.4.6.2  2000/01/11 19:35:16  rogers
--| modified to comply with the major vision2. Set default options is removed.
--|
--| Revision 1.4.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
