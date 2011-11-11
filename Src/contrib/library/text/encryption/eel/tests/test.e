note
	description : "tests application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			key_pair: RSA_KEY_PAIR
			message: INTEGER_X
			cipher: INTEGER_X
			plain: INTEGER_X
			signature: INTEGER_X
			correct: BOOLEAN
		do
			io.put_string ("Creating keypair%N")
			create key_pair.make (1024)
			io.put_string ("Created keypair%N")
			create message.make_random (128)
			cipher := key_pair.public.encrypt (message)
			plain := key_pair.private.decrypt (cipher)
			io.put_string ("Checked encryption%N")
			signature := key_pair.private.sign (message)
			correct := key_pair.public.verify (message, signature)
			io.put_string ("Checked signing%N")
		end

	make_2
		local
			key: EC_KEY_PAIR
			message: INTEGER_X
			signature: TUPLE [r: INTEGER_X s: INTEGER_X]
			correct: BOOLEAN
			i: INTEGER
		do
			create key.make_sec_t113r1
			create message.make_random_max (key.private.params.n)
			from
				i := 0
			until
				i > 100
			loop
				signature := key.private.sign (message)
				correct := key.public.verify (message, signature)
				i := i + 1
			end
		end

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
		end

	test1: detachable AES_TEST
	test2: detachable CBC_TEST
	test3: detachable CFB_TEST
	test4: detachable CTR_TEST
	test5: detachable DER_TEST
	test6: detachable ECB_TEST
	test7: detachable EC_TEST
	test8: detachable MD5_TEST
	test9: detachable OFB_TEST
	test10: detachable RSA_TEST
	test11: detachable SHA1_TEST
	test12: detachable SHA256_TEST
	test13: detachable TEST_EC_BINARY
	test14: detachable HMAC_SHA256_TEST

end
