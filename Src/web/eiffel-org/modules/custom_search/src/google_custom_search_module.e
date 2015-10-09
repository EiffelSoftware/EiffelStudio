note
	description: "[
			Module that provide Google Custom Search functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GOOGLE_CUSTOM_SEARCH_MODULE

inherit

	CMS_MODULE
		redefine
			register_hooks
		end

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
			version := "1.0"
			description := "Google custome search module"
			package := "search"
		end

feature -- Access

	name: STRING = "custom_search"
			-- <Precursor>

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
			a_router.handle ("/gcse", create {WSF_URI_AGENT_HANDLER}.make (agent handle_search (a_api, ?, ?)), a_router.methods_head_get)
		end

feature -- Recaptcha

	gcse_secret_key (api: CMS_API): detachable READABLE_STRING_8
			-- Get recaptcha security key.
		local
			utf: UTF_CONVERTER
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if
					attached cfg.text_item ("gcse.secret_key") as l_recaptcha_key and then
					not l_recaptcha_key.is_empty
				then
					Result := utf.utf_32_string_to_utf_8_string_8 (l_recaptcha_key)
				end
			end
		end

	gcse_cx_key (api: CMS_API): detachable READABLE_STRING_8
			-- Get recaptcha security key.
		local
			utf: UTF_CONVERTER
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if
					attached cfg.text_item ("gcse.cx") as l_recaptcha_key and then
					not l_recaptcha_key.is_empty
				then
					Result := utf.utf_32_string_to_utf_8_string_8 (l_recaptcha_key)
				end
			end
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"search">>
		end

feature -- Handler

	handle_search (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_parameters:GCSE_QUERY_PARAMETERS
			l_search: GCSE_API
		do
				-- TODO handle errors!!!
			write_debug_log (generator + ".handle_search")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if attached {WSF_STRING} req.query_parameter ("q") as l_query then
				if
					attached gcse_cx_key (api) as l_cx and then
					attached gcse_secret_key (api) as l_key
				then
					create l_parameters.make (l_key, l_cx, l_query.value )
					if
						attached {WSF_STRING} req.query_parameter ("start") as l_index and then
					  	attached {WSF_STRING} req.query_parameter ("num") as l_num
					then
						l_parameters.set_start (l_index.value)
						l_parameters.set_num (l_num.value)
					end
					create l_search.make (l_parameters)
					l_search.search
					if attached template_block (Current, "search", r) as l_tpl_block then
						l_tpl_block.set_value (l_search.last_result, "result")
						r.add_block (l_tpl_block, "content")
					end
				else
						-- If no key are provided, at least output google search result page.
					if req.is_https then
						r.set_redirection ("https://www.google.com/search?sitesearch=" + r.absolute_url ("", Void) + "&q=" + l_query.url_encoded_value)
					else
						r.set_redirection ("http://www.google.com/search?sitesearch=" + r.absolute_url ("", Void) + "&q=" + l_query.url_encoded_value)
					end
				end
			end
			r.execute
		end

end
