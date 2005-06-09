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
	ABSTRACT_SPECIAL
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
			create internal_native_array.make (n)
		ensure
			area_allocated: count = n
		end

	frozen make_from_native_array (an_array: like native_array) is
			-- Creates a special object from `an_array'.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			an_array_not_void: an_array /= Void
		do
			internal_native_array ?= an_array.clone
		ensure
			native_array_set: native_array.equals (an_array)
		end

feature -- Access

	frozen item, frozen infix "@" (i: INTEGER): T is
			-- Item at `i'-th position
			-- (indices begin at 0)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			Result := internal_native_array.item (i)
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

	frozen item_address (i: INTEGER): POINTER is
			-- Address of element at position `i'.
		require
			not_dotnet: not {PLATFORM}.is_dotnet
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
		ensure
			element_address_not_null: Result /= default_pointer
		end

	frozen base_address: POINTER is
			-- Address of element at position `0'.
		require
			not_dotnet: not {PLATFORM}.is_dotnet
		do
		ensure
			base_address_not_null: Result /= default_pointer
		end
		
	frozen native_array: NATIVE_ARRAY [T] is
			-- Only for compatibility with .NET
		require
			is_dotnet: {PLATFORM}.is_dotnet
		do
			Result := internal_native_array
		end

feature -- Measurement

	lower: INTEGER is 0
			-- Minimum index of Current
			
	frozen upper: INTEGER is 
			-- Maximum index of Current
		do
			Result := internal_native_array.count - 1
		end

	frozen count, frozen capacity: INTEGER is
			-- Count of the special area
		do
			Result := internal_native_array.count
		end

feature -- Status report

	frozen all_default (upper_bound: INTEGER): BOOLEAN is
			-- Are all items between index `0' and `upper_bound'
			-- set to default values?
		require
			min_upper_bound: upper_bound >= -1
			max_upper_bound: upper_bound < count
		local
			i, nb: INTEGER
			l_array: like internal_native_array
			t: T
		do
			from
				Result := True
				l_array := internal_native_array
				nb := upper_bound + 1
			until
				i = nb
			loop
				if l_array.item (i) /= t then
					Result := False
					i := nb - 1
				end
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
			i, nb: INTEGER
			l_array, l_other_array: like internal_native_array
		do
			from
				Result := True
				l_array := internal_native_array
				l_other_array := other.internal_native_array
				nb := upper_bound + 1
			until
				i = nb
			loop
				if l_array.item (i) /= l_other_array.item (i) then
					Result := False
					i := nb - 1 -- Jump out of loop
				end
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
			internal_native_array.put (i, v)
		end

	frozen fill_with (v: T; start_index, end_index: INTEGER) is
			-- Set items between `start_index' and `end_index' with `v'.
		require
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index
			end_index_valid: end_index < count
		local
			i, nb: INTEGER
			l_array: like native_array
		do
			from
				l_array := internal_native_array
				i := start_index
				nb := end_index + 1
			until
				i = nb
			loop
				l_array.put (i, v)
				i := i + 1
			end
		end

	frozen copy_data (other: like Current; source_index, destination_index, n: INTEGER) is
			-- Copy `n' elements of `other' from `source_start' position to Current at
			-- `destination_index'. Other elements of Current remain unchanged.
		require
			other_not_void: other /= Void
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= other.count
			n_is_small_enough_for_destination: destination_index + n <= count
		do
			{SYSTEM_ARRAY}.copy (other.internal_native_array, source_index, internal_native_array, destination_index, n)
		end

	frozen move_data (source_index, destination_index, n: INTEGER) is
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= count
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, source_index, l_array, destination_index, n)
		end

	frozen overlapping_move (source_index, destination_index, n: INTEGER) is
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			different_source_and_target: source_index /= destination_index
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= count
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, source_index, l_array, destination_index, n)
		end

	frozen non_overlapping_move (source_index, destination_index, n: INTEGER) is
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			different_source_and_target: source_index /= destination_index
			non_overlapping: 
				(source_index < destination_index implies source_index + n < destination_index) or
				(source_index > destination_index implies destination_index + n < source_index)
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= count
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, source_index, l_array, destination_index, n)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		local
			l_old_native: like native_array
		do
			l_old_native := internal_native_array
			standard_copy (other)
			if l_old_native = Void or else l_old_native.count /= other.count then
				create internal_native_array.make (other.count)
			else
				internal_native_array := l_old_native
			end
			
			{SYSTEM_ARRAY}.copy (other.internal_native_array, internal_native_array, other.count)
		end

feature -- Resizing

	frozen resized_area (n: INTEGER): like Current is
			-- Create a copy of Current with a count of `n'.
		require
			valid_new_count: n > count
		local
			l_array: like internal_native_array
		do
			create Result.make (n)
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, Result.internal_native_array, l_array.count)
		ensure
			Result_not_void: Result /= Void
			Result_different_from_current: Result /= Current
			new_count: Result.count = n
		end
	
	frozen aliased_resized_area (n: INTEGER): like Current is
			-- Try to resize `Current' with a count of `n', if not
			-- possible a new copy.
		require
			valid_new_count: n > count
		do
			Result := resized_area (n)
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = n
		end

	frozen aliased_resized_area_and_keep (n, j, k: INTEGER): like Current is
			-- Try to resize `Current' with a count of `n', if not
			-- possible a new copy.
		require
			valid_new_count: n > count
			j_positive: j >= 0
			k_positive: k >= 0
			k_valid: k <= count
		do
			create Result.make (n)
			{SYSTEM_ARRAY}.copy (internal_native_array, 0, Result.internal_native_array, j, k)
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = n
		end
	
feature -- Removal

	frozen clear_all is
			-- Reset all items to default values.
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.clear (l_array, 0, l_array.count)
		end

feature {SPECIAL} -- Implementation: Access

	internal_native_array: like native_array;
			-- Access to memory location.

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


