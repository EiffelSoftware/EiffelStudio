indexing

	description: "[
		Sequences of values, all of the same type or of a conforming one,
		accessible through integer indices in a contiguous interval.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class ARRAY [G] inherit

	RESIZABLE [G]
		redefine
			full, copy, is_equal
		end

	INDEXABLE [G, INTEGER]
		redefine
			copy, is_equal
		end

	TO_SPECIAL [G]
		export
			{ARRAY} set_area
		redefine
			copy, is_equal
		end

create
	make,
	make_from_array

feature -- Initialization

	make (min_index, max_index: INTEGER) is
			-- Allocate array; set index interval to
			-- `min_index' .. `max_index'; set all values to default.
			-- (Make array empty if `min_index' = `max_index' + 1).
		require
			valid_bounds: min_index <= max_index + 1
		do
			lower := min_index
			upper := max_index
			if min_index <= max_index then
				make_area (max_index - min_index + 1)
			else
				make_area (0)
			end
		ensure
			lower_set: lower = min_index
			upper_set: upper = max_index
			items_set: all_default
		end

	make_from_array (a: ARRAY [G]) is
			-- Initialize from the items of `a'.
			-- (Useful in proper descendants of class `ARRAY',
			-- to initialize an array-like object from a manifest array.)
		require
			array_exists: a /= Void
		do
			area := a.area
			lower := a.lower
			upper := a.upper
		end

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- Entry at index `i', if in index interval
		do
			Result := area.item (i - lower)
		end

	entry (i: INTEGER): G is
			-- Entry at index `i', if in index interval
		require
			valid_key: valid_index (i)
		do
			Result := item (i)
		end

	has (v: G): BOOLEAN is
			-- Does `v' appear in array?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i: INTEGER
			upper_bound: INTEGER
		do
			upper_bound := upper
			if object_comparison then
				if v = Void then
					i := upper_bound + 1
				else
					from
						i := lower
					until
						i > upper_bound or else (item (i) /= Void and then item (i).is_equal (v))
					loop
						i := i + 1
					end
				end
			else
				from
					i := lower
				until
					i > upper_bound or else (item (i) = v)
				loop
					i := i + 1
				end
			end
			Result := not (i > upper_bound)
		end

feature -- Measurement

	lower: INTEGER
			-- Minimum index

	upper: INTEGER
			-- Maximum index

	count, capacity: INTEGER is
			-- Number of available indices
		do
			Result := upper - lower + 1
		ensure then
			consistent_with_bounds: Result = upper - lower + 1
		end

	occurrences (v: G): INTEGER is
			-- Number of times `v' appears in structure
		local
			i: INTEGER
		do
			if object_comparison then
				if v /= Void then
					from
						i := lower
					until
						i > upper
					loop
						if item (i) /= Void and then v.is_equal (item (i)) then
							Result := Result + 1
						end
						i := i + 1
					end
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

	index_set: INTEGER_INTERVAL is
			-- Range of acceptable indexes
		do
			create Result.make (lower, upper)
		ensure then
			same_count: Result.count = count
			same_bounds:
				((Result.lower = lower) and (Result.upper = upper))
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is array made of the same items as `other'?
		local
			i: INTEGER
		do
			if lower = other.lower and then upper = other.upper and then
				object_comparison = other.object_comparison then
				if object_comparison then
					from 
						Result := True
						i := lower
					until 
						not Result or i > upper 
					loop
						Result := equal (item (i), other.item (i))
						i := i + 1
					end
				else
					Result := area.same_items (other.area, upper - lower)
				end
			end
		end

feature -- Status report

	all_default: BOOLEAN is
			-- Are all items set to default values?
		do
			Result := area.all_default (upper - lower)
		ensure
			definition: Result = (count = 0 or else 
				((item (upper) = Void or else 
				item (upper) = item (upper).default) and 
				subarray (lower, upper - 1).all_default))
		end

	full: BOOLEAN is
			-- Is structure filled to capacity? (Answer: yes)
		do
			Result := True
		end

	same_items (other: like Current): BOOLEAN is
			-- Do `other' and Current have same items?
		require
			other_not_void: other /= Void
		do
			if count = other.count then
				Result := area.same_items (other.area, upper - lower)
			end
		ensure
			definition: Result = ((count = other.count) and then
				(count = 0 or else (item (upper) = other.item (other.upper)
				and subarray (lower, upper - 1).same_items 
				(other.subarray (other.lower, other.upper - 1)))))
		end

	all_cleared: BOOLEAN is
			-- Are all items set to default values?
		obsolete
			"Use `all_default' instead"
		do
			Result := all_default
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of the array?
		do
			Result := (lower <= i) and then (i <= upper)
		end

	extendible: BOOLEAN is
			-- May items be added?
			-- (Answer: no, although array may be resized.)
		do
			Result := False
		end

	prunable: BOOLEAN is
			-- May items be removed? (Answer: no.)
		do
			Result := False
		end

	valid_index_set: BOOLEAN is
		do
			Result := index_set.count = count
		end

