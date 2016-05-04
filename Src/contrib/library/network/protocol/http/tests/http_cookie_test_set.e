note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTTP_COOKIE_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_cookie_expected_header
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345"))
		end

	test_cookie_value_with_illegal_characters
			-- values (cookie name and value)
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			assert ("Not valid space", not l_cookie.has_valid_characters ("Use! 12"))
			assert ("Not valid comma", not l_cookie.has_valid_characters ("Use!,12"))
			assert ("Not valid semicolon", not l_cookie.has_valid_characters ("Use!;12"))
			assert ("Not valid backslash", not l_cookie.has_valid_characters ("Use!\12"))
			assert ("Not valid Dquote", not l_cookie.has_valid_characters ("Use!%"12"))
		end

	test_cookie_empty_value
			-- values (cookie name and value)
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "")
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id="))
		end

	test_cookie_full_attributes
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			l_cookie.set_max_age (1)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=1; Secure; HttpOnly"))
		end

	test_cookie_include_expires
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Secure; HttpOnly"))
		end

	test_cookie_full_include_max_age
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			l_cookie.set_max_age (1)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=1; Secure; HttpOnly"))
		end

	test_cookie_defaults_and_http_only
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; HttpOnly"))
		end

	test_cookie_defaults_and_secure
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_secure (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Secure"))
		end


	test_cookie_default_and_domain
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com"))
		end


	test_cookie_default_and_path
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_path ("/")
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Path=/"))
		end

	test_cookie_default_and_custom_max_age
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_max_age (120)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Max-Age=120"))
		end

	test_cookie_date_rfc1123_valid
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			assert ("Valid RFC1123", l_cookie.is_valid_rfc1123_date ("Thu, 19 Mar 2015 16:14:03 GMT"))
		end

	test_cookie_date_rfc1123_invalid
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			assert ("Invalid RFC1123", not l_cookie.is_valid_rfc1123_date ("Thuesday, 19 Mar 2015 16:14:03 GMT"))
		end

	test_cookie_without_max_age_and_expires
		local
			l_cookie: HTTP_COOKIE
		do
			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Secure; HttpOnly"))
		end


end


