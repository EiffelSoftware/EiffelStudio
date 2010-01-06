class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			l_test2: COMPUSTAT_FUNDAMENTAL_COMPOSITE_DATA_SOURCE
		do
			create l_test2.make
		end

end
