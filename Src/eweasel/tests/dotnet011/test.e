class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			t1: TEST1
			t2: TEST2
		do
			create t1
			create t2
			
			t1.test1
			t1.test2

			t2.test1
			t2.test2
		end

end
