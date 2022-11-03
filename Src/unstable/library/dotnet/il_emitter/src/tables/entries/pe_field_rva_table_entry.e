note
	description: "Summary description for {PE_FIELD_RVA_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_RVA_TABLE_ENTRY

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

	make_with_data (a_rva: NATURAL; a_field_index: NATURAL)
		do
			rva := a_rva
			create field_index.make_with_index (a_field_index)
		end

feature -- Access

	rva: NATURAL

	field_index: PE_FIELD_LIST

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfieldrva.value.to_integer_32
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
