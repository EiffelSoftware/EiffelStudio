note
	description: "Streams where values can be output one by one."
	author: "Nadia Polikarpova"
	model: off_
	manual_inv: true
	false_guards: true

deferred class
	V_OUTPUT_STREAM [G]

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		deferred
		ensure
			defintion: Result = off_
		end

feature -- Replacement

	output (v: G)
			-- Put `v' into the stream and move to the next position.
		require
			not_off: not off
			subjects_wrapped: across subjects as s all
					s.item.is_wrapped and
					across s.item.observers as o all o.item /= Current implies o.item.is_open end
				end
			modify_model ("off_", Current)
			modify (subjects)
		deferred
		ensure
			subjects_wrapped: across subjects as s all
					s.item.is_wrapped and
					across s.item.observers as o all o.item /= Current implies o.item.is_open end
				end
		end

	pipe (input: V_INPUT_STREAM [G])
			-- Copy values from `input' until either `Current' or `input' is `off'.
		note
			status: nonvariant
		require
			input_wrapped: input.is_wrapped
			input_not_current: input /= Current
			subjects_wrapped: across subjects as s all
					s.item.is_wrapped and
					across s.item.observers as o all o.item /= Current implies o.item.is_open end
				end
			input_subjects_wrapped: across input.subjects as s all s.item.is_wrapped end
			modify (Current, subjects)
			modify_model ("box", input)
		do
			from
			invariant
				is_wrapped and input.is_wrapped
				inv and input.inv
				subjects ~ subjects.old_
				subjects_wrapped: across subjects as s all
					s.item.is_wrapped and
					across s.item.observers as o all o.item /= Current implies o.item.is_open end
				end
				decreases ([])
			until
				off or input.off
			loop
				output (input.item)
				input.forth
			end
		ensure
			off_effect: off_ or input.box.is_empty
		end

	pipe_n (input: V_INPUT_STREAM [G]; n: INTEGER)
			-- Copy `n' elements from `input'; stop if either `Current' or `input' is `off'.
		note
			status: nonvariant
		require
			input_exists: input.is_wrapped
			input_not_current: input /= Current
			n_non_negative: n >= 0
			subjects_wrapped: across subjects as s all
					s.item.is_wrapped and
					across s.item.observers as o all o.item /= Current implies o.item.is_open end
				end
			input_subjects_wrapped: across input.subjects as s all s.item.is_wrapped end
			modify_model ("box", input)
			modify (Current, subjects)
		local
			i: INTEGER
		do
			from
				i := 1
			invariant
				is_wrapped and input.is_wrapped
				inv and input.inv
				subjects ~ subjects.old_
				subjects_wrapped: across subjects as s all
					s.item.is_wrapped and
					across s.item.observers as o all o.item /= Current implies o.item.is_open end
				end
			until
				i > n or off or input.off
			loop
				output (input.item)
				input.forth
				i := i + 1
			variant
				n - i
			end
		end

feature -- Specification

	off_: BOOLEAN
		note
			status: ghost
		attribute
		end

invariant
	subjects_contraint: not subjects [Current]
	no_observers: observers = []

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
