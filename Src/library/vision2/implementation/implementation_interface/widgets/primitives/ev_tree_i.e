--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision Tree. Implemenation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_TREE_ITEM_LIST_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize is
		do
				-- Set default width & height for the pixmaps
			pixmaps_width := 16
			pixmaps_height := 16
		end

feature -- Access

	selected_item: EV_TREE_ITEM is
			-- Tree item which is currently selected
		deferred
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one tree item selected ?
		require
		deferred
		end

	pixmaps_width: INTEGER
			-- Width of displayed pixmaps in the Multicolumn list.

	pixmaps_height: INTEGER
			-- Height of displayed pixmaps in the Multicolumn list.

feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in the Multicolumn list.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		end

feature {EV_ANY_I} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			-- Do nothing by default
		end

feature {EV_ANY_I}

	interface: EV_TREE

end -- class EV_TREE_I

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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.23  2000/04/26 00:02:44  pichery
--| Slight redesign of the pixmap handling in
--| trees and multi-column lists.
--|
--| Added `set_pixmaps_size', `pixmaps_width'
--| and `pixmaps_height' in the interfaces and
--| in the implementations.
--|
--| Fixed bugs in multi-column lists and trees.
--|
--| Revision 1.22  2000/03/17 00:01:26  king
--| Accounted for name change of tree_item_holder
--|
--| Revision 1.21  2000/03/09 19:57:38  king
--| Removed multiple selection features
--|
--| Revision 1.20  2000/03/07 01:31:39  king
--| Noe inheriting from ev_tree_item_holder_i
--|
--| Revision 1.19  2000/03/01 18:09:22  oconnor
--| released
--|
--| Revision 1.18  2000/02/29 00:02:53  king
--| Added multiple select features
--|
--| Revision 1.17  2000/02/22 23:57:58  king
--| Added selected_item
--|
--| Revision 1.16  2000/02/22 21:39:50  king
--| Removed redundant command association features, inheriting from item_list
--|
--| Revision 1.15  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.3  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.2  1999/12/17 17:47:15  rogers
--| Redefined interface to be of more refined type.
--|
--| Revision 1.13.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
