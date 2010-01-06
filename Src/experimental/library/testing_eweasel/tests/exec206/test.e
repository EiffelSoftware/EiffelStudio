class
	TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			t: TEST2
		do
			create t
			t.create_new_list
		end

end
