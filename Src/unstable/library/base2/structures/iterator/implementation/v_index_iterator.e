note
	description: "Iterators over sequences that access elements directly through an integer index."
	author: "Nadia Polikarpova"
	model: target, index

deferred class
	V_INDEX_ITERATOR [G]

inherit
	V_SEQUENCE_ITERATOR [G]
		redefine
			go_to
		end

feature -- Access

	target: V_SEQUENCE [G]
			-- Target container.
		deferred
		end

	item: G
			-- Item at current position.
		do
			Result := target [target.lower + index - 1]
		end

feature -- Measurement

	index: INTEGER
			-- Index of current position.

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			Result := index = 0
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			Result := index = target.count + 1
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			Result := not target.is_empty and index = 1
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := not target.is_empty and index = target.count
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		do
			index := 1
		end

	finish
			-- Go to the last position.
		do
			index := target.count
		end

	forth
			-- Move one position forward.
		do
			index := index + 1
		end

	back
			-- Go one position backwards.
		do
			index := index - 1
		end

	go_to (i: INTEGER)
			-- Go to position `i'.
		do
			index := i
		end

	go_before
			-- Go before any position of `target'.
		do
			index := 0
		end

	go_after
			-- Go after any position of `target'.
		do
			index := target.count + 1
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
				i := target.lower
			until
				i > target.upper
			loop
				Result := Result & target [i]
				i := i + 1
			end
		end
end
