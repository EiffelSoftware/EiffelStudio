class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			a: TEST
		do
			a := Current
			item := a
		end

feature -- Access

	item: TEST

end