note
	description: "Summary description for {CMS_DEBUG_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_DEBUG_MODULE

inherit
	CMS_MODULE
		redefine
			setup_hooks
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Debug"
			package := "cms"
		end

feature -- Access

	name: STRING = "debug"

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/debug/", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_debug (a_api, ?, ?)), Void)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"?debug-info">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			b: CMS_CONTENT_BLOCK
			dbg: WSF_DEBUG_INFORMATION
			s: STRING
		do
			create dbg.make
			create s.make_empty
			dbg.append_information_to (a_response.request, a_response.response, s)
			append_info_to ("Storage", a_response.api.storage.generator, a_response, s)
			create b.make ("debug-info", "Debug", s, a_response.api.formats.plain_text)
			b.add_condition (create {CMS_BLOCK_EXPRESSION_CONDITION}.make_none)
			a_response.add_block (b, "footer")
		end

feature -- Handler		

	handle_debug (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
		do
			if req.is_get_request_method then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_title ("DEBUG")

				create s.make_empty
				append_info_to ("Name", api.setup.site_name, r, s)
				append_info_to ("Url", api.setup.site_url, r, s)

				if attached api.setup.environment.cms_config_ini_path as l_loc then
					s.append ("<hr/>")
					append_info_to ("Configuration file", l_loc.name, r, s)
				end

				s.append ("<hr/>")

				append_info_to ("Current dir", execution_environment.current_working_path.utf_8_name, r, s)
--				append_info_to ("Base url", cms.base_url, r, s)
--				append_info_to ("Script url", cms.script_url, r, s)
				s.append ("<hr/>")
				append_info_to ("Site dir", api.site_location.utf_8_name, r, s)
				append_info_to ("Www dir", api.setup.environment.www_path.utf_8_name, r, s)
				append_info_to ("Assets dir", api.setup.environment.assets_path.utf_8_name, r, s)
				append_info_to ("Config dir", api.setup.environment.config_path.utf_8_name, r, s)
				s.append ("<hr/>")
				append_info_to ("Theme", api.theme_name, r, s)
				append_info_to ("Theme location", api.theme_location.utf_8_name, r, s)
				s.append ("<hr/>")
				append_info_to ("Files location", api.files_location.utf_8_name, r, s)
				append_info_to ("Modules location", api.modules_location.utf_8_name, r, s)
				append_info_to ("Storage", api.storage.generator, r, s)
--				s.append ("<hr/>")

				append_info_to ("Url", r.url ("/", Void), r, s)
--				if attached r.user as u then
--					append_info_to ("User", u.name, r, s)
--					append_info_to ("User url", r.user_url (u), r, s)
--				end

				r.set_main_content (s)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	append_info_to (n: READABLE_STRING_8; v: detachable READABLE_STRING_GENERAL; r: CMS_RESPONSE; t: STRING)
		do
			t.append ("<li>")
			t.append ("<strong>" + n + "</strong>: ")
			if v /= Void then
				t.append (r.html_encoded (v))
			end
			t.append ("</li>")
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
