note
	description: "Iterators to read from and update mutable sequences."
	author: "Nadia Polikarpova"
	model: target, index_
	manual_inv: true
	false_guards: true

deferred class
	V_MUTABLE_SEQUENCE_ITERATOR [G]

inherit
	V_SEQUENCE_ITERATOR [G]
		redefine
			target,
			sequence,
			index_
		end

	V_IO_ITERATOR [G]
		undefine
			is_model_equal
		redefine
			target,
			sequence,
			index_,
			put
		end

feature -- Access

	target: V_MUTABLE_SEQUENCE [G]
			-- Sequence to iterate over.

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		deferred
		ensure then
			target_sequence_effect: target.sequence ~ old (target.sequence.replaced_at (index_, v))
		end

feature -- Specficiation

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in `target'.
		note
			status: ghost
		attribute
		end

	index_: INTEGER
			-- Current position.
		note
			status: ghost
		attribute
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
