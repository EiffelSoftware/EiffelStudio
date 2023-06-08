note
	description: "Object representing The AssemblyRef table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=AssemblyRef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=238&zoom=100,116,793", "protocol=uri"

class
	PE_ASSEMBLY_REF_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_major, a_minor, a_build, a_revision: NATURAL_16; a_name_index: NATURAL_64; a_key_index: NATURAL_64)
			-- Defaul value for a_key_index = 0
		do
			flags := a_flags
			major := a_major
			minor := a_minor
			build := a_build
			revision := a_revision
			create name_index.make_with_index (a_name_index)
			create public_key_index.make_with_index (a_key_index)
				-- Create a default culture index.
			create culture_index.make_with_index (0)
				-- Create a default hash_index
			create hash_index.make_with_index (0)

		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.major = major and then
					e.minor = minor and then
					e.build = build and then
					e.revision = revision and then
					e.flags = flags and then
					e.public_key_index.is_equal (public_key_index) and then
					e.name_index.is_equal (name_index) and then
					e.culture_index.is_equal (culture_index) and then
					e.hash_index.is_equal (hash_index)
				)
		end

feature -- Access

	major: NATURAL_16
			-- 2 byte constant.

	minor: NATURAL_16
			-- 2 byte constant.

	build: NATURAL_16
			-- 2 byte constant.

	revision: NATURAL_16
			-- 2 byte constant.

	flags: INTEGER
			-- a 4-byte bitmask of type AssemblyFlags
			-- see https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=275&zoom=100,116,337

	public_key_index: PE_BLOB
			-- an index into the Blob heap, indicating the public key or token
			-- that identifies the author of this Assembly

	name_index: PE_STRING
			-- an index into the String heap

	culture_index: PE_STRING
			-- an index into the String heap

	hash_index: PE_BLOB
			-- an index into the Blob heap.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tassemblyref.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Initialize the number of bytes written
			l_bytes := 0

				-- Assembly version
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, major, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, minor, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, build, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, revision, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_integer_32 (a_dest, flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Write public_key_index, name_index, culture_index and hash_index to the buffer and update the number of bytes.

			l_bytes := l_bytes + public_key_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + culture_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + hash_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Initialize the number of bytes readed
			l_bytes := 0

				-- Assembly version
			major := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			minor := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			build := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			revision := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_32 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Get the public_key_index, name_index  culture_index, hash_index and
				-- update the number of bytes.

			l_bytes := l_bytes + public_key_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + name_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + culture_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + hash_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
