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

end
