note
	description: "[
			Lists implemented as ring buffers.
			The size of list might be smaller than the size of underlying array.
			Random access is constant time. Inserting or removing elements at front or back is amortized constant time.
			Inserting or removing elements in the middle is linear time.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence
	manual_inv: true
	false_guards: true

class
	V_ARRAYED_LIST [G]

inherit
	V_LIST [G]
		redefine
			default_create,
			is_equal_
		end

feature {NONE} -- Initialization

	default_create
			-- Create an empty list with default `capacity' and `growth_rate'.
		note
			status: creator
		do
			create array.make (0, default_capacity - 1)
		ensure then
			sequence_effect: sequence.is_empty
			observers_empty: observers.is_empty
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize by copying all the items of `other'.
		require
			observers_open: ∀ o: observers ¦ o.is_open
		do
			if other /= Current then
				other.unwrap
				create array.copy_ (other.array)
				other.wrap
				first_index := other.first_index
				count_ := other.count_
				sequence := other.sequence
			end
		ensure
			sequence_effect: sequence ~ old other.sequence
			modify_model ("sequence", Current)
			modify_field ("closed", other)
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value associated with `i'.
		do
			check inv end
			Result := array [array_index (i)]
		end

feature -- Iteration

	at (i: INTEGER): V_ARRAYED_LIST_ITERATOR [G]
			-- New iterator pointing at position `i'.
		note
			status: impure
		do
			create Result.make (Current, i)
			check Result.inv end
			check inv_only ("lower_definition") end
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is list made of the same values in the same order as `other'?
			-- (Use reference comparison.)
		local
			i: INTEGER
		do
			if other = Current then
				Result := True
			elseif count = other.count then
				from
					Result := True
					i := 1
				invariant
					1 <= i and i <= sequence.count + 1
					inv
					other.inv
					if Result
						then ∀ k: 1 |..| (i - 1) ¦ sequence [k] = other.sequence [k]
						else sequence [i - 1] /= other.sequence [i - 1] end
				until
					i > count_ or not Result
				loop
					Result := item (i) = other.item (i)
					i := i + 1
				variant
					sequence.count - i
				end
			end
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Associate `v' with index `i'.
		do
			array.put (v, array_index (i))
			sequence := sequence.replaced_at (i, v)
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' at the front.
		note
			explicit: wrapping
		do
			reserve (count_ + 1)
			unwrap
			if count_ = 0 then
				array [0] := v
				first_index := 0
			else
				first_index := mod_capacity (first_index - 1)
				array [first_index] := v
			end
			count_ := count_ + 1
			sequence := sequence.prepended (v)
			wrap
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		note
			explicit: wrapping
		do
			reserve (count_ + 1)
			unwrap
			count_ := count_ + 1
			array [array_index (count_)] := v
			sequence := sequence & v
			wrap
		end

	extend_at (v: G; i: INTEGER)
			-- Insert `v' at position `i'.
		note
			explicit: wrapping
		do
			check inv_only ("count_definition") end
			if i = 1 then
				extend_front (v)
				check sequence = sequence.old_.extended_at (i, v) end
			elseif i = count_ + 1 then
				extend_back (v)
				check sequence = sequence.old_.extended_at (i, v) end
			else
				reserve (count_ + 1)
				unwrap
				count_ := count_ + 1
				circular_copy (i, i + 1, count_ - i)
				array [array_index (i)] := v
				sequence := sequence.extended_at (i, v)
				wrap
			end
		end

	prepend (input: V_ITERATOR [G])
			-- Prepend sequence of values, over which `input' iterates.
		note
			explicit: wrapping
		do
			insert_at (input, 1)
		end

	insert_at (input: V_ITERATOR [G]; i: INTEGER)
			-- Insert sequence of values, over which `input' iterates, starting at position `i'.
		note
			explicit: wrapping
		local
			ic, j, new_capacity: INTEGER
		do
			check input.inv_only ("subjects_definition", "index_constraint", "target_bag_constraint") end
			ic := input.target.count - input.index + 1
			reserve (count_ + ic)
			unwrap
			if i < count_ + 1 then
				circular_copy (i, i + ic, count_ - i + 1)
			end
			new_capacity := array.sequence.count
			sequence := sequence.front (i - 1) + input.sequence.tail (input.index) + sequence.tail (i)

			from
				j := 0
			invariant
				0 <= j and j <= ic
				input.index_ = input.index_.old_ + j
				array.is_wrapped
				input.is_wrapped
				array.sequence.count = new_capacity
				∀ k: 1 |..| sequence.count ¦
						k <= i - 1 + j or i + ic <= k implies sequence [k] = array.sequence [array_seq_index (k)]
				modify_model ("sequence", array)
				modify_model ("index_", input)
			until
				input.after
			loop
				array [array_index (i + j)] := input.item
				j := j + 1
				input.forth
			variant
				ic - j
			end
			count_ := count_ + ic
			wrap
		end

