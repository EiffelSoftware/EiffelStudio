note
	description: "Summary description for {PE_MD_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE_ENTRY

inherit
	PE_VISITABLE

	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (pe: PE_FILE)
		do
			read (pe)
		end

	read (pe: PE_FILE)
		deferred
		end

feature -- Access

	table_id: NATURAL_8
		deferred
		ensure
			{PE_TABLES}.valid (Result)
		end

	description: STRING_8
		do
			Result := "No Information"
		end

	description_as_array: ARRAY [READABLE_STRING_GENERAL]
		do
			Result := <<"No Information">>
		end

	token: NATURAL_32

feature -- Status report

	has_token: BOOLEAN = True

	debug_output: STRING
		do
			Result := token.to_hex_string + " {"+ {PE_MD_TABLES}.table_name (table_id) +"}"
		end

feature -- Conversion	

	to_string_array: ARRAY [like to_string]
		do
			Result := <<to_string>>
		end

	to_string: STRING_32
		do
			Result := {STRING_32} "{" + generator + "} " + dump
		end

	dump: STRING_8
		do
			Result := ""
		end

feature -- Errors		

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

feature -- Element change

	set_token (tok: like token)
		do
			token := tok
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_table_entry (Current)
		end

end
