note
	description: "Summary description for {EIFFEL_LANG_ABOUT_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_ABOUT_MODULE

inherit

	CMS_MODULE
		redefine
			register_hooks
		end

	SHARED_HTML_ENCODER

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "eiffel_lang_about"
			version := "1.0"
			description := "Eiffel Lang About module"
			package := "about"
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
			create Result.make (0)
			Result.handle_with_request_methods ("/about", create {WSF_URI_AGENT_HANDLER}.make (agent handle_about (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/purpose", create {WSF_URI_AGENT_HANDLER}.make (agent handle_purpose (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/news", create {WSF_URI_AGENT_HANDLER}.make (agent handle_news (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/articles", create {WSF_URI_AGENT_HANDLER}.make (agent handle_articles (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/blogs", create {WSF_URI_AGENT_HANDLER}.make (agent handle_blogs (a_api, ?, ?)), Result.methods_head_get)
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
				fixme ("add /about and /contribute to primary menu")
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"about_main", "purpose", "news", "articles", "blogs">>
			create l_string.make_empty
			across
				Result as ic
			loop
				l_string.append (ic.item)
				l_string.append_character (' ')
			end
			log.write_debug (generator + ".block_list:" + l_string)
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			l_path_info: READABLE_STRING_8
		do
			l_path_info := a_response.request.percent_encoded_path_info

				--"purpose","news","articles","blogs"
			if a_block_id.is_case_insensitive_equal_general ("about_main") and then l_path_info.starts_with ("/about") then
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
		end

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

feature {NONE} -- HTML ENCODING.

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