feature -- Removal

	remove_front
			-- Remove first element.
		do
			first_index := mod_capacity (first_index + 1)
			count_ := count_ - 1
			sequence := sequence.but_first
		end

	remove_back
			-- Remove last element.
		do
			count_ := count_ - 1
			sequence := sequence.but_last
		end

	remove_at (i: INTEGER)
			-- Remove element at position `i'.
		note
			explicit: wrapping
		do
			check inv_only ("count_definition") end
			if i = 1 then
				remove_front
			elseif i = count_ then
				remove_back
			else
				unwrap
				circular_copy (i + 1, i, count_ - i)
				count_ := count_ - 1
				sequence := sequence.removed_at (i)
				wrap
			end
		end

	wipe_out
			-- Remove all elements.
		do
			count_ := 0
			create sequence
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	array: V_ARRAY [G]
			-- Element storage.

	first_index: INTEGER
			-- Index of the first list element in `array'.

feature {NONE} -- Implementation

	frozen capacity: INTEGER
			-- Size of the underlying array.
		require
			array_closed: array.closed
			reads (universe)
		do
			Result := array.count
		ensure
			Result = array.sequence.count
		end

	default_capacity: INTEGER = 8
			-- Default value for `capacity'.

	growth_rate: INTEGER = 2
			-- Minimum number by which underlying array grows when resized.

	frozen mod_capacity (i: INTEGER): INTEGER
			-- `i' modulo `capacity' in range [`0', `capacity' - 1].
		require
			array_closed: array.closed
			i_in_bounds: -1 <= i and i < 2 * array.sequence.count
			inv_only ("array_non_empty")
			reads (universe)
		do
			Result := (i + capacity) \\ capacity
		ensure
			in_bounds: 0 <= Result and Result < array.sequence.count
			i = -1 implies Result = array.sequence.count - 1
			0 <= i and i < array.sequence.count implies Result = i
			array.sequence.count <= i implies Result = i - array.sequence.count
		end

	frozen array_index (i: INTEGER): INTEGER
			-- Position in `array' of `i'th list element.
		require
			array_closed: array.closed
			inv_only ("array_non_empty", "first_index_in_bounds")
			i_in_bounds: 1 <= i and i <= array.sequence.count
			reads (universe)
		do
			Result := mod_capacity (i - 1 + first_index)
		ensure
			Result = array_seq_index (i) - 1
		end

	circular_copy (src, dest, n: INTEGER)
			-- Copy `n' elements from position `src' to position `dest'.
		require
			array_wrapped: array.is_wrapped
			n_non_neagtive: n >= 0
			src_non_negative: 1 <= src and src <= array.sequence.count - n + 1
			dest_in_bounds: 1 <= dest and dest <= array.sequence.count - n + 1
			inv_only ("array_non_empty", "first_index_in_bounds", "array_no_observers", "array_starts_from_zero")
		local
			i: INTEGER
		do
			if src < dest then
				from
					i := n
				invariant
					i_in_bounds: 0 <= i and i <= n
					array_wrapped: array.is_wrapped
					inv_only ("array_non_empty", "first_index_in_bounds", "array_no_observers", "array_starts_from_zero")
					array.sequence.count = array.sequence.count.old_
					∀ k: (array_index_set (dest + i, dest + n - 1)) ¦
							array.sequence [k] = array.sequence.old_ [array_seq_index (list_index (k) - dest + src)]
					∀ k: 1 |..| array.sequence.count ¦ not array_index_set (dest + i, dest + n - 1) [k] implies array.sequence [k] = array.sequence.old_ [k]
				until
					i < 1
				loop
					array [array_index (dest + i - 1)] := array [array_index (src + i - 1)]
					i := i - 1
				end
				check ∀ k: (array_index_set (dest, dest + n - 1)) ¦ array.sequence [k] = array.sequence.old_ [array_seq_index (list_index (k) - dest + src)] end
			elseif src > dest then
				from
					i := 1
				invariant
					i_in_bounds: 1 <= i and i <= n + 1
					array_wrapped: array.is_wrapped
					inv_only ("array_non_empty", "first_index_in_bounds", "array_no_observers", "array_starts_from_zero")
					array.sequence.count = array.sequence.count.old_
					∀ k: (array_index_set (dest, dest + i - 2)) ¦
							array.sequence [k] = array.sequence.old_ [array_seq_index (list_index (k) - dest + src)]
					∀ k: 1 |..| array.sequence.count ¦ not array_index_set (dest, dest + i - 2) [k] implies array.sequence [k] = array.sequence.old_ [k]
				until
					i > n
				loop
					array [array_index (dest + i - 1)] := array [array_index (src + i - 1)]
					i := i + 1
				end
				check ∀ k: (array_index_set (dest, dest + n - 1)) ¦ array.sequence [k] = array.sequence.old_ [array_seq_index (list_index (k) - dest + src)] end
			end
		ensure
			array_wrapped: array.is_wrapped
			inv_only ("array_non_empty", "first_index_in_bounds", "array_no_observers", "array_starts_from_zero")
			sequence_domain_effect: array.sequence.count = old array.sequence.count
			sequence_effect_new: ∀ k: (array_index_set (dest, dest + n - 1)) ¦
					∀ l: 1 |..| array.sequence.count ¦
						l = array_seq_index (list_index (k) - dest + src) implies array.sequence [k] = (old array.sequence) [l]
			sequence_effect_old: ∀ k: 1 |..| array.sequence.count ¦ not array_index_set (dest, dest + n - 1) [k] implies array.sequence [k] = array.sequence.old_ [k]
			modify_model ("sequence", array)
		end

	reserve (n: INTEGER)
			-- Make sure `array' can accommodate `n' elements;
			-- Do not resize by less than `growth_rate'.
		note
			explicit: contracts
		require
			wrapped: is_wrapped
			observers_open: ∀ o: observers ¦ o.is_open
		local
			old_size, new_size: INTEGER
		do
			unwrap
			if capacity < n then
				old_size := capacity
				new_size := n.max (capacity * growth_rate)
				array.resize (0, new_size - 1)
				if first_index + count_ > old_size then
					array.copy_range_within (first_index, old_size - 1, new_size - old_size + first_index)
					array.clear (first_index, (old_size - 1).min (new_size - old_size + first_index - 1))
					first_index := new_size - old_size + first_index
				end
			end
			wrap
		ensure
			at_least_n: array.sequence.count >= n
			at_least_old: array.sequence.count >= old array.sequence.count
			wrapped: is_wrapped
			modify_field (["first_index", "closed"], Current)
		end

feature {NONE} -- Specification

	array_seq_index (i: INTEGER): INTEGER
			-- Index in `array.sequence' that corresponds to index `i' in `sequence'.
		note
			status: ghost, functional
		require
			array_exists: array /= Void
			i_in_bounds: 1 <= i and i <= array.sequence.count
			inv_only ("first_index_in_bounds")
			reads_field (["array", "first_index"], Current)
			reads_field ("sequence", array)
		do
			Result := if i + first_index <= array.sequence.count then i + first_index else i + first_index - array.sequence.count end
		ensure
			result_in_bounds: 1 <= Result and Result <= array.sequence.count
		end

	list_index (i: INTEGER): INTEGER
			-- Index in `sequence' that corresponds to index `i' in `array.sequence'.
		note
			status: ghost, functional
		require
			array_exists: array /= Void
			i_in_bounds: 1 <= i and i <= array.sequence.count
			inv_only ("first_index_in_bounds")
			reads_field (["array", "first_index"], Current)
			reads_field ("sequence", array)
		do
			Result := if i - first_index >= 1 then i - first_index else i - first_index + array.sequence.count end
		ensure
			result_in_bounds: 1 <= Result and Result <= array.sequence.count
		end

	array_index_set (lo, hi: INTEGER): MML_SET [INTEGER]
			-- Set of indexes in `array_sequence' that corresponds to index interval `i'..`j' in `sequence'.
		note
			status: ghost, functional
		require
			array_exists: array /= Void
			lo_large_enough: 1 <= lo + first_index
			hi_small_enough: hi + first_index <= 2 * array.sequence.count
			inv_only ("first_index_in_bounds")
			reads_field (["array", "first_index"], Current)
			reads_field ("sequence", array)
		do
			Result := create {MML_INTERVAL}.from_range (lo + first_index, (hi + first_index).min (array.sequence.count)) +
				create {MML_INTERVAL}.from_range ((lo + first_index - array.sequence.count).max (1), hi + first_index - array.sequence.count)
		ensure
			result_in_domain: Result <= array.sequence.domain
		end

invariant
	array_exists: array /= Void
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (array)
	array_non_empty: array.sequence.count > 0
	array_starts_from_zero: array.lower_ = 0
	first_index_in_bounds: 0 <= first_index and first_index < array.sequence.count
	sequence_count_constraint: sequence.count <= array.sequence.count
	sequence_implementation: ∀ i: 1 |..| sequence.count ¦ sequence [i] = array.sequence [array_seq_index (i)]
	array_no_observers: array.observers.is_empty

note
	explicit: observers
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
