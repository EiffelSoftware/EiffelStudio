--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tree-item container, gtk implementation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_HOLDER_IMP

inherit
	EV_TREE_ITEM_HOLDER_I

	EV_ITEM_HOLDER_IMP

--	EV_CONTAINER_IMP
--		-- Inheriting from container, because tree item and subtree
--		-- are widgets in gtk, although it is not a widget in
--		-- EiffelVision. This is just for implementation
--		-- reasons.

feature {EV_TREE_IMP, EV_TREE_ITEM_IMP} -- Implementation

	tree_parent_imp: EV_TREE_IMP
			-- This is the tree in which the tree items are.
			-- We need it to be able to update the `ev_children' array
			-- in EV_TREE, which contains all the tree items, when
			-- we add items under items.

	set_tree_parent_imp (tree_par_imp: EV_TREE_IMP) is
			-- set the `tree_parent_imp' to `tree_par_imp'.
		do
			tree_parent_imp := tree_par_imp
		end

feature {EV_TREE_ITEM_HOLDER_IMP} -- Implementation

	find_item_recursively_by_data (data: ANY): EV_TREE_ITEM is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		local
			list: ARRAYED_LIST [EV_ITEM_IMP]
			litem: EV_TREE_ITEM
		do
			from
				list := ev_children
				list.start
			until
				list.after or Result/= Void
			loop
				litem ?= list.item.interface
				if equal (data, litem.data) then
					Result ?= litem
				else
					Result ?= litem.find_item_recursively_by_data (data)
				end
				list.forth
			end
		end

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item' to the list
		deferred
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item' to the list
		deferred
		end

feature -- implementation

	widget: POINTER is
			-- Pointer to the Gtk object.
		deferred
		end

feature {EV_TREE_ITEM_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- List of the children.

end -- class EV_TREE_ITEM_HOLDER_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.6.4  2000/02/04 07:37:25  oconnor
--| unreleased
--|
--| Revision 1.15.6.3  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.15.6.2  2000/01/27 19:29:38  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
