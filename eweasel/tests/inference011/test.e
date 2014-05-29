class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			i; r1; r2; r3; r4; p1; p2; p3; p4; f1; f2; f3; f4
		do
				-- Inline agents.
			r1 := agent (x, y: INTEGER) do report (y, True) end (i, ?)
			p1 := agent (x, y: INTEGER): BOOLEAN do Result := x = y end (i, ?)
			f1 := agent (x, y: INTEGER): INTEGER do Result := x + y end (i, ?)
			r1 (1)
			report (2, p1 (5))
			report (3, f1 (5) = 10)
				-- Routine-based unqualified agents.
			r2 := agent r (i, ?)
			p2 := agent p (i, ?)
			f2 := agent f (i, ?)
			r2 (10)
			report (11, p2 (5))
			report (12, f2 (5) = 10)
				-- Routine-based qualified agents.
			r3 := agent Current.r (i, ?)
			p3 := agent Current.p (i, ?)
			f3 := agent Current.f (i, ?)
			r3 (20)
			report (21, p3 (5))
			report (22, f3 (5) = 10)
				-- Routine-based qualified agents on open target.
			r4 := agent {TEST}.r (i, ?)
			p4 := agent {TEST}.p (i, ?)
			f4 := agent {TEST}.f (i, ?)
			r4 (Current, 30)
			report (31, p4 (Current, 5))
			report (32, f4 (Current, 5) = 10)
				-- Variable to be inferred and used in agent expressions.
			i := 5
		end

feature {NONE} -- Helper

	r (x, y: INTEGER) do report (y, True) end
	p (x, y: INTEGER): BOOLEAN do Result := x = y end
	f (x, y: INTEGER): INTEGER do Result := x + y end


feature {NONE} -- Output

	report (test: INTEGER; value: BOOLEAN)
			-- Output `value' for test `test' on a new line.
		do
			io.put_string ("Test #")
			io.put_integer (test)
			if value then
				io.put_string (": OK.")
			else
				io.put_string (": Failed.")
			end
			io.put_new_line
		end

end
