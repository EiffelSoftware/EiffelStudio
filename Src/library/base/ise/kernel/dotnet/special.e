indexing
	description: "[
		Special objects: homogeneous sequences of values, 
		used to represent arrays and strings
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature {INTERNAL} -- Initialization

	frozen make (n: INTEGER) is
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			create internal_native_array.make (n)
		ensure
			area_allocated: count = n
		end

feature {NONE} -- Initializaiton

	frozen make_from_native_array (an_array: like native_array) is
			-- Creates a special object from `an_array'.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			an_array_not_void: an_array /= Void
		do
			internal_native_array ?= an_array.clone
		ensure
				-- Commented because `equals' in .NET does not compare the content of arrays.
--			native_array_set: native_array.equals (an_array)
		end

feature -- Access

	frozen item alias "[]", frozen infix "@" (i: INTEGER): T assign put is
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

	all_default (start_index, end_index: INTEGER): BOOLEAN
			-- Are all items between index `start_index' and `end_index'
			-- set to default values?
		require
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < count
		local
			i: INTEGER
			t: T
		do
			from
				Result := True
				i := start_index
			until
				i > end_index or else not Result
			loop
				Result := item (i) = t
				i := i + 1
			end
		ensure
			valid_on_empty_area: (end_index < start_index) implies Result
		end

	same_items (other: like Current; start_index, end_index: INTEGER): BOOLEAN
			-- Do all items between index `start_index' and `end_index' have
			-- same value?
			-- (Use reference equality for comparison.)
		require
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < count
			other_not_void: other /= Void
			other_has_enough_items: end_index < other.count
		local
			i: INTEGER
		do
			from
				Result := True
				i := start_index
			until
				i > end_index or else not Result
			loop
				Result := item (i) = other.item (i)
				i := i + 1
			end
		ensure
			valid_on_empty_area: (end_index < start_index) implies Result
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
		local
			l_other_count: INTEGER
		do
			if other /= Current then
				l_other_count := other.count
				if count = l_other_count then
					Result := same_items (other, 0, l_other_count - 1)
				end
			else
				Result := True
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
			start_index_not_too_big: start_index <= end_index + 1
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
			-- Try to resize `Current' with a count of `n' and keeping the old
			-- content between indices `j', `k'. If not possible a new copy.
		require
			n_non_negative: n >= 0
			j_non_negative: j >= 0
			k_non_negative: k >= 0
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
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class SPECIAL


