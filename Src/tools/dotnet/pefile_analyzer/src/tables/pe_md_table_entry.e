note
	description: "Summary description for {PE_MD_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE_ENTRY

inherit
	PE_VISITABLE

feature {NONE} -- Initialization

	make (pe: PE_FILE)
		do
			read (pe)
		end

	read (pe: PE_FILE)
		deferred
		end

feature -- Access

	table_id: NATURAL_32
		deferred
		ensure
			{PE_TABLES}.valid (Result)
		end

	description: STRING_8
		do
			Result := "No Information"
		end

	to_string: STRING_32
		do
			Result := {STRING_32} "{" + generator + "} " + dump
		end

	dump: STRING_8
		do
			Result := ""
		end

	has_error: BOOLEAN
		do
			-- To redefine !
		end

	errors: ARRAYED_LIST [PE_ERROR]
		require
			has_error
		do
			create Result.make (1)
		end

	report_not_implemented
		local
--			e: DEVELOPER_EXCEPTION
		do
--			create e;
--			e.set_description ("Not Implemented")
--			e.raise
			{EXCEPTIONS}.raise ("["+ generator +"] NotImplemented")
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_table_entry (Current)
		end

end
