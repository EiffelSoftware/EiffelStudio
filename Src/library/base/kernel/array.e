indexing

	description:
		"Sequences of values, all of the same type or of a conforming one, %
		%accessible through integer indices in a contiguous range";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ARRAY [G] inherit

	RESIZABLE [G]
		redefine
			full, copy, is_equal,
			consistent, setup
		end;

	INDEXABLE [G, INTEGER]
		redefine
			copy, is_equal,
			consistent, setup
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		redefine
			copy, is_equal,
			consistent, setup
		end;

	TO_SPECIAL [G]
		export
			{ARRAY} set_area
		redefine
			copy, is_equal,
			consistent, setup
		end

creation

	make

feature -- Initialization

	make (minindex, maxindex: INTEGER) is
			-- Allocate array; set index interval to `minindex' .. `maxindex'
			-- (empty if `minindex' > `maxindex').
		do
			upper := -1;
				-- (`lower' initialized to 0 by default, so invariant holds)
			if minindex <= maxindex then
				make_area (maxindex - minindex + 1);
				lower := minindex;
				upper := maxindex
			else
				make_area (0)
			end;
		ensure
			(minindex > maxindex) implies (capacity = 0);
			(minindex <= maxindex) implies (capacity = maxindex - minindex + 1)
		end;

	setup (other: like Current) is
			-- Perform actions on a freshly created object so that
			-- the contents of `other' can be safely copied onto it.
		do
			make_area (other.capacity)
		end;

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- Entry at index `i', if in index interval.
		do
			Result := area.item (i - lower);
		end;


	has (v: G): BOOLEAN is
			-- Does `v' appear in array?
			-- (According to the `=' discrimination rule used in `search')
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


feature -- Measurement

	
	lower: INTEGER;
			-- Minimum index

	upper: INTEGER;
			-- Maximum index

	count, capacity: INTEGER is
			-- Available indices
		do
			Result := upper - lower + 1
		end;

	occurrences (v: G): INTEGER is
			-- Number of times `v' appears in structure
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				if item (i) = v then
					Result := Result +1
				end;
				i := i + 1
			end
		end;

feature -- Element change


feature -- Comparison

	is_equal (array: like Current): BOOLEAN is
		do
			Result := area.is_equal (array.area)
		end;

feature -- Status report

	consistent (other: like Current): BOOLEAN is
				-- Is object in a consistent state so that others
				-- can be copied onto it? (Default answer: yes).
		do
			Result := capacity = other.capacity
		end;

	full: BOOLEAN is
			-- Is structure filled to capacity? (Answer: yes)
		do
			Result := true
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

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := (lower <= i) and then (i <= upper)
		end;


	extendible: BOOLEAN is
			-- May items be added? (Answer: no.)
		do
			Result := false
		end;

	prunable: BOOLEAN is
			-- May items be removed? (Answer: no.)
		do
			Result := false
		end;

feature -- Element change
 
	put (v: G; i: INTEGER) is
			-- Replace `i'-th entry, if in index range, by `v'.
		do
			area.put (v, i - lower);
		end;

	force (v: like item; i: INTEGER) is
			-- Assign item `v' to `i'-th entry.
			-- Always applicable: resize the array if `i' falls out of
			-- currently defined bounds; preserve existing elements.
		do
			if upper < lower then
				resize (i, i);	
			elseif i < lower then
				auto_resize (i, upper);
			elseif i > upper then
				auto_resize (lower, i);
			end;
			put (v, i)
		ensure
			inserted: item (i) = v;
			--higher_capacity: capacity >= old capacity
		end;

feature -- Removal

	wipe_out is
			-- Make array empty.
		do
			lower := 0;
			upper := -1;
			make_area (0)
		end;

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

 
feature -- Resizing

	grow (i: INTEGER) is
			-- Change the capacity to at least `i'.
		do
			if i > capacity then
				resize (lower, upper + i - capacity)
			end
		end;

	resize (minindex, maxindex: INTEGER) is
			-- Rearrange array so that it can accommodate
			-- indices down to `minindex' and up to `maxindex'.
			-- Do not lose any previously entered item.
		require
			valid_indices: minindex <= maxindex
		local
			old_size, new_size, old_count: INTEGER;
			new_lower, new_upper: INTEGER;
		do
			if empty_area then
				new_lower := minindex;
				new_upper := maxindex
			else
				if minindex < lower then
					new_lower := minindex
				else
					new_lower := lower
				end;
				if maxindex > upper then
					new_upper := maxindex
				else
					new_upper := upper
				end
			end;
			new_size := new_upper - new_lower + 1;
			if not empty_area then 
				old_size := area.count;
				old_count := upper - lower + 1
			end;
			if empty_area then
				make_area (new_size);
			elseif new_size /= old_size then
				area := arycpy ($area, new_size, 
					lower - new_lower, old_count)
			end;
			lower := new_lower;
			upper := new_upper
		end;	
				
				
feature -- Conversion
		
	sequential_representation: SEQUENTIAL [G] is
			-- Representation as a sequential structure
		local
			temp: ARRAYED_LIST [G];
			i: INTEGER;
		do
			!! temp.make (capacity);
			from
				i := lower;
			until
				i > upper
			loop
				temp.extend (item (i));
				i := i + 1;
			end;
			Result := temp;
		end;

feature -- Duplication


	copy (other: like Current) is
			-- Reinitialize by copying all the elements of `other'.
			-- (This is also used by `clone'.)
		do
			standard_copy (other);
			set_area (standard_clone (other.area));
		ensure then
			equal_areas: area.is_equal (other.area)
		end;


feature -- Obsolete

	duplicate: like Current is obsolete "Use ``clone''"
		do
			Result := clone (Current)
		end;

feature {NONE} -- Inapplicable

	prune (v: G) is
			-- Precondition is always false here.
		do
		end;

	extend (v: G) is
			-- Precondition is always false here.
		do
		end;

feature {ARRAY} -- Implementation

	arycpy (old_area: like area; newsize, s, n: INTEGER): like area is
			-- New area of size `newsize' containing `n' items
			-- from `oldarea'.
			-- Old items are at position `s' in new area.
		external
			"C"
		end;

feature {NONE} -- Implementation

	auto_resize (minindex, maxindex: INTEGER) is
			-- Rearrange array so that it can accommodate
			-- indices down to `minindex' and up to `maxindex'.
			-- Do not lose any previously entered item.
			-- If area must be extended, ensure that space for at least
			-- additional_space item is added.
		require
			valid_indices: minindex <= maxindex
		local
			old_size, new_size: INTEGER;
			new_lower, new_upper: INTEGER;
		do
			if empty_area then
				new_lower := minindex;
				new_upper := maxindex
			else
				if minindex < lower then
					new_lower := minindex
				else
					new_lower := lower
				end;
				if maxindex > upper then
					new_upper := maxindex
				else
					new_upper := upper
				end
			end;
			new_size := new_upper - new_lower + 1;
			if not empty_area then 
				old_size := area.count;
				if new_size > old_size
					 and new_size - old_size < additional_space
				then
					new_size := old_size + additional_space
				end
			end;
			if empty_area then
				make_area (new_size);
			elseif new_size > old_size or new_lower < lower then
					area := arycpy ($area, new_size, 
						lower - new_lower, capacity)
			end;
			lower := new_lower;
			upper := new_upper
		end;
	
	to_c: ANY is
			-- Address of actual sequence of values,
			-- for passing to external (non-Eiffel) routines.
		do
			Result := area
		end;
		
	empty_area: BOOLEAN is
		do
			Result := area.count = 0
		end;

invariant

	consistent_size: capacity = upper - lower + 1;
	non_negative_size: capacity >= 0;

end -- class ARRAY


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
