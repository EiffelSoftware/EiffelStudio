class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			c := <<1, 2, 3>>
			n := <<1, 2, 3>>
				-- Test that after both assignments the created array conforms to both `{ARRAY [COMPARABLE]}` and `ARRAY [NUMERIC]`.
			io.put_boolean (attached {like c} n)
			io.put_new_line
			io.put_boolean (attached {like n} c)
			io.put_new_line
		end

feature {NONE} -- Access

	c: ARRAY [COMPARABLE]
			-- An attribute to assign a manifest array to.

	n: ARRAY [NUMERIC]
			-- An attribute to assign a manifest array to.

end