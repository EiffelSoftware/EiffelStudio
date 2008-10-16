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

	make (n: INTEGER)
			-- Create a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			create internal_native_array.make (n)
		ensure
			area_allocated: count = n
		end

feature {NONE} -- Initialization

	make_from_native_array (an_array: like native_array)
			-- Create a special object from `an_array'.
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

	item alias "[]" (i: INTEGER): T assign put
			-- Item at `i'-th position
			-- (indices begin at 0)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			Result := internal_native_array.item (i)
		end

	infix "@" (i: INTEGER): T
			-- Item at `i'-th position
			-- (indices begin at 0)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			Result := item (i)
		end

	index_of (v: T; start_position: INTEGER): INTEGER
			-- Index of first occurrence of item identical to `v'.
			-- -1 if none.
			-- (Use object equality for comparison.)
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

	item_address (i: INTEGER): POINTER
			-- Address of element at position `i'
		require
			not_dotnet: not {PLATFORM}.is_dotnet
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
		ensure
			element_address_not_null: Result /= default_pointer
		end

	base_address: POINTER
			-- Address of element at position `0'
		require
			not_dotnet: not {PLATFORM}.is_dotnet
		do
		ensure
			base_address_not_null: Result /= default_pointer
		end

	native_array: ?NATIVE_ARRAY [T]
			-- Only for compatibility with .NET
		require
			is_dotnet: {PLATFORM}.is_dotnet
		do
			Result := internal_native_array
		end

feature -- Measurement

	lower: INTEGER = 0
			-- Minimum index of Current

	upper: INTEGER
			-- Maximum index of Current
		do
			Result := internal_native_array.count - 1
		ensure
			definition: lower <= Result + 1
		end

	count: INTEGER
			-- Count of special area
		do
			Result := internal_native_array.count
		end
	
	capacity: INTEGER
			-- Count of special area
		do
			Result := internal_native_array.count
		ensure
			capacity_non_negative: Result >= 0
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

	same_items (other: like Current; source_index, destination_index, n: INTEGER): BOOLEAN
			-- Do all items between index `start_index' and `end_index' have
			-- same value?
			-- (Use reference equality for comparison.)
		require
			other_not_void: other /= Void
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= other.count
			n_is_small_enough_for_destination: destination_index + n <= count
		local
			i, j, nb: INTEGER
		do
			Result := True
			if other /= Current then
				from
					i := source_index
					j := destination_index
					nb := source_index + n
				until
					i = nb
				loop
					if other.item (i) /= item (j) then
						Result := False
						i := nb - 1
					end
					i := i + 1
					j := j + 1
				end
			end
		ensure
			valid_on_empty_area: (n = 0) implies Result
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and (i < count)
		ensure
			definition: Result = ((0 <= i) and (i < count))
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_other_count: INTEGER
		do
			if other /= Current then
				l_other_count := other.count
				if count = l_other_count then
					Result := same_items (other, 0, 0, l_other_count)
				end
			else
				Result := True
			end
		end

feature -- Element change

	put (v: T; i: INTEGER)
			-- Replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_big_enough: i >= 0
			index_small_enough: i < count
		do
			internal_native_array.put (i, v)
		ensure
			inserted: item (i) = v
		end

	fill_with (v: T; start_index, end_index: INTEGER)
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
		ensure
			filled: -- For every `i' in `start_index' .. `end_index', `item' (`i') = `v'
		end

	copy_data (other: SPECIAL [T]; source_index, destination_index, n: INTEGER)
			-- Copy `n' elements of `other' from `source_index' position to Current at
			-- `destination_index'. Other elements of Current remain unchanged.
		require
			other_not_void: other /= Void
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= other.count
			n_is_small_enough_for_destination: destination_index + n <= count
			same_type: other.conforms_to (Current)
		do
			{SYSTEM_ARRAY}.copy (other.internal_native_array, source_index, internal_native_array, destination_index, n)
		ensure
			copied:	same_items (other, source_index, destination_index, n)
		end

	move_data (source_index, destination_index, n: INTEGER)
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
		ensure
			moved: same_items (old twin, source_index, destination_index, n)
		end

	overlapping_move (source_index, destination_index, n: INTEGER)
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
		ensure
			moved: same_items (old twin, source_index, destination_index, n)
		end

	non_overlapping_move (source_index, destination_index, n: INTEGER)
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
		ensure
			moved: same_items (Current, source_index, destination_index, n)
		end

feature -- Duplication

	copy (other: like Current)
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

	resized_area (n: INTEGER): like Current
			-- Create a copy of Current with a count of `n'
		require
			n_non_negative: n >= 0
		local
			l_array: like internal_native_array
		do
			create Result.make (n)
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, Result.internal_native_array, n.min (l_array.count))
		ensure
			Result_not_void: Result /= Void
			Result_different_from_current: Result /= Current
			new_count: Result.count = n
			preserved: Result.same_items (Current, 0, 0, n.min (old count))
		end

	aliased_resized_area (n: INTEGER): like Current
			-- Try to resize `Current' with a count of `n', if not
			-- possible a new copy
		require
			valid_new_count: n > count
		do
			Result := resized_area (n)
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = n
			preserved: Result.same_items (old twin, 0, 0, old count)
		end

feature -- Removal

	clear_all
			-- Reset all items to default values.
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.clear (l_array, 0, l_array.count)
		ensure
			cleared: all_default (0, upper)
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


