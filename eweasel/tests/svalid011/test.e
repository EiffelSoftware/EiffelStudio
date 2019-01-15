class TEST

inherit
	TEST4
		redefine
			test_g
		end

create
	make

feature -- Access

	test_g: DIRECTORY_NAME
		-- Used for testing

end
