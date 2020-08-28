class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			io.put_string ("Test 1: ")
			if attached {attached TEST} Current as t and then attached {attached TEST} t.identity.identity as w then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
			io.put_string ("Test 2: ")
			if attached {attached STRING} Current as s and then attached {attached STRING} s.out.out as p then
				io.put_string ("FAILED")
			else
				io.put_string ("OK")
			end
			io.put_new_line
		end

feature {TEST} -- Test

	identity: TEST
		do
			Result := Current
		end

end