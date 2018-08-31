note
	description: "[
		Containers for a finite number of values.
		Immutable interface.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: bag
	manual_inv: true
	false_guards: true

deferred class
	V_CONTAINER [G]

inherit
	ITERABLE [G]

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		deferred
		ensure
			definition: Result = bag.count
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is container empty?
		note
			status: nonvariant
		do
			Result := count = 0
		ensure
			definition: Result = bag.is_empty
		end

feature -- Search

	has (v: G): BOOLEAN
			-- Is value `v' contained?
			-- (Uses reference equality.)
		note
			status: impure, nonvariant
		require
			modify_model ("observers", Current)
		local
			it: V_ITERATOR [G]
		do
			it := new_cursor
			it.search_forth (v)
			Result := not it.after
			forget_iterator (it)
		ensure
			definition: Result = bag.domain [v]
			observers_restored: observers = old observers
		end

	occurrences (v: G): INTEGER
			-- How many times is value `v' contained?
			-- (Uses reference equality.)
		note
			status: impure, nonvariant
		require
			modify_model ("observers", Current)
		local
			it: V_ITERATOR [G]
			s: MML_SEQUENCE [G]
		do
			from
				it := new_cursor
				create s
			invariant
				1 <= it.index_ and it.index_ <= it.sequence.count + 1
				s = it.sequence.front (it.index_ - 1)
				Result = s.occurrences (v)
				it.is_wrapped
				modify_model ("index_", it)
			until
				it.off
			loop
				if it.item = v then
					Result := Result + 1
				end
				s := s & it.item
				it.forth
			variant
				it.sequence.count - it.index_
			end
			forget_iterator (it)
		ensure
			definition: Result = bag [v]
			observers_restored: observers ~ old observers
		end

feature -- Iteration

	new_cursor: V_ITERATOR [G]
			-- New iterator pointing to a position in the container, from which it can traverse all elements by going `forth'.
		note
			status: impure
		deferred
		ensure then
			target_definition: Result.target = Current
			index_definition: Result.index_ = 1
		end

feature -- Specification

	bag: MML_BAG [G]
			-- Bag of elements.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	forget_iterator (it: V_ITERATOR [G])
			-- Remove `it' from `observers'.
		note
			status: ghost
			explicit: contracts
		require
			wrapped: is_wrapped
			it_wrapped: it.is_wrapped
			valid_target: it.target = Current
			modify_field (["observers", "closed"], Current)
			modify (it) -- not using modify_field here because of the typing bug
		do
			it.unwrap
			set_observers (observers / it)
		ensure
			wrapped: is_wrapped
			it_open: it.is_open
			observer_removed: observers = old observers / it
			it.owns ~ old it.owns
			it.observers ~ old it.observers
		end

feature {V_CONTAINER, V_ITERATOR} -- Specification

	add_iterator (it: V_ITERATOR [G])
			-- Add `it' to `observers'.
		note
			status: ghost
		require
			wrapped: is_wrapped
			valid_type: attached {like new_cursor} it
			modify_field (["observers", "closed"], Current)
		do
			unwrap
			set_observers (observers & it)
			wrap
		ensure
			wrapped: is_wrapped
			observer_added: observers = old observers & it
		end

invariant
	not_observer: not observers [Current]

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
