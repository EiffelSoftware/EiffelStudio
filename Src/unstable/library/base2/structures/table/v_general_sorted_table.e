note
	description: "[
			Tables implemented as binary search trees
			with arbitrary order relation on keys and equivalence relation on keys derived from order.
			Search, extension and removal are logarithmic on average.
		]"
	author: "Nadia Polikarpova"
	model: map, key_order

class
	V_GENERAL_SORTED_TABLE [K, V]

inherit
	V_SET_TABLE [K, V]
		redefine
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (o: PREDICATE [K, K])
			-- Create an empty table with key order `o'.
		require
			--- o_is_total: o.precondition |=| True
			--- o_is_total_order: is_total_order (o)
		do
			key_order := o
			create set.make ((create {V_TUPLE_PROJECTOR [K, V, BOOLEAN]}).project_two_predicate (o))
		ensure
			map_effect: map.is_empty
			--- key_less_order_effect: key_less_order |=| o
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize table by copying `key_order', and key-value pair from `other'.
		note
			modify: map, key_order
		do
			if other /= Current then
				key_order := other.key_order
				if set = Void then
					-- Copy used as a creation procedure
					set := other.set.twin
				else
					set.copy (other.set)
				end
			end
		ensure then
			map_effect: map |=| other.map
			--- key_order_effect: key_order |=| other.key_order
		end

feature -- Search

	key_order: PREDICATE [K, K]
			-- Order relation on keys.

	less_equal (k1, k2: K): BOOLEAN
			-- Is `k1 <= k2' according to `key_order'?
		do
			Result := key_order.item ([k1, k2])
		ensure
			definition: Result = key_order.item ([k1, k2])
		end

	key_equivalence: PREDICATE [K, K]
			-- Key equivalence relation derived from `key_less_order'.	
		do
			Result := agent (x, y: K): BOOLEAN
				do
					Result := less_equal (x, y) and less_equal (y, x)
				end
		ensure then
			--- definition: Result |=| agent (x, y: K): BOOLEAN -> key_order (x, y) and key_order (y, x) 	
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	set: V_GENERAL_SORTED_SET [TUPLE [key: K; value: V]]
			-- Underlying set of key-value pairs.
			-- Should not be reassigned after creation.

feature -- Specification

---	is_total_order (o: PREDICATE [ANY, TUPLE [K, K]])
			-- Is `o' a total order relation?
---		note
---			status: specification
---		deferred
---		ensure
			--- definition: Result = (
			--- (forall x: K :: o (x, x)) and
			--- (forall x, y, z: K :: o (x, y) and o (y, z) implies o (x, z) and
			--- (forall x, y: K :: o (x, y) or o (y, x)))
---		end

invariant
	--- key_order_is_total_order: is_total_order (key_order)
end
