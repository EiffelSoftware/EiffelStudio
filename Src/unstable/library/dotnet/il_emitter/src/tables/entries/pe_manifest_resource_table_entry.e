note
	description: "Summary description for {PE_MANIFEST_RESOURCE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MANIFEST_RESOURCE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_offset: NATURAL; a_flags: NATURAL; a_name: NATURAL_64; a_implementation: PE_IMPLEMENTATION)
		do
			offset := a_offset
			flags := a_flags
			create name.make_with_index (a_name)
			implementation := a_implementation
		end

feature -- Access

	offset: NATURAL

	flags: NATURAL

	name: PE_STRING

	implementation: PE_IMPLEMENTATION

feature -- Flags

	VisibilityMask: INTEGER = 7
	Public: INTEGER = 1
	Private: INTEGER = 2

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tManifestResource.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Initialize the bytes to write and set offset and flags to the buffer.
			l_bytes := 0
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest.to_special, offset, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest.to_special, flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4


				-- Write name and implemention to the buffer and update the bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + implementation.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Initialize the bytes to write and set offset and flags to the buffer.
			l_bytes := 0
			offset := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4


				-- Get name and implemention to the buffer and update the bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + implementation.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end

end
