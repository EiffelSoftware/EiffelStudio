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

inherit {NONE}
	V_EQUALITY [K]
		export {NONE}
			all
		undefine
			default_create,
			out,
			copy,
			is_equal
		end

	V_HASH [K]
		export {NONE}
			all
		undefine
			default_create,
			out,
			copy,
			is_equal
		end

create
	default_create,
	with_object_equality

feature {NONE} -- Initialization

	default_create
			-- Create an empty table with reference equality as equivalence relation on keys.
		do
			key_equivalence := agent reference_equal
			key_hash := agent hash_code
			create set.make (
				agent keys_reference_equal,
				agent key_hash_code)
		end

	with_object_equality
			-- Create an empty table with object equality as equivalence relation on keys.
		do
			key_equivalence := agent object_equal
			key_hash := agent hash_code
			create set.make (
				agent keys_object_equal,
				agent key_hash_code)
		end

feature -- Implementation

	keys_reference_equal (kv1, kv2: TUPLE [key: K; value: V]): BOOLEAN
			-- Are keys of `kv1' and `kv2' reference equal?
		do
			Result := kv1.key = kv2.key
		end

	keys_object_equal (kv1, kv2: TUPLE [key: K; value: V]): BOOLEAN
			-- Are keys of `kv1' and `kv2' object equal?
		do
			Result := kv1.key ~ kv2.key
		end

	key_hash_code (kv: TUPLE [key: K; value: V]): INTEGER
			-- Hash code of key of `kv'.
		do
			Result := kv.key.hash_code
		end

end
