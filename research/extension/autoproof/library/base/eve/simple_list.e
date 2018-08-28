note
	description: "List with specifications usable in AutoProof."
	status: skip

frozen class
	SIMPLE_LIST [G]

inherit

	ITERABLE [G]

create
	make

feature {NONE} -- Initialization

	make
			-- Create an empty list.
		note
			status: creator
		do
			create sequence.default_create
		ensure
			empty: is_empty
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of list's elements.
		note
			status: ghost
		attribute
		end

feature -- Access

	is_empty: BOOLEAN
			-- Is the list empty?
		require
			reads (Current)
		do
			Result := sequence.is_empty
		ensure
			definition: Result = sequence.is_empty
		end

	count: INTEGER
			-- Number of elements in the list.
		require
			reads (Current)
		do
			Result := sequence.count
		ensure
			definition: Result = sequence.count
		end

	item alias "[]" (i: INTEGER): G
			-- Element at index `i'.
		require
			in_bounds: 1 <= i and i <= count
			reads (Current)
		do
			Result := sequence [i]
		ensure
			definition: Result = sequence [i]
		end

	has (x: G) : BOOLEAN
			-- Is `x' an element of the list?
		require
			reads (Current)
		do
			Result := sequence.has (x)
		ensure
			definition: Result = sequence.has (x)
		end

	new_cursor: ITERATION_CURSOR [G]
			-- <Precursor>
		note
			status: impure
		do
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' in the front.
		do
			sequence := sequence.prepended (v)
		ensure
			sequence_effect: sequence = old (sequence.prepended (v))
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		do
			sequence := sequence & v
		ensure
			sequence_effect: sequence = old (sequence & v)
		end

feature -- Modification

	put (v: G; i: INTEGER)
			-- Update value at position `i' with `v'.
		require
			in_bounds: 1 <= i and i <= count
		do
			sequence := sequence.replaced_at (i, v)
		ensure
			same_count: count = old count
			sequence_effect: sequence = old sequence.replaced_at (i, v)
		end

	remove_at (i: INTEGER)
			-- Remove element at position `i'.
		require
			in_bounds: 1 <= i and i <= count
		do
			sequence := sequence.removed_at (i)
		ensure
			count_reduced: sequence.count = old sequence.count - 1
			sequence_effect: sequence = old sequence.removed_at (i)
		end

end
