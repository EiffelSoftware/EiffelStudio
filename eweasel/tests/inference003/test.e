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
			i.do_nothing       -- Qualified call.
			b := -i            -- Unary expression.
			b := i < 7         -- Binary expression
			t := [i, b]
			t [1].do_nothing   -- Bracket expression.
			r := agent t.copy
			r ()               -- Parenthesis alias call.
		end

end
