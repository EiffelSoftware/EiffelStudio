class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			t: TEST1
		do
			create {TEST1} t.make
			create {TEST2} t.make
		end

end
