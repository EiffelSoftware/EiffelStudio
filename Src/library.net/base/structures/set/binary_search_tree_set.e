indexing
	description: "Sorted sets implemented as binary search trees"
	external_name: "ISE.Base.BinarySearchTreeSet"

class 
	BINARY_SEARCH_TREE_SET [G -> ICOMPARABLE] 

inherit

	COMPARABLE_SET [G]
		redefine
			min, max, has, off, disjoint, symdif
		end

	TRAVERSABLE_SUBSET [G]

create

	make

feature -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
			internal_before := True
		end

feature -- Access

	has (v: G): BOOLEAN is
		indexing
			description: "[
						Is there a node with item `v' in tree?
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		do
			if tree /= Void then
				Result := tree.has (v)
			end
		end

	off: BOOLEAN is
		indexing
			description: "[
						Is there no current item?
						`off' only if tree `is_empty' or if
						it is `before' or `after'.
					  ]"
		do
			Result := is_empty or Precursor {COMPARABLE_SET}
		end

feature -- Measurement

	count: INTEGER is
		indexing
			description: "Number of items in tree"
		do
			if tree /= Void then
				Result := tree.count
			end
		end

	min: G is
		indexing
			description: "Minimum item in tree"
		do
			Result := tree.min
		end

	max: G is
		indexing
			description: "Maximum item in tree"
		do
			Result := tree.max
		end

	item: G is
		indexing
			description: "Item at current position"
		do
			Result := active_node.item
		end

feature -- Status report

	is_empty: BOOLEAN is
		indexing
			description: "Is set empty?"
		do
			Result := tree = Void
		end

	extendible: BOOLEAN is
		indexing
			description: "Can new items be added? (Answer: yes.)"
		do
			Result := True
		end

	prunable: BOOLEAN is
		indexing
			description: "Can items be removed? (Answer: yes.)"
		do
			Result := True
		end

	after: BOOLEAN is
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
		do
			Result := internal_after
		end

	before: BOOLEAN is
		indexing
			description: "Is there no valid cursor position to the left of cursor?"
		do
			Result := internal_before
		end

feature -- Cursor movement

	start is
		indexing
			description: "Move cursor to first node."
		do
			internal_before := False
			if tree = Void then
				internal_after := True
			else
				internal_after := False
				active_node := tree.min_node
			end
		end

	finish is
		indexing
			description: "Move cursor to last node."
		do
			internal_after := False
			if tree = Void then
				internal_before := True
			else
				internal_before := False
				active_node := tree.max_node
			end
		end

	forth is
		indexing
			description: "Move cursor to next node."
		local
			prev_node: BINARY_SEARCH_TREE [G]
		do
			if before then
				internal_before := False
				if is_empty then
					internal_after:= True
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
						internal_after := True
					end
				end
			end
		end

	back is
		indexing
			description: "Move cursor to previous node."
		local
			prev_node: BINARY_SEARCH_TREE [G]
		do
			if after then
				internal_after := False
				if is_empty then
					internal_before:= True
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
						internal_before := True
					end
				end
			end
		end

