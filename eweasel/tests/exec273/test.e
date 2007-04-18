class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A
		do
			io.put_string ("Creation instruction: ")
			create a
			io.put_string ("done.")
			io.put_new_line
			io.put_string ("Assignment instruction: ")
			a := a
			io.put_string ("done.")
			io.put_new_line
		end

end