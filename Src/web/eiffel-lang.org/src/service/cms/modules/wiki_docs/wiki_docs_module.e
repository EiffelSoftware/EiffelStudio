note
	description: "Summary description for {WIKI_DOCS_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_DOCS_MODULE

inherit
	CMS_MODULE

--	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
		local
			cfg: detachable WDOCS_CONFIG
		do
			name := "wdocs"
			version := "1.0"
			description := "Wiki Documentation"
			package := "doc"

			cfg := configuration
			root_dir := cfg.root_dir
			wiki_dir := cfg.wiki_dir
			theme_name := cfg.theme_name
			cache_duration := cfg.cache_duration
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		local
			fs: WSF_FILE_SYSTEM_HANDLER
		do
			service := a_service
			a_service.map_uri_template ("/learn", agent handle_learn (a_service, ?, ?))
			a_service.map_uri_template ("/book/", agent handle_book (a_service, ?, ?))
			a_service.map_uri_template ("/book/{bookid}/_images/{filename}", agent handle_wiki_image (a_service, ?, ?))
			a_service.map_uri_template ("/book/{bookid}", agent handle_book (a_service, ?, ?))
			a_service.map_uri_template ("/book/{bookid}/{wikipageid}", agent handle_wikipage (a_service, ?, ?))

			create fs.make_with_path (theme_path.extended ("images"))
			fs.disable_index
			a_service.router.handle ("/images", fs)
		end

feature -- Access: config

	configuration: WDOCS_CONFIG
			-- Configuration setup.
		do
			if attached configuration_ini as l_config_ini then
				Result := l_config_ini
			elseif attached configuration_json as l_config_json then
				Result := l_config_json
			else
					-- Default
				create {WDOCS_DEFAULT_CONFIG} Result.make
			end
		end

feature {NONE} -- Implementation: config

	configuration_ini: detachable WDOCS_CONFIG
		local
			p: PATH
			ut: FILE_UTILITIES
		do
			create p.make_from_string ("eiffel-lang.ini")
			if ut.file_path_exists (p) then
				create {WDOCS_INI_CONFIG} Result.make (p)
			elseif attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if ut.file_path_exists (p) then
					create {WDOCS_INI_CONFIG} Result.make (p)
				end
			end
		end

	configuration_json: detachable WDOCS_CONFIG
		local
			p: PATH
			ut: FILE_UTILITIES
		do
			create p.make_from_string ("eiffel-lang.json")
			if ut.file_path_exists (p) then
				create {WDOCS_JSON_CONFIG} Result.make (p)
			elseif attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if ut.file_path_exists (p) then
					create {WDOCS_JSON_CONFIG} Result.make (p)
				end
			end
		end

feature -- Access: docs

	root_dir: PATH

	wiki_dir: PATH

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

	manager: WDOCS_MANAGER
		do
			create Result.make (root_dir, wiki_dir)
		end

	theme_name: IMMUTABLE_STRING_32
			-- Associated theme name.

	theme_path: PATH
		do
			Result := root_dir.extended ("themes").extended (theme_name)
		end

feature -- Hooks

--	block_list: ITERABLE [like {CMS_BLOCK}.name]
--		do
--			Result := <<"debug-info">>
--		end

--	get_block_view (a_block_id: detachable READABLE_STRING_8; a_execution: CMS_EXECUTION)
--		local
--			b: CMS_CONTENT_BLOCK
--		do
--			create b.make ("debug-info", "Debug", "... ", a_execution.formats.plain_text)
--			a_execution.add_block (b, Void)
--		end

