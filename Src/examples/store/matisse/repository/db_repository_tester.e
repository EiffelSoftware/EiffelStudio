indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class DB_REPOSITORY_TESTER 

create

	make

feature

	make is
	do
		integer_value := 15
		real_value := -0.5
		double_value := 0.707
		character_value := '#'
		string_value := "coucou"
	end --

	integer_value : INTEGER

	real_value : REAL

	string_value : STRING 

	double_value : DOUBLE

	character_value : CHARACTER;

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


end -- class DB_REPOSITORY_TESTER

