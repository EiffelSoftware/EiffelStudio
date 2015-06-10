note
	description: "Summary description for {TEST_WSF_RESPONSE_TEST_SUITE}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_WSF_RESPONSE_TEST_SUITE

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	WGI_EXPORTER
		undefine
			default_create
		end

feature {NONE} -- Events

	on_prepare
		do
		end

feature -- Test Cases

	test_add_single_cookie
		local
			w_res: WSF_RESPONSE
			l_cookie: WSF_COOKIE
			l_header: WSF_HEADER
			l_res: WGI_RESPONSE_NULL
		do
			create {WGI_RESPONSE_NULL} l_res.make
			create w_res.make_from_wgi (l_res)

			create l_header.make
			l_header.put_content_type_text_html

			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly"))

			w_res.put_header_text (l_header.string)
			w_res.add_cookie (l_cookie)
			w_res.set_status_code ({HTTP_STATUS_CODE}.ok)
			w_res.put_string ("Test")
			assert ("Expected", l_res.output.same_string("200 %R%NContent-Type: text/html%R%NSet-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly%R%N%R%NTest") )
		end


	test_add_multiple_cookiewith_similar_cookie_name
		local
			w_res: WSF_RESPONSE
			l_cookie: WSF_COOKIE
			l_header: WSF_HEADER
			l_res: WGI_RESPONSE_NULL
		do
			create {WGI_RESPONSE_NULL} l_res.make
			create w_res.make_from_wgi (l_res)

			create l_header.make
			l_header.put_content_type_text_html

			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly"))
			w_res.put_header_text (l_header.string)
			w_res.add_cookie (l_cookie)


			create l_cookie.make ("user_id", "newUser")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=newUser; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly"))

			w_res.add_cookie (l_cookie) -- Ignored
			w_res.set_status_code ({HTTP_STATUS_CODE}.ok)
			w_res.put_string ("Test")
			assert ("Expected", l_res.output.same_string("200 %R%NContent-Type: text/html%R%NSet-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly%R%N%R%NTest") )
		end


	test_add_multiple_cookie_with_similar_cookie_name_2
		local
			w_res: WSF_RESPONSE
			l_cookie: WSF_COOKIE
			l_header: WSF_HEADER
			l_res: WGI_RESPONSE_NULL
		do
			create {WGI_RESPONSE_NULL} l_res.make
			create w_res.make_from_wgi (l_res)

			create l_header.make
			l_header.put_content_type_text_html
			w_res.put_header_text (l_header.string)

			create l_cookie.make ("user_id", "u12345")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly"))


			w_res.add_cookie (l_cookie)
			create l_cookie.make ("user_id", "newUser")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: user_id=newUser; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly"))

			w_res.add_cookie (l_cookie) -- Ignored


			create l_cookie.make ("ewf_sessionid", "test")
			l_cookie.set_domain ("www.example.com")
			l_cookie.set_expiration ("Sat, 18 Apr 2015 21:22:05 GMT")
			l_cookie.set_path ("/")
			l_cookie.set_secure (True)
			l_cookie.set_http_only (True)
			assert("Expected", l_cookie.header_line.same_string ("Set-Cookie: ewf_sessionid=test; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly"))

			w_res.add_cookie (l_cookie)
			w_res.set_status_code ({HTTP_STATUS_CODE}.ok)
			w_res.put_string ("Test")
			assert ("Expected", l_res.output.same_string("200 %R%NContent-Type: text/html%R%NSet-Cookie: user_id=u12345; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly%R%NSet-Cookie: ewf_sessionid=test; Domain=www.example.com; Path=/; Expires=Sat, 18 Apr 2015 21:22:05 GMT; Max-Age=-1; Secure; HttpOnly%R%N%R%NTest") )
		end
end
