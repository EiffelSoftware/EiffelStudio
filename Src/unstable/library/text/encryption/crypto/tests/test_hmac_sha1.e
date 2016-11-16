note
	description: "Test for HMAC_SHA1"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_SHA1

inherit
	EQA_TEST_SET

feature -- Test routines

	test_empty
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("")
			expected := "fbdb1d1b18aa6c08324b7d64b71fb76370690e1d"
			assert ("test_rfc_4231_1", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_1
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b")
			hmac.update_from_string ("Hi There")
			expected := "b617318655057264e28bc0b6fb378c8ef146be00"
			assert ("test_rfc_4231_1", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_2
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("4a656665")
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "effcdf6ae5eb2fa2d27416d5f184df9c259a7c79"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_2_ascii
		local
			hmac: HMAC_SHA1
			e1, e2, e3, expected: STRING
		do
			create hmac.make_ascii_key ("secret-shared-key-goes")
			hmac.update_from_string ("first and last")
			e1 := hmac.digest_as_string

			create hmac.make_ascii_key ("secret-shared-key-goes")
			hmac.update_from_string ("first")
			hmac.update_from_string (" and last")
			e2 := hmac.digest_as_string

			create hmac.make_ascii_key ("secret-shared-key-goes")
			hmac.update_from_string ("first")
			e3 := hmac.digest_as_string

			hmac.update_from_string (" and last")
			e3 := hmac.digest_as_string

			assert("e1=e2=e3", e1.same_string (e2) and e2.same_string (e3))


			create hmac.make_ascii_key ("Jefe")
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "effcdf6ae5eb2fa2d27416d5f184df9c259a7c79"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_3
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string (create {STRING_8}.make_filled ('%/221/', 50))
			expected := "125d7342b9ac11cd91a39af48aa17b4f63f175d3"
			assert ("test_rfc_4231_3", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_4
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("0102030405060708090a0b0c0d0e0f10111213141516171819")
			hmac.update_from_string (create {STRING_8}.make_filled ('%/205/', 50))
			expected := "4c9007f4026250c6bc8414f9bf50c86c2d7235da"
			assert ("test_rfc_4231_4", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_6
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string ("Test Using Larger Than Block-Size Key - Hash Key First")
			expected := "90d0dace1c1bdc957339307803160335bde6df2b"
			assert ("test_rfc_4231_6", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_7
		local
			hmac: HMAC_SHA1
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string ("This is a test using a larger than block-size key and a larger than block-size data. The key needs to be hashed before being used by the HMAC algorithm.")
			expected := "217e44bb08b6e06a2d6c30f3cb9f537f97c63356"
			assert ("test_rfc_4231_7", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
