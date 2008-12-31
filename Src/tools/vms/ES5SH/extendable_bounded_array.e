note
	archive: "$Archive: /beta/kernel/infrastructure/containers/EXTENDABLE_BOUNDED_ARRAY.E $"
	description: "Array which is extendable and linear"
	keywords: "array,linear,extendable,iterable"
	author: "Mark Howard"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTENDABLE_BOUNDED_ARRAY [G]

inherit
	ROSE_LINEAR [G]
		rename
			item as current_item,
			for_all as rose_for_all,
			there_exists as rose_there_exists,
			do_if as rose_do_if
		undefine
			copy, off, is_equal, has, occurrences,do_all
		end
	ARRAY [G]
		rename
			subarray as array_subarray
		export
			{ROSE_LINEAR_ARRAY_OR_ONE} auto_resize
		undefine
			linear_representation, prunable, prune, extendible
		redefine
			make, extend, prune_all, full, wipe_out, make_from_array, has, occurrences
		end

create
	make, make_empty, make_from_array, make_from_linear

feature -- Initialization

	make (a_lower, a_upper: INTEGER)
			-- Allocate an array with 'a_lower' and 'a_upper' bounds.
		do
			Precursor (a_lower,a_upper)
			index := a_lower
			compare_objects
		end

	make_empty
			-- Allocate an empty array.
		do
			make (1,0)
		end

	make_from_linear (a_linear: LINEAR [G])
			-- Allocate an array initially populated with all elements from 'a_linear'.
		do
			make_empty
			from
				a_linear.start
			until
				a_linear.off
			loop
				extend (a_linear.item)
				a_linear.forth
			end
		end

	make_from_array (a_array: ARRAY[G])
			-- Allocate an array initially populated with all elements from 'a_array'.
		local
			i: INTEGER
		do
			make (1,a_array.count)
			from
				i := a_array.lower
			until
				i > a_array.upper
			loop
				put (a_array.item (i),i-a_array.lower + 1)
				i := i + 1
			end
		end

