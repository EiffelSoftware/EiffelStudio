indexing
	description: "Lists implemented by resizable arrays"
	external_name: "ISE.Base.ArrayedList"

class
	ARRAYED_LIST [G]

inherit

	RESIZABLE [G]
		undefine
			is_equal
		end
			
	DYNAMIC_LIST [G]
		redefine
			append, is_equal, implementation,
			put_i_th, force, swap, i_th, infix "@",			
			prune, duplicate, wipe_out,
			prune_all, extend, put, index_of
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
		indexing
			description: "[
						Allocate list with `n' items.
						(`n' may be zero for empty list.)
					  ]"
		require
			valid_number_of_items: n >= 0
		do
			create internal_implementation.make_1 (n)
			internal_index := 0
		ensure
			correct_position: before
		end

feature -- Access

	frozen i_th (i: INTEGER): G is
		indexing
			description: "Entry at index `i'"
		do
			Result ?= implementation.get_item (i - lower)
		end

	frozen infix "@" (i: INTEGER): G is
		indexing
			description: "Entry at index `i'"
		do
			Result ?= implementation.get_item (i - lower)
		end
		
	item: G is
		indexing
			description: "Current item"
		require else
			index_is_valid: valid_index (index)
		do
			Result := i_th (index)
		end

	index: INTEGER is
		indexing
			description: "Index of `item', if valid."
		do
			Result := internal_index
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
			Result := Precursor (v, i) + lower
		end
		
	cursor: CURSOR is
		indexing
			description: "Current cursor position"
		do
			create {ARRAYED_LIST_CURSOR} Result.make (index)
		end

feature -- Measurement

	capacity: INTEGER is
		indexing
			description: "Number of items that may be stored"
		do
			Result := implementation.get_capacity
		ensure then
			consistent_with_bounds: Result = upper - lower + 1
		end

feature -- Status report

	full: BOOLEAN is
		indexing
			description: "Is structure filled to capacity? (Answer: no.)"
		do
			Result := count = capacity
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		indexing
			description: "Can the cursor be moved to position `p'?"
		local
			al_c: ARRAYED_LIST_CURSOR
		do
			al_c ?= p
			if al_c /= Void then
				Result := valid_cursor_index (al_c.index)
			end
		end

	is_inserted (v: G): BOOLEAN is
		indexing
			description: "Has `v' been inserted at the end by the most recent `put' or `extend'?"
		do
			check
				put_constraint: (v /= last) implies not off
					-- Because, if this routine has not been called by
					-- `extend', it was called by `put' which replaces the
					-- current item, which implies the cursor is not `off'.
			end

			Result := (v = last) or else (v = item)
		end

feature -- Cursor movement

	move (i: INTEGER) is
		indexing
			description: "Move cursor `i' positions."
		local
			length, j: INTEGER
			moved: BOOLEAN
		do
			internal_index := index + i
			if (internal_index < 0) then
				implementation.get_enumerator.reset
				internal_index := 0
			elseif (internal_index > count + 1) then
				internal_index := count + 1
			else
				if i >= 0 then
					length := i
				else
					length := internal_index
					implementation.get_enumerator.reset
				end
				from
					j := 1
				until
					j > length
				loop
					moved := implementation.get_enumerator.move_next
					j := j + 1
				end
			end
		end

	start is
		indexing
			description: "Move cursor to first position if any."
		local
			moved: BOOLEAN
		do
			implementation.get_enumerator.reset
			moved := implementation.get_enumerator.move_next
			internal_index := 1
		ensure then
			after_when_empty: is_empty implies after
		end

	finish is
		indexing
			description: "Move cursor to last position if any."
		local
			moved: BOOLEAN
			local_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
		do
			moved := True
			from
				local_enumerator := implementation.get_enumerator
			until
				not moved
			loop
				moved := local_enumerator.move_next
			end
			internal_index := count
		ensure then
			before_when_empty: is_empty implies before
		end

	forth is
		indexing
			description: "Move cursor one position forward."
		local
			moved: BOOLEAN
		do
			moved := implementation.get_enumerator.move_next
			internal_index := internal_index + 1
		end

	back is
		indexing
			description: "Move cursor one position backward."
		local
			local_index, i: INTEGER
			moved: BOOLEAN
		do
			local_index := index - 1
			internal_index := local_index
			implementation.get_enumerator.reset
			from
				i := 1
			until
				i > local_index
			loop
				moved := implementation.get_enumerator.move_next
				i := i + 1
			end
			check
				index = local_index
			end
		end

	go_to (p: CURSOR) is
		indexing
			description: "Move cursor to position `p'."
		local
			al_c: ARRAYED_LIST_CURSOR
		do
			al_c ?= p
				check
					al_c /= Void
				end
			move (al_c.index - index)
		end

