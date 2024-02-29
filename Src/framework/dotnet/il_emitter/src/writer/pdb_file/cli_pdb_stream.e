Note
	description: "[
					Object representing a PDB stream
				
				Offset	Size	Field						Description
				0		20		PDB id						A byte sequence uniquely representing the debugging metadata blob content.	
				20		4		EntryPoint					Entry point MethodDef token, or 0 if not applicable. The same value as stored in CLI header of the PE file. See ECMA-335-II 15.4.1.2.
				24		8		ReferencedTypeSystemTables	Bit vector of referenced type system metadata tables, let n be the number of bits that are 1.
				32		4*n		TypeSystemTableRows			Array of n 4-byte unsigned integers indicating the number of rows for each referenced type system metadata table.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=pdb stream", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#pdb-stream", "protocol=uri"

class
	CLI_PDB_STREAM

create
	make

feature {NONE} -- Initialization

	make
		do
			create pdb_id.make_filled (0, 1, 5)
			entry_point := 0
			create referenced_type_system_tables.make_filled (0, 1, 2)
			create type_system_table_rows.make_empty
		end

feature -- Access

	pdb_id: ARRAY [NATURAL_8]
			-- A byte sequence uniquely representing the debugging metadata blob content.
			-- size 20 (5 bytes)

	entry_point: INTEGER_32
			-- Entry point MethodDef token, or 0 if not applicable. The same value as stored in CLI header of the PE file.
			-- See ECMA-335-II 15.4.1.2.

	referenced_type_system_tables: ARRAY [NATURAL_8]
			-- Bit vector of referenced type system metadata tables, let n be the number of bits that are 1.
			-- Size 8 (2 bytes)

	type_system_table_rows: ARRAY [NATURAL_32]
			-- Array of n 4-byte unsigned integers indicating the number of rows for each referenced type system metadata table.


feature -- Change Element

	set_pdb_id (a_pdb_id: ARRAY [NATURAL_8])
			-- Set `pdb_id` with `a_pdb_id`
		require
			valid_length: a_pdb_id.count = 20
		do
			pdb_id := a_pdb_id
		end

	set_entry_point (a_entry_point: INTEGER_32)
			-- Set 	`entry_point` with `a_entry_point`.
		do
			entry_point := a_entry_point
		end

	set_referenced_type_system_tables (a_references: ARRAY [NATURAL_8])
			-- Set `referenced_type_system_tables` with `a_references`.
		require
			valid_length: a_references.count = 8
		do
			create referenced_type_system_tables.make_from_array (a_references)
		end

	set_type_system_table_rows (a_rows: ARRAY [NATURAL_32])
			-- Set `type_system_table_rows` with `a_rows`.
		do
			create type_system_table_rows.make_from_array (a_rows)
		end

feature -- Managed Pointer

	item: CLI_MANAGED_POINTER
			-- write the items to the buffer in  little-endian format.
		do
			create Result.make (size_of)

				-- pdb-id
			check pdb_id.count = 20 end
			Result.put_natural_8_array (pdb_id)

				-- entry_point
			Result.put_integer_32 (entry_point)

				-- referenced_type_system_tables
			check referenced_type_system_tables.count = 8 end
			Result.put_natural_8_array (referenced_type_system_tables)

				-- type_system_table_rows
			across
				type_system_table_rows as ic
			loop
				Result.put_natural_32 (ic.item)
			end
		ensure
			item.position = size_of
		end

feature -- Measurement

	size_of: INTEGER
			-- Size of `CLI_PDB_STREAM' structure.
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make

				-- pdb_id
			check pdb_id.count = 20 end
			s.put_natural_8_array (pdb_id.count)

				-- entry_point
			s.put_integer_32

				-- referenced_type_system_tables
			check referenced_type_system_tables.count = 8 end
			s.put_natural_8_array (referenced_type_system_tables.count)

				-- type_system_table_rows	
			s.put_natural_8_array (type_system_table_rows.count * 4)

			Result := s
		end


end
