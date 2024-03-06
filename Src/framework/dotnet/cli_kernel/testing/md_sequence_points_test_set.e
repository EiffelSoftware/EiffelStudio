note
	description: "Summary description for {MD_SEQUENCE_POINTS_TEST_SET}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_SEQUENCE_POINTS_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_compress_unsigned_data
			-- New test routine
		note
			testing:  "covers/{MD_SEQUENCE_POINTS}"
		local
			mp: MD_SEQUENCE_POINTS
			checker: EQA_COMMONLY_USED_ASSERTIONS
		do
			create checker
			create mp.make

			mp.reset
			mp.put_unsigned_value(0x03)
			checker.assert_arrays_equal("Compress 0x03 -> 03", {ARRAY [NATURAL_8]}<<0x03>>, mp.as_array)

			mp.reset
			mp.put_unsigned_value(0x7F)
			checker.assert_arrays_equal("Compress 0x7F -> 7F", {ARRAY [NATURAL_8]}<<0x7F>>, mp.as_array)

			mp.reset
			mp.put_unsigned_value (0x80)
			checker.assert_arrays_equal("Compress 0x80 -> 8080", {ARRAY [NATURAL_8]}<<0x80, 0x80>>, mp.as_array)

			mp.reset
			mp.put_unsigned_value (0x2E57)
			checker.assert_arrays_equal("Compress 0x2E57 -> AE57", {ARRAY [NATURAL_8]}<<0xAE, 0x57>>, mp.as_array)


			mp.reset
			mp.put_unsigned_value (0x4000)
			checker.assert_arrays_equal("Compress 0x4000 -> C000 4000", {ARRAY [NATURAL_8]}<<0xC0, 0x00, 0x40, 0x00>>, mp.as_array)


			mp.reset
			mp.put_unsigned_value (0x1FFF_FFFF)
			checker.assert_arrays_equal("Compress 0x1FFF_FFFF -> DFFF FFFF", {ARRAY [NATURAL_8]}<<0xDF, 0xFF, 0xFF, 0xFF>>, mp.as_array)
		end

	test_compress_signed_data
			-- New test routine
		note
			testing:  "covers/{MD_SEQUENCE_POINTS}"
		local
			mp: MD_SEQUENCE_POINTS
			checker: EQA_COMMONLY_USED_ASSERTIONS
		do
			create checker
			create mp.make

			mp.reset
			mp.put_signed(3)
			checker.assert_arrays_equal("Compress 3 -> 06", {ARRAY [NATURAL_8]}<<0x06>>, mp.as_array)

			mp.reset
			mp.put_signed(-3)
			checker.assert_arrays_equal("Compress -3 -> 7B", {ARRAY [NATURAL_8]}<<0x7B>>, mp.as_array)

			mp.reset
			mp.put_signed (64)
			checker.assert_arrays_equal("Compress 64 -> 8080", {ARRAY [NATURAL_8]}<<0x80, 0x80>>, mp.as_array)

			mp.reset
			mp.put_signed (-64)
			checker.assert_arrays_equal("Compress -64 -> 01", {ARRAY [NATURAL_8]}<<0x01>>, mp.as_array)


			mp.reset
			mp.put_signed (8192)
			checker.assert_arrays_equal("Compress 8192 -> C000 4000", {ARRAY [NATURAL_8]}<<0xC0, 0x00, 0x40, 0x00>>, mp.as_array)



			mp.reset
			mp.put_signed (-8192)
			checker.assert_arrays_equal("Compress -8192 -> 8001", {ARRAY [NATURAL_8]}<<0x80, 0x01>>, mp.as_array)


			mp.reset
			mp.put_signed (268435455)
			checker.assert_arrays_equal("Compress 268435455 -> DFFF FFFE", {ARRAY [NATURAL_8]}<<0xDF, 0xFF, 0xFF, 0xFE>>, mp.as_array)

			mp.reset
			mp.put_signed (-268435456)
			checker.assert_arrays_equal("Compress -268435455 -> C000 0001", {ARRAY [NATURAL_8]}<<0xC0, 0x00, 0x00, 0x01>>, mp.as_array)
		end

end
