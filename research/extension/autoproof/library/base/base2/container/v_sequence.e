note
	description: "[
		Containers where values are associated with integer indexes from a continuous interval.
		Immutable interface.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence, lower_
	manual_inv: true
	false_guards: true

deferred class
	V_SEQUENCE [G]

inherit
	V_CONTAINER [G]
		redefine
			is_empty
		end

feature -- Access

	item alias "[]" (i: INTEGER): G
			-- Value at index `i'.
		require
			has_index: has_index (i)
		deferred
		ensure then
			definition: Result = sequence [i - lower_ + 1]
		end

	first: G
			-- First element.
		note
			status: nonvariant
		require
			not_empty: not is_empty
		do
			check inv end
			Result := item (lower)
		ensure
			definition: Result = sequence.first
		end

	last: G
			-- Last element.
		note
			status: nonvariant
		require
			not_empty: not is_empty
		do
			check inv end
			Result := item (upper)
		ensure
			definition: Result = sequence.last
		end

feature -- Measurement

	lower: INTEGER
			-- Lower bound of index interval.
		deferred
		ensure
			definition: Result = lower_
		end

	upper: INTEGER
			-- Upper bound of index interval.
		note
			status: nonvariant
		do
			check inv end
			Result := lower + count - 1
		ensure
			definition: Result = upper_
		end

	count: INTEGER
			-- Number of elements.
		deferred
		ensure then
			definition_sequence: Result = sequence.count
		end

	has_index (i: INTEGER): BOOLEAN
			-- Is any value associated with `i'?
		note
			status: nonvariant
		do
			check inv end
			Result := lower <= i and i <= upper
		ensure then
			Result = (lower_ <= i and i <= upper_)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is container empty?
		note
			status: nonvariant
		do
			Result := count = 0
		ensure then
			definition: Result = sequence.is_empty
		end

feature -- Search

	index_of (v: G): INTEGER
			-- Index of the first occurrence of `v';
			-- out of range, if `v' does not occur.			
		note
			status: impure, nonvariant
		require
			modify_model (["observers"], Current)
		do
			check inv end
			if not is_empty then
				Result := index_of_from (v, lower)
			else
				Result := upper + 1
			end
			check inv end
		ensure
			definition_not_has: not sequence.has (v) implies Result = upper_ + 1
			definition_has: sequence.has (v) implies lower_ <= Result and Result <= upper_ and then sequence [idx (Result)] = v
			constraint: not sequence.front (idx (Result - 1)).has (v)
			observers_restored: observers ~ old observers
		end

	index_of_from (v: G; i: INTEGER): INTEGER
			-- Index of the first occurrence of `v' starting from position `i';
			-- out of range, if `v' does not occur.
		note
			status: impure, nonvariant
		require
			has_index: has_index (i)
			modify_model (["observers"], Current)
		local
			it: V_SEQUENCE_ITERATOR [G]
		do
			it := at (i)
			it.search_forth (v)
			if it.off then
				Result := upper + 1
			else
				Result := it.target_index
			end
			forget_iterator (it)
		ensure
			definition_not_has: not sequence.tail (idx (i)).has (v) implies Result = upper_ + 1
			definition_has: sequence.tail (idx (i)).has (v) implies i <= Result and Result <= upper_ and then sequence [idx (Result)] = v
			constraint: not sequence.interval (idx (i), idx (Result - 1)).has (v)
			observers_restored: observers ~ old observers
		end

feature -- Iteration

	new_cursor: like at
			-- New iterator pointing to the first position.
		note
			status: impure, nonvariant
		do
			Result := at (lower)
		end

	at_last: like at
			-- New iterator pointing to the last position.
		note
			status: impure, nonvariant
		require
			modify_field (["observers", "closed"], Current)
		do
			Result := at (upper)
		ensure
			result_fresh: Result.is_fresh
			result_wrapped: Result.is_wrapped and Result.inv
			result_in_observers: observers = old observers & Result
			target_definition: Result.target = Current
			index_definition: Result.index_ = sequence.count
		end

	at (i: INTEGER): V_SEQUENCE_ITERATOR [G]
			-- New iterator pointing at position `i'.
			-- If `i' is off scope, iterator is off.
		note
			status: impure
		require
			modify_field (["observers", "closed"], Current)
		deferred
		ensure
			result_fresh: Result.is_fresh
			result_wrapped: Result.is_wrapped and Result.inv
			result_in_observers: observers = old observers & Result
			target_definition: Result.target = Current
			index_definition_in_bounds: lower_ - 1 <= i and i <= upper_ + 1 implies Result.index_ = i - lower_ + 1
			index_definition_before: i < lower_ implies Result.index_ = 0
			index_definition_after: i > upper_ implies Result.index_ = sequence.count + 1
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements.
		note
			status: ghost
			replaces: bag
		attribute
			check is_executable: False then end
		end

	lower_: INTEGER
			-- Lower bound of index interval.
		note
			status: ghost
		attribute
		end

	upper_: INTEGER
			-- Upper bound of index interval.
		note
			status: functional, ghost, nonvariant
		do
			Result := lower_ + sequence.count - 1
		end

	idx (i: INTEGER): INTEGER
			-- Sequence index of position `i'.
		note
			status: ghost, functional, nonvariant
		do
			Result := i - lower_ + 1
		end

invariant
	lower_constraint: sequence.is_empty implies lower_ = 1
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
