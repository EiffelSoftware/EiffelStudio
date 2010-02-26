class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t1: TEST1
			te: TEST_EPHEMERAL
			t2: TEST2
		do
			create t1
			create te
			create t2

			t1.f
			te.f
			te.k
			t2.f
			t2.k

			{TEST_EPHEMERAL}.f
			{TEST_EPHEMERAL}.k
		end

end
