class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a_s: ARRAY [detachable STRING]
			a_i: ARRAY [INTEGER_16]
		do
			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("4", 4)
			a_s.force ("5", 5)
			a_s.force ("6", 6)
			a_s.force ("7", 7)

			create a_s.make_empty
			a_s.force ("4", 4)
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("7", 7)
			a_s.force ("5", 5)
			a_s.force ("6", 6)

			create a_s.make_filled (Void, 1, 5)
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("4", 4)
			a_s.force ("5", 5)
			a_s.force ("6", 6)
			a_s.force ("7", 7)

			create a_s.make_filled (Void, 1, 5)
			a_s.force ("4", 4)
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("7", 7)
			a_s.force ("5", 5)
			a_s.force ("6", 6)

			create a_s.make_filled (Void, 3, 5)
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("4", 4)
			a_s.force ("5", 5)
			a_s.force ("6", 6)
			a_s.force ("7", 7)

			create a_s.make_filled (Void, 3, 5)
			a_s.force ("4", 4)
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("7", 7)
			a_s.force ("5", 5)
			a_s.force ("6", 6)

			create a_s.make_empty
			a_s.rebase (7)
			a_s.force ("7", 7)
			a_s.force ("6", 6)
			a_s.force ("5", 5)
			a_s.force ("4", 4)
			a_s.force ("3", 3)
			a_s.force ("2", 2)
			a_s.force ("1", 1)

			create a_i.make_empty
			a_i.force (1, 1)
			a_i.force (2, 2)
			a_i.force (3, 3)
			a_i.force (4, 4)
			a_i.force (5, 5)
			a_i.force (6, 6)
			a_i.force (7, 7)

			create a_i.make_empty
			a_i.force (4, 4)
			a_i.force (1, 1)
			a_i.force (2, 2)
			a_i.force (3, 3)
			a_i.force (7, 7)
			a_i.force (5, 5)
			a_i.force (6, 6)

			create a_i.make_filled (0, 1, 5)
			a_i.force (1, 1)
			a_i.force (2, 2)
			a_i.force (3, 3)
			a_i.force (4, 4)
			a_i.force (5, 5)
			a_i.force (6, 6)
			a_i.force (7, 7)

			create a_i.make_filled (0, 1, 5)
			a_i.force (4, 4)
			a_i.force (1, 1)
			a_i.force (2, 2)
			a_i.force (3, 3)
			a_i.force (7, 7)
			a_i.force (5, 5)
			a_i.force (6, 6)

			create a_i.make_filled (0, 3, 5)
			a_i.force (1, 1)
			a_i.force (2, 2)
			a_i.force (3, 3)
			a_i.force (4, 4)
			a_i.force (5, 5)
			a_i.force (6, 6)
			a_i.force (7, 7)

			create a_i.make_filled (0, 3, 5)
			a_i.force (4, 4)
			a_i.force (1, 1)
			a_i.force (2, 2)
			a_i.force (3, 3)
			a_i.force (7, 7)
			a_i.force (5, 5)
			a_i.force (6, 6)

			create a_i.make_empty
			a_i.rebase (7)
			a_i.force (7, 7)
			a_i.force (6, 6)
			a_i.force (5, 5)
			a_i.force (4, 4)
			a_i.force (3, 3)
			a_i.force (2, 2)
			a_i.force (1, 1)
		end

end
