class
	PDB_MD_TABLE_METHOD_DEBUG_INFORMATION

inherit
	PDB_MD_TABLE [PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
