class TEST

create
	make

feature -- Init

	make
		local
			null: NULL_HTTP_CLIENT_SESSION
		do
			create null.make ("http://example.com/")
			check not null.is_available end
			
			test_get_with_authentication
			test_http_client
		end

	test_get_with_authentication
		local
			cl: DEFAULT_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
				-- GET REQUEST WITH AUTHENTICATION, see http://browserspy.dk/password.php
				-- check header WWW-Authenticate is received (authentication successful)
			create cl
			sess := cl.new_session ("http://browserspy.dk")
			sess.set_credentials ("test", "test")
			create ctx.make_with_credentials_required
			if attached sess.get ("/password-ok.php", ctx) as res then
				if attached {READABLE_STRING_8} res.body as l_body then
					assert ("Fetch all body, including closing html tag", l_body.has_substring ("</html>"))
				else
					assert ("has body", False)
				end
			end
		end

	test_http_client
			-- New test routine
		local
			cl: DEFAULT_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			h: STRING_8
		do
			create cl
			sess := cl.new_session ("http://www.google.com")
			if attached sess.get ("/search?q=eiffel", Void) as res then
				assert ("Get returned without error", not res.error_occurred)
				create h.make_empty
				if attached res.headers as hds then
					across
						hds as c
					loop
						h.append (c.item.name + ": " + c.item.value + "%R%N")
					end
				end
				if attached res.body as l_body then
					assert ("body not empty", not l_body.is_empty)
				end
				assert ("same headers", h.same_string (res.raw_header))
			else
				assert ("Not found", False)
			end
		end

	assert (m: READABLE_STRING_8; b: BOOLEAN)
		local
			e: DEVELOPER_EXCEPTION
		do
			if not b then
				create e
				e.set_description (m)
				e.raise
			end
		end

end
