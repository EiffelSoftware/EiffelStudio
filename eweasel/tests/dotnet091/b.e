indexing
	dotnet_constructors: make_with_string
	
class
	B

inherit
	A
		rename
			make as make_a,
			make_from_a_0 as make_from_string
		end

create
	make_with_string,
	make_from_string

feature {NONE} -- Initialization

	make_with_string (a_string: SYSTEM_STRING)
		do
			print (a_string)
			print ("%N")
		end

end
