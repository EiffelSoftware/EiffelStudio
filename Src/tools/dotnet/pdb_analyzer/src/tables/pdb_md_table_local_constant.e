class
	PDB_MD_TABLE_LOCAL_CONSTANT

inherit
	PDB_MD_TABLE [PDB_MD_TABLE_LOCAL_CONSTANT_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
