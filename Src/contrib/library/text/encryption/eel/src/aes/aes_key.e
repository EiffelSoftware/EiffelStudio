note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The single most exciting thing you encounter in government is competence, because it's so rare. - Daniel Patrick Moynihan (1976)"

class
	AES_KEY

inherit
	DEBUG_OUTPUT
	ECB_TARGET
		rename
			encrypt_block as ecb_encrypt,
			decrypt_block as ecb_decrypt
		end
	CBC_TARGET
		rename
			encrypt_block as cbc_encrypt,
			decrypt_block as cbc_decrypt
		end
	CFB_TARGET
		rename
			encrypt_block as cfb_encrypt
		end
	OFB_TARGET
		rename
			encrypt_block as ofb_encrypt
		end
	CTR_TARGET
		rename
			encrypt_block as ctr_encrypt
		end
	AES_COMMON
	AES_ENGINE

create
	make,
	make_spec_128,
	make_spec_196,
	make_spec_256,
	make_vector_128,
	make_vector_196,
	make_vector_256

feature -- Key creation
	make (key_a: SPECIAL [NATURAL_8])
		require
			valid_lengths: key_a.count = 16 or key_a.count = 24 or key_a.count = 32
		do
			make_tables
			key := key_a
			expand_key_to_schedule (key_a)
		end

