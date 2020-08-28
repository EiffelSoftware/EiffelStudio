note

	description: "[
		Special objects: homogeneous sequences of values, 
		used to represent arrays and strings
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	SPECIAL [T]

create
	make,
	make_filled,
	make_empty

feature {NONE} -- Initialization

	frozen make_empty (n: INTEGER)
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			-- Built-in
		ensure
			area_allocated: count = 0
		end


	frozen make (n: INTEGER)
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			-- Built-in
		ensure
			area_allocated: count = n
		end

	frozen make_filled (v: T; n: INTEGER)
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			-- Built-in
		ensure
			area_allocated: count = n
		end

feature -- Access

	frozen item alias "@" (i: INTEGER): T
			-- Item at `i'-th position
			-- (indices begin at 0)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			-- Built-in
		end

	frozen index_of (v: T; start_position: INTEGER): INTEGER
			-- Index of first occurrence of item identical to `v'.
			-- -1 if none.
		require
			valid_start_position: start_position >= 0
		local
			nb: INTEGER
		do
			from
				Result := start_position
				nb := count
			until
				Result >= nb or else item (Result) ~ v
			loop
				Result := Result + 1
			end
			if Result >= nb then
				Result := -1
			end
		ensure
			found_or_not_found: Result = -1 or else (Result >= 0 and then Result < count)
		end
		
	frozen item_address (i: INTEGER): POINTER
			-- Address of element at position `i'.
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			Result := $Current
			Result := Result + i * sp_elem_size ($Current)
		ensure
			element_address_not_null: Result /= default_pointer
		end

	frozen base_address: POINTER
			-- Address of element at position `0'.
		do
			Result := $Current
		ensure
			base_address_not_null: Result /= default_pointer
		end
		
feature -- Measurement

	frozen count, frozen capacity: INTEGER
			-- Count of the special area
		do
			Result := {ISE_RUNTIME}.sp_count ($Current)
		end

feature -- Status report

	frozen all_default (upper: INTEGER): BOOLEAN
			-- Are all items between index `0' and `upper'
			-- set to default values?
		require
			min_upper: upper >= -1
			max_upper: upper < count
		local
			i: INTEGER
			t: T
		do
			from
				Result := True
			until
				i > upper or else not Result
			loop
				Result := item (i) = t
				i := i + 1
			end
		ensure
			valid_on_empty_area: upper = -1 implies Result
		end

	frozen same_items (other: like Current; upper: INTEGER): BOOLEAN
			-- Do all items between index `0' and `upper' have
			-- same value?
		require
			min_upper: upper >= -1
			max_upper: upper < count
			other_not_void: other /= Void
			other_has_enough_items: upper < other.count
		local
			i: INTEGER
		do
			from
				Result := True
			until
				i > upper or else not Result
			loop
				Result := item (i) = other.item (i)
				i := i + 1
			end
		ensure
			valid_on_empty_area: upper = -1 implies Result
		end
	
	frozen valid_index (i: INTEGER): BOOLEAN
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < count)
		end

	frozen to_array: ARRAY [T]
		do
			create Result.make_from_special (Current)
		end
		
feature -- Element change

	frozen put (v: T; i: INTEGER)
			-- Replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			-- Built-in
		end

feature -- Resizing

	frozen resized_area (n: INTEGER): like Current
			-- Create a copy of Current with a count of `n'.
		require
			valid_new_count: n > count
		local
			i, nb: INTEGER
			to: TO_SPECIAL [T]
		do
			create to.make_area (n)
			Result := to.area
			from
				nb := count
			invariant
				i >= 0 and i <= nb
			variant
				nb - i
			until
				i = nb
			loop
				Result.put (item (i), i)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
			Result_different_from_current: Result /= Current
			new_count: Result.count = n
		end
	
	frozen aliased_resized_area (n: INTEGER): like Current
			-- Try to resize `Current' with a count of `n', if not
			-- possible a new copy.
		require
			valid_new_count: n > count
		do
			Result := sparycpy ($Current, n, 0, count)
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = n
		end
		
feature -- Removal

	frozen clear_all
			-- Reset all items to default values.
		do
			spclearall ($Current)
		end

feature {NONE} -- Implementation

	frozen spclearall (p: POINTER)
			-- Reset all items to default value.
		external
			"C signature (EIF_REFERENCE) use %"eif_copy.h%""
		end

	frozen sparycpy (old_area: POINTER; newsize, s, n: INTEGER): SPECIAL [T]
			-- New area of size `newsize' containing `n' items
			-- from `oldarea'.
			-- Old items are at position `s' in new area.
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER): EIF_REFERENCE use %"eif_misc.h%""
		alias
			"arycpy"
		end
		
	frozen sp_elem_size (p: POINTER): INTEGER
			-- Size of elements.
		external
			"C signature use %"eif_eiffel.h%""
		end

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class SPECIAL


