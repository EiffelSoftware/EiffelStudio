class TEST_MT_ROOT

create

	make

feature {NONE} -- Creation

	make is
			-- Run "TEST_MT.make": workaround for VSRT3.
		local
			test: TEST_MT
		do
			create test.make
		end

end