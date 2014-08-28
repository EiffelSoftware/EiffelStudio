note
	description: "Summary description for {DEBUG_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_MODULE

inherit
	CMS_MODULE

--	CMS_HOOK_BLOCK

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
			name := "debug"
			version := "1.0"
			description := "Debug"
			package := "cms"
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		do
			service := a_service
			a_service.map_uri_template ("/debug/", agent handle_debug (a_service, ?, ?))
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

	handle_debug (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			e: CMS_EXECUTION
			s: STRING
		do
			if req.is_get_request_method then
				create {ANY_CMS_EXECUTION} e.make (req, res, cms)
				e.set_title ("DEBUG")

				create s.make_empty
				append_info_to ("Name", cms.site_name, e, s)
				append_info_to ("Url", cms.site_url, e, s)

				if attached cms.configuration as cfg and then attached cfg.configuration_location as l_loc then
					s.append ("<hr/>")
					append_info_to ("Configuration file", l_loc.name, e, s)
				end

				s.append ("<hr/>")

				append_info_to ("Current dir", execution_environment.current_working_path.utf_8_name, e, s)
				append_info_to ("Base url", cms.base_url, e, s)
				append_info_to ("Script url", cms.script_url, e, s)
				s.append ("<hr/>")
				append_info_to ("Dir", cms.site_dir.utf_8_name, e, s)
				append_info_to ("Var dir", cms.site_var_dir.utf_8_name, e, s)
				s.append ("<hr/>")
				append_info_to ("Theme", cms.theme_name, e, s)
				append_info_to ("Theme location", cms.theme_resource_location.utf_8_name, e, s)
				s.append ("<hr/>")
				append_info_to ("Files location", cms.files_location.utf_8_name, e, s)
				s.append ("<hr/>")

				append_info_to ("Url", e.url ("/", Void), e, s)
				if attached e.user as u then
					append_info_to ("User", u.name, e, s)
					append_info_to ("User url", e.user_url (u), e, s)

				end

				e.set_main_content (s)
			else
				create {NOT_FOUND_CMS_EXECUTION} e.make (req, res, cms)
			end
			e.execute
		end

	append_info_to (n: READABLE_STRING_8; v: detachable READABLE_STRING_GENERAL; e: CMS_EXECUTION; t: STRING)
		do
			t.append ("<li>")
			t.append ("<strong>" + n + "</strong>: ")
			if v /= Void then
				t.append (e.html_encoded (v))
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
