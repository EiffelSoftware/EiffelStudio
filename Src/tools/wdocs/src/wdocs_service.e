note
	description: "Summary description for {WDOCS_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_SERVICE

inherit
	WSF_ROUTED_SERVICE
		redefine
			execute_default
		end

	SHARED_WSF_PERCENT_ENCODER
	SHARED_HTML_ENCODER

feature	-- Initialization

	setup_router
		local
			fs: WSF_FILE_SYSTEM_HANDLER
		do
			router.handle ("/learn/", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_book))
			router.handle ("/book/", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_book))
			router.handle ("/book/{bookid}/_images/{filename}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_wiki_image))
			router.handle ("/book/{bookid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_book))
			router.handle ("/book/{bookid}/{wikipageid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_wikipage))

			create fs.make_with_path ((create {EXECUTION_ENVIRONMENT}).current_working_path.extended ("files"))
			router.handle ("/files", fs)

			create fs.make_with_path (theme_path.extended ("css"))
			fs.disable_index
			router.handle ("/css", fs)

			create fs.make_with_path (theme_path.extended ("js"))
			fs.disable_index
			router.handle ("/js", fs)

			create fs.make_with_path (theme_path.extended ("images"))
			fs.disable_index
			router.handle ("/images", fs)


			create fs.make_with_path (theme_path)
			fs.disable_index
			router.handle ("/theme", fs)
		end

feature -- Access

	manager: WDOCS_MANAGER
		deferred
		end

	theme_path: PATH
		once
			Result := manager.root_dir.extended ("themes").extended ("demo")
		end

	wdocs_theme: WDOCS_THEME
		once
			create Result.make (theme_path)
		end

feature	-- Execution		

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch requests without a matching handler.
		local
			m: WDOCS_PAGE_RESPONSE
			b: STRING
		do
			create m.make (req, "doc", wdocs_theme)
			create b.make_from_string ("<h1>Documentation</h1>")
			b.append ("<li><a href=%"" + req.script_url ("/book/") + "%">All the books</a></li>")
			debug ("wdocs")
				if attached req.http_referer as l_ref then
					b.append ("<li><a href=%"" + l_ref + "%">back to "+ l_ref +"</a></li>")
				end
				b.append ("<li>Location: " + req.request_uri + "</li>")
			end

			m.set_value (b, "content")
			res.send (m)
		end

	handle_book (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WDOCS_PAGE_RESPONSE
			b: STRING
			l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
		do
			create m.make (req, "doc", wdocs_theme)

			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end
			create m.make (req, "doc", wdocs_theme)
			if l_bookid /= Void then
				m.set_value (l_bookid, "book_name")
				create b.make_from_string ("<h1>Book # "+ m.html_encoded_string (l_bookid) +"</h1>")
				mnger := manager
				if attached mnger.book (l_bookid) as l_book then
					across
						l_book.pages as ic
					loop
						if ic.item.key.is_case_insensitive_equal_general ("index") or ic.item.parent_key.is_case_insensitive_equal_general ("index") then
							b.append ("<li>")
							append_wiki_page_link (req, l_bookid, ic.item, True, b)
	--						b.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (l_bookid)) + "/" + percent_encoder.percent_encoded_string (last_segment (ic.item.src)) + "%">")
	--						b.append (m.html_encoded_string (ic.item.title))
	--						b.append ("</a>")
							b.append ("</li>")
						end
					end
				end
			else
				create b.make_from_string ("<h1>List of books ... </h1>")
				mnger := manager
				across
					mnger.book_names as ic
				loop
					b.append ("<li>")
					b.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (ic.item)) +"/index%">")
					b.append (m.html_encoded_string (ic.item))
					b.append ("</a>")
					b.append ("</li>")
				end
			end
			debug ("wdocs")
				append_navigation_to (req, b)
			end
			m.set_value (b, "content")
			res.send (m)
		end

	append_wiki_page_link (req: WSF_REQUEST; a_book_id: detachable READABLE_STRING_GENERAL; a_page: WIKI_PAGE; is_recursive: BOOLEAN; a_output: STRING)
		do
			if a_book_id /= Void then
				a_output.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (a_book_id)) + "/" + percent_encoder.percent_encoded_string (last_segment (a_page.src)) + "%">")
			else
				a_output.append ("<a href=%"../" + percent_encoder.percent_encoded_string (last_segment (a_page.src)) + "%">")
			end
			a_output.append (html_encoder.general_encoded_string (a_page.title))
			a_output.append ("</a>")

			if attached a_page.pages as l_pages and then not l_pages.is_empty then
				if is_recursive then
					a_output.append ("<ul>")
					across
						l_pages as ic
					loop
						a_output.append ("<li>")
						append_wiki_page_link (req, a_book_id, ic.item, is_recursive, a_output)
						a_output.append ("</li>")
					end
					a_output.append ("</ul>")
				end
			end
		end

	handle_wiki_image (req: WSF_REQUEST; res: WSF_RESPONSE)
			--|	map: "/book/_images/{filename}"
		local
			l_bookid: detachable READABLE_STRING_32
			l_filename: detachable READABLE_STRING_32
			l_not_found: WSF_NOT_FOUND_RESPONSE
			l_file_response: WSF_FILE_RESPONSE
			mnger: WDOCS_MANAGER
			p: PATH
		do
			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end
			if attached {WSF_STRING} req.path_parameter ("filename") as p_filename then
				l_filename := p_filename.value
			end
			if l_bookid /= Void and l_filename /= Void then
				mnger := manager
				p := mnger.wiki_database_path.extended (l_bookid).extended ("_images").extended (l_filename)
				create l_file_response.make (p.name)
--				l_file_response.set_expires_in_seconds (24*60*60)
				res.send (l_file_response)
			else
				create l_not_found.make (req)
				res.send (l_not_found)
			end
		end

	handle_wikipage (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WDOCS_PAGE_RESPONSE
			l_wiki_id: detachable READABLE_STRING_32
			l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
			pg: detachable WIKI_PAGE
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end
			if attached {WSF_STRING} req.path_parameter ("wikipageid") as p_id then
				l_wiki_id := p_id.value
			end
			mnger := manager



			create m.make (req, "doc", wdocs_theme)
			if l_bookid /= Void then
				m.set_value (l_bookid, "wiki_book_name")
				pg := mnger.page (l_bookid, l_wiki_id)
			end

			m.head_lines.extend ("[
				<style>
					table {border: solid 1px blue;}
					td {border: solid 1px blue;}
				</style>
				]")
			if pg /= Void then
				m.set_value (pg.title, "wiki_page_name")
				create s.make_empty

				debug ("wdocs")
					if l_wiki_id /= Void then
						s.append ("<h1><a href="+ req.request_uri +">Wiki page # "+ m.html_encoded_string (l_wiki_id) +"</a></h1>")
					else
						s.append ("<h1>Wiki page #???</h1>")
					end
				end

				append_wiki_page_xhtml_to (pg, l_bookid, mnger, s)

				if attached pg.pages as l_sub_pages then
					across
						l_sub_pages as ic
					loop
						s.append ("<li>")
						append_wiki_page_link (req, l_bookid, ic.item, False, s)
						s.append ("</li>")
					end
				end

				if attached {WSF_STRING} req.query_parameter ("debug") as s_debug and then not s_debug.is_case_insensitive_equal ("no") then
					s.append ("<hr/>")
					if attached pg.path as l_path then
						s.append ("File: ")
						s.append (m.html_encoded_string (l_path.absolute_path.canonical_path.name))
						s.append ("<br/>")
						if attached wiki_text (l_path) as l_wiki_text then
							s.append ("Wiki text:<pre style=%"border: solid 1px #000; background-color: #ffa; white-space: pre-wrap; %">%N")
							s.append (l_wiki_text)
							s.append ("%N</pre>")
						end
					end
					s.append ("HTML rendering:<pre style=%"border: solid 1px #000; background-color: #afa; white-space: pre-wrap;%">%N")
					s.append (m.html_encoded_string (s))
					s.append ("</pre>")
				end
			else
				create s.make_from_string ("<h1>Wiki page #???</h1>")
			end

			debug ("wdocs")
				append_navigation_to (req, s)
			end
			m.set_value (s, "content")
--			m.set_body (b)
			res.send (m)
		end

feature -- Helper		

	append_navigation_to (req: WSF_REQUEST; s: STRING)
		do
			s.append ("<li><a href=%"" + req.script_url ("/") + "%">back to home</a></li>")
			if attached req.http_referer as l_ref then
				s.append ("<li><a href=%"" + l_ref + "%">back to "+ l_ref +"</a></li>")
			end
			s.append ("<li>Location: " + req.request_uri + "</li>")
		end

	last_segment (s: READABLE_STRING_8): READABLE_STRING_8
		local
			i: INTEGER
		do
			i := s.last_index_of ('/', s.count)
			if i > 0 then
				Result := s.substring (i + 1, s.count)
			else
				Result := s
			end
			if Result.is_case_insensitive_equal_general ("index") then
				if s.last_index_of ('/', i - 1) > 0 then
					Result := last_segment (s.substring (1, i - 1))
				end
			end
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_book_name: detachable READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_xhtml: detachable STRING_8
			wvis: WIKI_XHTML_GENERATOR
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			l_wiki_page_date_timestamp,
			l_cache_date_timestamp: INTEGER
		do
			p := a_manager.database_path.appended_with_extension ("cache")
			if a_book_name /= Void then
				p := p.extended (a_book_name)
			end
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			p := p.extended (a_wiki_page.title).appended_with_extension ("xhtml")
			if attached a_wiki_page.path as l_pg_path then
				create f.make_with_path (l_pg_path)
				if f.exists and then f.is_access_readable then
					l_wiki_page_date_timestamp := f.change_date
				end
			end
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				l_cache_date_timestamp := f.change_date
				create l_xhtml.make (f.count)
				from
					f.open_read
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					l_xhtml.append (f.last_string)
				end
				f.close
			end
			if l_xhtml = Void then
				create l_xhtml.make_empty
				create wvis.make (l_xhtml)
				wvis.set_link_resolver (a_manager)
				wvis.set_image_resolver (a_manager)
				wvis.set_template_resolver (a_manager)
				wvis.visit_page (a_wiki_page)
				if not f.exists or else f.is_writable then
					f.open_write
					f.put_string (l_xhtml)
					f.close
				end
			end
			a_output.append (l_xhtml)
		end

	wiki_text (fn: PATH): detachable STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

	wiki_text_cached_expired (pg: WIKI_PAGE): BOOLEAN
		do

		end

end
