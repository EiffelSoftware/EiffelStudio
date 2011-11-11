note
	description: "Summary description for {TEST_NUMBER_ARITHMETIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SPECIAL_ARITHMETIC

inherit
	EQA_TEST_SET
	SPECIAL_COMPARISON
		undefine
			default_create
		end
	SPECIAL_ARITHMETIC
		undefine
			default_create
		end

feature
	test_add_1_1
		local
			one: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			add_1 (item, 0, one, 0, 4, 1, carry)
			assert ("Test add 1 1", item [0] = 0 and item [1] = 0 and item [2] = 0 and item [3] = 0 and carry.item = 1)
		end

	test_add_1_2
		local
			item: SPECIAL [NATURAL_32]
			junk: CELL [NATURAL_32]
		do
			create junk.put (0)
			create item.make_filled (0, 2)
			item [0] := 0xcb101a11
			item [1] := 0xf00635d0
			add_1 (item, 0, item, 0, 2, 0x57cc11df, junk)
			assert ("test add 1 2", item [0] = 0x22dc2bf0 and item [1] = 0xf00635d1 and junk.item = 0)
		end

	test_add_1_3
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			junk: CELL [NATURAL_32]
		do
			create junk.put (0)
			create one.make_filled (0, 4)
			create two.make_filled (0, 2)
			one [0] := 0xeeeeeeee
			one [1] := 0xeeeeeeee
			two [0] := 0xeeeeeeee
			add_1 (one, 2, two, 1, 1, 0, junk)
			assert ("test add 1 3", one [0] = 0xeeeeeeee and one [1] = 0xeeeeeeee and one [2] = 0x0 and one [3] = 0x0 and two [0] = 0xeeeeeeee and two [1] = 0x0 and junk.item = 0)
		end

	test_add_1_4
		local
			one: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			add_1 (item, 0, one, 0, 4, 1, carry)
			assert ("Test add 1 4 1", item [0] = 0 and item [1] = 0 and item [2] = 0 and item [3] = 0 and carry.item = 1)
			add_1 (item, 0, one, 0, 4, 0, carry)
			assert ("Test add 1 4 2", item [0] = 0xffffffff and item [1] = 0xffffffff and item [2] = 0xffffffff and item [3] = 0xffffffff and carry.item = 0)
		end

	test_add_n
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create item.make_filled (0, 4)
			create one.make_filled (0xffffffff, 4)
			create two.make_filled (0, 4)
			one [3] := 0x0
			two [0] := 0x1
			add_n (item, 0, one, 0, two, 0, 4, carry)
			assert ("Test add n", item [0] = 0 and item [1] = 0 and item [2] = 0 and item [3] = 1 and carry.item = 0)
		end

	test_add_n_carry
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create item.make_filled (0, 4)
			create one.make_filled (0xffffffff, 4)
			create two.make_filled (0, 4)
			two [0] := 0x1
			add_n (item, 0, one, 0, two, 0, 4, carry)
			assert ("Test add n", item [0] = 0 and item [1] = 0 and item [2] = 0 and item [3] = 0 and carry.item = 1)
		end

	test_add_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create item.make_filled (0, 4)
			create one.make_filled (0xffffffff, 4)
			create two.make_filled (0, 4)
			one [3] := 0x0
			two [0] := 0x1
			add (item, 0, one, 0, one.count, two, 0, two.count, carry)
			assert ("Test add n", item [0] = 0 and item [1] = 0 and item [2] = 0 and item [3] = 1 and carry.item = 0)
		end

	test_add_2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create one.make_filled (0, 0xb)
			create two.make_filled (0, 0xa)
			create three.make_filled (0, 0x5)
			two [0] := 0xee98e4a2
			two [1] := 0x8aec1812
			two [2] := 0xfc43f9bb
			two [3] := 0x70d1ccc8
			two [4] := 0xc122bf19
			two [5] := 0xeb356bfb
			two [6] := 0x77f53c1f
			two [7] := 0xac9b2b87
			two [8] := 0x13524c02
			two [9] := 0x89136811
			three [0] := 0x9cd0d89d
			three [1] := 0x7850c26c
			three [2] := 0xba3e2571
			three [3] := 0x4706816a
			three [4] := 0xa9993e36
			add (one, 0, two, 0, 0xa, three, 0, 0x5, carry)
			assert ("test add 2", carry.item = 0 and one [0] = 0x8b69bd3f and one [1] = 0x033cda7f and one [2] = 0xb6821f2d and one [3] = 0xb7d84e33 and one [4] = 0x6abbfd4f and one [5] = 0xeb356bfc and one [6] = 0x77f53c1f and one [7] = 0xac9b2b87 and one [8] = 0x13524c02 and one [9] = 0x89136811)
		end

	test_cmp_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			comp: INTEGER_32
		do
			create one.make_filled (0xffffffff, 4)
			create two.make_filled (0x90000000, 4)
			comp := cmp (one, 0, two, 0, 4)
			assert ("Test cmp 1", comp = 1)
		end

	test_cmp_2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			comp: INTEGER_32
		do
			create one.make_filled (0x90000000, 4)
			create two.make_filled (0xffffffff, 4)
			comp := cmp (one, 0, two, 0, 4)
			assert ("Test cmp 2", comp = -1)
		end

	test_cmp_3
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			comp: INTEGER_32
		do
			create one.make_filled (0x80000000, 4)
			create two.make_filled (0x80000000, 4)
			assert ("Test cmp 3", comp = 0)
		end

	test_mul_1
		local
			one: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create item.make_filled (0, 4)
			create one.make_filled (1, 4)
			mul_1 (item, 0, one, 0, 4, 2, carry)
			assert ("Test mul 1", item [0] = 2 and item [1] = 2 and item [2] = 2 and item [3] = 2 and carry.item = 0)
			create item.make_filled (0, 4)
			create one.make_filled (0xffffffff, 4)
			mul_1 (item, 0, one, 0, 4, 0xffffffff, carry)
			assert ("Test mul 1", item [0] = 0x1 and item [1] = 0xffffffff and item [2] = 0xffffffff and item [3] = 0xffffffff and carry.item = 0xfffffffe)
		end

	test_mul_1_offsets
		local
			one: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create item.make_filled (0, 6)
			create one.make_filled (1, 6)
			item [0] := 0x10101010
			item [5] := 0x10101010
			mul_1 (item, 1, one, 1, 4, 2, carry)
			assert ("Test mul 1 offsets", item [0] = 0x10101010 and item [1] = 2 and item [2] = 2 and item [3] = 2 and item [4] = 2 and item [5] = 0x10101010 and carry.item = 0)
			create item.make_filled (0, 6)
			create one.make_filled (0xffffffff, 6)
			item [0] := 0x10101010
			item [5] := 0x10101010
			mul_1 (item, 1, one, 1, 4, 0xffffffff, carry)
			assert ("Test mul 1 offsets", item [0] = 0x10101010 and item [1] = 1 and item [2] = 0xffffffff and item [3] = 0xffffffff and item [4] = 0xffffffff and item [5] = 0x10101010 and carry.item = 0xfffffffe)
		end

	test_mul_n_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			target: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x77777777, 4)
			create two.make_filled (0x0, 4)
			two [0] := 0x2
			create target.make_filled (0, 8)
			mul_n (target, 0, one, 0, two, 0, 4)
			assert ("test mul n 1", target [0] = 0xeeeeeeee and target [1] = 0xeeeeeeee and target [2] = 0xeeeeeeee and target [3] = 0xeeeeeeee and target [4] = 0x0 and target [5] = 0x0 and target [6] = 0x0 and target [7] = 0x0)
		end

	test_mul_basecase_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create item.make_filled (0, 8)
			create one.make_filled (4, 4)
			create two.make_filled (4, 4)
			mul_basecase (item, 0, one, 0, one.count, two, 0, two.count)
			assert ("test mul basecase", item [0] = 0x10 and item [1] = 0x20 and item [2] = 0x30 and item [3] = 0x40 and item [4] = 0x30 and item [5] = 0x20 and item [6] = 0x10 and item [7] = 0x0)
		end

	test_sqr
		local
			one: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 8)
			sqr_n (item, 0, one, 0, 4)
			assert ("test sqr", item [0] = 0x00000001 and item [1] = 0x0 and item [2] = 0x0 and item [3] = 0x0 and item [4] = 0xfffffffe and item [5] = 0xffffffff and item [6] = 0xffffffff and item [7] = 0xffffffff)
		end

	test_sub_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			borrow: CELL [NATURAL_32]
		do
			create borrow.put (0)
			create one.make_filled (0, 0x12)
			create two.make_filled (0xffffffff, 0x11)
			two [0x10] := 0x000001ff
			create three.make_filled (0, 0x10)
			three [0] := 0x9e76fb15
			three [1] := 0x32e4e606
			three [2] := 0xb6d93fcc
			three [3] := 0x621dd631
			three [4] := 0xa3a1f005
			three [5] := 0x19f28b09
			three [6] := 0x19a6800c
			three [7] := 0xaf6e5a54
			three [8] := 0x37fae053
			three [9] := 0xad460fb3
			three [10] := 0xfb2a9d7c
			three [11] := 0x9947e909
			three [12] := 0x2a7e14c9
			three [13] := 0xce163d50
			three [14] := 0x689f4fd7
			three [15] := 0x7231ea35
			sub (one, 0, two, 0, 0x11, three, 0, 0x10, borrow)
			assert ("test sub 1 1", borrow.item = 0 and one [0] = 0x618904ea and one [1] = 0xcd1b19f9 and one [2] = 0x4926c033 and one [3] = 0x9de229ce)
			assert ("test sub 1 2", one [4] = 0x5c5e0ffa and one [5] = 0xe60d74f6 and one [6] = 0xe6597ff3 and one [7] = 0x5091a5ab)
			assert ("test sub 1 3", one [8] = 0xc8051fac and one [9] = 0x52b9f04c and one [10] = 0x04d56283 and one [11] = 0x66b816f6)
			assert ("test sub 1 4", one [12] = 0xd581eb36 and one [13] = 0x31e9c2af and one [14] = 0x9760b028 and one [15] = 0x8dce15ca and one [16] = 0x000001ff)
		end

	test_sub_1_1
		local
			one: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create one.make_filled (0x11111111, 4)
			sub_1 (one, 0 + 2, one, 0 + 2, 2, 0, carry)
			assert ("test sub 1", one [0] = 0x11111111 and one [1] = 0x11111111 and one [2] = 0x11111111 and one [3] = 0x11111111 and carry.item = 0x0)
		end

	test_sub_1_2
		local
			one: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create one.make_filled (0, 4)
			sub_1 (one, 3, one, 3, 1, 0, carry)
			assert ("Test sub 1 2", one [0] = 0x0 and one [1] = 0x0 and one [2] = 0x0 and one [3] = 0x0 and carry.item = 0x0)
		end

	test_sub_n
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			create carry.put (0)
			create item.make_filled (0, 4)
			create one.make_filled (0, 4)
			create two.make_filled (0, 4)
			two [0] := 1
			sub_n (item, 0, one, 0, two, 0, 4, carry)
			assert ("Test sub", item [0] = 0xffffffff and item [1] = 0xffffffff and item [2] = 0xffffffff and item [3] = 0xffffffff and carry.item = 1)
		end

	test_incr_u
		local
			item: SPECIAL [NATURAL_32]
		do
			create item.make_filled (0xffffffff, 4)
			item [3] := 0
			incr_u (item, 0, 1)
			assert ("Test incr u", item [0] = 0x0 and item [1] = 0x0 and item [2] = 0x0 and item [3] = 0x1)
		end

	big_one: SPECIAL [NATURAL_32]
		local
			one: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 65)
			one [0] := 0xffffffff one [1] := 0xffffffff one [2] := 0xffffffff one [3] := 0xffffffff
			one [4] := 0xffffffff one [5] := 0xffffffff one [6] := 0xffffffff one [7] := 0x3fffffff
			--
			one [36] := 0x00000000 one [37] := 0x00000000 one [38] := 0xc0000000 one [39] := 0xffffffff
			one [40] := 0xffffffff one [41] := 0xffffffff one [42] := 0xffffffff one [43] := 0xffffffff
			one [44] := 0xffffffff one [45] := 0xffffffff one [46] := 0xffffffff one [47] := 0xffffffff
			one [48] := 0xffffffff one [49] := 0xffffffff one [50] := 0xffffffff one [51] := 0xffffffff
			one [52] := 0xffffffff one [53] := 0xffffffff one [54] := 0xffffffff one [55] := 0xffffffff
			one [56] := 0xffffffff one [57] := 0x01ffffff one [58] := 0x00000000 one [59] := 0x00000000
			one [63] := 0xffffffff one [64] := 0xffffffff

			Result := one
		end

	big_two: SPECIAL [NATURAL_32]
		local
			two: SPECIAL [NATURAL_32]
		do
			create two.make_filled (0, 65)
			two [0] := 0xffffffff
			two [40] := 0x00000000 two [41] := 0x00000000 two [42] := 0x00000000 two [43] := 0xfff80000
			two [44] := 0xffffffff two [45] := 0xffffffff two [46] := 0xffffffff two [47] := 0xffffffff
			two [48] := 0xffffffff two [49] := 0xffffffff two [50] := 0xffffffff two [51] := 0xffffffff
			two [52] := 0xffffffff two [53] := 0xffffffff two [54] := 0xffffffff two [55] := 0xffffffff
			two [56] := 0xffffffff two [57] := 0xffffffff two [58] := 0xffffffff two [59] := 0xffffffff
			two [60] := 0xffffffff two [61] := 0xffffffff two [62] := 0xffffffff two [63] := 0xffffffff
			two [64] := 0xffffffff

			Result := two
		end

	test_kara_n_odd
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			ref: SPECIAL [NATURAL_32]
			workspace: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			one := big_one
			two := big_two
			create ref.make_filled (0, 130)
			ref [0] := 0x00000001 ref [1] := 0xffffffff ref [2] := 0xffffffff ref [3] := 0xffffffff
			ref [4] := 0xffffffff ref [5] := 0xffffffff ref [6] := 0xffffffff ref [7] := 0xbfffffff
			ref [8] := 0x3fffffff
			ref [36] := 0x00000000 ref [37] := 0x00000000 ref [38] := 0x40000000 ref [39] := 0xc0000000
			ref [40] := 0xffffffff ref [41] := 0xffffffff ref [42] := 0xffffffff ref [43] := 0x0007ffff
			ref [48] := 0x00000000 ref [49] := 0x00000000 ref [50] := 0x00000000 ref [51] := 0xfffe0000
			ref [52] := 0xffffffff ref [53] := 0xffffffff ref [54] := 0xffffffff ref [55] := 0xffffffff
			ref [56] := 0xffffffff ref [57] := 0xfdffffff ref [58] := 0x01ffffff
			ref [60] := 0x00000000 ref [61] := 0x00000000 ref [62] := 0x00000000 ref [63] := 0x00000001
			ref [64] := 0xffffffff ref [65] := 0xfffffffd
			ref [72] := 0x40000000
			ref [80] := 0x00000000 ref [81] := 0x00000000 ref [82] := 0x00020000
			ref [100] := 0x00000000 ref [101] := 0xfffff000 ref [102] := 0xffffffff ref [103] := 0xbfffffff
			ref [104] := 0xffffffff ref [105] := 0xffffffff ref [106] := 0x0007ffff ref [107] := 0x00000000
			ref [108] := 0xfff80000 ref [109] := 0xffffffff ref [110] := 0xffffffff ref [111] := 0xffffffff
			ref [112] := 0xffffffff ref [113] := 0xffffffff ref [114] := 0xffffffff ref [115] := 0xffffffff
			ref [116] := 0xffffffff ref [117] := 0xffffffff ref [118] := 0xffffffff ref [119] := 0xffffffff
			ref [120] := 0xffffffff ref [121] := 0xffffffff ref [122] := 0x01ffffff
			ref [124] := 0x00000000 ref [125] := 0x00000000 ref [126] := 0x00000000 ref [127] := 0x00000000
			ref [128] := 0xffffffff ref [129] := 0xffffffff

			create workspace.make_filled (0, 2 * 65 + 2 * 32)
			create item.make_filled (0, 65 + 65)
			kara_mul_n (item, 0, one, 0, two, 0, 65, workspace, 0)
			assert ("Test kara mul n odd", item.same_items (ref, 0, 0, ref.count))
		end

	test_kara_n
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			ref: SPECIAL [NATURAL_32]
			workspace: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			one := big_one
			two := big_two
			create ref.make_filled (0, 128)
			ref [0] := 0x00000001 ref [1] := 0xffffffff ref [2] := 0xffffffff ref [3] := 0xffffffff
			ref [4] := 0xffffffff ref [5] := 0xffffffff ref [6] := 0xffffffff ref [7] := 0xbfffffff
			ref [8] := 0x3fffffff
			ref [36] := 0x00000000 ref [37] := 0x00000000 ref [38] := 0x40000000 ref [39] := 0xc0000000
			ref [40] := 0xffffffff ref [41] := 0xffffffff ref [42] := 0xffffffff ref [43] := 0x0007ffff
			ref [48] := 0x00000000 ref [49] := 0x00000000 ref [50] := 0x00000000 ref [51] := 0xfffe0000
			ref [52] := 0xffffffff ref [53] := 0xffffffff ref [54] := 0xffffffff ref [55] := 0xffffffff
			ref [56] := 0xffffffff ref [57] := 0xfdffffff ref [58] := 0x01ffffff
			ref [60] := 0x00000000 ref [61] := 0x00000000 ref [62] := 0x00000000 ref [63] := 0x00000001
			ref [64] := 0xfffffffd
			ref [68] := 0x00000000 ref [69] := 0x00000000 ref [70] := 0x00000000 ref [71] := 0x40000000
			ref [80] := 0x00000000 ref [81] := 0x00000000 ref [82] := 0x00020000
			ref [100] := 0x00000000 ref [101] := 0xfffff000 ref [102] := 0xbfffffff ref [103] := 0xffffffff
			ref [104] := 0xffffffff ref [105] := 0xffffffff ref [106] := 0x0007ffff ref [107] := 0xfff80000
			ref [108] := 0xffffffff ref [109] := 0xffffffff ref [110] := 0xffffffff ref [111] := 0xffffffff
			ref [112] := 0xffffffff ref [113] := 0xffffffff ref [114] := 0xffffffff ref [115] := 0xffffffff
			ref [116] := 0xffffffff ref [117] := 0xffffffff ref [118] := 0xffffffff ref [119] := 0xffffffff
			ref [120] := 0xffffffff ref [121] := 0x01ffffff
			ref [124] := 0x00000000 ref [125] := 0x00000000 ref [126] := 0x00000000 ref [127] := 0xffffffff

			create workspace.make_filled (0, 2 * 64 + 2 * 32)
			create item.make_filled (0, 64 + 64)
			kara_mul_n (item, 0, one, 0, two, 0, 64, workspace, 0)
			assert ("Test kara mul n", item.same_items (ref, 0, 0, ref.count))
		end
end
