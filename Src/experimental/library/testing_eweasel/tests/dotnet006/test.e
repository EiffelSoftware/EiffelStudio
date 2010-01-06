class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			pi: STRING
		do
			pi := (feature {MATH}.pi * 1000000000000000).truncated_to_integer_64.out
			if pi.is_equal ("3141592653589793") then
				io.put_string ("Test 1: OK")
			else
				io.put_string ("Test 1: Failed: %"" + pi + "%"")
			end
			io.put_new_line
		end

end