note
	description: "Summary description for {TEST_INTEGER_X_IO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_IO

inherit
	EQA_TEST_SET
	INTEGER_X_IO
		undefine
			default_create
		end

feature
	test_export_1
		local
			one: INTEGER_X
			two: SPECIAL [NATURAL_8]
			junk: TUPLE [junk: INTEGER]
		do
			create junk
			create one.make_limbs (6)
			one.item [0] := 0x7393172a
			one.item [1] := 0xe93d7e11
			one.item [2] := 0x2e409f96
			one.item [3] := 0x6bc1bee2
			one.count := 4
			create two.make_filled (0, 16)
			output (two, 0, junk, 1, 1, -1, one)
			assert ("test output 1 1", two [0] = 0x6b and two [1] = 0xc1 and two [2] = 0xbe and two [3] = 0xe2)
			assert ("test output 1 2", two [4] = 0x2e and two [5] = 0x40 and two [6] = 0x9f and two [7] = 0x96)
			assert ("test output 1 3", two [8] = 0xe9 and two [9] = 0x3d and two [10] = 0x7e and two [11] = 0x11)
			assert ("test output 1 4", two [12] = 0x73 and two [13] = 0x93 and two [14] = 0x17 and two [15] = 0x2a)
		end

	test_import_1
		local
			one: INTEGER_X
			two: SPECIAL [NATURAL_8]
		do
			create two.make_filled (0, 16)
			two [0] := 0x6b two [1] := 0xc1 two [2] := 0xbe two [3] := 0xe2
			two [4] := 0x2e two [5] := 0x40 two [6] := 0x9f two [7] := 0x96
			two [8] := 0xe9 two [9] := 0x3d two [10] := 0x7e two [11] := 0x11
			two [12] := 0x73 two [13] := 0x93 two [14] := 0x17 two [15] := 0x2a
			create one
			input (one, 16, 1, 1, -1, two, 0)
			assert ("test input 1", one.item [0] = 0x7393172a and one.item [1] = 0xe93d7e11 and one.item [2] = 0x2e409f96 and one.item [3] = 0x6bc1bee2)
		end

	test_export_2
		local
			one: INTEGER_X
			two: SPECIAL [NATURAL_8]
			junk: TUPLE [junk: INTEGER]
		do
			create junk
			create one.make_limbs (6)
			one.item [0] := 0x0c0d0e0f
			one.item [1] := 0x08090a0b
			one.item [2] := 0x04050607
			one.item [3] := 0x00010203
			one.count := 4
			create two.make_filled (0, 16)
			output (two, 0, junk, 1, 1, -1, one)
			assert ("test export 1 1", two [0] = 0x01 and two [1] = 0x02 and two [2] = 0x03 and two [3] = 0x04)
			assert ("test export 1 2", two [4] = 0x05 and two [5] = 0x06 and two [6] = 0x07 and two [7] = 0x08)
			assert ("test export 1 3", two [8] = 0x09 and two [9] = 0x0a and two [10] = 0x0b and two [11] = 0x0c)
			assert ("test export 1 4", two [12] = 0x0d and two [13] = 0x0e and two [14] = 0x0f and two [15] = 0x00)
		end

	test_import_2
		local
			one: INTEGER_X
			two: SPECIAL [NATURAL_8]
		do
			create two.make_filled (0, 16)
			two [0] := 0x01 two [1] := 0x02 two [2] := 0x03 two [3] := 0x04
			two [4] := 0x05 two [5] := 0x06 two [6] := 0x07 two [7] := 0x08
			two [8] := 0x09 two [9] := 0x0a two [10] := 0x0b two [11] := 0x0c
			two [12] := 0x0d two [13] := 0x0e two [14] := 0x0f two [15] := 0x0
			create one
			input (one, 16, 1, 1, -1, two, 0)
			assert ("test import 2", one.item [0] = 0x0d0e0f00 and one.item [1] = 0x090a0b0c and one.item [2] = 0x05060708 and one.item [3] = 0x01020304)
		end
end
