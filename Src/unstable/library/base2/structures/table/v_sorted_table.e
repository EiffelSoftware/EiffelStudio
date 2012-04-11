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

inherit {NONE}
	V_ORDER [K]
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
