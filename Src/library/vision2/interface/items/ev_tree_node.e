indexing	
	description: 
		"Node for use with EV_TREE."
	status: "See notice at end of class"
	keywords: "tree, item, leaf, node, branch"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_NODE

inherit
	EV_ITEM
		rename
			parent as old_parent
		export
			{NONE} old_parent
		redefine
			implementation,
			create_action_sequences
		end

	EV_TEXTABLE
		redefine
			implementation
		end

	EV_DESELECTABLE
		redefine
			implementation
		end

	EV_TOOLTIPABLE
		redefine
			implementation
		end

	EV_TREE_NODE_CONTAINER
		redefine
			implementation
		end

feature -- Access

	parent: EV_TREE_NODE_CONTAINER is
			-- Parent of the tree item
		do
			Result := implementation.parent
		end
	
	parent_tree: EV_TREE is
			-- Contains `Current'.
		do
			Result := implementation.parent_tree
		end

	find_item_recursively_by_data (v: ANY): EV_TREE_NODE is
			-- An item at any level in tree that has `data'.
		do
			Result := implementation.find_item_recursively_by_data (v)
		end

feature -- Status report

	is_expanded: BOOLEAN is
			-- Are items in `Current' displayed?
		require
			in_tree: parent_tree /= Void
		do
			Result := implementation.is_expanded
		end

feature -- Status setting

	expand is
			-- Set `is_expanded' `True'.
		require
			parent_tree_not_void: parent_tree /= Void
		do
			implementation.set_expand (True)
		ensure
			is_expanded: is_expanded
		end

	collapse is
			-- Set `is_expanded' `False'.
		require
			parent_tree_not_void: parent_tree /= Void
		do
			implementation.set_expand (False)
		ensure
			not_is_expanded: not is_expanded
		end

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when selected.

	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when deselected.

	expand_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when expanded.

	collapse_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when collapsed.

feature -- Contract support

	is_parent_recursive (a_list: EV_TREE_NODE): BOOLEAN is
			-- Is `a_list' `parent' or recursively `parent' of `parent'.
		local
			a_parent: EV_TREE_NODE
		do
			a_parent ?= parent
			Result := a_list = a_parent or else
			(a_parent /= Void and then a_parent.is_parent_recursive (a_list))
		end

feature {EV_ANY_I}-- Implementation

	implementation: EV_TREE_NODE_I
			-- Responsible for interaction with the native graphics toolkit.


feature {NONE} -- Implementation

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_ITEM} Precursor
			create select_actions
			create deselect_actions
			create expand_actions
			create collapse_actions
		end

end -- class EV_TREE_NODE

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
--| Revision 1.2  2000/06/07 17:28:05  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.3  2000/05/18 20:54:43  king
--| Reimplemented parent, is_parent_recursive
--|
--| Revision 1.1.2.2  2000/05/16 16:49:03  oconnor
--| Made king's changes from ev_tree_item 1.25.4.1->1.25.4.3:
--| Integrated selectable with tree item
--| Made tooltipable
--|
--| Revision 1.1.2.1  2000/05/16 16:32:52  oconnor
--| mainly moved from ev_tree_item.e
--|
--| Revision 1.43  2000/04/07 22:28:19  brendel
--| EV_SIMPLE_ITEM -> EV_ITEM.
--|
--| Revision 1.42  2000/04/07 22:15:41  brendel
--| Removed EV_SIMPLE_ITEM from inheritance hierarchy.
--|
--| Revision 1.41  2000/04/05 21:16:13  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.40  2000/04/04 21:37:52  oconnor
--| comments
--|
--| Revision 1.39.2.1  2000/04/03 18:09:05  brendel
--| Added is_parent_recursive.
--|
--| Revision 1.39  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.38  2000/03/17 00:01:26  king
--| Accounted for name change of tree_item_holder
--|
--| Revision 1.37  2000/03/09 21:40:12  king
--| Removed inheritence from PND
--|
--| Revision 1.36  2000/03/07 01:32:10  king
--| Now inheriting from ev_tree_item_holder
--|
--| Revision 1.35  2000/03/01 20:28:52  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.33  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.32  2000/03/01 18:09:03  oconnor
--| released
--|
--| Revision 1.31  2000/02/24 20:52:13  king
--| Inheriting from pick and dropable
--|
--| Revision 1.30  2000/02/24 20:12:26  king
--| Tidied up comments and tags
--|
--| Revision 1.29  2000/02/23 21:21:58  king
--| Added action sequences
--|
--| Revision 1.28  2000/02/22 21:40:29  king
--| Tidied up interface, now inherits from item_list
--|
--| Revision 1.27  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.26  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.25.6.3  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.25.6.2  1999/12/17 21:10:38  rogers
--| Now inherits EV_PICK_AND_DROPABLE instead of EV_PND_SOURCE and
--| EV_PND_TARGET. Make procedures have been removed, ready for
--| re-implementation. The addition and removal of commands have been commented,
--| ready for re-implementation.
--|
--| Revision 1.25.6.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.25.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.25.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
