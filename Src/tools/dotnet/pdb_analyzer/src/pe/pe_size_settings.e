class
	PE_SIZE_SETTINGS

feature {NONE} -- Access

	is_initialized: BOOLEAN

feature -- Helpers	

	is_table_using_4_bytes (tb: NATURAL_8; a_tables: PDB_MD_TABLES; tagbit: INTEGER): BOOLEAN
		do
			if tagbit = 0 then
				Result := a_tables.table_size (tb) >= 0x1_0000  -- 2^16
			else
				Result := a_tables.table_size (tb) >= (2 ^ (16 - tagbit))  -- 2^(16-tagbit)
			end
		end

feature -- Initialization

	initialize (a_tables: PDB_MD_TABLES)
		do
			-- Heap
			is_string_heap_using_4_bytes := a_tables.string_heap_index_bytes_size = 4
			is_guid_heap_using_4_bytes := a_tables.guid_heap_index_bytes_size = 4
			is_blob_heap_using_4_bytes := a_tables.blob_heap_index_bytes_size = 4

			-- Table
			is_method_def_table_using_4_bytes		:=	is_table_using_4_bytes ({PE_TABLES}.tmethoddef, a_tables, 0)

			is_document_table_using_4_bytes			:=	is_table_using_4_bytes ({PDB_TABLES}.tdocument, a_tables, 0)
			is_import_scope_table_using_4_bytes		:=	is_table_using_4_bytes ({PDB_TABLES}.timportscope, a_tables, 0)
			is_local_variable_table_using_4_bytes	:=	is_table_using_4_bytes ({PDB_TABLES}.tlocalvariable, a_tables, 0)
			is_local_constant_table_using_4_bytes	:=	is_table_using_4_bytes ({PDB_TABLES}.tlocalconstant, a_tables, 0)

			is_initialized := True
		end

feature -- Heap settings

	is_string_heap_using_4_bytes,
	is_guid_heap_using_4_bytes,
	is_blob_heap_using_4_bytes: BOOLEAN

feature -- Settings

	is_method_def_table_using_4_bytes: BOOLEAN

	is_document_table_using_4_bytes: BOOLEAN

	is_import_scope_table_using_4_bytes: BOOLEAN

	is_local_variable_table_using_4_bytes: BOOLEAN

	is_local_constant_table_using_4_bytes: BOOLEAN


feature -- Multi index size

end
