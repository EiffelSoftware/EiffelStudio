note
	description: "Summary description for {SHA256_TEST}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "A little government and a little luck are necessary in life, but only a fool trusts either of them. - P. J. O'Rourke"

class
	SHA256_TEST

inherit
	EQA_TEST_SET

feature
	test_long
		local
			sha256: SHA256
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
			i: INTEGER
		do
			create sha256.make
			create output.make_filled (0, 32)
			create solution.make_filled (0, 32)
			solution [0] := 0xcd
			solution [1] := 0xc7
			solution [2] := 0x6e
			solution [3] := 0x5c
			solution [4] := 0x99
			solution [5] := 0x14
			solution [6] := 0xfb
			solution [7] := 0x92
			solution [8] := 0x81
			solution [9] := 0xa1
			solution [10] := 0xc7
			solution [11] := 0xe2
			solution [12] := 0x84
			solution [13] := 0xd7
			solution [14] := 0x3e
			solution [15] := 0x67
			solution [16] := 0xf1
			solution [17] := 0x80
			solution [18] := 0x9a
			solution [19] := 0x48
			solution [20] := 0xa4
			solution [21] := 0x97
			solution [22] := 0x20
			solution [23] := 0x0e
			solution [24] := 0x04
			solution [25] := 0x6d
			solution [26] := 0x39
			solution [27] := 0xcc
			solution [28] := 0xc7
			solution [29] := 0x11
			solution [30] := 0x2c
			solution [31] := 0xd0
			from
				i := 1
			until
				i > 1_000_000
			loop
				sha256.sink_character ('a')
				i := i + 1
			variant
				1_000_000 - i + 1
			end
			sha256.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 32)
			assert ("test long", correct)
		end

	test_multi
		local
			sha256: SHA256
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create sha256.make
			create output.make_filled (0, 32)
			create solution.make_filled (0, 32)
			solution [0] := 0x24
			solution [1] := 0x8d
			solution [2] := 0x6a
			solution [3] := 0x61
			solution [4] := 0xd2
			solution [5] := 0x06
			solution [6] := 0x38
			solution [7] := 0xb8
			solution [8] := 0xe5
			solution [9] := 0xc0
			solution [10] := 0x26
			solution [11] := 0x93
			solution [12] := 0x0c
			solution [13] := 0x3e
			solution [14] := 0x60
			solution [15] := 0x39
			solution [16] := 0xa3
			solution [17] := 0x3c
			solution [18] := 0xe4
			solution [19] := 0x59
			solution [20] := 0x64
			solution [21] := 0xff
			solution [22] := 0x21
			solution [23] := 0x67
			solution [24] := 0xf6
			solution [25] := 0xec
			solution [26] := 0xed
			solution [27] := 0xd4
			solution [28] := 0x19
			solution [29] := 0xdb
			solution [30] := 0x06
			solution [31] := 0xc1
			sha256.sink_string ("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq")
			sha256.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 32)
			assert ("test multi", correct)
		end

	test_abc
		local
			sha256: SHA256
			output: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create sha256.make
			create output.make_filled (0, 32)
			create solution.make_filled (0, 32)
			solution [0] := 0xba
			solution [1] := 0x78
			solution [2] := 0x16
			solution [3] := 0xbf
			solution [4] := 0x8f
			solution [5] := 0x01
			solution [6] := 0xcf
			solution [7] := 0xea
			solution [8] := 0x41
			solution [9] := 0x41
			solution [10] := 0x40
			solution [11] := 0xde
			solution [12] := 0x5d
			solution [13] := 0xae
			solution [14] := 0x22
			solution [15] := 0x23
			solution [16] := 0xb0
			solution [17] := 0x03
			solution [18] := 0x61
			solution [19] := 0xa3
			solution [20] := 0x96
			solution [21] := 0x17
			solution [22] := 0x7a
			solution [23] := 0x9c
			solution [24] := 0xb4
			solution [25] := 0x10
			solution [26] := 0xff
			solution [27] := 0x61
			solution [28] := 0xf2
			solution [29] := 0x00
			solution [30] := 0x15
			solution [31] := 0xad
			sha256.update (('a').code.to_natural_8)
			sha256.update (('b').code.to_natural_8)
			sha256.update (('c').code.to_natural_8)
			sha256.do_final (output, 0)
			correct := solution.same_items (output, 0, 0, 32)
			assert ("test abc", correct)
		end
end
