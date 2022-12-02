note
	description: "Summary description for {PE_CONSTANT_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CONSTANT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_type: INTEGER; a_parent_index: PE_CONSTANT; a_value_index: NATURAL_64)
		do
			type := a_type.to_natural_8
			parent_index := a_parent_index
			create value_index.make_with_index (a_value_index)
		end

feature -- Access

	type: NATURAL_8
		-- Defined as a Byte 1 byte.

	parent_index: PE_CONSTANT

	value_index: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tconstant.value.to_integer_32
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
