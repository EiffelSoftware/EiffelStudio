note
	description: "Summary description for {TEST_INTEGER_X_ACCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_ACCESS

inherit
	EQA_TEST_SET
	INTEGER_X_ACCESS
		undefine
			default_create
		end

feature
	test_get_integer_64_1
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.max_value.out)
			assert ("test get integer 64 1 1", one.fits_integer_64)
			assert ("test get integer 64 1 2", one.as_integer_64 = int.max_value)
		end

	test_get_integer_64_2
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.min_value.out)
			assert ("test get integer 64 2 1", one.fits_integer_64)
			assert ("test get integer 64 2 2", one.as_integer_64 = int.min_value)
		end

	test_get_integer_64_3
		local
			one: INTEGER_X
		do
			create one.make_from_string ("0")
			assert ("test get integer 64 3 1", one.fits_integer_64)
			assert ("test get integer 64 3 2", one.as_integer_64 = 0)
		end

	test_get_integer_64_4
		local
			one: INTEGER_X
		do
			create one.make_from_string ("-1")
			assert ("test get integer 64 4 1", one.fits_integer_64)
			assert ("test get integer 64 4 2", one.as_integer_64 = -1)
		end

	test_get_integer_64_5
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test get integer 64 5 1", not one.fits_integer_64)
			assert ("test get integer 64 5 2", one.as_integer_64 = 0)
		end

	test_get_integer_64_6
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test get integer 64 6 1", not one.fits_integer_64)
			assert ("test get integer 64 6 2", one.as_integer_64 = -1)
		end

	test_get_integer_32_1
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.max_value.out)
			assert ("test get integer 32 1 1", one.fits_integer_32)
			assert ("test get integer 32 1 2", one.as_integer_32 = int.max_value)
		end

	test_get_integer_32_2
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.min_value.out)
			assert ("test get integer 32 2 1", one.fits_integer_32)
			assert ("test get integer 32 2 2", one.as_integer_32 = int.min_value)
		end

	test_get_integer_32_3
		local
			one: INTEGER_X
		do
			create one.make_from_string ("0")
			assert ("test get integer 32 3 1", one.fits_integer_32)
			assert ("test get integer 32 3 2", one.as_integer_32 = 0)
		end

	test_get_integer_32_4
		local
			one: INTEGER_X
		do
			create one.make_from_string ("-1")
			assert ("test get integer 32 4 1", one.fits_integer_32)
			assert ("test get integer 32 4 2", one.as_integer_32 = -1)
		end

	test_get_integer_32_5
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test get integer 32 5 1", not one.fits_integer_32)
			assert ("test get integer 32 5 2", one.as_integer_32 = 0)
		end

	test_get_integer_32_6
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test get integer 32 6 1", not one.fits_integer_32)
			assert ("test get integer 32 6 2", one.as_integer_32 = -1)
		end

	test_get_integer_16_1
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.max_value.out)
			assert ("test get integer 16 1 1", one.fits_integer_16)
			assert ("test get integer 16 1 2", one.as_integer_16 = int.max_value)
		end

	test_get_integer_16_2
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.min_value.out)
			assert ("test get integer 16 2 1", one.fits_integer_16)
			assert ("test get integer 16 2 2", one.as_integer_16 = int.min_value)
		end

	test_get_integer_16_3
		local
			one: INTEGER_X
		do
			create one.make_from_string ("0")
			assert ("test get integer 16 3 1", one.fits_integer_16)
			assert ("test get integer 16 3 2", one.as_integer_16 = 0)
		end

	test_get_integer_16_4
		local
			one: INTEGER_X
		do
			create one.make_from_string ("-1")
			assert ("test get integer 16 4 1", one.fits_integer_16)
			assert ("test get integer 16 4 2", one.as_integer_16 = -1)
		end

	test_get_integer_16_5
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test get integer 16 5 1", not one.fits_integer_16)
			assert ("test get integer 16 5 2", one.as_integer_16 = 0)
		end

	test_get_integer_16_6
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test get integer 16 6 1", not one.fits_integer_16)
			assert ("test get integer 16 6 2", one.as_integer_16 = -1)
		end

	test_get_integer_8_1
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.max_value.out)
			assert ("test get integer 8 1 1", one.fits_integer_8)
			assert ("test get integer 8 1 2", one.as_integer_8 = int.max_value)
		end

	test_get_integer_8_2
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.min_value.out)
			assert ("test get integer 8 2 1", one.fits_integer_8)
			assert ("test get integer 8 2 2", one.as_integer_8 = int.min_value)
		end

	test_get_integer_8_3
		local
			one: INTEGER_X
		do
			create one.make_from_string ("0")
			assert ("test get integer 8 3 1", one.fits_integer_8)
			assert ("test get integer 8 3 2", one.as_integer_8 = 0)
		end

	test_get_integer_8_4
		local
			one: INTEGER_X
		do
			create one.make_from_string ("-1")
			assert ("test get integer 8 4 1", one.fits_integer_8)
			assert ("test get integer 8 4 2", one.as_integer_8 = -1)
		end

	test_get_integer_8_5
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test get integer 8 5 1", not one.fits_integer_8)
			assert ("test get integer 8 5 2", one.as_integer_8 = 0)
		end

	test_get_integer_8_6
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test get integer 8 6 1", not one.fits_integer_8)
			assert ("test get integer 8 6 2", one.as_integer_8 = -1)
		end

	test_get_str_1
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_limbs (4)
			one.item [0] := 0x87654321
			one.item [1] := 0xcccccccc
			one.item [2] := 0x33333333
			one.item [3] := 0xffffffff
			one.count := 4
			output := one.out_base (16)
			assert ("test get str 1", "ffffffff33333333cccccccc87654321" ~ output)
		end

	test_get_str_2
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_limbs (4)
			one.item [0] := 0x87654321
			one.item [1] := 0xcccccccc
			one.item [2] := 0x33333333
			one.item [3] := 0xffffffff
			one.count := 4
			output := one.out_base (10)
			assert ("test get str 2", "340282366857555933463031183799994368801" ~ output)
		end

	test_get_str_3
		local
			one: INTEGER_X
			two: INTEGER_X
			output: STRING
			i: INTEGER
			base: INTEGER
		do
			from
				i := 0
			until
				i > 1000
			loop
				base := i \\ 61 + 2
				create one.make_random (256)
				output := one.out_base (base)
				create two.make_from_string_base (output, base)
				assert ("test get str 3", one ~ two)
				i := i + 1
			end
		end

	test_get_str_4
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_limbs (8)
			one.item [0] := 0x99811941
			one.item [1] := 0x841FD605
			one.item [2] := 0xD960A1BF
			one.item [3] := 0x5E433EFC
			one.item [4] := 0x48C9BC93
			one.item [5] := 0x1C8B6FB1
			one.item [6] := 0x8CA06DE0
			one.item [7] := 0xC6182337
			one.count := 8
			output := one.out_base (10)
			assert ("test get str 4", output ~ "89600591407770348063754312463218194105764385355557091513583682190076098451777")
		end

	test_get_str_5
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_limbs (8)
			one.item [0] := 0x99811941
			one.item [1] := 0x841FD605
			one.item [2] := 0xD960A1BF
			one.item [3] := 0x5E433EFC
			one.item [4] := 0x48C9BC93
			one.item [5] := 0x1C8B6FB1
			one.item [6] := 0x8CA06DE0
			one.item [7] := 0xC6182337
			one.count := 8
			output := one.out_base (3)
			assert ("test get str 5", output ~ "110022012022022000201210111012211020111202020222100010210022020220110011011010201011020001011210101000122212110112010121211022120122101102102020102011202010010112")
		end

	test_get_str_6
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_limbs (8)
			one.item [7] := 0x8134b7f7
			one.item [6] := 0x8d570cbf
			one.item [5] := 0xeb5f7c66
			one.item [4] := 0x7aa64334
			one.item [3] := 0xbb6cd783
			one.item [2] := 0x22792988
			one.item [1] := 0x6ec0f7ac
			one.item [0] := 0x4438ad87
			one.count := 8
			output := one.out_base (7)
			assert ("test get str 6", output ~ "5050422450443414252030234161450453214063666050554216601312032162510626626621233550541413260")
		end

	test_get_str_7
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_limbs (8)
			one.item [0] := 0x8134b7f7
			one.item [1] := 0x8d570cbf
			one.item [2] := 0xeb5f7c66
			one.item [3] := 0x7aa64334
			one.item [4] := 0xbb6cd783
			one.item [5] := 0x22792988
			one.item [6] := 0x6ec0f7ac
			one.item [7] := 0x4438ad87
			one.count := 8
			output := one.out_base (7)
			assert ("test get str 7", output ~ "2460223246331335544520513341363224654146046636101125253015521231163466226621435340120452343")
		end

	test_get_str_8
		local
			one: INTEGER_X
			output: STRING
		do
			create one.make_from_integer (-1)
			output := one.out_hex
			assert ("test get str 7", output ~ "-1")
		end
end
