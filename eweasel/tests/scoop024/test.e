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
			-- Execute call chains on `t'.
		do
				-- Calls to `g' should go to the processor of `t'.
			t.g (1)
			t.f.g (2)
			(+ t).g (3)
			(t + 0).g (4)
			(t [0]).g (5)
			t.h := 6
			t.f.h := 7
			(+ t).h := 8
			(t + 0).h := 9
			(t [0]).h := 10
		end

	f: TEST
			-- An object of the current processor.
		do
			Result := Current
		end

	unary_plus alias "+": TEST
			-- An object of the current processor.
		do
			Result := Current
		end

	binary_plus alias "+" (i: INTEGER): TEST
			-- An object of the current processor.
		do
			Result := Current
		end

	bracket alias "[]" (i: INTEGER): TEST
			-- An object of the current processor.
		do
			Result := Current
		end

	g (i: INTEGER)
			-- Output a value of `x' for test number `i'.
		do
			io.put_string ("Test ")
			io.put_integer (i)
			io.put_string (": ")
			io.put_string (x.item)
			io.put_character ('.')
			io.put_new_line
		end

	h: INTEGER assign g
			-- A feature that has assigner `g'.
		do
		end

	x: CELL [STRING]
			-- A value associated with the current processor.
		once
			create Result.put ("Unknown")
		end

end
