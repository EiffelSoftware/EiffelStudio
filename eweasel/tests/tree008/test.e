class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			two_way_tree_is_equal
			two_way_tree_make
			two_way_tree_put_child
			two_way_tree_put_child_right
			two_way_tree_remove_left_child_1
			two_way_tree_remove_left_child_2
			two_way_tree_remove_right_child_1
			two_way_tree_remove_right_child_2
			two_way_tree_replace_child
			two_way_tree_prune_1
			two_way_tree_prune_2
			two_way_tree_prune_3
			two_way_tree_twl_merge_left
			two_way_tree_twl_merge_right
			
			two_way_tree_has_orig
			two_way_tree_make_orig
			two_way_tree_merge_tree_before_orig
			two_way_tree_prune_all_orig
			two_way_tree_put_child_orig
			two_way_tree_put_child_right_orig_1
			two_way_tree_put_child_right_orig_2
		end

	two_way_tree_is_equal
			-- If both trees are leaves, their items are not compared
			-- (because `is_empty' from TWO_WAY_LIST is renamed into `is_leaf' and selected).
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			create tree2.make (2)
			check not tree1.is_equal (tree2) end
		end

	two_way_tree_make
			-- Calling `make' not as a creation procedure can result in both `before' and `after' being True
			-- (if `after' was True before the call).	
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (2)
			tree.child_start
			check tree.child_after end
			tree.make (3)
		end

	two_way_tree_put_child
			-- If `n' has a parent and siblings, `put_child' does not remove its sibling links,
			-- which causes inconsistencies
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.put_front (2)
			tree1.put_front (3)
			create tree2.make (5)
			tree2.put_child (tree1.first_child)
		end

	two_way_tree_put_child_right
			-- If `n' has a parent and siblings, `put_child_right' does not remove its sibling links,
			-- which causes inconsistencies
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.put_front (2)
			tree1.put_front (3)
			create tree2.make (5)
			tree2.put_front (6)
			tree2.child_finish
			tree2.put_child_right (tree1.first_child)
		end

	two_way_tree_remove_left_child_1
			-- TWO_WAY_TREE.remove_left_child inherits stronger precondition from DYNAMIC_CHAIN than from DYNAMIC_TREE;
			-- As a result the precondition is violated unexpectedly for clients of DYNAMIC_TREE when the cursor is `before'.
			-- Note that the inherited preconditions should be or-ed, but they are not.
			-- If they were, `back' would fail inside `remove_left_child'.	
		local
			tree: DYNAMIC_TREE [INTEGER]
		do
			create {TWO_WAY_TREE [INTEGER]} tree.make (1)
			tree.put_child (create {TWO_WAY_TREE [INTEGER]}.make (2))
			tree.child_go_i_th (0)
			check not tree.child_isfirst end
			tree.remove_left_child
		end

	two_way_tree_remove_left_child_2
			-- TWO_WAY_TREE.remove_left_child inherits stronger precondition from DYNAMIC_CHAIN than from DYNAMIC_TREE;
			-- As a result the precondition is violated unexpectedly for clients of DYNAMIC_TREE for a leaf node.
			-- Note that the inherited preconditions should be or-ed, but they are not.
			-- If they were, `remove' would fail inside `remove_left_child'.	
		local
			tree: DYNAMIC_TREE [INTEGER]
		do
			create {TWO_WAY_TREE [INTEGER]} tree.make (1)
			tree.child_go_i_th (1)
			check not tree.child_isfirst end
			tree.remove_left_child
		end

	two_way_tree_remove_right_child_1
			-- TWO_WAY_TREE.remove_left_child inherits stronger precondition from DYNAMIC_CHAIN than from DYNAMIC_TREE;
			-- As a result the precondition is violated unexpectedly for clients of DYNAMIC_TREE when the cursor is `before'.
			-- Note that the inherited preconditions should be or-ed, but they are not.
			-- If they were, `forth' would fail inside `remove_left_child'.	
		local
			tree: DYNAMIC_TREE [INTEGER]
		do
			create {TWO_WAY_TREE [INTEGER]} tree.make (1)
			tree.put_child (create {TWO_WAY_TREE [INTEGER]}.make (2))
			tree.child_go_i_th (2)
			check not tree.child_islast end
			tree.remove_right_child
		end

	two_way_tree_remove_right_child_2
			-- TWO_WAY_TREE.remove_left_child inherits stronger precondition from DYNAMIC_CHAIN than from DYNAMIC_TREE;
			-- As a result the precondition is violated unexpectedly for clients of DYNAMIC_TREE for a leaf node.
			-- Note that the inherited preconditions should be or-ed, but they are not.
			-- If they were, `remove' would fail inside `remove_left_child'.	
		local
			tree: DYNAMIC_TREE [INTEGER]
		do
			create {TWO_WAY_TREE [INTEGER]} tree.make (1)
			tree.child_go_i_th (0)
			check not tree.child_islast end
			tree.remove_right_child
		end

	two_way_tree_replace_child
			-- Implementation removes current child,
			-- which moves the cursor to the one on the right,
			-- and then inserts the new one to the right instead of to the left.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (3)
			tree.put_front (2)
			tree.child_finish
			tree.replace_child (create {TWO_WAY_TREE [INTEGER]}.make (5))
		end

	two_way_tree_prune_1
			-- When deleting first child, its siblings don't forget about it and become inconsistent.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (3)
			tree.put_front (2)
			tree.prune (tree.first_child)
		end

	two_way_tree_prune_2
			-- When deleting last child, its siblings don't forget about it and become inconsistent.
			-- Different from `two_way_tree_prune_1' because the bug is in another branch.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (3)
			tree.put_front (2)
			tree.prune (tree.last_child)
		end
		
	two_way_tree_prune_3
			-- When deleting active child,
			-- sets `child' to its `left_sibling' after calling `bl_put_left',
			-- which results in `child' being Void without adjusting `before' or `after'.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (3)
			tree.put_front (2)
			tree.put_front (1)
			tree.child_go_i_th (2)
			tree.prune (tree.child)
		end

	two_way_tree_twl_merge_left
			-- `twl_merge_left' merges children, but does not adapt their parent links;
			-- should be hidden.
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.put_front (2)
			tree1.child_start
			create tree2.make (5)
			tree2.put_front (6)
			tree1.twl_merge_left (tree2)
			check tree1.first_child.parent = tree1 end
		end

	two_way_tree_twl_merge_right
			-- `twl_merge_right' merges children, but does not adapt their parent links;
			-- should be hidden.
		local
			tree1, tree2: TWO_WAY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.put_front (2)
			tree1.child_start
			create tree2.make (5)
			tree2.put_front (6)
			tree1.twl_merge_right (tree2)
			check tree1.last_child.parent = tree1 end
		end
		
	two_way_tree_has_orig
			-- Wrong postcondition
			-- because `is_empty' from TWO_WAY_LIST is renamed into `is_leaf' and selected.
		local
			tree: TWO_WAY_TREE [INTEGER]
			b: BOOLEAN
		do
			create tree.make (1)
			b := tree.has (1)
		end

	two_way_tree_make_orig
			-- Calling `make' not as a creation procedure sets `before' to True
			-- without adjusting `active'.	
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (2)
			tree.put_front (1)
			tree.child_go_i_th (2)
			tree.make (5)
		end

	two_way_tree_merge_tree_before_orig
			-- `merge_tree_before' does not have a precondition `other /= Current',
			-- but it calls `twl_merge_left' which has this precondition.
			-- The same problem exists in `merge_tree_after'.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (2)
			tree.child_start
			tree.merge_tree_before (tree)
		end
		
	two_way_tree_prune_all_orig
			-- Wrong postcondition `no_more_occurrences'
			-- because prune_all only removes children, and not nodes from the whole tree.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (1)
			tree.prune_all (1)
		end

	two_way_tree_put_child_orig
			-- Missing precondition:
			-- it should not be allowed to add Current to its own children.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_child (tree)
		end

	two_way_tree_put_child_right_orig_1
			-- Missing precondition:
			-- it should not be allowed to add Current's children to its children again.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (2)
			tree.child_start
			tree.put_child_right (tree.last_child)
		end

	two_way_tree_put_child_right_orig_2
			-- Missing precondition:
			-- it should not be allowed to add Current to its own children.
		local
			tree: TWO_WAY_TREE [INTEGER]
		do
			create tree.make (1)
			tree.put_front (2)
			tree.child_start
			tree.put_child_right (tree)
		end
		
end