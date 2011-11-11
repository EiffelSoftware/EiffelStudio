note
	description: "Summary description for {TEST_RANDSTRUCT_LC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RANDSTRUCT_LC

inherit
	EQA_TEST_SET
	INTEGER_X_FACILITIES
		undefine
			default_create
		end

feature
	test_randget_1
		local
			struct: LINEAR_CONGRUENTIAL_RNG
			target: SPECIAL [NATURAL_32]
		do
			create struct.make (16)
			create target.make_filled (0, 16)
			struct.randget (target, 0, 16 * 32)
			assert ("test randget 1 1", target [0] = 0x9a13029c and target [1] = 0xa57f74f1 and target [2] = 0x4978d92b and target [3] = 0xfcd3c783)
			assert ("test randget 1 2", target [4] = 0xc6815ba3 and target [5] = 0xd1c1fccc and target [6] = 0xdce6db9b and target [7] = 0xab842185)
			assert ("test randget 1 3", target [8] = 0x7561a561 and target [9] = 0xd97b558c and target [10] = 0x38fe3b9c and target [11] = 0x18105699)
			assert ("test randget 1 4", target [12] = 0x4aa55829 and target [13] = 0xd9eae640 and target [14] = 0xc2e62e2f and target [15] = 0x8157a727)
		end

	test_randget_2
		local
			struct: LINEAR_CONGRUENTIAL_RNG
			target: SPECIAL [NATURAL_32]
		do
			create struct.make (128)
			create target.make_filled (0, 16)
			struct.randget (target, 0, 16 * 32)
			assert ("test randget 2 1", target [0] = 0x42a99a0c and target [1] = 0x71fd8f07 and target [2] = 0x2aaf58a0 and target [3] = 0xaf66ba93)
			assert ("test randget 2 2", target [4] = 0xec6b8425 and target [5] = 0x3507ca60 and target [6] = 0x64c9c175 and target [7] = 0x73cfa3c6)
			assert ("test randget 2 3", target [8] = 0xa8e20278 and target [9] = 0x2cd68b8a and target [10] = 0xa131dec1 and target [11] = 0x53ea074c)
			assert ("test randget 2 4", target [12] = 0x47581f73 and target [13] = 0xa53cc0eb and target [14] = 0x343532f8 and target [15] = 0x3cf5ac8c)
		end

	test_randget_3
		local
			struct: LINEAR_CONGRUENTIAL_RNG
			target: SPECIAL [NATURAL_32]
			i: INTEGER
		do
			create struct.make (128)
			create target.make_filled (0, 4)
			from
				i := 0
			until
				i = 1_000
			loop
				struct.randget (target, 0, 4 * 32)
				i := i + 1
			end
			assert ("test randget 3", target [0] = 0x6cb70ec0 and target [1] = 0x7e6c8a80 and target [2] = 0x314b0a1c and target [3] = 0xf4f389af)
		end

	test_randget_4
		local
			one: SPECIAL [NATURAL_32]
			struct: LINEAR_CONGRUENTIAL_RNG
		do
			create one.make_filled (0, 6)
			create struct.make (32)
			struct.randget (one, 0, 0xa1)
			assert ("test randget 4 1", one [0] = 0xbaecd515 and one [1] = 0x13ae8ec6 and one [2] = 0x518c8090 and one [3] = 0x881ca077 and one [4] = 0x870b7134 and one [5] = 0x00000001)
			struct.randget (one, 0, 0xa1)
			assert ("test randget 4 2", one [0] = 0x323a7636 and one [1] = 0xa122cb1a and one [2] = 0x99811941 and one [3] = 0x841fd605 and one [4] = 0xd960a1bf and one [5] = 0x0)
		end

	test_make_1
		local
			struct: LINEAR_CONGRUENTIAL_RNG
		do
			create struct.make (32)
			assert ("test make 1", struct.seed.seed.capacity = 2)
		end
end
