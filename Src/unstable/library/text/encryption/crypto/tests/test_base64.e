note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BASE64

inherit
	EQA_TEST_SET

feature -- Test routines

	test_text
		local
			expected: STRING
			src,dec,enc: STRING
		do
			src := "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure."
			expected := "TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4="
			enc := base64_encoded_string (src)
			assert ("test_encoded", enc.same_string (expected))
			dec := base64_decoded_string (expected)
			assert ("test_decoded", dec.same_string (src))
		end

	test_unicode
		local
			expected: STRING
			src,dec,enc: STRING
			uni: STRING_32
			utf: UTF_CONVERTER
		do
			src := utf.utf_32_string_to_utf_8_string_8 ({STRING_32} "你好")
			expected := "5L2g5aW9"
			enc := base64_encoded_string (src)
			assert ("test_encoded", enc.same_string (expected))
			dec := base64_decoded_string (expected)
			assert ("test_decoded", dec.same_string (src))
			uni := utf.utf_8_string_8_to_string_32 (dec)
			assert ("unicode test_decoded", uni.same_string ({STRING_32} "你好"))
		end

	test_cases_bytes_encoding
		do
			assert("test cases#b01", base64_bytes_encoded_string (<<('f').code.to_natural_8, ('o').code.to_natural_8>>).same_string ("Zm8="))
			assert("test cases#b02", base64_bytes_encoded_string (<<('f').code.to_natural_8, ('o').code.to_natural_8, ('o').code.to_natural_8>>).same_string ("Zm9v"))
		end

	test_cases_encoding
		do
--			assert("test cases#01", base64_encoded_string ("").same_string (""))
			assert("test cases#02", base64_encoded_string ("f").same_string ("Zg=="))
			assert("test cases#03", base64_encoded_string ("fo").same_string ("Zm8="))
			assert("test cases#04", base64_encoded_string ("foo").same_string ("Zm9v"))
			assert("test cases#05", base64_encoded_string ("foob").same_string ("Zm9vYg=="))
			assert("test cases#06", base64_encoded_string ("fooba").same_string ("Zm9vYmE="))
			assert("test cases#07", base64_encoded_string ("foobar").same_string ("Zm9vYmFy"))
		end

	test_cases_decoding
		do
			assert("test cases#01", base64_decoded_string ("").same_string (""))
			assert("test cases#02", base64_decoded_string ("Zg==").same_string ("f"))
			assert("test cases#03", base64_decoded_string ("Zm8=").same_string ("fo"))
			assert("test cases#04", base64_decoded_string ("Zm9v").same_string ("foo"))
			assert("test cases#05", base64_decoded_string ("Zm9vYg==").same_string ("foob"))
			assert("test cases#06", base64_decoded_string ("Zm9vYmE=").same_string ("fooba"))
			assert("test cases#07", base64_decoded_string ("Zm9vYmFy").same_string ("foobar"))
		end

	test_cases_decoding_paddingless
		do
			assert("test cases#02", base64_decoded_string ("Zg").same_string ("f"))
			assert("test cases#03", base64_decoded_string ("Zm8").same_string ("fo"))
			assert("test cases#04", base64_decoded_string ("Zm9v").same_string ("foo"))
			assert("test cases#05", base64_decoded_string ("Zm9vYg").same_string ("foob"))
			assert("test cases#06", base64_decoded_string ("Zm9vYmE").same_string ("fooba"))
			assert("test cases#07", base64_decoded_string ("Zm9vYmFy").same_string ("foobar"))
		end

	test_now_01
		local
			s,e: STRING
			s32: STRING_32
			utf: UTF_CONVERTER
		do
			s := "any carnal pleasure."
			e := base64_encoded_string (s)
			assert ("1", e.same_string ("YW55IGNhcm5hbCBwbGVhc3VyZS4="))

			s := "any carnal pleasure"
			e := base64_encoded_string (s)
			assert ("1", e.same_string ("YW55IGNhcm5hbCBwbGVhc3VyZQ=="))

			s := "any carnal pleasur"
			e := base64_encoded_string (s)
			assert ("1", e.same_string ("YW55IGNhcm5hbCBwbGVhc3Vy"))

			s := "any carnal pleasu"
			e := base64_encoded_string (s)
			assert ("1", e.same_string ("YW55IGNhcm5hbCBwbGVhc3U="))

			s := "any carnal pleas"
			e := base64_encoded_string (s)
			assert ("1", e.same_string ("YW55IGNhcm5hbCBwbGVhcw=="))

			s := "LxtbuqgvDzwKHZySOPeTO02WbWfwfWHBxt5zIEWA+kDfE7w="
			if attached base64_decoded_string (s) as d then
				s32 := utf.utf_8_string_8_to_string_32 (d)
			end
		end

feature -- Helpers

	base64_bytes_encoded_string (a_bytes: ARRAY [NATURAL_8]): STRING
		local
			base64: BASE64
		do
			create base64
			Result := base64.bytes_encoded_string (a_bytes)
		end

	base64_encoded_string (s: READABLE_STRING_8): STRING
		local
			base64: BASE64
		do
			create base64
			Result := base64.encoded_string (s)
		end

	base64_decoded_string (s: READABLE_STRING_8): STRING
		local
			base64: BASE64
		do
			create base64
			Result := base64.decoded_string (s)
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
