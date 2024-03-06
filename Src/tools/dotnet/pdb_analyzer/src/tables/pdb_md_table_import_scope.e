class
	PDB_MD_TABLE_IMPORT_SCOPE

inherit
	PDB_MD_TABLE [PDB_MD_TABLE_IMPORT_SCOPE_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
