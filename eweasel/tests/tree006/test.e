class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			dynamic_tree_fill_subtree_1
			dynamic_tree_fill_subtree_2
		end
		
	dynamic_tree_fill_subtree_1
			-- `fill_subtree' assumes that Current and `other' have the same number of children,
			-- but if Current had children before, then now it has more,
			-- so cursor falls off the list of children of `other'.
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.put_front (2)
			create tree2.make (5)
			tree2.put_front (6)
			tree1.fill (tree2)
		end

	dynamic_tree_fill_subtree_2
			-- Uses `other.item' instead of `other.child_item' while copying child items from other,
			-- which results in just copying the value of the `other' node many times.
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (5)
			tree2.put_front (6)
			tree1.fill (tree2)
			check tree1.has (6) end
		end


end