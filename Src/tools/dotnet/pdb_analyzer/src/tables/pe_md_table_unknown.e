class
	PE_MD_TABLE_UNKNOWN

inherit
	PDB_MD_TABLE [PE_MD_TABLE_UNKNOWN_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PDB_FILE): like entry
		do
			create Result.make (pe)		
		end

end
