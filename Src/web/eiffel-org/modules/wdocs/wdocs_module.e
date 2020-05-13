note
	description: "Summary description for {WDOCS_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_MODULE

inherit
	CMS_MODULE
		rename
			module_api as wdocs_api
		redefine
			setup_hooks,
			initialize,
			wdocs_api,
			permissions
		end

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_RECENT_CHANGES_HOOK

	CMS_SITEMAP_HOOK

	WDOCS_MODULE_HELPER
		undefine
			percent_encoder
		end

	CMS_TAXONOMY_HOOK

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		local
			l_root_dir: PATH
		do
			version := "1.0"
			description := "Wiki Documentation"
			package := "doc"

				-- FIXME: maybe have a WDOCS_MODULE_EXECUTION to get those info when needed...
				-- Note those values are really set in `register`
			create l_root_dir.make_current
			temp_dir := l_root_dir.extended ("tmp")
			documentation_dir := l_root_dir.extended ("data").extended ("documentation")
			default_version_id := "current"
			cache_duration := 0

			add_optional_dependency ({CMS_RECENT_CHANGES_MODULE})
			add_optional_dependency ({CMS_SITEMAP_MODULE})
		end

feature -- Access

	name: STRING = "wdocs"
			-- Name of the module.

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		do
			Result := Precursor
			Result.force ("clear wdocs cache")
		end

feature -- Administration

	administration: WDOCS_MODULE_ADMINISTRATION
			-- <Precursor>
		do
			create Result.make (Current)
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_setup: WDOCS_SETUP
			l_wdocs_api: attached like wdocs_api
		do
			Precursor (api)
			l_setup := settings (api)
			temp_dir := l_setup.temp_dir
			documentation_dir := l_setup.documentation_dir
			cache_duration := l_setup.cache_duration
			get_default_version_id (l_setup)
			create l_wdocs_api.make (default_version_id, api, l_setup)
			wdocs_api := l_wdocs_api

			api.add_content_type_webform_manager (create {WDOCS_TYPE_WEBFORM_MANAGER}.make (create {CMS_WDOCS_CONTENT_TYPE}, l_wdocs_api))
		end

	get_default_version_id (cfg: WDOCS_SETUP)
			-- Get default version id from `cfg` or "version" file from `documentation_dir`.
			-- If set via configuration, it has priority over "version" file.
		local
			f: PLAIN_TEXT_FILE
			utf: UTF_CONVERTER
			s: STRING
			v: detachable READABLE_STRING_GENERAL
			retried: BOOLEAN
		do
			if not retried then
				v := cfg.documentation_default_version
				if v = Void or else v.is_whitespace then
					create f.make_with_path (documentation_dir.extended ("version"))
					if f.exists and then f.is_access_readable then
						f.open_read
						f.read_line_thread_aware
						s := f.last_string
						f.close
						s.left_adjust
						s.right_adjust
						v := utf.utf_8_string_8_to_string_32 (s)
					end
				end
			end
			if v = Void or else v.is_whitespace then
				v := "current"
			end
			default_version_id := v
		ensure
			valid_default_version_id: not default_version_id.is_whitespace
		rescue
			retried := True
			retry
		end

feature -- Access: API

	wdocs_api: detachable WDOCS_API
			-- <Precursor>		

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		local
			h: WSF_URI_TEMPLATE_AGENT_HANDLER
			h_uri: WSF_URI_AGENT_HANDLER
		do
			create h.make (agent handle_wikipage_by_uuid (a_api, ?, ?))
			a_router.handle ("/doc/uuid/{wikipage_uuid}", h, a_router.methods_get)
			a_router.handle ("/doc/version/{version_id}/uuid/{wikipage_uuid}", h, a_router.methods_get)

			create h.make (agent handle_wikipage_by_eis_id (a_api, ?, ?))
			a_router.handle ("/doc/eis/{eis_id}", h, a_router.methods_get)
			a_router.handle ("/doc/version/{version_id}/eis/{eis_id}", h, a_router.methods_get)

			create h_uri.make (agent handle_documentation (a_api, ?, ?))
			a_router.handle ("/documentation", h_uri, a_router.methods_get)
			a_router.handle ("/doc", h_uri, a_router.methods_get)
			a_router.handle ("/doc/", h_uri, a_router.methods_get)

			create h.make (agent handle_documentation (a_api, ?, ?))
			a_router.handle ("/doc/version/{version_id}/", h, a_router.methods_get)
			a_router.handle ("/doc/version/{version_id}/{bookid}", h, a_router.methods_get)
			a_router.handle ("/doc/{bookid}", h, a_router.methods_get)

			create h.make (agent handle_wikipage (a_api, ?, ?))
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}", h, a_router.methods_get)
			a_router.handle ("/doc/{bookid}/{wikipageid}", h, a_router.methods_get)

-- TO COMPLETE before enabling it.
--			create h.make (agent handle_wikipage_references (a_api, ?, ?))
--			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/whatlinkshere", h, a_router.methods_get)
--			a_router.handle ("/doc/{bookid}/{wikipageid}/whatlinkshere", h, a_router.methods_get)


			create h.make (agent handle_wiki_image (a_api, ?, ?))
			a_router.handle ("/doc-image/{image_id}", h, a_router.methods_get)
			a_router.handle ("/doc-image/version/{version_id}/{image_id}", h, a_router.methods_get)
			a_router.handle ("/doc-image/version/{version_id}/{bookid}/_images/{filename}", h, a_router.methods_get)
			a_router.handle ("/doc-image/{bookid}/_images/{filename}", h, a_router.methods_get)

			create h.make (agent handle_wiki_file (a_api, ?, ?))
			a_router.handle ("/doc-file/{filename}", h, a_router.methods_get)
			a_router.handle ("/doc-file/version/{version_id}/{filename}", h, a_router.methods_get)
			a_router.handle ("/doc-file/version/{version_id}/{bookid}/{filename}", h, a_router.methods_get)
			a_router.handle ("/doc-file/{bookid}/{filename}", h, a_router.methods_get)

			create h.make (agent handle_static_documentation (a_api, ?, ?))
			a_router.handle ("/doc-static/version/{version_id}{/vars}", h, a_router.methods_get)

		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)

				-- Module specific hook, if available.
			a_hooks.subscribe_to_hook (Current, {CMS_RECENT_CHANGES_HOOK})
			a_hooks.subscribe_to_hook (Current, {CMS_TAXONOMY_HOOK})
			a_hooks.subscribe_to_hook (Current, {CMS_SITEMAP_HOOK})
		end

