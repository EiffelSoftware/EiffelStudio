note
	description: "[
			Class describing the LocalScope table.
			The LocalScope table has several columns and specific sorting and range requirements.
			
			The table is required to be sorted first by Method in ascending order, then by StartOffset in ascending order, then by Length in descending order.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=LocalScope", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#localscope-table-0x32", "protocol=uri"

class
	PE_LOCAL_SCOPE_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_method_row_id: NATURAL_32; a_import_scope_row_id: NATURAL_32; a_variable_list_row_id: NATURAL_32; a_constant_list_row_id: NATURAL_32; a_start_offset: NATURAL_32; a_length: NATURAL_32)
		do
				-- TODO
				-- maybe we can directly pass the method_row_id: as PE_METHOD_DEF_OR_REF.
			create method_row_id.make_with_tag_and_index ({PE_METHOD_DEF_OR_REF}.methoddef, a_method_row_id)
			create import_scope_row_id.make_with_index (a_import_scope_row_id)
			create variable_list_row_id.make_with_index (a_variable_list_row_id)
			create constant_list_row_id.make_with_index (a_constant_list_row_id)
			start_offset := a_start_offset
			length := a_length
		end

feature -- Access

	method_row_id: PE_METHOD_DEF_OR_REF
			-- MethodDef row index.

	import_scope_row_id: PE_IMPORT_SCOPE
			-- ImportScope row index.

	variable_list_row_id: PE_LOCAL_VARIABLE_LIST
			-- LocalVariable row index.
			-- An index into the LocalVariable table; it marks the first of a contiguous run of LocalVariables owned by this LocalScope.
			-- The run continues to the smaller of:
			-- the last row of the LocalVariable table
			-- the next run of LocalVariables, found by inspecting the VariableList of the next row in this LocalScope table.


	constant_list_row_id: PE_LOCAL_CONSTANT_LIST
			-- LocalConstant row index.
			--| An index into the LocalConstant table; it marks the first of a contiguous run of LocalConstants owned by this LocalScope.
			--| The run continues to the smaller of:
			--| the last row of the LocalConstant table
			--| the next run of LocalConstants, found by inspecting the ConstantList of the next row in this LocalScope table.

	start_offset: NATURAL_32
			-- Starting IL offset of the scope.

	length: NATURAL_32
			-- The scope length in bytes.

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PDB_TABLES}.tLocalScope
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes_written: NATURAL_32
		do
				-- Initialize the number of bytes written to 0
			l_bytes_written := 0

				-- Render the method_row_id and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + method_row_id.render (a_sizes, a_dest, l_bytes_written)

				-- Render the import_scope_row_id and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + import_scope_row_id.render (a_sizes, a_dest, l_bytes_written)

				-- Render the variable_list_row_id and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + variable_list_row_id.render (a_sizes, a_dest, l_bytes_written)

				-- Render the constant_list_row_id and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + constant_list_row_id.render (a_sizes, a_dest, l_bytes_written)

				-- Write the start_offset to the destination array
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, start_offset, l_bytes_written.to_integer_32)
			l_bytes_written := l_bytes_written + 4

				-- Write the length to the destination array
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, length, l_bytes_written.to_integer_32)
			l_bytes_written := l_bytes_written + 4

				-- Return the total number of bytes written
			Result := l_bytes_written
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Initialize the number of bytes read to 0
			l_bytes := 0

				-- Read the method_row_id
			l_bytes := l_bytes + method_row_id.get (a_sizes, a_src, l_bytes)

				-- Read the import_scope_row_id
			l_bytes := l_bytes + import_scope_row_id.get (a_sizes, a_src, l_bytes)

				-- Read the variable_list_row_id
			l_bytes := l_bytes + variable_list_row_id.get (a_sizes, a_src, l_bytes)

				-- Read the constant_list_row_id
			l_bytes := l_bytes + constant_list_row_id.get (a_sizes, a_src, l_bytes)

				-- Read the start_offset from the source array
			start_offset := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Read the length from the source array
			length := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 4

				-- Return the total number of bytes read
			Result := l_bytes
		end

end
