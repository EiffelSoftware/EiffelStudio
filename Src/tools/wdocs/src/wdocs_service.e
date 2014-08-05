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

feature	-- Initialization

	setup_router
		local
			sess: detachable WSF_ROUTER_SESSION
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
			fs: WSF_FILE_SYSTEM_HANDLER
		do
			router.handle ("/book/", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_book))
			router.handle ("/book/{bookid}/_images/{filename}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_wiki_image))
			router.handle ("/book/{bookid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_book))
			router.handle ("/book/{bookid}/{wikipageid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_wikipage))
			create fs.make_with_path ((create {EXECUTION_ENVIRONMENT}).current_working_path.extended ("files"))
			router.handle ("/files", fs)
		end

feature -- Access

	manager: WDOCS_MANAGER
		deferred
		end

feature	-- Execution		

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch requests without a matching handler.
		local
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
		do
			create m.make
			create b.make_from_string ("<h1>Wiki Docs App</h1>")
			b.append ("<li><a href=%"" + req.script_url ("/book/") + "%">Books</a></li>")
			b.append ("<li><a href=%"" + req.script_url ("/book/a_test/index") + "%">Test</a></li>")
			b.append ("<li><a href=%"" + req.script_url ("/book/eiffelstudio/index") + "%">EiffelStudio</a></li>")
			b.append ("<li><a href=%"" + req.script_url ("/exit") + "%">exit</a></li>")


			if attached req.http_referer as l_ref then
				b.append ("<li><a href=%"" + l_ref + "%">back to "+ l_ref +"</a></li>")
			end
			b.append ("<li>Location: " + req.request_uri + "</li>")

			m.set_body (b)
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
		end

	handle_book (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
			l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end
			create m.make
			if l_bookid /= Void then
				create b.make_from_string ("<h1>Book # "+ m.html_encoded_string (l_bookid) +"</h1>")
				mnger := manager
				if attached mnger.book (l_bookid) as l_book then
					across
						l_book.pages as ic
					loop
						b.append ("<li>")
						s := ic.item.src

						b.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (l_bookid)) + "/" + percent_encoder.percent_encoded_string (last_segment (ic.item.src)) + "%">")
						b.append (m.html_encoded_string (ic.item.title))
						b.append ("</a>")
						b.append ("</li>")
					end
				end
			else
				create b.make_from_string ("<h1>Book index ... </h1>")
				mnger := manager
				across
					mnger.book_names as ic
				loop
					b.append ("<li>")
					b.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (ic.item)) +"%">")
					b.append (m.html_encoded_string (ic.item))
					b.append ("</a>")
					b.append ("</li>")
				end
			end
			append_navigation_to (req, b)
			m.set_body (b)
			res.send (m)
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
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
			l_wiki_id: detachable READABLE_STRING_32
			l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
			pg: detachable WIKI_PAGE
--			wvis: WIKI_XHTML_GENERATOR
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end
			if attached {WSF_STRING} req.path_parameter ("wikipageid") as p_id then
				l_wiki_id := p_id.value
			end
			mnger := manager

			if l_bookid /= Void then
				pg := mnger.page (l_bookid, l_wiki_id)
			end

			create m.make
			m.head_lines.extend ("[
				<style>
					table {border: solid 1px blue;}
					td {border: solid 1px blue;}
				</style>
				]")
			if pg /= Void then
				if l_wiki_id /= Void then
					create b.make_from_string ("<h1><a href="+ req.request_uri +">Wiki page # "+ m.html_encoded_string (l_wiki_id) +"</a></h1>")
				else
					create b.make_from_string ("<h1>Wiki page #???</h1>")
				end

				create s.make_empty
				append_wiki_page_xhtml_to (pg, l_bookid, mnger, s)
				b.append (s)

				if attached pg.pages as l_sub_pages then
					across
						l_sub_pages as ic
					loop
						b.append ("<li>")
						b.append (ic.item.src)
						b.append ("</li>")
					end
				end


				b.append ("<hr/>")
				if attached pg.path as l_path then
					b.append ("File: ")
					b.append (m.html_encoded_string (l_path.absolute_path.canonical_path.name))
					b.append ("<br/>")
					if attached wiki_text (l_path) as l_wiki_text then
						b.append ("Wiki text:<pre style=%"border: solid 1px #000; background-color: #ffa; white-space: pre-wrap; %">%N")
						b.append (l_wiki_text)
						b.append ("%N</pre>")
					end
				end
				b.append ("HTML rendering:<pre style=%"border: solid 1px #000; background-color: #afa; white-space: pre-wrap;%">%N")
				b.append (m.html_encoded_string (s))
				b.append ("</pre>")
			else
				create b.make_from_string ("<h1>Wiki page #???</h1>")
			end

			append_navigation_to (req, b)

			m.set_body (b)
			res.send (m)
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_book_name: detachable READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_xhtml: detachable STRING_8
			wvis: WIKI_XHTML_GENERATOR
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
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
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				create l_xhtml.make (f.count)
				from
					f.open_read
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					l_xhtml.append (f.last_string)
				end
--				if attached {STRING_8} f.retrieved as s then
--					l_xhtml := s
--				end
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
--					f.basic_store (l_xhtml)
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

end
