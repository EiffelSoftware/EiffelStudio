note
	description: "[
		Object representing The Field table
		Conceptually, each row in the Field table is owned by one, and only one, row in the TypeDef table
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Field Table", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=249&zoom=100,116,324", "protocol=uri"

class
	PE_FIELD_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER_32; a_name_index: NATURAL_32; a_signature_index: NATURAL_32)
		do
			flags := a_flags.to_integer_16
			check no_truncation: flags.to_integer_32 = a_flags end

			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| Flags.CompilerControlled = 1 then this row is ignored completely in duplicate checking
			--| There shall be no duplicate rows in the Field table, based upon  owner+Name+Signature (where owner is the owning row in the TypeDef table, as
			--| described above) (Note however that if Flags.CompilerControlled = 1, then this
			--| row is completely excluded from duplicate checking)
		do
			Result := Precursor (e)
				or else (
					e.flags /= 1 and then
					e.flags = flags and then
					e.name_index.is_equal (name_index) and then
					e.signature_index.is_equal (signature_index)
				)
		end

feature -- Access

	flags: INTEGER_16
			-- a 2-byte bitmask of type FieldAttributes
			-- see https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=276&zoom=100,116,708

	name_index: PE_STRING
			-- an index into the String heap.

	signature_index: PE_BLOB
			-- an index into the Blob heap.

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
		once
			Result := {PE_TABLES}.tfield.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes: NATURAL_32
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_integer_16 (a_dest, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 2

				-- Write the name_index, signature_index
				-- to the buffer and update the number of bytes.
			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + signature_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
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
