note
	description: "Summary description for {SHA1_TEST}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "We must have government, but we must watch them like a hawk. - Millicent Fenwick (1983)"

class
	SHA1_TEST

inherit
	EQA_TEST_SET

feature
	test_long
		local
			sha1: SHA1
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
			i: INTEGER
		do
			create sha1.make
			create output.make_filled (0, 20)
			create solution.make_filled (0, 20)
			solution [0] := 0x34
			solution [1] := 0xaa
			solution [2] := 0x97
			solution [3] := 0x3c
			solution [4] := 0xd4
			solution [5] := 0xc4
			solution [6] := 0xda
			solution [7] := 0xa4
			solution [8] := 0xf6
			solution [9] := 0x1e
			solution [10] := 0xeb
			solution [11] := 0x2b
			solution [12] := 0xdb
			solution [13] := 0xad
			solution [14] := 0x27
			solution [15] := 0x31
			solution [16] := 0x65
			solution [17] := 0x34
			solution [18] := 0x01
			solution [19] := 0x6f
			from
				i := 1
			until
				i > 1_000_000
			loop
				sha1.sink_character ('a')
				i := i + 1
			variant
				1_000_000 - i + 1
			end
			sha1.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 20)
			assert ("test long", correct)
		end

	test_multi
		local
			sha1: SHA1
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create sha1.make
			create output.make_filled (0, 20)
			create solution.make_filled (0, 20)
			solution [0] := 0x84
			solution [1] := 0x98
			solution [2] := 0x3e
			solution [3] := 0x44
			solution [4] := 0x1c
			solution [5] := 0x3b
			solution [6] := 0xd2
			solution [7] := 0x6e
			solution [8] := 0xba
			solution [9] := 0xae
			solution [10] := 0x4a
			solution [11] := 0xa1
			solution [12] := 0xf9
			solution [13] := 0x51
			solution [14] := 0x29
			solution [15] := 0xe5
			solution [16] := 0xe5
			solution [17] := 0x46
			solution [18] := 0x70
			solution [19] := 0xf1
			sha1.sink_string ("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq")
			sha1.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 20)
			assert ("test multi", correct)
		end

	test_abc
		local
			sha1: SHA1
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create sha1.make
			create output.make_filled (0, 20)
			create solution.make_filled (0, 20)
			solution [0] := 0xa9
			solution [1] := 0x99
			solution [2] := 0x3e
			solution [3] := 0x36
			solution [4] := 0x47
			solution [5] := 0x06
			solution [6] := 0x81
			solution [7] := 0x6a
			solution [8] := 0xba
			solution [9] := 0x3e
			solution [10] := 0x25
			solution [11] := 0x71
			solution [12] := 0x78
			solution [13] := 0x50
			solution [14] := 0xc2
			solution [15] := 0x6c
			solution [16] := 0x9c
			solution [17] := 0xd0
			solution [18] := 0xd8
			solution [19] := 0x9d
			sha1.update (('a').code.to_natural_8)
			sha1.update (('b').code.to_natural_8)
			sha1.update (('c').code.to_natural_8)
			sha1.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 20)
			assert ("test abc", correct)
		end

	test_empty
		local
			sha1: SHA1
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create sha1.make
			create output.make_filled (0, 20)
			create solution.make_filled (0, 20)
			solution [0] := 0xda
			solution [1] := 0x39
			solution [2] := 0xa3
			solution [3] := 0xee
			solution [4] := 0x5e
			solution [5] := 0x6b
			solution [6] := 0x4b
			solution [7] := 0x0d
			solution [8] := 0x32
			solution [9] := 0x55
			solution [10] := 0xbf
			solution [11] := 0xef
			solution [12] := 0x95
			solution [13] := 0x60
			solution [14] := 0x18
			solution [15] := 0x90
			solution [16] := 0xaf
			solution [17] := 0xd8
			solution [18] := 0x07
			solution [19] := 0x09
			sha1.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 20)
			assert ("test empty", correct)
		end
end
