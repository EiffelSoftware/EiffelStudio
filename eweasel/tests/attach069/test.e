class
	TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: SPECIAL [INTEGER]
			int: INTERNAL
		do
			create a.make_filled (0, 10)
			create sa.make_filled (0, 10)

			create int
			if int.dynamic_type (a) /= int.dynamic_type (sa) then
				io.put_string ("Failure%N")
			end
		end

	sa: SPECIAL [INTEGER]

end
