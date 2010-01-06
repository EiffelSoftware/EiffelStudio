class TEST

inherit
	PARENT

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			item := Current
			is_valid := True
			test
		end

feature {NONE} -- Implementation

	item: PARENT

	test is
		do
		end

end 