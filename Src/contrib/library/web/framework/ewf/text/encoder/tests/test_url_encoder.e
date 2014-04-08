note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_URL_ENCODER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_url_encoded_encoder
		note
			testing:  "url-encoded"
		do
			test_url_encoded_encoding ({STRING_32}"http://domain.tld/foo/bar/script.php?test='toto'&foo=bar&title=il était une fois")
			test_url_encoded_encoding ({STRING_32}"été")
			test_url_encoded_decoding ({STRING_8}"%%E9t%%E9", {STRING_32}"été")
			test_url_encoded_decoding ({STRING_8}"Test%0A", {STRING_32}"Test%N")

			test_utf8_url_encoded_decoding ({STRING_8}"%%C3%%A9t%%C3%%A9", {STRING_32}"été")
		end

	test_url_encoded_encoding (s: STRING_32)
		local
			u: STRING_32
			e: STRING_8
			b: URL_ENCODER
		do
			create b
			e := b.encoded_string (s)
			u := b.decoded_string (e)
			assert ("decoded encoded string is same for string %"" + u + "%"", u ~ s)
		end

	test_url_encoded_decoding (s: STRING_8; e: STRING_32)
		local
			u: STRING_32
			b: URL_ENCODER
		do
			create b
			u := b.decoded_string (s)
			assert ("decoded encoded string is same for %"" + s + "%"", u ~ e)
		end

	test_utf8_url_encoded_decoding (s: STRING_8; e: STRING_32)
		local
			u: STRING_32
			b: UTF8_URL_ENCODER
		do
			create b
			u := b.decoded_string (s)
			assert ("decoded encoded string is same for %"" + s + "%"", u ~ e)
		end


note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