feature -- Transformation

	sort is
		indexing
			description: "Sort elements."
		do
			implementation.sort
		end
		
	swap (i: INTEGER) is
		indexing
			description: "Exchange item at `i'-th position with item at cursor position."
		local
			old_item: G
		do
			old_item := item
			replace (i_th (i))
			put_i_th (old_item, i)
		end

feature -- Element change

	put (v: G) is
		indexing
			description: "Replace current item by `v'. (Synonym for `replace')"
		do
			implementation.put_i_th (index - lower, v)
		end

	put_front (v: G) is
		indexing
			description: "Add `v' to the beginning. Do not move cursor."
		do
			if is_empty then
				extend (v)
			else
				insert (v, 1)
			end
			internal_index := index + 1
		end

	force (v: G) is
		indexing
			description: "Add `v' to end. Do not move cursor."
		local
			new_count: INTEGER
		do
			new_count := implementation.extend (v)
		end

	extend (v: G) is
		indexing
			description: "Add `v' to end. Do not move cursor."
		local
			new_count: INTEGER
		do
			new_count := implementation.extend (v)
		end
		
	frozen put_i_th (v: G; i: INTEGER) is
		indexing
			description: "Replace `i'-th entry, if in index interval, by `v'."
		do
			implementation.put_i_th (i - lower, v)
		end

	put_left (v: G) is
		indexing
			description: "Add `v' to the left of current position. Do not move cursor."
		do
			if after or is_empty then
				extend (v)
			else
				insert (v, index)
			end
			internal_index := index + 1
		end

	put_right (v: G) is
		indexing
			description: "Add `v' to the right of current position. Do not move cursor."
		do
			if index = count then
				extend (v)
			else
				insert (v, index + 1)
			end
		end

	replace (v: G) is
		indexing
			description: "Replace current item by `v'."
		do
			put_i_th (v, index)
		end

	append (s: SEQUENCE [G]) is
		indexing
			description: "Append a copy of `s'."
		do
			implementation.append (s.implementation)
		end

	merge_left (other: ARRAYED_LIST [G]) is
		indexing
			description: "Insert elements of `other' to the left of current position."
		local
			i: INTEGER
		do
			if not other.is_empty then
				from
					i := other.count					
				until
					i = 0
				loop
					insert (other.i_th (i), index)
					i := i - 1
				end
				internal_index := internal_index + other.count
				other.wipe_out
			end
		end

	merge_right (other: ARRAYED_LIST [G]) is
		indexing
			description: "Insert elements of `other' to the right of current position."
		local
			old_index: INTEGER
		do
			old_index := index
			forth
			merge_left (other)
			go_i_th (old_index)
		end