feature -- Handler		

	handle_learn (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_book (cms, req, res)
		end

	handle_book (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			e: CMS_EXECUTION
			b: STRING
			l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
		do
			to_implement ("Find a way to extract presentation [html code] outside Eiffel")

			if req.is_get_request_method then
				create {ANY_CMS_EXECUTION} e.make (req, res, cms)
			else
				create {NOT_FOUND_CMS_EXECUTION} e.make (req, res, cms)
			end

			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end

			if l_bookid /= Void then
				e.set_optional_content_type ("doc")
				e.set_title (l_bookid)
				e.set_value (l_bookid, "book_name")
				create b.make_from_string ("<h1>Book # "+ html_encoded (l_bookid) +"</h1>")
				mnger := manager
				if attached mnger.book (l_bookid) as l_book then
					across
						l_book.pages as ic
					loop
						if ic.item.key.is_case_insensitive_equal_general ("index") or ic.item.parent_key.is_case_insensitive_equal_general ("index") then
							b.append ("<li>")
							append_wiki_page_link (req, l_bookid, ic.item, True, b)
							b.append ("</li>")
						end
					end
				end
			else
				e.set_optional_content_type ("doc")
				e.set_title ("Book list ...")
				create b.make_from_string ("<ul class=%"books%">")
				mnger := manager
				across
					mnger.book_names as ic
				loop
					b.append ("<li>")
					b.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (ic.item)) +"/index%">")
					b.append (html_encoded (ic.item))
					b.append ("</a>")
					b.append ("</li>")
				end
				b.append ("</ul>")
			end
			debug ("wdocs")
				append_navigation_to (req, b)
			end

			e.set_main_content (b)
			e.execute
		end

	handle_wikipage (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_wiki_id: detachable READABLE_STRING_32
			l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
			pg: detachable WIKI_PAGE
			e: CMS_EXECUTION
			s: STRING
		do
			to_implement ("Find a way to extract presentation [html code] outside Eiffel")

			if req.is_get_request_method then
				create {ANY_CMS_EXECUTION} e.make (req, res, cms)
			else
				create {NOT_FOUND_CMS_EXECUTION} e.make (req, res, cms)
			end

			e.set_optional_content_type ("doc")

			if attached {WSF_STRING} req.path_parameter ("bookid") as p_bookid then
				l_bookid := p_bookid.value
			end
			if attached {WSF_STRING} req.path_parameter ("wikipageid") as p_id then
				l_wiki_id := p_id.value
			end
			mnger := manager

			if l_bookid /= Void then
				e.set_value (l_bookid, "wiki_book_name")
				pg := mnger.page (l_bookid, l_wiki_id)
			end

			e.add_additional_head_line ("[
						<style>
							table {border: solid 1px blue;}
							td {border: solid 1px blue;}
						</style>
					]", False
				)

			if pg /= Void then
				e.set_title (pg.title)
				e.set_value (pg.title, "wiki_page_name")
				create s.make_empty

				debug ("wdocs")
					if l_wiki_id /= Void then
						s.append ("<h1><a href="+ req.request_uri +">Wiki page # "+ html_encoded (l_wiki_id) +"</a></h1>")
					else
						s.append ("<h1>Wiki page #???</h1>")
					end
				end

				append_wiki_page_xhtml_to (pg, l_bookid, mnger, s, req)

				if attached {WSF_STRING} req.query_parameter ("debug") as s_debug and then not s_debug.is_case_insensitive_equal ("no") then
					s.append ("<hr/>")
					if attached pg.path as l_path then
						s.append ("File: ")
						s.append (html_encoded (l_path.absolute_path.canonical_path.name))
						s.append ("<br/>")
						if attached wiki_text (l_path) as l_wiki_text then
							s.append ("Wiki text:<pre style=%"border: solid 1px #000; background-color: #ffa; white-space: pre-wrap; %">%N")
							s.append (l_wiki_text)
							s.append ("%N</pre>")
						end
					end
					s.append ("HTML rendering:<pre style=%"border: solid 1px #000; background-color: #afa; white-space: pre-wrap;%">%N")
					s.append (html_encoded (s))
					s.append ("</pre>")
				end
			else
				e.set_title ("Wiki page #???")
				create s.make_from_string ("Page not found")
			end

			debug ("wdocs")
				append_navigation_to (req, s)
			end

			e.set_main_content (s)
			e.execute
		end

	handle_wiki_image (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
			--|	map: "/book/_images/{filename}"
		local
			l_bookid: detachable READABLE_STRING_32
			l_filename: detachable READABLE_STRING_32
			l_not_found: WSF_NOT_FOUND_RESPONSE
			l_file_response: WSF_FILE_RESPONSE
			mnger: WDOCS_MANAGER
			p: PATH
			h: HTTP_HEADER
			dt: DATE_TIME
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

				if
					attached req.meta_string_variable ("HTTP_IF_MODIFIED_SINCE") as s_if_modified_since and then
					attached http_date_format_to_date (s_if_modified_since) as l_if_modified_since_date and then
					attached file_date (p) as f_date and then
					f_date <= l_if_modified_since_date
				then
					create dt.make_now_utc
					create h.make
					h.put_cache_control ("private, max-age=" + (cache_duration).out) -- 24 hours
					h.put_utc_date (dt)
					if cache_duration > 0 then
						dt := dt.twin
						dt.second_add (cache_duration)
					end
					h.put_expires_date (dt)
					h.put_last_modified (f_date)
					res.set_status_code ({HTTP_STATUS_CODE}.not_modified)
					res.put_header_lines (h)
					res.flush
				else
					create l_file_response.make (p.name)
	--				l_file_response.set_expires_in_seconds (24*60*60)
					res.send (l_file_response)
				end
			else
				create l_not_found.make (req)
				res.send (l_not_found)
			end
		end

feature {NONE} -- Implementation: wiki render	

	append_navigation_to (req: WSF_REQUEST; s: STRING)
		do
			to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			s.append ("<li><a href=%"" + req.script_url ("/") + "%">back to home</a></li>")
			if attached req.http_referer as l_ref then
				s.append ("<li><a href=%"" + l_ref + "%">back to "+ l_ref +"</a></li>")
			end
			s.append ("<li>Location: " + req.request_uri + "</li>")
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_book_name: detachable READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_output: STRING; req: WSF_REQUEST)
		local
			l_cache: detachable WDOCS_FILE_STRING_8_CACHE
			l_xhtml: detachable STRING_8
			wvis: WIKI_XHTML_GENERATOR
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			l_wiki_page_date_time: detachable DATE_TIME
			client_request_no_server_cache: BOOLEAN
		do
			p := wiki_dir.appended_with_extension ("cache")
			if a_book_name /= Void then
				p := p.extended (a_book_name)
			end
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			p := p.extended (a_wiki_page.title).appended_with_extension ("xhtml")

			if
				cache_disabled
			then
					-- No cache!
			else
				create l_cache.make (p)
				if attached a_wiki_page.path as l_pg_path then
					create f.make_with_path (l_pg_path)
					if f.exists and then f.is_access_readable then
						create l_wiki_page_date_time.make_from_epoch (f.date)
					end
				end
			end

			client_request_no_server_cache := attached req.meta_string_variable ("HTTP_CACHE_CONTROL") as s_cache_control and then
						s_cache_control.is_case_insensitive_equal_general ("no-cache")


			if
				not client_request_no_server_cache and then
				l_cache /= Void and then -- i.e: cache enabled
				l_cache.exists and then
				not l_cache.expired (l_wiki_page_date_time, cache_duration)
			then
				create l_xhtml.make (l_cache.file_size)
				l_cache.append_to (l_xhtml)

				l_xhtml.append ("<div class=%"cache-info%">cached: " + l_cache.cache_date_time.out + "</div>")
			else
				create l_xhtml.make_empty

				create wvis.make (l_xhtml)
				wvis.set_link_resolver (a_manager)
				wvis.set_image_resolver (a_manager)
				wvis.set_template_resolver (a_manager)
				wvis.visit_page (a_wiki_page)

				if attached a_wiki_page.pages as l_sub_pages then
					across
						l_sub_pages as ic
					loop
						l_xhtml.append ("<li>")
						append_wiki_page_link (req, a_book_name, ic.item, False, l_xhtml)
						l_xhtml.append ("</li>")
					end
				end

				if l_cache /= Void then
					l_cache.put (l_xhtml)
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

feature {NONE} -- implementation: wiki docs

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

	append_wiki_page_link (req: WSF_REQUEST; a_book_id: detachable READABLE_STRING_GENERAL; a_page: WIKI_PAGE; is_recursive: BOOLEAN; a_output: STRING)
		do
			to_implement ("Find a way to extract presentation [html code] outside Eiffel")
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

feature {NONE} -- Implementation: date and time

	http_date_format_to_date (s: READABLE_STRING_8): detachable DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_string (s)
			if not d.has_error then
				Result := d.date_time
			end
		end

	file_date (p: PATH): DATE_TIME
		require
			path_exists: (create {FILE_UTILITIES}).file_path_exists (p)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			Result := timestamp_to_date (f.date)
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end

feature {NONE} -- Implementation		

	append_info_to (n: READABLE_STRING_8; v: detachable READABLE_STRING_GENERAL; e: CMS_EXECUTION; t: STRING)
		do
			t.append ("<li>")
			t.append ("<strong>" + n + "</strong>: ")
			if v /= Void then
				t.append (e.html_encoded (v))
			end
			t.append ("</li>")
		end

	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