feature -- Element change

	put (v: like item; i: INTEGER) is
			-- Replace `i'-th entry, if in index interval, by `v'.
		do
			area.put (v, i - lower)
		end

	enter (v: like item; i: INTEGER) is
			-- Replace `i'-th entry, if in index interval, by `v'.
		require
			valid_key: valid_index (i)
		do
			area.put (v, i - lower)
		end

	force (v: like item; i: INTEGER) is
			-- Assign item `v' to `i'-th entry.
			-- Always applicable: resize the array if `i' falls out of
			-- currently defined bounds; preserve existing items.
		do
			if i < lower then
				auto_resize (i, upper)
			elseif i > upper then
				auto_resize (lower, i)
			end
			put (v, i)
		ensure
			inserted: item (i) = v
			higher_count: count >= old count
		end

	subcopy (other: like Current; start_pos, end_pos, index_pos: INTEGER) is
			-- Copy items of `other' within bounds `start_pos' and `end_pos'
			-- to current array starting at index `index_pos'.
		require
			other_not_void: other /= Void
			valid_start_pos: other.valid_index (start_pos)
			valid_end_pos: other.valid_index (end_pos)
			valid_bounds: (start_pos <= end_pos) or (start_pos = end_pos + 1)
			valid_index_pos: valid_index (index_pos)
			enough_space: (upper - index_pos) >= (end_pos - start_pos)
		local
			other_area: like area
			other_lower: INTEGER
			start0, end0, index0: INTEGER
		do
			other_area := other.area
			other_lower := other.lower
			start0 := start_pos - other_lower
			end0 := end_pos - other_lower
			index0 := index_pos - lower
			spsubcopy ($other_area, $area, start0, end0, index0)
		ensure
			-- copied: forall `i' in 0 .. (`end_pos'-`start_pos'),
			--     item (index_pos + i) = other.item (start_pos + i)
		end

feature -- Removal

	wipe_out is
			-- Make array empty.
		obsolete
			"Not applicable since not `prunable'. Use `discard_items' instead."
		do
			discard_items
		end

	discard_items is
			-- Reset all items to default values with reallocation.
		do
			make_area (capacity)
		ensure
			default_items: all_default
		end

	clear_all is
			-- Reset all items to default values.
		do
			area.clear_all
		ensure
			stable_lower: lower = old lower
			stable_upper: upper = old upper
			default_items: all_default
		end

feature -- Resizing

	grow (i: INTEGER) is
			-- Change the capacity to at least `i'.
		do
			if i > capacity then
				resize (lower, upper + i - capacity)
			end
		end

	resize (min_index, max_index: INTEGER) is
			-- Rearrange array so that it can accommodate
			-- indices down to `min_index' and up to `max_index'.
			-- Do not lose any previously entered item.
		require
			good_indices: min_index <= max_index
		local
			old_size, new_size, old_count: INTEGER
			new_lower, new_upper: INTEGER
		do
			if empty_area then
				new_lower := min_index
				new_upper := max_index
			else
				new_lower := min_index.min (lower)
				new_upper := max_index.max (upper)
			end
			new_size := new_upper - new_lower + 1
			if not empty_area then
				old_size := area.count
				old_count := upper - lower + 1
			end
			if empty_area then
				make_area (new_size)
			elseif new_size > old_size or new_lower < lower then
				area := arycpy ($area, new_size,
					lower - new_lower, old_count)
			end
			lower := new_lower
			upper := new_upper
		ensure
			no_low_lost: lower = min_index or else lower = old lower
			no_high_lost: upper = max_index or else upper = old upper
		end

