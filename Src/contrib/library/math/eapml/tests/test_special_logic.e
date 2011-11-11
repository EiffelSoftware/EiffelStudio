note
	description: "Summary description for {TEST_NUMBER_LOGIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SPECIAL_LOGIC

inherit
	EQA_TEST_SET
	SPECIAL_LOGIC
		undefine
			default_create
		end

feature
	test_lshift_1
		local
			one: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			lshift (item, 0, one, 0, 4, 8, carry)
			assert ("Test lshift 1", item [0] = 0xffffff00 and item [1] = 0xffffffff and item [2] = 0xffffffff and item [3] = 0xffffffff and carry.item = 0xff)
		end

	test_bit_xor_lshift_1
			-- Test if bit_xor_lshift copies lower limbs of op1 when entire limbs of 0 are shifted in to op2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 6)
			create two.make_filled (0x66666666, 6)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 6, three, 0, 4, 37)
			assert ("test bit xor lshift 1", one [0] = 0x66666666)
		end

	test_bit_xor_lshift_2
			-- Test if bit_xor_lshift xors the lower partial part of op2 e.g. the first lower 27 bits in this case
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 6)
			create two.make_filled (0x66666666, 6)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 6, three, 0, 4, 37)
			assert ("test bit xor lshift 2", one [0] = 0x66666666 and one [1] = 0x33333326)
		end

	test_bit_xor_lshift_3
			-- Test if bit_xor_lshift xors all limbs when there are enough from both op1 and op2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 6)
			create two.make_filled (0x66666666, 6)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 6, three, 0, 4, 37)
			assert ("test bit xor lshift 3", one [0] = 0x66666666 and one [1] = 0x33333326 and one [2] = 0x33333333 and one [3] = 0x33333333 and one [4] = 0x33333333)
		end

	test_bit_xor_lshift_4
			-- Test if bit_xor_lshift xors the last part of the upper partial part of op2 e.g. the upper 5 bits in this case
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 6)
			create two.make_filled (0x66666666, 6)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 6, three, 0, 4, 37)
			assert ("test bit xor lshift 4", one [0] = 0x66666666 and one [1] = 0x33333326 and one [2] = 0x33333333 and one [3] = 0x33333333 and one [4] = 0x33333333 and one [5] = 0x66666673)
		end

	test_bit_xor_lshift_5
			-- Test if bit_xor_lshift copies all extra limbs after op2 contents is exhausted
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 8)
			create two.make_filled (0x66666666, 7)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 7, three, 0, 4, 37)
			assert ("test bit xor lshift 5", one [0] = 0x66666666 and one [1] = 0x33333326 and one [2] = 0x33333333 and one [3] = 0x33333333 and one [4] = 0x33333333 and one [5] = 0x66666673 and one [6] = 0x66666666)
		end

	test_bit_xor_lshift_6
			-- Test if bit_xor_lshift handles when op1 runs out of data before op2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 8)
			create two.make_filled (0x66666666, 4)
			create three.make_filled (0xaaaaaaaa, 6)
			bit_xor_lshift (one, 0, two, 0, 4, three, 0, 6, 37)
			assert ("test bit xor lshift 6", one [0] = 0x66666666 and one [1] = 0x33333326 and one [2] = 0x33333333 and one [3] = 0x33333333)
		end

	test_bit_xor_lshift_7
			-- Test if bit_xor_lshift handles the shifted tail of op2 after op1 is consumed
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 8)
			create two.make_filled (0x66666666, 4)
			create three.make_filled (0xaaaaaaaa, 6)
			bit_xor_lshift (one, 0, two, 0, 4, three, 0, 6, 37)
			assert ("test bit xor lshift 7", one [0] = 0x66666666 and one [1] = 0x33333326 and one [2] = 0x33333333 and one [3] = 0x33333333 and one [4] = 0x55555555 and one [5] = 0x55555555 and one [6] = 0x55555555 and one [7] = 0x15)
		end

	test_bit_xor_lshift_8
			-- Test when op1 and op2 are exhausted at the same time
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 8)
			create two.make_filled (0x66666666, 5)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 5, three, 0, 4, 37)
			assert ("test bit xor lshift 8", one [0] = 0x66666666 and one [1] = 0x33333326 and one [2] = 0x33333333 and one [3] = 0x33333333 and one [4] = 0x33333333 and one [5] = 0x15)
		end

	test_bit_xor_lshift_9
			-- Test a normal xor
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 8)
			create two.make_filled (0x66666666, 4)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 4, three, 0, 4, 0)
			assert ("test bit xor lshift 9", one [0] = 0xcccccccc and one [1] = 0xcccccccc and one [2] = 0xcccccccc and one [3] = 0xcccccccc and one [4] = 0x0)
		end

	test_bit_xor_lshift_10
			-- Test a tight fit xor
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 3)
			create two.make_filled (0x66666666, 3)
			create three.make_filled (0xaaaaaaaa, 2)
			bit_xor_lshift (one, 0, two, 0, 3, three, 0, 2, 22)
			assert ("test bit xor lshift 10", one [0] = 0xcce66666 and one [1] = 0xcccccccc and one [2] = 0x664ccccc)
		end

	test_bit_xor_lshift_11
			-- Test a tight fit xor
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 4)
			create two.make_filled (0x66666666, 4)
			create three.make_filled (0xaaaaaaaa, 2)
			bit_xor_lshift (one, 0, two, 0, 4, three, 0, 2, 22)
			assert ("test bit xor lshift 11", one [0] = 0xcce66666 and one [1] = 0xcccccccc and one [2] = 0x664ccccc and one [3] = 0x66666666)
		end

	test_bit_xor_lshift_12
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 8)
			create two.make_filled (0x66666666, 4)
			create three.make_filled (0xaaaaaaaa, 4)
			bit_xor_lshift (one, 0, two, 0, 4, three, 0, 4, 1)
			assert ("test bit xor lshift 12", one [0] = 0x33333332 and one [1] = 0x33333333 and one [2] = 0x33333333 and one [3] = 0x33333333 and one [4] = 0x1)
		end

	test_bit_xor_lshift_13
			-- Test a normal xor
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 8)
			create two.make_filled (0x66666666, 4)
			create three.make_filled (0x0, 4)
			three [0] := 0x12345678
			three [1] := 0xfedcba98
			three [2] := 0x13579bdf
			three [3] := 0x2468ace0
			bit_xor_lshift (one, 0, two, 0, 4, three, 0, 4, 0)
			assert ("test bit xor lshift 13", one [0] = 0x7452301e and one [1] = 0x98badcfe and one [2] = 0x7531fdb9 and one [3] = 0x420eca86)
		end

	test_bit_xor_lshift_14
			-- Test xor with op1 as a zero size operand
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 8)
			create two.make_filled (0x0, 0)
			create three.make_filled (0x0, 4)
			three [0] := 0x12345678
			three [1] := 0xfedcba98
			three [2] := 0x13579bdf
			three [3] := 0x2468ace0
			bit_xor_lshift (one, 0, two, 0, 0, three, 0, 4, 0)
			assert ("test bit xor lshift 14", one [0] = 0x12345678 and one [1] = 0xfedcba98 and one [2] = 0x13579bdf and one [3] = 0x2468ace0)
		end

	test_bit_xor_lshift_15
		local
			one_two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
		do
			create one_two.make_filled (0, 5)
			create three.make_filled (0x0, 4)
			one_two [0] := 0x201
			one_two [1] := 0x0
			one_two [2] := 0x0
			one_two [3] := 0x20000
			three [0] := 0x3562c10f
			three [1] := 0xab1407d7
			three [2] := 0x616f35f4
			three [3] := 0x9d73
			bit_xor_lshift (one_two, 0, one_two, 0, 4, three, 0, 4, 2)
			assert ("test bit xor lshift 15", one_two [0] = 0xd58b063d and one_two [1] = 0xac501f5c and one_two [2] = 0x85bcd7d2 and one_two [3] = 0x75cd)
		end
end
