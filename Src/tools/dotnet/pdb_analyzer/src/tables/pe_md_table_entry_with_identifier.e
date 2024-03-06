note
	description: "Summary description for {PE_MD_TABLE_ENTRY_WITH_IDENTIFIER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

feature -- Display

	resolved_identifier (pe: PDB_FILE): detachable STRING_32
			-- Human identifier
		deferred
		end

end
