class
	PE_MD_TABLE_UNKNOWN_ENTRY

inherit
	PDB_MD_TABLE_ENTRY

create
	make

feature -- Access

	read (pe: PDB_FILE)
		do
--			report_not_implemented
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {NATURAL_8}.max_value
		end

end
