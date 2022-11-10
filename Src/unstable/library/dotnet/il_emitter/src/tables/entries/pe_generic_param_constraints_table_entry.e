note
	description: "Summary description for {PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Initialization

	-- TODO add a new creation procedure `make`

	make_with_data (a_owner: NATURAL; a_constraint: PE_TYPEDEF_OR_REF)
		do
			create owner.make_with_index (a_owner)
			constraint := a_constraint
		end

feature -- Access

	owner: PE_GENERIC_REF

	constraint: PE_TYPEDEF_OR_REF

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tGenericParam.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

end
