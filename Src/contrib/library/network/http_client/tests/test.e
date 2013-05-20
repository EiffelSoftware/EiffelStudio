class TEST

create
	make

feature -- Init

	make
		do
			test_http_client
		end

	test_http_client
			-- New test routine
		local
			sess: LIBCURL_HTTP_CLIENT_SESSION
			h: STRING_8
		do
			create sess.make ("http://www.google.com")
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
				e.set_message (m)
				e.raise
			end
		end

end
