--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
    description:
        "EiffelVision list item holder, implementation."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

deferred class
	EV_LIST_ITEM_HOLDER_IMP

inherit
	EV_ITEM_LIST_IMP [EV_LIST_ITEM]

end -- class EV_LIST_ITEM_HOLDER_IMP

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
--| Revision 1.8  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/05 21:16:09  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.6.4.1  2000/04/04 23:42:17  brendel
--| Unreleased.
--|
--| Revision 1.6  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/02/04 08:02:00  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/28 18:51:06  king
--| Changed to generic inheritence of ev_item_list_imp
--|
--| Revision 1.4.6.4  2000/01/27 19:29:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.3  1999/12/01 20:30:10  oconnor
--| removed ev_children
--|
--| Revision 1.4.6.2  1999/11/30 22:55:17  oconnor
--| rename widget -> c_object
--|
--| Revision 1.4.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
