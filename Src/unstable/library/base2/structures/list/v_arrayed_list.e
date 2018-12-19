note
	description: "[
		Lists implemented as arrays.
		The size of list might be smaller than the size of underlying array.
		Random access is constant time. Inserting or removing elements at front or back is amortized constant time.
		Inserting or removing elements in the middle is linear time.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence

class
	V_ARRAYED_LIST [G]

inherit
	V_LIST [G]
		redefine
			default_create,
			put,
			copy
		end

feature {NONE} -- Initialization

	default_create
			-- Create an empty list with default `capacity' and `growth_rate'.
		do
			create array.make (0, default_capacity - 1)
		ensure then
			sequence_effect: sequence.is_empty
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize by copying all the items of `other'.
		note
			modify: sequence
		do
			if other /= Current then
				array := other.array.twin
				first_index := other.first_index
				count := other.count
			end
		ensure then
			sequence_effect: sequence |=| other.sequence
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value associated with `i'.
		do
			Result := array [array_index (i)]
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.

feature -- Iteration

	at (i: INTEGER): V_ARRAYED_LIST_ITERATOR [G]
			-- New iterator pointing at position `i'.
		do
			create {V_ARRAYED_LIST_ITERATOR [G]} Result.make (Current, i)
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Associate `v' with index `i'.
		note
			modify: sequence
		do
			array.put (v, array_index (i))
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' at the front.
		do
			reserve (count + 1)
			if is_empty then
				array [0] := v
				first_index := 0
			else
				first_index := mod_capacity (first_index - 1)
				array [first_index] := v
			end
			count := count + 1
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		do
			count := count + 1
			reserve (count)
			array [array_index (count)] := v
		end

	extend_at (v: G; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			if i = 1 then
				extend_front (v)
			elseif i = count + 1 then
				extend_back (v)
			else
				count := count + 1
				reserve (count)
				circular_copy (i, i + 1, count - i)
				array [array_index (i)] := v
			end
		end

	prepend (input: V_ITERATOR [G])
			-- Prepend sequence of values, over which `input' iterates.
		do
			insert_at (input, 1)
		end

	insert_at (input: V_ITERATOR [G]; i: INTEGER)
			-- Insert sequence of values, over which `input' iterates, starting at position `i'.
		local
			ic: INTEGER
		do
			if i = count + 1 then
				append (input)
			else
				ic := input.count_left
				reserve (count + ic)
				circular_copy (i, i + ic, count - i + 1)
				count := count + ic
				at (i).pipe (input)
			end
		end

feature -- Removal

	remove_front
			-- Remove first element.
		do
			array [array_index (1)] := ({G}).default
			first_index := mod_capacity (first_index + 1)
			count := count - 1
		end

	remove_back
			-- Remove last element.
		do
			array [array_index (count)] := ({G}).default
			count := count - 1
		end

	remove_at (i: INTEGER)
			-- Remove element at position `i'.
		do
			if i = 1 then
				remove_front
			elseif i = count then
				remove_back
			else
				circular_copy (i + 1, i, count - i)
				array [array_index (count)] := ({G}).default
				count := count - 1
			end
		end

	wipe_out
			-- Remove all elements.
		do
			array.clear (0, capacity - 1)
			count := 0
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	array: V_ARRAY [G]
			-- Element storage.

	first_index: INTEGER
			-- Index of the first list element in `array'.

feature {NONE} -- Implementation

	frozen capacity: INTEGER
			-- Size of the underlying array.
		do
			Result := array.count
		end

	default_capacity: INTEGER = 8
			-- Default value for `capacity'.

	growth_rate: INTEGER = 2
			-- Minimum number by which underlying array grows when resized.

	frozen mod_capacity (i: INTEGER): INTEGER
			-- `i' modulo `capacity' in range [`0', `capacity' - 1].
		require
			i_large_enough: i >= -capacity
		do
			Result := (i + capacity) \\ capacity
		ensure
			in_bounds: 0 <= Result and Result < capacity
		end

	frozen array_index (i: INTEGER): INTEGER
			-- Position in `array' of `i'th list element.
		require
			i_non_negative: i >= 0
		do
			Result := mod_capacity (i - 1 + first_index)
		ensure
			in_bounds: 0 <= Result and Result < capacity
		end

	circular_copy (src, dest, n: INTEGER)
			-- Copy `n' elements from position `src' to position `dest'.
		require
			src_non_negative: src >= 0
			dest_non_negative: dest >= 0
		local
			i: INTEGER
		do
			if src < dest then
				from
					i := n
				until
					i < 1
				loop
					array [array_index (dest + i - 1)] := array [array_index (src + i - 1)]
					i := i - 1
				end
			elseif src > dest then
				from
					i := 1
				until
					i > n
				loop
					array [array_index (dest + i - 1)] := array [array_index (src + i - 1)]
					i := i + 1
				end
			end
		end

	reserve (n: INTEGER)
			-- Make sure `array' can accommodate `n' elements;
			-- Do not resize by less than `growth_rate'.
		local
			old_size, new_size: INTEGER
		do
			if capacity < n then
				old_size := capacity
				new_size := n.max (capacity * growth_rate)
				array.resize (0, new_size - 1)
				if first_index > 0 then
					array.array_copy_range (array, first_index, old_size - 1, new_size - old_size + first_index)
					array.clear (first_index, (old_size - 1).min (new_size - old_size + first_index - 1))
					first_index := new_size - old_size + first_index
				end
			end
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements.
		note
			status: specification
		local
			i: INTEGER
		do
			create Result
			from
				i := lower
			until
				i > upper
			loop
				Result := Result & item (i)
				i := i + 1
			end
		end

invariant
	array_non_empty: capacity > 0
	array_starts_from_zero: array.lower = 0
	first_index_in_bounds: 0 <= first_index and first_index < capacity
	count_definition: count = sequence.count
end
