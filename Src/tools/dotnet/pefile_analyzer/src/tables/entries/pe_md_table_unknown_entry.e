class
	PE_MD_TABLE_UNKNOWN_ENTRY

inherit
	PE_MD_TABLE_ENTRY

create
	make

feature -- Access

	read (pe: PE_FILE)
		do
--			report_not_implemented
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {NATURAL_32}.max_value
		end

end
