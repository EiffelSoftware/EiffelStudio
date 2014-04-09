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
		local
			utf8: STRING_8
		do
			create utf8.make_empty
			utf8.append_code (195) --+
			utf8.append_code (169) --  é
			utf8.append_code (116) --  t
			utf8.append_code (195) --+
			utf8.append_code (169) --  é
			test_utf8_decoding (utf8, {STRING_32}"été")

			create utf8.make_empty
			utf8.append_code (228) --+
			utf8.append_code (189) --+
			utf8.append_code (160) --  你

			utf8.append_code (229) --+
			utf8.append_code (165) --+			
			utf8.append_code (189) --  好			

			utf8.append_code (229) --+
			utf8.append_code (144) --+			
			utf8.append_code (151) --  吗			

			test_utf8_decoding (utf8, {STRING_32}"你好吗")
		end

	test_utf8_decoding (s: STRING_8; e: STRING_32)
		local
			u: STRING_32
			b: UTF8_ENCODER
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


