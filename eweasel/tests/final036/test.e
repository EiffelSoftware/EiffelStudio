class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			create {TEST2} a
			a.f
		end

	a: TEST1

end
