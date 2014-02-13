class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			i
			b
			t
			r
		do
			i := 5
			i.do_nothing        -- Qualified call to a procedure.
			b := i.is_equal (i) -- Qualified call to a function.
			i := -i             -- Unary expression.
			b := i < 7          -- Binary expression
			t := [i, b]
			t [1].do_nothing    -- Bracket expression.
			r := agent t.do_nothing
			r                   -- Parenthesis alias call.
		end

end