feature -- Spec and test vector keys
	make_vector_128
		local
			vector_key: SPECIAL [NATURAL_8]
		do
			create vector_key.make_filled (0, 16)
			vector_key [0] := 0x00
			vector_key [1] := 0x01
			vector_key [2] := 0x02
			vector_key [3] := 0x03
			vector_key [4] := 0x04
			vector_key [5] := 0x05
			vector_key [6] := 0x06
			vector_key [7] := 0x07
			vector_key [8] := 0x08
			vector_key [9] := 0x09
			vector_key [10] := 0x0a
			vector_key [11] := 0x0b
			vector_key [12] := 0x0c
			vector_key [13] := 0x0d
			vector_key [14] := 0x0e
			vector_key [15] := 0x0f
			make (vector_key)
		ensure
			vector_128
		end

	make_vector_196
		local
			vector_key: SPECIAL [NATURAL_8]
		do
			create vector_key.make_filled (0, 24)
			vector_key [0] := 0x00
			vector_key [1] := 0x01
			vector_key [2] := 0x02
			vector_key [3] := 0x03
			vector_key [4] := 0x04
			vector_key [5] := 0x05
			vector_key [6] := 0x06
			vector_key [7] := 0x07
			vector_key [8] := 0x08
			vector_key [9] := 0x09
			vector_key [10] := 0x0a
			vector_key [11] := 0x0b
			vector_key [12] := 0x0c
			vector_key [13] := 0x0d
			vector_key [14] := 0x0e
			vector_key [15] := 0x0f
			vector_key [16] := 0x10
			vector_key [17] := 0x11
			vector_key [18] := 0x12
			vector_key [19] := 0x13
			vector_key [20] := 0x14
			vector_key [21] := 0x15
			vector_key [22] := 0x16
			vector_key [23] := 0x17
			make (vector_key)
		ensure
			vector_196
		end

	make_vector_256
		local
			vector_key: SPECIAL [NATURAL_8]
		do
			create vector_key.make_filled (0, 32)
			vector_key [0] := 0x00
			vector_key [1] := 0x01
			vector_key [2] := 0x02
			vector_key [3] := 0x03
			vector_key [4] := 0x04
			vector_key [5] := 0x05
			vector_key [6] := 0x06
			vector_key [7] := 0x07
			vector_key [8] := 0x08
			vector_key [9] := 0x09
			vector_key [10] := 0x0a
			vector_key [11] := 0x0b
			vector_key [12] := 0x0c
			vector_key [13] := 0x0d
			vector_key [14] := 0x0e
			vector_key [15] := 0x0f
			vector_key [16] := 0x10
			vector_key [17] := 0x11
			vector_key [18] := 0x12
			vector_key [19] := 0x13
			vector_key [20] := 0x14
			vector_key [21] := 0x15
			vector_key [22] := 0x16
			vector_key [23] := 0x17
			vector_key [24] := 0x18
			vector_key [25] := 0x19
			vector_key [26] := 0x1a
			vector_key [27] := 0x1b
			vector_key [28] := 0x1c
			vector_key [29] := 0x1d
			vector_key [30] := 0x1e
			vector_key [31] := 0x1f
			make (vector_key)
		ensure
			vector_256
		end

	make_spec_128
			-- Make the FIPS-197 spec 128-bit key
		local
			spec_key: SPECIAL [NATURAL_8]
		do
			create spec_key.make_filled (0, 16)
			spec_key[0] := 0x2b
			spec_key[1] := 0x7e
			spec_key[2] := 0x15
			spec_key[3] := 0x16
			spec_key[4] := 0x28
			spec_key[5] := 0xae
			spec_key[6] := 0xd2
			spec_key[7] := 0xa6
			spec_key[8] := 0xab
			spec_key[9] := 0xf7
			spec_key[10] := 0x15
			spec_key[11] := 0x88
			spec_key[12] := 0x09
			spec_key[13] := 0xcf
			spec_key[14] := 0x4f
			spec_key[15] := 0x3c
			make (spec_key)
		ensure
			spec_schedule: spec_128
		end

	make_spec_196
			-- Make the FIPS-197 spec 196-bit key
		local
			spec_key: SPECIAL [NATURAL_8]
		do
			create spec_key.make_filled (0, 24)
			spec_key [0] := 0x8e
			spec_key [1] := 0x73
			spec_key [2] := 0xb0
			spec_key [3] := 0xf7
			spec_key [4] := 0xda
			spec_key [5] := 0x0e
			spec_key [6] := 0x64
			spec_key [7] := 0x52
			spec_key [8] := 0xc8
			spec_key [9] := 0x10
			spec_key [10] := 0xf3
			spec_key [11] := 0x2b
			spec_key [12] := 0x80
			spec_key [13] := 0x90
			spec_key [14] := 0x79
			spec_key [15] := 0xe5
			spec_key [16] := 0x62
			spec_key [17] := 0xf8
			spec_key [18] := 0xea
			spec_key [19] := 0xd2
			spec_key [20] := 0x52
			spec_key [21] := 0x2c
			spec_key [22] := 0x6b
			spec_key [23] := 0x7b
			make (spec_key)
		ensure
			spec_schedule: spec_196
		end

	make_spec_256
			-- Make the FIPS-197 spec 256-bit key
		local
			spec_key: SPECIAL [NATURAL_8]
		do
			create spec_key.make_filled (0, 32)
			spec_key [0] := 0x60
			spec_key [1] := 0x3d
			spec_key [2] := 0xeb
			spec_key [3] := 0x10
			spec_key [4] := 0x15
			spec_key [5] := 0xca
			spec_key [6] := 0x71
			spec_key [7] := 0xbe
			spec_key [8] := 0x2b
			spec_key [9] := 0x73
			spec_key [10] := 0xae
			spec_key [11] := 0xf0
			spec_key [12] := 0x85
			spec_key [13] := 0x7d
			spec_key [14] := 0x77
			spec_key [15] := 0x81
			spec_key [16] := 0x1f
			spec_key [17] := 0x35
			spec_key [18] := 0x2c
			spec_key [19] := 0x07
			spec_key [20] := 0x3b
			spec_key [21] := 0x61
			spec_key [22] := 0x08
			spec_key [23] := 0xd7
			spec_key [24] := 0x2d
			spec_key [25] := 0x98
			spec_key [26] := 0x10
			spec_key [27] := 0xa3
			spec_key [28] := 0x09
			spec_key [29] := 0x14
			spec_key [30] := 0xdf
			spec_key [31] := 0xf4
			make (spec_key)
		ensure
			spec_schedule: spec_256
		end

feature {ECB_TARGET} -- ECB
	ecb_ready: BOOLEAN
		do
			result := true
		end

	ecb_encrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			encrypt (in, in_offset, out_array, out_offset)
		end

	ecb_decrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			decrypt (in, in_offset, out_array, out_offset)
		end

feature {CBC_TARGET} -- CBC
	cbc_ready: BOOLEAN
		do
			result := true
		end

	cbc_encrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			encrypt (in, in_offset, out_array, out_offset)
		end

	cbc_decrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			decrypt (in, in_offset, out_array, out_offset)
		end

