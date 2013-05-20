note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_UTF8_ENCODER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_url_encoded_encoder
		note
			testing:  "url-encoded"
		do
			test_utf8_decoding ("%%C3%%A9t%%C3%%A9", {STRING_32}"été")
		end

	test_utf8_decoding (s: STRING_8; e: STRING_32)
		local
			url: URL_ENCODER
			u: STRING_32
			b: UTF8_ENCODER
		do
			create b
			create url
			u := b.decoded_string (url.decoded_string (s))
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


