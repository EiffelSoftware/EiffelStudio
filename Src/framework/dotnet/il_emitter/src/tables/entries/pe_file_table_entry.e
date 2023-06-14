note
	description: "Object representing the File table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=File", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=297", "protocol=uri"
	EIS: "name=Flags for file", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=277&zoom=100,116,376", "protocol=uri"

class
	PE_FILE_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: NATURAL_32; a_name: NATURAL_32; a_hash: NATURAL_32)
		do
				-- See section II.22.19 File : 0x26
			flags := a_flags
			create name.make_with_index (a_name)
			create hash.make_with_index (a_hash)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			-- There shall be no duplicate rows; that is, rows with the same Name value.
		do
			Result := Precursor (e)
				or else (
					e.name.is_equal (name)
				)
		end

feature -- Access

	flags: NATURAL_32
			-- Defined as a DWord four bytes.

	name: PE_STRING
			-- an index into the String heap.

	hash: PE_BLOB
			-- an index into the Blob heap.

feature -- Flags

	ContainsMetaData: INTEGER = 0
			-- This is not a resource file.

	ContainsNoMetaData: INTEGER = 1
			-- This is a resource file or other non-metadata-containing file

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tfile
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set flags to the buffer.
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, flags, 0)
				-- Initialize the bytes
			l_bytes := 4

				-- Render name and hash and update the bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + hash.render (a_sizes, a_dest, l_bytes)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- get flags from the buffer.
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, 0)
				-- Initialize the bytes
			l_bytes := 4

				-- Get name and hash and update the bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + hash.get (a_sizes, a_src, l_bytes)

			Result := l_bytes
		end

end
