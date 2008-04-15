class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			a:= "Test OK"
				-- Cause class invariant to be checked.
			Current.f
				-- Report test result.
			io.put_string (a.out)
			io.put_new_line
		end

feature {TEST} -- Test

	a: ANY

	f
		do
		end

invariant
	is_string: {s: !STRING} a and then s.is_equal ("Test OK")

end
