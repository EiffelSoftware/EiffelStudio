indexing
	description:
		"EiffelVision tree node. Implementation interface.";
	status: "See notice at end of class."		
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_NODE_I

inherit
	EV_ITEM_I
		rename
			parent as old_parent
		export {NONE}
			old_parent
		redefine
			interface
		select
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_TREE_NODE_LIST_I
		rename
			interface as nl_interface
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_TREE_NODE_ACTION_SEQUENCES_I

feature -- Access

	parent: EV_TREE_NODE_CONTAINER is
			-- Parent of `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
				check
					result_not_void: Result /= Void
				end
			end
		end	

	parent_tree: EV_TREE is
			-- Root tree that holds `Current'.
		local
			parent_item: EV_TREE_NODE_I
		do
			Result ?= parent
			if Result = Void and then parent /= Void then
				parent_item ?= parent.implementation
				Result := parent_item.parent_tree
			end
		end

feature -- Status report

	is_selectable: BOOLEAN is
			-- May the `Current' be selected?
		do
			Result := parent_tree /= Void
		end

	is_expanded: BOOLEAN is
			-- is `Current' expanded ?
		require
			in_tree: parent_tree /= Void
		deferred
		end

feature -- Status setting

	set_expand (flag: BOOLEAN) is
			-- Expand `Current' if `flag', otherwise collapse it.
		require
			in_tree: parent_tree /= Void
			is_expandable: count > 0
		deferred
		ensure
			state_set: is_expanded = flag
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE

end -- class EV_TREE_NODE_I

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
--| Revision 1.4  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.3  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.8  2000/08/23 21:34:46  king
--| Added is_expandable precond to set_expand
--|
--| Revision 1.1.2.7  2000/08/17 22:18:21  rogers
--| parent is once again renamed to old_parent.
--|
--| Revision 1.1.2.6  2000/08/17 20:34:11  rogers
--| Removed fixme not_reviewed. Comments.
--|
--| Revision 1.1.2.5  2000/07/24 21:31:44  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.1.2.4  2000/05/18 23:13:51  rogers
--| formatting.
--|
--| Revision 1.1.2.3  2000/05/18 20:53:53  king
--| Reimplemented parent
--|
--| Revision 1.1.2.2  2000/05/16 18:00:13  king
--| Made compilable
--|
--| Revision 1.1.2.1  2000/05/16 16:53:05  oconnor
--| Mainly copied from ev_tree_item_i.e
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
