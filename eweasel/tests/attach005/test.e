class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			l_test: !TEST
		do
			l_test := Current
		end

end