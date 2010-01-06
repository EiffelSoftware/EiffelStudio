class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a_i: A [INTEGER_8]
			a_s: A [STRING]
		do
			create a_i
			create a_s
		end

end
