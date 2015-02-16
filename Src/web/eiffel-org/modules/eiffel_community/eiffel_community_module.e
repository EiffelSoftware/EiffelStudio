note
	description: "Summary description for {EIFFEL_COMMUNITY_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_MODULE

inherit
	CMS_MODULE
		redefine
			register_hooks
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
			name := "eiffel_community"
			version := "1.0"
			description := "Eiffel Community module"
			package := "misc"

			create root_dir.make_current
			cache_duration := 0
		end

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

	router (a_api: CMS_API): WSF_ROUTER
			-- Router configuration.
		do
			create Result.make (7)
			Result.handle_with_request_methods ("/about", create {WSF_URI_AGENT_HANDLER}.make (agent handle_about (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/purpose", create {WSF_URI_AGENT_HANDLER}.make (agent handle_purpose (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/news", create {WSF_URI_AGENT_HANDLER}.make (agent handle_news (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/articles", create {WSF_URI_AGENT_HANDLER}.make (agent handle_articles (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/blogs", create {WSF_URI_AGENT_HANDLER}.make (agent handle_blogs (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/privacy_policy", create {WSF_URI_AGENT_HANDLER}.make (agent handle_privacy_policy (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/terms_of_use", create {WSF_URI_AGENT_HANDLER}.make (agent handle_terms_of_use (a_api, ?, ?)), Result.methods_head_get)

			Result.handle_with_request_methods ("/contribute", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contribute (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/contribute_description", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contribute_description (a_api, ?, ?)), Result.methods_head_get)
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
			a_response.subscribe_to_block_hook (Current)
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
			Result := <<"front_header_welcome", "social_area", "eiffel_copyright", "about_main", "purpose", "news", "articles", "blogs", "social_buttons", "updates", "popular_nodes", "libraries", "privacy_policy", "terms_of_use", "main">>
			create l_string.make_empty
			across Result as ic loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
			log.write_debug (generator + ".block_list:" + l_string )
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			l_path_info: READABLE_STRING_8
		do
			fixme ("Feature too long!!!")
			l_path_info := a_response.request.percent_encoded_path_info

				--"purpose","news","articles","blogs"
			if a_block_id.is_case_insensitive_equal_general ("front_header_welcome") and then l_path_info.same_string_general ("/") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "header")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("about_main") and then l_path_info.starts_with ("/about") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("purpose") and then l_path_info.starts_with ("/purpose") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("news") and then l_path_info.starts_with ("/news") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("articles") and then l_path_info.starts_with ("/articles") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("blogs") and then l_path_info.starts_with ("/blogs") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			end

			if a_block_id.is_case_insensitive_equal_general ("social_buttons") then
				if
					attached {READABLE_STRING_GENERAL} a_response.values.item ("optional_content_type") as l_type and then
					l_type.same_string ("doc")
				then
					if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
						log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("popular_nodes") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "sidebar_second")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("social_area") and then  a_response.request.path_info.same_string_general ("/") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					-- TODO: double check: Social Header is only included in the home page.
					a_response.add_block (l_tpl_block, "header")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("eiffel_copyright") then
				if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
					l_tpl_block.set_is_raw (True)
					a_response.add_block (l_tpl_block, "footer")
					log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				end
			elseif a_block_id.is_case_insensitive_equal_general ("updates") then
				if a_response.is_front then
					if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
						log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("libraries") then
				if a_response.is_front then
					if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
						log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("privacy_policy") and then  a_response.request.path_info.same_string_general ("/privacy_policy") then
						if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
							a_response.add_block (l_tpl_block, "content")
							log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
						else
							debug ("cms")
								a_response.add_warning_message ("Error with block [" + a_block_id + "]")
							end
						end
			elseif a_block_id.is_case_insensitive_equal_general ("terms_of_use") and then  a_response.request.path_info.same_string_general ("/terms_of_use") then
					if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
							a_response.add_block (l_tpl_block, "content")
							log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("main") and then  a_response.request.path_info.same_string_general ("/") then
					if attached template_block (Current, a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
						log.write_debug (generator + ".get_block_view with template_block:" + l_tpl_block.out)
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			end

		end

feature -- Request handling: About	

	handle_about (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_about")
			if req.is_get_request_method then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end

			r.values.force ("about_main", "about_main")
			r.execute
		end

	handle_purpose (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_purpose")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("purpose", "purpose")
			r.execute
		end

	handle_news (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_about")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("news", "news")
			r.execute
		end

	handle_articles (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_articles")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("articles", "articles")
			r.execute
		end

	handle_blogs (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_blogs")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("blogs", "blogs")
			r.execute
		end

	handle_privacy_policy (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_privacy_policy")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("privacy_policy", "privacy_policy")
			r.execute
		end

	handle_terms_of_use (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_terms_of_use")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("terms_of_use", "terms_of_use")
			r.execute
		end

	handle_main (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			log.write_debug (generator + ".handle_main")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("main", "main")
			r.execute
		end


feature -- Request handling: Contribute

	handle_contribute (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			fixme ("Use CMS node and associated content for Contribute link!")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("contribute", "optional_content_type")
--			r.set_title ("Contribute")
			r.set_main_content ("")
			if attached template_block (Current, "contribute_page", r) as l_tpl_block then
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [contribute_page]")
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
--			r.set_title ("Contribute")
			r.set_main_content ("")
			if attached template_block (Current, "contribute_description", r) as l_tpl_block then
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

feature {NONE} -- Implementation		

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
