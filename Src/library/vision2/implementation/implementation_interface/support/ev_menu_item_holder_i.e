indexing
	description: 
		"EiffelVision menu item container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_HOLDER_I

obsolete
	"This class is no longer required by Vision2."

inherit
	EV_ITEM_LIST_I [EV_MENU_ITEM]

feature -- Element change

	ev_children: ARRAYED_LIST [EV_ITEM_IMP] is
		deferred
		end

end -- class EV_MENU_ITEM_HOLDER_I

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
--| Revision 1.15  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.4.2  2000/08/18 16:27:38  rogers
--| Removed fixme not_reviewed. Removed commented features. Made obsolete.
--|
--| Revision 1.12.4.1  2000/05/03 19:09:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/02/22 18:39:42  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.6  2000/02/04 04:04:54  oconnor
--| released
--|
--| Revision 1.12.6.5  2000/01/29 01:05:01  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.12.6.4  2000/01/27 19:29:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.3  1999/12/17 18:40:40  rogers
--| add_item and remove_item are no longer required.
--|
--| Revision 1.12.6.2  1999/11/30 22:49:16  oconnor
--| renamed EV_ITEM_HOLDER_I to EV_ITEM_LIST_I
--|
--| Revision 1.12.6.1  1999/11/24 17:30:07  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.3  1999/11/04 23:10:36  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
