--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision tree. A tree show a hierarchy with%
		% several levels of items."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences,
			make_for_test
		end

	EV_TREE_NODE_LIST
		redefine
			implementation,
			create_action_sequences
		end

	EV_TREE_NODE_CONTAINER
		undefine
			off,
			index_of,
			has,
			occurrences,
			search,
			changeable_comparison_criterion
		redefine
			implementation
		end

create
	default_create,
	make_for_test

feature {EV_ANY} -- Contract support

	make_for_test is
		local
			t_item, t_item2, t_item3, t_item4, ti: EV_TREE_ITEM
			a_counter1, a_counter2, a_counter3: INTEGER
			dti: EV_DYNAMIC_TREE_ITEM
		do
			Precursor
			set_background_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
			from
				a_counter1 := 1
			until
				a_counter1 > 5
			loop
				create t_item
				extend (t_item)
				t_item.set_text ("Tree item " + a_counter1.out)
				from
					a_counter2 := 1
				until
					a_counter2 > 5
				loop
					t_item.extend (create {EV_TREE_ITEM})
					t_item.go_i_th (a_counter2)
					t_item.item.set_text ("Sub tree item " + a_counter2.out)
					from
						a_counter3 := 1
					until
						a_counter3 > 5
					loop
						ti ?= t_item.item
						ti.extend (create {EV_TREE_ITEM})
						ti.go_i_th (a_counter3)
						ti.item.set_text
							("Sub tree's sub tree item " + a_counter3.out)
						a_counter3 := a_counter3 + 1
					end
					a_counter2 := a_counter2 + 1
				end
				t_item.expand 
				a_counter1 := a_counter1 + 1
			end
			create t_item2.make_with_text 
				("First item of 'Tree item 5' after tests")
			create t_item3.make_with_text 
				("Third item of 'Tree item 5' after tests")
			t_item2.extend (t_item3)
			t_item2.start
			create t_item4.make_with_text 
				("Fifth item of 'Tree item 5' after tests")
			ti ?= t_item2.item
			ti.extend (t_item4)
			t_item.extend (t_item2)
			t_item.prune (t_item2)
			from
				t_item.start
			until
				t_item.off
			loop
				t_item.put_left (t_item2)
				t_item.prune (t_item2)
				if not t_item.off then
					t_item.forth
				end
			end
			t_item.put_front (t_item2)
			t_item2.prune (t_item3)
			t_item.go_i_th (3)
			t_item.put_left (t_item3)
			t_item.go_i_th (5)
			ti.prune (t_item4)
			t_item.replace (t_item4)
			create dti
			dti.set_text ("dynamic tree item")
			dti.set_subtree_function (~dynamic_subtree)
			extend (dti)
		end

	dynamic_subtree: LINKED_LIST [EV_TREE_NODE] is
		local
			dti: EV_DYNAMIC_TREE_ITEM
		do
			create Result.make
			create dti
			dti.set_text ("dynamic 1")
			dti.set_subtree_function (~dynamic_subtree)
			Result.extend (dti)
			create dti
			dti.set_text ("dynamic 2")
			dti.set_subtree_function (~dynamic_subtree)
			Result.extend (dti)
			create dti
			dti.set_text ("dynamic 3")
			dti.set_subtree_function (~dynamic_subtree)
			Result.extend (dti)
			create dti
			dti.set_text ("dynamic 4")
			dti.set_subtree_function (~dynamic_subtree)
			Result.extend (dti)
			create dti
			dti.set_text ("dynamic 5")
			dti.set_subtree_function (~dynamic_subtree)
			Result.extend (dti)
			create dti
			dti.set_text ("dynamic 6")
			dti.set_subtree_function (~dynamic_subtree)
			Result.extend (dti)
		end

feature -- Access

	selected_item: EV_TREE_NODE is
			-- Currently selected tree item.
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is one tree item selected ?
		require
		do
			Result := implementation.selected
		end

	pixmaps_width: INTEGER is
			-- Width of displayed pixmaps in the Multicolumn list.
		do
			Result := implementation.pixmaps_width
		ensure
			bridge_ok: Result = implementation.pixmaps_width
		end

	pixmaps_height: INTEGER is
			-- Height of displayed pixmaps in the Multicolumn list.
		do
			Result := implementation.pixmaps_height
		ensure
			bridge_ok: Result = implementation.pixmaps_height
		end

feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in the Multicolumn list.
			-- Note: The Default value is 16x16
		require
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			implementation.set_pixmaps_size (a_width, a_height)
		ensure
			width_set: pixmaps_width = a_width
			height_set: pixmaps_height = a_height
		end

