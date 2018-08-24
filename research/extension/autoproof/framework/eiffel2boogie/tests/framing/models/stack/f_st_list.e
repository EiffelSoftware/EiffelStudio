note
	description: "Minimal list interface."
	model: sequence

class F_ST_LIST [G]

create
	make

feature {NONE} -- Initialization

	make
			-- Create an empty list.
		note
			status: creator
		do
		ensure
			empty: is_empty
		end

feature -- Access

	is_empty: BOOLEAN
			-- Is the list empty?
		do
			Result := sequence.is_empty
		ensure
			definition: Result = sequence.is_empty
		end

	count: INTEGER
			-- Number of elements in the list.
		do
			Result := sequence.count
		ensure
			definition: Result = sequence.count
		end

	item alias "[]" (i: INTEGER): G
			-- Element at index `i'.
		require
			in_bounds: 1 <= i and i <= count
		do
			Result := sequence [i]
		ensure
			definition: Result = sequence [i]
		end

	has (x: G) : BOOLEAN
			-- Is `x' an element of the list?
		do
			Result := sequence.has (x)
		ensure
			definition: Result = sequence.has (x)
		end

feature -- Element change

	extend_back (v: G)
			-- Insert `v' at the back.
		require
			modify_model ("sequence", Current)
		do
			sequence := sequence & v
		ensure
			sequence_effect: sequence = old (sequence & v)
		end

	remove_back
			-- Remove the last element.
		require
			not_empty: not is_empty
			modify_model ("sequence", Current)
		do
			sequence := sequence.but_last
		ensure
			sequence_effect: sequence = old (sequence.but_last)
		end

	wipe_out
		do
			sequence := {MML_SEQUENCE [G]}.empty_sequence
		ensure
			sequence_effect: sequence.count = 0
		end


feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of list's elements.
		note
			status: ghost
		attribute
		end

end