feature {CFB_TARGET} -- CFB
	cfb_ready: BOOLEAN
		do
			result := true
		end

	cfb_encrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			encrypt (in, in_offset, out_array, out_offset)
		end

feature {OFB_TARGET} -- OFB
	ofb_ready: BOOLEAN
		do
			result := true
		end

	ofb_encrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			encrypt (in, in_offset, out_array, out_offset)
		end

feature {CTR_TARGET} -- CTR
	ctr_ready: BOOLEAN
		do
			result := true
		end

	ctr_encrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		do
			encrypt (in, in_offset, out_array, out_offset)
		end

feature -- Operations
	encrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		require
			in.valid_index (in_offset)
			out_array.valid_index (out_offset)
			in.valid_index (in_offset + 15)
			out_array.valid_index (out_offset + 15)
		do
			unpack (in, in_offset)
			encrypt_work (key_schedule.upper)
			pack (out_array, out_offset)
		end

	decrypt (in: SPECIAL [NATURAL_8] in_offset: INTEGER out_array: SPECIAL [NATURAL_8] out_offset: INTEGER)
		require
			in.valid_index (in_offset)
			out_array.valid_index (out_offset)
			in.valid_index (in_offset + 15)
			out_array.valid_index (out_offset + 15)
		do
			unpack (in, in_offset)
			decrypt_work (key_schedule.upper)
			pack (out_array, out_offset)
		end

