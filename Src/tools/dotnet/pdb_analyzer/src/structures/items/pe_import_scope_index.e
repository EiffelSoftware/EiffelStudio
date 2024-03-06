class
	PE_IMPORT_SCOPE_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_IMPORT_SCOPE_INDEX_ITEM
		do
			Result := pe.read_import_scope_index (label)
		end


end
