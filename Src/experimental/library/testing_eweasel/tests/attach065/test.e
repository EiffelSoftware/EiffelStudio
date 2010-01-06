class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			a := "abc"
			if attached o.o.a as l and then l = a then
				io.put_string ("Test: OK")
			else
				io.put_string ("Test: FAILED")
			end
			io.put_new_line
		end

feature {TEST} -- Test

	a: ANY

	o: TEST
		once
			Result := Current
		end

end
