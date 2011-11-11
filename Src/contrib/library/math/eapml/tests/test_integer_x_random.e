note
	description: "Summary description for {TEST_INTEGER_X_RANDOM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_RANDOM

inherit
	EQA_TEST_SET

	INTEGER_X_RANDOM
		undefine
			default_create
		end

feature
	test_urandomm_1
		local
			one: INTEGER_X
			two: MERSENNE_TWISTER_RNG
			three: INTEGER_X
		do
			create one
			create two.make
			create three.make_from_hex_string ("1000 0000 0000 0000 0000 0000 0000 0000")
			urandomm (one, two, three)
			assert ("test urandomm 1", one.item [0] = 0x39bca874 and one.item [1] = 0x58d2754b and one.item [2] = 0x82902d2f and one.item [3] = 0x0647f3c3)
		end

	test_urandomm_2
		local
			one: INTEGER_X
			two: MERSENNE_TWISTER_RNG
			three: INTEGER_X
			i: INTEGER
		do
			create one
			create two.make
			create three.make_from_hex_string ("1000 0000 0000 0000 0000 0000 0000 0000")
			from
				i := 0
			until
				i = 1000
			loop
				urandomm (one, two, three)
				i := i + 1
			end
			assert ("test urandomm 2", one.item [0] = 0x620764dc and one.item [1] = 0xe1fff273 and one.item [2] = 0x6a24317d and one.item [3] = 0x05d87e21)
		end

	test_urandomm_3
		local
			one: INTEGER_X
			two: MERSENNE_TWISTER_RNG
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make
			create three.make_from_hex_string ("1 00000000 00000000 0001b8fa 16dfab9a ca16b6b3")
			create expected.make_from_hex_string ("72a8d0a2 fd530069 2ab48f9e f732f5c3 fa212b90")
			urandomm (one, two, three)
			assert ("test urandomm 3", one ~ expected)
		end

	test_urandomm_4
		local
			one: INTEGER_X
			two: LINEAR_CONGRUENTIAL_RNG
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make (32)
			create three.make_from_hex_string ("1 00000000 00000000 0001b8fa 16dfab9a ca16b6b3")
			create expected.make_from_hex_string ("d960a1bf 841fd605 99811941 a122cb1a 323a7636")
			urandomm (one, two, three)
			assert ("test urandomm 4", one ~ expected)
		end
end
