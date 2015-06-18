note
	description: "Summary description for {TEST_HMAC_SHA1_SIGNATURE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_SHA1_SIGNATURE_SERVICE

inherit

	EQA_TEST_SET

feature -- Tests

	test_return_signature
		local
			l_service : HMAC_SHA1_SIGNATURE_SERVICE
			l_expected: STRING
		do
			l_expected := "uGymw2KHOTWI699YEaoi5xyLT50="
			create l_service
			assert("Expected:uGymw2KHOTWI699YEaoi5xyLT50==", l_service.signature ("base string", "api secret", "token secret").is_equal (l_expected))
		end
note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
