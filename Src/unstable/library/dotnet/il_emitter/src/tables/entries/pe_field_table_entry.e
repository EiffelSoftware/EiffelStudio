note
	description: "Summary description for {PE_FIELD_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_TABLE_ENTRY

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

	make_with_data (a_flags: INTEGER; a_name_index: NATURAL_64; a_signature_index: NATURAL_64)
		do
			flags := a_flags
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	flags: INTEGER

	name_index: PE_STRING

	signature_index: PE_BLOB

feature -- Enum: Flags

	FieldAccessMask: INTEGER = 0x0007

	PrivateScope: INTEGER = 0x0000
	Private: INTEGER = 0x0001
	FamANDAssem: INTEGER = 0x0002
	Assembly: INTEGER = 0x0003
	Family: INTEGER = 0x0004
	FamORAssem: INTEGER = 0x0005
	Public: INTEGER = 0x0006

		-- other attribs
	Static: INTEGER = 0x0010
	InitOnly: INTEGER = 0x0020
	Literal: INTEGER = 0x0040
	NotSerialized: INTEGER = 0x0080
	SpecialName: INTEGER = 0x0200

		-- pinvoke
	PinvokeImpl: INTEGER = 0x2000

		-- runtime
	ReservedMask: INTEGER = 0x9500
	RTSpecialName: INTEGER = 0x0400
	HasFieldMarshal: INTEGER = 0x1000
	HasDefault: INTEGER = 0x8000
	HasFieldRVA: INTEGER = 0x0100

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfield.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
			-- <Precursor>
		local
			l_bytes: NATURAL_64
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16_with_integer_32 (a_dest.to_special, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 2

				-- Write the name_index, signature_index
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + signature_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the flags (from a_src)  to the flags.
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_16 (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 2

				-- Get the name_index, signature_index and
				-- update the number of bytes.

			l_bytes := l_bytes + name_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + signature_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
