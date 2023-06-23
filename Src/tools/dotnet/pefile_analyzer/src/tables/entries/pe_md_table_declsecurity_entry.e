class
	PE_MD_TABLE_DECLSECURITY_ENTRY

inherit
	PE_MD_TABLE_ENTRY

create
	make

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tdeclsecurity
		end

	read (pe: PE_FILE)
		do
			report_not_implemented
		end

end
