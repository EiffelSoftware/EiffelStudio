class TEST

inherit
	TEST4
		redefine
			test_g
		end

create
	make

feature -- Access

	test_g: FILE_NAME
		-- Used for testing

end
