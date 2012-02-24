class TEST

create
	default_create,
	make,
	make_test

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: separate TEST
		do
				-- It's OK to get an expanded value from the root processor.
			x.put ("OK")
			create t.make_test
			test (t)
		end

	make_test
			-- Initialize non-root object.
		do
				-- Calls to expanded object via the new processor are bad.
			x.put ("Fail")
		end

feature -- Test

	test (t: separate TEST)
			-- Execute call chains on `t'.
		do
				-- All to `report' are performed on an expanded object
				-- and should go to the root processor.
			t.f.report (1)
			t.g.report (2)
			p (t.f).report (3)
			q (t.f).report (4)
			q (t.g).report (5)
			t.p (t.f).report (6)
			t.q (t.f).report (7)
			t.q (t.g).report (8)
		end

	f: expanded TEST
			-- An object of the current processor.
		do
		end

	g: TEST
			-- An object of the current processor.
		do
			Result := f
		end

	p (a: TEST): like a
			-- A value of `a'.
		do
			Result := a
		end

	q (a: separate TEST): like a
			-- A value of `a'.
		do
			Result := a
		end

	report (i: INTEGER)
			-- Output a value of `x' for test number `i'.
		do
			io.put_string ("Test ")
			io.put_integer (i)
			io.put_string (": ")
			io.put_string (x.item)
			io.put_character ('.')
			io.put_new_line
		end

	x: CELL [STRING]
			-- A value associated with the current processor.
		once
			create Result.put ("Unknown")
		end

end
