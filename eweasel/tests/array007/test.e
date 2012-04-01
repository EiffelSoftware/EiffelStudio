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
			a_s.force ("Crash", 0)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if a_s.item (0) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -1)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if a_s.item (0) /= Void then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-1) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -2)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if a_s.item (0) /= Void or a_s.item (-1) /= Void then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-2) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -3)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if a_s.item (0) /= Void or a_s.item (-1) /= Void or a_s.item (-2) /= Void then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-3) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -4)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if
				a_s.item (0) /= Void or a_s.item (-1) /= Void or a_s.item (-2) /= Void or
				a_s.item (-3) /= Void
			then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-4) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -5)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if
				a_s.item (0) /= Void or a_s.item (-1) /= Void or a_s.item (-2) /= Void or
				a_s.item (-3) /= Void or a_s.item (-4) /= Void
			then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-5) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -6)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if
				a_s.item (0) /= Void or a_s.item (-1) /= Void or a_s.item (-2) /= Void or 
				a_s.item (-3) /= Void or a_s.item (-4) /= Void or a_s.item (-5) /= Void
			then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-6) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -7)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if
				a_s.item (0) /= Void or a_s.item (-1) /= Void or a_s.item (-2) /= Void or 
				a_s.item (-3) /= Void or a_s.item (-4) /= Void or a_s.item (-5) /= Void or
				a_s.item (-6) /= Void
			then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-7) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

			create a_s.make_empty
			a_s.force ("1", 1)
			a_s.force ("2", 2)
			a_s.force ("3", 3)
			a_s.force ("Crash", -8)
			if a_s.item (1) /~ "1" or a_s.item (2) /~ "2" or a_s.item (3) /~ "3" then
				io.put_string ("Not OK%N")
			end
			if
				a_s.item (0) /= Void or a_s.item (-1) /= Void or a_s.item (-2) /= Void or 
				a_s.item (-3) /= Void or a_s.item (-4) /= Void or a_s.item (-5) /= Void or
				a_s.item (-6) /= Void or a_s.item (-7) /= Void
			then
				io.put_string ("Not reset%N")
			end
			if a_s.item (-8) /~ "Crash" then
				io.put_string ("Not Ok%N")
			end

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
