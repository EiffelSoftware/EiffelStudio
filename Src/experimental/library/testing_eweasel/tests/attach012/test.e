class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			io.put_string ("Test 1: ")
			if {t: !TEST} Current and then {w: !TEST} t.identity.identity then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
			io.put_string ("Test 2: ")
			if {s: !STRING} Current and then {p: !STRING} s.out.out then
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