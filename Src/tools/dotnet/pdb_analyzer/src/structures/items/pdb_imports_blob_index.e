class
	PDB_IMPORTS_BLOB_INDEX

inherit
	PE_BLOB_INDEX
		redefine
			read
		end

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_BLOB_INDEX_ITEM
		do
			Result := pe.read_blob_index (label)
		end

end
