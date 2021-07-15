note
	description: "Iterators to read and write from/to a container in linear order."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, sequence, index_
	manual_inv: true
	false_guards: true

deferred class
	V_IO_ITERATOR [G]

inherit
	V_ITERATOR [G]
		redefine
			sequence,
			index_
		end

	V_OUTPUT_STREAM [G]
		undefine
			is_model_equal
		end

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			target_observers_open: ∀ o: target.observers ¦ o /= Current implies o.is_open
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.replaced_at (index_, v)
			target_wrapped: target.is_wrapped
			target_bag_effect: target.bag ~ old ((target.bag / sequence [index_]) & v)
			modify_model (["sequence", "box"], Current)
			modify_model ("bag", target)
		end

	output (v: G)
			-- Replace item at current position with `v' and go to the next position.
		note
			status: nonvariant
		do
			check inv_only ("subjects_definition", "subjects_contraint") end
			put (v)
			check inv end
			forth
		ensure then
			sequence_effect: sequence ~ old (sequence.replaced_at (index_, v))
			index_effect: index_ = old index_ + 1
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in `target'.
		note
			status: ghost
			replaces: off_
		attribute
		end

	index_: INTEGER
			-- Current position.
		note
			status: ghost
			replaces: off_
		attribute
		end

invariant
	off_definition: off_ = not sequence.domain [index_]

note
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
