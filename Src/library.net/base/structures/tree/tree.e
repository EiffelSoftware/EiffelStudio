indexing
	description: "Trees, without commitment to a particular representation"
	class_type: Interface
	external_name: "ISE.Base.Tree"

deferred class	
	TREE [G] 

inherit
	CONTAINER [G]

feature -- Access

	parent: TREE [G] is
		indexing
			description: "Parent of current node"
		deferred
		end

	child: TREE [G] is
		indexing
			description: "Current child node"
		require
			readable: readable_child
		deferred
		end

	item: G is
		indexing
			description: "Item in current node"
		deferred
		end

	child_item: G is
		indexing
			description: "Item in current child node"
		require
			readable: child_readable
		deferred
		end

	child_cursor: CURSOR is
		indexing
			description: "Current cursor position"
		deferred
		end

	child_index: INTEGER is
		indexing
			description: "Index of current child"
		deferred
		ensure
			valid_index: Result >= 0 and Result <= arity + 1
		end

	first_child: TREE [G] is
		indexing
			description: "Leftmost child"
		require
			is_not_leaf: not is_leaf
		deferred
		end

	last_child: TREE [G] is
		indexing
			description: "Right most child"
		require
			is_not_leaf: not is_leaf
		deferred
		end

	left_sibling: TREE [G] is
		indexing
			description: "Left neighbor (if any)"
		require
			is_not_root: not is_root
		deferred
		ensure
			is_sibling: Result /= Void implies is_sibling (Result)
			right_is_current: (Result /= Void) implies (Result.right_sibling = Current)
		end

	right_sibling: TREE [G] is
		indexing
			description: "Right neighbor (if any)"
		require
			is_not_root: not is_root
		deferred
		ensure
			is_sibling: Result /= Void implies is_sibling (Result)
			left_is_current: (Result /= Void) implies (Result.left_sibling = Current)
		end

	is_sibling (other: TREE [G]): BOOLEAN is
		indexing
			description: "Are current node and `other' siblings?"
		require
			other_exists: other /= Void
		deferred
		ensure
			not_root: Result implies not is_root
			other_not_root: Result implies not other.is_root
			same_parent: Result = not is_root and other.parent = parent
		end

feature -- Measurement

	arity: INTEGER is
		indexing
			description: "Number of children"
		deferred
		end

	count: INTEGER is
		indexing
			description: "Number of items"
		deferred
		end

feature -- Status report

	readable: BOOLEAN is 
		indexing
			description: "Is there a current item to be read?"
		deferred
		end
		
	child_readable: BOOLEAN is
		indexing
			description: "Is there a current `child_item' to be read?"
		deferred
		end

	readable_child: BOOLEAN is
		indexing
			description: "Is there a current child to be read?"
		deferred
		end

	writable: BOOLEAN is
		indexing
			description: "Is there a current item that may be modified?"
		deferred
		end
		
	child_writable: BOOLEAN is
		indexing
			description: "Is there a current `child_item' that may be modified?"
		deferred
		end

	writable_child: BOOLEAN is
			-- Is there a current child that may be modified?
		deferred
		end

	child_off: BOOLEAN is
		indexing
			description: "Is there no current child?"
		deferred
		end

	child_before: BOOLEAN is
		indexing
			description: "Is there no valid child position to the left of cursor?"
		deferred
		end

	child_after: BOOLEAN is
		indexing
			description: "Is there no valid child position to the right of cursor?"
		deferred
		end

	is_leaf: BOOLEAN is
		indexing
			description: "Are there no children?"
		deferred
		end

	is_root: BOOLEAN is
		indexing
			description: "Is there no parent?"
		deferred
		end

	child_isfirst: BOOLEAN is
		indexing
			description: "Is cursor under first child?"
		deferred
		ensure
			not_is_leaf: Result implies not is_leaf
		end

	child_islast: BOOLEAN is
		indexing
			description: "Is cursor under last child?"
		deferred
		ensure
			not_is_leaf: Result implies not is_leaf
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' correctly bounded for cursor movement?"
		deferred
		ensure
			valid_cursor_index_definition: Result = (i >= 0) and (i <= arity + 1)
		end

