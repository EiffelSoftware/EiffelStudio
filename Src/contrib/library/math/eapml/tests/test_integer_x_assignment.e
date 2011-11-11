note
	description: "Summary description for {TEST_INTEGER_X_ASSIGNMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_ASSIGNMENT

inherit
	EQA_TEST_SET
	INTEGER_X_ASSIGNMENT
		undefine
			default_create
		end

feature
	test_set_str_1
		local
			target: INTEGER_X
		do
			create target
			set_str (target, "100", 10)
			assert ("test set str 1 1", target.item [0] = 100 and target.count = 1)

			set_str (target, "10000000000", 10)
			assert ("test set str 1 2", target.item [0] = 0x540be400 and target.item [1] = 0x00000002 and target.count = 2)
		end

	test_set_str_2
		local
			target: INTEGER_X
		do
			create target
			set_str (target, "1000", 16)
			assert ("test set str 1 1", target.item [0] = 0x1000 and target.count = 1)

			set_str (target, "100000000000", 16)
			assert ("test set str 1 2", target.item [0] = 0x00000000 and target.item [1] = 0x00001000 and target.count = 2)
		end

	test_set_str_3
		local
			target: INTEGER_X
		do
			create target
			set_str (target, "    1         			0    	 			0     0      				", 16)
			assert ("test set str 3 1", target.item [0] = 0x1000 and target.count = 1)
			set_str (target, " 	1 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	", 16)
			assert ("test set str 3 2", target.item [0] = 0x00000000 and target.item [1] = 0x00001000 and target.count = 2)
		end

	test_set_str_4
		local
			target: INTEGER_X
		do
			create target
			set_str (target, " 	0x 	1 	0 	0 	0 	", 0)
			assert ("test set str 3 1", target.item [0] = 0x1000 and target.count = 1)
			set_str (target, " 0", 0)
			assert ("test set str 3 2", target.count = 0)
		end

	test_set_str_5
		local
			one: INTEGER_X
		do
			create one.make_from_string_base ("5050422450443414252030234161450453214063666050554216601312032162510626626621233550541413260", 7)
			assert ("test set str 5", one.item [7] = 0x8134b7f7 and one.item [6] = 0x8d570cbf and one.item [5] = 0xeb5f7c66 and one.item [4] = 0x7aa64334 and one.item [3] = 0xbb6cd783 and one.item [2] = 0x22792988 and one.item [1] = 0x6ec0f7ac and one.item [0] = 0x4438ad87 and one.count = 8)
		end

	test_set_str_6
		local
			one: INTEGER_X
		do
			create one.make_from_string_base ("2460223246331335544520513341363224654146046636101125253015521231163466226621435340120452343", 7)
			assert ("test set str 6", one.item [0] = 0x8134b7f7 and one.item [1] = 0x8d570cbf and one.item [2] = 0xeb5f7c66 and one.item [3] = 0x7aa64334 and one.item [4] = 0xbb6cd783 and one.item [5] = 0x22792988 and one.item [6] = 0x6ec0f7ac and one.item [7] = 0x4438ad87 and one.count = 8)
		end

	test_set_str_7
		local
			one: INTEGER_X
		do
			create one.make_from_hex_string ("1")
			assert ("test set str 7", one.item [0] = 0x1 and one.count = 1)
		end

	test_set_1
		local
			one: INTEGER_X
			two: INTEGER_X
		do
			create one.make_from_hex_string ("f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff")
			assert ("test set 1 1", one.item [0] = 0xfcfdfeff and one.item [1] = 0xf8f9fafb and one.item [2] = 0xf4f5f6f7 and one.item [3] = 0xf0f1f2f3 and one.count = 4)
			create two
			two.copy (one)
			assert ("test set 1 2", one ~ two)
			assert ("test set 1 3", one.item [0] = 0xfcfdfeff and one.item [1] = 0xf8f9fafb and one.item [2] = 0xf4f5f6f7 and one.item [3] = 0xf0f1f2f3 and one.count = 4)
			assert ("test set 1 4", two.item [0] = 0xfcfdfeff and two.item [1] = 0xf8f9fafb and two.item [2] = 0xf4f5f6f7 and two.item [3] = 0xf0f1f2f3 and two.count = 4)
		end

	test_set_from_integer_64_1
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_integer_64 (int.min_value)
			assert ("test set from integer 64 1 1", one.fits_integer_64)
			assert ("test set from integer 64 1 2", one.to_integer_64 = int.min_value)
		end

	test_set_from_integer_64_2
		local
			one: INTEGER_X
		do
			create one.make_from_integer_64 (-1)
			assert ("test set from integer 64 2 1", one.fits_integer_64)
			assert ("test set from integer 64 2 2", one.to_integer_64 = -1)
		end

	test_set_from_integer_64_3
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_integer_64 (int.max_value)
			assert ("test set from integer 64 3 1", one.fits_integer_64)
			assert ("test set from integer 64 3 2", one.to_integer_64 = int.max_value)
		end

	test_set_from_integer_32_1
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_integer_32 (int.min_value)
			assert ("test set from integer 32 1 1", one.fits_integer_32)
			assert ("test set from integer 32 1 2", one.to_integer_32 = int.min_value)
		end

	test_set_from_integer_32_2
		local
			one: INTEGER_X
		do
			create one.make_from_integer_32 (-1)
			assert ("test set from integer 32 2 1", one.fits_integer_32)
			assert ("test set from integer 32 2 2", one.to_integer_32 = -1)
		end

	test_set_from_integer_32_3
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_integer_32 (int.max_value)
			assert ("test set from integer 32 3 1", one.fits_integer_32)
			assert ("test set from integer 32 3 2", one.to_integer_32 = int.max_value)
		end

	test_set_from_integer_16_1
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_integer_16 (int.min_value)
			assert ("test set from integer 16 1 1", one.fits_integer_16)
			assert ("test set from integer 16 1 2", one.to_integer_16 = int.min_value)
		end

	test_set_from_integer_16_2
		local
			one: INTEGER_X
		do
			create one.make_from_integer_16 (-1)
			assert ("test set from integer 16 2 1", one.fits_integer_16)
			assert ("test set from integer 16 2 2", one.to_integer_16 = -1)
		end

	test_set_from_integer_16_3
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_integer_16 (int.max_value)
			assert ("test set from integer 16 3 1", one.fits_integer_16)
			assert ("test set from integer 16 3 2", one.to_integer_16 = int.max_value)
		end

	test_set_from_integer_8_1
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_integer_8 (int.min_value)
			assert ("test set from integer 8 1 1", one.fits_integer_8)
			assert ("test set from integer 8 1 2", one.to_integer_8 = int.min_value)
		end

	test_set_from_integer_8_2
		local
			one: INTEGER_X
		do
			create one.make_from_integer_8 (-1)
			assert ("test set from integer 8 2 1", one.fits_integer_8)
			assert ("test set from integer 8 2 2", one.to_integer_8 = -1)
		end

	test_set_from_integer_8_3
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_integer_8 (int.max_value)
			assert ("test set from integer 8 3 1", one.fits_integer_8)
			assert ("test set from integer 8 3 2", one.to_integer_8 = int.max_value)
		end
end
