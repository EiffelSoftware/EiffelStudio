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
		redefine
			is_equal,
			copy,
			debug_output
		end

create
	make_empty,
	make_filled,
	make_from_native_array

feature {INTERNAL} -- Initialization

	make_empty (n: INTEGER)
			-- Create a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			create internal_native_array.make (n)
		ensure
			capacity_set: capacity = n
			area_allocated: count = 0
		end

feature {NONE} -- Initialization

	make_filled (v: T; n: INTEGER)
			-- Create a special object for `n' entries initialized with `v'.
		require
			non_negative_argument: n >= 0
		do
			make_empty (n)
			fill_with (v, 0, n - 1)
		ensure
			capacity_set: capacity = n
			count_set: count = n
			filled: filled_with (v, 0, n - 1)
		end

	make_from_native_array (an_array: like native_array)
			-- Create a special object from `an_array'.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			an_array_not_void: an_array /= Void
		do
			if attached {like native_array} an_array.clone as l_array then
				internal_native_array := l_array
			else
				check not_possible: False end
				internal_native_array := an_array
			end
			count := an_array.count
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

	at alias "@" (i: INTEGER): T
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

	native_array: NATIVE_ARRAY [T]
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
			Result := count - 1
		ensure
			definition: lower <= Result + 1
		end

	count: INTEGER
			-- Count of special area

	capacity: INTEGER
			-- Count of special area
		do
			Result := internal_native_array.count
		ensure
			capacity_non_negative: Result >= 0
		end

feature -- Status report

	filled_with (v: T; start_index, end_index: INTEGER): BOOLEAN
			-- Are all items between index `start_index' and `end_index'
			-- set to `v'?
			-- (Use reference equality for comparison.)			
		require
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < count
		local
			i: INTEGER
		do
			from
				Result := True
				i := start_index
			until
				i > end_index or else not Result
			loop
				Result := item (i) = v
				i := i + 1
			end
		end

	same_items (other: like Current; source_index, destination_index, n: INTEGER): BOOLEAN
			-- Are the `n' elements of `other' from `source_index' position the same as
			-- the `n' elements of `Current' from `destination_index'?
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

	force (v: T; i: INTEGER)
			-- If `i' is equal to `count' increase `count' by one and insert `v' at index `count',
			-- otherwise replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_big_enough: i >= 0
			index_small_enough: i <= count
			not_full: i = count implies count < capacity
		do
			if i < count then
				put (v, i)
			else
				extend (v)
			end
		ensure
			count_updated: count = (i + 1).max (old count)
			same_capacity: capacity = old capacity
			inserted: item (i) = v
		end

	extend (v: T)
			-- Add `v' at index `count'.
		require
			count_small_enough: count < capacity
		do
			internal_native_array.put (count, v)
			count := count + 1
		ensure
			count_increased: count = old count + 1
			same_capacity: capacity = old capacity
			inserted: item (count - 1) = v
		end

	extend_filled (v: T)
			-- Set items between `count' and `capacity - 1' with `v'.
		do
			fill_with (v, count, capacity - 1)
		ensure
			same_capacity: capacity = old capacity
			count_increased: count = capacity
			filled: filled_with (v, old count, capacity - 1)
		end

	fill_with (v: T; start_index, end_index: INTEGER)
			-- Set items between `start_index' and `end_index' with `v'.
		require
			start_index_non_negative: start_index >= 0
			start_index_in_bound: start_index <= count
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < capacity
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
			count := count.max (end_index + 1)
		ensure
			same_capacity: capacity = old capacity
			count_definition: count = (old count).max (end_index + 1)
			filled: filled_with (v, start_index, end_index)
		end

	fill_with_default (start_index, end_index: INTEGER)
			-- Clear items between `start_index' and `end_index'.
		require
			is_self_initializing: ({T}).has_default
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < count
		do
			fill_with (({T}).default, start_index, end_index)
		ensure
			filled: filled_with (({T}).default, start_index, end_index)
		end

	insert_data (other: SPECIAL [T]; source_index, destination_index, n: INTEGER)
			-- Insert `n' elements of `other' from `source_index' position to Current at
			-- `destination_index' and shift elements between `destination_index' and `count'
			-- to the right. Other elements of Current remain unchanged.
		require
			other_not_void: other /= Void
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			destination_index_in_bound: destination_index <= count
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= other.count
			n_is_small_enough_for_destination: count + n <= capacity
			same_type: other.conforms_to (Current)
		local
			l_remaining_items: INTEGER
		do
			l_remaining_items := count - destination_index
			if l_remaining_items = 0 then
					-- It is being added at the end of Current, therefore we can simply extend.
				copy_data (other, source_index, destination_index, n)
			else
					-- Simple case where we can perform a move of the existing items to the end
					-- and then copy the elements of `other'.
				{SYSTEM_ARRAY}.copy (internal_native_array, destination_index, internal_native_array, destination_index + n, l_remaining_items)
				{SYSTEM_ARRAY}.copy (other.internal_native_array, source_index, internal_native_array, destination_index, n)
				count := count + n
			end
		ensure
			copied: same_items (other, source_index, destination_index, n)
			count_updated: count = old count + n
		end

	copy_data (other: SPECIAL [T]; source_index, destination_index, n: INTEGER)
			-- Copy `n' elements of `other' from `source_index' position to Current at
			-- `destination_index'. Other elements of Current remain unchanged.
		require
			other_not_void: other /= Void
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			destination_index_in_bound: destination_index <= count
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= other.count
			n_is_small_enough_for_destination: destination_index + n <= capacity
			same_type: other.conforms_to (Current)
		do
			{SYSTEM_ARRAY}.copy (other.internal_native_array, source_index, internal_native_array, destination_index, n)
			count := count.max (destination_index + n)
		ensure
			copied:	same_items (other, source_index, destination_index, n)
			count_updated: count = (old count).max (destination_index + n)
		end

	move_data (source_index, destination_index, n: INTEGER)
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			destination_index_in_bound: destination_index <= count
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= capacity
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, source_index, l_array, destination_index, n)
			count := count.max (destination_index + n)
		ensure
			moved: same_items (old twin, source_index, destination_index, n)
			count_updated: count = (old count).max (destination_index + n)
		end

	overlapping_move (source_index, destination_index, n: INTEGER)
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			destination_index_in_bound: destination_index <= count
			n_non_negative: n >= 0
			different_source_and_target: source_index /= destination_index
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= capacity
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, source_index, l_array, destination_index, n)
			count := count.max (destination_index + n)
		ensure
			moved: same_items (old twin, source_index, destination_index, n)
			count_updated: count = (old count).max (destination_index + n)
		end

	non_overlapping_move (source_index, destination_index, n: INTEGER)
			-- Move `n' elements of Current from `source_start' position to `destination_index'.
			-- Other elements remain unchanged.
		require
			source_index_non_negative: source_index >= 0
			destination_index_non_negative: destination_index >= 0
			destination_index_in_bound: destination_index <= count
			n_non_negative: n >= 0
			different_source_and_target: source_index /= destination_index
			non_overlapping:
				(source_index < destination_index implies source_index + n < destination_index) or
				(source_index > destination_index implies destination_index + n < source_index)
			n_is_small_enough_for_source: source_index + n <= count
			n_is_small_enough_for_destination: destination_index + n <= capacity
		local
			l_array: like internal_native_array
		do
			l_array := internal_native_array
			{SYSTEM_ARRAY}.copy (l_array, source_index, l_array, destination_index, n)
			count := count.max (destination_index + n)
		ensure
			moved: same_items (Current, source_index, destination_index, n)
			count_updated: count = (old count).max (destination_index + n)
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

	keep_head (n: INTEGER)
			-- Keep the first `n' entries.
		require
			non_negative_argument: n >= 0
			less_than_count: n <= count
		do
			set_count (n)
		ensure
			count_updated: count = n
			kept: same_items (old twin, 0, 0, n)
		end

	keep_tail (n: INTEGER)
			-- Keep the last `n' entries.
		require
			non_negative_argument: n >= 0
			less_than_count: n <= count
		do
			overlapping_move (count - n, 0, n)
			set_count (n)
		ensure
			count_updated: count = n
			kept: same_items (old twin, n, 0, n)
		end

	remove_head (n: INTEGER)
			-- Remove the first `n' entries.
		require
			non_negative_argument: n >= 0
			less_than_count: n <= count
		do
			keep_tail (count - n)
		ensure
			count_updated: count = old count - n
			kept: same_items (old twin, n, 0, count)
		end

	remove_tail (n: INTEGER)
			-- Keep the first  `count - n' entries.
		require
			non_negative_argument: n >= 0
			less_than_count: n <= count
		do
			keep_head (count - n)
		ensure
			count_updated: count = old count - n
			kept: same_items (old twin, 0, 0, count)
		end

	resized_area (n: INTEGER): like Current
			-- Create a copy of Current with a count of `n'
		require
			n_non_negative: n >= 0
		do
			create Result.make_empty (n)
			Result.copy_data (Current, 0, 0, n.min (count))
		ensure
			Result_not_void: Result /= Void
			Result_different_from_current: Result /= Current
			new_count: Result.count =  n.min (old count)
			preserved: Result.same_items (Current, 0, 0, n.min (old count))
			capacity_preserved: n <= capacity implies Result.capacity = capacity
			capcity_increased: n > capacity implies Result.capacity = n
		end

	resized_area_with_default (a_default_value: T; n: INTEGER): like Current
			-- Create a copy of Current with a count of `n' where not yet initialized
			-- entries are set to `a_default_value'.
		require
			n_non_negative: n >= 0
		do
			create Result.make_empty (n)
			if n > count then
				Result.copy_data (Current, 0, 0, count)
				Result.fill_with (a_default_value, count, n - 1)
			else
				Result.copy_data (Current, 0, 0, n)
			end
		ensure
			Result_not_void: Result /= Void
			Result_different_from_current: Result /= Current
			new_count: Result.count = n.min (old count)
			preserved: Result.same_items (Current, 0, 0, n.min (old count))
			capacity_preserved: n <= capacity implies Result.capacity = capacity
			capcity_increased: n > capacity implies Result.capacity = n
		end

	aliased_resized_area (n: INTEGER): like Current
			-- Try to resize `Current' with a count of `n', if not
			-- possible a new copy
		require
			n_non_negative: n > count
		do
			Result := resized_area (n)
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = old count
			new_capacity: Result.capacity = n
			preserved: Result.same_items (old twin, 0, 0, old count)
		end

	aliased_resized_area_with_default (a_default_value: T; n: INTEGER): like Current
			-- Try to resize `Current' with a count of `n', if not
			-- possible a new copy. Non yet initialized entries are set to `a_default_value'.
		require
			n_non_negative: n > count
		local
			i: INTEGER
		do
			Result := aliased_resized_area (n)
			from
				i := Result.count
			until
				i = n
			loop
				Result.extend (a_default_value)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
			new_count: Result.count = n
			new_capacity: Result.capacity = n
			preserved: Result.same_items (old twin, 0, 0, old count)
		end

feature -- Removal

	replace_all (v: T)
			-- Replace all items with `v'.
		local
			i: INTEGER
		do
			from
				i := count - 1
			until
				i < 0
			loop
				put (v, i)
				i := i - 1
			end
		ensure
			cleared: filled_with (v, 0, upper)
		end

	wipe_out
			-- Reset count to zero.
		do
			set_count (0)
		ensure
			same_capacity: capacity = old capacity
			count_reset: count = 0
		end

	clear_all
			-- Reset all items to default values.
		obsolete
			"Because of the new precondition, it is recommended to use `fill_with' instead."
		require
			has_default: ({T}).has_default
		do
			fill_with_default (0, upper)
		ensure
			same_capacity: capacity = old capacity
			count_reset: count = old count
		end

