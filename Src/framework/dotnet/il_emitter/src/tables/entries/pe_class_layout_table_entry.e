note
	description: "[
			Object representing the class layour table
			The ClassLayout table is used to define how the fields of a class or value type shall be laid out by the
			CLI. (Normally, the CLI is free to reorder and/or insert gaps between the fields defined for a class or
			value type.)
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ClassLayout", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=240&zoom=100,116,96", "protocol=uri"

class
	PE_CLASS_LAYOUT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
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

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			lst: LIST [PE_TABLE_ENTRY_BASE]
			n: NATURAL_64
		do
			lst := tables.table
			n := 0
			across
				lst as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.pack = pack and then
					e.size = size and then
					e.parent.is_equal (parent)
				then
					Result := n
				end
			end
		end

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

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tClassLayout.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write pack to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, pack, 0)
				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write size to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest.to_special, size, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Write parent to the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the pack (from a_src)  to pack
			pack := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, 0)

				-- Initialize the number of bytes
			l_bytes := 2
			size := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, l_bytes.to_integer_32)

				-- Read parent from the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes
			Result := l_bytes

		end

end
