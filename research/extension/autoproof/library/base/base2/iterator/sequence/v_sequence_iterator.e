note
	description: "Itreators to read from sequences."
	author: "Nadia Polikarpova"
	model: target, index_
	manual_inv: true
	false_guards: true

deferred class
	V_SEQUENCE_ITERATOR [G]

inherit
	V_ITERATOR [G]
		redefine
			target,
			is_model_equal
		end

feature -- Access

	target_index: INTEGER
			-- Target index at current position.
		note
			status: nonvariant
		require
			target_closed: target.closed
			not_off: not off
		do
			check inv end
			Result := target.lower + index_ - 1
		ensure
			definition: Result = target.lower + index_ - 1
		end

	target: V_SEQUENCE [G]
			-- Sequence to iterate over.

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional, nonvariant
		do
			Result := target = other.target and index_ = other.index_
		end

invariant
	sequence_definition: sequence ~ target.sequence

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