feature {NONE} -- Config

	settings (api: CMS_API): WDOCS_SETUP
			-- Configuration setup.
		local
			d: PATH
		do
			d := api.site_location.extended ("config").extended ("modules").extended (name)
			if attached settings_within (d) as cfg then
				Result := cfg
			else
				d := api.module_location (Current)
				if attached settings_within (d) as cfg then
					Result := cfg
				else
						-- Default
					create {WDOCS_DEFAULT_SETUP} Result.make_default
				end
			end
		end

	settings_within (a_dir: PATH): detachable WDOCS_SETUP
		local
			p: detachable PATH
			ut: FILE_UTILITIES
		do
			if attached execution_environment.item ("WDOCS_SETUP") as s then
				create p.make_from_string (s)
				if not ut.file_path_exists (p) then
					p := a_dir.extended (s)
					if not ut.file_path_exists (p) then
						p := Void
					end
				end
			end
			if p /= Void then
				create {WDOCS_DEFAULT_SETUP} Result.make_with_configuration (p)
			else
				p := a_dir.extended (name).appended_with_extension ("ini")
				if ut.file_path_exists (p) then
					create {WDOCS_DEFAULT_SETUP} Result.make_with_configuration (p)
				else
					p := a_dir.extended (name).appended_with_extension ("json")
					if ut.file_path_exists (p) then
						create {WDOCS_DEFAULT_SETUP} Result.make_with_configuration (p)
					end
				end
			end
		end

feature -- Access: docs

	temp_dir: PATH

	documentation_dir: PATH

	default_version_id: READABLE_STRING_GENERAL

	documentation_wiki_dir (a_version_id: READABLE_STRING_GENERAL): PATH
		require
			a_version_id_not_blank: not a_version_id.is_whitespace
		do
			Result := documentation_dir.extended (a_version_id)
		end

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valid
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		require
			has_wdocs_api: wdocs_api /= Void
		do
			check attached wdocs_api as l_wdocs_api then
				Result := l_wdocs_api.manager (a_version_id)
			end
		end