feature -- Conversion

	to_c: ANY is
			-- Address of actual sequence of values,
			-- for passing to external (non-Eiffel) routines.
		do
			Result := area
		end

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		local
			temp: ARRAYED_LIST [G]
			i: INTEGER
		do
			create temp.make (capacity)
			from
				i := lower
			until
				i > upper
			loop
				temp.extend (item (i))
				i := i + 1
			end
			Result := temp
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying all the items of `other'.
			-- (This is also used by `clone'.)
		do
			if other /= Current then
				standard_copy (other)
				set_area (standard_clone (other.area))
			end
		ensure then
			equal_areas: area.is_equal (other.area)
		end

	subarray (start_pos, end_pos: INTEGER): like Current is
			-- Array made of items of current array within
			-- bounds `start_pos' and `end_pos'.
		require
			valid_start_pos: valid_index (start_pos)
			valid_end_pos: valid_index (end_pos)
			valid_bounds: (start_pos <= end_pos) or (start_pos = end_pos + 1)
		do
			create Result.make (start_pos, end_pos)
			Result.subcopy (Current, start_pos, end_pos, start_pos)
		ensure
			lower: Result.lower = start_pos
			upper: Result.upper = end_pos
			-- copied: forall `i' in `start_pos' .. `end_pos',
			--     Result.item (i) = item (i)
		end

feature {NONE} -- Inapplicable

	prune (v: G) is
			-- Remove first occurrence of `v' if any.
			-- (Precondition is False.)
		do
		end

	extend (v: G) is
			-- Add `v' to structure.
			-- (Precondition is False.)
		do
		end

feature {ARRAY} -- Implementation

	arycpy (old_area: POINTER; newsize, s, n: INTEGER): like area is
			-- New area of size `newsize' containing `n' items
			-- from `oldarea'.
			-- Old items are at position `s' in new area.
		external
			"C | %"eif_misc.h%""
		end

feature {NONE} -- Implementation

	auto_resize (min_index, max_index: INTEGER) is
			-- Rearrange array so that it can accommodate
			-- indices down to `min_index' and up to `max_index'.
			-- Do not lose any previously entered item.
			-- If area must be extended, ensure that space for at least
			-- additional_space item is added.
		require
			valid_indices: min_index <= max_index
		local
			old_size, new_size: INTEGER
			new_lower, new_upper: INTEGER
		do
			if empty_area then
				new_lower := min_index
				new_upper := max_index
			else
				new_lower := min_index.min (lower)
				new_upper := max_index.max (upper)
			end
			new_size := new_upper - new_lower + 1
			if not empty_area then
				old_size := area.count
				if new_size > old_size
					 and new_size - old_size < additional_space
				then
					new_size := old_size + additional_space
				end
			end
			if empty_area then
				make_area (new_size)
			elseif new_size > old_size or new_lower < lower then
					area := arycpy ($area, new_size,
						lower - new_lower, capacity)
			end
			lower := new_lower
			upper := new_upper
		end

	empty_area: BOOLEAN is
			-- Is `area' empty?
		do
			Result := (area.count = 0)
		end

	spsubcopy (source, target: POINTER; s, e, i: INTEGER) is
			-- Copy elements of `source' within bounds `s'
			-- and `e' to `target' starting at index `i'.
		external
			"C | %"eif_copy.h%""
		end

invariant

	area_exists: area /= Void
	consistent_size: capacity = upper - lower + 1
	non_negative_count: count >= 0
	index_set_has_same_count: valid_index_set
-- Internal discussion haven't reached an agreement on this invariant
--	index_set_has_same_bounds: ((index_set.lower = lower) and 
--				(index_set.upper = lower + count - 1))

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

end -- class ARRAY
