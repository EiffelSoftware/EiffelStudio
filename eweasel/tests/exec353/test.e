class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			a, a0, a1: A
			b, b0, b1: B
			c0, c1: C
			x, y: detachable ANY
		do
				-- Initialize variables.
			create a.make_0
			create a0.make_0
			create a1.make_1
			create b1.make_1
			create c1.make_1
				-- Compare detached expressions.
			report ("void = void", void = void)
			report ("x (void) = y (void)", x = y)
				-- Compare attached with detached.
			report ("a /= void", a /= void)
			report ("void /= a", void /= a)
			report ("b /= void", b /= void)
			report ("void /= b", void /= b)
			y := b
			report ("x (void) /= y (b)", x /= y)
			report ("y (b) /= x (void)", y /= x)
				-- Compare objects with copy and reference semantics.
			report ("a /= b", a /= b)
			report ("b /= a", b /= a)
			x := a
			report ("x (a) /= y (b)", x /= y)
			report ("y (b) /= x (a)", y /= x)
				-- Compare references.
			report ("a = a", a = a)
			report ("a /= a0", a /= a0)
			report ("a /= a1", a /= a1)
				-- Compare objects with copy semantics: same type.
			report ("b = b", b = b)
			report ("b = b0", b = b0)
			report ("b /= b1", b /= b1)
			x := b
			y := b
			report ("x (b) = y (b)", x = y)
			y := b0
			report ("x (b) = y (b0)", x = y)
			y := b1
			report ("x (b) /= y (b1)", x /= y)
				-- Compare objects with copy semantics: different type.
			report ("b0 = c0", b0 = c0)
			report ("b0 /= c1", b0 /= c1)
			report ("c0 /= b0", c0 /= b0)
			report ("c1 /= b0", c1 /= b0)
			x := b0
			y := c0
			report ("x (b0) = y (c0)", x = y)
			y := c1
			report ("x (b0) /= y (c1)", x /= y)
			y := c0
			report ("y (c0) /= x (b0)", y /= x)
			y := c1
			report ("y (c1) /= x (b0)", y /= x)
		end

feature {NONE} -- Output

	report (name: STRING; value: BOOLEAN)
			-- Report that the test `name' completes with `value'.
		do
			io.put_string (name)
			if value then
				io.put_string (": passed.")
			else
				io.put_string (": FAILED.")
			end
			io.put_new_line
		end

end
