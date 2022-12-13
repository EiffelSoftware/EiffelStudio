note
	description: "Summary description for {PE_FIELD_LAYOUT_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_LAYOUT_TABLE_ENTRY

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

	make_with_data (a_offset: NATURAL_64; a_parent: NATURAL_64)
		do
			offset := a_offset
			create parent.make_with_index (a_parent)
		end

feature -- Access

	offset: NATURAL_64

	parent: PE_FIELD_LIST

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tFieldLayout.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write offset to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_dest.to_special, offset, 0)

				-- Intialize the number of bytes written
			l_bytes := 4

				-- Write parent and premission set to the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the offset (from a_src)  to action
			offset := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 4

				-- Read parent from the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.get (a_sizes, a_src, l_bytes.to_integer_32)
				-- Return the number of bytes readed
			Result := l_bytes
		end

end
