indexing

	description:
		"Lists implemented by resizable arrays"

	status: "See notice at end of class"
	names: sequence;
	representation: array;
	access: index, cursor, membership;
	size: fixed;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class ARRAYED_LIST [G] inherit

	ARRAY [G]
		rename
			force as force_i_th,
			item as i_th,
			make as array_make,
			put as put_i_th,
			count as array_count,
			index_set as array_index_set,
			bag_put as put,
			valid_index as array_valid_index
		export
			{NONE}
				all
			{ARRAYED_LIST}
				array_make, subcopy
			{ANY}
				capacity
		undefine
			linear_representation, prunable, put, is_equal,
			prune, occurrences, extendible 
		redefine
			extend, prune_all, full, wipe_out,
			is_inserted, make_from_array
		select
			array_valid_index
		end

	DYNAMIC_LIST [G]
		undefine
			valid_index, infix "@", i_th, put_i_th,
			force, is_inserted, copy, has
		redefine
			first, last, swap, wipe_out,
			go_i_th, move, prunable, start, finish,
			count, prune, remove,
			put_left, merge_left,
			merge_right, duplicate, prune_all
		select
			count, index_set
		end

create

	make, make_filled, make_from_array

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate list with `n' items.
			-- (`n' may be zero for empty list.)
		require
			valid_number_of_items: n >= 0
		do
			index := 0
			set_count (0)
			array_make (1, n)
		ensure
			correct_position: before
		end

	make_filled (n: INTEGER) is
			-- Allocate list with `n' items.
			-- (`n' may be zero for empty list.)
			-- This list will be full.
		require
			valid_number_of_items: n >= 0
		do
			index := 0
			set_count (n)
			array_make (1, n)
		ensure
			correct_position: before
			filled: full
		end

	make_from_array (a: ARRAY [G]) is
			-- Create list from array `a'.
		do
			Precursor (a)
			lower := 1
			set_count (a.count)
			upper := count
			index := 0
		end 

feature -- Access

	item: like first is
			-- Current item
		require else
			index_is_valid: valid_index (index)
		do
			Result := area.item (index - 1)
		end

	first: G is
			-- Item at first position
		do
			Result := area.item (0)
		end

	last: like first is
			-- Item at last position
		do
			Result := area.item (count - 1)
		end

	index: INTEGER
			-- Index of `item', if valid.

	cursor: CURSOR is
			-- Current cursor position
		do
			create {ARRAYED_LIST_CURSOR} Result.make (index)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.

feature -- Status report

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := (count = capacity)
		end

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			al_c: ARRAYED_LIST_CURSOR
		do
			al_c ?= p
			if al_c /= Void then
				Result := valid_cursor_index (al_c.index)
			end
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := (1 <= i) and (i <= count)
		end

	is_inserted (v: G): BOOLEAN is
			-- Has `v' been inserted at the end by the most recent `put' or
			-- `extend'?
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
			-- Move cursor `i' positions.
		do
			index := index + i
			if (index > count + 1) then
				index := count + 1
			elseif (index < 0) then
				index := 0
			end
		end

	start is
			-- Move cursor to first position if any.
		do
			index := 1
		ensure then
			after_when_empty: is_empty implies after
		end

	finish is
			-- Move cursor to last position if any.
		do
			index := count
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

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			al_c: ARRAYED_LIST_CURSOR
		do
			al_c ?= p
				check
					al_c /= Void
				end
			index := al_c.index
		end

