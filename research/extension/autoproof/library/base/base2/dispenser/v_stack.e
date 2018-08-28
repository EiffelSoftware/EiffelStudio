note
	description: "Dispensers where the latest added element is accessible."
	author: "Nadia Polikarpova"
	model: sequence
	manual_inv: true
	false_guards: true

deferred class
	V_STACK [G]

inherit
	V_DISPENSER [G]
		redefine
			extend,
			is_model_equal
		end

feature -- Extension

	extend (v: G)
			-- Push `v' on the stack.
		deferred
		ensure then
			sequence_effect: sequence ~ old sequence.prepended (v)
		end

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional, nonvariant
		do
			Result := sequence ~ other.sequence
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
