note
	description: "[
			Hash tables with arbitrary equivalence relation on keys and hash function.
			Implementation uses chaining.
			Search, extension and removal are amortized constant time.
		]"
	author: "Nadia Polikarpova"
	model: map, key_equivalence, key_hash

class
	V_GENERAL_HASH_TABLE [K, V]

inherit
	V_SET_TABLE [K, V]
		redefine
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (eq: PREDICATE [K, K]; h: FUNCTION [K, INTEGER])
			-- Create an empty table with key equivalence `eq' and hash function `h'.
		require
			--- eq_is_total: eq.precondition |=| True
			--- eq_is_equivalence: is_equivalence (eq)
			--- h_is_total: h.precondition |=| True
			--- h_non_negative: forall x: K :: h (x) >= 0
			--- h_eq_consistent: forall x, y: K :: eq (x, y) implies h (x) = h(y)			
		do
			key_equivalence := eq
			key_hash := h
			create set.make (
				(create {V_TUPLE_PROJECTOR [K, V, BOOLEAN]}).project_two_predicate (eq),
				(create {V_TUPLE_PROJECTOR [K, V, INTEGER]}).project_one (h))
		ensure
			map_effect: map.is_empty
			--- key_equivalence_effect: key_equivalence |=| eq
			--- key_hash_effect: key_hash |=| h
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize table by copying `key_order', and key-value pair from `other'.
		note
			modify: map, key_equivalence, key_hash
		do
			if other /= Current then
				key_equivalence := other.key_equivalence
				key_hash := other.key_hash
				if set = Void then
					-- Copy used as a creation procedure
					set := other.set.twin
				else
					set.copy (other.set)
				end
			end
		ensure then
			map_effect: map |=| other.map
			--- key_equivalence_effect: key_equivalence |=| other.key_equivalence
			--- key_hash_effect: key_hash |=| other.key_hash
		end

feature -- Search

	key_equivalence: PREDICATE [K, K]
			-- Equivalence relation on keys.

	key_hash: FUNCTION [K, INTEGER]
			-- Hash function on keys.

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	set: V_GENERAL_HASH_SET [TUPLE [key: K; value: V]]
			-- Underlying set of key-value pairs.
			-- Should not be reassigned after creation.

invariant
	--- key_hash_non_negative: forall x: K :: key_hash (x) >= 0
end
