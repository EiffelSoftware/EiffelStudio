indexing
	description: "Eiffel Vision tree item. Mswindows implementation."
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
		undefine
			parent
		redefine
			interface,
			set_tooltip
		end

create
	make

feature {NONE} -- Implementation

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
				-- Assign `a_tooltip' to `tooltip'.
			tooltip := clone (a_tooltip)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM

end -- class EV_TREE_ITEM_IMP

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


--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.72  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.71  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.70  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.24.4.12  2000/12/20 19:00:50  rogers
--| Removed redundent_code from set_tooltip.
--|
--| Revision 1.24.4.11  2000/12/19 18:11:49  pichery
--| Removed unused local variable.
--|
--| Revision 1.24.4.10  2000/11/17 00:40:30  rogers
--| ev_tool_bar_button_imp.e
--|
--| Revision 1.24.4.9  2000/10/19 23:17:45  rogers
--| Removed one of the two fixmes relating to the same bug.
--|
--| Revision 1.24.4.8  2000/08/11 19:16:06  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.24.4.7  2000/07/20 22:57:30  rogers
--| Aded fixme in set_tooltip.
--|
--| Revision 1.24.4.5  2000/06/12 18:36:43  rogers
--| Revied, comments, formatting.
--|
--| Revision 1.24.4.4  2000/05/16 20:19:43  king
--| Converted to new tree item structure
--|
--| Revision 1.24.4.3  2000/05/11 00:03:38  king
--| Made tooltipable
--|
--| Revision 1.24.4.2  2000/05/09 23:00:08  king
--| Accounted for deselectable integration
--|
--| Revision 1.24.4.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.68  2000/04/27 23:16:27  rogers
--| Undefined check_drag_and_drop_release from EV_ARRAYED_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.67  2000/04/26 04:05:20  pichery
--| EV_IMAGE_LIST_IMP.add_pixmap now
--| takes an EV_PIXMAP as parameter.
--| -->Adapting
--|
--| Revision 1.66  2000/04/26 00:03:10  pichery
--| Slight redesign of the pixmap handling in
--| trees and multi-column lists.
--|
--| Added `set_pixmaps_size', `pixmaps_width'
--| and `pixmaps_height' in the interfaces and
--| in the implementations.
--|
--| Fixed bugs in multi-column lists and trees.
--|
--| Revision 1.65  2000/04/25 01:16:35  pichery
--| Changed the handling of pixmaps.
--|
--| Revision 1.64  2000/04/21 21:54:55  rogers
--| Removed set_capture, release_capture, set_heavy_capture,
--| release_heavy_capture and set_pointer_style.
--|
--| Revision 1.63  2000/04/14 23:24:26  rogers
--| Removed re-definition of pnd_press as now only
--| set_pnd_original_parent is redefined.
--|
--| Revision 1.62  2000/04/14 21:33:44  rogers
--| Redefined pnd_press to call top_parent_imp.
--|
--| Revision 1.61  2000/04/14 17:37:15  rogers
--| Pnd_press is now inherited from EV_ITEM_IMP, previously
--| EV_ARRAYED_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.60  2000/04/11 19:04:02  rogers
--| Insert_item and remove_item no longer modify ev_children.
--|
--| Revision 1.59  2000/04/11 17:10:03  rogers
--| Removed pnd_press.
--|
--| Revision 1.58  2000/04/10 18:28:09  brendel
--| Modified creation sequence.
--|
--| Revision 1.57  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.56  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.55  2000/03/30 19:51:58  rogers
--| Changed all instances of:
--| 	set_source_true -> set_parent_source_true
--| 	set_pnd_child_source -> set_item_source
--| 	set_t_item_true -> set_item_source_true
--|
--| Revision 1.54.2.1  2000/04/03 18:07:52  brendel
--| Removed count.
--|
--| Revision 1.54  2000/03/30 18:31:58  rogers
--| Improved comments, added pre-conditions, added invariant
--|
--| Revision 1.53  2000/03/29 20:36:26  brendel
--| Modified text handling in compliance with new EV_TEXTABLE_IMP.
--|
--| Revision 1.52  2000/03/29 06:59:49  pichery
--| Improved the add of pixmaps in an item.
--|
--| Revision 1.51  2000/03/28 22:52:42  rogers
--| Fixed index alteration bug in orphaning a sub tree structure.
--| Simplified on_orphaned.
--|
--| Revision 1.50  2000/03/28 18:39:43  rogers
--| Pnd_press now uses top_parent_imp when retrieveing the parent.
--| Previously used parent_imp which was wrong.
--|
--| Revision 1.49  2000/03/28 17:32:23  rogers
--| on_orphaned now only reduces high indices if an image was removed
--| from the image list.
--|
--| Revision 1.48  2000/03/28 01:11:02  rogers
--| Added reduce_image_list_references.
--|
--|
--| Revision 1.47  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.46  2000/03/27 23:11:25  rogers
--| Formatting.
--|
--| Revision 1.42  2000/03/24 20:51:52  rogers
--| Added on_parented and set_pixmap_in_parent. This allows the pixmaps to be 
--| set before parenting the items.
--|
--| Revision 1.41  2000/03/24 19:16:20  rogers
--| Redefined initialize from EV_ARRAYED_LIST_ITEM_HOLDER_IMP. Removed 
--| commented PND inheritence.
--|
--| Revision 1.40  2000/03/24 17:15:36  rogers
--| Added tree_view_pixmap_height, tree_view_pixmap_width, and fixed 
--| set_pixmap so that repeated icons are shared internally in the image list.
--|
--| Revision 1.39  2000/03/24 00:18:01  rogers
--| Implemented set_pixmap.
--|
--| Revision 1.38  2000/03/22 20:23:05  rogers
--| Removed repeated inheritance from EV_PICK_AND_DROPABLE_IMP. Added 
--|pnd_press and set_pointer_style.
--|
--| Revision 1.37  2000/03/17 23:25:18  rogers
--| Undefined set_pointer_style from EV_PICK_AND_AND_DROPABLE_IMP.
--|
--| Revision 1.36  2000/03/15 17:56:29  rogers
--| Removed old command association.
--|
--| Revision 1.35  2000/03/13 20:51:43  rogers
--| Added relative position which returns position of `Current' in relation 
--|to the tree.
--|
--| Revision 1.34  2000/03/09 20:24:51  rogers
--| Added text coment, removed add_item and removed commented lines from count.
--|
--| Revision 1.33  2000/03/09 17:28:33  rogers
--| Removed redundent commented code. Insert item now uses pos - 1 correctly,
--| instead of index when the insertion position is not one.
--|
--| Revision 1.31  2000/03/08 17:33:44  rogers
--| Set_text from WEL_TREE_VIEW is now redefined. Redundent make_with_text has
--| been removed. Set text now sets the text to a clone of the passed text. 
--| All calls to general_insert_item now take an index.
--|
--| Revision 1.30  2000/03/07 17:43:18  rogers
--| Now inherits from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM] instead 
--| of EV_TREE_ITEM_HOLDER_IMP. The same type change has been implemented for
--| parent_imp, and insert item now takes EV_TREE_ITEM_IMP instead of 
--| like item_type.
--|
--| Revision 1.29  2000/03/06 21:10:21  rogers
--| Is_initialized is now set to true in initialization, and internal_children
--| is created. Re-implemented parent_imp.
--|
--| Revision 1.28  2000/03/06 19:07:22  rogers
--| Added text and also top_parent_imp which returns the implementation of 
--| parent_tree. Set text no longer calls the EV_SIMPLE_ITEM_IMP Precursor.
--|
--| Revision 1.27  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.4  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.24.6.3  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.2  1999/12/17 17:29:52  rogers
--| Altered to fit in with the review branch. Make takes an interface. Now
--| inherits from EV_PICK_AND_dROPABLE_IMP.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
