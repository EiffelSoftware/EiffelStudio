indexing
	dotnet_constructors: make
	
class
	B

inherit
	A
		rename
			make as make_a
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: SYSTEM_STRING)
		do
			print ("Hello B%N")
		end

end
