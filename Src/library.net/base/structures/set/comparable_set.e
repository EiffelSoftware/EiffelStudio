indexing
	description: "Sets whose items may be compared according to a total order relation"
	external_name: "ISE.Base.ComparableSet"

deferred class 
	COMPARABLE_SET [G -> ICOMPARABLE] 

inherit

	SUBSET [G]
		redefine
			extendible, prunable, wipe_out, count,
			duplicate, intersect, is_subset, merge,
			subtract, extend, prune, put
		end

	COMPARABLE_STRUCT [G]
		rename
			min as cs_min,
			max as cs_max
		export
			{NONE}
				all
		redefine
			implementation, is_empty, item, start, 
			after, finish, forth, back, before
		end
		
feature -- Access

	has (v: G): BOOLEAN is
		indexing
			description: "[
						Does structure include an occurrence of `v'?
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		do
			start
			if not off then
				search (v)
			end
			Result := not exhausted
		end

feature -- Status report

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "May `object_comparison' be changed? (Answer: yes by default.)"
		do
			Result := is_empty
		end

	object_comparison: BOOLEAN is
		indexing
			description: "[
						Must search operations use `equal' rather than `='
						for comparing references? (Default: no, use `='.)
					  ]"
		do
			Result := internal_object_comparison
		end
		
	is_inserted (v: G): BOOLEAN is
		indexing
			description: "[
						Has `v' been inserted by the most recent insertion?
						(By default, the value returned is equivalent to calling 
						`has (v)'. However, descendants might be able to provide more
						efficient implementations.)
					  ]"
		do
			Result := has (v)
		end

feature {NONE} -- Statue report

	exhausted: BOOLEAN is
		indexing
			description: "Has structure been completely explored?"
		do
			Result := off
		end

feature -- Status setting

	compare_objects is
		indexing
			description: "[
						Ensure that future search operations will use `equal'
						rather than `=' for comparing references.
					  ]"
		do
			internal_object_comparison := True
		end

	compare_references is
		indexing
			description: "[
						Ensure that future search operations will use `='
						rather than `equal' for comparing references.
					  ]"
		do
			internal_object_comparison := False
		end
		
feature -- Element change

	extend (v: G) is
		indexing
			description: "[
						Ensure that structure includes `v'.
						Was declared in COLLECTION as synonym of `put'.
					  ]"
		deferred
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
		end

	put (v: G) is
		indexing
			description: "[
						Ensure that set includes `v'.
						Was declared in SET as synonym of `extend'.
					  ]"
		deferred
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
		end
	
	fill (other: CONTAINER [G]) is
		indexing
			description: "[
						Fill with as many items of `other' as possible.
						The representations of `other' and current structure
						need not be the same.
					  ]"
		local
			lin_rep: LINEAR [G]
		do
			lin_rep := other.linear_representation
			from
				lin_rep.start
			until
				not extendible or else lin_rep.off
			loop
				extend (lin_rep.item)
				lin_rep.forth
			end
		end

feature -- Removal

	prune (v: G) is
		indexing
			description: "Remove `v' if present."
		deferred
		ensure then 
			removed_count_change: old has (v) implies (count = old count - 1)
			not_removed_no_count_change: not old has (v) implies (count = old count)
			item_deleted: not has (v)
		end
		
	prune_all (v: G) is
			--| Default implementation, usually inefficient.
		indexing
			description: "[
						Remove all occurrences of `v'.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		do
			from
			until
				not has (v)
			loop
				prune (v)
			end
		end
		
feature -- Comparison

	is_superset (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a superset of `other'?"
		do
			Result := other.is_subset (Current)
		end

	disjoint (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Do current set and `other' have no items in common?"
		local
			temp: like Current
		do
			if not is_empty then
				temp ?= duplicate (count)
				temp.intersect (other)
				Result := temp.is_empty
			else
				Result := True
			end
		end

feature -- Basic operations

	symdif (other: SUBSET [G]) is
		indexing
			description: "[
						Remove all items also in `other', and add all
						items of `other' not already present.
					  ]"
		local
			temp: like Current
		do
			temp ?= duplicate (count)
			temp.intersect (other)
			merge (other)
			subtract (temp)
		end

feature -- Conversion

	linear_representation: LINEAR [G] is
		indexing
			description: "Representation as a linear structure"
		do
			Result := Current
		end

feature {NONE} -- Measurement

	cs_min: G is
		indexing
			description: "Minimum item"
		do
			from
				start
				Result := item
				forth
			until
				off
			loop
				if item < Result then
					Result := item
				end
				forth
			end
		end

	cs_max: G is
		indexing
			description: "Maximum item"
		do
			from
				start
				Result := item
				forth
			until
				off
			loop
				if item > Result then
					Result := item
				end
				forth
			end
		end

	min_max_available: BOOLEAN is
		indexing
			description: "Can min and max be computed?"
		do
			Result := not is_empty
		end

feature -- Measurement

	min: G is
		indexing
			description: "Minimum item"
		require else
			not_empty: not is_empty
		do
			Result := cs_min
		ensure
			-- smallest: For every item `it' in set, `Result' <= `it'
		end

	max: G is
		indexing
			description: "Maximum item"
		require else
			not_empty: not is_empty
		do
			Result := cs_max
		ensure
			-- largest: For every item `it' in set, `element' <= `it'
		end

feature {NONE} -- Inapplicable

	index: INTEGER is
		do
		end

	search (v: G) is
		indexing
			description: "[
						Move to first position (at or after current
						position) where `item' and `v' are equal.
						(Reference or object equality,
						based on `object_comparison'.)
						If no such position ensure that `exhausted' will be true.
					  ]"
		local
			a: ANY
		do
			if before and not is_empty then
				forth
			end
			if object_comparison and v /= void then
				from
					a:= v
				until
					exhausted or else (item /= void and then a.is_equal (item))
				loop
					forth
				end
			else
				from
				until
					exhausted or else v = item
				loop
					forth
				end
			end
		end
		
	occurrences (v: G): INTEGER is
		indexing
			description: "[
						Number of times `v' appears.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		do
			from
				start
				search (v)
			until
				exhausted
			loop
				Result := Result + 1
				forth
				search (v)
			end
		end

	index_of (v: G; i: INTEGER): INTEGER is
		indexing
			description: "[
						Index of `i'-th occurrence of `v'.
						0 if none.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			occur, pos: INTEGER
			a: ANY
		do
			if object_comparison and v /= void then
				from
					start
					pos := 1
					a := v
				until
					off or (occur = i)
				loop
					if item /= void and then a.is_equal (item) then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			else
				from
					start
					pos := 1
				until
					off or (occur = i)
				loop
					if item = v then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			end
			if occur = i then
				Result := pos - 1
			end
		end

	off: BOOLEAN is
		indexing
			description: "Is there no current item?"
		do
			Result := before or after
		end

feature {NONE} -- Implementation

	internal_object_comparison: BOOLEAN

feature -- Bug fix?

	implementation: SYSTEM_COLLECTIONS_ICOLLECTION is
		indexing
			description: "Object for .NET access and implementation"
		deferred
		end
		
	is_empty: BOOLEAN is
		indexing
			description: "Is there no element?"
		deferred
		end
	
	item: G is
		indexing
			description: "Item at current position"
		deferred
		end	
		
	start is
		indexing
			description: "Move to first position if any."
		deferred
		end

	after: BOOLEAN is
		indexing
			description: "Is there no valid position to the right of current one?"
		deferred
		end
		
	finish is
		indexing
			description: "Move to last position."
		deferred
		end
		
	forth is
		indexing
			description: "[
						Move to next position; if no next position,
						ensure that `exhausted' will be true.
					  ]"
		deferred
		end	
		
	back is
		indexing
			description: "Move to previous position."
		deferred
		end	
		
	before: BOOLEAN is
		indexing
			description: "Is there no valid position to the left of current one?"
		deferred
		end
	
	extendible: BOOLEAN is
		indexing
			description: "May new items be added?"
		deferred
		end
		
	prunable: BOOLEAN is
		indexing
			description: "May items be removed?"
		deferred
		end
		
	wipe_out is
		indexing
			description: "Remove all items."
		deferred
		end
		
	count: INTEGER is
		indexing
			description: "Number of items"
		deferred
		end

	duplicate (n: INTEGER): SUBSET [G] is
		indexing
			description: "[
						New structure containing min (`n', `count')
						items from current structure
					  ]"
		deferred
		end
		
	intersect (other: SUBSET [G]) is
		indexing
			description: "Remove all items not in `other'."
		deferred
		end
		
	is_subset (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a subset of `other'?"
		deferred
		end
		
	merge (other: CONTAINER [G]) is
		indexing
			description: "Add all items of `other'."
		deferred
		end	
		
	subtract (other: SUBSET [G]) is
		indexing
			description: "Remove all items also in `other'."
		deferred
		end
		
end -- class COMPARABLE_SET



