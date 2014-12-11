note
	description: "Containers that can be extended with values and make only one element accessible at a time."
	author: "Nadia Polikarpova"
	model: sequence

deferred class
	V_DISPENSER [G]

inherit
	V_CONTAINER [G]

feature -- Access

	item: G
			-- The accessible element.
		require
			not_empty: not is_empty
		deferred
		ensure
			definition: Result = sequence.first
		end

feature -- Iteration

	new_cursor: V_ITERATOR [G]
			-- New iterator pointing to the accessible element.
			-- (Traversal in the order of accessibility.)
		deferred
		ensure then
			sequence_definition: Result.sequence |=| sequence
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the dispenser.
		note
			modify: sequence
		deferred
		ensure
			bag_effect: bag |=| old (bag & v)
		end

feature -- Removal

	remove
			-- Remove the accessible element.
		note
			modify: sequence
		require
			not_empty: not is_empty
		deferred
		ensure
			sequence_effect: sequence |=| old sequence.but_first
		end

	wipe_out
			-- Remove all elements.
		note
			modify: sequence
		deferred
		ensure
			sequence_effect: sequence.is_empty
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in the order of access.
		note
			status: specification
		do
			Result := new_cursor.sequence
		end

invariant
	bag_domain_definition: bag.domain |=| sequence.range
	bag_definition: bag.domain.for_all (agent (x: G): BOOLEAN
		do
			Result := bag [x] = sequence.occurrences (x)
		end)
end
