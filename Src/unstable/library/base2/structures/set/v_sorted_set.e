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

inherit {NONE}
	V_ORDER [G]
		rename
			less_equal as comparable_less_equal
		export {NONE}
			all
		undefine
			default_create,
			out,
			copy,
			is_equal
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create an empty set with reference equality as equivalence relation.
		do
			make (agent comparable_less_equal)
		end
end
