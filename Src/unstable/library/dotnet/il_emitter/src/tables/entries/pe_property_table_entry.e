note
	description: "Summary description for {PE_PROPERTY_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PROPERTY_TABLE_ENTRY

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

	make_with_data (a_flags: NATURAL_16; a_name: NATURAL; a_property_type: NATURAL)
		do
			flags := a_flags
			create name.make_with_index (a_name)
			create property_type.make_with_index (a_property_type)
		end

feature -- Access

	flags: NATURAL_16
			-- defined as a word two bytes.

	name: PE_STRING

	property_type: PE_BLOB
			-- Yes this is a signature in the blob.

feature -- Flags

	SpecialName: INTEGER = 0x200
	ReservedMask: INTEGER = 0xf400
	RTSpecialName: INTEGER = 0x400
	HasDefault: INTEGER = 0x1000

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tProperty.value.to_integer_32
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