feature -- Event handling

	select_actions: EV_TREE_ITEM_SELECT_ACTION_SEQUENCE
		-- Actions performed when a tree item is selected.

	deselect_actions: EV_TREE_ITEM_SELECT_ACTION_SEQUENCE
		-- Actions performed when a tree item is deselected.

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of tree
		do
			create {EV_TREE_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create the action sequences for the tree.
		do
			{EV_PRIMITIVE} Precursor
			{EV_TREE_NODE_LIST} Precursor
			create select_actions
			create deselect_actions
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_TREE_I	
			-- Platform dependent access.

end -- class EV_TREE

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
--| Revision 1.37  2000/06/07 17:28:13  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.14.4.9  2000/05/23 20:32:18  rogers
--| Replaced dynamic tree item into make_for_test.
--|
--| Revision 1.14.4.8  2000/05/18 20:56:53  king
--| Now inheriting from EV_TREE_NODE_CONTAINER
--|
--| Revision 1.14.4.7  2000/05/18 17:42:13  rogers
--| Removed EV_DYNAMIC_TREE_ITEM from make_for_test.
--|
--| Revision 1.14.4.6  2000/05/17 19:11:51  rogers
--| Fixed bug in make_for_test.
--|
--| Revision 1.14.4.5  2000/05/17 16:31:12  king
--| Corrected make_for_test
--|
--| Revision 1.14.4.4  2000/05/16 23:02:44  oconnor
--| more tests
--|
--| Revision 1.14.4.3  2000/05/16 16:55:46  oconnor
--| updated for EV_TREE_NODE, added dynamic tree test
--|
--| Revision 1.14.4.2  2000/05/04 17:42:57  brendel
--| Changed line where t_item3 was already removed from a container and then
--| tried to acces parent.
--|
--| Revision 1.14.4.1  2000/05/03 19:10:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.36  2000/05/03 18:14:25  oconnor
--| extended make_for_test
--|
--| Revision 1.35  2000/04/26 00:04:04  pichery
--| Slight redesign of the pixmap handling in
--| trees and multi-column lists.
--|
--| Added `set_pixmaps_size', `pixmaps_width'
--| and `pixmaps_height' in the interfaces and
--| in the implementations.
--|
--| Fixed bugs in multi-column lists and trees.
--|
--| Revision 1.34  2000/04/14 16:52:43  brendel
--| Added FIXME. Why is this item's parent not Void???
--|
--| Revision 1.33  2000/03/17 00:10:55  king
--| Corrected precursor call in create_act_seq
--|
--| Revision 1.32  2000/03/17 00:01:26  king
--| Accounted for name change of tree_item_holder
--|
--| Revision 1.31  2000/03/10 19:22:55  king
--| Corrected indentation in make_for_test
--|
--| Revision 1.30  2000/03/09 19:58:52  king
--| Removed multiple selection features
--|
--| Revision 1.29  2000/03/09 17:29:38  rogers
--| Improved tests in make_for_test.
--|
--| Revision 1.28  2000/03/07 01:33:12  king
--| Now inheriting from ev_tree_item_holder
--|
--| Revision 1.27  2000/03/06 20:16:23  king
--| Changed action sequence types
--|
--| Revision 1.26  2000/03/02 22:08:57  king
--| Made 80 cols or less
--|
--| Revision 1.24  2000/03/01 23:44:50  king
--| Changed selected_item post-condition to use lists_equal
--|
--| Revision 1.23  2000/03/01 19:48:54  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.22  2000/03/01 18:09:03  oconnor
--| released
--|
--| Revision 1.21  2000/03/01 03:26:55  oconnor
--| added make_for_test
--|
--| Revision 1.20  2000/02/29 00:03:38  king
--| Added multiple selection features
--|
--| Revision 1.19  2000/02/24 01:51:10  king
--| Added appropriate action sequences
--|
--| Revision 1.18  2000/02/22 23:58:44  king
--| Added selected_item
--|
--| Revision 1.17  2000/02/22 21:41:12  king
--| Tidied up interface, now inheriting from item_list
--|
--| Revision 1.16  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.15  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.6.4  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.6.3  2000/01/16 23:36:40  oconnor
--| formatting
--|
--| Revision 1.14.6.2  1999/12/17 19:23:32  rogers
--| the addition and removal of commands needs to be fixed so that they use the
--| new action sequences.
--|
--| Revision 1.14.6.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.14.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
