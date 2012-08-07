class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			tree_binary_representation
			tree_child_before
			tree_compare_objects_1
			tree_compare_objects_2
			tree_compare_references_1
			tree_compare_references_2
			tree_copy_1
			tree_copy_2
			tree_tree_is_equal_1
			tree_tree_is_equal_2
			tree_linear_representation
			tree_is_sibling_orig
			tree_valid_cursor_index
		end

	tree_binary_representation
			-- `binary_representation' is a function, but it has a side effect of moving the cursor.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
			i: INTEGER
		do
			create tree1.make (1)
			tree1.put_left_child (create {BINARY_TREE [INTEGER]}.make (2))
			tree1.put_right_child (create {BINARY_TREE [INTEGER]}.make (3))
			i := tree1.child_index
			tree2 := tree1.binary_representation
			check i = tree1.child_index end
		end

	tree_child_before
			-- `child_before' should accept negative indexes,
			-- or alternatively the invariant 0 <= child_index <= child_count + 1 should be maintained.
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_left_child (create {BINARY_TREE [INTEGER]}.make (2))
			tree.put_right_child (create {BINARY_TREE [INTEGER]}.make (3))
			tree.child_go_i_th (-1)
			check tree.child_before end
		end

	tree_compare_objects_1
			-- `compare_objects' for a tree node does not change `object_comparison' for its parent,
			-- which results in an inconsistent tree.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			tree1.put_left_child (tree2)
			tree2.compare_objects
			check tree1.object_comparison = tree2.object_comparison end
		end

	tree_compare_objects_2
			-- `compare_objects' for a tree node does not change `object_comparison' for its children,
			-- which results in an inconsistent tree.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			tree1.put_left_child (tree2)
			tree1.compare_objects
			check tree1.object_comparison = tree2.object_comparison end
		end

	tree_compare_references_1
			-- `compare_references' for a tree node does not change `object_comparison' for its parent,
			-- which results in an inconsistent tree.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.compare_objects
			create tree2.make (2)
			-- Adjusts `object_comparison' here:
			tree1.put_left_child (tree2)
			check tree1.object_comparison = tree2.object_comparison end
			-- But not here:
			tree2.compare_references
			check tree1.object_comparison = tree2.object_comparison end
		end

	tree_compare_references_2
			-- `compare_references' for a tree node does not change `object_comparison' for its children,
			-- which results in an inconsistent tree.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.compare_objects
			create tree2.make (2)
			-- Adjusts `object_comparison' here:
			tree1.put_left_child (tree2)
			check tree1.object_comparison = tree2.object_comparison end
			-- But not here:
			tree1.compare_references
			check tree1.object_comparison = tree2.object_comparison end
		end

	tree_copy_1
			-- If Current is a child of other, then other gets modified while copying and they are not equal at the end.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			tree1.put_left_child (tree2)
			tree2.copy (tree1)
		end

	tree_copy_2
			-- `copy' does not adjust `object_comparison' before calling `tree_copy'.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.compare_objects
			create tree2.make (2)
			tree2.put_left_child (create {BINARY_TREE [INTEGER]}.make (3))
			tree1.copy (tree2)
		end

	tree_tree_is_equal_1
			-- If both trees are leaves, their values are always compared with `~', regardless of `object_comparison'.
			-- (If trees are not leaves, then not).
		local
			tree1, tree2: BINARY_TREE [ANY]
		do
			create tree1.make (create {ANY})
			create tree2.make (create {ANY})
			check not tree1.object_comparison end
			check not tree2.object_comparison end
			check not tree1.is_equal (tree2) end
		end

	tree_tree_is_equal_2
			-- `tree_is_equal' does not take into account
			-- that if Current is a child of `other',
			-- then its child cursor is moved while comparing children of the initial nodes
			-- and falls off the child list unexpectedely.
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
			b: BOOLEAN
		do
			create tree1.make (1)
			create tree2.make (1)
			tree2.put_front (1)
			tree2.first_child.put_front (1)
			tree1.put_child (tree2)
			b := tree2.is_equal (tree1)
		end

	tree_linear_representation
			-- `linear_representation' is a function, but it modifies the cursor position.
		local
			tree: TWO_WAY_TREE [INTEGER]
			list: LINEAR [INTEGER]
			i: INTEGER
		do
			create tree.make (1)
			tree.put_front (2)
			tree.put_front (3)
			tree.child_start
			i := tree.child_index
			list := tree.linear_representation
			check tree.child_index = i end
		end
		
	tree_is_sibling_orig
			-- Wrong parentheses in the postcondition clause `same_parent'.
		local
			tree1, tree2: BINARY_TREE [INTEGER]
			b: BOOLEAN
		do
			create tree1.make (1)
			tree1.put_left_child (create {BINARY_TREE [INTEGER]}.make (2))
			create tree2.make (3)
			b := tree1.left_child.is_sibling (tree2)
		end

	tree_valid_cursor_index
			-- Wrong parentheses in the postcondition.
		local
			tree: BINARY_TREE [INTEGER]
			b: BOOLEAN
		do
			create tree.make (1)
			b := tree.valid_cursor_index (10)
		end
		
end