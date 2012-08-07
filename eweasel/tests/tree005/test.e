class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			binary_tree_binary_representation
			binary_tree_child_remove
			binary_tree_put_child_1
			binary_tree_put_child_2
			binary_tree_fill_subtree
			binary_tree_make_1
			binary_tree_make_2
		end
		
	binary_tree_binary_representation
			-- When Current only has right_child, then "start; forth" skips to after (instead of to right child),
			-- because of how start is implemented; so the right child is never added to the Result.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.put_right_child (create {BINARY_TREE [INTEGER]}.make (2))
			tree2 := tree1.binary_representation
			check tree2.count = tree1.count end
		end

	binary_tree_child_remove
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.child_remove
		end

	binary_tree_put_child_1
			-- If there are no children, always moves the cursor to 1 (contrary to the header comment).
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			tree1.child_go_i_th (2)
			check not tree1.child_off end
			tree1.put_child (tree2)
			check tree1.right_child = tree2 end
		end

	binary_tree_put_child_2
			-- `put_child' is missing precondition `not child_off';
			-- (note: only fails if already has children;
			-- otherwise moves the cursor to 1 like in `binary_tree_put_child_1')
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_child (create {BINARY_TREE [INTEGER]}.make (2))
			tree.child_go_i_th (0)
			tree.put_child (create {BINARY_TREE [INTEGER]}.make (3))
		end

	binary_tree_fill_subtree
			-- Copies the right child only when both children are present
			-- (so a single right child is never copied).
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			-- This works:
			create tree1.make (1)
			create tree2.make (2)
			tree2.put_left_child (create {BINARY_TREE [INTEGER]}.make (3))
			tree1.fill (tree2)
			check tree1.has (3) end
			-- but this does not:
			create tree1.make (1)
			create tree2.make (2)
			tree2.put_right_child (create {BINARY_TREE [INTEGER]}.make (3))
			tree1.fill (tree2)
			check tree1.has (3) end
		end

	binary_tree_make_1
			-- When calling make not as a creation procedure,
			-- Current is not always root, contrary to the header comment.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			tree1.put_left_child (tree2)
			tree2.make (3)
		end

	binary_tree_make_2
			-- When calling make not as a creation procedure,
			-- Current is not always leaf (single node), contrary to the header comment.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			tree1.put_left_child (tree2)
			tree1.make (3)
		end

end