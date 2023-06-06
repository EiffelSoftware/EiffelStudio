note
	description: "Object Representing the ManifestResource table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ManifestResource", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=257&zoom=100,116,746", "protocol=uri"

class
	PE_MANIFEST_RESOURCE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_offset: NATURAL_32; a_flags: NATURAL_32; a_name: NATURAL_64; a_implementation: PE_IMPLEMENTATION)
		do
			offset := a_offset
			flags := a_flags
			create name.make_with_index (a_name)
			implementation := a_implementation
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
					e.offset = offset and then
					e.flags = flags and then
					e.name.is_equal (name) and then
					e.implementation.is_equal (implementation)
				then
					Result := n
				end
			end
		end

feature -- Access

	offset: NATURAL
			-- a 4-byte constant.

	flags: NATURAL
			-- a 4-byte bitmask of type ManifestResourceAttributes

	name: PE_STRING
			-- an index into the String heap

	implementation: PE_IMPLEMENTATION
			-- an index into a File table, a AssemblyRef table, or null; more
			-- precisely, an Implementation index.

feature -- Flags

	VisibilityMask: INTEGER = 7
	Public: INTEGER = 1
	Private: INTEGER = 2

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tManifestResource.to_integer_32
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
