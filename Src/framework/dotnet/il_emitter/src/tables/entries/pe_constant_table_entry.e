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

	make_with_data (a_type: INTEGER; a_parent_index: PE_CONSTANT; a_value_index: NATURAL_64)
		do
			type := a_type.to_natural_8
			parent_index := a_parent_index
			create value_index.make_with_index (a_value_index)
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.type = type and then
					e.parent_index.is_equal (parent_index) and then
					e.value_index.is_equal (value_index)
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

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tconstant.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write the type to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_8 (a_dest.to_special, type, 0)
			{BYTE_ARRAY_HELPER}.put_array_natural_8 (a_dest.to_special, 0, 1)

				-- Initialize the number of bytes written
			l_bytes := 2

				-- Write the parent_index and value_index to the buffer and update the number of bytes
			l_bytes := l_bytes + parent_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + value_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the type (from a_src)  to the type
			type := {BYTE_ARRAY_HELPER}.byte_array_to_natural_8 (a_src, 0)

				-- Initialize the number of bytes readad
			l_bytes := 2

				-- Read the parent_index and value_index from the buffer and update the number of bytes
			l_bytes := l_bytes + parent_index.render (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + value_index.render (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the total number of bytes readed
			Result := l_bytes
		end

end
