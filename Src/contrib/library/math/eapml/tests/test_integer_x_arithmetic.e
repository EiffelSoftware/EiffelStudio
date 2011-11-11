note
	description: "Summary description for {TEST_INTEGER_ARITHMETIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_ARITHMETIC

inherit
	EQA_TEST_SET
	INTEGER_X_ARITHMETIC
		undefine
			default_create
		end

feature
	test_add_1
			-- Test integer addition cases, ++ +- -+ --, 0 sum
		local
			posone: INTEGER_X
			postwo: INTEGER_X
			negone: INTEGER_X
			negtwo: INTEGER_X
			ans: INTEGER_X
		do
			create posone.make_from_integer (1000)
			create postwo.make_from_integer (2000)
			create negone.make_from_integer (-1000)
			create negtwo.make_from_integer (-2000)
			ans := posone + postwo
			assert ("{INTEGER_X}.add test", ans.to_integer_32 = 1000 + 2000)
			ans := postwo + negone
			assert ("{INTEGER_X}.add test", ans.to_integer_32 = 2000 + -1000)
			ans := negone + postwo
			assert ("{INTEGER_X}.add test", ans.to_integer_32 = -1000 + 2000)
			ans := negone + negtwo
			assert ("{INTEGER_X}.add test", ans.to_integer_32 = -1000 + -2000)
			ans := posone + negone
			assert ("{INTEGER_X}.add test", ans.to_integer_32 = 1000 + -1000)
		end

	test_add_2
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one.make_limbs (6)
			create two.make_from_hex_string ("343bd97a 7e17702a 800c8f10 54ad58f6 1f07c505")
			create three.make_from_hex_string ("ffffffff ffffffff ffffffff ffffffff 7ffffffc")
			create expected.make_from_hex_string ("1343bd97a7e17702a800c8f1054ad58f59f07c501")
			add (one, two, three)
			assert ("test add 2", one ~ expected)
		end

	test_add_3
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("a9993e364706816aba3e25717850c26c9cd0d89d")
			create three.make_from_hex_string ("8913681113524c02ac9b2b8777f53c1feb356bfbc122bf1970d1ccc8fc43f9bb8aec1812ee98e4a2")
			create expected.make_from_hex_string ("8913681113524c02ac9b2b8777f53c1feb356bfc6abbfd4fb7d84e33b6821f2d033cda7f8b69bd3f")
			add (one, two, three)
			assert ("test add 3", one ~ expected)
		end

	test_add_4
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("-7231ea35689f4fd7ce163d502a7e14c99947e909fb2a9d7cad460fb337fae053af6e5a5419a6800c19f28b09a3a1f005621dd631b6d93fcc32e4e6069e76fb15")
			create three.make_from_hex_string ("1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
			create expected.make_from_hex_string ("1ff8dce15ca9760b02831e9c2afd581eb3666b816f604d5628352b9f04cc8051fac5091a5abe6597ff3e60d74f65c5e0ffa9de229ce4926c033cd1b19f9618904ea")
			add (one, two, three)
			assert ("test add 4", one ~ expected)
		end

	test_sub_1
		local
			one_three: INTEGER_X
			two: INTEGER_X
			expected: INTEGER_X
		do
			create one_three.make_from_hex_string ("014fae42 56ad0915 2a7b2b66 fe887b52 e06ffa35 d359cd33 14156137 564096ef 90eb9c01 9ee82ea9")
			create two.make_from_hex_string ("1")
			create expected.make_from_hex_string ("-014fae42 56ad0915 2a7b2b66 fe887b52 e06ffa35 d359cd33 14156137 564096ef 90eb9c01 9ee82ea8")
			sub (one_three, two, one_three)
			assert ("test sub 1", one_three ~ expected)
		end

	test_sub_2
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("1429cb78799228669deb4a9025f308ab78be74ae")
			create three.make_from_hex_string ("-f7c5cdcb7d66c16bbf17e81de30488c02078684")
			create expected.make_from_hex_string ("23a628553168947d59dcc912042351377ac5fb32")
			sub (one, two, three)
			assert ("test sub 2", one ~ expected)
		end

	test_mul_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one.make_limbs (10)
			create two.make_limbs (5)
			create three.make_limbs (6)
			create expected.make_from_hex_string ("30f2de49 bab11556 78be37e5 d4205117 663c6cc5 5fd1e2bd 41b4a8fd 35ce30b2 07939fb8 c29af9f6")
			two.item [0] := 0x9f07c4ff
			two.item [1] := 0xd4ad58f1
			two.item [2] := 0x800c8f0e
			two.item [3] := 0x7e17702a
			two.item [4] := 0x343bd97a
			two.count := 5
			three.item [0] := 0xfb4ab80a
			three.item [1] := 0x2077ac6a
			three.item [2] := 0x5bdd4431
			three.item [3] := 0x6672da8e
			three.item [4] := 0xefe650c5
			three.count := 5
			mul (one, two, three)
			assert ("test mul 1", expected ~ one)
		end

	test_mul_2
		local
			one_three: INTEGER_X
			two: INTEGER_X
			expected: INTEGER_X
		do
			create one_three.make_limbs (6)
			create two.make_limbs (5)
			create expected.make_from_hex_string ("30f2de49 bab11556 78be37e5 d4205117 663c6cc5 5fd1e2bd 41b4a8fd 35ce30b2 07939fb8 c29af9f6")
			two.item [0] := 0x9f07c4ff
			two.item [1] := 0xd4ad58f1
			two.item [2] := 0x800c8f0e
			two.item [3] := 0x7e17702a
			two.item [4] := 0x343bd97a
			two.count := 5
			one_three.item [0] := 0xfb4ab80a
			one_three.item [1] := 0x2077ac6a
			one_three.item [2] := 0x5bdd4431
			one_three.item [3] := 0x6672da8e
			one_three.item [4] := 0xefe650c5
			one_three.count := 5
			mul (one_three, two, one_three)
			assert ("test mul 1", expected ~ one_three)
		end

	test_mul_3
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("-e69e4c55 8d0e2ed0 10128582 48b54fe8 8e87802e c871b791 5347fc54 8fb749de 9bc6e6b7 1868a715 859bcde6 96d6f196 37ad0367 26bc4cea 65f0d20e 67321392")
			create three.make_from_hex_string ("000001ff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff")
			create expected.make_from_hex_string ("-1cd3c98ab1a1c5da020250b04916a9fd11d0f005d90e36f22a68ff8a91f6e93bd378dcd6e30d14e2b0b379bcd2dade32c6f5a06ce4d7899d4cbe1a41cce642723ff1961b3aa72f1d12fefed7a7db74ab01771787fd1378e486eacb803ab7048b62164391948e79758ea7a64321969290e69c852fc98d943b3159a0f2df198cdec6e")
			mul (one, two, three)
			assert ("test mul 3", one ~ expected)
		end

	test_mul_2exp_1
		local
			one: INTEGER_X
			two: INTEGER_X
			expected: INTEGER_X
		do
			create one.make_limbs (7)
			create two.make_from_hex_string ("2 fe13c053 7bbc11ac aa07d793 de4e6d5e 5c94eee8")
			create expected.make_from_hex_string ("0000000b f84f014d eef046b2 a81f5e4f 7939b579 7253bba0")
			mul_2exp (one, two, 2)
			assert ("test mul 2exp 1", one ~ expected)
		end

	test_mul_2exp_2
		local
			one: INTEGER_X
			two: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("8 00000000 00000000 00000000 00000000 00000000")
			create expected.make_from_hex_string ("8 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000")
			mul_2exp (one, two, 0x80)
			assert ("test mul 2exp 2", one ~ expected)
		end
end
