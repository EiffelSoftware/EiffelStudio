note
	description: "[
			Hash sets with hash function provided by HASHABLE
			and with reference or object equality as equivalence relation.

			When using reference equality with mutable elements,
			consider inheriting elements from V_REFERENCE_HASHABLE.
		]"
	author: "Nadia Polikarpova"
	model: set, equivalence, hash

class
	V_HASH_SET [G -> HASHABLE]

inherit
	V_GENERAL_HASH_SET [G]
		redefine
			default_create
		end

create
	default_create,
	with_object_equality

feature {NONE} -- Initialization

	default_create
			-- Create an empty set with reference equality as equivalence relation.
		do
			buckets := empty_buckets (default_capacity)
			equivalence := agent (create {V_EQUALITY [G]}).reference_equal
			hash := agent (create {V_HASH [G]}).hash_code
		end

	with_object_equality
			-- Create an empty set with object equality as equivalence relation.
		do
			buckets := empty_buckets (default_capacity)
			equivalence := agent (create {V_EQUALITY [G]}).object_equal
			hash := agent (create {V_HASH [G]}).hash_code
		end
end
