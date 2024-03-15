class
	PDB_MD_TABLE_IMPORT_SCOPE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "ImportScope")
			structure := struct
			struct.add_import_scope_index ("Parent")
			struct.add_imports_blob_index ("Imports") -- (Blob index, encoding: Imports blob)
		end

feature -- Access

	parent: detachable PE_IMPORT_SCOPE_INDEX_ITEM
		do
			if attached {like parent} structure.index_item ("Parent") as p then
				Result := p
			end
		end

	imports_index: detachable PE_BLOB_INDEX_ITEM
		do
			if attached {like imports_index} structure.index_item ("Imports") as b then
				Result := b
			end
		end

feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.timportscope
		end

end

