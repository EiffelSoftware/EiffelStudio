note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_REQUEST_PARSER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_get_empty
			-- Tests parsing a get request message for an empty request
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
		do
			create l_parser.make
			l_req := l_parser.request("GET / HTTP/1.1#HI##E##HO##E##SE##E##A#")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				assert ("uri", l_r.uri.is_equal ("/"))
				assert ("headers_in", l_r.headers_in.count = 0)
				assert ("headers_out", l_r.headers_out.count = 0)
				assert ("environment_vars", l_r.environment_vars.count = 0)
				assert ("args", l_r.args.count = 0)
				assert ("args_table", l_r.argument_table.count = 0 )
				assert ("cookies", l_r.cookies.count = 0)
			end
		end

	test_full_get
			-- Test a full get request with in and out headers, se vars, a cookie and three arguments
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
		do
			create l_parser.make
			l_req := l_parser.request("GET /test.xeb?name=admin&password=plain_text&login=true HTTP/1.1#HI##$#Host#%%#localhost:55000#$#Cookie#%%#user=admin#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#E##HO##$#Host#%%#localhost:55000#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#E##SE##$#Host#%%#localhost:55000#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#E##A#&name=admin&password=plain_text&login=true")


			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				assert ("uri", l_r.uri.is_equal ("/test.xeb?name=admin&password=plain_text&login=true"))

				if attached {STRING} l_r.headers_in ["Host"] as l_a then
					assert ("headers_in", l_a.is_equal ("localhost:55000"))
				else
					assert ("headers_in", false)
				end

				if attached {STRING} l_r.headers_in ["User-Agent"] as l_a then
					assert ("headers_in", l_a.is_equal ("Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0"))
				else
					assert ("headers_in", false)
				end

				if attached {STRING} l_r.headers_in ["Accept"] as l_a then
					assert ("headers_in", l_a.is_equal ("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"))
				else
					assert ("headers_in", false)
				end


				if attached {STRING} l_r.headers_out ["Host"] as l_a then
					assert ("headers_out", l_a.is_equal ("localhost:55000"))
				else
					assert ("headers_out", false)
				end

				if attached {STRING} l_r.headers_out ["User-Agent"] as l_a then
					assert ("headers_out", l_a.is_equal ("Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0"))
				else
					assert ("headers_out", false)
				end

				if attached {STRING} l_r.headers_out ["Accept"] as l_a then
					assert ("headers_out", l_a.is_equal ("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"))
				else
					assert ("headers_out", false)
				end


				if attached {STRING} l_r.environment_vars ["Host"] as l_a then
					assert ("environment_vars", l_a.is_equal ("localhost:55000"))
				else
					assert ("environment_vars", false)
				end

				if attached {STRING} l_r.environment_vars ["User-Agent"] as l_a then
					assert ("environment_vars", l_a.is_equal ("Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0"))
				else
					assert ("environment_vars", false)
				end

				if attached {STRING} l_r.environment_vars ["Accept"] as l_a then
					assert ("environment_vars", l_a.is_equal ("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"))
				else
					assert ("environment_vars", false)
				end

				if attached {XH_COOKIE} l_r.cookies ["user"] as l_a then
					assert ("cookie_user_wrong", l_a.value.is_equal ("admin"))
				else
					assert ("cookie_user_missing", false)
				end

				assert ("args", l_r.args.is_equal ("&name=admin&password=plain_text&login=true"))

				if attached {STRING} l_r.argument_table ["name"] as l_a then
					assert ("arg_table_name_wrong", l_a.is_equal ("admin"))
				else
					assert ("arg_table_name_missing", false)
				end

				if attached {STRING} l_r.argument_table ["password"] as l_a then
					assert ("arg_table_password_wrong", l_a.is_equal ("plain_text"))
				else
					assert ("arg_table_password_missing", false)
				end

				if attached {STRING} l_r.argument_table ["login"] as l_a then
					assert ("arg_table_login_wrong", l_a.is_equal ("true"))
				else
					assert ("arg_table_login_missing", false)
				end
			end

		end

	test_get_cookies
			-- New test routine
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
		do
			create l_parser.make

				-- Test three cookies
			l_req := l_parser.request("GET / HTTP/1.1#HI##$#Connection#%%#keep-alive#$#Referer#%%#http://localhost:55000/demoapplication/reservations.xeb#$#Cookie#%%#xuuid=1B9314C9-B147-406C-BB80-7E9572D53B18; place=eiffelstudio, hollister avenue #3 =her; webapp=demoapplication#$#Content-Type#%%#application/text/xml#E##HO##E##SE##E##A#this is unimportant")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				if attached {XH_COOKIE} l_r.cookies ["xuuid"] as l_a then
					assert ("cookie_table_xuuid_wrong_name", l_a.name.is_equal ("xuuid"))
					assert ("cookie_table_xuuid_wrong", l_a.value.is_equal ("1B9314C9-B147-406C-BB80-7E9572D53B18"))
				else
					assert ("cookie_table_xuuid_missing", false)
				end

				if attached {XH_COOKIE} l_r.cookies ["place"] as l_a then
					assert ("cookie_table_place_wrong_name", l_a.name.is_equal ("place"))
					assert ("cookie_table_place_wrong", l_a.value.is_equal ("eiffelstudio, hollister avenue #3 =her"))
				else
					assert ("cookie_table_place_missing", false)
				end

				if attached {XH_COOKIE} l_r.cookies ["webapp"] as l_a then
					assert ("cookie_table_webapp_wrong_name", l_a.name.is_equal ("webapp"))
					assert ("cookie_table_webapp_wrong", l_a.value.is_equal ("demoapplication"))
				else
					assert ("cookie_table_webapp_missing", false)
				end
			end

				-- Test two cookies
			l_req := l_parser.request("GET / HTTP/1.1#HI##$#Connection#%%#keep-alive#$#Referer#%%#http://localhost:55000/demoapplication/reservations.xeb#$#Cookie#%%#xuuid=1B9314C9-B147-406C-BB80-7E9572D53B18; place=eiffelstudio, hollister avenue #3 =her#$#Content-Type#%%#application/text/xml#E##HO##E##SE##E##A#this is unimportant")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				if attached {XH_COOKIE} l_r.cookies ["xuuid"] as l_a then
					assert ("cookie_table_xuuid_wrong_name", l_a.name.is_equal ("xuuid"))
					assert ("cookie_table_xuuid_wrong", l_a.value.is_equal ("1B9314C9-B147-406C-BB80-7E9572D53B18"))
				else
					assert ("cookie_table_xuuid_missing", false)
				end

				if attached {XH_COOKIE} l_r.cookies ["place"] as l_a then
					assert ("cookie_table_place_wrong_name", l_a.name.is_equal ("place"))
					assert ("cookie_table_place_wrong", l_a.value.is_equal ("eiffelstudio, hollister avenue #3 =her"))
				else
					assert ("cookie_table_place_missing", false)
				end
			end
		end


	test_post_form
			-- New test routine
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
		do
			create l_parser.make
			l_req := l_parser.request("POST / HTTP/1.1#HI##$#Content-Type#%%#application/x-www-form-urlencoded#E##HO##E##SE##E##A#&name=admin&password=plain_text&login=true")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("POST"))
				assert ("args", l_r.args.is_equal ("&name=admin&password=plain_text&login=true"))

				if attached {STRING} l_r.argument_table ["name"] as l_a then
					assert ("arg_table_name_wrong", l_a.is_equal ("admin"))
				else
					assert ("arg_table_name_missing", false)
				end

				if attached {STRING} l_r.argument_table ["password"] as l_b then
					assert ("arg_table_password_wrong", l_b.is_equal ("plain_text"))
				else
					assert ("arg_table_password_missing", false)
				end

				if attached {STRING} l_r.argument_table ["login"] as l_c then
					assert ("arg_table_login_wrong", l_c.is_equal ("true"))
				else
					assert ("arg_table_login_missing", false)
				end
			end
		end

	test_post_plain
			-- New test routine
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
		do
			create l_parser.make
			l_req := l_parser.request("POST / HTTP/1.1#HI##$#Content-Type#%%#application/text/xml#E##HO##E##SE##E##A#On this pane enter the information needed to produce synthesized tests. Use thel#E##HO##E##SE##E##A#  Class or type name entry box in  ")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("POST"))
				assert ("args", l_r.args.is_equal ("On this pane enter the information needed to produce synthesized tests. Use thel#E##HO##E##SE##E##A#  Class or type name entry box in  "))
				assert ("argts_table_empty", l_r.argument_table.count = 0)
			end
		end

	test_goto_request
			--
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
			l_req2: detachable XH_REQUEST
			l_request_builder: XH_REQUEST_BUILDER
		do
			create l_parser.make
			l_req := l_parser.request("GET /test/test/index.xeb HTTP/1.1#HI##E##HO##E##SE##E##A#")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				assert ("uri", l_r.uri.is_equal ("/test/test/index.xeb"))

				create l_request_builder.make

				l_req2 := l_request_builder.create_goto_request ("/other_application/home.xeb", l_r)
				assert ("method", l_req2.method.is_equal ("GET"))
				assert ("uri", l_req2.uri.is_equal ("/other_application/home.xeb"))
			end

		end


	test_escaping
				--
		local
			l_parser: XH_REQUEST_PARSER
			l_req: detachable XH_REQUEST
			l_req2: detachable XH_REQUEST
			l_response: XH_RESPONSE
			l_request_builder: XH_REQUEST_BUILDER
			l_bad_cookie_name: STRING
			l_bad_cookie_value: STRING
			l_temp: STRING
			l_temp_name: STRING
			l_temp_value: STRING
		do
			create l_response.make_empty
			l_bad_cookie_name := "name an ; #E# d text #CE# = here"
			l_bad_cookie_value := "value : so ; and = and #CE# and #E#"

			l_response.put_cookie_order (create {XH_COOKIE_ORDER}.make (l_bad_cookie_name, l_bad_cookie_value))

			l_temp := l_response.render_to_string
			l_temp.remove_head ({XU_CONSTANTS}.cookie_start.count)

			l_temp := l_temp.split (';').i_th (1)
			l_temp_name := l_temp.split ('=').i_th (1)
			l_temp_value := l_temp.split ('=').i_th (2)

			create l_parser.make
			l_req := l_parser.request("GET /index.xeb HTTP/1.1#HI##$#Cookie#%%#" + l_temp_name + "=" + l_temp_value + "#E##HO##E##SE##E##A#")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				if attached {XH_COOKIE} l_r.cookies [l_bad_cookie_name] as l_a then
					assert ("cookie_wrong_name", l_a.name.is_equal (l_bad_cookie_name))
					assert ("cookie_wrong", l_a.value.is_equal (l_bad_cookie_value))
				else
					assert ("cookie_missing", false)
				end
			end


		end

end


