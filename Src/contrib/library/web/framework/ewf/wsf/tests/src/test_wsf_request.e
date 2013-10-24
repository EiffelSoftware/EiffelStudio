note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WSF_REQUEST

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

	TEST_SERVICE
		undefine
			default_create
		end

feature {NONE} -- Events

	web_app: detachable NINO_SERVICE

	port_number: INTEGER
	base_url: detachable STRING

	on_prepare
			-- <Precursor>
		local
			app: NINO_SERVICE
			wt: WORKER_THREAD
			e: EXECUTION_ENVIRONMENT
		do
			create e
--			port_number := 9091 -- Uncomment to use with server outside this process
			if port_number = 0 then
				server_log ("== Current directory: " + e.current_working_directory)

				port_number := 0
				base_url := "/test/"
				create app.make_custom (to_wgi_service, base_url)
				web_app := app

				create wt.make (agent app.listen (port_number))
				wt.launch
				e.sleep (1_000_000_000 * 5)
				port_number := app.port
				server_log ("Server port=" + port_number.out)
			else
				server_log ("Use existing server")
				server_log ("== Current directory: " + e.current_working_directory)

			end
		end

	server_log_name: STRING
		local
			fn: FILE_NAME
		once
			create fn.make_from_string ("..")
			fn.extend ("..")
			fn.extend ("..")
			fn.extend ("..")
			fn.extend ("..")
			fn.extend ("server_test.log")
			Result := fn.string
		end

	server_log (m: STRING_8)
		local
			f: RAW_FILE
		do
			create f.make_open_append (server_log_name)--"..\server-tests.log")
			f.put_string (m)
			f.put_character ('%N')
			f.close
		end

	test_url (a_query_url: READABLE_STRING_8): READABLE_STRING_8
		local
			b: like base_url
		do
			b := base_url
			if b = Void then
				b := ""
			end
			Result := b + a_query_url
		end

	on_clean
			-- <Precursor>
		do
			if attached web_app as app then
				app.shutdown
			end
		end

	http_session: detachable HTTP_CLIENT_SESSION

	get_http_session
		local
			h: LIBCURL_HTTP_CLIENT
			b: like base_url
		do
			create h.make
			b := base_url
			if b = Void then
				b := "/"
			end
			if attached {HTTP_CLIENT_SESSION} h.new_session ("localhost:" + port_number.out + b) as sess then
				http_session := sess
				sess.set_timeout (-1)
				sess.set_is_debug (True)
				sess.set_connect_timeout (-1)
--				sess.set_proxy ("127.0.0.1", 8888) --| inspect traffic with http://www.fiddler2.com/								
			end
		end

	test_get_request (a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; a_expected_body: READABLE_STRING_8)
		do
			get_http_session
			if attached http_session as sess then
				if attached sess.get (a_url, adapted_context (ctx)) as res then
					if attached res.body as l_body then
						if res.error_occurred then
							assert ("Request %""+a_url+"%" failed, got=[" + l_body + "]", False)
						else
							assert ("Good answer got=%""+l_body+"%" expected=%""+a_expected_body+"%"", l_body.same_string (a_expected_body))
						end
					else
						assert ("Request %""+a_url+"%" failed, no body, status=" + res.status.out , False)
					end
				end
			end
		end

	test_post_request (a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; a_expected_body: READABLE_STRING_8)
		do
			get_http_session
			if attached http_session as sess then
				if attached sess.post (a_url, adapted_context (ctx), Void) as res and then not res.error_occurred and then attached res.body as l_body then
					assert ("Good answer got=%""+l_body+"%" expected=%""+a_expected_body+"%"", l_body.same_string (a_expected_body))
				else
					assert ("Request %""+a_url+"%" failed", False)
				end
			end
		end

	test_post_request_with_filename (a_url: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; a_fn: STRING; a_expected_body: READABLE_STRING_8)
		do
			get_http_session
			if attached http_session as sess then
				if attached sess.post_file (a_url, adapted_context (ctx), a_fn) as res and then not res.error_occurred and then attached res.body as l_body then
					assert ("Good answer got=%""+l_body+"%" expected=%""+a_expected_body+"%"", l_body.same_string (a_expected_body))
				else
					assert ("Request %""+a_url+"%" failed", False)
				end
			end
		end

	adapted_context (ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_REQUEST_CONTEXT
		do
			if ctx /= Void then
				Result := ctx
			else
				create Result.make
			end
--			Result.set_proxy ("127.0.0.1", 8888) --| inspect traffic with http://www.fiddler2.com/			
		end

feature -- Test routines

	test_get_request_01
			-- New test routine
		do
			get_http_session
			if attached http_session as sess then
				test_get_request ("get/01", Void, "get-01")
				test_get_request ("get/01/?foo=bar", Void, "get-01(foo=bar)")
				test_get_request ("get/01/?foo=bar&abc=def", Void, "get-01(foo=bar&abc=def)")
				test_get_request ("get/01/?lst=a&lst=b", Void, "get-01(lst=[a,b])")
			else
				assert ("not_implemented", False)
			end
		end

	test_post_request_uploaded_file
			-- New test routine
		local
			fn: FILE_NAME
			f: RAW_FILE
			s: STRING
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			get_http_session
			if attached http_session as sess then
				create fn.make_temporary_name
				create f.make_create_read_write (fn.string)
				s := "This is an uploaded file%NTesting purpose%N"
				f.put_string (s)
				f.close
				test_post_request_with_filename ("post/file/01", Void, fn.string, "post-file-01%N" + s)

				create ctx.make
				ctx.add_form_parameter ("foo", "bar")
				test_post_request_with_filename ("post/file/01", ctx, fn.string, "post-file-01%N" + s)
			else
				assert ("not_implemented", False)
			end
		end

	test_post_request_01
			-- New test routine
		local
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			get_http_session
			if attached http_session as sess then
				create ctx.make
				ctx.add_form_parameter ("id", "123")
				ctx.add_form_parameter ("Eiffel", "Web")
				test_post_request ("post/01", ctx, "post-01 : " + ctx.form_parameters_to_url_encoded_string)
				test_post_request ("post/01/?foo=bar", ctx, "post-01(foo=bar) : " + ctx.form_parameters_to_url_encoded_string)
				test_post_request ("post/01/?foo=bar&abc=def", ctx, "post-01(foo=bar&abc=def) : " + ctx.form_parameters_to_url_encoded_string)
				test_post_request ("post/01/?lst=a&lst=b", ctx, "post-01(lst=[a,b]) : " + ctx.form_parameters_to_url_encoded_string)
			else
				assert ("not_implemented", False)
			end
		end

end


