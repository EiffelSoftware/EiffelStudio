note
	description: "[
			Object representing the class layour table
			The ClassLayout table is used to define how the fields of a class or value type shall be laid out by the
			CLI. (Normally, the CLI is free to reorder and/or insert gaps between the fields defined for a class or
			value type.)
			A ClassLayout table can contain zero or more rows.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ClassLayout", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=240&zoom=100,116,96", "protocol=uri"

class
	PE_CLASS_LAYOUT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_pack: NATURAL_16; a_size: NATURAL; a_parent: NATURAL_32)
		do
			pack := a_pack
			size := a_size
			create parent.make_with_index (a_parent)
		end

feature -- Status


feature -- Access

	pack: NATURAL_16
			-- Defined as a word two bytes.
			-- packing size.

	size: NATURAL
			-- class size
			-- a 4-byte constant

	parent: PE_TYPE_DEF
			-- an index into the TypeDef table

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tClassLayout
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write pack to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, pack, 0)
				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write size to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, size, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Write parent to the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the pack (from a_src)  to pack
			pack := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)

				-- Initialize the number of bytes
			l_bytes := 2

			size := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Read parent from the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes
			Result := l_bytes

		end

end
