indexing
	description:
		"EiffelVision tree-item container, gtk implementation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_HOLDER_IMP

inherit
	EV_TREE_ITEM_HOLDER_I

	EV_CONTAINER_IMP
		-- Inheriting from container, because tree item and subtree
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

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

end -- class EV_TREE_ITEM_HOLDER_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
