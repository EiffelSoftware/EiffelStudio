note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The best government is the one that charges you the least blackmail for leaving you alone. - Thomas Rudmose-Brown (1996)"

class
	AES_TEST

inherit
	EQA_TEST_SET

feature
	test_vector_256
		local
			key_data: SPECIAL [NATURAL_8]
			key: AES_KEY
			cipher_text: SPECIAL [NATURAL_8]
			plain: SPECIAL [NATURAL_8]
			vector: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create key_data.make_filled (0, 32)
			key_data [0] := 0x00
			key_data [1] := 0x01
			key_data [2] := 0x02
			key_data [3] := 0x03
			key_data [4] := 0x04
			key_data [5] := 0x05
			key_data [6] := 0x06
			key_data [7] := 0x07
			key_data [8] := 0x08
			key_data [9] := 0x09
			key_data [10] := 0x0a
			key_data [11] := 0x0b
			key_data [12] := 0x0c
			key_data [13] := 0x0d
			key_data [14] := 0x0e
			key_data [15] := 0x0f
			key_data [16] := 0x10
			key_data [17] := 0x11
			key_data [18] := 0x12
			key_data [19] := 0x13
			key_data [20] := 0x14
			key_data [21] := 0x15
			key_data [22] := 0x16
			key_data [23] := 0x17
			key_data [24] := 0x18
			key_data [25] := 0x19
			key_data [26] := 0x1a
			key_data [27] := 0x1b
			key_data [28] := 0x1c
			key_data [29] := 0x1d
			key_data [30] := 0x1e
			key_data [31] := 0x1f
			create key.make (key_data)
			create solution.make_filled (0, 16)
			solution [0] := 0x8e
			solution [1] := 0xa2
			solution [2] := 0xb7
			solution [3] := 0xca
			solution [4] := 0x51
			solution [5] := 0x67
			solution [6] := 0x45
			solution [7] := 0xbf
			solution [8] := 0xea
			solution [9] := 0xfc
			solution [10] := 0x49
			solution [11] := 0x90
			solution [12] := 0x4b
			solution [13] := 0x49
			solution [14] := 0x60
			solution [15] := 0x89
			create vector.make_filled (0, 16)
			vector [0] := 0x00
			vector [1] := 0x11
			vector [2] := 0x22
			vector [3] := 0x33
			vector [4] := 0x44
			vector [5] := 0x55
			vector [6] := 0x66
			vector [7] := 0x77
			vector [8] := 0x88
			vector [9] := 0x99
			vector [10] := 0xaa
			vector [11] := 0xbb
			vector [12] := 0xcc
			vector [13] := 0xdd
			vector [14] := 0xee
			vector [15] := 0xff
			create cipher_text.make_filled (0, 16)
			key.encrypt (vector, 0, cipher_text, 0)
			correct := cipher_text.same_items (solution, 0, 0, 16)
			assert ("test vector 256 1", correct)
			create plain.make_filled (0, 16)
			key.decrypt (cipher_text, 0, plain, 0)
			correct := plain.same_items (vector, 0, 0, 16)
			assert ("test vector 256 2", correct)
		end

	test_vector_192
		local
			key_data: SPECIAL [NATURAL_8]
			key: AES_KEY
			cipher_text: SPECIAL [NATURAL_8]
			plain: SPECIAL [NATURAL_8]
			vector: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create key_data.make_filled (0, 24)
			key_data [0] := 0x00
			key_data [1] := 0x01
			key_data [2] := 0x02
			key_data [3] := 0x03
			key_data [4] := 0x04
			key_data [5] := 0x05
			key_data [6] := 0x06
			key_data [7] := 0x07
			key_data [8] := 0x08
			key_data [9] := 0x09
			key_data [10] := 0x0a
			key_data [11] := 0x0b
			key_data [12] := 0x0c
			key_data [13] := 0x0d
			key_data [14] := 0x0e
			key_data [15] := 0x0f
			key_data [16] := 0x10
			key_data [17] := 0x11
			key_data [18] := 0x12
			key_data [19] := 0x13
			key_data [20] := 0x14
			key_data [21] := 0x15
			key_data [22] := 0x16
			key_data [23] := 0x17
			create key.make (key_data)
			create solution.make_filled (0, 16)
			solution [0] := 0xdd
			solution [1] := 0xa9
			solution [2] := 0x7c
			solution [3] := 0xa4
			solution [4] := 0x86
			solution [5] := 0x4c
			solution [6] := 0xdf
			solution [7] := 0xe0
			solution [8] := 0x6e
			solution [9] := 0xaf
			solution [10] := 0x70
			solution [11] := 0xa0
			solution [12] := 0xec
			solution [13] := 0x0d
			solution [14] := 0x71
			solution [15] := 0x91
			create vector.make_filled (0, 16)
			vector [0] := 0x00
			vector [1] := 0x11
			vector [2] := 0x22
			vector [3] := 0x33
			vector [4] := 0x44
			vector [5] := 0x55
			vector [6] := 0x66
			vector [7] := 0x77
			vector [8] := 0x88
			vector [9] := 0x99
			vector [10] := 0xaa
			vector [11] := 0xbb
			vector [12] := 0xcc
			vector [13] := 0xdd
			vector [14] := 0xee
			vector [15] := 0xff
			create cipher_text.make_filled (0, 16)
			key.encrypt (vector, 0, cipher_text, 0)
			correct := cipher_text.same_items (solution, 0, 0, 16)
			assert ("test vector 192 1", correct)
			create plain.make_filled (0, 16)
			key.decrypt (cipher_text, 0, plain, 0)
			correct := vector.same_items (plain, 0, 0, 16)
			assert ("test vector 192 2", correct)
		end

	test_vector_128
		local
			aes: AES_KEY
			cipher_text: SPECIAL [NATURAL_8]
			plain: SPECIAL [NATURAL_8]
			vector_1: SPECIAL [NATURAL_8]
			solution: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create solution.make_filled (0, 16)
			solution [0] := 0x39
			solution [1] := 0x25
			solution [2] := 0x84
			solution [3] := 0x1d
			solution [4] := 0x02
			solution [5] := 0xdc
			solution [6] := 0x09
			solution [7] := 0xfb
			solution [8] := 0xdc
			solution [9] := 0x11
			solution [10] := 0x85
			solution [11] := 0x97
			solution [12] := 0x19
			solution [13] := 0x6a
			solution [14] := 0x0b
			solution [15] := 0x32
			create vector_1.make_filled (0, 16)
			vector_1 [0] := 0x32
			vector_1 [1] := 0x43
			vector_1 [2] := 0xf6
			vector_1 [3] := 0xa8
			vector_1 [4] := 0x88
			vector_1 [5] := 0x5a
			vector_1 [6] := 0x30
			vector_1 [7] := 0x8d
			vector_1 [8] := 0x31
			vector_1 [9] := 0x31
			vector_1 [10] := 0x98
			vector_1 [11] := 0xa2
			vector_1 [12] := 0xe0
			vector_1 [13] := 0x37
			vector_1 [14] := 0x07
			vector_1 [15] := 0x34
			create cipher_text.make_filled (0, 16)
			aes.encrypt (vector_1, 0, cipher_text, 0)
			correct := cipher_text.same_items (solution, 0, 0, 16)
			assert ("test vector 128 1", correct)
			create plain.make_filled (0, 16)
			aes.decrypt (cipher_text, 0, plain, 0)
			correct := vector_1.same_items (plain, 0, 0, 16)
			assert ("test vector 128 2", correct)
		end

	test_keys
		local
			key1: AES_KEY
			key2: AES_KEY
			key3: AES_KEY
		do
			create key1.make_spec_128
			assert ("test keys 1", key1.spec_128_bit_schedule)
			create key2.make_spec_196
			assert ("test keys 2", key2.spec_196_bit_schedule)
			create key3.make_spec_256
			assert ("test keys 3", key3.spec_256_bit_schedule)
		end
end