feature -- Element change

	put_front (v: like item) is
			-- Add `v' to the beginning.
			-- Do not move cursor.
		do
			if is_empty then
				extend (v)
			else
				insert (v, 1)
			end
			index := index + 1
		end

	force, extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			set_count (count + 1)
			force_i_th (v, count)
		end

	put_left (v: like item) is
			-- Add `v' to the left of current position.
			-- Do not move cursor.
		do
			if after or is_empty then
				extend (v)
			else
				insert (v, index)
			end
			index := index + 1
		end

	put_right (v: like item) is
			-- Add `v' to the right of current position.
			-- Do not move cursor.
		do
			if index = count then
				extend (v)
			else
				insert (v, index + 1)
			end
		end

	replace (v: like first) is
			-- Replace current item by `v'.
		do
			put_i_th (v, index)
		end

	merge_left (other: ARRAYED_LIST [G]) is
			-- Merge `other' into current structure before cursor.
		local
			old_index: INTEGER
			old_other_count: INTEGER
		do
			old_index := index
			old_other_count := other.count
			index := index - 1
			merge_right (other)
			index := old_index + old_other_count
		end


	merge_right (other: ARRAYED_LIST [G]) is
			-- Merge `other' into current structure after cursor.
		do
			if not other.is_empty then
				resize (1, count + other.count)
				if index < count then
					subcopy (Current, index + 1, count, 
						index + other.count + 1) 
				end
				subcopy (other, 1, other.count, index + 1) 
				set_count (count + other.count)
				other.wipe_out
			end
		end

feature -- Removal

	prune (v: like item) is
			-- Remove first occurrence of `v', if any,
			-- after cursor position.
			-- Move cursor to right neighbor.
			-- (or `after' if no right neighbor or `v' does not occur)
		do
			if before then index := 1 end
			if object_comparison then
				if v /= Void then
					from
					until
						after or else (item /= Void and then v.is_equal (item))
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
			if not after then remove end
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor)
		local
			default_value: G
		do
			if index < count then
				subcopy (Current, index + 1, count, index)
			end
			set_count (count - 1)
			area.put (default_value, count)
		ensure then
			index: index = old index
		end

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i: INTEGER
			offset: INTEGER
			res: BOOLEAN
			obj_cmp: BOOLEAN
			default_val: like item
		do
			obj_cmp := object_comparison
			from 
				i := 1 
			until 
				i > count 
			loop
				if i <= count - offset then
					if offset > 0 then 
						put_i_th (i_th (i + offset), i) 
					end
					if obj_cmp then
						res := equal (v, i_th (i))
					else
						res := (v = i_th (i))
					end
					if res then 
						offset := offset + 1
					else
						i := i + 1
					end
				else
					put_i_th (default_val, i)
					i := i + 1
				end
			end
			set_count (count - offset)
			index := count + 1
		ensure then
			is_after: after
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			index := index - 1
			remove
		end

	remove_right is
			-- Remove item to the right of cursor position
			-- Do not move cursor
		do
			index := index + 1
			remove
			index := index - 1
		end

	wipe_out is
			-- Remove all items.
		do
			set_count (0)
			index := 0
			discard_items
		end

feature -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			old_item: like item
		do
			old_item := item
			replace (area.item (i - 1))
			area.put (old_item, i - 1)
		end

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-list beginning at current position
			-- and having min (`n', `count' - `index' + 1) items.
		local
			end_pos: INTEGER
		do
			if after then
				create Result.make (0)
			else
				end_pos := count.min (index + n - 1)
				create Result.make_filled (end_pos - index + 1)
				Result.subcopy (Current, index, end_pos, 1)
			end
		end

feature {NONE} -- Inapplicable

	new_chain: like Current is
			-- Unused
		do
		end

feature {NONE} -- Implementation

	insert (v: like item; pos: INTEGER) is
			-- Add `v' at `pos', moving subsequent items
			-- to the right.
		require
			index_small_enough: pos <= count
			index_large_enough: pos >= 1
		do
			if count + 1 > capacity then
				auto_resize (lower, count + 1)
			end
			set_count (count + 1)
			subcopy (Current, pos , count - 1 , pos + 1)
			enter (v, pos)
		ensure
			new_count: count = old count + 1
			index_unchanged: index = old index
			insertion_done: i_th (pos) = v
		end
		
	set_count (new_count: INTEGER) is
			-- Set `count' to `new_count'
		do
			count := new_count			
		end

invariant

	prunable: prunable
	starts_from_one: lower = 1
	empty_means_storage_empty: is_empty implies all_default

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ARRAYED_LIST
