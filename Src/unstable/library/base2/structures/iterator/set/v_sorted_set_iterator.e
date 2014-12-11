note
	description: "Iterators over sorted sets."
	author: "Nadia Polikarpova"
	model: target, sequence, index

class
	V_SORTED_SET_ITERATOR [G]

inherit
	V_SET_ITERATOR [G]
		undefine
			off
		redefine
			copy,
			search_forth,
			search_back
		end

create {V_GENERAL_SORTED_SET}
	 make

feature {NONE} -- Initialization

	make (s: V_GENERAL_SORTED_SET [G]; t: V_BINARY_TREE [G])
			-- Create an iterator over `s'.
			-- (Passing `t' is needed to avoid violating invariant `iterator /= Void' when calling `s.tree')
		require
			valid_tree: t = s.tree
		do
			target := s
			create tree_iterator.make (target.tree)
		ensure
			target_effect: target = s
			index_effect: index = 0
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			modify: target, sequence, index
		do
			target := other.target
			tree_iterator := other.tree_iterator.twin
		ensure then
			target_effect: target = other.target
			index_effect: index = other.index
		end

feature -- Access

	target: V_GENERAL_SORTED_SET [G]
			-- Set to iterate over.

	item: G
			-- Item at current position.
		do
			Result := tree_iterator.item
		end

feature -- Measurement

	index: INTEGER
			-- Index of current position.
		do
			Result := tree_iterator.index
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			Result := tree_iterator.before
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			Result := tree_iterator.after
		end

	off: BOOLEAN
			-- Is current position off scope?
		do
			Result := tree_iterator.off
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			Result := tree_iterator.is_first
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := tree_iterator.is_last
		end

feature {V_GENERAL_SORTED_SET} -- Status report

	is_root: BOOLEAN
			-- Is cursor at root?
		do
			Result := tree_iterator.is_root
		end

	is_leaf: BOOLEAN
			-- Is cursor at leaf?
		require
			not_off: not off
		do
			Result := tree_iterator.is_leaf
		end

	has_left: BOOLEAN
			-- Does current node have a left child?
		require
			not_off: not off
		do
			Result := tree_iterator.has_left
		end

	has_right: BOOLEAN
			-- Does current node have a right child?
		require
			no_off: not off
		do
			Result := tree_iterator.has_right
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		do
			tree_iterator.start
		end

	finish
			-- Go to the last position.
		do
			tree_iterator.finish
		end

	forth
			-- Go one position forward.
		do
			tree_iterator.forth
		end

	back
			-- Go one position backward.
		do
			tree_iterator.back
		end

	go_before
			-- Go before any position of `target'.
		do
			tree_iterator.go_before
		end

	go_after
			-- Go after any position of `target'.
		do
			tree_iterator.go_after
		end

	search (v: G)
			-- Move to an element equivalent to `v'.
			-- (Use `target.equivalence'.)
		local
			c: detachable V_BINARY_TREE_CELL [G]
		do
			c := target.cell_equivalent (v)
			if c = Void then
				go_after
			else
				tree_iterator.go_to_cell (c)
			end
		end

	search_forth (v: G)
			-- Move to the first occurrence of `v' starting from current position.
			-- If `v' does not occur, move `off'.
			-- (Use reference equality.)
		do
			if before or (tree_iterator.active /= Void and then (target.less_equal (item, v) and not target.less_equal (v, item))) then
				search (v)
			end
			if tree_iterator.active /= Void and then v /= item then
				go_after
			end
		end

	search_back (v: G)
			-- Move to the last occurrence of `v' at or before current position.
			-- If `v' does not occur, move `before'.
			-- (Use reference equality.)
		do
			if after or (not off and then (target.less_equal (v, item) and not target.less_equal (item, v))) then
				search (v)
			end
			if after or (tree_iterator.active /= Void and then v /= item) then
				go_before
			end
		end

feature {V_GENERAL_SORTED_SET} -- Cursor movement

	up
			-- Move cursor up to the parent.
		require
			not_off: not off
		do
			tree_iterator.up
		end

	left
			-- Move cursor down to the left child.
		require
			not_off: not off
		do
			tree_iterator.left
		end

	right
			-- Move cursor down to the right child.
		require
			not_off: not off
		do
			tree_iterator.right
		end

	go_root
			-- Move cursor to the root.
		do
			tree_iterator.go_root
		end

feature {V_GENERAL_SORTED_SET} -- Extension

	extend_left (v: G)
			-- Add a left child with value `v' to the current node.
		require
			not_off: not off
			not_has_left: not has_left
		do
			tree_iterator.extend_left (v)
		end

	extend_right (v: G)
			-- Add a left child with value `v' to the current node.
		require
			not_off: not off
			not_has_right: not has_right
		do
			tree_iterator.extend_right (v)
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		local
			it: V_INORDER_ITERATOR [G]
		do
			if has_left and has_right then
				it := tree_iterator.twin
				forth
				it.put (item)
				tree_iterator.remove
				tree_iterator := it
			else
				it := tree_iterator.twin
				forth
				it.remove
			end
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	tree_iterator: V_INORDER_ITERATOR [G]
			-- Iterator over the underlying search tree of `target'.

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements	in `target'.
		note
			status: specification
		do
			Result := tree_iterator.sequence
		end

invariant
	 valid_tree: tree_iterator.target = target.tree

end
