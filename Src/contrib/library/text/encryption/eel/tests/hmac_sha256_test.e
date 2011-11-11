note
	description: "Summary description for {HMAC_SHA256_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HMAC_SHA256_TEST

inherit

	EQA_TEST_SET

feature

	test_empty
		local
			hmac: HMAC_SHA256
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("0"))
			hmac.finish
			hmac.reset
			hmac.finish
		end

	test_rfc_4231_1
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"))
			hmac.sink_string ("Hi There")
			hmac.finish
			create expected.make_from_hex_string ("b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7")
			assert ("test_rfc_4231_1", hmac.hmac ~ expected)
		end

	test_rfc_4231_2
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("4a656665"))
			hmac.sink_string ("what do ya want for nothing?")
			hmac.finish
			create expected.make_from_hex_string ("5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843")
			assert ("test_rfc_4231_2", hmac.hmac ~ expected)
		end

	test_rfc_4231_2_ascii
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make_ascii_key ("Jefe")
			hmac.sink_string ("what do ya want for nothing?")
			hmac.finish
			create expected.make_from_hex_string ("5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843")
			assert ("test_rfc_4231_2", hmac.hmac ~ expected)
		end

	test_rfc_4231_3
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
			hmac.sink_string (create {STRING_8}.make_filled ('%/221/', 50))
			hmac.finish
			create expected.make_from_hex_string ("773ea91e36800e46854db8ebd09181a72959098b3ef8c122d9635514ced565fe")
			assert ("test_rfc_4231_3", hmac.hmac ~ expected)
		end

	test_rfc_4231_4
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("0102030405060708090a0b0c0d0e0f10111213141516171819"))
			hmac.sink_string (create {STRING_8}.make_filled ('%/205/', 50))
			hmac.finish
			create expected.make_from_hex_string ("82558a389a443c0ea4cc819899f2083a85f0faa3e578f8077a2e3ff46729665b")
			assert ("test_rfc_4231_4", hmac.hmac ~ expected)
		end

	test_rfc_4231_6
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
			hmac.sink_string ("Test Using Larger Than Block-Size Key - Hash Key First")
			hmac.finish
			create expected.make_from_hex_string ("60e431591ee0b67f0d8a26aacbf5b77f8e0bc6213728c5140546040f0ee37f54")
			assert ("test_rfc_4231_6", hmac.hmac ~ expected)
		end

	test_rfc_4231_7
		local
			hmac: HMAC_SHA256
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
			hmac.sink_string ("This is a test using a larger than block-size key and a larger than block-size data. The key needs to be hashed before being used by the HMAC algorithm.")
			hmac.finish
			create expected.make_from_hex_string ("9b09ffa71b942fcb27635fbcd5b0e944bfdc63644f0713938a7f51535c3a35e2")
			assert ("test_rfc_4231_7", hmac.hmac ~ expected)
		end

end
