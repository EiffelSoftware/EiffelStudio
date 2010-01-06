class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			io.put_string ("Test OK.")
			io.put_new_line
		end

end
