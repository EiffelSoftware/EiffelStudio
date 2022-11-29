note
	description: "Summary description for {PE_METHOD_SPEC_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_SPEC_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_method: PE_METHOD_DEF_OR_REF; a_instantiation: NATURAL)
		do
			method := a_method
			create instantiation.make_with_index (a_instantiation)
		end

feature -- Access

	method: PE_METHOD_DEF_OR_REF

	instantiation: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tMethodSpec.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end

