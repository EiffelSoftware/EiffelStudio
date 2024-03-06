class
	PDB_MD_TABLE_STATE_MACHINE_METHOD

inherit
	PDB_MD_TABLE [PDB_MD_TABLE_STATE_MACHINE_METHOD_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
