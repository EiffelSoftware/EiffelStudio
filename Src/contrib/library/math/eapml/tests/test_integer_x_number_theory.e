note
	description: "Summary description for {TEST_INTEGER_X_NUMBER_THEORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_NUMBER_THEORY

inherit
	EQA_TEST_SET
	INTEGER_X_NUMBER_THEORY
		undefine
			default_create
		end

feature
	test_invert_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
			has: BOOLEAN
		do
			create one
			create two.make_from_hex_string ("474c50aa 62d128fa b3b99224 0846a26e f58bf664")
			create three.make_from_hex_string ("ffffffff ffffffff ffffffff ffffffff 7fffffff")
			create expected.make_from_hex_string ("fb4ab80a 2077ac6a 5bdd4431 6672da8e efe650c5")
			has := invert (one, two, three)
			assert ("test invert 1", has and one ~ expected)
		end

	test_invert_2
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
			has: BOOLEAN
		do
			create one
			create two.make_from_hex_string ("51875f78 fcf4ae64 66099f92 3707f601")
			create three.make_from_hex_string ("fffffffd ffffffff ffffffff ffffffff")
			create expected.make_from_hex_string ("86043be0 479c80d7 d8181a73 7e4b676a")
			has := invert (one, two, three)
			assert ("test invert 2", has and one ~ expected)
		end

	test_invert_3
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
			has: BOOLEAN
		do
			create one
			create two.make_from_hex_string ("4aa462dfb47b5da4294b5351ba91eaa46e808bc8052e951c4f2508a87b96ef400b15f688d8e16b449bf3247ffcddb250b39605a9c31de7167167504b440f14bc")
			create three.make_from_hex_string ("1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
			create expected.make_from_hex_string ("1ff8dce15ca9760b02831e9c2afd581eb3666b816f604d5628352b9f04cc8051fac5091a5abe6597ff3e60d74f65c5e0ffa9de229ce4926c033cd1b19f9618904ea")
			has := invert (one, two, three)
			assert ("test invert 3", has and one ~ expected)
		end

	test_invert_4
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			four: INTEGER_X
			has: BOOLEAN
			i: INTEGER
			one_constant: INTEGER_X
		do
			create one
			create three.make_from_string ("35742549198872617291353508656626642567")
			create one_constant.make_from_integer (1)
			from
				i := 0
			until
				i > 1000
			loop
				create two.make_random_max (three)
				has := invert (one, two, three)
				four := one * two \\ three
				assert ("test invert 4 iteration: " + i.out, has and four ~ one_constant)
				i := i + 1
			end
		end

	test_invert_5
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
			has: BOOLEAN
		do
			create one
			create two.make_from_hex_string ("3a4085c123535aa7ad14d55c0b3765c55c5b78b946517c14438ad876ec0f7ac22792988bb6cd7837aa64334eb5f7c668d570cbf8134b7f7e87eefa95179ca11bedcdf420eb6df91")
			create three.make_from_hex_string ("3ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe661ce18ff55987308059b186823851ec7dd9ca1161de93d5174d66e8382e9bb2fe84e47")
			create expected.make_from_hex_string ("14f365462bac9e4b1fd955049cd7320d0d4ce2cec67d60ee2011ec10879cdb60f61ec86bda440358278bb5592cce8bfddee8c57c1565cf47eb89854ecd76f341bf19bf326671aa1")
			has := invert (one, two, three)
			assert ("test invert 5", has and one ~ expected)
		end

	test_probably_prime_1
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_integer (11)
			val := probab_prime_p (one, 10)
			assert ("test probably prime 1", val = 2)
		end

	test_probably_prime_2
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_integer (2_147_483_647)
			val := probab_prime_p (one, 10)
			assert ("test probably prime 2", val = 1)
		end

	test_probably_prime_3
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("2 305 843 009 213 693 951")
			val := probab_prime_p (one, 10)
			assert ("test probably prime 3", val = 1)
		end

	test_probably_prime_4
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("59 604 644 783 353 249")
			val := probab_prime_p (one, 10)
			assert ("test probably prime 4", val = 1)
		end

	test_probably_prime_5
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("43 143 988 327 398 957 279 342 419 750 374 600 193")
			val := probab_prime_p (one, 10)
			assert ("test probably prime 5", val = 1)
		end

	test_probably_prime_6
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("2074722246773485207821695222107608587480996474721117292752992589912196684750549658310084416732550077")
			val := probab_prime_p (one, 10)
			assert ("test probably prime 6", val = 1)
		end

	test_probably_prime_7
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("236749577021714299526482794866680 9 233066409497699870112003149352380375124855230068487109373226251983")
			val := probab_prime_p (one, 10)
			assert ("test probably prime 7", val = 1)
		end

	test_probably_prime_8
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("236749577021714299526482794866680 8 233066409497699870112003149352380375124855230068487109373226251983")
			val := probab_prime_p (one, 10)
			assert ("test probably prime 7", val = 0)
		end

	test_gcdext_1
		local
			one: INTEGER_X
			two: INTEGER_X
			four: INTEGER_X
			five: INTEGER_X
			expected_1: INTEGER_X
			expected_2: INTEGER_X
		do
			create one.make_limbs (6)
			create two.make_limbs (6)
			create four.make_from_hex_string ("474c50aa 62d128fa b3b99224 0846a26e f58bf664")
			create five.make_from_hex_string ("ffffffff ffffffff ffffffff ffffffff 7fffffff")
			create expected_1.make_from_integer (1)
			create expected_2.make_from_hex_string ("-00000000 04b547f5 df885395 a422bbce 998d2570 9019af3a")
			gcdext (one, two, void, four, five)
			assert ("test gcdext 1", one ~ expected_1 and two ~ expected_2)
		end

	test_millerrabin_1
		local
			one: INTEGER_X
			val: INTEGER
		do
			create one.make_from_string ("2 305 843 009 213 693 951")
			val := millerrabin (one, 10)
			assert ("test probably prime 3", val = 1)
		end

	test_powm_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			four: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_integer (0xd2)
			create three.make_from_integer (0x7ffffffe)
			create four.make_from_integer (0x7fffffff)
			create expected.make_from_integer (1)
			powm (one, two, three, four)
			assert ("test powm 1", one ~ expected)
		end

	test_powm_2
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			four: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_integer (0xd2)
			create three.make_from_hex_string ("1ffffff ffffffffe")
			create four.make_from_hex_string ("1fffffff ffffffff")
			create expected.make_from_integer (0x1)
			powm (one, two, three, four)
			assert ("test powm 2", one ~ expected)
		end

	test_probably_prime_isprime_1
		local
			val: BOOLEAN
		do
			val := probab_prime_isprime (0x25)
			assert ("test probably_prime_isprime 1", val)
		end

	test_probably_prime_isprime_2
		local
			val: BOOLEAN
		do
			val := probab_prime_isprime (0x31)
			assert ("test probably_prime_isprime 2", not val)
		end
end
