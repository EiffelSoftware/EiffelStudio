note
	description: "Test for HMAC_SHA256"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_SHA256

inherit
	EQA_TEST_SET

feature -- Test routines

	test_empty
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("")
			expected := "b613679a0814d9ec772f95d778c35fc5ff1697c493715653c6c712144292c5ad"
			assert ("test_rfc_4231_1", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_1
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b")
			hmac.update_from_string ("Hi There")
			expected := "b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7"
			assert ("test_rfc_4231_1", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_2
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("4a656665")
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_2_ascii
		local
			hmac: HMAC_SHA256
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
			hmac.reset
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))

			hmac.reset
			hmac.update_from_string ("what do ya want for nothing?")
			expected := "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843"
			assert ("test_rfc_4231_2", hmac.digest_as_string.is_case_insensitive_equal (expected))

		end

	test_rfc_4231_3
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string (create {STRING_8}.make_filled ('%/221/', 50))
			expected := "773ea91e36800e46854db8ebd09181a72959098b3ef8c122d9635514ced565fe"
			assert ("test_rfc_4231_3", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_4
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("0102030405060708090a0b0c0d0e0f10111213141516171819")
			hmac.update_from_string (create {STRING_8}.make_filled ('%/205/', 50))
			expected := "82558a389a443c0ea4cc819899f2083a85f0faa3e578f8077a2e3ff46729665b"
			assert ("test_rfc_4231_4", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_6
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string ("Test Using Larger Than Block-Size Key - Hash Key First")
			expected := "60e431591ee0b67f0d8a26aacbf5b77f8e0bc6213728c5140546040f0ee37f54"
			assert ("test_rfc_4231_6", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

	test_rfc_4231_7
		local
			hmac: HMAC_SHA256
			expected: STRING
		do
			create hmac.make_hexadecimal_key ("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
			hmac.update_from_string ("This is a test using a larger than block-size key and a larger than block-size data. The key needs to be hashed before being used by the HMAC algorithm.")
			expected := "9b09ffa71b942fcb27635fbcd5b0e944bfdc63644f0713938a7f51535c3a35e2"
			assert ("test_rfc_4231_7", hmac.digest_as_string.is_case_insensitive_equal (expected))
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
