note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTTP_AUTHORIZATION_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_basic
			-- New test routine
		local
			l_auth: READABLE_STRING_8
			u,p: detachable READABLE_STRING_32
			h: HTTP_AUTHORIZATION
		do
			l_auth := "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ=="
			create h.make (l_auth)
			assert ("login", attached h.login as l_login and then l_login.same_string ("Aladdin"))
			assert ("password", attached h.password as l_password and then l_password.same_string ("open sesame"))

			check_basic_auth_for_login_password ("Aladdin", "open sesame", "Aladdin")
			check_basic_auth_for_login_password ("", "", "empty")
			check_basic_auth_for_login_password ("@#$@%%@??<.,.,", "@@#$&)&*>M<?>:ASDFDSA''", "symbol")
			check_basic_auth_for_login_password ({STRING_32} "%/20320/%/22909/%/21527/", {STRING_32}"%/20320/%/22909/%/21527/", "unicode")
			check_basic_auth_for_login_password (create {STRING_32}.make_filled ('u', 100) + {STRING_32}"%/20320/%/22909/%/21527/", create {STRING_32}.make_filled ('p', 100) + {STRING_32}"%/20320/%/22909/%/21527/", "long unicode")
		end

feature -- Impl

	check_basic_auth_for_login_password (u,p: READABLE_STRING_32; a_title: READABLE_STRING_8)
		local
			h: HTTP_AUTHORIZATION
			l_auth: detachable READABLE_STRING_8
		do
			create h.make_basic_auth (u, p)
			assert (a_title + ":login", attached h.login as l_login and then l_login.same_string (u))
			assert (a_title + ":password", attached h.password as l_password and then l_password.same_string (p))
			l_auth := h.http_authorization

			create h.make (l_auth)
			assert (a_title + ":basic", h.type.is_case_insensitive_equal ("Basic"))
			assert (a_title + ":login", attached h.login as l_login and then l_login.same_string (u))
			assert (a_title + ":password", attached h.password as l_password and then l_password.same_string (p))
		end

end


