note
	description: "Sorted tables with order relation on keys provided by COMPARABLE."
	author: "Nadia Polikarpova"
	model: map, key_order

class
	V_SORTED_TABLE [K -> COMPARABLE, V]

inherit
	V_GENERAL_SORTED_TABLE [K, V]
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create an empty set with reference equality as equivalence relation.
		do
			key_order := agent (create {V_ORDER [K]}).less_equal
			create set.make ((create {V_TUPLE_PROJECTOR [K, V, BOOLEAN]}).project_two_predicate (key_order))
		end
end
