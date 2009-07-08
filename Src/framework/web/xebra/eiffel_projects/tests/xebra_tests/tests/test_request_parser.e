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
			-- Tests parsing a request message for an empty request
		local
			l_fac: XH_REQUEST_FACTORY
			l_req: detachable XH_REQUEST
		do
			create l_fac.make
			l_req := l_fac.request("GET / HTTP/1.1#HI##E##HO##E##SE##E##A#")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				assert ("uri", l_r.target_uri.is_equal ("/"))
				assert ("headers_in", l_r.headers_in.count = 0)
				assert ("headers_out", l_r.headers_out.count = 0)
				assert ("environment_vars", l_r.environment_vars.count = 0)
				assert ("args", l_r.args.count = 0)
				assert ("args_table", l_r.argument_table.count = 0 )
				assert ("cookies", l_r.cookies.count = 0)

			end
		end

	test_full_get
			-- New test routine
		local
			l_fac: XH_REQUEST_FACTORY
			l_req: detachable XH_REQUEST
		do
			create l_fac.make
			l_req := l_fac.request("GET /test.xeb?name=admin&password=plain_text&login=true HTTP/1.1#HI##$#Host#%%#localhost:55000#$#Cookie#%%#user=admin#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#E##HO##$#Host#%%#localhost:55000#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#E##SE##$#Host#%%#localhost:55000#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#E##A#&name=admin&password=plain_text&login=true")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("method", l_r.method.is_equal ("GET"))
				assert ("uri", l_r.target_uri.is_equal ("/test.xeb?name=admin&password=plain_text&login=true"))

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
					assert ("arg_table_password_wrong", l_a.is_equal ("plain"))
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


	test_post_form
			-- New test routine
		local
			l_fac: XH_REQUEST_FACTORY
			l_req: detachable XH_REQUEST
		do
			create l_fac.make
			l_req := l_fac.request("GET / HTTP/1.1#HI##$#Content-Type#%%#application/x-www-form-urlencoded#E##HO##E##SE##E##A#&name=admin&password=plain_text&login=true")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("args", l_r.args.is_equal ("&name=admin&password=plain_text&login=true"))

				if attached {STRING} l_r.argument_table ["name"] as l_a then
					assert ("arg_table_name_wrong", l_a.is_equal ("admin"))
				else
					assert ("arg_table_name_missing", false)
				end

				if attached {STRING} l_r.argument_table ["password"] as l_a then
					assert ("arg_table_password_wrong", l_a.is_equal ("plain"))
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

	test_post_plain
			-- New test routine
		local
			l_fac: XH_REQUEST_FACTORY
			l_req: detachable XH_REQUEST
		do
			create l_fac.make
			l_req := l_fac.request("GET / HTTP/1.1#HI##$#Content-Type#%%#application/text/xml#E##HO##E##SE##E##A#On this pane enter the information needed to produce synthesized tests. Use thel#E##HO##E##SE##E##A#  Class or type name entry box in  ")

			assert ("Parsing ok", attached l_req)
			if attached {XH_REQUEST} l_req as l_r then
				assert ("args", l_r.args.is_equal ("On this pane enter the information needed to produce synthesized tests. Use thel#E##HO##E##SE##E##A#  Class or type name entry box in  "))
				assert ("argts_table_empty", l_r.argument_table.count = 0)
			end
		end
end


