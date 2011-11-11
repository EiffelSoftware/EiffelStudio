note
	description: "Summary description for {TEST_EC_BINARY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EC_BINARY

inherit
	EQA_TEST_SET

feature -- Binary math

	test_sec_t_multiply
		local
			d: INTEGER_X
			g: EC_POINT_F2M
			curve: EC_CURVE_F2M
			q: EC_POINT_F2M
			q_x_solution: INTEGER_X
			q_y_solution: INTEGER_X
			q_solution: EC_POINT_F2M
			correct: BOOLEAN
		do
			create d.make_from_hex_string ("00000003 A41434AA 99C2EF40 C8495B2E D9739CB2 155A1E0D")
			create g.make_sec_t163k1
			create curve.make_sec_t163k1
			create q_x_solution.make_from_hex_string ("00000003 7D529FA3 7E42195F 10111127 FFB2BB38 644806BC")
			create q_y_solution.make_from_hex_string ("00000004 47026EEE 8B34157F 3EB51BE5 185D2BE0 249ED776")
			create q_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_F2M}.make (q_x_solution), create {EC_FIELD_ELEMENT_F2M}.make (q_y_solution))
			q := g.product_value (d, curve)
			correct := q ~ q_solution
			assert ("test sec t multiply", correct)
		end

	test_sec_t_sign
		local
			d: INTEGER_X
			k: INTEGER_X
			e: INTEGER_X
			r_x_solution: INTEGER_X
			r_y_solution: INTEGER_X
			r_solution: EC_POINT_F2M
			curve: EC_CURVE_F2M
			r: INTEGER_X
			s: INTEGER_X
			s_solution: INTEGER_X
			r_point: EC_POINT_F2M
			r_int_solution: INTEGER_X
			correct: BOOLEAN
			g: EC_POINT_F2M
		do
			create curve.make_sec_t163k1
			create g.make_sec_t163k1
			create d.make_from_hex_string ("00000003 A41434AA 99C2EF40 C8495B2E D9739CB2 155A1E0D")
			create k.make_from_string ("936523985789236956265265265235675811949404040044")
			create r_x_solution.make_from_hex_string ("00000004 994D2C41 AA30E529 52B0A94E C6511328 C502DA9B")
			create r_y_solution.make_from_hex_string ("00000003 1FC936D7 3163B858 BBC5326D 77C19839 46405264")
			create e.make_from_hex_string ("A9993E36 4706816A BA3E2571 7850C26C 9CD0D89D")
			create r_int_solution.make_from_hex_string ("994D2C41 AA30E529 52AEA846 2370471B 2B0A34AC")
			create s_solution.make_from_hex_string ("00000001 52F95CA1 5DA1997A 8C449E00 CD2AA2AC CB988D7F")
			create r_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_F2M}.make (r_x_solution), create {EC_FIELD_ELEMENT_F2M}.make (r_y_solution))
			r_point := g.product_value (k, curve)
			correct := r_point ~ r_solution
			assert ("test set t sign 1", correct)
			r := r_point.x.x \\ curve.n
			correct := r_int_solution ~ r
			assert ("test set t sign 2", correct)
			s := (k.inverse_value (curve.n) * (r * d + e)) \\ curve.n
			correct := s ~ s_solution
			assert ("test set t sign 3", correct)
		end

	test_sec_t_verify
		local
			q: EC_POINT_F2M
			d: INTEGER_X
			curve: EC_CURVE_F2M
			e: INTEGER_X
			r: INTEGER_X
			s: INTEGER_X
			u1: INTEGER_X
			u2: INTEGER_X
			u1_solution: INTEGER_X
			u2_solution: INTEGER_X
			correct: BOOLEAN
			u1g: EC_POINT_F2M
			u1g_solution: EC_POINT_F2M
			u1g_x: INTEGER_X
			u1g_y: INTEGER_X
			u2q: EC_POINT_F2M
			u2q_solution: EC_POINT_F2M
			u2q_x: INTEGER_X
			u2q_y: INTEGER_X
			r_x: INTEGER_X
			r_y: INTEGER_X
			r_solution: EC_POINT_F2M
			r_point: EC_POINT_F2M
			g: EC_POINT_F2M
			v: INTEGER_X
		do
			create curve.make_sec_t163k1
			create d.make_from_hex_string ("00000003 A41434AA 99C2EF40 C8495B2E D9739CB2 155A1E0D")
			create r.make_from_hex_string ("994D2C41 AA30E529 52AEA846 2370471B 2B0A34AC")
			create s.make_from_hex_string ("00000001 52F95CA1 5DA1997A 8C449E00 CD2AA2AC CB988D7F")
			create e.make_from_hex_string ("A9993E36 4706816A BA3E2571 7850C26C 9CD0D89D")
			create u1_solution.make_from_string ("5658067548292182333034494350975093404971930311298")
			create u2_solution.make_from_string ("2390570840421010673757367220187439778211658217319")
			create u1g_x.make_from_hex_string ("00000005 1B4B9235 90399545 34D77469 AC7434D7 45BE784D")
			create u1g_y.make_from_hex_string ("00000001 C657D070 935987CA 79976B31 6ED2F533 41058956")
			create u2q_x.make_from_hex_string ("07FD04AF 05DCAF73 39F6F89C 52EF27FE 94699AED")
			create u2q_y.make_from_hex_string ("AA84BE48 C0F1256F A31AAADD F4ADDDD5 AD1F0E14")
			create r_x.make_from_hex_string ("00000004 994D2C41 AA30E529 52B0A94E C6511328 C502DA9B")
			create r_y.make_from_hex_string ("00000003 1FC936D7 3163B858 BBC5326D 77C19839 46405264")
			create u1g_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_F2M}.make (u1g_x), create {EC_FIELD_ELEMENT_F2M}.make (u1g_y))
			create u2q_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_F2M}.make (u2q_x), create {EC_FIELD_ELEMENT_F2M}.make (u2q_y))
			create r_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_F2M}.make (r_x), create {EC_FIELD_ELEMENT_F2M}.make (r_y))
			create g.make_sec_t163k1
			q := g.product_value (d, curve)
			u1 := (e * s.inverse_value (curve.n) \\ curve.n)
			u2 := (r * s.inverse_value (curve.n) \\ curve.n)
			correct := u1 ~ u1_solution
			assert ("test sec t verify 1", correct)
			correct := u2 ~ u2_solution
			assert ("test sec t verify 2", correct)
			u1g := g.product_value (u1, curve)
			correct := u1g ~ u1g_solution
			assert ("test sec t verify 3", correct)
			u2q := q.product_value (u2, curve)
			correct := u2q ~ u2q_solution
			assert ("test sec t verify 4", correct)
			r_point := u1g.plus_value (u2q, curve)
			correct := r_point ~ r_solution
			v := r_point.x.x \\ curve.n
			correct := v ~ r
			assert ("test sec t verify 5", correct)
		end
