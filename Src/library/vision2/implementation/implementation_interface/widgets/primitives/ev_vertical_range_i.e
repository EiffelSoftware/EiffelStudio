indexing 
	description: "Eiffel Vision vertical range. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VERTICAL_RANGE_I

inherit
	EV_RANGE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_RANGE

end -- class EV_VERTICAL_RANGE_I

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
--| Revision 1.8  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.7  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.1  2000/05/03 19:09:08  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.6  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.3.6.5  2000/02/02 00:59:34  brendel
--| Revised to comply with revised interface.
--|
--| Revision 1.3.6.4  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/11 17:19:30  rogers
--| Added interface.
--|
--| Revision 1.3.6.2  2000/01/11 16:57:43  rogers
--| Altered to comply with the major vision2 changes. redefined interface, and removed default options.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
