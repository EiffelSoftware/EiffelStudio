indexing
	description: "Sequential lists, without commitment to a particular representation"
	external_name: "ISE.Base.List"

deferred class 
	LIST [G] 

inherit
	CHAIN [G]
		undefine
			is_equal
		redefine
			implementation,
			full, item, index, back, is_inserted,
			replace, cursor, go_to, valid_cursor,
			duplicate, move
		end

feature -- Access

	has (v: G): BOOLEAN is
		indexing
			description: "[
						Does structure include `v'?
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			pos: CURSOR
		do
			pos := cursor
			if object_comparison then
				Result := implementation.has (v)
			else
				from 
					start
				until
					after or else (item /= Void and then item = v)
				loop
					forth
				end
				Result := not after and then (item /= Void and then item = v)
			end
			go_to (pos)
		end

	search (v: G) is
		indexing
			description: "[
						Move to first position (at or after current
						position) where `item' and `v' are equal.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
						If no such position ensure that `exhausted' will be true.
					  ]"
		local
			a: ANY
		do
			if before and not is_empty then
				forth
			end
			if object_comparison and v /= Void then
				from
					a := v
				until
					exhausted or else (item /= Void and then a.is_equal (item))
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
		do
			Result := implementation.index_of (v)
		end

	first: G is
		indexing
			description: "Item at first position"
		local
			pos: CURSOR
		do
			pos := cursor
			start
			Result := item
			go_to (pos)
		end

	last: G is
		indexing
			description: "Item at last position"
		local
			pos: CURSOR
		do
			pos := cursor
			finish
			Result := item
			go_to (pos)
		end

	i_th (i: INTEGER): G is
		indexing
			description: "Item at `i'-th position"
		local
			pos: CURSOR
		do
			pos := cursor
			go_i_th (i)
			Result := item
			go_to (pos)
		end

	infix "@" (i: INTEGER): G is
		indexing
			description: "Item at `i'-th position"
		local
			pos: CURSOR
		do
			pos := cursor
			go_i_th (i)
			Result := item
			go_to (pos)
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
		local
			pos: CURSOR
		do
			pos := cursor
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
			go_to (pos)
		end

feature -- Status report

	object_comparison: BOOLEAN is
		indexing
			description: "[
						Must search operations use `equal' rather than `='
						for comparing references? (Default: no, use `='.)
					  ]"
		do
			Result := internal_object_comparison
		end

	is_empty: BOOLEAN is
		indexing
			description: "Is there no element?"
		do
			Result := (count = 0)
		end

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "May `object_comparison' be changed? (Answer: yes by default.)"
		do
			Result := True
		end

	off: BOOLEAN is
		indexing
			description: "Is there no current item?"
		do
			Result := (index = 0) or (index = count + 1)
		end

	exhausted: BOOLEAN is
		indexing
			description: "Has structure been completely explored?"
		do
			Result := off
		end

	before: BOOLEAN is
		indexing
			description: "Is there no valid position to the left of current one?"
		do
			Result := index = 0
		end

	after: BOOLEAN is
		indexing
			description: "Is there no valid position to the right of current one?"
		do
			Result := (index = count + 1)
		end

	readable: BOOLEAN is
		indexing
			description: "Is there a current item that may be read?"
		do
			Result := not off
		end

	writable: BOOLEAN is
		indexing
			description: "Is there a current item that may be modified?"
		do
			Result := not off
		end

	valid_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' within allowable bounds?"
		do
			Result := (1 <= i) and (i <= count)
		end

	isfirst: BOOLEAN is
		indexing
			description: "Is cursor at first position?"
		do
			Result := not is_empty and (index = 1)
		end

	islast: BOOLEAN is
		indexing
			description: "Is cursor at last position?"
		do
			Result := not is_empty and (index = count)
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' correctly bounded for cursor movement?"
		do
			Result := (i >= 0) and (i <= count + 1)
		end

	Extendible: BOOLEAN is
		indexing
			description: "May new items be added? (Answer: yes.)"
		do
			Result := True
		end

	prunable: BOOLEAN is
		indexing
			description: "May items be removed? (Answer: yes.)"
		do
			Result := True
		end

feature -- Measurement

	count: INTEGER is
		indexing
			description: "Number of items."
		do
			Result := implementation.get_count
		end

	index_set: INTEGER_INTERVAL is
		indexing
			description: "Range of acceptable indexes"
		do
			create Result.make (1, count)
		ensure then
			Result.count = count
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

feature -- Conversion

	linear_representation: LINEAR [G] is
		indexing
			description: "Representation as a linear structure"
		do
			Result := Current
		end

feature -- Element change

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
		
	extend (v: G) is
		indexing
			description: "Add a new occurrence of `v'."
		local
			index_insert: INTEGER
		do
			index_insert := implementation.extend (v)
		ensure then
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
		end		

	put_i_th (v: G; i: INTEGER) is
		indexing
			description: "Associate value `v' with key `i'."
		local
			pos: CURSOR
		do
			pos := cursor
			go_i_th (i)
			replace (v)
			go_to (pos)
		ensure then
			insertion_done: i_th (i) = v
		end

	force (v: G) is
		indexing
			description: "Add `v' to end."
		do
			extend (v)
		end
		
	put (v: G) is
		indexing
			description: "Replace current item by `v'. (Synonym for `replace')"
		do
			replace (v)
		ensure then
			same_count: count = old count
		end

	append (s: SEQUENCE [G]) is
		indexing
			description: "Append a copy of `s'."
		local
			l: SEQUENCE [G]
		do
			if s = Current then
				l := duplicate (count)
			else
				l := s
			end
			from
				l.start
			until
				l.exhausted
			loop
				extend (l.item)
				l.forth
			end
		end

feature -- Removal

	prune (v: G) is
		indexing
			description: "[
						Remove the first occurrence of `v' if any.
						If no such occurrence go `off'.
					  ]"
		do
			implementation.Remove (v)
		end

	prune_all (v: G) is
		indexing
			description: "Remove all occurrences of `v'; go `off'."
		do
			from
				start
			until
				exhausted
			loop
				search (v)
				if not exhausted then
					remove
				end
			end
		end

	wipe_out is
		indexing
			description: "Remove all items."
		do
			implementation.Clear
		end

