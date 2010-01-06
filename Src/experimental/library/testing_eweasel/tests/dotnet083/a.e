indexing
	dotnet_constructors: make

class
	A

inherit
	SYSTEM_OBJECT

create
	make,
	make_with_name
	
feature {NONE} -- Initialization

	make is
		do
			print ("Empty%N")
		end
		
	make_with_name (a_name: STRING) is
		do
			print (a_name + "%N")
		end

end
