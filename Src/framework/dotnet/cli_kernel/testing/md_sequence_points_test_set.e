note
	description: "Summary description for {MD_SEQUENCE_POINTS_TEST_SET}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_SEQUENCE_POINTS_TEST_SET

inherit
	EQA_TEST_SET



feature -- Test routines

	test_signed_compress
			-- New test routine
		note
			testing:  "covers/{MD_SEQUENCE_POINTS}"
		local
			mp: MD_SEQUENCE_POINTS
			l_result: ARRAY [NATURAL_8]
			checker: EQA_COMMONLY_USED_ASSERTIONS
		do
			create checker
			create mp.make
			mp.put_signed(3)
			checker.assert_arrays_equal("Compress 3 - 06", {ARRAY [NATURAL_8]}<<6>>, mp.as_array)

--			create mp.make
--			mp.put_signed(-3)
--			checker.assert_arrays_equal("Compress 3 - 7B", {ARRAY [NATURAL_8]}<<123>>, mp.as_array)


			mp.reset
			mp.put_signed(64)
			l_result := mp.as_array

			mp.reset
			mp.put_signed(-64)
			l_result := mp.as_array

			mp.reset
			mp.put_signed(8192)
			l_result := mp.as_array

			mp.reset
			mp.put_signed(-8192)
			l_result := mp.as_array


			mp.reset
			mp.put_signed(268435455)
			l_result := mp.as_array

			mp.reset
			mp.put_signed(-268435456)
			l_result := mp.as_array


		end

end
