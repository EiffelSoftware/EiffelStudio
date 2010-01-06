class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: AS_SCALAR [REAL_64]
		do
			a.do_nothing
		end

end
