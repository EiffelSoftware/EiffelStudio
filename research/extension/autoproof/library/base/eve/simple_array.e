note
	description: "Array with specification usable in AutoProof."
	status: skip

frozen class
	SIMPLE_ARRAY [G]

inherit

	ITERABLE [G]

create
	make_empty, make, make_from_array, init

feature {NONE} -- Initialization

	make_empty
			-- Create an empty array.
		note
			status: creator
		do
			create sequence
		ensure
			empty_array: count = 0
		end

	make (n: INTEGER)
			-- Create an array of size `n' filled with default values.
		note
			status: creator
		require
			n_non_negative: n >= 0
		do
			create sequence.constant (({G}).default, n)
		ensure
			count_set: count = n
			all_default: across sequence.domain as i all sequence [i] = ({G}).default end
		end

	make_from_array (a: SIMPLE_ARRAY [G])
			-- Create an array with the same elements as `a'.
		note
			status: creator
		do
			sequence := a.sequence
		ensure
			same_elements: sequence = a.sequence
		end

	init (s: MML_SEQUENCE [G])
			-- Create an array an initialize it with elements of `s'.
		note
			status: creator
		do
			sequence := s
		ensure
			count_set: count = s.count
			sequence_set: sequence = s
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of values.

feature -- Access

	count: INTEGER
			-- Number of elements.
		note
			status: functional
		require
			reads (Current)
		do
			Result := sequence.count
		ensure
			definition: Result = sequence.count
		end

	item alias "[]" (i: INTEGER): G assign put
			-- Item at position `i'.
		require
			in_bounds: 1 <= i and i <= count
			valid_index: valid_index (i)
			reads (Current)
		do
			Result := sequence[i]
		ensure
			definition: Result = sequence [i]
		end

	subarray (l, u: INTEGER): SIMPLE_ARRAY [G]
			-- Subarray from `l' to `u' (inclusive).
		note
			status: impure
		require
			l_not_too_small: l >= 1
			u_not_too_large: u <= count
			l_not_too_large: l <= u + 1
		do
			create Result.init (sequence.interval (l, u))
		ensure
			result_wrapped: Result.is_wrapped
			result_fresh: Result.is_fresh
			result_sequence_definition: Result.sequence ~ sequence.interval (l, u)
			result_count_definition: Result.count = (u - l + 1)
		end

	new_cursor: ITERATION_CURSOR [G]
			-- <Precursor>
		note
			status: impure
		do
				-- TODO: provide implementation.
			check is_implemented: False then end
		end

feature -- Status report

	has (v: G): BOOLEAN
			-- Does the array contain `v'?
		note
			status: functional
		do
			Result := sequence.has (v)
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index into the array?
		note
			status: functional
		require
			reads (Current)
		do
			Result := 1 <= i and i <= sequence.count
		end

feature -- Modification

	put (v: G; i: INTEGER)
			-- Update value at position `i' with `v'.
		require
			in_bounds: 1 <= i and i <= count
			valid_index: valid_index (i)
		do
			sequence := sequence.replaced_at (i, v)
			check sequence.count > 0 end
			check count > 0 end
		ensure
			same_count: count = old count
			sequence_effect: sequence = old sequence.replaced_at (i, v)
		end

	force (v: G; i: INTEGER)
			-- Update value at position `i' with `v'.
		require
			in_bounds: 1 <= i and i <= count + 1
		do
			if i = count + 1 then
				sequence := sequence.extended (v)
			else
				sequence := sequence.replaced_at (i, v)
			end
		ensure
			count_effect: (i = old count + 1) implies count = old count + 1
			sequence_effect: (i = old count + 1) implies sequence = old sequence.extended (v)
			count_effect: (i <= old count) implies count = old count
			sequence_effect: (i <= old count) implies sequence = old sequence.replaced_at (i, v)
		end

	remove_at (i: INTEGER)
			-- Remove element at position `i'.
		require
			in_bounds: 1 <= i and i <= count + 1
			valid_index: valid_index (i)
		do
			sequence := sequence.removed_at (i)
		ensure
			count_reduced: count = old count - 1
			sequence_effect: sequence = old sequence.removed_at (i)
		end

invariant
	count_definition: count >= 0 and count = sequence.count

end
