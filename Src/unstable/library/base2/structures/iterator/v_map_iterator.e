note
	description: "Iterators to read from maps in linear order."
	author: "Nadia Polikarpova"
	model: target, key_sequence, index

deferred class
	V_MAP_ITERATOR [K, V]

inherit
	V_ITERATOR [V]
		rename
			sequence as value_sequence
		end

feature -- Access

	key: K
			-- Key at current position.
		require
			not_off: not off
		deferred
		ensure
			definition: Result = key_sequence [index]
		end

	target: V_MAP [K, V]
			-- Map to iterate over.
		deferred
		end

feature -- Cursor movement

	search_key (k: K)
			-- Move to a position where key is equivalent to `k'.
			-- If `k' does not appear, go after.
			-- (Use `target.key_equivalence'.)
		note
			modify: index
		deferred
		ensure
			index_effect_found: target.has_key (k) implies target.equivalent (key_sequence [index], k)
			index_effect_not_found: not target.has_key (k) implies index = key_sequence.count + 1
		end

feature -- Specification

	key_sequence: MML_SEQUENCE [K]
			-- Sequence of keys.
		note
			status: specification
		deferred
		end

invariant
	keys_in_target: key_sequence.range |=| target.map.domain
	unique_keys: key_sequence.count = target.map.count
	value_sequence_domain_definition: value_sequence.count = key_sequence.count
	value_sequence_definition: value_sequence.for_all (agent (i: INTEGER; x: V): BOOLEAN
		do
			Result := x = target.map [key_sequence [i]]
		end)
end
