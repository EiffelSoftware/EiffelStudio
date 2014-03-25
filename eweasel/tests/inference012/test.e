class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t
			r
		do
			t := [3]
			r := agent t.do_nothing -- Agent expression.
			r := agent r.do_nothing -- Agent expression (with assignment to the same variable).
			r := agent r.item (r)   -- Agent expression (with assignment to the same variable).
		end

end
