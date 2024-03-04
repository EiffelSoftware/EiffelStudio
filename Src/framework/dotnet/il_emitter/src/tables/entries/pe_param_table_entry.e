note
	description: "Object representing the Param Table."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Param Table", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=266&zoom=100,116,794", "protocol=uri"

class
	PE_PARAM_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER_32; a_sequence_index: NATURAL_16; a_name_index: NATURAL_32)
		do
			flags := a_flags.to_integer_16
			check no_truncation: flags.to_integer_32 = a_flags end
			sequence_index := a_sequence_index
			create name_index.make_with_index (a_name_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.flags = flags and then
					e.sequence_index = sequence_index and then
					e.name_index.is_equal (name_index)
				)
		end

feature -- Access

	flags: INTEGER_16
			-- A 2-byte bitmask of type MD_PARAM_ATTRIBUTES.
			-- see https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=279&zoom=100,116,938

	sequence_index: NATURAL_16
			-- Defined as a Word two bytes.

	name_index: PE_STRING
			-- An index into the String heap.

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

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tparam
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_integer_16 (a_dest, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 2

				-- Write sequence index to the destination buffer.
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, sequence_index, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Write the name_index
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the flags (from a_src)  to flags.
			flags := {BYTE_ARRAY_HELPER}.integer_16_at (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 2

			sequence_index := {BYTE_ARRAY_HELPER}.natural_16_at (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Get the name_index
				-- from the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
