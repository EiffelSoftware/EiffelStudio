note
	description: "Summary description for {TEST_NUMBER_NUMBER_THEORETIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SPECIAL_NUMBER_THEORETIC

inherit
	EQA_TEST_SET
	SPECIAL_NUMBER_THEORETIC
		undefine
			default_create
		end

feature
	test_gcdext_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			cofactor: SPECIAL [NATURAL_32]
			target: SPECIAL [NATURAL_32]
			cofactor_count: TUPLE [cofactor_count: INTEGER]
			junk: INTEGER
		do
			create one.make_filled (0x80000000, 5)
			create two.make_filled (0x80000000, 5)
			one [4] := 0
			one [4] := 0
			create cofactor.make_filled (0, 4)
			create target.make_filled (0, 4)
			create cofactor_count
			junk := gcdext (target, 0, cofactor, 0, cofactor_count, one, 0, 4, two, 0, 4)
			assert ("test gcdext 1 gcd", target [0] = 0x80000000 and target [1] = 0x80000000 and target [2] = 0x80000000 and target [3] = 0x80000000)
			assert ("test gcdext 1 cofactor", cofactor [0] = 0x00000001 and cofactor [1] = 0x00000000 and cofactor [2] = 0x00000000 and cofactor [3] = 0x00000000 and cofactor_count.cofactor_count = 0)
		end

	test_gcdext_2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			cofactor: SPECIAL [NATURAL_32]
			target: SPECIAL [NATURAL_32]
			cofactor_count: TUPLE [cofactor_count: INTEGER]
			junk: INTEGER
		do
			create one.make_filled (0x80000000, 5)
			create two.make_filled (0x20000000, 5)
			one [4] := 0
			two [4] := 0
			create cofactor.make_filled (0, 4)
			create target.make_filled (0, 4)
			create cofactor_count
			junk := gcdext (target, 0, cofactor, 0, cofactor_count, one, 0, 4, two, 0, 4)
			assert ("test gcdext 2 gcd", target [0] = 0x20000000 and target [1] = 0x20000000 and target [2] = 0x20000000 and target [3] = 0x20000000)
			assert ("test gcdext 2 cofactor", cofactor [0] = 0x00000001 and cofactor [1] = 0x00000000 and cofactor [2] = 0x00000000 and cofactor [3] = 0x00000000 and cofactor_count.cofactor_count = 0)
		end

	test_gcdext_3
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: TUPLE [three: INTEGER]
			four: SPECIAL [NATURAL_32]
			six: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one.make_filled (0, 6)
			create two.make_filled (0, 6)
			create three
			create four.make_filled (0, 6)
			create six.make_filled (0, 6)
			four [0] := 0x7fffffff
			four [1] := 0xffffffff
			four [2] := 0xffffffff
			four [3] := 0xffffffff
			four [4] := 0xffffffff
			six [0] := 0xf58bf664
			six [1] := 0x0846a26e
			six [2] := 0xb3b99224
			six [3] := 0x62d128fa
			six [4] := 0x474c50aa
			val := gcdext (one, 0, two, 0, three, four, 0, 5, six, 0, 5)
			assert ("test gcdext 3 1", one [0] = 0x1 and one [1] = 0x0 and one [2] = 0x0 and one [3] = 0x0 and one [4] = 0x0 and one [5] = 0x0)
			assert ("test gcdext 3 2", two [0] = 0xe117d157 and two [1] = 0xfe887b52 and two [2] = 0x2a7b2b66 and two [3] = 0x56ad0915 and two [4] = 0x014fae42 and two [5] = 0x00000000)
			assert ("test gcdext 3 3", three.three = 5 and val = 1)
		end

	test_basic_gcdext_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: TUPLE [three: INTEGER]
			four: SPECIAL [NATURAL_32]
			six: SPECIAL [NATURAL_32]
			val: INTEGER
		do
			create one.make_filled (0, 6)
			create two.make_filled (0, 6)
			create three
			create four.make_filled (0, 6)
			create six.make_filled (0, 6)
			four [0] := 0x7fffffff
			four [1] := 0xffffffff
			four [2] := 0xffffffff
			four [3] := 0xffffffff
			four [4] := 0xffffffff
			six [0] := 0xf58bf664
			six [1] := 0x0846a26e
			six [2] := 0xb3b99224
			six [3] := 0x62d128fa
			six [4] := 0x474c50aa
			val := basic_gcdext (one, 0, two, 0, three, four, 0, 5, six, 0, 5)
			assert ("test basic gcdext 1 1", one [0] = 0x1 and one [1] = 0x0 and one [2] = 0x0 and one [3] = 0x0 and one [4] = 0x0 and one [5] = 0x0)
			assert ("test basic gcdext 1 2", two [0] = 0xe117d157 and two [1] = 0xfe887b52 and two [2] = 0x2a7b2b66 and two [3] = 0x56ad0915 and two [4] = 0x014fae42 and two [5] = 0x00000000)
			assert ("test basic gcdext 1 3", three.three = 5 and val = 1)
		end

	test_gcdext_div2_1
		local
			val: NATURAL_32
		do
			val := gcdext_div2 (0xe9021704, 0x8d4d6a9f, 0x80000000, 0x0)
			assert ("test gcdext div2 1", val = 0x1)
		end

	test_invert_gf_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 4)
			create two.make_filled (0, 4)
			create three.make_filled (0, 4)
			two [0] := 0x3562c10f
			two [1] := 0xab1407d7
			two [2] := 0x616f35f4
			two [3] := 0x9d73
			three [0] := 0x201
			three [3] := 0x20000
			invert_gf (one, 0, two, 0, 4, three, 0, 4)
			assert ("test invert gf 1", one [0] = 0x3e34792c and one [1] = 0xde538519 and one [2] = 0x9cd55090 and one [3] = 0xfa49)
		end
end
