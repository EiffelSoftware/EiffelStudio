note
	description: "Summary description for {WDOCS_MODULE_ADMINISTRATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [WDOCS_MODULE]
		redefine
			setup_hooks
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_CACHE

	CMS_HOOK_EXPORT

	WDOCS_MODULE_HELPER
		undefine
			percent_encoder
		end

create
	make

feature -- Module

	wdocs_api: detachable WDOCS_API
		do
			Result := module.wdocs_api
		end

	manager	(a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		do
			Result := module.manager (a_version_id)
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Setup url dispatching for Current module administration.
			-- (note: `a_router` is already based with admin path prefix).
		local
			h: WSF_URI_TEMPLATE_AGENT_HANDLER
		do
			create h.make (agent handle_admin (a_api, ?, ?))
			a_router.handle ("/module/" + name, h, a_router.methods_get)

			create h.make (agent handle_clear_cache (a_api, ?, ?))
			a_router.handle ("/module/" + name + "/clear-cache", h, a_router.methods_get)

			create h.make (agent handle_update_doc (a_api, ?, ?))
			a_router.handle ("/module/" + name + "/update", h, a_router.methods_get)
		end

feature -- Handler

	handle_admin (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_get_request_method then
				if r.has_permissions (<<"admin wdocs">>) then
					create s.make_from_string ("")
					s.append ("<li>")
					r.append_link_to_html ("Clear cache", api.administration_path ("/module/" + name + "/clear-cache"), Void, s)
					s.append ("</li>%N")
					s.append ("<li>")
					r.append_link_to_html ("Update", api.administration_path ("/module/" + name + "/update"), Void, s)
					s.append ("</li>%N")
					r.set_title ("WDocs management")
					r.set_main_content (s)
				else
					create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	handle_clear_cache (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_version: detachable READABLE_STRING_GENERAL
			mng: like manager
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_get_request_method then
				if r.has_permissions (<<"admin wdocs", "clear wdocs cache">>) then
					if attached {WSF_STRING} req.path_parameter ("version") as p_version then
						l_version := p_version.value
					end
					mng := manager (l_version)
					if l_version = Void then
						l_version := mng.version_id
					end

						-- Clear wiki catalog
					mng.refresh_data

						-- Clear cms menu
					across
						mng.book_names as ic
					loop
						reset_cached_wdocs_cms_menu (l_version, ic.item, mng)
					end

					r.set_main_content ("Documentation cache: cleared.")
					if attached {WSF_STRING} req.query_parameter ("destination") as p_dest then
						r.set_redirection (p_dest.url_encoded_value)
					end
				else
					create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.primary_tabs.extend (api.administration_link ("Wdocs-Administration", "module/" + name))
			r.execute
		end

	handle_update_doc (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_get_request_method then
				if r.has_permissions (<<"admin wdocs", "update wdocs">>) then
					if attached wdocs_api as l_wdocs_api then
						l_wdocs_api.update
						s := "Documentation: updated."
						s.append ("<p>Now, you should <a href=%"" + r.url (api.administration_path ("/module/" + name + "/clear-cache"), Void) + "%">clear the cache</a>.</p>")
					else
						s := "Documentation not updated, contact the webmaster."
					end
					r.set_main_content (s)
					if attached {WSF_STRING} req.query_parameter ("destination") as p_dest then
						r.set_redirection (p_dest.url_encoded_value)
					end
				else
					create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.primary_tabs.extend (api.administration_link ("Docs-Administration", "module/" + name))
			r.execute
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
				-- Module specific hook, if available.
			a_hooks.subscribe_to_cache_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_export_hook (Current)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if a_response.has_permissions (<<"admin wdocs", "clear wdocs cache">>) then
				lnk := a_response.administration_link ("Docs", "module/" + name)
				a_menu_system.management_menu.extend (lnk)

				module.menu_system_alter (a_menu_system, a_response)
			end
		end

	clear_cache (a_cache_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_response: CMS_RESPONSE)
			-- <Precursor>.
		do
			if a_response.has_permission ("clear wdocs cache") then
				if a_cache_id_list = Void and attached manager (Void) as mng then
					mng.refresh_data
					across
						mng.book_names as ic
					loop
						reset_cached_wdocs_cms_menu (mng.version_id, ic.item, mng)
					end
					a_response.add_notice_message ("Cache cleared from " + name)
				end
			end
		end

	reset_cached_wdocs_cms_menu (a_version_id: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER)
		do
			if attached module.wdocs_api as l_wdocs_api then
				l_wdocs_api.reset_cms_menu_cache_for (a_version_id, a_book_name)
			end
		end

feature -- Export data

	export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_ctx: CMS_EXPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Export data identified by `a_export_id_list',
			-- or export all data if `a_export_id_list' is Void.
		local
			mng: like manager
			pg: WIKI_BOOK_PAGE
			d: DIRECTORY
			xhtml_vis: WDOCS_WIKI_XHTML_GENERATOR
			f: RAW_FILE
			l_xhtml: STRING
			l_version_id: READABLE_STRING_GENERAL
			l_book_name: READABLE_STRING_8
			fut: FILE_UTILITIES
			l_resolver: WDOCS_XHTML_EXPORT_RESOLVER
			vid: STRING
			l_map: STRING
			s: STRING
		do
			if
				a_export_id_list = Void
				or else across a_export_id_list as ic some ic.item.same_string ("wdoc") end
			then
				if
					a_response.has_permission ("export wdoc") and then
					attached wdocs_api as l_wdocs_api
				then
					mng := manager (Void)
					l_version_id := mng.version_id
					a_export_ctx.log ("Exporting wdocs item for version " + utf_8_encoded (l_version_id) + ".")
					create d.make_with_path (a_export_ctx.location.extended (module.name).extended (l_version_id))
					if d.exists then
						d.recursive_delete
					end

					create l_xhtml.make (1024)
					create xhtml_vis.make (l_xhtml)
					create l_resolver.make (mng)
					xhtml_vis.set_link_resolver (l_resolver)
					xhtml_vis.set_image_resolver (l_resolver)
					xhtml_vis.set_file_resolver (l_resolver)
					xhtml_vis.set_template_resolver (l_resolver)
					xhtml_vis.code_aliases.force ("eiffel") 	-- Support <eiffel>..</eiffel> as <code lang=eiffel>
					xhtml_vis.code_aliases.force ("e") 		-- Support <e>..</e> as <code lang=eiffel>

						-- register interwiki mapping,
						-- and expand "$version" if any.
					vid := percent_encoder.percent_encoded_string (mng.version_id)
					across
						l_wdocs_api.settings.interwiki_mapping as ic
					loop
						l_map := ic.item
						l_map.replace_substring_all ("$version", vid)
						xhtml_vis.interwiki_mappings.force (l_map, ic.key)
					end

					copy_directory_to (mng.wiki_database_path.extended ("_images"), d.path.extended ("_images"), True)
					copy_directory_to (mng.wiki_database_path.extended ("_files"), d.path.extended ("_files"), True)


					create f.make_with_path (a_export_ctx.location.extended (module.name).extended (mng.version_id).extended ("index").appended_with_extension ("html"))
					f.create_read_write
					f.put_string ("<h1>Documentation</h1><ul>%N")

					across
						mng.book_names as ic
					loop
						if attached mng.book (ic.item) as bk then
							f.put_string ("<li><a href=%""+ url_encoded (bk.name) +"/"+ url_encoded (bk.name) +".html%">" + html_encoded (bk.name) + "</a></li>%N")
						end
					end
					f.put_string ("</ul>%N")
					f.close

					across
						mng.book_names as ic
					loop
						if attached mng.book (ic.item) as bk then
							l_book_name := bk.name
							a_export_ctx.log ("Exporting wdoc book '" + l_book_name + "'.")

							create d.make_with_path (a_export_ctx.location.extended (module.name).extended (mng.version_id).extended (bk.name))
							copy_directory_to (mng.wiki_database_path.extended (l_book_name).extended ("_images"), d.path.extended ("_images"), True)
							copy_directory_to (mng.wiki_database_path.extended (l_book_name).extended ("_files"), d.path.extended ("_files"), True)

							if not d.exists then
								d.recursive_create_dir
							end

							across
								bk.pages as bk_ic
							loop
								pg := bk_ic.item
								a_export_ctx.log ("Exporting wdoc page '" + utf_8_encoded (pg.title) + "'.")

								check empty_buffer: l_xhtml.is_empty end
								l_xhtml.wipe_out
								pg.process (xhtml_vis)

								l_xhtml.append ("<ul class=%"wdocs-nav%">")
								if
									l_book_name /= Void and then
									attached mng.page (pg.parent_key, l_book_name) as l_parent_page and then
									l_parent_page /= pg
								then
									create s.make_empty
									s.append ("<li><em>Parent</em> &lt;")
									append_wiki_page_link (l_version_id, l_book_name, l_parent_page, False, mng, s)
									s.append ("&gt;</li>")
									l_xhtml.prepend (s)
									l_xhtml.append (s)
								end

								pg.sort
								if attached pg.pages as l_sub_pages then
									across
										l_sub_pages as subpg_ic
									loop
										l_xhtml.append ("<li> ")
										append_wiki_page_link (l_version_id, l_book_name, subpg_ic.item, False, mng, l_xhtml)
										l_xhtml.append ("</li>")
									end
								end
								l_xhtml.append ("</ul>")


								create f.make_with_path (d.path.extended (pg.page_id).appended_with_extension ("html")) -- .src
								if f.exists then
									a_response.response.put_error ("FILE ALREADY HERE !!!" + f.path.utf_8_name+"%N")
								end
								fut.create_directory_path (f.path.parent)
								f.create_read_write
								f.put_string (l_xhtml)
								f.close

								l_xhtml.wipe_out
							end
						end
					end
				end
			end
		end


	copy_directory_to (a_from: PATH; a_to: PATH; rec: BOOLEAN)
		local
			d: DIRECTORY
			f: RAW_FILE
			fut: FILE_UTILITIES
		do
			create d.make_with_path (a_from)
			if d.exists then
				fut.create_directory_path (a_to)
				across
					d.entries as ic
				loop
					if ic.item.is_parent_symbol or ic.item.is_current_symbol then
					else
						create f.make_with_path (a_from.extended_path (ic.item))
						if f.is_directory then
							if rec then
								fut.create_directory_path (a_to.extended_path (ic.item))
								copy_directory_to (f.path, a_to.extended_path (ic.item), rec)
							end
						else
							fut.copy_file_path (f.path, a_to.extended_path (ic.item))
						end
					end
				end
			end
		end

	append_wiki_page_link (a_version_id, a_book_id: detachable READABLE_STRING_GENERAL; a_page: WIKI_BOOK_PAGE; is_recursive: BOOLEAN; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_pages: detachable LIST [WIKI_BOOK_PAGE]
		do
			a_page.sort
			l_pages := a_page.pages
			if l_pages /= Void and then l_pages.is_empty then
				l_pages := Void
			end

			if a_book_id /= Void then
				a_output.append ("<a href=%""+ wdocs_page_link_location (a_version_id, a_book_id, a_page.page_id + ".html") + "%"")
			else
				a_output.append ("<a href=%"../" + a_page.page_id + ".html" + "%"")
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
						append_wiki_page_link (a_version_id, a_book_id, ic.item, is_recursive, a_manager, a_output)
						a_output.append ("</li>")
					end
					a_output.append ("</ul>")
				end
			end
		end

	wdocs_book_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): STRING
		local
			p: PATH
		do
			create p.make_from_string ("..")
			p := p.extended (a_book_name)
			Result := p.utf_8_name
		end

	wdocs_page_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL; a_page_name: READABLE_STRING_GENERAL): STRING
		local
			p: PATH
		do
			create p.make_from_string (wdocs_book_link_location (a_version_id, a_book_name))
			p := p.extended (a_page_name)
			Result := p.utf_8_name
		end

end
