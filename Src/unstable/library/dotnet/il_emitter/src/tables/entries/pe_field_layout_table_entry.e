note
	description: "Summary description for {PE_FIELD_LAYOUT_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_LAYOUT_TABLE_ENTRY

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

	make_with_data (a_offset: NATURAL_64; a_parent: NATURAL_64)
		do
			offset := a_offset
			create parent.make_with_index (a_parent)
		end

feature -- Access

	offset: NATURAL_64

	parent: PE_FIELD_LIST

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tFieldLayout.value.to_integer_32
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
