class
	PE_MD_TABLE_CONSTANT

inherit
	PE_MD_SORTED_TABLE [PE_MD_TABLE_CONSTANT_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
			create Result.make (pe)
		end

	sorting_information: STRING_32 = "Parent"

end
