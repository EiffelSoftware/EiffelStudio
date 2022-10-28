note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERIC_REF

inherit

	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := 0
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL]): BOOLEAN
		do
			to_implement ("Add implementation")
		end

end
