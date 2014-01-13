note
	description: "Summary description for {PS_RELATIONAL_SQL_STRINGS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_RELATIONAL_SQL_STRINGS

feature

	show_tables: STRING
		deferred
		end

	assemble_upsert (table: READABLE_STRING_8; columns: LIST [STRING]; values: LIST [STRING]): STRING
		deferred
		end
end
