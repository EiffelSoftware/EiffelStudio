class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			a: A
		do
			a := Current
		end

end