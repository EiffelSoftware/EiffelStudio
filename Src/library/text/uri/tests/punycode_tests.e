note
	description: "Summary description for {PUNYCODE_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PUNYCODE_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_decode
			-- New test routine
		do
			test_decode_case ("1", "maana-pta", {STRING_32} "mañana")
			test_decode_case ("B", "ihqwcrb4cv8a8dqg056pqjye",
					{STRING_32} "%/20182/%/20204/%/20026/%/20160/%/20040/%/19981/%/35828/%/20013/%/25991/")
					--	u+4ED6 u+4EEC u+4E3A u+4EC0 u+4E48 u+4E0D u+8BF4 u+4E2D u+6587
			test_decode_case ("3", "--dqo34k", {STRING_32} "%/9731/-%/8984/")
			test_decode_case ("4", "bcher-kva", {STRING_32} "bücher")
			test_decode_case ("5", "p1ai", {STRING_32} "рф")
		end

	test_decode_case (a_id: READABLE_STRING_8; src: READABLE_STRING_GENERAL; exp: READABLE_STRING_32)
		local
			p: PUNYCODE
			dst: READABLE_STRING_32
		do
			create p
			dst := p.decoded_string (src)
			assert ("decode#" + a_id, dst.same_string_general (exp))
		end

	test_encode
		do
			test_encode_case ("B", {STRING_32} "%/20182/%/20204/%/20026/%/20160/%/20040/%/19981/%/35828/%/20013/%/25991/", "ihqwcrb4cv8a8dqg056pqjye")
			test_encode_case ("1", {STRING_32} "%/252/", "tda")
			test_encode_case ("2", {STRING_32} "ññ", "idaa")
			test_encode_case ("3", {STRING_32} "看", "c1y")
			test_encode_case ("4", {STRING_32} "點", "md7a")
			test_encode_case ("5", {STRING_32} "點看", "c1yn36f")
			test_encode_case ("6", {STRING_32} "mañana", "maana-pta")
			test_encode_case ("7", {STRING_32} "%/9731/-%/8984/", "--dqo34k")

			test_encode_case ("8", {STRING_32} "bücher", "bcher-kva")
			test_encode_case ("9", {STRING_32} "рф", "p1ai")
		end

	test_encode_case (a_id: READABLE_STRING_8; src: READABLE_STRING_GENERAL; exp: READABLE_STRING_8)
		local
			p: PUNYCODE
			dst: READABLE_STRING_32
		do
			create p
			dst := p.encoded_string (src)
			assert ("encode#" + a_id, dst.same_string_general (exp))
		end

end


