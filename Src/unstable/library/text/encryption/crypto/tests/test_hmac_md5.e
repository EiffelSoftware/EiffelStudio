note
	description: "Test for HMAC_MD5"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_MD5

inherit
	EQA_TEST_SET

feature -- Test routines

	test_empty
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("")
			expected := "74e6f7298a9c2d168935f58c001bad88"
			assert ("test_rfc_4231_1", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_1
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b")
			hmac.update_from_string ("Hi There")
			expected := "5ccec34ea9656392457fa1ac27f08fbc"
			assert ("test_rfc_4231_1", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_2
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("4a656665")
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "750c783e6ab0b503eaa86e310a5db738"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_2_ascii
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_ascii_key ("Jefe")
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "750c783e6ab0b503eaa86e310a5db738"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_3
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string (create {STRING_8}.make_filled ('%/221/', 50))
			expected := "2ab8b9a9f7d3894d15ad8383b97044b2"
			assert ("test_rfc_4231_3", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_4
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("0102030405060708090a0b0c0d0e0f10111213141516171819")
			hmac.update_from_string (create {STRING_8}.make_filled ('%/205/', 50))
			expected := "697eaf0aca3a3aea3a75164746ffaa79"
			assert ("test_rfc_4231_4", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_6
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string ("Test Using Larger Than Block-Size Key - Hash Key First")
			expected := "bfecaf4efff90a3a668f3922fec3762d"
			assert ("test_rfc_4231_6", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_7
		local
			hmac: HMAC_MD5
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string ("This is a test using a larger than block-size key and a larger than block-size data. The key needs to be hashed before being used by the HMAC algorithm.")
			expected := "09b8ae7b15adbbb243aca3491b51512b"
			assert ("test_rfc_4231_7", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