feature --Implementation
	expand_key_to_schedule (key_a: SPECIAL [NATURAL_8])
		require
			valid_lengths: key_a.count = 16 or key_a.count = 24 or key_a.count = 32
		do
			copy_key_to_schedule (key_a)
		end

	copy_key_to_schedule (key_a: SPECIAL [NATURAL_8])
		require
			valid_lengths: key_a.count = 16 or key_a.count = 24 or key_a.count = 32
		do
			copy_key_to_made_schedule (key_a, 4 * (rounds + 1), key_a.count // 4)
		end

	copy_key_to_made_schedule (key_a: SPECIAL [NATURAL_8] schedule_count: INTEGER key_word_count: INTEGER)
		require
			valid_lengths: key_a.count = 16 or key_a.count = 24 or key_a.count = 32
		local
			i: INTEGER
			t: INTEGER
			sub1, sub2, sub3, sub4: NATURAL_32
			temp: NATURAL_32
		do
			create key_schedule.make_filled (0, schedule_count)
			from
				t := 0
				i := 0
			until
				i > key.upper
			loop
				sub1 := key [i].to_natural_32 |<< 24
				i := i + 1
				sub2 := key [i].to_natural_32 |<< 16
				i := i + 1
				sub3 := key [i].to_natural_32 |<< 8
				i := i + 1
				sub4 := key [i].to_natural_32
				i := i + 1
				key_schedule [t] := sub1 | sub2 | sub3 | sub4
				t := t + 1
			end
			from
				i := key_a.count.bit_shift_right (2)
			until
				i >= schedule_count
			loop
				temp := key_schedule [i - 1]
				if
					i \\ key_word_count = 0
				then
					temp := sub_word (rot_word (temp)).bit_xor (round_constant [i // key_word_count])
				elseif
					key_word_count = 8 and i \\ key_word_count = 4
				then
					temp := sub_word(temp)
				end
				key_schedule [i] := key_schedule [i - key_word_count].bit_xor (temp)
				i := i + 1
			end
		end

	inv_mcol (x: NATURAL_32): NATURAL_32
		local
			f2: NATURAL_32
			f4: NATURAL_32
			f8: NATURAL_32
			f9: NATURAL_32
		do
			f2 := FFmulX (x)
			f4 := FFmulX (f2)
			f8 := FFmulX (f4)
			f9 := x.bit_xor(f8)
			result := f2.bit_xor (f4).bit_xor (f8).bit_xor (rotate_right_32 (f2.bit_xor (f9), 8)).bit_xor (rotate_right_32 (f4.bit_xor (f9), 16)).bit_xor (rotate_right_32 (f9, 24))
		end

	round_constant: SPECIAL [NATURAL_32]
			-- rcon
		once
			create result.make_filled (0, 11)
			result [0] := 0x00000000
			result [1] := 0x01000000
			result [2] := 0x02000000
			result [3] := 0x04000000
			result [4] := 0x08000000
			result [5] := 0x10000000
			result [6] := 0x20000000
			result [7] := 0x40000000
			result [8] := 0x80000000
			result [9] := 0x1b000000
			result [10] := 0x36000000
		end

	rounds: INTEGER
		require
			key.count = 16 or key.count = 24 or key.count = 32
		do
			result := key.count.bit_shift_right (2) + 6
		ensure
			result = key.count // 4 + 6
		end

	key: SPECIAL [NATURAL_8]

	sub_word (x_a: NATURAL_32): NATURAL_32
			-- S-box word substitution
		local
			x: INTEGER
		do
			x := x_a.to_integer_32
			result := result + s [(x |>> 24).bit_and (0xff)]
			result := result.bit_shift_left (8)
			result := result + s [(x |>> 16).bit_and (0xff)]
			result := result.bit_shift_left (8)
			result := result + s [(x |>> 8).bit_and (0xff)]
			result := result.bit_shift_left (8)
			result := result + s [x & 0xff]
		end

	rot_word (x: NATURAL_32): NATURAL_32
			-- Rotate left 4 bits
		do
			result := x.bit_shift_right (24) | x.bit_shift_left (8)
		end

	key_schedule: SPECIAL [NATURAL_32]
			-- FIPS W

	spec_128_bit_schedule: BOOLEAN
			-- Is `key_schedule' the one defined for the 128-bit spec key in FIPS-197
		do
			result := key_schedule.count = 44
			result := result and key_schedule [0] = 0x2b7e1516 and key_schedule [1] = 0x28aed2a6 and key_schedule [2] = 0xabf71588 and key_schedule [3] = 0x09cf4f3c
			result := result and key_schedule [4] = 0xa0fafe17 and key_schedule [5] = 0x88542cb1 and key_schedule [6] = 0x23a33939 and key_schedule [7] = 0x2a6c7605
			result := result and key_schedule [8] = 0xf2c295f2 and key_schedule [9] = 0x7a96b943 and key_schedule [10] = 0x5935807a and key_schedule [11] = 0x7359f67f
			result := result and key_schedule [12] = 0x3d80477d and key_schedule [13] = 0x4716fe3e and key_schedule [14] = 0x1e237e44 and key_schedule [15] = 0x6d7a883b
			result := result and key_schedule [16] = 0xef44a541 and key_schedule [17] = 0xa8525b7f and key_schedule [18] = 0xb671253b and key_schedule [19] = 0xdb0bad00
			result := result and key_schedule [20] = 0xd4d1c6f8 and key_schedule [21] = 0x7c839d87 and key_schedule [22] = 0xcaf2b8bc and key_schedule [23] = 0x11f915bc
			result := result and key_schedule [24] = 0x6d88a37a and key_schedule [25] = 0x110b3efd and key_schedule [26] = 0xdbf98641 and key_schedule [27] = 0xca0093fd
			result := result and key_schedule [28] = 0x4e54f70e and key_schedule [29] = 0x5f5fc9f3 and key_schedule [30] = 0x84a64fb2 and key_schedule [31] = 0x4ea6dc4f
			result := result and key_schedule [32] = 0xead27321 and key_schedule [33] = 0xb58dbad2 and key_schedule [34] = 0x312bf560 and key_schedule [35] = 0x7f8d292f
			result := result and key_schedule [36] = 0xac7766f3 and key_schedule [37] = 0x19fadc21 and key_schedule [38] = 0x28d12941 and key_schedule [39] = 0x575c006e
			result := result and key_schedule [40] = 0xd014f9a8 and key_schedule [41] = 0xc9ee2589 and key_schedule [42] = 0xe13f0cc8 and key_schedule [43] = 0xb6630ca6
		end

	spec_196_bit_schedule: BOOLEAN
			-- Is `key_schedule' the one defined for the 196-bit spec key in FIPS-197
		do
			result := key_schedule.count = 52
			result := result and key_schedule [0] = 0x8e73b0f7 and key_schedule [1] = 0xda0e6452 and key_schedule [2] = 0xc810f32b and key_schedule [3] = 0x809079e5
			result := result and key_schedule [4] = 0x62f8ead2 and key_schedule [5] = 0x522c6b7b and key_schedule [6] = 0xfe0c91f7 and key_schedule [7] = 0x2402f5a5
			result := result and key_schedule [8] = 0xec12068e and key_schedule [9] = 0x6c827f6b and key_schedule [10] = 0x0e7a95b9 and key_schedule [11] = 0x5c56fec2
			result := result and key_schedule [12] = 0x4db7b4bd and key_schedule [13] = 0x69b54118 and key_schedule [14] = 0x85a74796 and key_schedule [15] = 0xe92538fd
			result := result and key_schedule [16] = 0xe75fad44 and key_schedule [17] = 0xbb095386 and key_schedule [18] = 0x485af057 and key_schedule [19] = 0x21efb14f
			result := result and key_schedule [20] = 0xa448f6d9 and key_schedule [21] = 0x4d6dce24 and key_schedule [22] = 0xaa326360 and key_schedule [23] = 0x113b30e6
			result := result and key_schedule [24] = 0xa25e7ed5 and key_schedule [25] = 0x83b1cf9a and key_schedule [26] = 0x27f93943 and key_schedule [27] = 0x6a94f767
			result := result and key_schedule [28] = 0xc0a69407 and key_schedule [29] = 0xd19da4e1 and key_schedule [30] = 0xec1786eb and key_schedule [31] = 0x6fa64971
			result := result and key_schedule [32] = 0x485f7032 and key_schedule [33] = 0x22cb8755 and key_schedule [34] = 0xe26d1352 and key_schedule [35] = 0x33f0b7b3
			result := result and key_schedule [36] = 0x40beeb28 and key_schedule [37] = 0x2f18a259 and key_schedule [38] = 0x6747d26b and key_schedule [39] = 0x458c553e
			result := result and key_schedule [40] = 0xa7e1466c and key_schedule [41] = 0x9411f1df and key_schedule [42] = 0x821f750a and key_schedule [43] = 0xad07d753
			result := result and key_schedule [44] = 0xca400538 and key_schedule [45] = 0x8fcc5006 and key_schedule [46] = 0x282d166a and key_schedule [47] = 0xbc3ce7b5
			result := result and key_schedule [48] = 0xe98ba06f and key_schedule [49] = 0x448c773c and key_schedule [50] = 0x8ecc7204 and key_schedule [51] = 0x01002202
		end

	spec_256_bit_schedule: BOOLEAN
			-- Is `key_schedule' the one defined for the 256-bit spec key in FIPS-197
		do
			result := key_schedule.count = 60
			result := result and key_schedule [0] = 0x603deb10 and key_schedule [1] = 0x15ca71be and key_schedule [2] = 0x2b73aef0 and key_schedule [3] = 0x857d7781
			result := result and key_schedule [4] = 0x1f352c07 and key_schedule [5] = 0x3b6108d7 and key_schedule [6] = 0x2d9810a3 and key_schedule [7] = 0x0914dff4
			result := result and key_schedule [8] = 0x9ba35411 and key_schedule [9] = 0x8e6925af and key_schedule [10] = 0xa51a8b5f and key_schedule [11] = 0x2067fcde
			result := result and key_schedule [12] = 0xa8b09c1a and key_schedule [13] = 0x93d194cd and key_schedule [14] = 0xbe49846e and key_schedule [15] = 0xb75d5b9a
			result := result and key_schedule [16] = 0xd59aecb8 and key_schedule [17] = 0x5bf3c917 and key_schedule [18] = 0xfee94248 and key_schedule [19] = 0xde8ebe96
			result := result and key_schedule [20] = 0xb5a9328a and key_schedule [21] = 0x2678a647 and key_schedule [22] = 0x98312229 and key_schedule [23] = 0x2f6c79b3
			result := result and key_schedule [24] = 0x812c81ad and key_schedule [25] = 0xdadf48ba and key_schedule [26] = 0x24360af2 and key_schedule [27] = 0xfab8b464
			result := result and key_schedule [28] = 0x98c5bfc9 and key_schedule [29] = 0xbebd198e and key_schedule [30] = 0x268c3ba7 and key_schedule [31] = 0x09e04214
			result := result and key_schedule [32] = 0x68007bac and key_schedule [33] = 0xb2df3316 and key_schedule [34] = 0x96e939e4 and key_schedule [35] = 0x6c518d80
			result := result and key_schedule [36] = 0xc814e204 and key_schedule [37] = 0x76a9fb8a and key_schedule [38] = 0x5025c02d and key_schedule [39] = 0x59c58239
			result := result and key_schedule [40] = 0xde136967 and key_schedule [41] = 0x6ccc5a71 and key_schedule [42] = 0xfa256395 and key_schedule [43] = 0x9674ee15
			result := result and key_schedule [44] = 0x5886ca5d and key_schedule [45] = 0x2e2f31d7 and key_schedule [46] = 0x7e0af1fa and key_schedule [47] = 0x27cf73c3
			result := result and key_schedule [48] = 0x749c47ab and key_schedule [49] = 0x18501dda and key_schedule [50] = 0xe2757e4f and key_schedule [51] = 0x7401905a
			result := result and key_schedule [52] = 0xcafaaae3 and key_schedule [53] = 0xe4d59b34 and key_schedule [54] = 0x9adf6ace and key_schedule [55] = 0xbd10190d
			result := result and key_schedule [56] = 0xfe4890d1 and key_schedule [57] = 0xe6188d0b and key_schedule [58] = 0x046df344 and key_schedule [59] = 0x706c631e
		end

	valid_spec_keys: BOOLEAN
		local
			key128: AES_KEY
			key196: AES_KEY
			key256: AES_KEY
		do
			create key128.make_spec_128
			create key196.make_spec_196
			create key256.make_spec_256
			result := key128.spec_128_bit_schedule and key196.spec_196_bit_schedule and key256.spec_256_bit_schedule
		end

	valid_spec_keys_once: BOOLEAN
		once
			result := valid_spec_keys
		end

feature -- Test if the key is a spec key
	spec_128: BOOLEAN
		do
			result := key.count = 16
			result := result and key [0] = 0x2b
			result := result and key [1] = 0x7e
			result := result and key [2] = 0x15
			result := result and key [3] = 0x16
			result := result and key [4] = 0x28
			result := result and key [5] = 0xae
			result := result and key [6] = 0xd2
			result := result and key [7] = 0xa6
			result := result and key [8] = 0xab
			result := result and key [9] = 0xf7
			result := result and key [10] = 0x15
			result := result and key [11] = 0x88
			result := result and key [12] = 0x09
			result := result and key [13] = 0xcf
			result := result and key [14] = 0x4f
			result := result and key [15] = 0x3c
		ensure
			result implies spec_128_bit_schedule
		end

	spec_196: BOOLEAN
		do
			result := key.count = 24
			result := result and key [0] = 0x8e
			result := result and key [1] = 0x73
			result := result and key [2] = 0xb0
			result := result and key [3] = 0xf7
			result := result and key [4] = 0xda
			result := result and key [5] = 0x0e
			result := result and key [6] = 0x64
			result := result and key [7] = 0x52
			result := result and key [8] = 0xc8
			result := result and key [9] = 0x10
			result := result and key [10] = 0xf3
			result := result and key [11] = 0x2b
			result := result and key [12] = 0x80
			result := result and key [13] = 0x90
			result := result and key [14] = 0x79
			result := result and key [15] = 0xe5
			result := result and key [16] = 0x62
			result := result and key [17] = 0xf8
			result := result and key [18] = 0xea
			result := result and key [19] = 0xd2
			result := result and key [20] = 0x52
			result := result and key [21] = 0x2c
			result := result and key [22] = 0x6b
			result := result and key [23] = 0x7b
		ensure
			result implies spec_196_bit_schedule
		end

	spec_256: BOOLEAN
		do
			result := key.count = 32
			result := result and key [0] = 0x60
			result := result and key [1] = 0x3d
			result := result and key [2] = 0xeb
			result := result and key [3] = 0x10
			result := result and key [4] = 0x15
			result := result and key [5] = 0xca
			result := result and key [6] = 0x71
			result := result and key [7] = 0xbe
			result := result and key [8] = 0x2b
			result := result and key [9] = 0x73
			result := result and key [10] = 0xae
			result := result and key [11] = 0xf0
			result := result and key [12] = 0x85
			result := result and key [13] = 0x7d
			result := result and key [14] = 0x77
			result := result and key [15] = 0x81
			result := result and key [16] = 0x1f
			result := result and key [17] = 0x35
			result := result and key [18] = 0x2c
			result := result and key [19] = 0x07
			result := result and key [20] = 0x3b
			result := result and key [21] = 0x61
			result := result and key [22] = 0x08
			result := result and key [23] = 0xd7
			result := result and key [24] = 0x2d
			result := result and key [25] = 0x98
			result := result and key [26] = 0x10
			result := result and key [27] = 0xa3
			result := result and key [28] = 0x09
			result := result and key [29] = 0x14
			result := result and key [30] = 0xdf
			result := result and key [31] = 0xf4
		ensure
			result implies spec_256_bit_schedule
		end

	vector_128: BOOLEAN
		do
			result := key.count = 16
			result := result and key [0] = 0x00
			result := result and key [1] = 0x01
			result := result and key [2] = 0x02
			result := result and key [3] = 0x03
			result := result and key [4] = 0x04
			result := result and key [5] = 0x05
			result := result and key [6] = 0x06
			result := result and key [7] = 0x07
			result := result and key [8] = 0x08
			result := result and key [9] = 0x09
			result := result and key [10] = 0x0a
			result := result and key [11] = 0x0b
			result := result and key [12] = 0x0c
			result := result and key [13] = 0x0d
			result := result and key [14] = 0x0e
			result := result and key [15] = 0x0f
		end

	vector_196: BOOLEAN
		do
			result := key.count = 24
			result := result and key [0] = 0x00
			result := result and key [1] = 0x01
			result := result and key [2] = 0x02
			result := result and key [3] = 0x03
			result := result and key [4] = 0x04
			result := result and key [5] = 0x05
			result := result and key [6] = 0x06
			result := result and key [7] = 0x07
			result := result and key [8] = 0x08
			result := result and key [9] = 0x09
			result := result and key [10] = 0x0a
			result := result and key [11] = 0x0b
			result := result and key [12] = 0x0c
			result := result and key [13] = 0x0d
			result := result and key [14] = 0x0e
			result := result and key [15] = 0x0f
			result := result and key [16] = 0x10
			result := result and key [17] = 0x11
			result := result and key [18] = 0x12
			result := result and key [19] = 0x13
			result := result and key [20] = 0x14
			result := result and key [21] = 0x15
			result := result and key [22] = 0x16
			result := result and key [23] = 0x17
		end

	vector_256: BOOLEAN
		do
			result := key.count = 32
			result := result and key [0] = 0x00
			result := result and key [1] = 0x01
			result := result and key [2] = 0x02
			result := result and key [3] = 0x03
			result := result and key [4] = 0x04
			result := result and key [5] = 0x05
			result := result and key [6] = 0x06
			result := result and key [7] = 0x07
			result := result and key [8] = 0x08
			result := result and key [9] = 0x09
			result := result and key [10] = 0x0a
			result := result and key [11] = 0x0b
			result := result and key [12] = 0x0c
			result := result and key [13] = 0x0d
			result := result and key [14] = 0x0e
			result := result and key [15] = 0x0f
			result := result and key [16] = 0x10
			result := result and key [17] = 0x11
			result := result and key [18] = 0x12
			result := result and key [19] = 0x13
			result := result and key [20] = 0x14
			result := result and key [21] = 0x15
			result := result and key [22] = 0x16
			result := result and key [23] = 0x17
			result := result and key [24] = 0x18
			result := result and key [25] = 0x19
			result := result and key [26] = 0x1a
			result := result and key [27] = 0x1b
			result := result and key [28] = 0x1c
			result := result and key [29] = 0x1d
			result := result and key [30] = 0x1e
			result := result and key [31] = 0x1f
		end

feature -- {DEBUG_OUTPUT}
	debug_output: STRING
		local
			index: INTEGER_32
		do
			Result := "0x"
			from
				index := key.lower
			until
				index > key.upper
			loop
				Result.append (key [index].to_hex_string)
				index := index + 1
			variant
				key.upper - index + 2
			end
		end

invariant
	valid_spec_keys_once: valid_spec_keys_once
end
