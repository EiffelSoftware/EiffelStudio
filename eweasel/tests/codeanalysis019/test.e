class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Make sure features are called.
		do
			b
		end

feature {NONE} -- Test

	a: INTEGER
			-- Check that there are no leftovers from the checks for `b'.
			-- There is no control flow graph here, so it should be ignored.

	b
		local
			x: INTEGER
		do
				-- Set a variable but do not use it.
				-- Cause a violation of a rule that processes a control flow graph.
			x := a + c
		end           

	c: INTEGER
			-- Check that there are no leftovers from the checks for `b'.
			-- There is no control flow graph here, so it should be ignored.

end
