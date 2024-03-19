note
	description: "Define and index that occur in the table Document."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DOCUMENT

inherit
	PE_INDEX_BASE
		redefine
			has_index_overflow
		end

create
	make_with_index

feature -- Operations

	has_index_overflow (a_sizes: SPECIAL [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes, {PDB_TABLES}.tdocument)
		end
end
