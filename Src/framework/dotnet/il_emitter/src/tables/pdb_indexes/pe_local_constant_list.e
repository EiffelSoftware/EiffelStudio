note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_LOCAL_CONSTANT_LIST


inherit
	PE_LIST

create
	make_default,
	make_with_index

feature -- Access

	associated_table_index: NATURAL_32
		do
			Result := {PDB_TABLES}.tLocalConstant
		end


end