feature -- Iteration

	do_all_in_bounds (action: PROCEDURE [ANY, TUPLE [T]]; start_index, end_index: INTEGER)
			-- Apply `action' to every item, from first to last.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_not_void: action /= Void
		local
			i, nb: INTEGER
		do
			from
				i := start_index
				nb := end_index
			until
				i > nb
			loop
				action.call ([item (i)])
				i := i + 1
			end
		end

	do_if_in_bounds (action: PROCEDURE [ANY, TUPLE [T]]; test: FUNCTION [ANY, TUPLE [T], BOOLEAN]; start_index, end_index: INTEGER)
			-- Apply `action' to every item that satisfies `test', from first to last.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_not_void: action /= Void
			test_not_void: test /= Void
		local
			i, nb: INTEGER
		do
			from
				i := start_index
				nb := end_index
			until
				i > nb
			loop
				if test.item ([item (i)]) then
					action.call ([item (i)])
				end
				i := i + 1
			end
		end

	there_exists_in_bounds (test: FUNCTION [ANY, TUPLE [T], BOOLEAN]; start_index, end_index: INTEGER): BOOLEAN
			-- Is `test' true for at least one item?
		require
			test_not_void: test /= Void
		local
			i, nb: INTEGER
		do
			from
				i := start_index
				nb := end_index
			until
				i > nb or Result
			loop
				Result := test.item ([item (i)])
				i := i + 1
			end
		end

	for_all_in_bounds (test: FUNCTION [ANY, TUPLE [T], BOOLEAN]; start_index, end_index: INTEGER): BOOLEAN
			-- Is `test' true for all items?
		require
			test_not_void: test /= Void
		local
			i, nb: INTEGER
		do
			from
				i := start_index
				nb := end_index
				Result := True
			until
				i > nb or not Result
			loop
				Result := test.item ([item (i)])
				i := i + 1
			end
		end

	do_all_with_index_in_bounds (action: PROCEDURE [ANY, TUPLE [T, INTEGER]]; start_index, end_index: INTEGER)
			-- Apply `action' to every item, from first to last.
			-- `action' receives item and its index.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_not_void: action /= Void
		local
			i, j, nb: INTEGER
		do
			from
				i := start_index
				j := lower
				nb := end_index
			until
				i > nb
			loop
				action.call ([item (i), j])
				j := j + 1
				i := i + 1
			end
		end

	do_if_with_index_in_bounds (action: PROCEDURE [ANY, TUPLE [T, INTEGER]]; test: FUNCTION [ANY, TUPLE [T, INTEGER], BOOLEAN]; start_index, end_index: INTEGER)
			-- Apply `action' to every item that satisfies `test', from first to last.
			-- `action' and `test' receive the item and its index.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_not_void: action /= Void
			test_not_void: test /= Void
		local
			i, j, nb: INTEGER
		do
			from
				i := start_index
				j := lower
				nb := end_index
			until
				i > nb
			loop
				if test.item ([item (i), j]) then
					action.call ([item (i), j])
				end
				j := j + 1
				i := i + 1
			end
		end

feature -- Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := Precursor
			Result.append_string (", capacity=")
			Result.append_integer (capacity)
		end

feature {NONE} -- Implementation

	set_count (n: INTEGER)
			-- Set `count' with `n'.
		require
			n_non_negative: n >= 0
			valid_new_count: n <= count
		do
			count := n
		ensure
			count_set: count = n
			capacity_preserved: capacity = old capacity
		end

feature {SPECIAL} -- Implementation: Access

	internal_native_array: like native_array;
			-- Access to memory location.

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SPECIAL
