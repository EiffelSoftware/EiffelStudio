class
	PDB_MD_TABLE_DOCUMENT

inherit
	PDB_MD_TABLE [PDB_MD_TABLE_DOCUMENT_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
