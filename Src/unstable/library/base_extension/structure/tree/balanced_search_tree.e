note
	description: "Balanced search trees."
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BALANCED_SEARCH_TREE [G -> COMPARABLE]

inherit
	TREE [G]
		rename
			has as tree_has,
			put as tree_put,
			prune as prune_tree
		export {NONE}
			child_put,
			child_replace,
			empty,
			put_child,
			replace,
			replace_child,
			sprout,
			tree_has,
			tree_put
		redefine
			changeable_comparison_criterion,
			child_writable,
			parent,
			writable_child,
			item,
			is_stable
		end

feature -- Access

	parent: detachable like Current
		-- Parent of current node

	item: G
			-- Item in current node
		deferred
		end

feature -- Measurement

	min: like item
			-- Minimum item stored in tree
		require
			is_sorted
			not is_empty
		deferred
		ensure
			min_item: not is_empty implies attached Result
		end

	max: like item
			-- Maximum item stored in tree
		require
			is_sorted
			not is_empty
		deferred
		ensure
			max_item: not is_empty implies attached Result
		end

	height: INTEGER
			-- Tree height
		deferred
		end

feature -- Status report

	changeable_comparison_criterion: BOOLEAN
			-- May `object_comparison' be changed?
			-- (Answer: `No' because there must not be duplicate items
			-- in a balanced tree).
		do
			Result := False
		end

	has (v: like item): BOOLEAN
			-- Does subtree include `v'?
			-- (Reference of object equality,
			-- based on `object_comparison'.)
		require
			sorted_tree: is_sorted
		deferred
		ensure
			sorted_tree: is_sorted
		end

	is_sorted: BOOLEAN
			-- Are all tree items in sorted order?
			-- (Order can be destroyed by modifying
			-- item values after insertion in tree.)
		deferred
		end

	is_valid_balanced_search_tree: BOOLEAN
			-- Is tree sorted and are all items unique?
			-- (item values may have changed after insertion)
		do
			Result := is_sorted and has_unique_items
		end

	has_unique_items: BOOLEAN
			-- Are all items unique?
		deferred
		end

	child_writable: BOOLEAN = False
			-- Is there a current `child_item' that may be modified?

	writable_child: BOOLEAN = False
			-- Is there a current child that may be modified?
			-- False because balanced trees are self-organizing.

feature -- Element change

	put, extend (v: G)
			-- Put `v' at proper position in tree
			-- (unless `v' exists already).
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			item_not_void: v /= Void
			valid_tree: is_valid_balanced_search_tree
			is_root: is_root
		deferred
		ensure
			valid_tree: is_valid_balanced_search_tree
		end

feature -- Removal

	prune (v: G)
			-- Remove `v' from tree if `v' exists.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Rebalance tree as necessary.
		require
			valid_tree: is_valid_balanced_search_tree
		deferred
		ensure
			valid_tree: is_valid_balanced_search_tree
		end

feature -- Basic operations

	sort
			-- Restore order of all elements and balance tree.
			-- Necessary when item values have changed after insertion in tree.
			-- Note that duplicate item values will be removed (object comparison).
		deferred
		ensure
			valid_tree: is_valid_balanced_search_tree
		end


feature {BALANCED_SEARCH_TREE} -- Inapplicable

	forget_left
			-- Forget all left siblings.
		do
		end

	forget_right
			-- Forget all right siblings.
		do
		end

	wipe_out
			-- Remove all children.
		do
		end

	tree_put, replace (v: like item)
			-- Replace element at cursor position by `v'.
		do
		end

	put_child (n: like parent)
			-- Add `n' to the list of children.
			-- Do not move child cursor.
		do
		end

	replace_child (n: like parent)
			-- Put `n' at current child position.
		do
		end

	child_put, child_replace (v: like item)
			-- Put `v' at current child position.
		do
		end


feature {NONE} -- Implementation

	is_stable: BOOLEAN
			-- Attribute used to evaluate the invariant tree_consistency.

invariant

	object_comparison: object_comparison


note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class BALANCED_SEARCH_TREE
