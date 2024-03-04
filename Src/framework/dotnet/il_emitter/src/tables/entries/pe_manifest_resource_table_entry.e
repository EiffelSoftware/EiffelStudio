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
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_offset: NATURAL_32; a_flags: NATURAL_32; a_name: NATURAL_32; a_implementation: PE_IMPLEMENTATION)
		do
			offset := a_offset
			flags := a_flags
			create name.make_with_index (a_name)
			implementation := a_implementation
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			-- There shall be no duplicate rows, based upon Name
		do
			Result := Precursor (e)
				or else (
					e.name.is_equal (name)
				)
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

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tManifestResource
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Initialize the bytes to write and set offset and flags to the buffer.
			l_bytes := 0
			{BYTE_ARRAY_HELPER}.put_natural_32 (a_dest, offset, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4
			{BYTE_ARRAY_HELPER}.put_natural_32 (a_dest, flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Write name and implemention to the buffer and update the bytes.
			l_bytes := l_bytes + name.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + implementation.render (a_sizes, a_dest, l_bytes)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Initialize the bytes to write and set offset and flags to the buffer.
			l_bytes := 0
			offset := {BYTE_ARRAY_HELPER}.natural_32_at (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4
			flags := {BYTE_ARRAY_HELPER}.natural_32_at (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Get name and implemention to the buffer and update the bytes.
			l_bytes := l_bytes + name.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + implementation.get (a_sizes, a_src, l_bytes)

			Result := l_bytes
		end

end
