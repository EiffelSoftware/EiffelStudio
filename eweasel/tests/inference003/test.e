class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			a
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
			a := t [1]          -- Bracket expression.
			r := agent t.do_nothing
			r (i, b)            -- Parenthesis alias call.
		end

end
