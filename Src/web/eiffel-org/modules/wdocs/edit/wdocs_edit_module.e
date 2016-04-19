note
	description: "Summary description for {WDOCS_EDIT_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_MODULE

inherit
	CMS_MODULE
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	WDOCS_MODULE_HELPER
		undefine
			percent_encoder
		end

create
	make

feature {NONE} -- Initialization

	make (wdocs: WDOCS_MODULE)
			-- Create current module
		do
			wdocs_module := wdocs
			version := "1.0"
			description := "Wiki Documentation Editing"
			package := "doc"
		end

feature -- Access

	name: STRING = "wdocs_edit"

	wdocs_module: WDOCS_MODULE

	wdocs_api: detachable WDOCS_API
		do
			Result := wdocs_module.wdocs_api
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		local
			h: WSF_URI_TEMPLATE_AGENT_HANDLER
		do
				-- Router			
			create h.make (agent handle_wikipage_source (a_api, ?, ?))
			a_router.handle ("/doc/{bookid}/{wikipageid}/source", h, a_router.methods_get)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/source", h, a_router.methods_get)

			create h.make (agent handle_wikipage_editing (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/edit", h, a_router.methods_get_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/edit", h, a_router.methods_get_post)

--			create h.make (agent handle_wikipage_editing (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/add-child", h, a_router.methods_get_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/add-child", h, a_router.methods_get_post)

			create h.make (agent handle_wikipage_deletion (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/delete", h, a_router.methods_get_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/delete", h, a_router.methods_get_post)

			create h.make (agent handle_wikipage_html_preview (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/preview", h, a_router.methods_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/preview", h, a_router.methods_post)
		end

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		do
			Result := Precursor
			Result.force ("admin wdocs")
			Result.force (perm_edit_wdocs_page)
			Result.force (perm_create_wdocs_page)
			Result.force (perm_delete_wdocs_page)

			Result.force ("edit any wdocs page")
			Result.force ("delete any wdocs page")
			Result.force ("edit own wdocs page")
			Result.force ("delete own wdocs page")

			Result.force ("clear wdocs cache")
		end

	perm_edit_wdocs_page: STRING = "edit wdocs page"
	perm_create_wdocs_page: STRING = "create wdocs page"
	perm_delete_wdocs_page: STRING = "delete wdocs page"

feature -- Helper

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		do
			Result := wdocs_module.manager (a_version_id)
		end

feature -- Handlers

	handle_wikipage_source (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				if
					attached wdocs_module.wikipage_data_from_request (req) as pg_info and then
					attached pg_info.page as pg and then
					attached wdocs_api as l_wdocs_api and then
					attached l_wdocs_api.wiki_text (pg) as l_wiki_text
				then
					if attached pg.path as l_path then
						res.header.put_header_key_value ("X-WDOCS-file-location", l_path.utf_8_name)
						res.header.put_utc_date (file_date (l_path))
					end
					res.header.put_content_type_utf_8_text_plain
					res.header.put_content_length (l_wiki_text.count)
					res.put_string (l_wiki_text)
				else
					res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.not_found))
				end
			else
				res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
			end
		end

	handle_wikipage_editing (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if attached wdocs_api as l_api then
				if req.is_get_request_method then
					create {WDOCS_EDIT_FORM_RESPONSE} r.make (req, res, api, l_api, Current)
				elseif req.is_post_request_method then
					create {WDOCS_EDIT_FORM_RESPONSE} r.make (req, res, api, l_api, Current)
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				end
			else
				check has_wdocs_api: False end
				create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	handle_wikipage_deletion (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			pg: detachable WIKI_BOOK_PAGE
			r: CMS_RESPONSE
			f: CMS_FORM
			but: WSF_FORM_SUBMIT_INPUT
			s: STRING
		do
			if api.has_permission (perm_delete_wdocs_page) then
				if attached wdocs_module.wikipage_data_from_request (req) as l_info then
					if attached wdocs_api as l_api then
						pg := l_info.page

						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						create f.make (req.percent_encoded_path_info, "wdocs_page_delete_form")
						create but.make ("confirm")
						but.set_label ("You are about to delete page " + pg.title + " ... (no undo!)")
						but.set_text_value ("DELETE")
						f.extend (but)
						f.set_method_post

						if req.is_get_request_method then
							r.set_main_content (f.to_html (r.wsf_theme))
						elseif req.is_post_request_method then
							f.process (r)
							if
								attached f.last_data as fd and then
								fd.is_valid
							then
								l_api.delete_wiki_page (pg, pg.path, l_info.bookid, l_info.manager, Void)
								if l_api.has_error then
									s := "Page %"" + pg.title + "%" was NOT deleted due to error!!!"
									r.add_error_message (s)
									r.add_error_message (l_api.error_handler.as_string_representation)
									api.process_email (api.new_email (api.setup.site_email, "Failure when deleting wiki page %"" + pg.title + "%"", s + "%N" + l_api.error_handler.as_string_representation))
									l_api.reset_error
									r.set_main_content (f.to_html (r.wsf_theme))
								else
									s := "Page %"" + pg.title + "%" was deleted successfully!"
									r.add_notice_message (s)
									api.process_email (api.new_email (api.setup.site_email, "Deleted wiki page %"" + pg.title + "%"", s))
									r.set_redirection ("documentation") -- FIXME
								end
							else
								r.set_main_content (f.to_html (r.wsf_theme))
							end
						else
							create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
						end
					else
						check has_wdocs_api: False end
						create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, api)
					end
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)

				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	handle_wikipage_html_preview (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_xhtml: STRING
			l_field: READABLE_STRING_GENERAL
		do
			if req.is_post_request_method then
				if attached {WSF_STRING} req.query_parameter ("source_field") as s then
					l_field := s.value
				else
					l_field := "source"
				end
				if
					attached {WSF_STRING} req.form_parameter (l_field) as p_source and then
					attached wdocs_module.wikipage_data_from_request (req) as pg_info and then
					attached pg_info.manager as l_manager and then
					attached pg_info.page as pg and then
					attached pg.path as l_path --and then
--					attached wiki_text (l_path) as l_wiki_text
				then
					l_xhtml := wiki_to_xhtml (wdocs_api, pg.title, p_source.value, pg, l_manager)
					res.header.put_content_type_text_html
					res.header.put_content_length (l_xhtml.count)
					res.put_string (l_xhtml)
				else
					res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
				end
			else
				res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			loc: STRING
			l_version: detachable READABLE_STRING_GENERAL
			lnk: CMS_LOCAL_LINK
		do
			if
				attached {WDOCS_PAGE_CMS_RESPONSE} a_response as l_wdocs_response
			then
				if attached l_wdocs_response.page as pg then
					l_version := l_wdocs_response.version_id
					loc := manager (l_version).wiki_page_uri_path (pg, l_wdocs_response.book_name, l_version)
					if loc.starts_with_general ("/") then
						loc.remove_head (1)
					end
				else
					loc := l_wdocs_response.location
				end

				if l_wdocs_response.has_permission (perm_edit_wdocs_page) then
					create lnk.make ("Edit", loc + "/edit")
					lnk.set_weight (5)
					a_menu_system.primary_tabs.extend (lnk)
					create lnk.make ("Source", loc + "/source")
					lnk.set_weight (4)
					a_menu_system.primary_tabs.extend (lnk)
				end
				if l_wdocs_response.has_permission (perm_delete_wdocs_page) then
					create lnk.make ("Delete", loc + "/delete")
					lnk.set_weight (10)
					a_menu_system.primary_tabs.extend (lnk)
				end
				if l_wdocs_response.has_permission (perm_create_wdocs_page) then
					if l_wdocs_response.book_name.is_empty then
							-- FIXME: add a link to create new book!
--						if l_wdocs_response.has_permission ("create wdocs book") then
--							a_menu_system.primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Create Book", loc + "/add-child"))
--						end
					else
						create lnk.make ("Add Child", loc + "/add-child")
						lnk.set_weight (6)
						a_menu_system.primary_tabs.extend (lnk)
					end
				end
			end
		end

	response_alter (a_response: CMS_RESPONSE)
		do

		end

end
