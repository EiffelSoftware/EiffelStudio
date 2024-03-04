note
	description: "Object representing the Constant table is used to store compile-time, constant values for fields, parameters, and properties. "
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Constant", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=242&zoom=100,116,169", "protocol=uri"

class
	PE_CONSTANT_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Intialization

	make_with_data (a_type: INTEGER; a_parent_index: PE_CONSTANT; a_value_index: NATURAL_32)
		do
			type := a_type.to_natural_8
			parent_index := a_parent_index
			create value_index.make_with_index (a_value_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			-- There shall be no duplicate rows, based upon Parent
		do
			Result := Precursor (e)
				or else (
					e.parent_index.is_equal (parent_index)
				)
		end

feature -- Access

	type: NATURAL_8
			-- Defined as a Byte 1 byte.
			-- a 1-byte constant, followed by a 1-byte padding zero). The
			-- encoding of Type for the nullref value for FieldInit in ilasm is
			-- ELEMENT_TYPE_CLASS with a Value of a 4-byte zero

	parent_index: PE_CONSTANT
			-- an index into the Param, Field, or Property table; more precisely, a
			-- HasConstant coded index

	value_index: PE_BLOB
			-- an index into the Blob heap

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tconstant
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write the type to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_natural_8 (a_dest, type, 0)
			l_bytes := 1
			{BYTE_ARRAY_HELPER}.put_natural_8 (a_dest, 0, 1)
			l_bytes := l_bytes + 1

				-- Write the parent_index and value_index to the buffer and update the number of bytes
			l_bytes := l_bytes + parent_index.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + value_index.render (a_sizes, a_dest, l_bytes)

				-- Return the total number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the type (from a_src)  to the type
			type := {BYTE_ARRAY_HELPER}.natural_8_at (a_src, 0)
				-- also unused byte +1

				-- Initialize the number of bytes readad
			l_bytes := 2

				-- Read the parent_index and value_index from the buffer and update the number of bytes
			l_bytes := l_bytes + parent_index.render (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + value_index.render (a_sizes, a_src, l_bytes)

				-- Return the total number of bytes readed
			Result := l_bytes
		end

end
