note
	description: "Summary description for {TEST_NUMBER_GCD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SPECIAL_GCD

inherit
	EQA_TEST_SET
	SPECIAL_GCD
		undefine
			default_create
		end

feature
	test_basic_gcd_1
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			res: INTEGER_32
		do
			create one_two.make_filled (0, 5)
			create three.make_filled (0, 5)
			one_two [0] := 0x7fffffff
			one_two [1] := 0xffffffff
			one_two [2] := 0xffffffff
			one_two [3] := 0xffffffff
			one_two [4] := 0xffffffff
			three [0] := 0xbd62fd99
			three [1] := 0x0211a89b
			three [2] := 0xacee6489
			three [3] := 0x98b44a3e
			three [4] := 0x11d3142a
			res := basic_gcd (one_two, 0, one_two, 0, 5, three, 0, 5)
			assert ("test basic gcd_1", one_two [0] = 0x00000001 and one_two [1] = 0x00000000 and one_two [2] = 0xffffffff and one_two [3] = 0xffffffff and one_two [4] = 0xffffffff and res = 1)
		end

	test_basic_gcd_2
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x6141c975
			three [1] := 0x22ddfba5
			three [2] := 0xa09fab66
			three [3] := 0x000075bd
			val := basic_gcd (one_two, 0, one_two, 0, 4, three, 0, 4)
			assert ("test basic gcd 2", one_two [0] = 0x1 and val = 1)
		end

	test_basic_gcd_3
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x0be1f345
			three [1] := 0x0943df37
			three [2] := 0x0565ad11
			three [3] := 0x00001f3e
			val := basic_gcd (one_two, 0, one_two, 0, 4, three, 0, 4)
			assert ("test basic gcd 3", one_two [0] = 0x1 and val = 1)
		end

	test_basic_gcd_4
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x8bb4ea3d
			three [1] := 0x1f8bcda9
			three [2] := 0x25f7d40e
			three [3] := 0x00002e40
			val := basic_gcd (one_two, 0, one_two, 0, 4, three, 0, 4)
			assert ("test basic gcd 4", one_two [0] = 0x1 and val = 1)
		end

	test_basic_gcd_5
		local
			one_three: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_three.make_filled (0, 17)
			create two.make_filled (0, 17)
			two [0] := 0xd96a4395
			two [1] := 0xd77d6bb5
			two [2] := 0xff132ed5
			two [3] := 0xeca1c0e4
			two [4] := 0xb6df6c57
			two [5] := 0xfeb6912f
			two [6] := 0xafb643b9
			two [7] := 0xc05dd8ec
			two [8] := 0x12c61699
			two [9] := 0xd44be35a
			two [10] := 0xb675f7ea
			two [11] := 0x2ffd5545
			two [12] := 0xab960e36
			two [13] := 0xfd9a1223
			two [14] := 0xc5d32145
			two [15] := 0xb369d437
			two [16] := 0x000001ff
			one_three [0] := 0xffffffff
			one_three [1] := 0xffffffff
			one_three [2] := 0xffffffff
			one_three [3] := 0xffffffff
			one_three [4] := 0xffffffff
			one_three [5] := 0xffffffff
			one_three [6] := 0xffffffff
			one_three [7] := 0xffffffff
			one_three [8] := 0xffffffff
			one_three [9] := 0xffffffff
			one_three [10] := 0xffffffff
			one_three [11] := 0xffffffff
			one_three [12] := 0xffffffff
			one_three [13] := 0xffffffff
			one_three [14] := 0xffffffff
			one_three [15] := 0xffffffff
			one_three [16] := 0x000001ff
			val := basic_gcd (one_three, 0, two, 0, 17, one_three, 0, 17)
			assert ("test basic gcd 5", one_three [0] = 0x1 and val = 1)
		end

	test_div2_1
		local
			r0: CELL [NATURAL_32]
			r1: CELL [NATURAL_32]
			val: NATURAL_32
		do
			create r0.put (0)
			create r1.put (0)
			val := div2 (r0, r1, 0x55bf739f, 0xc3945435, 0x0fff167f, 0xf3e8e754)
			assert ("test div2 1", r0.item = 0x0007cf91 and r1.item = 0x05c40320 and val = 0x5)
		end

	test_div2_2
		local
			r0: CELL [NATURAL_32]
			r1: CELL [NATURAL_32]
			val: NATURAL_32
		do
			create r0.put (0)
			create r1.put (0)
			val := div2 (r0, r1, 0x9d001ff4, 0x08c14be0, 0x1f3e0565, 0xad110943)
			assert ("test div2 2", r0.item = 0xa76c1d91 and r1.item = 0x00ca04f7 and val = 0x5)
		end

	test_find_a
		local
			val: NATURAL_32
		do
			val := find_a (0x68b82f95, 0xc45247ed)
			assert ("test find a", val = 0x52aa2b12)
		end

	test_nhgcd2_1
		local
			five: SPECIAL [NATURAL_32]
			val: BOOLEAN
		do
			create five.make_filled (0, 4)
			val := nhgcd2 (0xdb7c2abf, 0x62e35e66, 0x75bda09f, 0xab6622dd, five)
			assert ("test nhgcd2 1", val and five [0] = 0x02c85433 and five [1] = 0x0c43d237 and five [2] = 0x017e1f50 and five [3] = 0x0694540b)
		end

	test_nhgcd2_2
		local
			five: SPECIAL [NATURAL_32]
			val: BOOLEAN
		do
			create five.make_filled (0, 4)
			val := nhgcd2 (0xdb7c2abf, 0x62e35e66, 0x1f3e0565, 0xad110943, five)
			assert ("test nhgcd2 2", val and five [0] = 0x15d545dd and five [1] = 0x088e653f and five [2] = 0x031b98c4 and five [3] = 0x0137c9e1)
		end

	test_nhgcd2_3
		local
			five: SPECIAL [NATURAL_32]
			val: BOOLEAN
		do
			create five.make_filled (0, 4)
			val := nhgcd2 (0xdb7c2abf, 0x62e35e66, 0x2e4025f7, 0xd40e1f8b, five)
			assert ("test nhgcd2 3", val and five [0] = 0x3d89bb6b and five [1] = 0x2b76efa2 and five [2] = 0x0cf7ad20 and five [3] = 0x0928b403)
		end

	test_nhgcd2_4
		local
			five: SPECIAL [NATURAL_32]
			val: BOOLEAN
		do
			create five.make_filled (0, 4)
			val := nhgcd2 (0xdb7c2abf, 0x62e35e66, 0x0905a1c3, 0xf4cec73b, five)
			assert ("test nhgcd2 4", val and five [0] = 0x411e611d and five [1] = 0x05ebcf53 and five [2] = 0x02ad3db7 and five [3] = 0x003e4ece)
		end

	test_ngcd_lehmer_1
		local
			one_three: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			four: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_three.make_filled (0, 7)
			one_three [0] := 0x05fadced
			one_three [1] := 0x01251177
			one_three [2] := 0x17eb73b4
			one_three [3] := 0x049445dc
			create two.make_filled (0, 5)
			two [0] := 0x236dc147
			two [1] := 0x0071f142
			two [2] := 0xffffffff
			two [3] := 0xffffffff
			two [4] := 0xffffffff
			create four.make_filled (0, 6)
			four [0] := 0x236dc147
			four [1] := 0x0071f142
			four [2] := 0x530b1a98
			four [3] := 0xbe9c1686
			four [4] := 0x9ecb20bd
			four [5] := 0x000000df
			val := ngcd_lehmer (one_three, 0, two, 0, one_three, 0, 2, four, 0)
			assert ("test ngcd lehmer 1", one_three [0] = 0x1 and val = 1)
		end

	test_ngcd_lehmer_2
		local
			one_three: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			four: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_three.make_filled (0, 4)
			create two.make_filled (0, 4)
			create four.make_filled (0, 8)
			one_three [0] := 0x6141c975
			one_three [1] := 0x22ddfba5
			one_three [2] := 0xa09fab66
			one_three [3] := 0x000075bd
			two [0] := 0xbead208b
			two [1] := 0x5e668076
			two [2] := 0x2abf62e3
			two [3] := 0x0000db7c
			val := ngcd_lehmer (one_three, 0, two, 0, one_three, 0, 4, four, 0)
			assert ("test ngcd lehmer 2", one_three [0] = 0x1 and val = 1)
		end

	test_ngcd_lehmer_3
		local
			one_three: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			four: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create two.make_filled (0, 4)
			create one_three.make_filled (0, 4)
			create four.make_filled (0, 8)
			two [0] := 0xbead208b
			two [1] := 0x5e668076
			two [2] := 0x2abf62e3
			two [3] := 0x0000db7c
			one_three [0] := 0x0be1f345
			one_three [1] := 0x0943df37
			one_three [2] := 0x0565ad11
			one_three [3] := 0x00001f3e
			val := ngcd_lehmer (one_three, 0, two, 0, one_three, 0, 4, four, 0)
			assert ("test ngcd lehmer 3", one_three [0] = 0x1 and val = 1)
		end

	test_ngcd_lehmer_4
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			four: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			create four.make_filled (0, 8)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x8bb4ea3d
			three [1] := 0x1f8bcda9
			three [2] := 0x25f7d40e
			three [3] := 0x00002e40
			val := ngcd_lehmer (one_two, 0, one_two, 0, three, 0, 4, four, 0)
			assert ("test ngcd lehmer 4", one_two [0] = 0x1 and val = 1)
		end

	test_gcd_2_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one.make_filled (0, 2)
			create two.make_filled (0, 2)
			one [0] := 0x236dc147
			one [1] := 0x0071f142
			two [0] := 0x05fadced
			two [1] := 0x01251177
			val := gcd_2 (one, 0, two, 0)
			assert ("test gcd 2", val = 1 and one [0] = 0x1 and one [1] = 0x0)
		end

	test_gcd_1_1
		local
			one: SPECIAL [NATURAL_32]
			val: NATURAL_32
		do
			create one.make_filled (0, 2)
			one [0] := 0x302ccd43
			one [1] := 0x0
			val := gcd_1 (one, 0, 1, 0xccd079fe)
			assert ("test gcd 1 1", val = 0x1)
		end

	test_gcd_1
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x6141c975
			three [1] := 0x22ddfba5
			three [2] := 0xa09fab66
			three [3] := 0x000075bd
			val := gcd (one_two, 0, one_two, 0, 4, three, 0, 4)
			assert ("test gcd 1", one_two [0] = 0x1 and one_two [1] = 0x0 and one_two [2] = 0x0 and one_two [3] = 0x0 and val = 1)
		end

	test_gcd_2
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x0be1f345
			three [1] := 0x0943df37
			three [2] := 0x0565ad11
			three [3] := 0x00001f3e
			val := gcd (one_two, 0, one_two, 0, 4, three, 0, 4)
			assert ("test gcd 2", one_two [0] = 0x1 and val = 1)
		end

	test_gcd_3
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_two.make_filled (0, 4)
			create three.make_filled (0, 4)
			one_two [0] := 0xbead208b
			one_two [1] := 0x5e668076
			one_two [2] := 0x2abf62e3
			one_two [3] := 0x0000db7c
			three [0] := 0x8bb4ea3d
			three [1] := 0x1f8bcda9
			three [2] := 0x25f7d40e
			three [3] := 0x00002e40
			val := gcd (one_two, 0, one_two, 0, 4, three, 0, 4)
			assert ("test gcd 3", one_two [0] = 0x1 and val = 1)
		end

	test_gcd_4
		local
			one_three: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one_three.make_filled (0, 17)
			create two.make_filled (0, 17)
			two [0] := 0xd96a4395
			two [1] := 0xd77d6bb5
			two [2] := 0xff132ed5
			two [3] := 0xeca1c0e4
			two [4] := 0xb6df6c57
			two [5] := 0xfeb6912f
			two [6] := 0xafb643b9
			two [7] := 0xc05dd8ec
			two [8] := 0x12c61699
			two [9] := 0xd44be35a
			two [10] := 0xb675f7ea
			two [11] := 0x2ffd5545
			two [12] := 0xab960e36
			two [13] := 0xfd9a1223
			two [14] := 0xc5d32145
			two [15] := 0xb369d437
			two [16] := 0x000001ff
			one_three [0] := 0xffffffff
			one_three [1] := 0xffffffff
			one_three [2] := 0xffffffff
			one_three [3] := 0xffffffff
			one_three [4] := 0xffffffff
			one_three [5] := 0xffffffff
			one_three [6] := 0xffffffff
			one_three [7] := 0xffffffff
			one_three [8] := 0xffffffff
			one_three [9] := 0xffffffff
			one_three [10] := 0xffffffff
			one_three [11] := 0xffffffff
			one_three [12] := 0xffffffff
			one_three [13] := 0xffffffff
			one_three [14] := 0xffffffff
			one_three [15] := 0xffffffff
			one_three [16] := 0x000001ff
			val := gcd (one_three, 0, two, 0, 17, one_three, 0, 17)
			assert ("test gcd 4", one_three [0] = 0x1 and val = 1)
		end
end
