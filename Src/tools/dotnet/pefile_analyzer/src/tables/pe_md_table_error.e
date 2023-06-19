class
	PE_MD_TABLE_ERROR

inherit
	PE_MD_TABLE [PE_MD_TABLE_UNKNOWN_ENTRY]
		redefine
			is_error
		end

create
	make

feature -- Acces

	is_error: BOOLEAN = True

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
--			create Result.make (pe)		
		end

end
