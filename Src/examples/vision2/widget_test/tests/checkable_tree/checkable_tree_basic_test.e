indexing
	description: "Objects that test EV_CHECKABLE_TREE."
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

	tree: EV_CHECKABLE_TREE
		-- Widget that test is to be performed on.

end -- class CHECKABLE_TREE_BASIC_TEST
