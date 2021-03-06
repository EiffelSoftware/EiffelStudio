note
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

create
	make,
	make_from_native_array

feature {NONE} -- Initialization

	frozen make (n: INTEGER)
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			-- Built-in
		ensure
			area_allocated: count = n
		end

	frozen make_from_native_array (an_array: like native_array)
			-- Creates a special object from `an_array'.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			an_array_not_void: an_array /= Void
		do
		end

feature -- Access

	frozen item alias "[]", frozen infix "@" (i: INTEGER): T assign put
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

	frozen item_address (i: INTEGER): POINTER
			-- Address of element at position `i'.
		require
			not_dotnet: not {PLATFORM}.is_dotnet
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
		require
			not_dotnet: not {PLATFORM}.is_dotnet
		do
			Result := $Current
		ensure
			base_address_not_null: Result /= default_pointer
		end

	frozen native_array: NATIVE_ARRAY [T]
			-- Only for compatibility with .NET
		require
			is_dotnet: {PLATFORM}.is_dotnet
		do
		end

feature -- Measurement

	lower: INTEGER = 0
			-- Minimum index of Current

	frozen upper: INTEGER
			-- Maximum index of Current
		do
			Result := {ISE_RUNTIME}.sp_count ($Current) - 1
		end

	frozen count, frozen capacity: INTEGER
			-- Count of the special area
		do
			Result := {ISE_RUNTIME}.sp_count ($Current)
		end

feature -- Status report

	frozen all_default (upper_bound: INTEGER): BOOLEAN
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

	frozen same_items (other: like Current; upper_bound: INTEGER): BOOLEAN
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

	frozen valid_index (i: INTEGER): BOOLEAN
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < count)
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

	frozen fill_with (v: T; start_index, end_index: INTEGER)
			-- Set items between `start_index' and `end_index' with `v'.
		require
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index
			end_index_valid: end_index < count
		local
			i, nb: INTEGER
		do
			from
				i := start_index
				nb := end_index + 1
			until
				i = nb
			loop
				put (v, i)
				i := i + 1
			end
		end

	frozen copy_data (other: SPECIAL [T]; source_index, destination_index, n: INTEGER)
			-- Copy `n' elements of `other' from `source_index' position to Current at
			-- `destination_index'. Other elements of Current remain unchanged.
		require
			other_not_void: other /= Void
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= other.count
			n_is_small_enough_for_destination: destination_index + n <= count
			same_type: same_type (other)
		local
			i, j, nb: INTEGER
		do
			if other = Current then
				move_data (source_index, destination_index, n)
			else
				from
					i := source_index
					j := destination_index
					nb := source_index + n
				until
					i = nb
				loop
					put (other.item (i), j)
					i := i + 1
					j := j + 1
				end
			end
		end

	frozen move_data (source_index, destination_index, n: INTEGER)
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= count
		do
			if source_index = destination_index then
			elseif source_index > destination_index then
				if destination_index + n < source_index then
					non_overlapping_move (source_index, destination_index, n)
				else
					overlapping_move (source_index, destination_index, n)
				end
			else
				if source_index + n < destination_index then
					non_overlapping_move (source_index, destination_index, n)
				else
					overlapping_move (source_index, destination_index, n)
				end
			end
		end

	frozen overlapping_move (source_index, destination_index, n: INTEGER)
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
			i, nb: INTEGER
			l_offset: INTEGER
		do
			if source_index < destination_index then
					-- We shift from left to right starting from the end
					-- due to possible overlapping.
				from
					i := source_index + n - 1
					nb := source_index - 1
					l_offset := destination_index - source_index
					check
						l_offset_positive: l_offset > 0
					end
				until
					i = nb
				loop
					put (item (i), i + l_offset)
					i := i - 1
				end
			else
					-- We shift from right to left.
				from
					i := source_index
					nb := source_index + n
					l_offset := source_index - destination_index
					check
						l_offset_positive: l_offset > 0
					end
				until
					i = nb
				loop
					put (item (i), i - l_offset)
					i := i + 1
				end
			end
		end

	frozen non_overlapping_move (source_index, destination_index, n: INTEGER)
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
			i, nb: INTEGER
			l_offset: INTEGER
		do
			from
				i := source_index
				nb := source_index + n
				l_offset := destination_index - source_index
			until
				i = nb
			loop
				put (item (i), i + l_offset)
				i := i + 1
			end
		end

feature -- Resizing

	frozen resized_area (n: INTEGER): like Current
			-- Create a copy of Current with a count of `n'.
		require
			valid_new_count: n > count
		do
			create Result.make (n)
			Result.copy_data (Current, 0, 0, count)
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

	frozen aliased_resized_area_and_keep (n, j, k: INTEGER): like Current
			-- Try to resize `Current' with a count of `n' and keeping the old
			-- content between indices `j', `k'. If not possible a new copy.
		require
			n_non_negative: n >= 0
			j_non_negative: j >= 0
			k_non_negative: k >= 0
			k_valid: k <= count
		do
			Result := sparycpy ($Current, n, j, k)
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
			"C signature (EIF_REFERENCE): EIF_INTEGER use %"eif_eiffel.h%""
		end

note
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


