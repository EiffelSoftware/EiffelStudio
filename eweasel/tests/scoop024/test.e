class TEST

create
       make,
       make_test

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: separate TEST
		do
				-- It's an error to get a value from the root processor.
			x.put ("Fail")
			create t.make_test
			test (t)
		end

	make_test
			-- Initialize non-root object.
		do
				-- Calls to the new processor are OK.
			x.put ("OK")
		end

feature -- Test

	test (t: separate TEST)
		do
				-- Calls to `f' and `g' should go to the new processor.
			t.f.g (2)
		end

	f: TEST
			-- Report test result and return an object of the current processor.
		do
			g (1)
			Result := Current
		end

	g (i: INTEGER)
			-- Output a value of `x' for test number `i'.
		do
			io.put_string ("TEST ")
			io.put_integer (i)
			io.put_string (": ")
			io.put_string (x.item)
			io.put_character ('.')
			io.put_new_line
		end

	x: CELL [STRING]
			-- A value associated woth the current processor.
		once ("THREAD")
			create Result.put ("Unknown")
		end

end
