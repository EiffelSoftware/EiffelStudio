note
	description: "Iterators over sequences that access elements directly through an integer index."
	author: "Nadia Polikarpova"
	model: target, index_
	manual_inv: true
	false_guards: true

deferred class
	V_INDEX_ITERATOR [G]

inherit
	V_SEQUENCE_ITERATOR [G]
		redefine
			is_equal_,
			go_to
		end

feature -- Access

	item: G
			-- Item at current position.
		note
			status: nonvariant
		do
			check inv end
			Result := target [target.lower + index - 1]
		end

feature -- Measurement

	index: INTEGER
			-- Index of current position.

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		note
			status: nonvariant
		do
			check inv end
			Result := index = 0
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		note
			status: nonvariant
		do
			check inv end
			Result := index = target.count + 1
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		note
			status: nonvariant
		do
			check inv end
			Result := not target.is_empty and index = 1
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		note
			status: nonvariant
		do
			check inv end
			Result := not target.is_empty and index = target.count
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is iterator traversing the same container and is at the same position at `other'?
		note
			status: nonvariant
		do
			check inv; other.inv end
			Result := target = other.target and index = other.index
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

invariant
	index_definition: index_ = index

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
