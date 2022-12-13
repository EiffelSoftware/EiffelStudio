note
	description: "Summary description for {PE_FILE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FILE_TABLE_ENTRY

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

	make_with_data (a_flags: NATURAL_32; a_name: NATURAL_64; a_hash: NATURAL_64)
		do
			flags := a_flags
			create name.make_with_index (a_name)
			create hash.make_with_index (a_hash)
		end

feature -- Access

	flags: NATURAL_32
			-- Defined as a DWord four bytes.

	name: PE_STRING

	hash: PE_BLOB

feature -- Flags

	ContainsMetaData: INTEGER = 0

	ContainsNoMetaData: INTEGER = 1

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfile.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set flags to the buffer.
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest.to_special, flags, 0)
				-- Initialize the bytes
			l_bytes := 4

				-- Render name and hash and update the bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + hash.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
	local
			l_bytes: NATURAL_64
		do
				-- get flags from the buffer.
			flags :={BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, 0)
				-- Initialize the bytes
			l_bytes := 4

				-- Get name and hash and update the bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + hash.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end
end
