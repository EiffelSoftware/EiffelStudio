indexing

	description:

		"Routines that ought to be in class FIXED_ARRAY. %
		%A fixed array is a zero-based indexed sequence of values, %
		%equipped with features `put', `item' and `count'."

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_FIXED_ARRAY_ROUTINES [G]

inherit

	KL_IMPORTED_FIXED_ARRAY_TYPE [G]

feature -- Initialization

	make (n: INTEGER): like FIXED_ARRAY_TYPE is
			-- Create a new fixed array being able to contain `n' items.
		require
			non_negative_n: n >= 0
		local
			to_special: TO_SPECIAL [G]
		do
			!! to_special.make_area (n)
			Result := to_special.area
		ensure
			fixed_array_not_void: Result /= Void
			valid_fixed_array: valid_fixed_array (Result)
			count_set: Result.count = n
		end

	make_from_array (an_array: ARRAY [G]): like FIXED_ARRAY_TYPE is
			-- Create a new fixed array with items from `an_array'.
		require
			an_array_not_void: an_array /= Void
		local
			array_routines: KL_ARRAY_ROUTINES [G]
		do
			!! array_routines
			Result := array_routines.make_from_array (an_array, 0).area
		ensure
			fixed_array_not_void: Result /= Void
			valid_fixed_array: valid_fixed_array (Result)
			count_set: Result.count = an_array.count
--			same_items: forall i in 0.. (Result.count - 1),
--				Result.item (i) = an_array.item (an_array.lower + i)
		end

feature -- Conversion

	to_fixed_array (an_array: ARRAY [G]): like FIXED_ARRAY_TYPE is
			-- Fixed array filled with items from `an_array'.
			-- The fixed array and `an_array' may share internal
			-- data. Use `make_from_array' if this is a concern.
		require
			an_array_not_void: an_array /= Void
		do
			Result := an_array.area
		ensure
			fixed_array_not_void: Result /= Void
			valid_fixed_array: valid_fixed_array (Result)
			count_set: Result.count >= an_array.count
--			same_items: forall i in 0.. (an_array.count - 1),
--				Result.item (i) = an_array.item (an_array.lower + i)
		end

feature -- Status report

	has (an_array: like FIXED_ARRAY_TYPE; v: G): BOOLEAN is
			-- Does `v' appear in `an_array'?
		require
			an_array_not_void: an_array /= Void
		local
			i: INTEGER
		do
			from
				i := an_array.count - 1
			until
				Result or i < 0
			loop
				Result := an_array.item (i) = v
				i := i - 1
			end
		end

	valid_fixed_array (an_array: like FIXED_ARRAY_TYPE): BOOLEAN is
			-- Make sure that the lower bound of `an_array' is zero.
		require
			an_array_not_void: an_array /= Void
		do
			Result := True
		end

feature -- Resizing

	resize (an_array: like FIXED_ARRAY_TYPE; n: INTEGER): like FIXED_ARRAY_TYPE is
			-- Resize `an_array' so that it contains `n' items.
			-- Do not lose any previously entered items.
			-- Note: the returned fixed array  might be `an_array'
			-- or a newly created fixed array where items from
			-- `an_array' have been copied to.
		require
			an_array_not_void: an_array /= Void
			valid_fixed_array: valid_fixed_array (an_array)
			n_large_enough: n >= an_array.count
		do
			Result := c_arycpy ($an_array, n, 0, an_array.count)
		ensure
			fixed_array_not_void: Result /= Void
			valid_fixed_array: valid_fixed_array (Result)
			count_set: Result.count = n
		end

feature -- Removal

	clear_all (an_array: like FIXED_ARRAY_TYPE) is
			-- Reset all items to default values.
		require
			an_array_not_void: an_array /= Void
			valid_fixed_array: valid_fixed_array (an_array)
		do
			c_spclearall ($an_array)
		ensure
			-- all_cleared: forall i in 0..(an_array.count - 1),
			--		an_array.item (i) = Void or else
			--		an_array.item (i) = an_array.item (i).default
		end

feature {NONE} -- Externals

	c_arycpy (old_area: POINTER; newsize, s, n: INTEGER): SPECIAL [G] is
			-- New area of size `newsize' containing `n' items
			-- from `oldarea'.
			-- Old items are at position `s' in new area.
		external
			"C | %"eif_misc.h%""
		alias
			"arycpy"
		end

	c_spclearall (p: POINTER) is
			-- Reset all items to default value.
		external
			"C | %"eif_copy.h%""
		alias
			"spclearall"
		end

end -- class KL_FIXED_ARRAY_ROUTINES