feature -- Hooks

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_javascript_url (a_response.module_resource_url (Current, "/files/js/wdocs.js", Void))
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/wdocs.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system`
			-- for related response `a_response`.
		local
			lnk: CMS_LOCAL_LINK
			l_docs_admin_loc: READABLE_STRING_8
		do
			if a_response.has_permissions (<<"admin wdocs", "clear wdocs cache">>) then
				l_docs_admin_loc := a_response.api.administration_path_location ("module/" + name)

				lnk := a_response.administration_link ("Clear cache", "module/" + name + "/clear-cache")
				lnk.add_query_parameter (a_response.location, "destination")
				a_menu_system.management_menu.extend_into (lnk, "Docs", l_docs_admin_loc)

				lnk := a_response.administration_link ("Update", "module/" + name + "/update")
				lnk.add_query_parameter (a_response.location, "destination")
				a_menu_system.management_menu.extend_into (lnk, "Docs", l_docs_admin_loc)
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"wdocs-tree", "?wdocs-cards">>
			debug ("wdocs")
				Result := <<"wdocs-tree", "?wdocs-page-info", "?wdocs-cards">>
			end
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			l_menublock: CMS_MENU_BLOCK
			l_content_block: CMS_CONTENT_BLOCK
			m: CMS_MENU
			s: STRING
			l_version_id, l_book_name, l_page_name: detachable READABLE_STRING_GENERAL
			mng: like manager
		do
			if
				attached {READABLE_STRING_GENERAL} a_response.optional_content_type as l_type and then
				l_type.is_case_insensitive_equal (documentation_content_type)
			then
				if a_block_id /= Void then
					if attached {READABLE_STRING_GENERAL} a_response.values.item ("wiki_version_id") as t then
						l_version_id := t
					end
					mng := manager (l_version_id)
					if l_version_id = Void then
						l_version_id := mng.version_id
					end
					if attached {READABLE_STRING_GENERAL} a_response.values.item ("wiki_book_name") as t then
						l_book_name := url_encoded_string_to_wiki_name (t)
					end
					if attached {READABLE_STRING_GENERAL} a_response.values.item ("wiki_page_name") as t then
						l_page_name := url_encoded_string_to_wiki_name (t)
					end

					if a_block_id.same_string_general ("wdocs-tree") then
						m := cached_wdocs_cms_menu ({STRING_32} "Documentation", l_version_id, l_book_name, mng)
						create l_menublock.make (m)
						l_menublock.set_title (Void)
						a_response.add_block (l_menublock, "sidebar_first")
					elseif a_block_id.same_string_general ("wdocs-cards") then
						a_response.add_block (wdocs_cards_block (a_block_id, a_response, mng), "content")
					elseif a_block_id.same_string_general ("wdocs-page-info") then
						if
							l_book_name /= Void and then l_page_name /= Void and then
							attached mng.page (l_page_name, l_book_name) as wp
						then
							create s.make_empty
							s.append ("<strong>title:</strong>")
							s.append (wp.title)
							s.append ("%N")

							s.append ("<strong>key:</strong>")
							s.append (wp.key)
							s.append ("%N")

							s.append ("<strong>src:</strong>")
							s.append (wp.src)
							s.append ("%N")

							if attached wp.path as l_path then
								s.append ("<strong>path:</strong>")
								s.append (l_path.name.as_string_8)
								s.append ("%N")
							end

							if attached mng.page_metadata (wp, Void) as l_metadata then
								across
									l_metadata as ic
								loop
									s.append_string (ic.key.as_string_8)
									s.append_character ('=')
									s.append_string (ic.item.as_string_8)
									s.append_character ('%N')
								end
							end
							create l_content_block.make (a_block_id, {STRING_32} "Page info", s, a_response.formats.filtered_html)
							a_response.add_block (l_content_block, "sidebar_second")
						end
					end
				end
			end
		end

	wdocs_cards_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE; a_manager: WDOCS_MANAGER): CMS_BLOCK
		local
			tb: STRING_TABLE [WIKI_PAGE] -- book root page indexed by url
			l_url: READABLE_STRING_8
		do
			if attached template_block (a_block_id, a_response) as l_tpl_block then
				l_tpl_block.set_title (Void) --("Documentation")
				l_tpl_block.set_is_raw (True)
				create tb.make (5)
				across
					a_manager.books_with_root_page as book_ic
				loop
					if attached book_ic.item as l_book then
						if attached a_manager.version_id as l_version_id then
							l_url := a_response.request.script_url ("/doc/version/" + percent_encoder.percent_encoded_string (l_version_id) + "/" + percent_encoder.percent_encoded_string (l_book.name) + "/index")
						else
							l_url := a_response.request.script_url ("/doc/" + percent_encoder.percent_encoded_string (l_book.name) + "/index")
						end
						if attached l_book.root_page as l_root_page then
							tb.force (l_root_page, l_url)
--						else
--							tb.force (l_book, l_url)
						end
					end
				end
				l_tpl_block.set_value (tb, "root_pages_by_url")
				Result := l_tpl_block
			else
				create {CMS_CONTENT_BLOCK} Result.make_raw (a_block_id, Void, "", Void)
			end
		end

feature -- Hook/sitemap

	populate_sitemap (a_sitemap: CMS_SITEMAP)
			-- Populate `a_sitemap`.
		local
			i: CMS_SITEMAP_ITEM
			l_title: detachable READABLE_STRING_32
			dt: detachable DATE_TIME
			loc: STRING
			ut: FILE_UTILITIES
		do
			if attached wdocs_api as l_wdocs_api then
				if
					attached l_wdocs_api.manager (Void) as mng and then
					attached mng.book_names as l_book_names
				then
					across
						l_book_names as bk_ic
					loop
						if attached mng.book (bk_ic.item) as l_book then
							across
								l_book.pages as ic
							loop
								if attached {WIKI_BOOK_PAGE} ic.item as wp then
									l_title := wp.metadata ("link_title")
									if l_title = Void then
										l_title := wp.title
									end
									if attached wp.path as p and then ut.file_path_exists (p) then
										dt := file_date (p)
									else
										create dt.make_now_utc
									end
									loc := mng.wiki_page_uri_path (wp, bk_ic.item, Void)
									if loc.starts_with ("/") then
										loc.remove_head (1)
									end
									create i.make (create {CMS_LOCAL_LINK}.make (l_title, loc), dt)
									a_sitemap.force (i)
								end
							end
						end
					end
				end
			end
		end

feature -- Hook / Recent changes

	documentation_content_type: STRING = "doc"

	recent_changes_sources: detachable LIST [READABLE_STRING_8]
			-- <Precursor>
		local
			lst: ARRAYED_LIST [READABLE_STRING_8]
		do
			create lst.make (1)
			lst.extend (documentation_content_type)
			Result := lst
		end

	populate_recent_changes (a_changes: CMS_RECENT_CHANGE_CONTAINER; a_current_user: detachable CMS_USER)
			-- <Precursor>.
		local
			pos, pos_eol: INTEGER
			i: CMS_RECENT_CHANGE_ITEM
			dt: detachable DATE_TIME
			l_src: detachable READABLE_STRING_8
			params: CMS_DATA_QUERY_PARAMETERS
			wp: WIKI_BOOK_PAGE
			s: STRING
			utf: UTF_CONVERTER
			l_title: detachable READABLE_STRING_32
			l_author: detachable READABLE_STRING_32
		do
			if attached wdocs_api as l_wdocs_api then
				l_src := a_changes.source --| i.e filter on source

				if l_src = Void or else l_src.is_case_insensitive_equal_general (documentation_content_type) then
					dt := a_changes.date
					if dt = Void then
						create dt.make_now_utc
					end

					create params.make (0, a_changes.limit)
					across
						l_wdocs_api.recent_changes_before (params, dt, Void) as ic
					loop
						if attached ic.item as l_data then
							a_changes.set_last_date_for_source (l_data.time, documentation_content_type)

							wp := l_data.page
							l_title := wp.metadata ("link_title")
							if l_title = Void then
								l_title := wp.title
							end
							create i.make (documentation_content_type, create {CMS_LOCAL_LINK}.make (l_title, wp.src), l_data.time)
							i.set_id (documentation_content_type + ":" + wp.src)
							i.set_author_name (l_data.author)
							if attached ic.item.log as l_log then
								i.set_information (l_log)
									-- Looking for real author "Signed-off-by: Super Developer <super.dev@example.com>"
									-- Check only the first instance.
								pos_eol := 0
								pos := l_log.substring_index ("(Signed-off-by:", 1)
								if pos > 0 then
									pos_eol := l_log.index_of (')', pos + 14)
									if pos_eol = 0 then
										pos := 0
									end
								end
								if pos = 0 then
									pos := l_log.substring_index ("%NSigned-off-by:", 1)
									if pos > 0 then
										pos_eol := l_log.index_of ('%N', pos + 14)
										if pos_eol = 0 then
											pos_eol := l_log.count + 1
										end
									end
								end
								if pos > 0 then
									s := l_log.substring (pos + 15, pos_eol - 1)
									s.right_adjust
									s.left_adjust
									l_author := utf.utf_8_string_8_to_string_32 (s)
									i.set_author_name (l_author)
									if attached l_wdocs_api.cms_api.user_api.user_by_name (l_author) as u then
										i.set_author (u)
									end
								end
							end
							if a_changes.has_expected_author (i) then
								a_changes.force (i)
							else
									-- filtered out.
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation		

	wdocs_page_cms_menu_link (a_version_id: detachable READABLE_STRING_GENERAL; a_book: WIKI_BOOK; a_page: detachable WIKI_PAGE; a_current_page_name: detachable READABLE_STRING_GENERAL; is_full: BOOLEAN; mng: WDOCS_MANAGER): CMS_LOCAL_LINK
		local
			l_book_name: READABLE_STRING_GENERAL
			l_page: detachable WIKI_PAGE
			l_title: detachable READABLE_STRING_32
		do
			l_book_name := a_book.name

			if a_page = Void then
				create Result.make (l_book_name, wdocs_book_link_location (a_version_id, l_book_name))
			else
				l_title := mng.wiki_page_link_title (a_page)
				create Result.make (l_title, wdocs_page_link_location (a_version_id, l_book_name, mng.url_friendly_wiki_name (a_page.title)))
			end
			Result.set_expandable (True)
			if a_page /= Void then
				l_page := a_page
			else
				l_page := a_book.root_page
			end
			if l_page /= Void then
				wdocs_append_pages_to_link (a_version_id, l_book_name, a_current_page_name, a_book.top_pages, Result, is_full, mng)
			end
		end

	cached_wdocs_cms_menu (a_menu_title: detachable READABLE_STRING_32; a_version_id: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL; mng: WDOCS_MANAGER): CMS_MENU
		local
			c: detachable WDOCS_CACHE [CMS_MENU]
		do
			if attached wdocs_api as l_wdocs_api then
				c := l_wdocs_api.cache_for_book_cms_menu (a_version_id, a_book_name)
			end
			if c /= Void and then attached c.item as l_menu then
				Result := l_menu
			else
				Result := wdocs_cms_menu (a_menu_title, a_version_id, a_book_name, Void, True, mng)
				if c /= Void then
					c.put (Result)
				end
			end
		end

	wdocs_cms_menu (a_menu_title: detachable READABLE_STRING_32; a_version_id, a_book_name, a_page_name: detachable READABLE_STRING_GENERAL; is_full: BOOLEAN; mng: WDOCS_MANAGER): CMS_MENU
			-- CMS Menu for wdocs books (version `a_version_id`, with `a_book_name`:`a_page_name` optionally selected.
		local
			ln: CMS_LOCAL_LINK
			loc: STRING
			wb: detachable WIKI_BOOK
			l_parent: detachable WIKI_PAGE
		do
			if a_menu_title /= Void then
				create Result.make_with_title ("wdocs-tree", a_menu_title, 3)
			else
				create Result.make ("wdocs-tree", 3)
			end
			if is_full then
				across
					mng.book_names as ic
				loop
					if
						attached mng.book (ic.item) as i_wb and then
						attached i_wb.root_page as l_root_page
					then
						l_root_page.sort
						if
							a_book_name /= Void and then
							i_wb.name.is_case_insensitive_equal_general (a_book_name)
						then
							ln := wdocs_page_cms_menu_link (a_version_id, i_wb, l_root_page, a_page_name, is_full, mng)
							ln.set_expanded (True)
						else
							ln := wdocs_page_cms_menu_link (a_version_id, i_wb, l_root_page, Void, is_full, mng)
							ln.set_collapsed (not i_wb.top_pages.is_empty)
						end
						Result.extend (ln)
					end
				end
			else
				if a_book_name /= Void then
					if a_page_name = Void then
						create ln.make (a_book_name.to_string_32, wdocs_book_link_location (a_version_id, a_book_name))
						ln.set_expandable (True)
						Result.extend (ln)
						wb := mng.book (a_book_name)
						if wb /= Void then
							if attached wb.root_page as wp then
								wp.sort
								if attached wp.pages as l_wp_pages then
									ln.set_expanded (not l_wp_pages.is_empty)
									wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_wp_pages, ln, is_full, mng)
								end
							else
								wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, wb.top_pages, ln, is_full, mng)
							end
						end
					else
						if a_book_name /= Void then
							wb := mng.book (a_book_name)
							loc := wdocs_page_link_location (a_version_id, a_book_name, mng.url_friendly_wiki_name (a_page_name))
						else
							loc := wdocs_page_link_location (a_version_id, "???", mng.url_friendly_wiki_name (a_page_name))
						end

						if wb /= Void and then attached wb.page (a_page_name) as wp then
							l_parent := wb.page_by_key (wp.parent_key)
							if l_parent /= Void then
								create ln.make ({STRING_32} "Back to: " + mng.wiki_page_title (l_parent), wdocs_page_link_location (a_version_id, wb.name, mng.url_friendly_wiki_name (l_parent.title)))
								ln.set_expandable (True)
								Result.extend (ln)

								l_parent.sort
								if attached l_parent.pages as l_wp_pages and then not l_wp_pages.is_empty then
									wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_wp_pages, ln, is_full, mng)
								else
									check has_wp: False end
								end
							else
								create ln.make ({STRING_32}"Book %"" + wb.name + "%"", wdocs_book_link_location (a_version_id, wb.name))
								ln.set_expandable (True)
								Result.extend (ln)

								if attached wb.top_pages as l_pages and then not l_pages.is_empty then
									wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_pages, ln, is_full, mng)
								end

	--								-- Is top  ..?
	--							create ln.make (a_page_name.to_string_32, loc)
	--							Result.extend (ln)
	--							if attached wp.pages as l_wp_pages and then not l_wp_pages.is_empty then
	--								ln.set_expandable (True)
	--								wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_wp_pages, ln)
	--							end
							end

						else
							create ln.make (a_page_name.to_string_32, loc)
							Result.extend (ln)
						end
					end
				end
				across
					mng.book_names as ic
				loop
					if
						a_book_name = Void
						or else not a_book_name.is_case_insensitive_equal (ic.item)
					then
						create ln.make (ic.item, wdocs_book_link_location (a_version_id, ic.item))
						Result.extend (ln)
					end
				end
			end
		end

	wdocs_append_pages_to_link (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL; a_active_page_name: detachable READABLE_STRING_GENERAL;
					a_pages: LIST [WIKI_PAGE]; a_link: CMS_LOCAL_LINK; is_full: BOOLEAN; mng: WDOCS_MANAGER)
			-- Append pages `a_pages' to link `a_link', for book `a_book_name' version `a_version_id'.
			-- If `is_full' recursively appends sub pages as well.
			-- Set page named `a_active_page_name' as active if any.
		require
			is_expandable: a_link.is_expandable
		local
			sub_ln: CMS_LOCAL_LINK
			wp: WIKI_PAGE
			l_is_active: BOOLEAN
			l_title: STRING
		do
			if a_pages.is_empty then
				a_link.set_expandable (False)
			else
				a_link.set_expandable (True)
				if not a_link.is_expanded and is_full then
					a_link.set_collapsed (True)
				end
				across
					a_pages as ic
				loop
					wp := ic.item
					l_title := mng.wiki_page_link_title (wp)
					create sub_ln.make (l_title, wdocs_page_link_location (a_version_id, a_book_name, mng.url_friendly_wiki_name (wp.title)))
					l_is_active := a_active_page_name /= Void and then
									a_active_page_name.is_case_insensitive_equal (wp.title)

					if l_is_active then
						a_link.set_expanded (True)
					end
					if wp.has_page then
						sub_ln.set_expandable (wp.has_page)

						if is_full or l_is_active then
								-- FIXME: find a way to mark it as current doc!
							wp.sort
							if
								attached wp.pages as l_wp_pages and then
								not l_wp_pages.is_empty
							then
								wdocs_append_pages_to_link (a_version_id, a_book_name, a_active_page_name, l_wp_pages, sub_ln, is_full, mng)
								if sub_ln.is_expanded and then not a_link.is_expanded then
									a_link.set_expanded (True)
								end
							end
						end
					end
					a_link.add_link (sub_ln)
				end
			end
		end

