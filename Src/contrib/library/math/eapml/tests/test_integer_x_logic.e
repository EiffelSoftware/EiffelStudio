note
	description: "Summary description for {TEST_INTEGER_X_LOGIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_LOGIC

inherit
	EQA_TEST_SET
	INTEGER_X_LOGIC
		undefine
			default_create
		end

feature

	test_xor_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("7253bba0 7253bba0 7253bba0 7253bba0 7253bba0")
			create three.make_from_hex_string ("5fc2780a 6f778235 9540faf2 7bc9cdab cb929ddd")
			create expected.make_from_hex_string ("2d91c3aa 1d243995 e7134152 099a760b b9c1267d")
			bit_xor (one, two, three)
			assert ("test xor 1", one ~ expected)
		end

	test_xor_lshift_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("7253bba0 7253bba0 7253bba0 7253bba0 7253bba0")
			create three.make_from_hex_string ("5fc2780a 6f778235 9540faf2 7bc9cdab cb929ddd")
			create expected.make_from_hex_string ("5fc2 780a6f77 f0662ee0 88a1c069 bff87032 ef8ebba0 7253bba0")
			bit_xor_lshift (one, two, three, 48)
			assert ("test xor lshift 1", one ~ expected)
		end

	test_walking_xor_1
		local
			i: INTEGER
			ones: INTEGER_X
			zero: INTEGER_X
			cursor: INTEGER_X
			xored: INTEGER_X
			j: INTEGER
		do
			create zero
			create ones.make_from_hex_string ("ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff")
			from
				i := 0
			until
				i >= 256
			loop
				cursor := zero.bit_complement_value (i)
				xored := cursor.bit_xor_value (ones)
				from
					j := 0
				until
					j >= 256
				loop
					assert ("test walking xor 1 iteration: " + i.out, (j /= i) = xored.bit_test (j))
					j := j + 1
				end
				i := i + 1
			end
		end

	test_walking_set_bit_1
		local
			i: INTEGER
			j: INTEGER
			zero: INTEGER_X
			cursor: INTEGER_X
		do
			create zero.default_create
			from
				i := 0
			until
				i >= 256
			loop
				cursor := zero.set_bit_value (true, i)
				from
					j := 0
				until
					j >= 256
				loop
					assert ("test walking set bit 1 iteration: " + i.out, (j = i) = cursor.bit_test (j))
					j := j + 1
				end
				i := i + 1
			end
		end

	test_bit_clear_1
		local
			one: INTEGER_X
			expected: INTEGER_X
		do
			create one.make_from_hex_string ("c 7ea29e73 e8b0ed09 f2d91bac ab1cd267 343dfdb2")
			create expected.make_from_hex_string ("4 7ea29e73 e8b0ed09 f2d91bac ab1cd267 343dfdb2")
			bit_clear (one, 0xa3)
			assert ("test bit clear 1", one ~ expected)
		end

	test_bit_clear_2
		local
			one: INTEGER_X
			expected: INTEGER_X
		do
			create one.make_from_hex_string ("ece1f5243f82d99431001da4573c")
			one.set_bit (False, 226)
			create expected.make_from_hex_string ("ece1f5243f82d99431001da4573c")
			assert ("test bit clear 2", one ~ expected)
		end
end
