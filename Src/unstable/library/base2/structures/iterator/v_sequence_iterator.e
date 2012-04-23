note
	description: "Itreators to read from sequences."
	author: "Nadia Polikarpova"
	model: target, index

deferred class
	V_SEQUENCE_ITERATOR [G]

inherit
	V_MAP_ITERATOR [INTEGER, G]
		rename
			key as target_index,
			search_key as search_target_index,
			key_sequence as target_index_sequence,
			value_sequence as sequence
		end

feature -- Access

	target_index: INTEGER
			-- Target index at current position.
		do
			Result := target.lower + index - 1
		end

	target: V_SEQUENCE [G]
			-- Sequence to iterate over.
		deferred
		end

feature -- Cursor movement

	search_target_index (i: INTEGER)
			-- Move to a position where target index is `i'.
			-- If `i' is not a valid index, go after.
			-- (Use `target.key_equivalence'.)
		do
			if target.has_index (i) then
				go_to (i - target.lower + 1)
			else
				go_after
			end
		end

feature -- Specification

	target_index_sequence: MML_SEQUENCE [INTEGER]
			-- Sequence of indexes in `target'.
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
				Result := Result & i
				i := i + 1
			end
		end

invariant
	target_index_sequence_definition: target_index_sequence.for_all (agent (i: INTEGER; x: INTEGER): BOOLEAN
		do
			Result := x = target.lower + i - 1
		end)
end
