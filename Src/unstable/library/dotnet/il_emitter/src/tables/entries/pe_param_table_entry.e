note
	description: "Summary description for {PE_PARAM_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PARAM_TABLE_ENTRY

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

	make_with_data (a_flags: INTEGER; a_sequence_index: NATURAL_16; a_name_index: NATURAL)
		do
			flags := a_flags
			sequence_index := a_sequence_index
			create name_index.make_with_index (a_name_index)
		end

feature -- Access

	flags: INTEGER

	sequence_index: NATURAL_16
		-- Defined as a Word two bytes.

	name_index: PE_STRING

feature -- Enum: Flags

	In: INTEGER = 0x0001 -- Param is [In]
	Out_: INTEGER = 0x0002 -- Param is [out]
	Optional: INTEGER = 0x0010 -- Param is optional

		-- runtime attribs

	ReservedMask: INTEGER = 0xf000
	HasDefault: INTEGER = 0x1000 -- Param has default value.

	HasFieldMarshal: INTEGER = 0x2000 -- Param has FieldMarshal.
	Unused: INTEGER = 0xcfe0

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tparam.value.to_integer_32
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