feature -- Removal

	prune (v: G) is
		indexing
			description: "[
						Remove first occurrence of `v', if any,
						after cursor position.
						Move cursor to right neighbor
						(or `after' if no right neighbor or `v'does not occur)
					  ]"
		local
			a: ANY
		do
			implementation.remove (v)
			if object_comparison then
				if v /= Void then
					from
						a := v
					until
						after or else (item /= Void and then a.is_equal (item))
					loop
						forth
					end
				end
			else
				from
				until
					after or else item = v
				loop
					forth
				end
			end
		end

	remove is
		indexing
			description: "[
						Remove current item.
						Move cursor to right neighbor
						(or `after' if no right neighbor)
					  ]"
		do
			implementation.prune_i_th (index - lower)
		end

	prune_all (v: G) is
		indexing
			description: "[
						Remove all occurrences of `v'.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
						Leave cursor `after'.
					  ]"
		local
			a: ANY
		do
			from
				start
				a := v
			until
				after
			loop
				if object_comparison then
					if item /= Void and then a.is_equal (item) then
						remove
					else
						forth
					end
				else
					if item /= Void and then item = v then
						remove
					else
						forth
					end
				end
			end
			internal_index := count + 1
		ensure then
			is_after: after
		end

	remove_left is
		indexing
			description: "Remove item to the left of cursor position. Do not move cursor."
		do
			back
			remove
		end

	remove_right is
		indexing
			description: "Remove item to the right of cursor position. Do not move cursor."
		do
			forth
			remove
			back
		end

	wipe_out is
		indexing
			description: "Remove all items."
		do
			internal_index := 0
			Precursor {DYNAMIC_LIST}
		end
		
feature -- Duplication

	copy (other: like Current) is
		indexing
			description: "Copy `other'."
		require 
			other_not_void: other /= void
			type_identity: get_type.is_equal (other.get_type)
		do
			internal_implementation ?= other.implementation.clone
		ensure 
--			is_equal: is_equal (other)
		end

	duplicate (n: INTEGER): CHAIN [G] is
		indexing
			description: "[
						Copy of sub-list beginning at current position
						and having min (`n', `count' - `index' + 1) items.
					  ]"
		local
			pos: INTEGER
			duplicated: ARRAYED_LIST [G]
		do
			if n <= count - index + 1 then
				create duplicated.make (n)
			else				
				create duplicated.make (count - index + 1)
			end
			from
				duplicated.start
				pos := index
			until
				duplicated.count = duplicated.capacity
			loop
				duplicated.extend (item)
				forth
			end
			duplicated.start
			go_i_th (pos)
			Result := duplicated
		end
		
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		indexing
			description: "Does `other' contain the same elements?"
		do
			Result := implementation.is_equal (other)
		end

feature {NONE} -- Internal

	Growth_percentage: INTEGER is 
		indexing
			description: "Percentage by which structure will grow automatically"
		do
		end
		
	Minimal_increase: INTEGER is 
		indexing
			description: "Minimal number of additional items"
		do
		end

	lower: INTEGER is
		indexing
			description: "Minimum index"
		do
			Result := 1
		end

	upper: INTEGER is		
		indexing
			description: "Maximum index"
		do
			Result := capacity
		end

	resizable: BOOLEAN is
		indexing
			description: "May `capacity' be changed?"
		do
		end
		
	additional_space: INTEGER is
			--| Result is a reasonable value, resulting from a space-time tradeoff.
		indexing
			description: "Proposed number of additional items"
		do
		end

	automatic_grow is
			--| Trades space for time:
			--| allocates fairly large chunks of memory but not very often.
		indexing
			description: "[
						Change the capacity to accommodate at least
						`Growth_percentage' more items.
					  ]"
		do
		end

	grow (i: INTEGER) is
		indexing
			description: "Change the capacity to at least `i'."
		local
			pos: CURSOR
			void_item: G
			j: INTEGER
		do
		end

	insert (v: G; pos: INTEGER) is
		indexing
			description: "Add `v' at `pos', moving subsequent items to the right."
		require
			index_small_enough: pos <= count
			index_large_enough: pos >= 1
		do
			implementation.insert (pos - lower, v)
		ensure
			new_count: count = old count + 1
			insertion_done: i_th (pos) = v
		end

	new_chain: DYNAMIC_CHAIN [G] is
		indexing
			description: "Unused"
		do
		end

feature {ARRAYED_LIST} -- Implementation
	
	internal_implementation: SYSTEM_COLLECTIONS_ARRAYLIST
	
	internal_index: INTEGER

feature -- Implementation
	
	implementation: SYSTEM_COLLECTIONS_ARRAYLIST is
		indexing
			description: "Object for .NET access and implementation"
		do
			Result := internal_implementation
		end

invariant

	prunable: prunable
	starts_from_one: lower = 1

end -- class ARRAYED_LIST
