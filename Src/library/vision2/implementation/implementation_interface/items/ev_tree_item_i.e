--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tree item, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_I

inherit
	EV_SIMPLE_ITEM_I
		redefine
			interface
		end

	EV_TREE_ITEM_HOLDER_I
		redefine
			interface
		end

feature -- Access

	parent_tree: EV_TREE is
			-- Root tree that parent is held within.
		local
			parent_item: EV_TREE_ITEM_IMP
		do
			Result ?= parent
			if Result = Void and then parent /= Void then
				parent_item ?= parent.implementation
				Result := parent_item.parent_tree
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		require
			in_tree: parent_tree /= Void
		deferred
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		require
			in_tree: parent_tree /= Void
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			in_tree: parent_tree /= Void
		deferred
		ensure
 			state_set: is_selected = flag
		end

	toggle is
			-- Change the state of selection of the item.
		require
			in_tree: parent_tree /= Void
		do
			set_selected (not is_selected)
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		require
			in_tree: parent_tree /= Void
			is_parent: count > 0
		deferred
		ensure
			state_set: is_expanded = flag
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I replaces EV_PND_SOURCE and EV_PND_TARGET. Added top_parent.
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
