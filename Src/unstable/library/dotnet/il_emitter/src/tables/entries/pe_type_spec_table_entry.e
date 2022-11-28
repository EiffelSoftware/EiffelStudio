note
	description: "Summary description for {PE_TYPE_SPEC_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_SPEC_TABLE_ENTRY

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

	make_with_data (a_signature_index: NATURAL_64)
		do
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	signature_index: PE_STRING

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.ttypespec.value.to_integer_32
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
