indexing
	dotnet_constructors: make
	
class
	B

inherit
	A
		rename
			make as make_a,
			make_from_a_0 as make_from_string
		end

create
	make,
	make_from_string

feature {NONE} -- Initialization

	make
		do
			print ("Hello using B ctor%N")
		end

end
