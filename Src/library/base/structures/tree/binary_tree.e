indexing

	description:
		"Binary tree: each node may have a left child and a right child"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: binary_tree, tree, fixed_tree;
	representation: recursive, array;
	access: cursor, membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_TREE [G]

inherit
	CELL [G]
		undefine
			copy, is_equal
		end

	TREE [G]
		redefine
			parent,
			is_leaf,
			subtree_has,
			subtree_count,
			fill_list,
			child_remove,
			child_after,
			child_capacity,
			child_start,
			child_forth,
			clone_node
		end

create
	make

feature -- Initialization

	make (v: like item) is
			-- Create a root node with value `v'.
		do
			item := v
		ensure
			node_item: item = v
			is_root: is_root
			is_leaf: is_leaf
		end

feature -- Access

	parent: BINARY_TREE [G]
			-- Parent of current node

	child_index: INTEGER
			-- Index of cursor position

	left_child: like parent
			-- Left child, if any

	right_child: like parent
			-- Right child, if any

	left_item: like item is
			-- Value of left child
		require
			has_left: left_child /= Void
		do
			Result := left_child.item
		end

	right_item: like item is
			-- Value of right child
		require
			has_right: right_child /= Void
		do
			Result := right_child.item
		end

	first_child: like parent is
			-- Left child
		do
			Result := left_child
		end

	last_child: like parent is
			-- Right child
		do
			Result := right_child
		end

	child: like parent is
			-- Child at cursor position
		do
			inspect
				child_index
			when 1 then
				Result := left_child
			when 2 then
				Result := right_child
			else
				Result := Void
			end
		end

	child_cursor: ARRAYED_LIST_CURSOR is
			-- Current cursor position
		do
			create Result.make (child_index)
		end

	left_sibling: like parent is
			-- Left neighbor, if any
		do
			if parent.right_child = Current then
				Result := parent.left_child
			end
		end

	right_sibling: like parent is
			-- Right neighbor, if any
		do
			if parent.left_child = Current then
				Result := parent.right_child
			end
		end

feature -- Measurement

	arity: INTEGER is
			-- Number of children
		do
			if has_left then
				Result := Result + 1
			end
			if has_right then
				Result := Result + 1
			end
		ensure then
			valid_arity: Result <= child_capacity
		end

	child_capacity: INTEGER is 2
			-- Maximum number of children

feature -- Status report

	child_after: BOOLEAN is
			-- Is there no valid child position to the right of cursor?
		do
			Result := child_index >= child_capacity + 1
		end

	is_leaf, has_none: BOOLEAN is
			-- Are there no children?
		do
			Result := left_child = Void and right_child = Void
		end

	has_left: BOOLEAN is
			-- Has current node a left child?
		do
			Result := left_child /= Void
		ensure
			Result = (left_child /= Void)
		end

	has_right: BOOLEAN is
			-- Has current node a right child?
		do
			Result := right_child /= Void
		ensure
			Result = (right_child /= Void)
		end

	has_both: BOOLEAN is
			-- Has current node two children?
		do
			Result := left_child /= Void and right_child /= Void
		ensure
			Result = (has_left and has_right)
		end

feature	-- Cursor movement

	child_go_to (p: ARRAYED_LIST_CURSOR) is
			-- Move cursor to child remembered by `p'.
		do
			child_index := p.index
		end

	child_start is
			-- Move to first child.
		do
			if has_left then
				child_index := 1
			elseif has_right then
				child_index := 2
			else
				child_index := 0
			end
		end

	child_finish is
			-- Move cursor to last child.
		do
			child_index := arity
		end

	child_forth is
			-- Move cursor to next child.
		do
			child_index := child_index + 1
		end

	child_back is
			-- Move cursor to previous child.
		do
			child_index := child_index - 1
		end

	child_go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th child.
		do
			child_index := i
		end

