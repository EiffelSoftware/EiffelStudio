indexing
	description: "Array which is extendable and linear"
	keywords: "array,linear,extendable,iterable"
	author: "Mark Howard"
	date: "$Date$"
	revision: "$Revision$"
	archive: "$File: //rose/source/kernel/infrastructure/containers/extendable_bounded_array.e $"

class
	EXTENDABLE_BOUNDED_ARRAY [G]

inherit
	INDEXED_LINEAR [G]
		rename
			item as current_item
		undefine
			copy, off, is_equal, has, occurrences,
			do_all, do_if, for_all, there_exists
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
	make, make_empty, make_from_array, make_from_linear, make_from_array_reversed, make_with_default_value

feature -- Initialization

	make (a_lower, a_upper: INTEGER) is
			-- Allocate an array with 'a_lower' and 'a_upper' bounds.
		do
			Precursor (a_lower, a_upper)
			index := a_lower
			compare_objects
		end

	make_empty is
			-- Allocate an empty array.
		do
			make (1, 0)
		end

	make_from_linear (a_linear: LINEAR [G]) is
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

	make_from_array (a_array: ARRAY[G]) is
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

	make_from_array_reversed (a_array: ARRAY[G]) is
			-- Allocate an array initially populated with all elements from 'a_array' in reverse order.
		local
			i: INTEGER
		do
			make (1,a_array.count)
			from
				i := a_array.upper
			until
				i < a_array.lower
			loop
				put (a_array.item (i), a_array.upper - i + 1)
				i := i - 1
			end
		end

	make_with_default_value (a_lower, a_upper: INTEGER; a_default_value: G) is
			-- Make filled with 'a_default_value'.
		local
			i: INTEGER
		do
			make (a_lower, a_upper)
			from i := lower
			until i > upper
			loop
				put (a_default_value, i)
				i := i + 1
			end
		end

feature -- Access

	safe_item (i: INTEGER): G is
			-- 'i'-th item if valid index 'i', Void (or default value) otherwise
		do
			if valid_index (i) then
				Result := item (i)
			end
		end

	current_item: G is
			-- Current item if valid, Void otherwise
		do
			if lower <= index and then index <= upper then
				--Result := item (index)
				Result := area.item (index - lower)
			end
		end

	previous_item: G is
			-- Item just previous to current item
		require
			index_greater_than_lower: index > lower
		do
			Result := item (index - 1)
		end

	next_item: G is
			-- Item just after current item
		require
			index_less_than_upper: index < upper
		do
			Result := item (index + 1)
		end

	first: G is
			-- Item at first position, if any
		do
			Result := safe_item (lower)
		end

	last: like first is
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

	new_index_of (a_item: G): INTEGER is
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
				if item_equal (item (i), a_item) then
					Result := i
				end
				i := i + 1
			end
		end


feature -- Status report

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end

	extendible: BOOLEAN is
			-- May items be added?
		do
			Result := True
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := (count = capacity)
		end

	at_first: BOOLEAN is
			-- Is the cursor at the first item?
		do
			Result := index = lower
		end

	at_last: BOOLEAN is
			-- Is the cursor at the last item?
		do
			Result := index = upper
		end

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := before or after
		end

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		do
			Result := index > upper
		end

	before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		do
			Result := index < lower
		end

	has (a_value: G): BOOLEAN is
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
					found_index > n or else (item_equal (item (found_index), a_value))
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

	occurrences (v: G): INTEGER is
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
					if item_equal (v, item (i)) then
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

	move (i: INTEGER) is
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

	start is
			-- Move cursor to first position if any.
		do
			index := lower
		ensure then
			after_when_empty: is_empty implies after
		end

	finish is
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

	forth is
			-- Move cursor one position forward.
		do
			index := index + 1
		end

	back is
			-- Move cursor one position backward.
		do
			index := index - 1
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			index := i
		end

	start_forth is
			-- Move cursor to first position if any, then if not off, move one position forth.
		do
			start
			if not off then forth end
		end

	finish_back is
			-- Move cursor to last position if any, then if not off, move one position back.
		do
			finish
			if not off then back end
		end

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at 'index' position.
		local
			l_item: G
		do
			l_item := current_item
			replace (item (i))
			put (l_item, i)
		end

	put_front (a_value: G) is
			-- Add `a_value' to the beginning.
			-- Do not move cursor.
		do
			if is_empty then
				extend (a_value)
			else
				insert (a_value,lower)
			end
		end

	extend (a_value: G) is
			-- Add `a_value' to end.
			-- Do not move cursor.
		do
			force (a_value, upper + 1)
		end

	put_left (a_value: G) is
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

	put_right (a_value: G) is
			-- Add `a_value' to the right of current position.
			-- Do not move cursor.
		do
			if index = count then
				extend (a_value)
			else
				insert (a_value, index + 1)
			end
		end

	replace (a_value: like first) is
			-- Replace current item by `a_value'.
		do
			put (a_value, index)
		end

	append_linear (a_linear: LINEAR [G]) is
			-- Append contents of 'a_linear' to this array.
		require
			a_linear_not_void: a_linear /= Void
		local
			l_linear: LINEAR [G]
		do
			l_linear := a_linear.twin
			from
				l_linear.start
			until
				l_linear.off
			loop
				extend (l_linear.item)
				l_linear.forth
			end
		end

	append_array (a_array: ARRAY [G]) is
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

	apply (a_agent: PROCEDURE[ANY,TUPLE[G]]) is
			--version of do_all which does not affect the state, so safe for recursion
		local
			 i: INTEGER
			 t: TUPLE [G]
		do
			create t
			from i := lower until i > upper loop
				t.put (item (i),1)
				a_agent.call (t)
				i := i + 1
			end
		end

	restrict (a_lower, a_upper: INTEGER) is
			-- Restrict bounds of this array to 'a_lower' and 'a_upper'
		do
			conservative_resize (a_lower,a_upper)
			lower := a_lower
			upper := a_upper
		end

feature -- Removal

	prune (a_value: G) is
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

	remove is
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

	prune_all (a_value: G) is
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

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			back
			remove
		end

	remove_right is
			-- Remove item to the right of cursor position
			-- Do not move cursor
		do
			forth
			remove
			back
		end

	empty_out,wipe_out is
			-- Remove all items.
		do
			discard_items
			index := lower
			upper := lower - 1
		end

	insert (a_value: G; pos: INTEGER) is
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

	valid_cursor (a_cursor : like cursor) : BOOLEAN is
			--is a_cursor valid?
		do
			Result := a_cursor.index >= lower - 1 and then
			a_cursor.index <= upper + 1
		end

	item_equal (a_1, a_2: G): BOOLEAN is
			-- Equal has problems in some versions of eiffel.
			-- The locals are a trick to handle
			-- reference and expanded generic parameter the same way
		local
			l_default: G
		do
			if a_1 = l_default and then a_2 = l_default then
				Result := True
			elseif a_1 /= l_default and then a_2 /= l_default then
				Result := a_1.same_type (a_2) and then a_1.is_equal (a_2)
			end
		end

end
