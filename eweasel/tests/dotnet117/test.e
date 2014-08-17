indexing
	dotnet_constructors: make
	
class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			create b.make
			io.put_string (b.to_string)
		end
		
	b: B

end
