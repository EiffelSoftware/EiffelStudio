note
	description	: "Tests basic Elliptical Curve library functionality"
	author : "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Giving money and power to government is like giving whiskey and car keys to teenage boys. - P.J. O'Rourke"

class
	EC_TEST

inherit
	EQA_TEST_SET

feature -- Polynomial math
	test_sec_multiply
		local
			curve: EC_CURVE_FP
			g: EC_POINT_FP
			d: INTEGER_X
			q: EC_POINT_FP
			q_x_solution: INTEGER_X
			q_y_solution: INTEGER_X
			q_solution: EC_POINT_FP
			correct: BOOLEAN
		do
			create curve.make_sec_p160r1
			create g.make_sec_p160r1
			create d.make_from_hex_string ("AA374FFC 3CE144E6 B0733079 72CB6D57 B2A4E982")
			q := g.product_value (d, curve)
			create q_x_solution.make_from_string ("466448783855397898016055842232266600516272889280")
			create q_y_solution.make_from_string ("1110706324081757720403272427311003102474457754220")
			create q_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_FP}.make_p_x (q_x_solution), create {EC_FIELD_ELEMENT_FP}.make_p_x (q_y_solution))
			correct := q ~ q_solution
			assert ("test sec multiply", correct)
		end

	test_sec_sign
		local
			h: INTEGER_X
			e: INTEGER_X
			k: INTEGER_X
			g: EC_POINT_FP
			r: EC_POINT_FP
			r_x_solution: INTEGER_X
			r_y_solution: INTEGER_X
			r_solution: EC_POINT_FP
			curve: EC_CURVE_FP
			correct: BOOLEAN
			s: INTEGER_X
			d: INTEGER_X
			s_solution: INTEGER_X
			n: INTEGER_X
		do
			create n.make_from_hex_string ("01 00000000 00000000 0001F4C8 F927AED3 CA752257")
			create d.make_from_hex_string ("AA374FFC 3CE144E6 B0733079 72CB6D57 B2A4E982")
			create h.make_from_hex_string ("A9993E36 4706816A BA3E2571 7850C26C 9CD0D89D")
			create curve.make_sec_p160r1
			create g.make_sec_p160r1
			create k.make_from_string ("702232148019446860144825009548118511996283736794")
			r := g.product_value (k, curve)
			create r_x_solution.make_from_string ("1176954224688105769566774212902092897866168635793")
			create r_y_solution.make_from_string ("1130322298812061698910820170565981471918861336822")
			create r_solution.make_curve_x_y (create {EC_FIELD_ELEMENT_FP}.make_p_x (r_x_solution), create {EC_FIELD_ELEMENT_FP}.make_p_x (r_y_solution))
			correct := r_solution ~ r
			assert ("test sec sign 1", correct)
			e := h
			s := (k.inverse_value (n) * (e + d * r.x.x)) \\ n
			create s_solution.make_from_string ("299742580584132926933316745664091704165278518100")
			correct := s ~ s_solution
			assert ("test sec sign 2", correct)
		end

	test_set_verify
		local
			h: INTEGER_X
			e: INTEGER_X
			s: INTEGER_X
			r: INTEGER_X
			n: INTEGER_X
			u1: INTEGER_X
			u2: INTEGER_X
			g: EC_POINT_FP
			q: EC_POINT_FP
			q_x: INTEGER_X
			q_y: INTEGER_X
			curve: EC_CURVE_FP
			r_point: EC_POINT_FP
			r_x_solution: INTEGER_X
			r_y_solution: INTEGER_X
			gu: EC_POINT_FP
			gu_x_solution: INTEGER_X
			gu_y_solution: INTEGER_X
			qu: EC_POINT_FP
			qu_x_solution: INTEGER_X
			qu_y_solution: INTEGER_X
			correct: BOOLEAN
			v: INTEGER_X
			u1_solution: INTEGER_X
			u2_solution: INTEGER_X
		do
			create h.make_from_hex_string ("A9993E36 4706816A BA3E2571 7850C26C 9CD0D89D")
			create n.make_from_hex_string ("01 00000000 00000000 0001F4C8 F927AED3 CA752257")
			create g.make_sec_p160r1
			create r.make_from_string ("1176954224688105769566774212902092897866168635793")
			create s.make_from_string ("299742580584132926933316745664091704165278518100")
			create curve.make_sec_p160r1
			create q_x.make_from_string ("466448783855397898016055842232266600516272889280")
			create q_y.make_from_string ("1110706324081757720403272427311003102474457754220")
			create q.make_curve_x_y (create {EC_FIELD_ELEMENT_FP}.make_p_x (q_x), create {EC_FIELD_ELEMENT_FP}.make_p_x (q_y))
			create gu_x_solution.make_from_string ("559637225459801172484164154368876326912482639549")
			create gu_y_solution.make_from_string ("1427364757892877133166464896740210315153233662312")
			create qu_x_solution.make_from_string ("1096326382299378890940501642113021093797486469420")
			create qu_y_solution.make_from_string ("1361206527591198621565826173236094337930170472426")
			create r_x_solution.make_from_string ("1176954224688105769566774212902092897866168635793")
			create r_y_solution.make_from_string ("1130322298812061698910820170565981471918861336822")
			create u1_solution.make_from_string ("126492345237556041805390442445971246551226394866")
			create u2_solution.make_from_string ("642136937233451268764953375477669732399252982122")
			e := h
			u1 := e * s.inverse_value (n) \\ n
			correct := u1 ~ u1_solution
			assert ("test set verify 1", correct)
			u2 := r * s.inverse_value (n) \\ n
			correct := u2 ~ u2_solution
			assert ("test set verify 2", correct)
			gu := g.product_value (u1, curve)
			correct := gu.x.x ~ gu_x_solution
			assert ("test set verify 3", correct)
			correct := gu.y.x ~ gu_y_solution
			assert ("test set verify 4", correct)
			qu := q.product_value (u2, curve)
			correct := qu.x.x ~ qu_x_solution
			assert ("test set verify 5", correct)
			correct := qu.y.x ~ qu_y_solution
			assert ("test set verify 6", correct)
			r_point := gu.plus_value (qu, curve)
			correct := r_x_solution ~ r_point.x.x
			assert ("test set verify 7", correct)
			correct := r_y_solution ~ r_point.y.x
			assert ("test set verify 8", correct)
			v := r_point.x.x \\ n
			correct := v ~ r
			assert ("test set verify 9", correct)
		end

