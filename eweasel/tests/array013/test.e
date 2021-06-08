class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			i: like {ARRAY [INTEGER]}.lower
		do
				-- Tests at lower 1 with a non-empty array.
			test (3, 1, 8, -1, <<8, 8, 1, 2, 3>>, 1)
			test (3, 1, 8, 0, <<8, 1, 2, 3>>, 2)
			test (3, 1, 8, 1, <<8, 2, 3>>, 3)
			test (3, 1, 8, 2, <<1, 8, 3>>, 4)
			test (3, 1, 8, 3, <<1, 2, 8>>, 5)
			test (3, 1, 8, 4, <<1, 2, 3, 8>>, 6)
			test (3, 1, 8, 5, <<1, 2, 3, 8, 8>>, 7)
				-- Tests at minimum lower with a non-empty array.
			i := i.min_value
			test (3, i + 2, 8, i + 0, <<8, 8, 1, 2, 3>>, 8)
			test (3, i + 2, 8, i + 1, <<8, 1, 2, 3>>, 9)
			test (3, i + 2, 8, i + 2, <<8, 2, 3>>, 10)
			test (3, i + 2, 8, i + 3, <<1, 8, 3>>, 11)
			test (3, i + 2, 8, i + 4, <<1, 2, 8>>, 12)
			test (3, i + 2, 8, i + 5, <<1, 2, 3, 8>>, 13)
			test (3, i + 2, 8, i + 6, <<1, 2, 3, 8, 8>>, 14)
				-- Tests at maximum upper with a non-empty array.
			i := i.max_value
			test (3, i - 4, 8, i - 6, <<8, 8, 1, 2, 3>>, 15)
			test (3, i - 4, 8, i - 5, <<8, 1, 2, 3>>, 16)
			test (3, i - 4, 8, i - 4, <<8, 2, 3>>, 17)
			test (3, i - 4, 8, i - 3, <<1, 8, 3>>, 18)
			test (3, i - 4, 8, i - 2, <<1, 2, 8>>, 19)
			test (3, i - 4, 8, i - 1, <<1, 2, 3, 8>>, 20)
			test (3, i - 4, 8, i - 0, <<1, 2, 3, 8, 8>>, 21)
				-- Tests at lower 1 with an empty array.
			test (0, 1, 8, -1, <<8, 8>>, 22)
			test (0, 1, 8, 0, <<8>>, 23)
			test (0, 1, 8, 1, <<8>>, 24)
			test (0, 1, 8, 2, <<8, 8>>, 25)
				-- Tests at minimum lower with an empty array.
			i := i.min_value
			test (0, i + 2, 8, i + 0, <<8, 8>>, 26)
			test (0, i + 2, 8, i + 1, <<8>>, 27)
			test (0, i + 2, 8, i + 2, <<8>>, 28)
			test (0, i + 2, 8, i + 3, <<8, 8>>, 29)
				-- Tests at maximum upper with an empty array.
			i := i.max_value
			test (0, i - 1, 8, i - 3, <<8, 8>>, 30)
			test (0, i - 1, 8, i - 2, <<8>>, 31)
			test (0, i - 1, 8, i - 1, <<8>>, 32)
			test (0, i - 1, 8, i - 0, <<8, 8>>, 33)
		end

feature {NONE} -- Output

	test
			(count: like {ARRAY [INTEGER]}.count
			lower: like {ARRAY [INTEGER]}.lower
			value: INTEGER
			index: like {ARRAY [INTEGER]}.lower
			expected: ARRAY [INTEGER]
			number: NATURAL)
		local
			a: ARRAY [INTEGER]
		do
				-- Report a test number.
			io.put_string ("Test #" + number.out + ": ")
				-- Allocate a new array filled with zeroes.
			create a.make_filled (0, lower, lower + count - 1)
				-- Fill the array with items `1`, `2`, ..., `count`.
			across
				a is c
			loop
				a [@c.target_index] := @c.cursor_index
			end
				-- Insert a new item.
			a.force_and_fill (value, index)
				-- Compare an actual result with the expected one.
			io.put_string
				(if not a.same_items (expected) then
					"FAILED - unexpected items%N"
				elseif a.lower /= lower.min (index) then
					"FAILED - unexpected lower%N"
				else
					"OK%N"
				end)
		end

end
