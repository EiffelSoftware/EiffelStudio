class
	PDB_MD_TABLE_LOCAL_VARIABLE

inherit
	PDB_MD_TABLE [PDB_MD_TABLE_LOCAL_VARIABLE_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
