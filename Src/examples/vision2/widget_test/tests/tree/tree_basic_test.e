indexing
	description: "Objects that test EV_TREE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			tree_item1, tree_item2: EV_TREE_ITEM
			
		do
			create tree
			tree.set_minimum_size (300, 300)
			create tree_item1.make_with_text ("level 1")
			tree.extend (tree_item1)
			create tree_item2.make_with_text ("Level 2")
			tree_item1.extend (tree_item2)
			create tree_item2.make_with_text ("Level 2")
			tree_item1.extend (tree_item2)
		
			widget := tree
		end
		
feature {NONE} -- Implementation

	tree: EV_TREE

end -- class TREE_BASIC_TEST
