note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_BASE64

inherit
	EQA_TEST_SET

feature -- Test routines

	test_base64_encoder
		note
			testing:  "base64"
		do
			test_base64_encoding ("Il était une fois !")
		end

	test_base64_encoding (s: STRING_8)
		local
			u: STRING_8
			e: STRING_8
			b: BASE64
		do
			create b
			e := b.encoded_string (s)
			u := b.decoded_string (e)
			assert ("decoded encoded string is same", u ~ s)
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


