indexing
	description: "Eiffel Vision tree item. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		redefine
			interface
		end
	
	EV_TREE_NODE_IMP
		redefine
			interface
		end

create
	make

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM
	
end -- class EV_TREE_ITEM_IMP

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
--| Revision 1.57  2001/06/07 23:08:02  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.28.4.7  2000/09/06 23:18:39  king
--| Reviewed
--|
--| Revision 1.28.4.6  2000/05/16 16:58:41  oconnor
--| moved bulk to ev_tree_node_i.e
--|
--| Revision 1.28.4.5  2000/05/10 23:59:58  king
--| Made tooltipable
--|
--| Revision 1.28.4.4  2000/05/09 22:55:59  king
--| Integrated selectable with tree item
--|
--| Revision 1.28.4.3  2000/05/08 22:13:16  king
--| Corrected is_selecred, add comment to set_selected
--|
--| Revision 1.28.4.2  2000/05/05 22:18:47  king
--| Implemented to use insert_i_th
--|
--| Revision 1.28.4.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.55  2000/05/02 18:55:19  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.54  2000/04/20 18:07:37  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.53  2000/04/12 18:49:55  brendel
--| Removed inheritance of EV_PICK_AND_DROPABLE_IMP (from EV_ITEM_IMP).
--| Removed inheritance of EV_C_UTIL (from EV_ANY_IMP).
--|
--| Revision 1.52  2000/04/07 22:35:53  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.51  2000/04/06 20:27:05  brendel
--| Uncommented list_widget.
--|
--| Revision 1.50  2000/04/06 02:04:30  brendel
--| Changed to comply with new EV_DYNAMIC_LIST_IMP.
--| Does not work yet!
--|
--| Revision 1.49  2000/04/04 20:50:19  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.48  2000/03/13 22:05:16  king
--| Added referencing handling for reorder child
--|
--| Revision 1.47  2000/03/10 23:51:57  king
--| Fixed dereferencing of list widget
--|
--| Revision 1.46  2000/03/08 22:21:41  king
--| Added set_parent_imp in addition/removal
--|
--| Revision 1.45  2000/03/01 23:41:57  king
--| Corrected select_callback, check falsed set_selection
--|
--| Revision 1.44  2000/03/01 18:09:22  oconnor
--| released
--|
--| Revision 1.43  2000/03/01 18:04:44  king
--| Changed on_select bug comment
--|
--| Revision 1.42  2000/02/29 22:28:55  king
--| Tidied up code, fixed gtk select callback bug
--|
--| Revision 1.41  2000/02/29 18:43:40  king
--| Tidied up code
--|
--| Revision 1.40  2000/02/29 00:57:41  king
--| Added fixme to set_selected
--|
--| Revision 1.39  2000/02/28 23:59:31  king
--| Added root_tree macro
--|
--| Revision 1.38  2000/02/26 01:27:46  king
--| Implemented to contain children even if item has no parent
--|
--| Revision 1.36  2000/02/24 20:52:13  king
--| Inheriting from pick and dropable
--|
--| Revision 1.35  2000/02/24 20:09:40  king
--| Added subtree handling on addition and removal of items
--|
--| Revision 1.34  2000/02/24 18:47:55  king
--| Redefined min_wid/hgt to avoid invariant violation that doesnt apply to
--| feature needed by the tree item
--|
--| Revision 1.33  2000/02/24 01:42:14  king
--| Implemented event handling
--|
--| Revision 1.32  2000/02/22 23:57:11  king
--| Added subtree_set boolean
--|
--| Revision 1.31  2000/02/22 21:36:42  king
--| Initial implementation to fit with new structure
--|
--| Revision 1.30  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.29  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.28.6.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.28.6.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.2.3  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.28.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
