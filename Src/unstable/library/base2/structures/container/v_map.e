note
	description: "[
		Containers where values are associated with keys. 
		Keys are unique with respect to some equivalence relation.
		Immutable interface.
		]"
	author: "Nadia Polikarpova"
	model: map, key_equivalence

deferred class
	V_MAP [K, V]

inherit
	V_CONTAINER [V]
		redefine
			out
		end

feature -- Access

	item alias "[]" (k: K): V
			-- Value associated with `k'.
		require
			has_key: has_key (k)
		deferred
		ensure
			definition: Result = map [key (k)]
		end

feature -- Search

	key_equivalence: PREDICATE [K, K]
			-- Key equivalence relation.
		deferred
		end

	has_key (k: K): BOOLEAN
			-- Does `map' contain a key equivalent to `k' according to `key_equivalence'?
		deferred
		ensure
			definition: Result = map.domain.exists (agent equivalent (k, ?))
		end

	exists_key (pred: PREDICATE [K]): BOOLEAN
			-- Is there a key that satisfies `pred'?
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: map.domain.for_all (agent (k: K; p: PREDICATE [K]): BOOLEAN
				do
					Result := p.precondition ([k])
				end (?, pred))
		local
			it: V_MAP_ITERATOR [K, V]
		do
			from
				Result := False
				it := new_cursor
			until
				it.after or Result
			loop
				Result := pred.item ([it.key])
				it.forth
			end
		ensure
			definition: Result = map.domain.exists (pred)
		end

	for_all_keys (pred: PREDICATE [K]): BOOLEAN
			-- Do all keys satisfy `pred'?
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: map.domain.for_all (agent (k: K; p: PREDICATE [K]): BOOLEAN
				do
					Result := p.precondition ([k])
				end (?, pred))
		do
			Result := across Current as it all pred.item ([it.key]) end
		ensure
			definition: Result = map.domain.for_all (pred)
		end

feature -- Iteration

	new_cursor: like at_key
			-- New iterator pointing to a position in the map, from which it can traverse all elements by going `forth'.
		deferred
		end

	at_key (k: K): V_MAP_ITERATOR [K, V]
			-- New iterator pointing to a position with key `k'.
			-- If key does not exist, iterator is off.
		deferred
		ensure
			target_definition: Result.target = Current
			index_definition_found: has_key (k) implies equivalent (Result.key_sequence [Result.index], k)
			index_definition_not_found: not has_key (k) implies not Result.key_sequence.domain [Result.index]
		end

feature -- Output

	out: STRING
			-- String representation of the content.
		local
			stream: V_STRING_OUTPUT
		do
			Result := ""
			create stream.make_with_separator (Result, "")
			across
				Current as it
			loop
				stream.output ("(")
				stream.output (it.key)
				stream.output (", ")
				stream.output (it.item)
				stream.output (")")
				if not it.is_last then
					stream.output (" ")
				end
			end
		end

feature -- Specification

	map: MML_MAP [K, V]
			-- Map of keys to values.
		note
			status: specification
		do
			create Result
			across
				Current as it
			loop
				Result := Result.updated (it.key, it.item)
			end
		end

	equivalent (k1, k2: K): BOOLEAN
			-- Are `k1' and `k2' equivalent according to `key_equivalence'?
		note
			status: specification
		do
			Result := key_equivalence.item ([k1, k2])
		ensure
			definition: Result = key_equivalence.item ([k1, k2])
		end

	key (k: K): K
			-- Key in `map' equivalent to `k' according to `relation'.
		note
			status: specification
		require
			has_key: has_key (k)
		do
			Result := (map.domain | agent equivalent (k, ?)).any_item
		ensure
			Result = (map.domain | agent equivalent (k, ?)).any_item
		end

---	is_equivalence (r: PREDICATE [ANY, TUPLE [K, K]])
			-- Is `r' an equivalence relation?
---		note
---			status: specification
---		deferred
---		ensure
			--- definition: Result = (
			---	(forall x: K :: r (x, x)) and
			--- (forall x, y: K :: r (x, y) = r (y, x)) and
			--- (forall x, y, z: K :: r (x, y) and r (y, z) implies r (x, z))
---		end

invariant
	--- equivalence_is_total: equivalence.precondition |=| True
	--- equivalence_is_equivalence: is_equivalence (key_equivalence)
	bag_domain_definition: bag.domain |=| map.range
	bag_definition: bag |=| map.to_bag
end
