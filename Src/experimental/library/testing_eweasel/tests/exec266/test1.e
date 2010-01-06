expanded class
	TEST1
inherit
	ANY
		redefine
			default_create
		end
	
create
	default_create

feature

	default_create
		do
			i := 5
			s := "TEST"
		end

	display 
		do
			io.put_integer (i)
			io.put_new_line
			io.put_string (s)
			io.put_new_line
		end

	i: INTEGER
	s: STRING

end
