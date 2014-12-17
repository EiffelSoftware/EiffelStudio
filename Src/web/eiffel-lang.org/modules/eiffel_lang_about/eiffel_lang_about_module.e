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
			Result.handle_with_request_methods ("/contact", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contact (a_api, ?, ?)), Result.methods_head_get)
			Result.handle_with_request_methods ("/post_contact", create {WSF_URI_AGENT_HANDLER}.make (agent handle_post_contact (a_api, ?, ?)), Result.methods_put_post)
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
			Result := <<"about_main","purpose","news","articles","blogs","contact","post_contact">>
			create l_string.make_empty
			across Result as ic loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
			log.write_debug (generator + ".block_list:" + l_string )
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do

				--"purpose","news","articles","blogs","contact"
			if a_block_id.is_case_insensitive_equal_general ("about_main") and then a_response.request.path_info.starts_with ("/about") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("purpose") and then a_response.request.path_info.starts_with ("/purpose") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("news") and then a_response.request.path_info.starts_with ("/news") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("articles") and then a_response.request.path_info.starts_with ("/articles") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("blogs") and then a_response.request.path_info.starts_with ("/blogs") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("contact") and then a_response.request.path_info.starts_with ("/contact") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
			elseif a_block_id.is_case_insensitive_equal_general ("post_contact") and then a_response.request.path_info.starts_with ("/post_contact") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						l_tpl_block.set_value (a_response.values.item ("has_error"), "has_error")
						a_response.add_block (l_tpl_block, "content")
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
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("about_main", "about_main")
			r.execute
		end


	handle_purpose (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("purpose", "purpose")
			r.execute
		end

	handle_news (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("news", "news")
			r.execute
		end

	handle_articles (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("articles", "articles")
			r.execute
		end

	handle_blogs (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("blogs", "blogs")
			r.execute
		end

	handle_contact (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("contact", "contact")
			r.execute
		end


	handle_post_contact (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: EMAIL_SERVICE
			m: STRING
			um:STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force (False, "has_error")
			if attached {WSF_STRING} req.form_parameter ("name") as l_name and then
			   attached {WSF_STRING} req.form_parameter ("email") as l_email and then
			   attached {WSF_STRING} req.form_parameter ("message") as l_message and then
			   attached api.setup.smtp as l_smtp then
				create m.make_from_string (contact_message)
				create es.make (l_smtp)
				es.send_contact_email (l_email.value, m)

				create um.make_from_string (user_contact)
				um.replace_substring_all ("$name", l_name.value)
				um.replace_substring_all ("$email", l_email.value)
				um.replace_substring_all ("$message", l_message.value)

				es.send_internal_email (um)
				if attached es.last_error then
					r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
					r.values.force (True, "has_error")
				end
				r.execute
			else
					-- Internal server error
				r.values.force ("post_contact", "post_contact")
				r.values.force (True, "has_error")
				r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
				r.execute
			end

		end



feature {NONE} -- Helpers

	template_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id'
		local
			p: detachable PATH
		do
			create p.make_from_string ("templates")
			p := p.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_response.module_resource_path (Current, p)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
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

feature {NONE} -- HTML ENCODING.

	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Contact Message


	contact_message: STRING = "[
						<p>
							Thank you for contacting the Eiffel Programming Language community.<br/>
							We will get back to you promptly on your contact request.
						</p>
						]"

	user_contact: STRING = "[
	                        <h2> Notification contact form</h2>  
							<div>
								<strong>Name<strong>: $name <br/>
								<strong>Email<strong>: $email <br/>
								<strong>Message<strong>: $message <br/>
							</div> <br/>			
		]"

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
