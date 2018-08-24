note
	description: "Summary description for {CODEBOARD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CODEBOARD_MODULE

inherit
	CMS_MODULE
		rename
			module_api as codeboard_api
		redefine
			initialize,
			setup_hooks,
			codeboard_api
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CMS_WITH_WEBAPI

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Codeboard module"
			package := "codeboard"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "codeboard"

feature {CMS_API} -- Initialization

	initialize (api: CMS_API)
			-- <Precursor>
		do
			create codeboard_api.make (api)
			Precursor (api)
		end

feature	-- Access

	codeboard_api: detachable CODEBOARD_API

feature -- Access: docs

	root_dir: PATH

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
			a_router.handle ("/" + codeboard_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_codeboard (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/" + codeboard_demo_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_codeboard_demo (a_api, ?, ?)), a_router.methods_head_get)

		end

	codeboard_location: STRING = "codeboard"

	codeboard_demo_location: STRING = "codeboard/demo"


feature -- Webapi

	webapi: CODEBOARD_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			debug ("refactor_fixme")
				fixme ("add about and contribute to primary menu")
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"launch_codeboard", "play_eiffel", "?codeboard_static_demo">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("launch_codeboard") then
				if a_response.location.same_string_general (codeboard_location) then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("codeboard_static_demo") then
				if
					a_response.is_front
					or else a_response.location.same_string_general (codeboard_demo_location)
				then
					if attached new_codeboard_static_demo_block as l_tpl_block then
						a_response.add_block (l_tpl_block, "header")
						a_response.add_style (a_response.module_resource_url (Current, "/files/css/codeboard_static_demo.css", Void), Void)
						a_response.add_javascript_url (a_response.module_resource_url (Current, "/files/codeboard_static_demo.js", Void))
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			else
						-- Support any block based on existing template
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					a_response.add_style (a_response.module_resource_url (Current, "/files/css/"+ a_block_id +".css", Void), Void)
				end
			end
		end

	new_codeboard_static_demo_block: detachable CMS_BLOCK
		local
			lst: ARRAYED_LIST [CODEBOARD_SNIPPET]
			i,nb: INTEGER
			tb: STRING_TABLE [ANY]
		do
			if attached codeboard_api as l_api then
				from
					i := 1
					nb := l_api.code_count
					create lst.make (nb)
				until
					i > nb
				loop
					if attached l_api.code (i) as l_code then
						l_code.set_id (i.out)
						lst.force (l_code)
					end
					i := i + 1
				end
				create tb.make_caseless (1)
				tb.force (lst, "snippets")
				Result := smarty_template_block_with_values (Current, "codeboard_static_demo", l_api.cms_api, tb)
			end
		end

feature -- Handling		

	handle_codeboard (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("Codeboard", "optional_content_type")
			r.set_title ("Codeboard")
			r.execute
		end

	handle_codeboard_demo (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("codeboard_demo", "optional_content_type")
			r.set_title ("Codeboard demo")
			r.execute
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
