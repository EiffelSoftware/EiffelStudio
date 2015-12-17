note
	description: "[
		Containers where values are associated with integer indexes from a continuous interval.
		Immutable interface.
		]"
	author: "Nadia Polikarpova"
	model: map

deferred class
	V_SEQUENCE [G]

inherit
	V_MAP [INTEGER, G]
		rename
			has_key as has_index,
			exists_key as exists_index,
			for_all_keys as for_all_indexes,
			at_key as at
		redefine
			out,
			key
		end

inherit {NONE}
	V_EQUALITY [INTEGER]
		export {NONE}
			all
		undefine
			out
		end

	V_ORDER [INTEGER]
		export {NONE}
			all
		undefine
			out
		end

feature -- Access

	first: G
			-- First element.
		require
			not_empty: not is_empty
		do
			Result := item (lower)
		ensure
			definition: Result = map [lower]
		end

	last: G
			-- Last element.
		require
			not_empty: not is_empty
		do
			Result := item (upper)
		ensure
			definition: Result = map [upper]
		end

feature -- Measurement

	lower: INTEGER
			-- Lower bound of index interval.
		deferred
		ensure
			definition_nonempty: not map.is_empty implies Result = map.domain.extremum (agent less_equal)
			definition_empty: map.is_empty implies Result = 1
		end

	upper: INTEGER
			-- Upper bound of index interval.
		deferred
		ensure
			definition_nonempty: not map.is_empty implies Result = map.domain.extremum (agent greater_equal)
			definition_empty: map.is_empty implies Result = 0
		end

	count: INTEGER
			-- Number of elements.
		do
			Result := upper - lower + 1
		end

	has_index (i: INTEGER): BOOLEAN
			-- Is any value associated with `i'?
		do
			Result := lower <= i and i <= upper
		end

feature -- Search

	index_of (v: G): INTEGER
			-- Index of the first occurrence of `v';
			-- out of range, if `v' does not occur.
		do
			if not is_empty then
				Result := index_of_from (v, lower)
			end
		ensure
			definition_not_has: not map.has (v) implies not map.domain [Result]
			definition_has: map.has (v) implies Result = map.inverse.image_of (v).extremum (agent less_equal)
		end

	index_of_from (v: G; i: INTEGER): INTEGER
			-- Index of the first occurrence of `v' starting from position `i';
			-- out of range, if `v' does not occur.
		require
			has_index: has_index (i)
		local
			it: V_ITERATOR [G]
			j: INTEGER
		do
			from
				it := at (i)
				j := i
				Result := upper + 1
			until
				it.after or else it.item = v
			loop
				it.forth
				j := j + 1
			end
			if not it.after then
				Result := j
			end
		ensure
			definition_not_has: not (map | create {MML_INTERVAL}.from_range (i, upper)).has (v) implies not map.domain [Result]
			definition_has: (map | create {MML_INTERVAL}.from_range (i, upper)).has (v) implies
				Result = (map | create {MML_INTERVAL}.from_range (i, upper)).inverse.image_of (v).extremum (agent less_equal)
		end

	index_satisfying (pred: PREDICATE [G]): INTEGER
			-- Index of the first value that satisfies `pred';
			-- out of range, if `pred' is never satisfied.
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: map.range.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		do
			if not is_empty then
				Result := index_satisfying_from (pred, lower)
			end
		ensure
			definition_not_has: not map.range.exists (pred) implies not map.domain [Result]
			definition_has: map.range.exists (pred) implies Result = map.inverse.image (map.range | pred).extremum (agent less_equal)
		end

	index_satisfying_from (pred: PREDICATE [G]; i: INTEGER): INTEGER
			-- Index of the first value that satisfies `pred' starting from position `i';
			-- out of range, if `pred' is never satisfied.
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: map.range.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
			has_index: has_index (i)
		local
			it: V_ITERATOR [G]
			j: INTEGER
		do
			from
				it := at (i)
				j := i
				Result := upper + 1
			until
				it.after or else pred.item ([it.item])
			loop
				it.forth
				j := j + 1
			end
			if not it.after then
				Result := j
			end
		ensure
			definition_not_has: not (map | create {MML_INTERVAL}.from_range (i, upper)).range.exists (pred) implies not map.domain [Result]
			definition_has: (map | create {MML_INTERVAL}.from_range (i, upper)).range.exists (pred) implies
				Result = (map | create {MML_INTERVAL}.from_range (i, upper)).inverse.image (map.range | pred).extremum (agent less_equal)
		end

	key_equivalence: PREDICATE [INTEGER, INTEGER]
			-- Index equivalence relation: identity.
		once
			Result := agent reference_equal
		end

feature -- Iteration

	new_cursor: like at
			-- New iterator pointing to the first position.
		do
			Result := at (lower)
		end

	at_last: like at
			-- New iterator pointing to the last position.
		do
			Result := at (upper)
		ensure
			target_definition: Result.target = Current
			index_definition: Result.index = map.count
		end

	at (i: INTEGER): V_SEQUENCE_ITERATOR [G]
			-- New iterator pointing at position `i'.
			-- If `i' is off scope, iterator is off.
		deferred
		ensure then
			index_definition_before: i < lower implies Result.index = 0
			index_definition_after: i > upper implies Result.index = map.count + 1
		end

feature -- Output

	out: STRING
			-- String representation of the content.
		local
			stream: V_STRING_OUTPUT
		do
			create Result.make_empty
			create stream.make (Result)
			stream.pipe (new_cursor)
			Result.remove_tail (stream.separator.count)
		end

feature -- Specification

	key (i: INTEGER): INTEGER
			-- Identity.
		note
			status: specification
		do
			Result := i
		end

---	is_total_order (o: PREDICATE [ANY, TUPLE [G, G]])
			-- Is `o' a total order relation?
---		note
---			status: specification
---		deferred
---		ensure
			--- definition: Result = (
			--- (forall x: G :: o (x, x)) and
			--- (forall x, y, z: G :: o (x, y) and o (y, z) implies o (x, z) and
			--- (forall x, y: G :: o (x, y) or o (y, x)))
---		end		

invariant
	indexes_in_interval: map.domain |=| create {MML_INTERVAL}.from_range (lower, upper)
	--- key_equivalence_definition: key_equivalence |=| agent reference_equal
end
