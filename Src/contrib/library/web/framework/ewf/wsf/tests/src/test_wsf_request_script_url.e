note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WSF_REQUEST_SCRIPT_URL

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

	test_script_url_1
		local
			req: WSF_REQUEST
			s: READABLE_STRING_8
		do
			--| Case #1
			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/foo/bar/test/home"],
						["SCRIPT_NAME", "/foo/bar/app.ext"],
						["PATH_INFO", "/test/home"]
					>>
				)
			s := req.script_url ("/new/path/")
			assert ("script_url (/new/path/) = %""+s+"%" but should be %"/foo/bar/new/path/%"", s.same_string ("/foo/bar/new/path/"))
			assert ("valid path info", req.path_info.same_string_general ("/test/home"))
			assert ("valid path info", req.percent_encoded_path_info.same_string_general ("/test/home"))
		end

	test_script_url_2
		local
			req: WSF_REQUEST
			s: READABLE_STRING_8
		do
			--| Case #2			
			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/foo/bar/abc/DEF"],
						["SCRIPT_NAME", "/foo/bar/app.ext"],
						["PATH_INFO", "/abc/DEF"]
					>>
				)
			s := req.script_url ("/new/path/")
			assert ("script_url (/new/path/) = %""+s+"%" but should be %"/foo/bar/new/path/%"", s.same_string ("/foo/bar/new/path/"))
		end

	test_script_url_3
		local
			req: WSF_REQUEST
			s: READABLE_STRING_8
		do
			--| Case #3		
			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/intranet/collab/cms/home"],
						["SCRIPT_NAME", "/intranet/collab/collab.ews"],
						["PATH_INFO", "/home"]
					>>
				)
			s := req.script_url ("/new/path/")
			assert ("script_url (/new/path/) = %""+s+"%" but should be %"/intranet/collab/cms/new/path/%"", s.same_string ("/intranet/collab/cms/new/path/"))
			assert ("path_info", req.path_info.same_string_general ("/home"))
			assert ("percent_encoded_path_info", req.percent_encoded_path_info.same_string_general ("/home"))
		end

	test_script_url_4
		local
			req: WSF_REQUEST
			s: READABLE_STRING_8
		do
			--| Case #3		
			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/support/"],
						["SCRIPT_NAME", "/support/esa_api.exe"],
						["PATH_INFO", ""]
					>>
				)
			s := req.script_url ("/new/path/")
			assert ("script_url (/new/path/) = %""+s+"%" but should be %"/support/new/path/%"", s.same_string ("/support/new/path/"))
			assert ("path_info", req.path_info.same_string_general (""))
			assert ("percent_encoded_path_info", req.percent_encoded_path_info.same_string_general (""))
		end

	test_script_url_5
		local
			req: WSF_REQUEST
			s: READABLE_STRING_8
		do
			--| Case #3		
			req := new_request (<<
						["REQUEST_METHOD", "GET"],
						["QUERY_STRING", ""],
						["REQUEST_URI", "/support/"],
						["SCRIPT_NAME", "/support/esa_api.exe"],
						["PATH_INFO", "/"]
					>>
				)
			s := req.script_url ("/new/path/")
			assert ("script_url (/new/path/) = %""+s+"%" but should be %"/support/new/path/%"", s.same_string ("/support/new/path/"))
			assert ("path_info", req.path_info.same_string_general ("/"))
			assert ("percent_encoded_path_info", req.percent_encoded_path_info.same_string_general ("/"))
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


