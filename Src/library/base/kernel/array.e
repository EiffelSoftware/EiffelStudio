--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class ARRAY [G] inherit

	RESIZABLE
		undefine
			empty
		redefine
			full, twin
		end;

	INDEXABLE [G, INTEGER]
		redefine
			twin
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		redefine
			twin
		end;

	TO_SPECIAL [G]
		export
			{ARRAY}
				set_area
		redefine
			twin
		end

creation

	make

feature -- Creation

	make (minindex, maxindex: INTEGER) is
			-- Allocate array; set index interval to `minindex' .. `maxindex'
			-- (empty if `minindex' > `maxindex').
		do
			upper := -1;
				-- (`lower' initialized to 0 by default, so invariant holds)
			if minindex <= maxindex then
				allocate_space (minindex, maxindex)
			end;
		ensure
			(minindex > maxindex) implies (capacity = 0);
			(minindex <= maxindex) implies (capacity = maxindex - minindex + 1)
		end;

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- Entry at index `i', if in index interval.
		do
			Result := area.item (i - lower);
		end;

	has (v: G): BOOLEAN is
			-- Does `Current' include `v'?
			-- (According to the `='
			-- discrimination rule used in `search')
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper or else (item (i) = v)
			loop
				i := i + 1;
			end;
			Result := not (i > upper);
		end;

feature -- Insertion

	put (v: G; i: INTEGER) is
			-- Replace `i'-th entry, if in index interval, by `v'.
		do
			area.put (v, i - lower);
		end;

	force (v: like item; i: INTEGER) is
			-- Assign item `v' to `i'-th entry.
			-- Always applicable: resize the array if `i' falls out of
			-- currently defined bounds; preserve existing elements.
		local
			j: INTEGER
		do
			if upper < lower then
				allocate_space (i, i + additional_space)
			elseif i < lower then
				j := i - additional_space;
				resize (j, upper);
				lower := j
			elseif i > upper then
				j := i + additional_space;
				resize (lower, j);
				upper := j
			end;
			put (v, i)
		ensure
			inserted: item (i) = v;
	--		higher_capacity: capacity >= old capacity
		end;


feature -- Deletion

	wipe_out is
			-- Empty `Current': discard all items.
		do
			lower := 0;
			upper := -1;
			make_area (0)
		end;

feature -- Number of elements

	grow (i: INTEGER) is
			-- Change the capacity of `Current' to at least `i'.
		do
			if i > capacity then
				resize (lower, upper + i - capacity)
			end
		end;

	resize (minindex, maxindex: INTEGER) is
			-- Rearrange `Current' so that it can accommodate
			-- indices down to `minindex' and up to `maxindex'.
			-- Do not lose any previously entered item.
		local
			i: INTEGER
		do
			if empty then
				allocate_space (minindex, maxindex)
			elseif minindex < lower then
				if maxindex > upper then
					i := lower - minindex;
					area := arycpy
					($area, maxindex - minindex + 1, i, count);
					upper := maxindex
				else
					i := lower - minindex;
					area := arycpy
					($area, upper - minindex + 1, i, count)
				end;
				lower := minindex
			elseif maxindex > upper then
				i := maxindex - lower + 1;
				area := arycpy ($area, i, 0, count);
				upper := maxindex
			end
		ensure
			lower <= minindex;
			maxindex <= upper
		end;

	lower: INTEGER;
			-- Minimum index

	upper: INTEGER;
			-- Maximum index

	count, capacity: INTEGER is
			-- Available indices
		do
			Result := upper - lower + 1
		end;

	full: BOOLEAN is false;
			-- Is `Current' full?

feature -- Transformation

	clear_all is
			-- Reset all items to default values.
		local
			i: INTEGER;
			dead_element: G
		do
			from
				i := lower
			variant
				upper + 1 - i
			until
				i > upper
			loop
				put (dead_element, i);
				i := i + 1
			end
		ensure
			all_cleared: all_cleared
		end;

	all_cleared: BOOLEAN is
			-- Are all items set to default values?
		local
			i: INTEGER;
			dead_element: G;
		do
			from
				i := lower
			variant
				upper + 1 - i
			until
				(i > upper) or else not (dead_element = item (i))
			loop
				i := i + 1
			end;
			Result := i > upper;
		end;

	sequential_representation: SEQUENTIAL [G] is
			-- Sequential representation of `Current'.
            -- This feature enables you to manipulate each
            -- item of `Current' regardless of its
            -- actual structure.
		local
			temp: ARRAY_SEQUENCE [G];
			i: INTEGER;
		do
			!! temp.make (count);
			from
				i := lower;
			until
				i > upper
			loop
				temp.add (item (i));
				i := i + 1;
			end;
			Result := temp;
		end;

feature -- Duplication

	twin: like Current is
			-- New object field-by-field identical to `Current'
		do
			Result := standard_twin;
			Result.set_area (area.standard_twin);
		ensure then
			equal_areas: area.is_equal (Result.area)
		end;

feature -- Obsolete

	duplicate: like Current is obsolete "Use ``twin''"
		do
			Result := twin
		end;

feature -- External representation

	to_c: ANY is
			-- Address of actual sequence of values,
			-- for passing to external (non-Eiffel) routines.
		do
			Result := area
		end;

feature -- Assertion check

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := (lower <= i) and then (i <= upper)
		end;

feature {ARRAY} -- Externals

	arycpy (old_area: like area; newsize, s, n: INTEGER): like area is
			-- New area of size `newsize' containing `n' items
			-- from `oldarea'.
			-- Old items are at position `s' in new area.
		external
			"C"
		end;

feature {NONE} -- Secret

	allocate_space (minindex, maxindex: INTEGER) is
			-- Allocate memory and initialize indexes.
		do
			lower := minindex;
			upper := maxindex;
			make_area (maxindex - minindex + 1)
		end;

invariant

	consistent_size: capacity = upper - lower + 1;
	non_negative_size: count >= 0;

end
