class
	PE_DOCUMENT_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_DOCUMENT_INDEX_ITEM
		do
			Result := pe.read_document_index (label)
		end


end
