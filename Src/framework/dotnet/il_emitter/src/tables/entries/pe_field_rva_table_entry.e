note
	description: "Object representing the FieldRVA table."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=FieldRVA", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=253&zoom=100,116,310", "protocol=uri"

class
	PE_FIELD_RVA_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_rva: NATURAL_64; a_field_index: NATURAL_64)
		do
			rva := a_rva
			create field_index.make_with_index (a_field_index)
		end

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			n: NATURAL_64
		do
			n := 0
			across
				tables as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.rva = rva and then
					e.field_index.is_equal (field_index)
				then
					Result := n
				end
			end
		end

feature -- Access

	rva: NATURAL_64
			-- (a 4-byte constant)

	field_index: PE_FIELD_LIST
			-- An index into the Field table.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tfieldrva.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- note that when reading rva_ holds the rva, when writing it holds an offset into the CIL section
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_dest.to_special, rva + {PE_WRITER}.cildata_rva.value, 0)

				-- Initialize the number of bytes written
			l_bytes := 4

				-- Write field_index
				-- to the buffer and update the number of bytes.
			l_bytes := l_bytes + field_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- note that when reading rva_ holds the rva, when writing it holds an offset into the CIL section
				-- Set the rva (from a_src)  to the rva.
			rva := {BYTE_ARRAY_HELPER}.byte_array_to_natural_64 (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 4

				-- Get the field_index and
				-- update the number of bytes.

			l_bytes := l_bytes + field_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
