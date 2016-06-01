note
	description: "[
			Module providing Google Custom Search functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GOOGLE_CUSTOM_SEARCH_MODULE

inherit

	CMS_MODULE

	CMS_HOOK_BLOCK_HELPER

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

	name: STRING = "google_search"
			-- <Precursor>

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		local
			m: WSF_URI_MAPPING
		do
			create m.make_trailing_slash_ignored ("/gcse", create {WSF_URI_AGENT_HANDLER}.make (agent handle_search (a_api, ?, ?)))
			a_router.map (m, a_router.methods_head_get)
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
			if
				attached {WSF_STRING} req.query_parameter ("q") as l_query and then
				not l_query.value.is_empty
			then
				if
					attached gcse_cx_key (api) as l_cx and then
					attached gcse_secret_key (api) as l_key
				then
					create l_parameters.make (l_key, l_cx, l_query.url_encoded_value )
					if
						attached {WSF_STRING} req.query_parameter ("start") as l_index and then
					  	attached {WSF_STRING} req.query_parameter ("num") as l_num
					then
						l_parameters.set_start (l_index.value)
						l_parameters.set_num (l_num.value)
					end
					create l_search.make (l_parameters)
					l_search.search
					if
						attached l_search.last_result as l_result and then
					    l_result.status = 200
					then
						if attached smarty_template_block (Current, "search", api) as l_tpl_block then
							l_tpl_block.set_value (l_result, "result")
							r.add_block (l_tpl_block, "content")
						end
					else
							-- Quota limit (403 status code) or not results.
						google_search_site (req, r,  l_query)
					end
				else
						-- If no key are provided, at least output google search result page.
					google_search_site (req, r,  l_query)
				end
			else
				r.add_message ("No query submitted", Void)
			end
			r.execute
		end

feature {NONE} -- Helper

	google_search_site (req: WSF_REQUEST; res: CMS_RESPONSE; query: WSF_STRING)
			-- Workaround to output google search result page
			-- If no key are provided or if GCSE reached the quota limit.
		local
			l_url_encoder: URL_ENCODER
		do
			create l_url_encoder
			if req.is_https then
				res.set_redirection ("https://www.google.com/search?sitesearch=" + l_url_encoder.general_encoded_string (res.absolute_url ("", Void)) + "&q=" + query.url_encoded_value)
			else
				res.set_redirection ("http://www.google.com/search?sitesearch=" + l_url_encoder.general_encoded_string (res.absolute_url ("", Void)) + "&q=" + query.url_encoded_value)
			end
		end
end
