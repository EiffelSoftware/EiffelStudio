note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	TEST_HTTP_CLIENT_I

inherit
	EQA_TEST_SET

feature -- Factory

	new_session (a_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		deferred
		end

feature -- Test routines

	test_http_client
			-- New test routine
		local
			sess: like new_session
			h: STRING_8
		do
			sess := new_session ("http://www.google.com")
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
				else
					assert ("missing body", False)
				end
				assert ("same headers", h.same_string (res.raw_header))
			end
		end

	test_http_client_ssl
			-- New test routine
		local
			sess: like new_session
			h: STRING_8
		do
			sess := new_session ("https://www.eiffel.org")
			sess.set_is_insecure (True)
			if attached sess.get ("/welcome", Void) as res then
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
		end

	test_abs_url
		local
			sess: like new_session
			h: STRING_8
			l_url: STRING
		do
			sess := new_session ("https://www.eiffel.org")
			l_url := "/foo/bar"
			assert ("abs rel", sess.url (l_url, Void).same_string (sess.base_url + l_url))

			l_url := "https://www.eiffel.org/foo/bar"
			assert ("abs 1", sess.url (l_url, Void).same_string (l_url))
			l_url := "https://example.com/foo/bar"
			assert ("abs 2", sess.url (l_url, Void).same_string (l_url))
		end

	test_headers
		local
			res: HTTP_CLIENT_RESPONSE
			h: STRING
		do
			create res.make ("http://example.com/")
			create h.make_empty
			h.append ("normal: NORMAL%R%N")
			h.append ("concat: ABC%R%N")
			h.append ("concat: DEF%R%N")
			h.append ("key1: KEY%R%N")
			h.append (" key2 : KEY%R%N")
			h.append (" %T key3    : KEY%R%N")
			h.append ("value1:VALUE%R%N")
			h.append ("value2: VALUE%R%N")
			h.append ("value3:  VALUE%R%N")
			h.append ("value4:   VALUE   %R%N")
			h.append ("  %Tfoo  	:	BAR%T   %R%N")
			res.set_raw_header (h)
			create h.make_empty
			if attached res.headers as hds then
				across
					hds as c
				loop
					h.append (c.item.name + ": " + c.item.value + "%N")
				end
			end
			assert ("Expected headers map", h.same_string (
"[
normal: NORMAL
concat: ABC
concat: DEF
key1: KEY
key2: KEY
key3: KEY
value1: VALUE
value2: VALUE
value3: VALUE
value4: VALUE
foo: BAR

]"))
		end

end