feature -- Element change

	put_left_child (n: like parent) is
			-- Set `left_child' to `n'.
		require
			no_parent: n = Void or else n.is_root
		do
			if n /= Void then
				if object_comparison then
					n.compare_objects
				else
					n.compare_references
				end
			end
			if left_child /= Void then
				left_child.attach_to_parent (Void)
			end
			if n /= Void then
				n.attach_to_parent (Current)
			end
			left_child := n
		end

	put_right_child (n: like parent) is
			-- Set `right_child' to `n'.
		require
			no_parent: n = Void or else n.is_root
		do
			if n /= Void then
				if object_comparison then
					n.compare_objects
				else
					n.compare_references
				end
			end
			if right_child /= Void then
				right_child.attach_to_parent (Void)
			end
			if n /= Void then
				n.attach_to_parent (Current)
			end
			right_child := n
		end

	child_put, child_replace (v: like item) is
			-- Put `v' at current child position.
		local
			node: like Current
		do
			if child /= Void then
				if object_comparison then
					child.compare_objects
				else
					child.compare_references
				end
				child.put (v)
			else
				create node.make (v)
				if object_comparison then
					node.compare_objects
				end
				put_child (node)
			end
		end

	put_child, replace_child (n: like parent) is
			-- Put `n' at current child position.
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			n.attach_to_parent (Void)
			if not has_left and not has_right then
				child_index := 1
			end

			inspect
				child_index
			when 1 then
				put_left_child (n)
			when 2 then
				put_right_child (n)
			end
		end

feature -- Removal

	remove_left_child is
			-- Remove left child.
		do
			if left_child /= Void then
				left_child.attach_to_parent (Void)
			end
			left_child := Void
		ensure
			not has_left
		end

	remove_right_child is
			-- Remove right child.
		do
			if right_child /= Void then
				right_child.attach_to_parent (Void)
			end
			right_child := Void
		ensure
			not has_right
		end

	child_remove is
			-- Remove current child.
		do
			inspect
		 		child_index
			when 1 then
				left_child.attach_to_parent (Void)
				left_child := Void
			when 2 then
				right_child.attach_to_parent (Void)
				right_child := Void
			end
		end

	prune (n: like parent) is
			-- Prune `n' from child nodes.
		do
			if left_child = n then
				remove_left_child
			elseif right_child = n then
				remove_right_child
			end
		end

	wipe_out is
			-- Remove all children.
		do
			remove_left_child
			remove_right_child
		end

	forget_left is
			-- Forget left sibling.
		do
			if not is_root and then parent.right_child = Current then
				parent.remove_left_child
			end
		end

	forget_right is
			-- Forget right sibling.
		do
			if not is_root and then parent.left_child = Current then
				parent.remove_right_child
			end
		end

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-tree beginning at cursor position and
			-- having min (`n', `arity' - `child_index' + 1)
			-- children.
		do
			Result := new_tree
			if child_index <= 1 and child_index + n >= 1 and has_left then
				Result.put_left_child (left_child.duplicate_all)
			end
			if child_index <= 2 and child_index + n >= 2 and has_right then
				Result.put_right_child (right_child.duplicate_all)
			end
		end

	duplicate_all: like Current is
		do
			Result := new_tree
			if has_left then
				Result.put_left_child (left_child.duplicate_all)
			end
			if has_right then
				Result.put_right_child (right_child.duplicate_all)
			end
		end

feature {BINARY_TREE} -- Implementation

	fill_list (al: ARRAYED_LIST [G]) is
			-- Fill `al' with all the children's items.
		do
			if left_child /= Void then
				al.extend (left_child.item)
				left_child.fill_list (al)
			end
			if right_child /= Void then
				al.extend (right_child.item)
				right_child.fill_list (al)
			end
		end

feature {NONE} -- Implementation

	clone_node (n: like Current): like Current is
			-- Clone node `n'.
		do
			create Result.make (n.item)
			Result.copy_node (n)
		end

feature {TREE} -- Implementation

	copy_node (n: like Current) is
			-- Copy content of `n' except tree data into Current.
		do
			standard_copy (n)
			child_index := 0
			left_child := Void
			right_child := Void
			parent := Void
		end

feature {NONE} -- Implementation

	subtree_has (v: G): BOOLEAN is
			-- Does subtree contain `v'?
		do
			if left_child /= Void then
				Result := left_child.has (v)
			end
			if right_child /= Void and not Result then
				Result := right_child.has (v)
			end
		end

	subtree_count: INTEGER is
			-- Number of items in subtree
		do
			if left_child /= Void then
				Result := left_child.count
			end
			if right_child /= Void then
				Result := Result + right_child.count
			end
		end

	fill_subtree (other: TREE [G]) is
			-- Copy `other' to subtree.
		local
			l_other: like Current
		do
			l_other ?= other
			if l_other /= Void then
				if not l_other.is_leaf then
					put_left_child (l_other.left_child.duplicate_all)
				end
				if l_other.arity >= 2 then
					put_right_child (l_other.right_child.duplicate_all)
				end
			end
		end

	new_tree: like Current is
			-- New tree node
		do
			create Result.make (item)
			if object_comparison then
				Result.compare_objects
			end
		end

invariant

	tree_is_binary: child_capacity = 2

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class BINARY_TREE
