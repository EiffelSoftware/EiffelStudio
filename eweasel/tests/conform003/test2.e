class
	TEST2 [G]

inherit
	TEST1 [G]
		redefine
			test_formals, y, make
		end

create
	make

feature 

	make 
		do
			Precursor
			create x.make (10)
		end

feature

	test_formals (v1: G; v2: detachable G; v3: attached G) is
		do
		end


	y: attached STRING

end
