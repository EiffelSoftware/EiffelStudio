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

	character_value : CHARACTER

end -- class DB_REPOSITORY_TESTER
