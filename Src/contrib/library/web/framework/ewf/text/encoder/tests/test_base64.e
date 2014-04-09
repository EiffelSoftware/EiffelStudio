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

feature -- Tests

	test_valid_64_encoding
		do
			assert ("Expected encoded True:", is_valid_base64_encoding ((create {BASE64}).encoded_string ("content")))
		end

	test_not_valid64_encoding
		do
			assert ("Expected encoded False:", not is_valid_base64_encoding ("content"))
			assert ("Expected encoded False:", not is_valid_base64_encoding ("!@#$%%^"))
		end

feature {NONE} -- Implementation

	is_valid_base64_encoding (a_string: STRING): BOOLEAN
			-- is `a_string' base64 encoded?
		local
			l_encoder: BASE64
			l_string: STRING
			l_retry: BOOLEAN
		do
			if not l_retry then
				create l_encoder
				l_string := l_encoder.decoded_string (a_string)
				Result := not l_encoder.has_error
			end
		rescue
			l_retry := True
			retry
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


