note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WSF_REQUEST_MIME_HANDLER

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

	test_mime_handler
		local
			req: WSF_REQUEST
			b: STRING_8
			h: WSF_HEADER
			ct: HTTP_CONTENT_TYPE
			m: ARRAY [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]
		do
			m := <<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/auto/test/foo"],
						["SCRIPT_NAME", "/auto/test/test.ews"],
						["PATH_INFO", "/foo"]
					>>

			create ct.make_from_string ({HTTP_MIME_TYPES}.multipart_form_data)
			ct.add_parameter ("boundary", "__=_the_boundary_1332296477_1804289383_=__")
			create h.make
			h.put_content_type (ct.string)

			b := "[
--__=_the_boundary_1332296477_1804289383_=__
Content-Disposition: form-data; name="user_name"

EWFdemo
--__=_the_boundary_1332296477_1804289383_=__
Content-Disposition: form-data; name="password"

EWFpassword
--__=_the_boundary_1332296477_1804289383_=__--
]"
			b.replace_substring_all ("%N", "%R%N")
			h.put_content_length (b.count)

			--| Case #1
			req := new_request (m, h.string, b)
			assert ("found user_name", attached req.form_parameter ("user_name") as u and then u.same_string ("EWFdemo"))
			assert ("found password", attached req.form_parameter ("password") as u and then u.same_string ("EWFpassword"))
		end

feature {NONE} -- Implementation

	new_request (a_meta: ARRAY [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]; h: READABLE_STRING_8; s: READABLE_STRING_8): WSF_REQUEST_NULL
		local
			wgi_req: WGI_REQUEST
			l_header: WSF_HEADER
			lst: ARRAYED_LIST [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]
			vn: STRING_8
		do
			create lst.make (10)
			across
				a_meta as c
			loop
				lst.extend (c.item)
			end

			create l_header.make_from_raw_header_data (h)
			across
				l_header.to_name_value_iterable as c
			loop
				--| for Any Abc-Def-Ghi add (or replace) the HTTP_ABC_DEF_GHI variable to `env'
				vn := c.item.name.as_upper

				vn.replace_substring_all ("-", "_")
				if
					vn.starts_with ("CONTENT_") and then
					(vn.same_string_general ({WGI_META_NAMES}.content_type) or vn.same_string_general ({WGI_META_NAMES}.content_length))
				then
					--| Keep this name
				else
					vn.prepend ("HTTP_")
				end
				lst.extend ([vn, c.item.value])
--				lst.extend (c.item)
			end

			create {WGI_REQUEST_NULL} wgi_req.make_with_body (lst, s)
			create Result.make_from_wgi (wgi_req)
		end

end