feature -- Cursor movement

	child_go_to (p: CURSOR) is
		indexing
			description: "Move cursor to position `p'."
		deferred
		end

	child_start is
		indexing
			description: "Move cursor to first child."
		deferred
		ensure then
			is_first_child: not is_leaf implies child_isfirst
		end

	child_finish is
		indexing
			description: "Move cursor to last child."
		deferred
		ensure then
			is_last_child: not is_leaf implies child_islast
		end

	child_forth is
		indexing
			description: "Move cursor to next child."
		deferred
		end

	child_back is
		indexing
			description: "Move cursor to previous child."
		deferred
		end

	child_go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th child."
		require else
			valid_cursor_index: valid_cursor_index (i)
		deferred
		ensure then
			position: child_index = i
		end

feature -- Element change

	sprout is
		indexing
			description: "Make current node a root."
		deferred
		end

	put (v: G) is
		indexing
			description: "Replace element at cursor position by `v'."
		require
			is_writable: writable
		deferred
		ensure
			item_inserted: item = v
		end

	replace (v: G) is
		indexing
			description: "Replace element at cursor position by `v'."
		require
			is_writable: writable
		deferred
		ensure
			item_inserted: item = v
		end
		
	child_put (v: G) is
		indexing
			description: "Put `v' at current child position."
		require
			child_writable: child_writable
		deferred
		ensure
			item_inserted: child_item = v
		end

	child_replace (v: G) is
		indexing
			description: "Put `v' at current child position."
		require
			child_writable: child_writable
		deferred
		ensure
			item_inserted: child_item = v
		end
		
	replace_child (n: TREE [G]) is
		indexing
			description: "Put `n' at current child position."
		require
			writable_child: writable_child
			was_root: n.is_root
		deferred
		ensure
			child_replaced: child = n
		end

	prune (n: TREE [G]) is
		indexing
			description: "Remove `n' from the children"
		require
			is_child: n.parent = Current
		deferred
		ensure
			n_is_root: n.is_root
		end

	fill (other: TREE [G]) is
		indexing
			description: "[
						Fill with as many items of `other' as possible.
						The representations of `other' and current node
						need not be the same.
					  ]"
		deferred
		end

feature -- Conversion

	binary_representation: BINARY_TREE[G] is
		indexing
			description: "[
						Convert to binary tree representation:
						first child becomes left child,
						right sibling becomes right child.
					  ]"
		deferred
		ensure
			Result_is_root: Result.is_root
			Result_has_no_right_child: not Result.has_right
		end

feature -- Duplication

	duplicate (n: INTEGER): TREE [G] is
		indexing
			description: "[
						Copy of sub-tree beginning at cursor position and
						having min (`n', `arity' - `child_index' + 1)
						children.
					  ]"
		require
			not_child_off: not child_off
			valid_sublist: n >= 0
		deferred
		end

feature {TREE} -- Implementation

	subtree_has (v: G): BOOLEAN is
		indexing
			description: "[
						Do children include `v'?
 						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		deferred
		end

	subtree_count: INTEGER is
		indexing
			description: "Number of items in children"
		deferred
		end

	fill_list (al: ARRAYED_LIST [G]) is
		indexing
			description: "Fill `al' with all the children's items."
		deferred
		end

	attach_to_parent (n: TREE [G]) is
		indexing
			description: "Make `n' parent of current node."
		deferred
		ensure
			new_parent: parent = n
		end

	fill_subtree (s: TREE [G]) is
		indexing
			description: "Fill children with children of `other'."
		deferred
		end

feature {NONE} -- Implementation

	remove is
		indexing
			description: "Remove current item"
		deferred
		end

	child_remove is
		indexing
			description: "Remove item of current child"
		deferred
		end

--invariant

--	leaf_definition: is_leaf = (arity = 0)
--	child_off_definition: child_off = child_before or child_after
--	child_before_definition: child_before = (child_index = 0)
--	child_isfirst_definition: child_isfirst = (not is_leaf and child_index = 1)
--	child_islast_definition: child_islast = (not is_leaf and child_index = arity)
--	child_after_definition: child_after = (child_index >= arity + 1)
--	child_consistency: child_readable implies child.parent = Current

end -- class TREE



