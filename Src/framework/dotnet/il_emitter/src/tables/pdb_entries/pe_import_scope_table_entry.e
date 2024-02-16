note
	description: "[
			Class describing the ImportScope table.
			The ImportScope table has several columns.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ImportScope", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#importscope-table-0x35", "protocol=uri"

class
	PE_IMPORT_SCOPE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_parent_row_id: NATURAL_32; a_imports_index: NATURAL_32)
		do
				-- TODO double check if index are 0' based.
				-- if not we need to pass -1
			if a_parent_row_id > 0 then
				create parent_row_id.make_with_index (a_parent_row_id)
			end
			create imports_index.make_with_index (a_imports_index)
		end

feature -- Access

	parent_row_id: detachable PE_IMPORT_SCOPE
			-- ImportScope row id or nil.

	imports_index: PE_BLOB
			-- Blob index, encoding: Imports blob.
			-- https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#imports-blob
			--| PE_IMPORTS_BLOB
			--| Blob ::= Import*
			--| Import ::= kind alias? target-assembly? target-namespace? target-type?

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PDB_TABLES}.tImportScope
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes_written: NATURAL_32
			null_scope: PE_IMPORT_SCOPE
		do
				-- Initialize the number of bytes written to 0
			l_bytes_written := 0

				-- Render the parent_row_id and add the number of bytes written to l_bytes_written
			if attached parent_row_id as l_parent_row_id then
				l_bytes_written := l_bytes_written + l_parent_row_id.render (a_sizes, a_dest, l_bytes_written)
			else
				create null_scope.make_with_index (0)
				l_bytes_written := l_bytes_written + null_scope.render (a_sizes, a_dest, l_bytes_written)
			end

				-- Render the imports_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + imports_index.render (a_sizes, a_dest, l_bytes_written)

				-- Return the total number of bytes written
			Result := l_bytes_written
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
			-- <Precursor>
		local
			l_bytes: NATURAL_32
			null_scope: PE_IMPORT_SCOPE
		do
				-- Initialize the number of bytes read to 0
			l_bytes := 0

				-- Read the parent_row_id

			if attached parent_row_id as l_parent_row_id then
				l_bytes := l_bytes + l_parent_row_id.get (a_sizes, a_src, l_bytes)
			else
				create null_scope.make_with_index (0)
				l_bytes := l_bytes + null_scope.get (a_sizes, a_src, l_bytes)
			end
				-- Read the imports_index
			l_bytes := l_bytes + imports_index.get (a_sizes, a_src, l_bytes)

				-- Return the total number of bytes read
			Result := l_bytes
		end

end
