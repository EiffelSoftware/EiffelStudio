class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			a: TEST
		do
			item := a
		end

feature -- Access

	item: TEST

	value: TEST
		do
			item := Result
		end

end