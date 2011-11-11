note
	description: "Summary description for {TEST_NUMBER_DIVISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SPECIAL_DIVISION

inherit
	EQA_TEST_SET
	EXCEPTION_MANAGER
		undefine
			default_create
		end
	SPECIAL_DIVISION
		undefine
			default_create
		end

feature
	test_tdiv_qr_div_0
		local
			divide_zero_exception: TUPLE [divide_zero_exception: BOOLEAN]
		do
			create divide_zero_exception
			divide_func (divide_zero_exception)
			assert ("test tdiv qr div 0", divide_zero_exception.divide_zero_exception)
		end

	divide_func (divide_zero_exception: TUPLE [divide_zero_exception: BOOLEAN])
		local
			retried: BOOLEAN
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
		do
			if not retried then
				create item.make_filled (0, 1)
				create one.make_filled (0, 1)
				create two.make_filled (0, 1)
				create three.make_filled (0, 1)
				tdiv_qr (item, 0, one, 0, two, 0, 1, three, 0, 0)
			end
		rescue
			retried := True
			if attached {DIVIDE_BY_ZERO} last_exception then
				divide_zero_exception.divide_zero_exception := True
			end
			retry
		end

	test_tdiv_qr_div_1_1
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0xffffffff, 4)
			create denominator.make_filled (0x77777777, 1)
			create quotient.make_filled (0, 4)
			create remainder.make_filled (0, 1)
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 1)
			assert ("tdiv qr div 1 1", quotient [0] = 0x00000002 and quotient [1] = 0xb6db6db9 and quotient [2] = 0x24924926 and quotient [3] = 0x00000002 and remainder [0] = 0x11111111)
		end

	test_tdiv_qr_div_2_1
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0xffffffff, 4)
			create denominator.make_filled (0x77777777, 2)
			create quotient.make_filled (0, 4)
			create remainder.make_filled (0, 2)
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 2)
			assert ("test tdiv qr div 2 1 quotient", quotient [0] = 0x92492494 and quotient [1] = 0x24924924 and quotient [2] = 0x00000002 and quotient [3] = 0x0)
			assert ("test tdiv qr div 2 1 remainder", remainder [0] = 0x33333333 and remainder [1] = 0x33333333)
		end

	test_tdiv_qr_div_big_1
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0xffffffff, 4)
			create denominator.make_filled (0x77777777, 3)
			create quotient.make_filled (0, 4)
			create remainder.make_filled (0, 3)
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 3)
			assert ("test tdiv qr div big 1 quotient", quotient [0] = 0x24924924 and quotient [1] = 0x00000002 and quotient [2] = 0x0 and quotient [3] = 0x0)
			assert ("test tdiv qr div big 1 remainder", remainder [0] = 0x44444443 and remainder [1] = 0x44444445 and remainder [2] = 0x44444444)
		end

	test_tdiv_qr_div_big_2
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0xffffffff, 4)
			create denominator.make_filled (0x77777777, 4)
			create quotient.make_filled (0, 4)
			create remainder.make_filled (0, 4)
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 4)
			assert ("test tdiv qr div big 2 quotient", quotient [0] = 0x000000002 and quotient [1] = 0x00000000 and quotient [2] = 0x00000000 and quotient [3] = 0x00000000)
			assert ("test tdiv qr div big 2 remainder", remainder [0] = 0x11111111 and remainder [1] = 0x11111111 and remainder [2] = 0x11111111 and remainder [3] = 0x11111111)
		end

	test_tdiv_qr_div_big_3
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0xffffffff, 4)
			create denominator.make_filled (0x77777777, 4)
			create quotient.make_filled (0x0, 4)
			create remainder.make_filled (0x0, 4)
			numerator [3] := 0
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 4)
			assert ("test tdiv qr div big 3 quotient", quotient [0] = 0x00000000 and quotient [1] = 0x00000000 and quotient [2] = 0x00000000)
			assert ("test tdiv qr div big 3 remainder", remainder [0] = 0xffffffff and remainder [1] = 0xffffffff and remainder [2] = 0xffffffff and remainder [3] = 0x0)
		end

	test_tdiv_qr_div_big_4
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0x80000000, 4)
			create denominator.make_filled (0x80000000, 4)
			create quotient.make_filled (0, 4)
			create remainder.make_filled (0, 4)
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 4)
			assert ("test tdiv qr div big 4 quotient", quotient [0] = 0x1 and quotient [1] = 0x0 and quotient [2] = 0x0 and quotient [3] = 0x0)
			assert ("test tdiv qr div big 4 remainder", remainder [0] = 0x0 and remainder [1] = 0x0 and remainder [2] = 0x0 and remainder [3] = 0x0)
		end

	test_tdiv_qr_div_big_5
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			quotient: SPECIAL [NATURAL_32]
			remainder: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0x80000000, 4)
			create denominator.make_filled (0x80000000, 4)
			create quotient.make_filled (0, 4)
			remainder := numerator
			tdiv_qr (quotient, 0, remainder, 0, numerator, 0, 4, denominator, 0, 4)
			assert ("test tdiv qr div big 4 quotient", quotient [0] = 0x1 and quotient [1] = 0x0 and quotient [2] = 0x0 and quotient [3] = 0x0)
			assert ("test tdiv qr div big 4 remainder", remainder [0] = 0x0 and remainder [1] = 0x0 and remainder [2] = 0x0 and remainder [3] = 0x0)
		end

	test_tdiv_qr_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			four: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 6)
			create two.make_filled (0, 5)
			create three.make_filled (0, 10)
			create four.make_filled (0, 5)
			three [0] := 0x9ee82ea8
			three [1] := 0x90eb9c01
			three [2] := 0x564096ef
			three [3] := 0x14156137
			three [4] := 0xd359cd33
			three [5] := 0xe06ffa35
			three [6] := 0xfe887b52
			three [7] := 0x2a7b2b66
			three [8] := 0x56ad0915
			three [9] := 0x014fae42
			four [0] := 0xf58bf664
			four [1] := 0x0846a26e
			four [2] := 0xb3b99224
			four [3] := 0x62d128fa
			four [4] := 0x474c50aa
			tdiv_qr (one, 0, two, 0, three, 0, 10, four, 0, 5)
			assert ("test tdiv qr 1 1", one [0] = 0x9019af3a and one [1] = 0x998d2570 and one [2] = 0xa422bbce and one [3] = 0xdf885395 and one [4] = 0x04b547f5)
			assert ("test tdiv qr 1 2", two [0] = 0x0 and two [1] = 0x0 and two [2] = 0x0 and two [3] = 0x0 and two [4] = 0x0)
		end

	test_divrem_1_div_1
		local
			one: SPECIAL [NATURAL_32]
			rem: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			rem := divrem_1 (item, 0, one, 0, 4, 1)
			assert ("Test divrem 1 div 1", item.same_items (one, 0, 0, 4) and rem = 0)
		end

	test_divrem_1_div_0
		local
			one: SPECIAL [NATURAL_32]
			rem: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0, 4)
			create item.make_filled (0, 4)
			rem := divrem_1 (item, 0, one, 0, 4, 0x12345678)
			assert ("Test divrem 1 div 0", item.same_items (one, 0, 0, 4) and rem = 0x0)
		end

	test_divrem_1_1
		local
			one: SPECIAL [NATURAL_32]
			rem: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x0, 4)
			one [3] := 0x80000000
			create item.make_filled (0, 4)
			rem := divrem_1 (item, 0, one, 0, 4, 4)
			assert ("Test divrem 1", item [3] = 0x20000000 and item [2] = 0x00000000 and item [1] = 0x00000000 and item [0] = 0x00000000 and rem = 0)
		end

	test_divrem_1_2
		local
			one: SPECIAL [NATURAL_32]
			rem: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0x80000000, 4)
			create item.make_filled (0, 4)
			rem := divrem_1 (item, 0, one, 0, 4, 4)
			assert ("Test divrem 1 2", item [3] = 0x20000000 and item [2] = 0x20000000 and item [1] = 0x20000000 and item [0] = 0x20000000 and rem = 0)
		end

	test_divrem_1_3
		local
			one: SPECIAL [NATURAL_32]
			rem: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			rem := divrem_1 (item, 0, one, 0, 4, 0x12345678)
			assert ("Test divrem 1 3", item [0] = 0x040021bc and item [1] = 0x880003f8 and item [2] = 0x10000077 and item [3] = 0x0000000e and rem = 0x026b07df)
		end

	test_divrem_1_4
		local
			one: SPECIAL [NATURAL_32]
			rem: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			rem := divrem_1 (item, 0, one, 0, 4, 0x87654321)
			assert ("Test divrem 1 4", item [0] = 0x8bcb369f and item [1] = 0x04899bbd and item [2] = 0xe4089ae4 and item [3] = 0x00000001 and rem = 0x65c75880)
		end

	test_divrem_2_1
		local
			one: SPECIAL [NATURAL_32]
			divisor: SPECIAL [NATURAL_32]
			junk: NATURAL_32
			item: SPECIAL [NATURAL_32]
		do
			create one.make_filled (0xffffffff, 4)
			create item.make_filled (0, 4)
			create divisor.make_filled (0x80000000, 2)
			junk := divrem_2 (item, 0, one, 0, 4, divisor, 0)
			assert ("Test divrem 2 1", item [0] = 00000001 and item [1] = 0xfffffffe and item [2] = 0x00000000 and item [3] = 0x00000000 and junk = 0x00000001)
			assert ("Test divrem 2 1", one [0] = 0x7fffffff and one [1] = 0x7fffffff and one [2] = 0xffffffff and one [3] = 0xffffffff)
		end

	test_divrem_2_2
		local
			numerator: SPECIAL [NATURAL_32]
			denominator: SPECIAL [NATURAL_32]
			junk: NATURAL_32
			quotient: SPECIAL [NATURAL_32]
		do
			create numerator.make_filled (0xffffffff, 5)
			numerator [0] := 0xfffffffe
			numerator [4] := 0x00000001
			create denominator.make_filled (0xeeeeeeee, 2)
			create quotient.make_filled (0x0, 5)
			junk := divrem_2 (quotient, 0, numerator, 0, 5, denominator, 0)
			assert ("test divrem 2 2", quotient [0] = 0x92492494 and quotient [1] = 0x24924924 and quotient [2] = 0x00000002 and quotient [3] = 0x0 and quotient [4] = 0x0)
			assert ("test divrem 2 2", numerator [0] = 0x66666666 and numerator [1] = 0x66666666)
		end

	test_limb_inverse_1
		local
			one: NATURAL_32
			res: NATURAL_32
		do
			one := 0x80000000
			res := limb_inverse (one)
			assert ("test limb inverse 1", res = 0xffffffff)
		end

	test_limb_inverse_2
		local
			one: NATURAL_32
			res: NATURAL_32
		do
			one := 0xffffffff
			res := limb_inverse (one)
			assert ("test limb inverse 2", res = 0x00000001)
		end

	test_limb_inverse_3
		local
			one: NATURAL_32
			res: NATURAL_32
		do
			one := 0x91a2b3c0
			res := limb_inverse (one)
			assert ("test limb inverse 3", res = 0xc200000e)
		end

	test_mod_1_1
		local
			one: SPECIAL [NATURAL_32]
			val: CELL [NATURAL_32]
		do
			create val.put (0)
			create one.make_filled (0, 5)
			one [0] := 0x02f36db3
			one [1] := 0x00000009
			one [2] := 0xffffffff
			one [3] := 0xffffffff
			one [4] := 0xffffffff
			mod_1 (one, 0, 2, 0x7b73add3, val)
			assert ("test mod 1 1", val.item = 0x54d134dd)
		end

	test_preinv_divrem_1
		local
			one: SPECIAL [NATURAL_32]
			junk: NATURAL_32
		do
			create one.make_filled (0, 5)
			one [1] := 0x87654321
			one [2] := 0xcccccccc
			one [3] := 0x33333333
			one [4] := 0xffffffff
			junk := preinv_divrem_1 (one, 0, 1, one, 1, 4, 0x3b9aca00, 0x12e0be82, 2)
			assert ("test preinv divrem 1", one [0] = 0xfe8ef428 and one [1] = 0x273df9b7 and one [2] = 0x46093181 and one [3] = 0x4b82fa06 and one [4] = 0x00000004 and junk = 0x1B487000)
		end

	test_preinv_divrem_2
		local
			one: SPECIAL [NATURAL_32]
			junk: NATURAL_32
		do
			create one.make_filled (0, 5)
			one [0] := 0xfe8ef428
			one [1] := 0x273df9b7
			one [2] := 0x46093181
			one [3] := 0x4b82fa06
			one [4] := 0x00000004
			junk := preinv_divrem_1 (one, 0, 1, one, 1, 4, 0x3b9aca00, 0x12e0be82, 2)
			assert ("test preinv divrem 2", one [0] = 0x07fba954 and one [1] = 0x81c6f917 and one [2] = 0x725dd1c3 and one [3] = 0x00000012 and one [4] = 0x00000000 and junk = 0x33DBB800)
		end

	test_preinv_divrem_3
		local
			one: SPECIAL [NATURAL_32]
			junk: NATURAL_32
		do
			create one.make_filled (0, 9)
			one [1] := 0x99811941
			one [2] := 0x841fd605
			one [3] := 0xd960a1bf
			one [4] := 0x5e433efc
			one [5] := 0x48c9bc93
			one [6] := 0x1c8b6fb1
			one [7] := 0x8ca06de0
			one [8] := 0xc6182337
			junk := preinv_divrem_1 (one, 0, 1, one, 1, 8, 0xcfd41b91, 0x3b563c24, 0)
			assert ("test preinv divrem 2", one [0] = 0xb670b6b5 and one [1] = 0xf02cf008 and one [2] = 0x2a9327ab and one [3] = 0x2c16b429 and one [4] = 0x52cd5013 and one [5] = 0x2f45a033 and one [6] = 0x0fc1ade8 and one [7] = 0xf4026dfb and one [8] = 0x00000000 and junk = 0x1DFF6C7B)
		end

	test_sb_divrem_mn_1
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			item: SPECIAL [NATURAL_32]
			junk: NATURAL_32
		do
			create one.make_filled (0xffffffff, 4)
			create two.make_filled (0x80000000, 3)
			create item.make_filled (0, 1)
			junk := sb_divrem_mn (item, 0, one, 0, 4, two, 0, 3)
			assert ("test sb divrem mn 1", item [0] = 0xfffffffe and one [1] = 0x00000000 and one [2] = 0x00000000 and one [3] = 0x7fffffff and junk = 0x1)
		end

	test_sb_divrem_mn_2
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			res: NATURAL_32
		do
			create one.make_filled (0, 5)
			create two.make_filled (0, 9)
			create three.make_filled (0, 4)
			two [4] := 0x348
			three [0] := 0xc50fb804
			three [1] := 0x4da1b404
			three [2] := 0xf47a2e7d
			three [3] := 0x81d4eb6b

			res := sb_divrem_mn (one, 0, two, 0, 8, three, 0, 4)
			assert ("test sb divrem mn 2", one [0] = 0x678 and one [1] = 0x0 and one [2] = 0x0 and one [3] = 0x0 and res = 0x0)
		end

	test_sb_divrem_mn_3
		local
			one: SPECIAL [NATURAL_32]
			two: SPECIAL [NATURAL_32]
			three: SPECIAL [NATURAL_32]
			val: NATURAL_32
		do
			create one.make_filled (0, 6)
			create two.make_filled (0, 10)
			create three.make_filled (0, 5)
			two [0] := 0x3dd05d50
			two [1] := 0x21d73803
			two [2] := 0xac812ddf
			two [3] := 0x282ac26e
			two [4] := 0xa6b39a66
			two [5] := 0xc0dff46b
			two [6] := 0xfd10f6a5
			two [7] := 0x54f656cd
			two [8] := 0xad5a122a
			two [9] := 0x029f5c84
			three [0] := 0xeb17ecc8
			three [1] := 0x108d44dd
			three [2] := 0x67732448
			three [3] := 0xc5a251f5
			three [4] := 0x8e98a154
			val := sb_divrem_mn (one, 0, two, 0, 10, three, 0, 5)
			assert ("test sb divrem mn 3 1", one [0] = 0x9019af3a and one [1] = 0x998d2570 and one [2] = 0xa422bbce and one [3] = 0xdf885395 and one [4] = 0x04b547f5)
			assert ("test sb divrem mn 3 2", two [0] = 0x0 and two [1] = 0x0 and two [2] = 0x0 and two [3] = 0x0 and two [4] = 0x0 and val = 0)
		end
end
