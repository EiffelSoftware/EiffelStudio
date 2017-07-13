class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
				-- Change initial values.
			n := 3
			s.wipe_out
			s.append ("Hi")
			a.put (5)
			f
		end

feature {NONE} -- Test

	f
		local
			b: A
		do
			b.put (5)
				-- Change current values.
			n := 33
			s.wipe_out
			s.append ("Good bye")
			a.put (-5)
			report (3 = old n, 1)
			report (n /= old n = 3, 2)
			report (("Hi").same_string (old s.twin), 3)
			report (not s.same_string (old s.twin), 4)
			report (b ~ old a, 5)
			report (a ~ old a, 5)
		end

feature {NONE} -- Access

	n: INTEGER
			-- A basic value.

	s: STRING = "Hello"
			-- A reference value.

	a: A
			-- An expanded value.

feature {NONE} -- Output

	report (is_passed: BOOLEAN; number: NATURAL_8)
			-- Report whether a test `number` has passed according to `is_passed`.
		do
			io.put_string ("Test #")
			io.put_natural_8 (number)
			io.put_string (if is_passed then ": OK" else ": Failed" end)
			io.put_new_line
		end

end
