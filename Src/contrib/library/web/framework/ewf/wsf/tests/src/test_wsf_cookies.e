note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WSF_COOKIES

inherit
	EQA_TEST_SET

	WSF_SERVICE
		undefine
			default_create
		end

feature {NONE} -- Events

	port_number: INTEGER
	base_url: detachable STRING

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			--| do nothing
		end

feature -- Tests

	test_cookies
		local
			req: WSF_REQUEST
		do
			--| Case #1
			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "name=value; name2=value2"]
					>>
				)
			assert ("#1 cookie name", attached {WSF_STRING} req.cookie ("name") as v and then v.value.is_case_insensitive_equal ("value"))
			assert ("#1 cookie name2", attached {WSF_STRING} req.cookie ("name2") as v and then v.value.is_case_insensitive_equal ("value2"))

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "name=value"]
					>>
				)
			assert ("#2 cookie name", attached {WSF_STRING} req.cookie ("name") as v and then v.value.is_case_insensitive_equal ("value"))

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "name=value;"]
					>>
				)
			assert ("#3 cookie name", attached {WSF_STRING} req.cookie ("name") as v and then v.value.is_case_insensitive_equal ("value"))

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "name1=value1; namewithoutvalue"]
					>>
				)
			assert ("#4 cookie name1", attached {WSF_STRING} req.cookie ("name1") as v and then v.value.is_case_insensitive_equal ("value1"))
			assert ("#4 cookie namewithoutvalue", attached {WSF_STRING} req.cookie ("namewithoutvalue") as v and then v.value.is_empty)

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "name1=value1; foo=;"]
					>>
				)
			assert ("#5 cookie name1", attached {WSF_STRING} req.cookie ("name1") as v and then v.value.is_case_insensitive_equal ("value1"))
			assert ("#5 cookie foo", attached {WSF_STRING} req.cookie ("foo") as v and then v.value.is_empty)

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "name1=value1; foo="]
					>>
				)
			assert ("#6 cookie name1", attached {WSF_STRING} req.cookie ("name1") as v and then v.value.is_case_insensitive_equal ("value1"))
			assert ("#6 cookie foo", attached {WSF_STRING} req.cookie ("foo") as v and then v.value.is_empty)

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "foo="]
					>>
				)
			assert ("#7 cookie foo", attached {WSF_STRING} req.cookie ("foo") as v and then v.value.is_empty)

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "foo"]
					>>
				)
			assert ("#8 cookie foo", attached {WSF_STRING} req.cookie ("foo") as v and then v.value.is_empty)

			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/cookie"],
						["HTTP_COOKIE", "foo;"]
					>>
				)
			assert ("#9 cookie foo", attached {WSF_STRING} req.cookie ("foo") as v and then v.value.is_empty)
		end

feature {NONE} -- Implementation

	new_request (a_meta: ARRAY [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]): WSF_REQUEST_NULL
		local
			wgi_req: WGI_REQUEST
		do
			create {WGI_REQUEST_NULL} wgi_req.make_with_file (a_meta, io.input)
			create Result.make_from_wgi (wgi_req)
		end

end


