class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			x: ANY
		do
			x := Current [Current]
		end

end
