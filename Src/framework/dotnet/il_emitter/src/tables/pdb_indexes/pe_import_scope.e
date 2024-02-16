note
	description: "Define an index that occur in the table ImportScope."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_IMPORT_SCOPE

inherit
	PE_INDEX_BASE
		redefine
			has_index_overflow
		end

create
	make_with_index

feature -- Operations

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large(a_sizes [{PDB_TABLES}.tImportScope.to_integer_32 + 1])
		end
end
