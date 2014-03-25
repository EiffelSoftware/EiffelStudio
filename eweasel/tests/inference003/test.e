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
			i.do_nothing            -- Qualified call to a procedure.
			b := i.is_equal (i)     -- Qualified call to a function.
			i := i.twin             -- Qualified call to a function (with assignment to the same variable).
			i := - i                -- Unary expression (with assignment to the same variable).
			i := i + i              -- Binary expression (with assignment to the same variable).
			b := i < 7              -- Binary expression.
			t := [i, b, a]
			a := t [1]              -- Bracket expression.
			t := [i, b, t [3]]      -- Bracket expression (with assignment to the same variable).
			r := agent t.do_nothing -- Agent expression.
			r (i, b)                -- Parenthesis alias call.
		end

end
