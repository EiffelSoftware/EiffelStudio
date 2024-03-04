note
	description: "Object representing the FieldLayout table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=FieldLayout", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=251&zoom=100,116,504", "protocol=uri"

class
	PE_FIELD_LAYOUT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_offset: NATURAL_32; a_parent: NATURAL_32)
		do
			offset := a_offset
			create parent.make_with_index (a_parent)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.offset = offset and then
					e.parent.is_equal (parent)
				)
		end

feature -- Access

	offset: NATURAL_32
			-- a 4-byte constant.
			-- TODO: check what we need to do to use NATURAL_32

	parent: PE_FIELD_LIST
			-- an index into the Field table.

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tFieldLayout
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write offset to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_natural_32 (a_dest, offset, 0)

				-- Intialize the number of bytes written
			l_bytes := 4

				-- Write parent and premission set to the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the offset (from a_src)  to action
			offset := {BYTE_ARRAY_HELPER}.natural_32_at (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 4

				-- Read parent from the buffer and update the number of bytes.
			l_bytes := l_bytes + parent.get (a_sizes, a_src, l_bytes)
				-- Return the number of bytes readed
			Result := l_bytes
		end

end
