note
	description: "[
					Class describing the LocalVariable table.
					The LocalVariable table has several columns and specific requirements.
			
					There shall be no duplicate rows in the LocalVariable table, based upon owner and Index.
					There shall be no duplicate rows in the LocalVariable table, based upon owner and Name.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Local Variable", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#localvariable-table-0x33", "protocol=uri"

class
	PE_LOCAL_VARIABLE_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_attributes: NATURAL_16; a_index: NATURAL_16; a_name_index: NATURAL_32)
		do
			attributes := a_attributes
			index := a_index
			create name_index.make_with_index (a_name_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There shall be no duplicate rows in the LocalVariable table, based upon owner and Index.
			--| There shall be no duplicate rows in the LocalVariable table, based upon owner and Name.

		do
			Result := Precursor (e)
				or else (
					e.index = index and then
					e.name_index.is_equal (name_index)
				)
		end

feature -- Access

	attributes: NATURAL_16
			-- LocalVariableAttributes value.

	index: NATURAL_16
			-- Slot index in the local signature of the containing MethodDef.

	name_index: PE_STRING
			-- String heap index.

feature -- Local Variable Attributes

	debugger_hidden: INTEGER = 0x0001
			-- Variable shouldn't appear in the list of variables displayed by the debugger

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PDB_TABLES}.tlocalvariable
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes_written: NATURAL_32
		do
				-- Initialize the number of bytes written to 0
			l_bytes_written := 0

				-- Write the attributes to the destination array
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, attributes, l_bytes_written.to_integer_32)
			l_bytes_written := l_bytes_written + 2

				-- Write the index to the destination array
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, index, l_bytes_written.to_integer_32)
			l_bytes_written := l_bytes_written + 2

				-- Render the name_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + name_index.render (a_sizes, a_dest, l_bytes_written)

				-- Return the total number of bytes written
			Result := l_bytes_written
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
			-- <Precursor>
		local
			l_bytes: NATURAL_32
		do
				-- Initialize the number of bytes read to 0
			l_bytes := 0

				-- Read the attributes from the source array
			l_bytes := l_bytes + 2

				-- Read the index from the source array
			l_bytes := l_bytes + 2

				-- Read the name_index
			l_bytes := l_bytes + name_index.rendering_size (a_sizes)

				-- Return the total number of bytes read
			Result := l_bytes
		end

end
