class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a_s: ARRAY [STRING]
		do
			create a_s.make (1, 0)
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("4", 4)
			a_s.force ("5", 5)
			a_s.force ("6", 6)
			a_s.force ("7", 7)

			create a_s.make (7, 6)
			a_s.force ("7", 7)
			a_s.force ("6", 6)
			a_s.force ("5", 5)
			a_s.force ("4", 4)
			a_s.force ("3", 3)
			a_s.force ("2", 2)
			a_s.force ("1", 1)
		end

end
