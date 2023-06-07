note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_LIST

inherit
	PE_LIST

create
	make_with_index,
	make

feature -- Access

	associated_table_index: NATURAL_32
		do
			Result := {PE_TABLES}.tMethodDef
		end

end
