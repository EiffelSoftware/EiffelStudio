note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IMAGE_UPLOADER

inherit
	ANY

	WSF_ROUTED_SKELETON_SERVICE
		undefine
			requires_proxy
		end

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

	WSF_NO_PROXY_POLICY

	WSF_DEFAULT_SERVICE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current
		do
			initialize_router


				-- To use particular port number (as 9090) with Nino connector
				-- Uncomment the following line
			set_service_option ("port", 9090)
			make_and_launch
		end

	setup_router
			-- Setup router
		local
			www: WSF_FILE_SYSTEM_HANDLER
		do
			map_uri_template_agent ("/upload{?nb}", agent execute_upload)

			create www.make (document_root)
			www.set_directory_index (<<"index.html">>)
			www.set_not_found_handler (agent execute_not_found)
			router.handle_with_request_methods ("", www, router.methods_GET)
		end

feature -- Configuration		

	document_root: READABLE_STRING_8
			-- Document root to look for files or directories
		local
			e: EXECUTION_ENVIRONMENT
			dn: DIRECTORY_NAME
		once
			create e
			create dn.make_from_string (e.current_working_directory)
			dn.extend ("htdocs")
			Result := dn.string
			if Result [Result.count] = Operating_environment.directory_separator then
				Result := Result.substring (1, Result.count - 1)
			end
		ensure
			not Result.ends_with (Operating_environment.directory_separator.out)
		end

	files_root: READABLE_STRING_8
			-- Uploaded files will be stored in `files_root' folder
		local
			dn: DIRECTORY_NAME
		once
			create dn.make_from_string (document_root)
			dn.extend ("files")
			Result := dn.string
		end

feature -- Execution

	execute_not_found (uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- `uri' is not found, redirect to default page
		do
			res.redirect_now_with_content (req.script_url ("/"), uri + ": not found.%NRedirection to " + req.script_url ("/"), "text/html")
		end

	execute_upload (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Upload page is requested, either GET or POST
			-- On GET display the web form to upload file, by passing ?nb=5 you can upload 5 images
			-- On POST display the uploaded files
		local
			l_body: STRING_8
			l_safe_filename: STRING_8
			fn: FILE_NAME
			page: WSF_HTML_PAGE_RESPONSE
			n: INTEGER
		do
			if req.is_request_method ("GET") or else not req.has_uploaded_file then
				create page.make
				page.set_title ("EWF: Upload file")
				page.add_style (req.script_url ("style.css"), "all")
				create l_body.make_empty
				page.set_body (l_body)
				l_body.append ("<h1>EWF: Upload image file</h1>%N")
				l_body.append ("<form action=%""+ req.script_url ("/upload") +"%" method=%"POST%" enctype=%"multipart/form-data%">%N")
				if attached {WSF_STRING} req.query_parameter ("nb") as p_nb and then p_nb.is_integer then
					n := p_nb.integer_value
				else
					n := 1
				end
				if attached {WSF_STRING} req.query_parameter ("demo") as p_demo then
					create fn.make_from_string (document_root)
					fn.set_file_name (p_demo.value)
					l_body.append ("File: <input type=%"file%" name=%"uploaded_file[]%" size=%"60%" value=%""+ html_encode (fn.string) +"%"></br>%N")
				end

				from
				until
					n = 0
				loop
					l_body.append ("File: <input type=%"file%" name=%"uploaded_file[]%" size=%"60%" accept=%"image/*%"></br>%N")
					n := n - 1
				end
				l_body.append ("	<input type=%"submit%" value=%"Upload%"/>%N</form>")
				res.send (page)
			else
				create l_body.make (255)
				l_body.append ("<h1>EWF: Uploaded files</h1>%N")
				l_body.append ("<ul>")
				across
					req.uploaded_files as c
				loop
					l_body.append ("<li>")
					l_body.append ("<div>" + c.item.name + "=" + html_encode (c.item.filename) + " size=" + c.item.size.out + " type=" + c.item.content_type + "</div>")
					create fn.make_from_string (files_root)
					l_safe_filename := c.item.safe_filename
					fn.set_file_name (l_safe_filename)
					if c.item.move_to (fn.string) then
						if c.item.content_type.starts_with ("image") then
							l_body.append ("%N<a href=%"../files/" + url_encode (l_safe_filename) + "%"><img src=%"../files/"+ l_safe_filename +"%" /></a>")
						else
							l_body.append ("File " + html_encode (c.item.filename) + " is not a supported image<br/>%N")
						end
					end
					l_body.append ("</li>")
				end
				l_body.append ("</ul>")

				create page.make
				page.set_title ("EWF: uploaded image")
				page.add_style ("../style.css", "all")
				page.set_body (l_body)
				res.send (page)
			end
		end

feature {NONE} -- Encoder

	url_encode (s: READABLE_STRING_32): STRING_8
			-- URL Encode `s' as Result
		do
			Result := url_encoder.encoded_string (s)
		end

	url_encoder: URL_ENCODER
		once
			create Result
		end

	html_encode (s: READABLE_STRING_32): STRING_8
			-- HTML Encode `s' as Result	
		do
			Result := html_encoder.encoded_string (s)
		end

	html_encoder: HTML_ENCODER
		once
			create Result
		end

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