feature -- Hook

	populate_content_associated_with_term (a_term: CMS_TERM; a_contents: CMS_TAXONOMY_ENTITY_CONTAINER)
			-- Populate `a_contents` with taxonomy entity associated with term `t`.
		local
			c: CMS_WDOCS_CONTENT
			lnk: CMS_LOCAL_LINK
			l_uuid: READABLE_STRING_GENERAL
			l_info_to_remove: ARRAYED_LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
		do
			if attached wdocs_api as l_wdocs_api then
				create l_info_to_remove.make (0)
				across
					a_contents.taxonomy_info as ic
				loop
					if
						attached ic.item.typename as l_typename and then
						l_typename.is_case_insensitive_equal_general ({CMS_WDOCS_CONTENT_TYPE}.name)
					then
						l_uuid := ic.item.entity
						if attached l_wdocs_api.wiki_page_by_uuid (l_uuid, Void, Void) as pg then
							create {CMS_WDOCS_CONTENT} c.make (pg, l_uuid)
							create lnk.make (pg.title, "doc/uuid/" + url_encoded (l_uuid))
							c.set_link (lnk)
							a_contents.force (create {CMS_TAXONOMY_ENTITY}.make (c, create {DATE_TIME}.make_now_utc))
							l_info_to_remove.force (ic.item)
						end
					end
				end
				across
					l_info_to_remove as ic
				loop
					a_contents.taxonomy_info.prune_all (ic.item)
				end
			end
		end

