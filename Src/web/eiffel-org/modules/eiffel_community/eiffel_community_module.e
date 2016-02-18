note
	description: "Summary description for {EIFFEL_COMMUNITY_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_MODULE

inherit
	CMS_MODULE
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Eiffel Community module"
			package := "misc"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "eiffel_community"

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
			a_router.handle ("/welcome", create {WSF_URI_AGENT_HANDLER}.make (agent handle_welcome (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/purpose", create {WSF_URI_AGENT_HANDLER}.make (agent handle_purpose (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/news", create {WSF_URI_AGENT_HANDLER}.make (agent handle_news (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/updates", create {WSF_URI_AGENT_HANDLER}.make (agent handle_updates (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/privacy_policy", create {WSF_URI_AGENT_HANDLER}.make (agent handle_privacy_policy (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/terms_of_use", create {WSF_URI_AGENT_HANDLER}.make (agent handle_terms_of_use (a_api, ?, ?)), a_router.methods_head_get)

			a_router.handle ("/contribute_description", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contribute_description (a_api, ?, ?)), a_router.methods_head_get)

			a_router.handle ("/resources", create {WSF_URI_AGENT_HANDLER}.make (agent handle_resources (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/resources/videos", create {WSF_URI_AGENT_HANDLER}.make (agent handle_resources_video (a_api, ?, ?)), a_router.methods_head_get)

			a_router.handle ("/admin/module/" + name + "/hack/", create {EIFFEL_COMMUNITY_ADMIN_HACK_HANDLER}.make (a_api), a_router.methods_get_post)
		end

feature -- Access			

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		do
			Result := Precursor
			Result.force ("manage " + name)
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
				fixme ("add /about ... and /contribute to primary menu")
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<
						"front_header_welcome", "social_area", "eiffel_copyright", "welcome_main",
						"purpose", "news", "social_buttons", "updates", "sidebar_updates", "popular_nodes",
						"libraries", "privacy_policy", "terms_of_use", "main"
					>>
			create l_string.make_empty
			across Result as ic loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
			write_debug_log (generator + ".block_list:" + l_string )
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			loc: READABLE_STRING_8
		do
			fixme ("Feature too long!!!")
			loc := a_response.location

				--"purpose","news","articles","blogs"
			if a_block_id.is_case_insensitive_equal_general ("front_header_welcome") and then loc.is_empty then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "header")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("welcome_main") and then loc.starts_with ("welcome") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("purpose") and then loc.starts_with ("purpose") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("news") and then loc.starts_with ("news") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("updates") and then loc.starts_with ("updates") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("social_buttons") then
				if
					attached {READABLE_STRING_GENERAL} a_response.values.item ("optional_content_type") as l_type and then
					l_type.same_string ("doc")
				then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
						write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("popular_nodes") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "sidebar_second")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("social_area") and then  loc.is_empty then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					-- TODO: double check: Social Header is only included in the home page.
					a_response.add_block (l_tpl_block, "header")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("eiffel_copyright") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					l_tpl_block.set_is_raw (True)
					a_response.add_block (l_tpl_block, "footer")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				end
			elseif a_block_id.is_case_insensitive_equal_general ("sidebar_updates") then
				if a_response.is_front then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
						write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("libraries") then
				if a_response.is_front then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
						write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("privacy_policy") and then loc.same_string_general ("privacy_policy") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("terms_of_use") and then loc.same_string_general ("terms_of_use") then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
						write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("main") and then loc.is_empty then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			end
		end

feature -- Request handling: About	

	handle_welcome (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_welcome")
			if req.is_get_request_method then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end

			r.values.force ("welcome_main", "welcome_main")
			r.execute
		end

	handle_purpose (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_purpose")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("purpose", "purpose")
			r.execute
		end

	handle_news (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_news")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("news", "news")
			r.execute
		end

	handle_updates (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_updates")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("updates", "updates")
			r.execute
		end

	handle_privacy_policy (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_privacy_policy")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("privacy_policy", "privacy_policy")
			r.execute
		end

	handle_terms_of_use (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_terms_of_use")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("terms_of_use", "terms_of_use")
			r.execute
		end

	handle_main (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_main")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("main", "main")
			r.execute
		end


feature -- Request handling: Contribute

	handle_resources (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			fixme ("Use CMS node and associated content for Resources link!")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("resources", "optional_content_type")
			r.set_main_content ("")
			if attached smarty_template_block (Current, "resources_page", api) as l_tpl_block then
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [resources_page]")
				end
			end
			r.execute
		end

	handle_resources_video (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_videos: LIST[STRING]
			l_filter: VIDEO_CONTENT_FILTER
			s: STRING_8
		do

			fixme ("Use CMS node and associated content for Resources link!")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("videos", "optional_content_type")

			create {ARRAYED_LIST[STRING_8]} l_videos.make (3)
	 		if attached {CMS_NODE_API} api.module_api_by_name ("node") as l_node_api then
                create l_filter
				across l_node_api.nodes as ic loop
					create s.make_empty
					if
						attached ic.item.format as l_format and then l_format.same_string ("video_html") and then
						attached ic.item.content as l_content
					then
						l_filter.filter (l_content)
						s.append (l_content)
						l_videos.force (s)
					end
				end
			end

			if attached smarty_template_block (Current, "videos_page", api) as l_tpl_block then
				l_tpl_block.set_value (l_videos, "videos")
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [resources_page]")
				end
			end
			r.execute
		end

	handle_contribute_description (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			fixme ("Use CMS node and associated content for Contribute link!")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("contribute", "optional_content_type")
			r.set_main_content ("")
			if attached smarty_template_block (Current, "contribute_description", api) as l_tpl_block then
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [contribute_page]")
				end
			end
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
