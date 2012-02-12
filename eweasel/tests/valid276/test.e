class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			(foo [1]).bar := Current
		end

end
