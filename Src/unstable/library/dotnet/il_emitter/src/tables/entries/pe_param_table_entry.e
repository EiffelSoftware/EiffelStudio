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

	make_with_data (a_flags: INTEGER; a_sequence_index: NATURAL_16; a_name_index: NATURAL_64)
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

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16_with_integer_32 (a_dest.to_special, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 2
				-- Write sequence index to the destination buffer.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, sequence_index, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Write the name_index
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the flags (from a_src)  to flags.
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_16 (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 2

			sequence_index := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Get the name_index
				-- from the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
