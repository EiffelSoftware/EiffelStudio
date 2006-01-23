indexing
	description: "String format of the database"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_STRING [G -> DATABASE create default_create end]

inherit

	DB_TYPE

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name of string
		do
			Result := db_spec.sql_name_string
		end
	
	eiffel_ref: STRING is
			-- Shared string reference
		once
			create Result.make (0)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATABASE_STRING


