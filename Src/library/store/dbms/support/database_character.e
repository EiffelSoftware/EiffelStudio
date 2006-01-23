indexing
	description: "Character format of the database"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATABASE_CHARACTER [G -> DATABASE create default_create end]

inherit

	DB_TYPE
		redefine
			eiffel_name
		end

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name for character
		do
			Result := db_spec.sql_name_character
		end
	
	eiffel_name: STRING is
			-- Eiffel type name for character
		once
			Result := "CHARACTER"
		ensure then
			Result.is_equal ("CHARACTER")
		end

	eiffel_ref: CHARACTER_REF is
			-- Shared character reference 
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




end -- class DATABASE_CHARACTER


