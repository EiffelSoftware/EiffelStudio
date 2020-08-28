class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			l_test: attached TEST
		do
			l_test := Current
		end

end