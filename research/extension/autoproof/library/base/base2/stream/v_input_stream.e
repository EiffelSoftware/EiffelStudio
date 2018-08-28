note
	description: "Streams that provide values one by one."
	author: "Nadia Polikarpova"
	model: box
	manual_inv: true
	false_guards: true

deferred class
	V_INPUT_STREAM [G]

feature -- Access

	item: G
			-- Item at current position.
		require
			not_off: not off
			subjects_closed: across subjects as s all s.item.closed end
		deferred
		ensure
			definition: Result = box.any_item
		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		require
			subjects_closed: across subjects as s all s.item.closed end
		deferred
		ensure
			definition: Result = box.is_empty
		end

feature -- Cursor movement

	forth
			-- Move one position forward.
		require
			subjects_closed: across subjects as s all s.item.closed end
			not_off: not off
			modify_model (["box"], Current)
		deferred
		end

	search (v: G)
			-- Move to the first occurrence of `v' at or after current position.
			-- If `v' does not occur, move `after'.
			-- (Use reference equality.)
		note
			status: nonvariant
		require
			subjects_closed: across subjects as s all s.item.is_wrapped end
			modify_model (["box"], Current)
		do
			from
			invariant
				decreases ([])
				is_wrapped
				across subjects as s all s.item.is_wrapped end
			until
				off or else item = v
			loop
				forth
			end
		ensure
			box_effect: box.is_empty or else box.any_item = v
		end

feature -- Specification

	box: MML_SET [G]
			-- Current element in the stream.
		note
			status: ghost
		attribute
		end

invariant
	box_count_constraint: box.count <= 1
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
