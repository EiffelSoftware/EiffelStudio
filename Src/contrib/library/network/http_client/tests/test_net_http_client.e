note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_NET_HTTP_CLIENT

inherit
	TEST_HTTP_CLIENT_I

feature -- Factory

	new_session (a_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		do
			create {NET_HTTP_CLIENT_SESSION} Result.make (a_url)
		end

feature -- Tests

	test_net_http_client
		do
			test_http_client
		end

	test_net_http_client_ssl
		do
			test_http_client_ssl
		end

	test_net_abs_url
		do
			test_abs_url
		end

	test_net_headers
		do
			test_headers
		end

	test_persistent_connection
		local
			sess: like new_session
			h: STRING_8
		do
			sess := new_session ("http://www.google.fr")
			if attached sess.get ("/", Void) as res then
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
				else
					assert ("missing body", False)
				end
				assert ("same headers", h.same_string (res.raw_header))
			end
			if attached sess.get ("/", Void) as res then
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
				else
					assert ("missing body", False)
				end
				assert ("same headers", h.same_string (res.raw_header))
			end
			sess.close
		end


end


