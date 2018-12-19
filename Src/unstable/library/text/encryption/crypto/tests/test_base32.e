note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BASE32

inherit
	EQA_TEST_SET

feature -- Test routines

	test_text
		local
			expected: STRING
			src,dec,enc: STRING
		do
			src := "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure."
			expected := "JVQW4IDJOMQGI2LTORUW4Z3VNFZWQZLEFQQG433UEBXW43DZEBRHSIDINFZSA4TFMFZW63RMEBRHK5BAMJ4SA5DINFZSA43JNZTXK3DBOIQHAYLTONUW63RAMZZG63JAN52GQZLSEBQW42LNMFWHGLBAO5UGSY3IEBUXGIDBEBWHK43UEBXWMIDUNBSSA3LJNZSCYIDUNBQXIIDCPEQGCIDQMVZHGZLWMVZGC3TDMUQG6ZRAMRSWY2LHNB2CA2LOEB2GQZJAMNXW45DJNZ2WKZBAMFXGIIDJNZSGKZTBORUWOYLCNRSSAZ3FNZSXEYLUNFXW4IDPMYQGW3TPO5WGKZDHMUWCAZLYMNSWKZDTEB2GQZJAONUG64TUEB3GK2DFNVSW4Y3FEBXWMIDBNZ4SAY3BOJXGC3BAOBWGKYLTOVZGKLQ="
			enc := base32_encoded_string (src)
			assert ("test_encoded", enc.same_string (expected))
			dec := base32_decoded_string (expected)
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
			expected := "4S62BZNFXU======"
			enc := base32_encoded_string (src)
			assert ("test_encoded", enc.same_string (expected))
			dec := base32_decoded_string (expected)
			assert ("test_decoded", dec.same_string (src))
			uni := utf.utf_8_string_8_to_string_32 (dec)
			assert ("unicode test_decoded", uni.same_string ({STRING_32} "你好"))
		end

	test_cases_bytes_encoding
		do
			assert("test cases#b01", base32_bytes_encoded_string (<<('f').code.to_natural_8, ('o').code.to_natural_8>>).same_string ("MZXQ===="))
			assert("test cases#b02", base32_bytes_encoded_string (<<('f').code.to_natural_8, ('o').code.to_natural_8, ('o').code.to_natural_8>>).same_string ("MZXW6==="))
		end

	test_cases_encoding
		do
			assert ("test case#1", base32_encoded_string ("").same_string (""))
			assert ("test case#2", base32_encoded_string ("f").same_string ("MY======"))
			assert ("test case#3", base32_encoded_string ("fo").same_string ("MZXQ===="))
			assert ("test case#4", base32_encoded_string ("foo").same_string ("MZXW6==="))
			assert ("test case#5", base32_encoded_string ("foob").same_string ("MZXW6YQ="))
			assert ("test case#6", base32_encoded_string ("fooba").same_string ("MZXW6YTB"))
			assert ("test case#7", base32_encoded_string ("foobar").same_string ("MZXW6YTBOI======"))
		end

	test_cases_decoding
		do
			assert ("test case#1", base32_decoded_string ("").same_string (""))
			assert ("test case#2", base32_decoded_string ("MY======").same_string ("f"))
			assert ("test case#3", base32_decoded_string ("MZXQ====").same_string ("fo"))
			assert ("test case#4", base32_decoded_string ("MZXW6===").same_string ("foo"))
			assert ("test case#5", base32_decoded_string ("MZXW6YQ=").same_string ("foob"))
			assert ("test case#6", base32_decoded_string ("MZXW6YTB").same_string ("fooba"))
			assert ("test case#7", base32_decoded_string ("MZXW6YTBOI======").same_string ("foobar"))
		end

	test_cases_decoding_paddingless
		do
			assert ("test case#2", base32_decoded_string ("MY").same_string ("f"))
			assert ("test case#3", base32_decoded_string ("MZXQ").same_string ("fo"))
			assert ("test case#4", base32_decoded_string ("MZXW6").same_string ("foo"))
			assert ("test case#5", base32_decoded_string ("MZXW6YQ").same_string ("foob"))
			assert ("test case#6", base32_decoded_string ("MZXW6YTB").same_string ("fooba"))
			assert ("test case#7", base32_decoded_string ("MZXW6YTBOI").same_string ("foobar"))
		end


feature -- Helpers

	base32_bytes_encoded_string (a_bytes: ARRAY [NATURAL_8]): STRING
		local
			base32: BASE32
		do
			create base32
			Result := base32.bytes_encoded_string (a_bytes)
		end

	base32_encoded_string (s: READABLE_STRING_8): STRING
		local
			base32: BASE32
		do
			create base32
			Result := base32.encoded_string (s)
		end

	base32_decoded_string (s: READABLE_STRING_8): STRING
		local
			base32: BASE32
		do
			create base32
			Result := base32.decoded_string (s)
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
