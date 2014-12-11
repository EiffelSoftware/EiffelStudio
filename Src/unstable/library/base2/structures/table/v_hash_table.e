note
	description: "[
			Hash tables with hash function provided by HASHABLE
			and with reference or object equality as equivalence relation on keys.
			
			When using reference equality with mutable keys,
			consider inheriting keys from V_REFERENCE_HASHABLE.
		]"
	author: "Nadia Polikarpova"
	model: map, key_equivalence, key_hash

class
	V_HASH_TABLE [K -> HASHABLE, V]

inherit
	V_GENERAL_HASH_TABLE [K, V]
		redefine
			default_create
		end

create
	default_create,
	with_object_equality

feature {NONE} -- Initialization

	default_create
			-- Create an empty table with reference equality as equivalence relation on keys.
		do
			key_equivalence := agent (create {V_EQUALITY [K]}).reference_equal
			key_hash := agent (create {V_HASH [K]}).hash_code
			create set.make (
				(create {V_TUPLE_PROJECTOR [K, V, BOOLEAN]}).project_two_predicate (key_equivalence),
				(create {V_TUPLE_PROJECTOR [K, V, INTEGER]}).project_one (key_hash))
		end

	with_object_equality
			-- Create an empty table with object equality as equivalence relation on keys.
		do
			key_equivalence := agent (create {V_EQUALITY [K]}).object_equal
			key_hash := agent (create {V_HASH [K]}).hash_code
			create set.make (
				(create {V_TUPLE_PROJECTOR [K, V, BOOLEAN]}).project_two_predicate (key_equivalence),
				(create {V_TUPLE_PROJECTOR [K, V, INTEGER]}).project_one (key_hash))
		end

end
