class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			c: C
		do
			create c
			c.f (Current)
		end

end
