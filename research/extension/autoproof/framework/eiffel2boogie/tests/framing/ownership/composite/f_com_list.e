note
	description: "Minimal list interface."
	status: skip

class F_COM_LIST [G]

create
	make

feature {NONE} -- Initialization

	make
			-- Create an empty list.
		note
			skip: True
			status: creator
		do
		ensure
			empty: is_empty
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of list's elements.
		note
			skip: True
			status: ghost
		attribute
		end

feature -- Access

	is_empty: BOOLEAN
			-- Is the list empty?
		note
			skip: True
		require
			closed: closed
		do
		ensure
			definition: Result = sequence.is_empty
		end

	count: INTEGER
			-- Number of elements in the list.
		note
			skip: True
		require
			closed: closed
		do
		ensure
			definition: Result = sequence.count
		end

	item alias "[]" (i: INTEGER): G
			-- Element at index `i'.
		note
			skip: True
		require
			closed: closed
			in_bounds: 1 <= i and i <= count
		do
		ensure
			definition: Result = sequence [i]
		end

	has (x: G) : BOOLEAN
			-- Is `x' an element of the list?
		note
			skip: True
		require
			closed: closed
		do
		ensure
			definition: Result = sequence.has (x)
		end

feature -- Extension

	extend_back (v: G)
			-- Insert `v' at the back.
		note
			skip: True
		do
		ensure
			sequence_effect: sequence = old (sequence & v)
		end

end
