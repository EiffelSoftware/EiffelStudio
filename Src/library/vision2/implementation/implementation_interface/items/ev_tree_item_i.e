indexing
	description:
		"EiffelVision tree item. Implementation interface.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_I

inherit
	EV_TREE_NODE_I
		redefine
			interface
		end

	EV_TREE_NODE_LIST_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM

end -- class EV_TREE_ITEM_I

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
--| Revision 1.36  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.35  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.22.4.5  2000/08/17 20:21:58  rogers
--| Removed fixme not_reviewed. Description.
--|
--| Revision 1.22.4.4  2000/05/16 16:58:09  oconnor
--| moved bulk to ev_tree_node_i.e
--|
--| Revision 1.22.4.3  2000/05/10 23:59:59  king
--| Made tooltipable
--|
--| Revision 1.22.4.2  2000/05/09 22:56:00  king
--| Integrated selectable with tree item
--|
--| Revision 1.22.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.33  2000/04/07 22:10:00  brendel
--| EV_SIMPLE_ITEM_I -> EV_ITEM_I & EV_TEXTABLE_I.
--|
--| Revision 1.32  2000/03/17 00:01:26  king
--| Accounted for name change of tree_item_holder
--|
--| Revision 1.31  2000/03/09 21:37:12  king
--| Removed inheritence from PND, now in simple item
--|
--| Revision 1.30  2000/03/07 01:28:50  king
--| Now inheriting from ev_tree_item_holder_i
--|
--| Revision 1.29  2000/03/01 18:09:22  oconnor
--| released
--|
--| Revision 1.28  2000/02/26 01:29:16  king
--| Correctly implemented parent_tree
--|
--| Revision 1.27  2000/02/24 20:52:13  king
--| Inheriting from pick and dropable
--|
--| Revision 1.26  2000/02/24 20:11:48  king
--| Changed comment in parent_tree
--|
--| Revision 1.25  2000/02/22 21:38:35  king
--| Removed redundant command association features, inheriting from item_list
--|
--| Revision 1.24  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.23  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.3  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.2  1999/12/17 19:06:03  rogers
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I
--| replaces EV_PND_SOURCE and EV_PND_TARGET. Added top_parent.
--|
--| Revision 1.22.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
