indexing
	dotnet_constructors: make
	
class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_b: B
		do
			create l_b.make_from_string ("Hello using A ctor")
			create l_b.make
		end
		
end
