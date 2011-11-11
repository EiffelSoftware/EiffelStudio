note
	description: "Summary description for {TEST_RANDSTRUCT_MT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RANDSTRUCT_MT

inherit
	EQA_TEST_SET

feature
	test_randget_1
		local
			one: MERSENNE_TWISTER_RNG
			target: SPECIAL [NATURAL_32]
		do
			create one.make
			create target.make_filled (0, 16)
			one.randget (target, 0, 16 * 32)
			assert ("test randget 1 1", target [0] = 0x39bca874 and target [1] = 0x58d2754b and target [2] = 0x82902d2f and target [3] = 0x7647f3c3)
			assert ("test randget 1 2", target [4] = 0x680bbdc8 and target [5] = 0x14b9c0e1 and target [6] = 0xd84a873b and target [7] = 0x6580d17d)
			assert ("test randget 1 3", target [8] = 0xbf767863 and target [9] = 0x1eff7e89 and target [10] = 0xaa3dc18b and target [11] = 0x3c0d9fcf)
			assert ("test randget 1 4", target [12] = 0x7a337236 and target [13] = 0xf58174d5 and target [14] = 0x6846aeb6 and target [15] = 0x18f204fe)
		end

	test_randget_2
		local
			one: MERSENNE_TWISTER_RNG
			target: SPECIAL [NATURAL_32]
			i: INTEGER
		do
			create one.make
			create target.make_filled (0, 4)
			from
				i := 0
			until
				i >= 1_000
			loop
				one.randget (target, 0, 4 * 32)
				i := i + 1
			end
			assert ("test randget 2", target [0] = 0x620764dc and target [1] = 0xe1fff273 and target [2] = 0x6a24317d and target [3] = 0x65d87e21)
		end
end