feature -- Handler

	handle_documentation (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			b: STRING
			l_version_id, l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
			l_toc: BOOLEAN
			wp: detachable WIKI_BOOK_PAGE
			l_book: detachable WIKI_BOOK
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end

			l_version_id := version_id (req, Void)
			l_bookid := book_id (req, Void)

			if req.is_get_request_method then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.values.force (l_version_id, "wiki_version_id")
			mnger := manager (l_version_id)

			if l_bookid /= Void then
				if attached {WSF_STRING} req.query_parameter ("toc") as p_toc then
					l_toc := not p_toc.value.is_case_insensitive_equal_general ("no")
				end

				l_book := mnger.book (l_bookid)
				if l_book /= Void then
					wp := l_book.root_page
				end

				r.set_optional_content_type (documentation_content_type)
				r.set_title (l_bookid)
				r.values.force (l_bookid, "wiki_book_name")
				if l_toc or wp = Void then
					create b.make_from_string ("<h1>Book # " + html_encoded (l_bookid) + "</h1>")
					if l_book /= Void then
						b.append ("<div class=%"wdocs-nav%"><ul>")
						if wp /= Void then
							b.append ("<li>")
							append_wiki_page_link (req, l_version_id, l_bookid, wp, True, mnger, b)
							b.append ("</li>")
						else
							across
								l_book.top_pages as ic
							loop
								b.append ("<li>")
								append_wiki_page_link (req, l_version_id, l_bookid, ic.item, True, mnger, b)
								b.append ("</li>")
							end
						end
						b.append ("</ul></div>")
					end
					r.set_main_content (b)
					r.execute
				else
					send_wikipage (wp, mnger, l_bookid, api, req, res)
				end
			else
				create b.make_empty
				wp := mnger.index_page
				if wp /= Void then
					send_wikipage (wp, mnger, "", api, req, res)
				else
					r.set_optional_content_type (documentation_content_type)
					r.set_title (Void) --"Documentation")
					r.set_main_content (b)
					r.execute
				end
			end
		end

	handle_wikipage_by_eis_id (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Resolve the EIS url into wdoc page, if possible.
			-- ex: /doc/eis/78D80981-EF3C-42EC-8919-EF7D7BB61701%40time%40time%40DATE_TIME
		local
			r: CMS_RESPONSE
			l_version_id, l_eis_id: detachable READABLE_STRING_GENERAL
			l_uuid, l_library, l_cluster, l_class: detachable READABLE_STRING_GENERAL
			s: detachable READABLE_STRING_32
			lst: LIST [READABLE_STRING_GENERAL]
			utf: UTF_CONVERTER
		do
			if req.is_get_request_method then
				l_version_id := version_id (req, Void)
				if attached {WSF_STRING} req.path_parameter ("eis_id") as p_eis_id then
					l_eis_id := p_eis_id.value
					lst := l_eis_id.split ('@')
					if lst.is_empty then
						-- Bad request !
					else
						l_uuid := lst.first
						lst.start
						lst.remove
						if lst.count >= 3 then
							lst.start
							l_library := lst.item
							lst.remove
						end
						if lst.count >= 2 then
							lst.start
							l_cluster := lst.item
							lst.remove
						end
						if lst.count >= 1 then
							lst.start
							l_class := lst.first
							lst.remove
						end
					end
				end
				if l_eis_id = Void or l_uuid = Void then
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				else
					if attached api.module_configuration (Current, "eis") as cfg then
						s := cfg.text_item (eis_query_config_key (l_uuid, l_library, l_cluster, l_class))
						if s = Void and l_library /= Void then
							s := cfg.text_item (eis_query_config_key (l_uuid, Void, l_cluster, l_class))
						end
						if s = Void and l_cluster /= Void then
							s := cfg.text_item (eis_query_config_key (l_uuid, Void, Void, l_class))
						end
						if s = Void and l_class /= Void then
							s := cfg.text_item (eis_query_config_key (l_uuid, Void, Void, Void))
						end
					end
					if s /= Void then
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						r.set_redirection (wdocs_page_uuid_link_location (l_version_id, utf.utf_32_string_to_utf_8_string_8 (s)))
						r.set_main_content ({STRING_32} "UUID associated with %"" + l_eis_id.as_string_32 + {STRING_32} "%" is " + s)
					else
						create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.set_main_content ("Page not found")
						r.set_title ({STRING_32} "Wiki page not found!")
							-- FIXME: Provide a form, to add a new EIS mapping!
						fixme ("Provide a form, to add a new EIS mapping!")
					end
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	eis_query_config_key (a_uuid: READABLE_STRING_GENERAL; a_lib, a_clu, a_cl: detachable READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make_from_string_general (a_uuid)
			Result.append_character ('.')
			if a_lib /= Void then
				Result.append_string_general (a_lib)
			else
				Result.append_character ('*')
			end
			Result.append_character ('.')
			if a_clu /= Void then
				Result.append_string_general (a_clu)
			else
				Result.append_character ('*')
			end
			Result.append_character ('.')
			if a_cl /= Void then
				Result.append_string_general (a_cl)
			else
				Result.append_character ('*')
			end
		end

	handle_wikipage_by_uuid (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			wnotfound: WDOCS_PAGE_NOT_FOUND_CMS_RESPONSE
			l_expected_url: STRING
		do
			if req.is_get_request_method then
				if attached wikipage_data_from_request (req) as pg_info then
					if attached wdocs_page_link_location (pg_info.manager.version_id, pg_info.bookid, pg_info.manager.url_friendly_wiki_name (pg_info.page.title)) as l_url then
						if attached req.query_string as qs and then not qs.is_whitespace then
							l_expected_url := l_url + "?" + qs
						else
							l_expected_url := l_url
						end
						res.redirect_now (req.absolute_script_url ("/" + l_expected_url))
					else
						send_wikipage (pg_info.page, pg_info.manager, pg_info.bookid, api, req, res)
					end
				elseif
					attached wdocs_api as l_wdocs_api and then
					attached wikipage_ids_from_request (req) as pg_ids
				then
					create wnotfound.make (req, res, l_wdocs_api)
					wnotfound.set_request_wiki_ids (pg_ids.wiki_id, pg_ids.bookid, pg_ids.version_id, pg_ids.wiki_uuid)
					wnotfound.execute
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("Page not found")
					r.set_title ({STRING_32} "Wiki page not found!")
					r.execute
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

	handle_wikipage (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			wnotfound: WDOCS_PAGE_NOT_FOUND_CMS_RESPONSE
			l_expected_url: STRING
		do
			if req.is_get_request_method then
				if attached wikipage_data_from_request (req) as pg_info then
					if
						attached wdocs_page_link_location (pg_info.manager.version_id, pg_info.bookid, pg_info.manager.url_friendly_wiki_name (pg_info.page.title)) as l_url and then
						req.percent_encoded_path_info.substring_index (l_url, 1) < 2 -- missing first "/" for l_url
					then
						if attached req.query_string as qs and then not qs.is_whitespace then
							l_expected_url := l_url + "?" + qs
						else
							l_expected_url := l_url
						end
						res.redirect_now (req.absolute_script_url ("/" + l_expected_url))
					else
						send_wikipage (pg_info.page, pg_info.manager, pg_info.bookid, api, req, res)
					end
				elseif
					attached wdocs_api as l_wdocs_api and then
					attached wikipage_ids_from_request (req) as pg_ids
				then
					create wnotfound.make (req, res, l_wdocs_api)
					wnotfound.set_request_wiki_ids (pg_ids.wiki_id, pg_ids.bookid, pg_ids.version_id, pg_ids.wiki_uuid)
					wnotfound.execute
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("Page not found")
					r.set_title ({STRING_32} "Wiki page not found!")
					r.execute
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

	handle_wikipage_references (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if req.is_get_request_method then
				if attached wikipage_data_from_request (req) as pg_info then
					if attached wdocs_api as l_wdocs_api then
						if attached l_wdocs_api.page_references (pg_info.page, pg_info.bookid, pg_info.manager.version_id) as lst then
						end
						create {NOT_IMPLEMENTED_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.execute
					else
						create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.execute
					end
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("Page not found")
					r.set_title ({STRING_32} "Wiki page not found!")
					r.execute
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

	handle_wiki_file (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
			--|	map: "/doc-file/{bookid}/{filename}"
		local
			l_version_id,
			l_bookid,
			l_filename: detachable READABLE_STRING_32
			l_not_found: WSF_NOT_FOUND_RESPONSE
			l_file_response: WSF_FILE_RESPONSE
			mnger: WDOCS_MANAGER
			p: detachable PATH
			h: HTTP_HEADER
			dt: DATE_TIME
			ut: FILE_UTILITIES
		do
			l_version_id := version_id (req, Void)
			l_bookid := book_id (req, Void)
			l_filename := text_path_parameter (req, "filename", Void)
			if l_filename /= Void then
				mnger := manager (l_version_id)
				p := mnger.file_path (l_filename, l_bookid)

				if p /= Void and then ut.file_path_exists (p) then
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
			else
				create l_not_found.make (req)
				res.send (l_not_found)
			end
		end

	handle_wiki_image (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
			--|	map: "/doc/_images/{filename}"
		local
			l_version_id,
			l_bookid,
			l_filename: detachable READABLE_STRING_32
			l_not_found: WSF_NOT_FOUND_RESPONSE
			l_file_response: WSF_FILE_RESPONSE
			mnger: WDOCS_MANAGER
			p: PATH
			h: HTTP_HEADER
			dt: DATE_TIME
			ut: FILE_UTILITIES
		do
			l_version_id := version_id (req, Void)
			l_bookid := book_id (req, Void)
			l_filename := text_path_parameter (req, "filename", Void)
			if l_bookid /= Void and l_filename /= Void then
				mnger := manager (l_version_id)
				p := mnger.wiki_database_path.extended (l_bookid).extended ("_images").extended (l_filename)
				if not ut.file_path_exists (p) then
					p := mnger.wiki_database_path.extended ("_images").extended (l_filename)
				end

				if ut.file_path_exists (p) then
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
			elseif attached text_path_parameter (req, "image_id", Void) as l_img_id then
				mnger := manager (l_version_id)
				if attached mnger.image_path (l_img_id, Void) as l_img_path then
					create l_file_response.make (l_img_path.name)
	--				l_file_response.set_expires_in_seconds (24*60*60)
					res.send (l_file_response)
				else
					create l_not_found.make (req)
					l_not_found.add_suggested_text ("Not Yet Implemented .. ", Void)
					if attached req.http_referer as ref then
						l_not_found.add_suggested_location (ref, "Back to previous page [" + ref + "]", Void)
					end
					res.send (l_not_found)
				end
			else
				create l_not_found.make (req)
				res.send (l_not_found)
			end
		end

	handle_static_documentation (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle /doc-static/... request to redirect to expected static doc location.
		local
			redir: CMS_REDIRECTION_RESPONSE_MESSAGE
			vid, loc: detachable STRING
			l_is_ref: BOOLEAN
		do
			if attached {WSF_STRING} req.path_parameter ("version_id") as v then
				vid := v.url_encoded_value
			end
			if attached {WSF_TABLE} req.path_parameter ("vars") as vars then
				create loc.make_empty
				across
					vars as ic
				loop
					if attached {WSF_STRING} ic.item as v then
						if v.value.same_string_general ("reference") then
							l_is_ref := True
						else
							loc.append_character ('/')
							loc.append (url_encoded (v.value))
						end
					end
				end
				if l_is_ref then
					loc.append (".html")
				end
			else
				loc := "/index.html"
			end
			if vid = Void then
				vid := percent_encoder.percent_encoded_string (default_version_id)
			end
			create redir.make (req.absolute_script_url ("/files/doc/static/" + vid + loc))
			res.send (redir)
		end

feature {WDOCS_EDIT_MODULE, WDOCS_EDIT_FORM_RESPONSE} -- Implementation: request and response.

	send_wikipage (pg: attached like {WDOCS_MANAGER}.page;
					a_manager: WDOCS_MANAGER;
					a_bookid: READABLE_STRING_GENERAL;
					api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			pgr: WDOCS_PAGE_CMS_RESPONSE
			r: CMS_RESPONSE
			s: STRING
			l_title: detachable READABLE_STRING_32
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end

			if req.is_get_request_method then
				create pgr.make_with_page (a_bookid, pg, a_manager.version_id, req, res, api)
				r := pgr
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end

			r.set_optional_content_type (documentation_content_type)
			r.values.force (a_manager.version_id, "wiki_version_id")
			if a_bookid /= Void then
				r.values.force (a_bookid, "wiki_book_name")
			end

			if pg /= Void then
				create s.make_empty

				if
					attached a_manager.page_metadata (pg, <<"title", "uuid", "link_title">>) as md and then
					attached md.item ("title") as l_md_title and then
					not l_md_title.is_whitespace
				then
					l_title := l_md_title
					if attached md.item ("uuid") as l_uuid then
						r.values.force (l_uuid, "wiki_uuid")
					end
					if attached md.item ("link_title") as l_link_title then
						r.values.force (l_link_title, "wiki_link_title")
					else
						r.values.force (l_title, "wiki_link_title")
					end
				else
					l_title := pg.title
				end
--				r.set_title (l_title)
				r.set_title (Void)
				r.set_value (l_title, "site_title")
				r.values.force (l_title, "wiki_page_name")
				if attached {WSF_STRING} req.query_parameter ("source") as s_source and then not s_source.is_case_insensitive_equal ("no") then
					if attached pg.path as l_path then
						s.append ("File: ")
						s.append (html_encoded (l_path.absolute_path.canonical_path.name))
						s.append ("<br/>")
					end
					if attached wiki_text (pg) as l_wiki_text then
						s.append ("Wiki text:<pre style=%"border: solid 1px #000; background-color: #ffa; white-space: pre-wrap; %">%N")
						s.append (l_wiki_text)
						s.append ("%N</pre>")
					end
--					s.append ("HTML rendering:<pre style=%"border: solid 1px #000; background-color: #afa; white-space: pre-wrap;%">%N")
--					s.append (html_encoded (s))
--					s.append ("</pre>")
				else
					r.set_metadata ({STRING_32} "article", "type")
					if attached pg.metadata ("description") as l_wp_description then
						r.set_description (l_wp_description)
					end
					append_wiki_page_xhtml_to (pg, l_title, a_bookid, a_manager, s, req, r)

					if attached pg.metadata ("publication_date") as l_pub_date and then attached date_time_from_string (l_pub_date) as dt then
						r.set_publication_date (dt)
					end
					if attached pg.metadata ("modification_date") as l_mod_date and then attached date_time_from_string (l_mod_date) as dt then
						r.set_modification_date (dt)
					end

					if attached {WSF_STRING} req.query_parameter ("debug") as s_debug and then not s_debug.is_case_insensitive_equal ("no") then
						s.append ("<hr/>")
						if attached pg.path as l_path then
							s.append ("File: ")
							s.append (html_encoded (l_path.absolute_path.canonical_path.name))
							s.append ("<br/>")
						end
						if attached wiki_text (pg) as l_wiki_text then
							s.append ("Wiki text:<pre style=%"border: solid 1px #000; background-color: #ffa; white-space: pre-wrap; %">%N")
							s.append (l_wiki_text)
							s.append ("%N</pre>")
						end

						s.append ("HTML rendering:<pre style=%"border: solid 1px #000; background-color: #afa; white-space: pre-wrap;%">%N")
						s.append (html_encoded (s))
						s.append ("</pre>")
					end
				end
			else
				r.set_title ({STRING_32} "Wiki page not found!")
				create s.make_from_string ("Page not found")
			end


			debug ("wdocs")
				append_navigation_to (req, s)
			end

			r.set_main_content (s)
			r.execute
		end

	wikipage_data_from_request (req: WSF_REQUEST): like wikipage_data_from_ids
			-- Page information related with request `req`.
		local
			l_ids: like wikipage_ids_from_request
		do
			if attached wdocs_api as l_api then
				l_ids := wikipage_ids_from_request (req)
				Result := wikipage_data_from_ids (l_ids)
			end
		end

	wikipage_from_request (req: WSF_REQUEST): detachable like {WDOCS_MANAGER}.page
			-- Page associated with request `req'.
		do
			if attached wikipage_data_from_request (req) as l_info then
				Result := l_info.page
			end
		end

	wikipage_data_from_ids (ids: like wikipage_ids_from_request): detachable TUPLE [page: attached like {WDOCS_MANAGER}.page;
				bookid: READABLE_STRING_GENERAL; manager: WDOCS_MANAGER]
		local
			pg: detachable like {WDOCS_MANAGER}.page
			l_book_id: detachable READABLE_STRING_GENERAL
			mng: like manager
		do
			if attached wdocs_api as l_api then
				l_book_id := ids.bookid
				pg := l_api.wiki_page (ids.wiki_id, l_book_id, ids.version_id)

				if pg = Void and attached ids.wiki_uuid as l_wiki_uuid then
					pg := l_api.wiki_page_by_uuid (l_wiki_uuid, l_book_id, ids.version_id)
				end
				if pg /= Void then
					mng := manager (ids.version_id)
					if l_book_id = Void then
						l_book_id := mng.book_name (pg)
					elseif not mng.has_book_named (l_book_id) then
						l_book_id := Void
					end
					if l_book_id /= Void then
						Result := [pg, l_book_id, mng]
					elseif pg.is_index_page then
						Result := [pg, "", mng] -- Main doc index page!
					end
				end
			end
		end

	wikipage_ids_from_request (req: WSF_REQUEST): TUPLE [wiki_id, bookid, version_id, wiki_uuid: detachable READABLE_STRING_GENERAL]
		do
			Result := [	wikipage_id (req, Void),
						book_id (req, Void),
						version_id (req, Void),
						wikipage_uuid (req, Void)
						]
		end

feature {WDOCS_EDIT_MODULE} -- Implementation: wiki render	

	version_id (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := text_path_parameter (req, "version_id", a_default)
		end

	book_id (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := wiki_name_text_path_parameter (req, "bookid", a_default)
			if Result /= Void and then Result.is_whitespace then
				Result := Void
			end
		end

	wikipage_id (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := wiki_name_text_path_parameter (req, "wikipageid", a_default)
		end

	wikipage_uuid (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := text_path_parameter (req, "wikipage_uuid", a_default)
		end

	append_navigation_to (req: WSF_REQUEST; s: STRING)
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end
			s.append ("<li><a href=%"" + req.script_url ("/") + "%">back to home</a></li>")
			if attached req.http_referer as l_ref then
				s.append ("<li><a href=%"" + l_ref + "%">back to " + l_ref + "</a></li>")
			end
			s.append ("<li>Location: " + req.request_uri + "</li>")
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_BOOK_PAGE; a_page_title: detachable READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_output: STRING; req: WSF_REQUEST; a_response: CMS_RESPONSE)
		local
			l_cache: detachable WDOCS_FILE_STRING_8_CACHE
			l_xhtml: detachable STRING_8
			lab: detachable READABLE_STRING_32
			f: PLAIN_TEXT_FILE
			l_wiki_page_date_time: detachable DATE_TIME
			client_request_no_server_cache: BOOLEAN
			l_version_id: detachable READABLE_STRING_GENERAL
		do
				-- FIXME: move cache access to `wdocs_api', to give WDOCS_EDIT_MODULE the possibility to reset it.
			l_version_id := version_id (req, Void)
			if l_version_id = Void then
				l_version_id := a_manager.version_id
			end
			if cache_disabled then
					-- No cache!
			else
				if attached wdocs_api as l_wdocs_api then
					l_cache := l_wdocs_api.cache_for_wiki_page_xhtml (l_version_id, a_book_name, a_wiki_page)
				end
				if attached a_wiki_page.path as l_pg_path then
					create f.make_with_path (l_pg_path)
					if f.exists and then f.is_access_readable then
						create l_wiki_page_date_time.make_from_epoch (f.date)
						a_response.set_modification_date (l_wiki_page_date_time)
					end
				end
			end

			client_request_no_server_cache := attached req.meta_string_variable ("HTTP_CACHE_CONTROL") as s_cache_control and then
						s_cache_control.is_case_insensitive_equal_general ("no-cache")

			if
				not client_request_no_server_cache and then
				l_cache /= Void and then -- i.r: cache enabled
				l_cache.exists and then
				not l_cache.expired (l_wiki_page_date_time, cache_duration)
			then
				create l_xhtml.make (l_cache.file_size)
				l_cache.append_to (l_xhtml)

				l_xhtml.append ("<div class=%"wdocs-cache-info%">cached: " + l_cache.cache_date_time.out + "</div>")
			else
				create l_xhtml.make_empty
				if not l_version_id.is_case_insensitive_equal (default_version_id) then
					if attached wdocs_api as l_wdocs_api then
						lab := l_wdocs_api.label_of_version (default_version_id)
					end
					if lab = Void then
						lab := {STRING_32} "current"
					end
					l_xhtml.append ("<ul class=%"message%"><li class=%"warning%">This is not the " + lab + " version of the documentation. ")
					a_response.append_link_to_html ("Recommended Version", a_manager.wiki_page_uri_path (a_wiki_page, a_book_name, Void), Void, l_xhtml)
					l_xhtml.append ("</li></ul>")
				end
				if attached wdocs_api as l_wdocs_api then
					l_wdocs_api.append_available_versions_menu_to_xhtml (a_wiki_page, l_version_id, a_response, l_xhtml)
					if attached {CMS_TAXONOMY_API} l_wdocs_api.cms_api.module_api ({CMS_TAXONOMY_MODULE}) as l_taxonomy_api and then attached a_wiki_page.metadata ("uuid") as l_uuid then
						l_taxonomy_api.append_taxonomy_to_xhtml (create {CMS_WDOCS_CONTENT}.make (a_wiki_page, l_uuid), a_response, l_xhtml)
					end
				end
				if attached a_wiki_page.text.content as l_wiki_content then
					l_xhtml.append (wiki_to_xhtml (wdocs_api, a_page_title, l_wiki_content, a_wiki_page, a_manager))
				end

					-- Parent and child navigation
				l_xhtml.append ("<div class=%"wdocs-nav%">")
				a_wiki_page.sort
				if attached a_wiki_page.pages as l_sub_pages and then l_sub_pages.count > 0 then
					l_xhtml.append ("<div class=%"wdocs-nav-section%">Read more</div>")
					l_xhtml.append ("<ul>")

					across
						l_sub_pages as ic
					loop
						l_xhtml.append ("<li> ")
						append_wiki_page_link (req, l_version_id, a_book_name, ic.item, False, a_manager, l_xhtml)
						l_xhtml.append ("</li>")
					end

					l_xhtml.append ("</ul>")
				end

				if
					a_book_name /= Void and then
					attached a_manager.page (a_wiki_page.parent_key, a_book_name) as l_parent_page and then
					l_parent_page /= a_wiki_page
				then
					l_xhtml.append ("<div class=%"wdocs-nav-section%">Back to ")
					append_wiki_page_link (req, l_version_id, a_book_name, l_parent_page, False, a_manager, l_xhtml)
					l_xhtml.append ("</div>")
				end

					-- UUID if any...
				if attached a_wiki_page.metadata ("uuid") as l_uuid then
					l_xhtml.append ("<div class=%"wdocs-uuid%">")
					if attached wdocs_api as l_wdocs_api then
						l_xhtml.append ("<a href=%"")
						l_xhtml.append (l_wdocs_api.cms_api.location_url (wdocs_page_uuid_link_location (l_version_id, utf_8_encoded (l_uuid)), Void))
						l_xhtml.append ("%">Permanent link</a>")
					else
						l_xhtml.append (utf_8_encoded (l_uuid))
					end
					l_xhtml.append ("</div>%N")
				end
				l_xhtml.append ("</div>%N")

				if l_cache /= Void then
					l_cache.put (l_xhtml)
				end
			end
			a_output.append (l_xhtml)
		end

	wiki_text (pg: like wdocs_api.new_wiki_page): detachable READABLE_STRING_8
		require
			has_wdocs_api: wdocs_api /= Void
		do
			if attached wdocs_api as l_wdocs_api then
				Result := l_wdocs_api.wiki_text (pg)
			else
				check has_wdocs_api: False end
				Result := pg.text.content
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

	append_wiki_page_link (req: WSF_REQUEST; a_version_id, a_book_id: detachable READABLE_STRING_GENERAL; a_page: WIKI_BOOK_PAGE; is_recursive: BOOLEAN; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_pages: detachable LIST [WIKI_BOOK_PAGE]
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end
			a_page.sort
			l_pages := a_page.pages
			if l_pages /= Void and then l_pages.is_empty then
				l_pages := Void
			end

			if a_book_id /= Void then
				a_output.append ("<a href=%"" + req.script_url ("/" + wdocs_page_link_location (a_version_id, a_book_id, a_manager.url_friendly_wiki_name (a_page.title))) + "%"")
			else
				a_output.append ("<a href=%"../" + wiki_name_to_url_encoded_string (a_manager.url_friendly_wiki_name (a_page.title)) + "%"")
			end
			if l_pages /= Void then
				a_output.append (" class=%"wdocs-folder%"")
			else
				a_output.append (" class=%"wdocs-page%"")
			end
			a_output.append (">")
			a_output.append (html_encoder.general_encoded_string (a_manager.wiki_page_link_title (a_page)))
			a_output.append ("</a>")

			if l_pages /= Void then
				check pages_not_empty: not l_pages.is_empty end
				if is_recursive then
					a_output.append ("<ul>")
					across
						l_pages as ic
					loop
						a_output.append ("<li>")
						append_wiki_page_link (req, a_version_id, a_book_id, ic.item, is_recursive, a_manager, a_output)
						a_output.append ("</li>")
					end
					a_output.append ("</ul>")
				end
			end
		end

	wdocs_book_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): STRING
		do
			create Result.make_from_string ("doc/")
			if a_version_id /= Void and then not a_version_id.same_string (default_version_id) then
				Result.append ("version/")
				Result.append (percent_encoder.percent_encoded_string (a_version_id))
				Result.append_character ('/')
			end
			Result.append (wiki_name_to_url_encoded_string (a_book_name))
		end

	wdocs_page_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL; a_page_name: READABLE_STRING_GENERAL): STRING
		do
			Result := wdocs_book_link_location (a_version_id, a_book_name)
			Result.append ("/")
				-- Encode twice, to avoid issue with / or %2F issue with apache.
			Result.append (wiki_name_to_url_encoded_string (a_page_name))
		end

	wdocs_page_uuid_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_uuid: READABLE_STRING_8): STRING
		do
			create Result.make_from_string ("doc/")
			if a_version_id /= Void and then not a_version_id.same_string (default_version_id) then
				Result.append ("version/")
				Result.append (percent_encoder.percent_encoded_string (a_version_id))
				Result.append_character ('/')
			end
			Result.append ("uuid/")
			Result.append (a_uuid)
		end

feature {NONE} -- Implementation		

	template_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id`.
		local
			res: PATH
			p: detachable PATH
		do
			create res.make_from_string ("templates")
			res := res.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (Current, res)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
		end

	append_info_to (n: READABLE_STRING_8; v: detachable READABLE_STRING_GENERAL; a_response: CMS_RESPONSE; t: STRING)
		do
			t.append ("<li>")
			t.append ("<strong>" + n + "</strong>: ")
			if v /= Void then
				t.append (a_response.html_encoded (v))
			end
			t.append ("</li>")
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