feature -- Prime reflexive tests
	test_reflexive_2
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
			i: INTEGER
		do
			from
				i := 0
			until
				i > 10
			loop
				create key.make_sec_p112r1
				create message.make_random_max (key.private.params.n)
				signature := key.private.sign (message)
				correct := key.public.verify (message, signature)
				assert ("test reflexive 2 iteration: " + i.out, correct)
				i := i + 1
			end
		end

	test_reflexive
		local
			key1: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create message.make_from_string ("968236873715988614170569073515315707566766479517")
			create key1.make_p521
			signature := key1.private.sign (message)
			correct := key1.public.verify (message, signature)
			assert ("test reflexive", correct)
		end

	test_sec_p112r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p112r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p112r1 reflexive", correct)
		end

	test_sec_p112r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p112r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p112r2 reflexive", correct)
		end

	test_sec_p128r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p128r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p128r1 reflexive", correct)
		end

	test_sec_p128r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p128r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p128r2 reflexive", correct)
		end

	test_sec_p160k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p160k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p160k1 reflexive", correct)
		end

	test_sec_p160r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p160r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p160r1 reflexive", correct)
		end

	test_sec_p160r2_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p160r2
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p160r2 reflexive", correct)
		end

	test_sec_p192k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p192k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p192k1 reflexive", correct)
		end

	test_sec_p192r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p192r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p192r1 reflexive", correct)
		end

	test_sec_p224k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p224k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p224k1 reflexive", correct)
		end

	test_sec_p224r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p224r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p224r1 reflexive", correct)
		end

	test_sec_p256k1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p256k1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p256k1 reflexive", correct)
		end

	test_sec_p256r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p256r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p256r1 reflexive", correct)
		end

	test_sec_p384r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p384r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p384r1 reflexive", correct)
		end

	test_sec_p521r1_reflexive
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
		do
			create key.make_sec_p521r1
			create message.make_random_max (key.private.params.n)
			signature := key.private.sign (message)
			correct := key.public.verify (message, signature)
			assert ("test sec p521r1 relfexive", correct)
		end

	test_agreement
		local
			key1: EC_KEY_PAIR
			key2: EC_KEY_PAIR
			e1_agreement: INTEGER_X
			e2_agreement: INTEGER_X
			correct: BOOLEAN
		do
			create key1.make_p521
			create key2.make_p521
			e1_agreement := key1.private.agreement (key2.public)
			e2_agreement := key2.private.agreement (key1.public)
			correct := e1_agreement ~ e2_agreement
			assert ("test agreement", correct)
		end
end
