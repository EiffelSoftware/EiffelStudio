indexing
	description: "Boolean format of the database"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATABASE_BOOLEAN [G -> DATABASE create default_create end]

inherit

	DB_TYPE
		redefine
			eiffel_name
		end

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name for boolean
		do
			Result := db_spec.sql_name_boolean
		end
	
	eiffel_name: STRING is
			-- Eiffel type name for boolean
		once
			Result := "BOOLEAN"
		ensure then
			textual_outlook: Result.is_equal ("BOOLEAN")
		end

	eiffel_ref: BOOLEAN_REF is
			-- Shared boolean reference
		once
			create Result
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




end -- class DATABASE_BOOLEAN


