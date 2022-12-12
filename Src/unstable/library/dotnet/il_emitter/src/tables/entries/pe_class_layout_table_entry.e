note
	description: "Summary description for {PE_CLASS_LAYOUT_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CLASS_LAYOUT_TABLE_ENTRY

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

	make_with_data (a_pack: NATURAL_16; a_size: NATURAL; a_parent: NATURAL_64)
		do
			pack := a_pack
			size := a_size
			create parent.make_with_index (a_parent)
		end

feature -- Access

	pack: NATURAL_16
			-- Defined as a word two bytes.

	size: NATURAL

	parent: PE_TYPE_DEF


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tClassLayout.value.to_integer_32
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
