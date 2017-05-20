note
	description: "Test for OTP"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OTP

inherit
	EQA_TEST_SET

feature -- Test routines

	test_totp
		local
			otp: TOTP
			dt: DATE_TIME
		do
			create otp.make_with_secret ("EQMOKRISKLOH6KYV")
			create dt.make (2016, 11, 16, 13, 25, 0)
			assert ("time_token", otp.time_token_at (dt).same_string_general ("936751"))

			assert ("time_token", otp.time_token.count = 6)

			assert ("counter_token", otp.token (123456).same_string_general ("730548"))
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