feature -- Comparison

	disjoint (other: TRAVERSABLE_SUBSET [G]): BOOLEAN is
		indexing
			description: "Do current set and `other' have no items in common?"
		local
			s: SUBSET_STRATEGY [G]
		do
			if not is_empty and not other.is_empty then
				s := subset_strategy (other)
				Result := s.disjoint (Current, other)
			else
				Result := True
			end
		end

	is_subset (other: TRAVERSABLE_SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a subset of `other'?"
		do
			if not other.is_empty and then count <= other.count then
				from
					start
				until
					off or else not other.has (item)
				loop
					forth
				end
				if off then Result := True end
			elseif is_empty then
				Result := True
			end
		end

feature -- Element change

	put (v: G) is
		indexing
			description: "Put `v' at proper position in set (unless one already exists)."
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

	extend (v: G) is
		indexing
			description: "Put `v' at proper position in set (unless one already exists)."
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

	wipe_out is
		indexing
			description: "Remove all items."
		do
			tree := Void
		end

	prune (v: G) is
		indexing
			description: "Prune `v'."
		do
			if tree /= Void then
				tree := tree.pruned (v, tree.parent)
			end
		end
		
	remove is
		indexing
			description: "Remove current item."
		do
			prune (item)
		end

feature -- Duplication

	duplicate (n: INTEGER): BINARY_SEARCH_TREE_SET [G] is
		indexing
			description: "[
						New structure containing min (`n', `count')
						items from current structure
					  ]"
		do
			create Result.make
			Result.set_tree (tree.duplicate (n))
		end

feature -- Basic operations

	symdif (other: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "[
						Remove all items also in `other', and add all
						items of `other' not already present.
					  ]"
		local
			s: SUBSET_STRATEGY [G]
		do
			if not other.is_empty then
				if is_empty then
--| To be fixed
--					copy (other)
				else
					s := subset_strategy (other)
					s.symdif (Current, other)
				end
			end
		end

	intersect (other: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "[
						Remove all items not in `other'.
						No effect if `other' `is_empty'.
					  ]"
		do
			if not other.is_empty then
				from
					start
					other.start
				until
					off
				loop
					if other.has (item) then
						forth
					else
						remove
					end
				end
			else
				wipe_out
			end
		end

	subtract (other: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "Remove all items also in `other'."
		do
			if not (other.is_empty or is_empty) then
				from
					start
					other.start
				until
					off
				loop
					if other.has (item) then
						remove
					else
						forth
					end
				end
			end
		end

	merge (other: CONTAINER [G]) is
		indexing
			description: "Add all items of `other'."
		local
			lin_rep: LINEAR [G]
		do 
			lin_rep ?= other
			if lin_rep = Void then
					-- `other' is not a descendant of LINEAR, therefore  we
					-- must convert its contents into a linear representation.
				lin_rep := other.linear_representation
			end
			from
				lin_rep.start
			until
				lin_rep.off
			loop
				extend (lin_rep.item)
				lin_rep.forth
			end
		end

feature {BINARY_SEARCH_TREE_SET} -- Implementation

	tree: BINARY_SEARCH_TREE [G]

	active_node: BINARY_SEARCH_TREE [G]

	set_tree (t : BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Set `tree' and `active_node' to `t'."
		do
			tree := t
			active_node := t
		end

feature {NONE} -- Implementation

	new_tree (v: G): BINARY_SEARCH_TREE [G] is
		indexing
			description: "New allocated node with `item' set to `v'"
		do
			create Result.make (v)
			if object_comparison then
				Result.compare_objects
			end
		end

	subset_strategy_selection (v: G; other: TRAVERSABLE_SUBSET [G]): 
								SUBSET_STRATEGY [G] is
		indexing
			description: "[
						Strategy to calculate several subset features selected depending
						on the dynamic type of `v'
					  ]"
		do
			create {SUBSET_STRATEGY_HASHABLE [G]} Result
		end

	subset_strategy (other: TRAVERSABLE_SUBSET [G]): SUBSET_STRATEGY [G] is
		indexing
			description: "Subset strategy suitable for the type of the contained elements."
		do
			start
			check
				not_off: not off
					-- Because we are at the first element of structure and the
					-- structure is not empty.
			end
			Result := subset_strategy_selection (item, other)
		end

feature -- Implementation

	implementation: SYSTEM_COLLECTIONS_ICOLLECTION is
		indexing
			description: "Object for .NET access and implementation"
		do
		end

feature {NONE} -- Implementation

	internal_after: BOOLEAN

	internal_before: BOOLEAN

invariant

	comparison_mode_equal: tree /= Void implies
				object_comparison = tree.object_comparison

end -- class BINARY_SEARCH_TREE_SET



