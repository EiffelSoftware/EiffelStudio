note
	description: "[
			Administrate cache functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_CACHE_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
		do
			if api.has_permission ("admin cache") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := clear_cache_web_form (l_response)
				create s.make_empty
				f.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
				l_response.execute
			else
				send_custom_access_denied (Void, <<"admin cache">>, req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
		do
			if api.has_permission ("admin cache") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := clear_cache_web_form (l_response)
				f.process (l_response)
				if
					attached f.last_data as fd and then
					fd.is_valid
				then
					if attached fd.string_item ("op") as l_op and then l_op.same_string (text_clear_all_caches) then
						api.hooks.invoke_clear_cache (Void, l_response)
						l_response.add_notice_message ("Caches cleared (if allowed)!")
					else
						fd.report_error ("Invalid form data!")
					end
				end
				create s.make_empty
				f.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
				l_response.execute
			else
				send_custom_access_denied (Void, <<"admin cache">>, req, res)
			end
		end

feature -- Widget

	clear_cache_web_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			but: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (a_response.request_url (Void), "form_clear_cache")
			create but.make_with_text ("op", text_clear_all_caches)
			Result.extend (but)
		end

feature -- Interface text.		

	text_clear_all_caches: STRING_32 = "Clear all caches"

end
