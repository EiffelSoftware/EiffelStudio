note
	description: "Summary description for {PE_ASSEMBLY_REF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ASSEMBLY_REF_TABLE_ENTRY

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

	make_with_data (a_flags: INTEGER; a_major, a_minor, a_build, a_revision: NATURAL_16; a_name_index: NATURAL_64; a_key_index: NATURAL_64)
		do
			flags := a_flags
			major := a_major
			minor := a_minor
			build := a_build
			revision := a_revision
			create name_index.make_with_index (a_name_index)
			create public_key_index.make_with_index (a_key_index)

		end

feature -- Access

	major: NATURAL_16

	minor: NATURAL_16

	build: NATURAL_16

	revision: NATURAL_16

	flags: INTEGER

	public_key_index: PE_BLOB

	name_index: PE_STRING

	culture_index: detachable PE_STRING

	hash_index: detachable PE_BLOB


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tassemblyref.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Initialize the number of bytes written
			l_bytes := 0

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

				-- Write public_key_index, name_index, culture_index and hash_index to the buffer and update the number of bytes.

 			l_bytes := l_bytes + public_key_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
 			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + if attached culture_index as l_ci then l_ci.render (a_sizes, a_dest, l_bytes.to_integer_32) else {NATURAL_64}0 end
			l_bytes := l_bytes + if attached hash_index as l_hi then l_hi.render (a_sizes, a_dest, l_bytes.to_integer_32) else {NATURAL_64}0 end

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
			l_bytes := l_bytes + if attached culture_index as l_ci then l_ci.get (a_sizes, a_src, l_bytes.to_integer_32) else {NATURAL_64}0 end
			l_bytes := l_bytes + if attached hash_index as l_hi then l_hi.get (a_sizes, a_src, l_bytes.to_integer_32) else {NATURAL_64}0 end

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
