note
	description: "Containers that can be extended with values and make only one element accessible at a time."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence
	manual_inv: true
	false_guards: true

deferred class
	V_DISPENSER [G]

inherit
	V_CONTAINER [G]
		redefine
			count
		end

feature -- Access

	item: G
			-- The accessible element.
		require
			not_empty: not is_empty
		deferred
		ensure
			definition: Result = sequence.first
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		deferred
		ensure then
			definition_sequence: Result = sequence.count
		end

feature -- Iteration

	new_cursor: V_ITERATOR [G]
			-- New iterator pointing to the accessible element.
			-- (Traversal in the order of accessibility.)
		note
			status: impure
		deferred
		ensure then
			sequence_definition: Result.sequence ~ sequence
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the dispenser.
		require
			no_observers: observers.is_empty
			modify_model ("sequence", Current)
		deferred
		ensure
			bag_effect: bag ~ old (bag & v)
		end

feature -- Removal

	remove
			-- Remove the accessible element.
		require
			not_empty: not is_empty
			no_observers: observers.is_empty
			modify_model ("sequence", Current)
		deferred
		ensure
			wrapped: is_wrapped
			sequence_effect: sequence ~ old sequence.but_first
		end

	wipe_out
			-- Remove all elements.
		require
			no_observers: observers.is_empty
			modify_model ("sequence", Current)
		deferred
		ensure
			wrapped: is_wrapped
			sequence_effect: sequence.is_empty
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in the order of access.
		note
			status: ghost
			replaces: bag
		attribute
			check is_executable: False then end
		end

invariant
	bag_definition: bag ~ sequence.to_bag

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
