note
	description: "Summary description for {PE_ASSEMBLY_DEF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ASSEMBLY_DEF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_major, a_minor, a_build, a_revision: NATURAL_16; a_name_index: NATURAL_64; a_key_index: NATURAL_64)
			-- key_index default value = 0
			--|ECMA II.22.2 Assembly : 0x20
		do
			hash_alg_id := DefaultHashAlgId.to_natural_16
			flags := a_flags
			major := a_major
			minor := a_minor
			build := a_build
			revision := a_revision
			create name_index.make_with_index (a_name_index)
			create public_key_index.make_with_index (a_key_index)
			create culture_index.make_with_index (0)
		end

feature -- Access

	hash_alg_id: NATURAL_16
			-- Defined as word two bytes.

	major, minor, build, revision: NATURAL_16
			-- Defined as word two bytes.

	flags: INTEGER assign set_flags

	public_key_index: PE_BLOB assign set_public_key_index
	name_index: PE_STRING
	culture_index: PE_STRING

feature -- flags

	DefaultHashAlgId: INTEGER = 0x8004


feature -- Element Change

	set_public_key_index (a_index: like public_key_index)
			-- Set `public_key_index` with `a_index`.
		do
			public_key_index := a_index
		ensure
			public_key_index_set: public_key_index = a_index
		end

	set_flags (a_flag: INTEGER)
			-- Set `flags` with `a_flag`.
		do
			flags := a_flag
		ensure
			flags_set: flags = a_flag
		end

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tAssemblyDef.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write the defaulthashalgid to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_integer_32 (a_dest.to_special, defaulthashalgid, 0)

				-- Initialize the number of bytes written
			l_bytes := 4

				-- Assembly version
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, major, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, minor, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, build, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, revision, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_integer_32 (a_dest.to_special, flags, l_bytes.to_integer_32)
			l_bytes := l_bytes +  4

				-- Write public_key_index, name_index, culture_index to the buffer and update the number of bytes.

 			l_bytes := l_bytes + public_key_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
 			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + culture_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- always assume the right hash algorithm as there is currently only one spec'd
				-- Initialize the number of bytes readed
				-- TODO check if we need to get the hash ffrom the buffer and set to
				-- hash_alg_id	
			l_bytes := 4

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

				-- Get the public_key_index, name_index  culture_index and
				-- update the number of bytes.

			l_bytes := l_bytes + public_key_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + name_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + culture_index.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
