note
	description: "Summary description for {MD5_TEST}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Give me liberty or give me death! - Patrick Henry"

class
	MD5_TEST

inherit
	EQA_TEST_SET

feature
	test_million_a
		local
			md5: MD5
			count: INTEGER_32
		do
			create md5.make
			from
				count := 1
			until
				count > 1_000_000
			loop
				md5.sink_character ('a')
				count := count + 1
			end
		end

	test_alphabet
		local
			md5: MD5
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create solution.make_filled (0, 16)
			solution [0] := 0xc3
			solution [1] := 0xfc
			solution [2] := 0xd3
			solution [3] := 0xd7
			solution [4] := 0x61
			solution [5] := 0x92
			solution [6] := 0xe4
			solution [7] := 0x00
			solution [8] := 0x7d
			solution [9] := 0xfb
			solution [10] := 0x49
			solution [11] := 0x6c
			solution [12] := 0xca
			solution [13] := 0x67
			solution [14] := 0xe1
			solution [15] := 0x3b
			create output.make_filled (0, 16)
			create md5.make
			md5.sink_string ("abcdefghijklmnopqrstuvwxyz")
			md5.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 16)
			assert ("test alphabet", correct)
		end

	test_empty
		local
			md5: MD5
			output: SPECIAL [NATURAL_8]
		do
			create output.make_filled (0, 16)
			create md5.make
			md5.do_final (output, 0)
		end

	test_a
		local
			md5: MD5
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create solution.make_filled (0, 16)
			solution [0] := 0x0c
			solution [1] := 0xc1
			solution [2] := 0x75
			solution [3] := 0xb9
			solution [4] := 0xc0
			solution [5] := 0xf1
			solution [6] := 0xb6
			solution [7] := 0xa8
			solution [8] := 0x31
			solution [9] := 0xc3
			solution [10] := 0x99
			solution [11] := 0xe2
			solution [12] := 0x69
			solution [13] := 0x77
			solution [14] := 0x26
			solution [15] := 0x61
			create output.make_filled (0, 16)
			create md5.make
			md5.sink_string ("a")
			md5.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 16)
			assert ("test a", correct)
		end

	test_abc
		local
			md5: MD5
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create solution.make_filled (0, 16)
			solution [0] := 0x90
			solution [1] := 0x01
			solution [2] := 0x50
			solution [3] := 0x98
			solution [4] := 0x3c
			solution [5] := 0xd2
			solution [6] := 0x4f
			solution [7] := 0xb0
			solution [8] := 0xd6
			solution [9] := 0x96
			solution [10] := 0x3f
			solution [11] := 0x7d
			solution [12] := 0x28
			solution [13] := 0xe1
			solution [14] := 0x7f
			solution [15] := 0x72
			create output.make_filled (0, 16)
			create md5.make
			md5.sink_string ("abc")
			md5.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 16)
			assert ("test abc", correct)
		end
end
