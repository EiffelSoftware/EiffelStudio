indexing
	description: "Objects that test EV_CHECKABLE_TREE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHECKABLE_TREE_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			tree_item, tree_sub_item: EV_TREE_ITEM
		do
			create tree
			tree.set_minimum_size (300, 300)
			create tree_item.make_with_text ("Item 1")
			tree.extend (tree_item)
			create tree_item.make_with_text ("Item 2")
			tree.extend (tree_item)
			create tree_sub_item.make_with_text ("Sub Item 1")
			tree_item.extend (tree_sub_item)
			create tree_sub_item.make_with_text ("Sub Item 2")
			tree_item.extend (tree_sub_item)
			create tree_sub_item.make_with_text ("Sub Item 3")
			tree_item.extend (tree_sub_item)
			create tree_item.make_with_text ("Item 3")
			tree.extend (tree_item)
			tree.check_item (tree_item)
			widget := tree
		end
		
feature {NONE} -- Implementation

	tree: EV_CHECKABLE_TREE;
		-- Widget that test is to be performed on.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CHECKABLE_TREE_BASIC_TEST
