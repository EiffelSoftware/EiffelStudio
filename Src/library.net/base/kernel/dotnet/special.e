indexing

	description: "[
		Special objects: homogeneous sequences of values, 
		used to represent arrays and strings
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	SPECIAL [T]
	
inherit
	ANY
		redefine
			is_equal,
			copy
		end

create
	make,
	make_from_native_array

feature {NONE} -- Initialization

	frozen make (n: INTEGER) is
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			create native_array.make (n)
		ensure
			area_allocated: count = n
		end

	frozen make_from_native_array (a: NATIVE_ARRAY [T]) is
			-- Creates a special object with `a'.
		require
			a_not_void: a /= Void
			valid_array_type: valid_array_type (a)
		do
			native_array := a
		ensure
			native_array_set: native_array = a
		end

feature -- Access

	frozen item, frozen infix "@" (i: INTEGER): T is
			-- Item at `i'-th position
			-- (indices begin at 0)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			Result := native_array.item (i)
		end

	frozen index_of (v: T; start_position: INTEGER): INTEGER is
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
				Result >= nb or else equal (item (Result), v)
			loop
				Result := Result + 1
			end
			if Result >= nb then
				Result := -1
			end
		ensure
			found_or_not_found: Result = -1 or else (Result >= 0 and then Result < count)
		end

	frozen native_array: NATIVE_ARRAY [T]
			-- Access to memory location.

feature -- Measurement

	lower: INTEGER is 0
			-- Minimum index of Current
			
	frozen upper: INTEGER is 
			-- Maximum index of Current
		do
			Result := native_array.count - 1
		end

	frozen count, frozen capacity: INTEGER is
			-- Count of the special area
		do
			Result := native_array.count
		end

feature -- Status report

	frozen valid_array_type (a: NATIVE_ARRAY [T]): BOOLEAN is
			-- Ensure that `a' is compatible with the type of Current.
		require
			a_not_void: a /= Void
		do
				-- To be implemented
			Result := True
		end

	frozen all_default (upper_bound: INTEGER): BOOLEAN is
			-- Are all items between index `0' and `upper_bound'
			-- set to default values?
		require
			min_upper_bound: upper_bound >= -1
			max_upper_bound: upper_bound < count
		local
			i: INTEGER
			t: T
		do
			from
				Result := True
			until
				i > upper_bound or else not Result
			loop
				Result := item (i) = t
				i := i + 1
			end
		ensure
			valid_on_empty_area: upper_bound = -1 implies Result
		end

	frozen same_items (other: like Current; upper_bound: INTEGER): BOOLEAN is
			-- Do all items between index `0' and `upper_bound' have
			-- same value?
		require
			min_upper_bound: upper_bound >= -1
			max_upper_bound: upper_bound < count
			other_not_void: other /= Void
			other_has_enough_items: upper_bound < other.count
		local
			i: INTEGER
		do
			from
				Result := True
			until
				i > upper_bound or else not Result
			loop
				Result := item (i) = other.item (i)
				i := i + 1
			end
		ensure
			valid_on_empty_area: upper_bound = -1 implies Result
		end

	frozen valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < count)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if count = other.count then
				Result := same_items (other, other.count - 1)
			end
		end

feature -- Element change

	frozen put (v: T; i: INTEGER) is
			-- Replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			native_array.put (i, v)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		local
			l_old_native: like native_array
		do
			l_old_native := native_array
			standard_copy (other)
			if l_old_native = Void or else l_old_native.count /= other.count then
				create native_array.make (other.count)
			else
				native_array := l_old_native
			end
			
			feature {SYSTEM_ARRAY}.copy (other.native_array, native_array, other.count)
		end

feature -- Resizing

	frozen resized_area (n: INTEGER): like Current is
			-- Create a copy of Current with a count of `n'.
		require
			valid_new_count: n > count
		local
			i, nb: INTEGER
		do
			create Result.make (n)
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
	
	frozen aliased_resized_area (n: INTEGER): like Current is
			-- Create a copy of Current with a count of `n'.
		require
			valid_new_count: n > count
		do
			Result := resized_area (n)
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = n
		end
		
feature -- Removal

	frozen clear_all is
			-- Reset all items to default values.
		local
			v: T
			i, nb: INTEGER
		do
			from
				nb := count
			invariant
				i >= 0 and i <= nb
			variant
				nb - i
			until
				i = nb
			loop
				put (v, i)
				i := i + 1
			end
		end

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

end -- class SPECIAL


