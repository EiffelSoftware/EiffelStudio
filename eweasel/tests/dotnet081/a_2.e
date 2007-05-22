indexing
	dotnet_constructors: make, make_with_name
	
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
			print ("Single Empty%N")
		end
		
	make_with_name (a_name: STRING) is
		do
			print ("Single " + a_name + "%N")
		end

end
