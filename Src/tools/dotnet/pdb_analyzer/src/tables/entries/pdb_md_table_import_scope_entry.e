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


feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.timportscope
		end

end

