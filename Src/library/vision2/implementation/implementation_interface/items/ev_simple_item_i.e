--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		"EiffelVision item. Implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_SIMPLE_ITEM_I

end -- class EV_SIMPLE_ITEM_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.26  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.25  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.20.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/04/07 22:10:00  brendel
--| EV_SIMPLE_ITEM_I -> EV_ITEM_I & EV_TEXTABLE_I.
--|
--| Revision 1.23  2000/03/09 21:36:24  king
--| Now inheriting from PND
--|
--| Revision 1.22  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.21  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.6.8  2000/02/04 21:29:59  king
--| Removed text features as it now inherits from textable
--|
--| Revision 1.20.6.7  2000/02/04 04:02:41  oconnor
--| released
--|
--| Revision 1.20.6.6  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.6.5  2000/01/06 18:43:42  king
--| Commented out maximum_pixmap_* from inheritance clause.
--|
--| Revision 1.20.6.4  2000/01/04 20:03:51  rogers
--| maximum_pixmap_height and maximum_pixmap_width are now undefined from ev_pixmapable_i.
--|
--| Revision 1.20.6.3  1999/12/09 03:15:05  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.20.6.2  1999/11/30 22:51:01  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.20.6.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.20.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
