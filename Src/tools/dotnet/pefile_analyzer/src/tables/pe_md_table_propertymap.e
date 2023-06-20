class
	PE_MD_TABLE_PROPERTYMAP

inherit
	PE_MD_TABLE [PE_MD_TABLE_PROPERTYMAP_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
			create Result.make (pe)
		end

end
