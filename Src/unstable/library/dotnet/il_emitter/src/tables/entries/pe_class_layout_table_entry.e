note
	description: "Summary description for {PE_CLASS_LAYOUT_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CLASS_LAYOUT_TABLE_ENTRY

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

	make_with_data (a_pack: NATURAL_16; a_size: NATURAL; a_parent: NATURAL_64)
		do
			pack := a_pack
			size := a_size
			create parent.make_with_index (a_parent)
		end

feature -- Access

	pack: NATURAL_16
			-- Defined as a word two bytes.

	size: NATURAL

	parent: PE_TYPE_DEF


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tClassLayout.value.to_integer_32
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
