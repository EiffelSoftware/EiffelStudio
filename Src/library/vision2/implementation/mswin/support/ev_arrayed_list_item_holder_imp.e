indexing
	description:
		" A particular type of item-holder that uses an arrayed-list to store%
		% the children. Mswin implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [G -> EV_ITEM]

obsolete "No longer used by Vision2."

inherit
	EV_ITEM_LIST_IMP [G]

end -- class EV_ARRAYED_LIST_ITEM_HOLDER_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.2.5  2000/08/03 17:59:09  rogers
--| Made obsolete.
--|
--| Revision 1.3.2.4  2000/08/02 22:46:27  rogers
--| Removed get_item and find_item_by_data. Added FIXME saying this class is
--| no longer required by Vision2.
--|
--| Revision 1.3.2.3  2000/06/12 20:36:08  rogers
--| Removed remove_all_items.
--|
--| Revision 1.3.2.2  2000/06/12 20:30:40  rogers
--| Removed FIXME to_be_reviewed. Comments, formatting. Removed commented out
--| ev_children as it is redundent.
--|
--| Revision 1.3.2.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.5.4.1  2000/04/03 18:16:37  brendel
--| Removed deferred redeclaration of ev_children.
--|
--| Revision 1.5  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.4  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.4.7  2000/02/01 20:36:08  king
--| Fixed arrayed list to use ASSIGN_ATTEMPT hack
--|
--| Revision 1.3.4.6  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.3.4.5  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.4.4  2000/01/19 20:08:37  rogers
--| Removed item, as it is now inherited from EV_ITEM_LIST_IMP.
--|
--| Revision 1.3.4.3  1999/12/17 17:16:35  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP.
--|
--| Revision 1.3.4.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP.
--| ev_item_holder_imp.e
--|
--| Revision 1.3.4.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
