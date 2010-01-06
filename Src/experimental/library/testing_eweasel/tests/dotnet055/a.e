indexing
	dotnet_constructors: make
	
class
	A

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Intialization

	make (a_arg: SYSTEM_STRING)
		do
			print (a_arg + "%N")
		end
		
end