feature -- Transformation

	swap (i: INTEGER) is
		indexing
			description: "Exchange item at `i'-th position with item at cursor position."
		local
			old_item, new_item: G
			pos: CURSOR
		do
			pos := cursor
			old_item := item
			go_i_th (i)
			new_item := item
			replace (old_item)
			go_to (pos)
			replace (new_item)
		end
	
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		indexing
			description: "Does `other' contain the same elements?"
		require else
			other_not_void: other /= void
		local
			c1, c2: CURSOR
			a: ANY
		do
			if Current = other then
				Result := True
			else
				Result := (is_empty = other.is_empty) and (object_comparison = other.object_comparison)
				if Result and not is_empty then
					c1 ?= cursor
					c2 ?= other.cursor
					check
						cursors_exist: c1 /= void and c2 /= void
					end
					from
						start
						other.start
					until
						after or not Result
					loop
						if object_comparison then
							a := item
							Result := a.is_equal (other.item)
						else
							Result := item = other.item
						end
						forth
						other.forth
					end
					go_to (c1)
					other.go_to (c2)
				elseif is_empty and other.is_empty and object_comparison = other.object_comparison then
					Result := True
				end
			end
		ensure then
			symmetric: Result implies other.is_equal (Current)
			consistent: is_equal (other) implies Result
			indices_unchanged: 
				index = old index and other.index = old other.index
			true_implies_same_size: Result implies count = other.count
		end

feature -- Cursor movement

	finish is
		indexing
			description: "Move cursor to last position. (No effect if empty)"
		deferred
		ensure then
			at_last: not is_empty implies islast
		end

	forth is
		indexing
			description: "[
						Move to next position; if no next position,
						ensure that `exhausted' will be true.
					  ]"
		deferred
		ensure then
			moved_forth: index = old index + 1
		end

	go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th position."
		do
			move (i - index)
		end

	start is
		indexing
			description: "Move cursor to first position. (No effect if empty)"
		deferred
		ensure then
			at_first: not is_empty implies isfirst
		end
	
feature {NONE} -- Inapplicable

	remove is
		indexing
			description: "Remove current item."
		do
		end

feature -- Implementation

	implementation: SYSTEM_COLLECTIONS_ILIST is
		indexing
			description: "Object for .NET access and implementation"
		do
		end
		
feature -- Bug fix?	

	full: BOOLEAN is
		indexing
			description: "Is structure filled to capacity?"
		deferred
		end
		
	item: G is
		indexing
			description: "Item at current position"
		deferred
		end
		
	index: INTEGER is
		indexing
			description: "Index of current position"
		deferred
		end
		
	back is
		indexing
			description: "Move to previous position."
		deferred
		end
		
	is_inserted (v: G): BOOLEAN is
		indexing
			description: "[
						Has `v' been inserted by the most recent insertion?
						(By default, the value returned is equivalent to calling
						`has (v)'. However, descendants might be able to provide more
						efficient implementations.)
					  ]"
		deferred
		end
		
	replace (v: G) is
		indexing
			description: "Replace current item by `v'."
		deferred
		end
		
	cursor: CURSOR is
		indexing
			description: "Current cursor position"
		deferred
		end
		
	go_to (p: CURSOR) is
		indexing
			description: "Move cursor to position `p'."
		deferred
		end
		
	valid_cursor (p: CURSOR): BOOLEAN is
		indexing
			description: "Can the cursor be moved to position `p'?"
		deferred
		end
		
	duplicate (n: INTEGER): CHAIN [G] is
		indexing
			description: "[
						Copy of sub-chain beginning at current position
						and having min (`n', `from_here') items,
						where `from_here' is the number of items
						at or to the right of current position.
					  ]"
		deferred
		end
		
	move (i: INTEGER) is
		indexing
			description: "[
						Move cursor `i' positions. The cursor
						may end up `off' if the absolute value of `i'
						is too big.
					  ]"
		deferred
		end
		
feature {LIST} -- Implementation

	internal_object_comparison: BOOLEAN
	
invariant

	before_definition: before = (index = 0)
	after_definition: after = (index = count + 1)

end -- class LIST