feature --Polynomial reflexive tests
	test_sec_t113r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t113r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t113r1 reflexive", correct)
		end

	test_sec_t113r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t113r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t113r2 reflexive", correct)
		end

	test_sec_t131r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t131r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t131r1 reflexive", correct)
		end

	test_sec_t131r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t131r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t131r2 reflexive", correct)
		end

	test_sec_t163k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t163k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t163k1 reflexive", correct)
		end

	test_sec_t163r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t163r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t163r1 reflexive", correct)
		end

	test_sec_t163r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t163r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t163r2 reflexive", correct)
		end

	test_sec_t193r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t193r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t193r1 reflexive", correct)
		end

	test_sec_t193r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t193r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t193r2 reflexive", correct)
		end

	test_sec_t233k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t233k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t233k1 reflexive", correct)
		end

	test_sec_t233r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t233r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t233r1 reflexive", correct)
		end

	test_sec_t239k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t239k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t239k1 reflexive", correct)
		end

	test_sec_t283k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t283k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t283k1 reflexive", correct)
		end

	test_sec_t283r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t283r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t283r1 reflexive", correct)
		end

	test_sec_t409k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t409k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t409k1 reflexive", correct)
		end

	test_sec_t409r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t409r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t409r1 reflexive", correct)
		end

	test_sec_t571k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t571k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t571k1 reflexive", correct)
		end

	test_sec_t571r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_t571r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec t571r1 reflexive", correct)
		end

	test_reduce_1
		local
			one: INTEGER_X
			a: INTEGER_X
			b: INTEGER_X
			n: INTEGER_X
			curve: EC_CURVE_F2M
			element: EC_FIELD_ELEMENT_F2M
			expected: INTEGER_X
		do
			create expected.make_from_hex_string ("13b6c2e54bb8c935c13fab54639da")
			create one.make_from_hex_string ("54505401551104100555400451414110050100000151441011150550")
			create a.make_from_hex_string ("3088250ca6e7c7fe649ce85820f7")
			create b.make_from_hex_string ("e8bee4d3e2260744188be0e9c723")
			create n.make_from_hex_string ("100000000000000d9ccec8a39e56f")
			create curve.make (0x71, 9, 0, 0, a, b, n)
			create element.make (one)
			element.reduce (one, curve)
			assert ("test reduce 1", one ~ expected)
		end

	test_square_1
		local
			one: INTEGER_X
			a: INTEGER_X
			b: INTEGER_X
			n: INTEGER_X
			curve: EC_CURVE_F2M
			element: EC_FIELD_ELEMENT_F2M
			expected: INTEGER_X
		do
			create one.make_from_hex_string ("ece1f5243f82d99431001da4573c")
			create expected.make_from_hex_string ("13b6c2e54bb8c935c13fab54639da")
			create a.make_from_hex_string ("3088250ca6e7c7fe649ce85820f7")
			create b.make_from_hex_string ("e8bee4d3e2260744188be0e9c723")
			create n.make_from_hex_string ("100000000000000d9ccec8a39e56f")
			create curve.make (0x71, 9, 0, 0, a, b, n)
			create element.make (one)
			element.square (curve)
			assert ("test square 1", element.x ~ expected)
		end

	test_square_2
		local
			parameters: EC_DOMAIN_PARAMETERS_F2M
			one: INTEGER_X
			element: EC_FIELD_ELEMENT_F2M
			expected: INTEGER_X
		do
			create one.make_from_hex_string ("3 ffffffff ffffffff ffffffff ffffffff")
			create expected.make_from_hex_string ("aaaaaaaaaaaaaaaaaaaaaaaaaaaabfee")
			create parameters.make_sec_t131r1
			create element.make (one)
			element.square (parameters.curve)
			assert ("test square 2", element.x ~ expected)
		end

	test_square_3
		local
			parameters: EC_DOMAIN_PARAMETERS_F2M
			one: INTEGER_X
			element: EC_FIELD_ELEMENT_F2M
			expected: INTEGER_X
		do
			create parameters.make_sec_t131r1
			create one.make_from_hex_string ("b11acac3b1c28415a4e733010375a5b8")
			create expected.make_from_hex_string ("18b11dd51ffe1f2aeef0ec79fae0b67f7")
			create element.make (one)
			element.square (parameters.curve)
			assert ("test square 3", element.x ~ expected)
		end

	test_product_1
		local
			curve: EC_CURVE_F2M
			one: EC_POINT_F2M
			expected: EC_POINT_F2M
			multiplicand: INTEGER_X
		do
			create one.make_curve_x_y (create {INTEGER_X}.make_from_hex_string ("9d73616f35f4ab1407d73562c10f"), create {INTEGER_X}.make_from_hex_string ("a52830277958ee84d1315ed31886"))
			create expected.make_curve_x_y (create {INTEGER_X}.make_from_hex_string ("1a42d8acf7568670dfd067fde38ff"), create {INTEGER_X}.make_from_hex_string ("11747870124d247a94b527a2fbc2e"))
			create multiplicand.make_from_hex_string ("a077518c809013ae8ec6baecd515")
			create curve.make (0x71, 9, 0, 0, create {INTEGER_X}.make_from_hex_string ("3088250ca6e7c7fe649ce85820f7"), create {INTEGER_X}.make_from_hex_string ("e8bee4d3e2260744188be0e9c723"), create {INTEGER_X}.make_from_hex_string ("100000000000000d9ccec8a39e56f"))
			one.product (multiplicand, curve)
			assert ("test product 1", one ~ expected)
		end

	test_product_2
		local
			curve: EC_CURVE_F2M
			one: EC_FIELD_ELEMENT_F2M
			expected: EC_FIELD_ELEMENT_F2M
			multiplicand: INTEGER_X
		do
			create one.make (create {INTEGER_X}.make_from_hex_string ("a52830277958ee84d1315ed31886"))
			create multiplicand.make_from_hex_string ("fa499cd55090de5385193e34792c")
			create expected.make (create {INTEGER_X}.make_from_hex_string ("7192944b0a76728036d728c69633"))
			create curve.make (0x71, 9, 0, 0, create {INTEGER_X}.make_from_hex_string ("3088250ca6e7c7fe649ce85820f7"), create {INTEGER_X}.make_from_hex_string ("e8bee4d3e2260744188be0e9c723"), create {INTEGER_X}.make_from_hex_string ("100000000000000d9ccec8a39e56f"))
			one.product (multiplicand, curve)
			assert ("test product 2", one ~ expected)
		end
end
