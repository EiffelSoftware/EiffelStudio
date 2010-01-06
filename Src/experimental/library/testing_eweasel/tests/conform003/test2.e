class
	TEST2 [G]

inherit
	TEST1 [G]
		redefine
			test_formals, y
		end

create
	make

feature

	test_formals (v1: G; v2: ?G; v3: !G) is
		do
		end


	y: !STRING

end
