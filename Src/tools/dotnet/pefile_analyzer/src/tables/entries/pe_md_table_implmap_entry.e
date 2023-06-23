class
	PE_MD_TABLE_IMPLMAP_ENTRY

inherit
	PE_MD_TABLE_ENTRY

create
	make

feature -- Access

	read (pe: PE_FILE)
		do
			report_not_implemented
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.timplmap
		end

end
