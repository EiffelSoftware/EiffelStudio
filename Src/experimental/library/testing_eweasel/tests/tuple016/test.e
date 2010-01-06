class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: TUPLE [a: ANY]
		do
			t := [123]
			io.put_string (t.a.out)
			io.put_new_line
		end

end
