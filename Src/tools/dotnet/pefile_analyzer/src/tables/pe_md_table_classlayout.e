class
	PE_MD_TABLE_CLASSLAYOUT

inherit
	PE_MD_TABLE [PE_MD_TABLE_CLASSLAYOUT_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
			create Result.make (pe)		
		end

end
