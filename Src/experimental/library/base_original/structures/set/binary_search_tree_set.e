note

	description:
		"Sorted sets implemented as binary search trees"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: binary_search_tree_set, set, binary_search_tree;
	representation: recursive, array;
	access: membership, min, max;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class BINARY_SEARCH_TREE_SET [G -> COMPARABLE] inherit

	COMPARABLE_SET [G]
		redefine
			min, max, has, off
		end

	TRAVERSABLE_SUBSET [G]

create

	make

feature -- Initialization

	make
			-- Create set.
		do
			before := True
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in tree
		do
			if tree /= Void then
				Result := tree.count
			end
		end

	min: like item
			-- Minimum item in tree
		do
			Result := tree.min
		end

	max: like item
			-- Maximum item in tree
		do
			Result := tree.max
		end

	item: G
			-- Current item
		do
			Result := active_node.item
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is set empty?
		do
			Result := tree = Void
		end

	extendible: BOOLEAN = True
		-- Can new items be added? (Answer: yes.)

	prunable: BOOLEAN = True
		-- Can items be removed? (Answer: yes.)

	after: BOOLEAN
		-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN
		-- Is there no valid cursor position to the left of cursor?

	has (v: like item): BOOLEAN
			-- Is there a node with item `v' in tree?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			if tree /= Void then
				Result := tree.has (v)
			end
		end

	off: BOOLEAN
			-- Is there no current item?
			-- `off' only if tree `is_empty' or if
			-- it is `before' or `after'.
		do
			Result := is_empty or Precursor {COMPARABLE_SET}
		end

feature -- Cursor movement

	start
			-- Move cursor to first node.
		do
			before := False
			if tree = Void then
				after := True
			else
				after := False
				active_node := tree.min_node
			end
		end

	finish
			-- Move cursor to last node.
		do
			after := False
			if tree = Void then
				before := True
			else
				before := False
				active_node := tree.max_node
			end
		end

	forth
			-- Move cursor to next node.
		local
			prev_node: like tree
		do
			if before then
				before := False
				if is_empty then
					after:= True
				end
			else
				if active_node.has_right then
					active_node := 	active_node.right_child.min_node
				else
					prev_node := active_node
					active_node := active_node.parent
					from
					until
						active_node = Void
						or else prev_node = active_node.left_child
					loop
						prev_node := active_node
						active_node := active_node.parent
					end
					if active_node = Void then
						active_node := tree
						after := True
					end
				end
			end
		end

	back
			-- Move cursor to previous node.
		local
			prev_node: like tree
		do
			if after then
				after := False
				if is_empty then
					before:= True
				end
			else
				if active_node.has_left then
					active_node := 	active_node.left_child.max_node
				else
					prev_node := active_node
					active_node := active_node.parent
					from
					until
						active_node = Void
						or else prev_node = active_node.right_child
					loop
						prev_node := active_node
						active_node := active_node.parent
					end
					if active_node = Void then
						active_node := tree
						before := True
					end
				end
			end
		end

feature -- Element change

	put, extend (v: like item)
			-- Put `v' at proper position in set
			-- (unless one already exists).
		require else
			item_exists: v /= Void
		do
			if tree = Void then
				tree := new_tree (v)
			else
				if not has (v) then
					tree.extend (v)
				end
			end
		end

feature -- Removal

	wipe_out
			-- Remove all items.
		do
			tree := Void
		end

	prune (v: like item)
			-- Remove `v'.
		do
			if tree /= Void then
				tree := tree.pruned (v, tree.parent)
			end
		end

	remove
			-- Remove current item.
		do
			prune (item)
		end

feature -- Duplication

	duplicate (n: INTEGER): BINARY_SEARCH_TREE_SET [G]
			-- New structure containing min (`n', `count')
			-- items from current structure
		do
			create Result.make
			Result.set_tree (tree.duplicate (n))
		end

feature {BINARY_SEARCH_TREE_SET} -- Implementation

	tree: BINARY_SEARCH_TREE [G]

	active_node: like tree

	set_tree (t: like tree)
			-- Set `tree' and `active_node' to `t'
		do
			tree := t
			active_node := t
		end

feature {NONE} -- Implementation

	new_tree (v: like item): like tree
			-- New allocated node with `item' set to `v'
		do
			create Result.make (v)
			if object_comparison then
				Result.compare_objects
			end
		end

	subset_strategy_selection (v: G; other: TRAVERSABLE_SUBSET [G]): 
								SUBSET_STRATEGY [G]
			-- Strategy to calculate several subset features selected depending
			-- on the dynamic type of `v' and `other'
		local
			h: HASHABLE
		do
			h ?= v
			if h /= Void then
				create {SUBSET_STRATEGY_HASHABLE [G]} Result
			elseif object_comparison and same_type (other) then
				create {SUBSET_STRATEGY_TREE [G]} Result
			else
				create {SUBSET_STRATEGY_GENERIC [G]} Result
			end
		end

invariant

	comparison_mode_equal: tree /= Void implies
				object_comparison = tree.object_comparison

note
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







end -- class BINARY_SEARCH_TREE_SET
