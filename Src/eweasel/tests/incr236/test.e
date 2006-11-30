class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			l: TEST1 $GENERIC
		do
			l.do_nothing
		end

end