feature -- Access

	subarray (i, j: INTEGER): like Current
		do
			create Result.make_from_array (array_subarray (i,j))
		end

	safe_item (i: INTEGER): G
			-- 'i'-th item if valid index 'i', Void (or default value) otherwise
		do
			if valid_index (i) then
				Result := item (i)
			end
		end

	current_item: G
			-- Current item if valid, Void otherwise
		do
			if lower <= index and then index <= upper then
				--Result := item (index)
				Result := area.item (index - lower)
			end
		end

	previous_item: G
			-- Item just previous to current item
		require
			index_greater_than_lower: index > lower
		do
			Result := item (index - 1)
		end

	next_item: G
			-- Item just after current item
		require
			index_less_than_upper: index < upper
		do
			Result := item (index + 1)
		end

	first: G
			-- Item at first position, if any
		do
			Result := safe_item (lower)
		end

	last: like first
			-- Item at last position, if any
		do
			if count > 0 then
				Result := item (upper)
			end
		end

	index: INTEGER
			-- Current index of `item', may be invalid

	found_index: INTEGER
			-- Index of item eventually found by last call to 'has' (this is a side effect)

	new_index_of (a_item: G): INTEGER
			-- Index of first occurence of 'a_item' in this array
		local
			i: INTEGER
		do
			Result := lower - 1
			from
				i := lower
			until
				Result >= lower or else i > upper
			loop
				if equal (item (i),a_item) then
					Result := i
				end
				i := i + 1
			end
		end


feature -- Status report

	prunable: BOOLEAN
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end

	extendible: BOOLEAN
		do
			Result := True
		end

	full: BOOLEAN
			-- Is structure filled to capacity?
		do
			Result := (count = capacity)
		end

	at_first: BOOLEAN
			-- Is the cursor at the first item?
		do
			Result := index = lower
		end

	at_last: BOOLEAN
			-- Is the cursor at the last item?
		do
			Result := index = upper
		end

	off: BOOLEAN
		do
			Result := before or after
		end

	after: BOOLEAN
		do
			Result := index > upper
		end

	before: BOOLEAN
		do
			Result := index < lower
		end

	has (a_value: G): BOOLEAN
			-- Does `a_value' appear in this array?
 			-- (Reference or object equality, based on `object_comparison'.)
		local
			n: INTEGER
		do
			n := upper
			if object_comparison then
					from
					found_index := lower
				until
					found_index > n or else (equal(item (found_index), a_value))
				loop
					found_index := found_index + 1
				end
			else
				from
					found_index := lower
				until
					found_index > n or else (item (found_index) = a_value)
				loop
					found_index := found_index + 1
				end
			end
			Result := not (found_index > n)
		end

	occurrences (v: G): INTEGER
			-- Number of times `v' appears in structure
		local
			i: INTEGER
		do
			if object_comparison then
				from
					i := lower
				until
					i > upper
				loop
					if equal(v, item (i)) then
						Result := Result + 1
					end
					i := i + 1
				end
			else
				from
					i := lower
				until
					i > upper
				loop
					if item (i) = v then
						Result := Result + 1
					end
					i := i + 1
				end
			end
		end

feature -- Cursor movement

	move (i: INTEGER)
			-- Move cursor `i' positions, does not go outside array bounds.
		do
			index := index + i
			if index > upper then
				index := upper
			elseif index < lower then
				index := lower
			end
		ensure
			within_bounds: not is_empty implies valid_index (index)
		end

	start
			-- Move cursor to first position if any.
		do
			index := lower
		ensure then
			after_when_empty: is_empty implies after
		end

	finish
			-- Move cursor to last position if any.
		do
			index := upper
				--| Temporary patch. Start moves the cursor
				--| to the first element. If the list is empty
				--| the cursor is before. The parents (CHAIN, LIST...)
				--| and decendants (ARRAYED_TREE...) need to be revised.
		ensure then
			before_when_empty: is_empty implies before
		end

	forth
			-- Move cursor one position forward.
		do
			index := index + 1
		end

	back
			-- Move cursor one position backward.
		do
			index := index - 1
		end

	go_i_th (i: INTEGER)
			-- Move cursor to `i'-th position.
		do
			index := i
		end

	start_forth
			-- Move cursor to first position if any, then if not off, move one position forth.
		do
			start
			if not off then forth end
		end

	finish_back
			-- Move cursor to last position if any, then if not off, move one position back.
		do
			finish
			if not off then back end
		end

	swap (i: INTEGER)
			-- Exchange item at `i'-th position with item
			-- at 'index' position.
		local
			l_item: G
		do
			l_item := current_item
			replace (item (i))
			put (l_item, i)
		end

	put_front (a_value: G)
			-- Add `a_value' to the beginning.
			-- Do not move cursor.
		do
			if is_empty then
				extend (a_value)
			else
				insert (a_value,lower)
			end
		end

	extend (a_value: G)
			-- Add `a_value' to end.
			-- Do not move cursor.
		do
			force (a_value, upper + 1)
		end

	put_left (a_value: G)
			-- Add `a_value' to the left of current position.
			-- Do not move cursor.
		do
			if after or is_empty then
				extend (a_value)
				index := index + 1
			else
				insert (a_value, index)
			end
		end

	put_right (a_value: G)
			-- Add `a_value' to the right of current position.
			-- Do not move cursor.
		do
			if index = count then
				extend (a_value)
			else
				insert (a_value, index + 1)
			end
		end

	replace (a_value: like first)
			-- Replace current item by `a_value'.
		do
			put (a_value, index)
		end

	append_linear (a_linear: LINEAR [G])
			-- Append contents of 'a_linear' to this array.
		require
			a_linear_not_void: a_linear /= Void
		local
			l_linear: LINEAR [G]
		do
			l_linear := clone (a_linear)
			from
				l_linear.start
			until
				l_linear.off
			loop
				extend (l_linear.item)
				l_linear.forth
			end
		end

	append_array (a_array: ARRAY [G])
			-- Append contents of 'a_array' to this array.
		local
			i: INTEGER
		do
			if a_array /= Void then
				from
					i := a_array.lower
				until
					i > a_array.upper
				loop
					extend (a_array.item (i))
					i := i + 1
				end
			end
		end

	apply (a_agent: PROCEDURE[ANY,TUPLE[G]])
			--version of do_all which does not affect the state, so safe for recursion
		local
			 i: INTEGER
			 t: TUPLE [G]
		do
			create t.make
			from i := lower until i > upper loop
				t.put (item (i),1)
				a_agent.call (t)
				i := i + 1
			end
		end

	restrict (a_lower, a_upper: INTEGER)
			-- Restrict bounds of this array to 'a_lower' and 'a_upper'
		do
			resize (a_lower,a_upper)
			lower := a_lower
			upper := a_upper
		end

feature -- Removal

	prune (a_value: G)
			-- Remove first occurrence of `a_value', if any,
			-- after cursor position.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor or `a_value' does not occur)
		do
			if before then index := 1 end
			if object_comparison then
				if a_value /= Void then
					from
					until
						after or else (current_item /= Void and then a_value.is_equal (current_item))
					loop
						forth
					end
				end
			else
				from
				until
					after or else current_item = a_value
				loop
					forth
				end
			end
			if not after then remove end
		end

	remove
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor)
		local
			i,j: INTEGER
			default_value: G
		do
			if not off then
				from
					i := index
				until
					i > upper
				loop
					j := i + 1
					if j > upper then
						put (default_value, i)
					else
						put (item (j), i)
					end
					i := j
				end
				put (default_value, upper)
				upper := upper - 1
			end
		end

	prune_all (a_value: G)
			-- Remove all occurrences of `a_value'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave cursor `after'.
		local
			i: INTEGER
			l_item, default_value: G
		do
			if object_comparison and then a_value /= Void then
				from
					start
				until
					after or else (current_item /= Void and then a_value.is_equal (current_item))
				loop
					forth
				end
				from
					if not after then
						i := index
						forth
					end
				until
					after
				loop
					l_item := current_item
					if l_item /= Void and then not a_value.is_equal (l_item) then
						put (l_item, i)
						i := i + 1
					end
					forth
				end
			else
				from
					start
				until
					after or else (current_item = a_value)
				loop
					forth
				end
				from
					if not after then
						i := index
						forth
					end
				until
					after
				loop
					l_item := current_item
					if l_item /= a_value then
						put (l_item, i)
						i := i + 1
					end
					forth
				end
			end
			if i >= lower then
				from
					index := i
				until
					i > upper
				loop
					put (default_value, i)
					i := i + 1
				end
				upper := index - 1
			end
		ensure then
			is_after: after
		end

	remove_left
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			back
			remove
		end

	remove_right
			-- Remove item to the right of cursor position
			-- Do not move cursor
		do
			forth
			remove
			back
		end

	empty_out,wipe_out
			-- Remove all items.
		do
			discard_items
			index := lower
			upper := lower - 1
		end

	insert (a_value: G; pos: INTEGER)
			-- Add `a_value' at `pos', moving subsequent items
			-- to the right.
		require
			index_small_enough: pos <= upper
			index_large_enough: pos >= lower
		local
			i,j: INTEGER
			last_item: G
		do
			if index >= pos then
				index := index + 1
			end
			last_item := last
			force (last_item, upper + 1)
			from
				i := upper - 1
			until
				i <= pos
			loop
				j := i - 1
				put (item (j), i)
				i := j
			end
			put(a_value, pos)
		ensure
			new_count: count = old count + 1
			insertion_done: item (pos) = a_value
		end
		
--	valid_cursor (a_cursor : like cursor) : BOOLEAN is
--		do
--			Result := a_cursor.index >= lower - 1 and then
--			a_cursor.index <= count + 1
--		end

end -- class EXTENDIBLE_BOUNDED_ARRAY
