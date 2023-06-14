note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MODULE_REF

inherit
	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_index

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := 0
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tModuleRef.to_integer_32 + 1])
		end

end
