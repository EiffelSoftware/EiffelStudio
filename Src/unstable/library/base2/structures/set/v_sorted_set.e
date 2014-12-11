note
	description: "Sorted sets with order relation provided by COMPARABLE."
	author: "Nadia Polikarpova"
	model: set, order

class
	V_SORTED_SET [G -> COMPARABLE]

inherit
	V_GENERAL_SORTED_SET [G]
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create an empty set with reference equality as equivalence relation.
		do
			order := agent (create {V_ORDER [G]}).less_equal
			create tree
		end
end
