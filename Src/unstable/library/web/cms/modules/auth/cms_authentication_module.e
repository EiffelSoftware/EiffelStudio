﻿note
	description: "Module Auth"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_MODULE

inherit
	CMS_MODULE

		redefine
			register_hooks
		end


	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_VALUE_TABLE_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	SHARED_LOGGER

	CMS_REQUEST_UTIL


create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "login"
			version := "1.0"
			description := "Authentication module"
			package := "authentication"

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

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			configure_web (a_api, a_router)
		end

	configure_web (a_api: CMS_API; a_router: WSF_ROUTER)
		do
			a_router.handle ("/account/roc-login", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-basic-auth", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login_basic_auth (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-register", create {WSF_URI_AGENT_HANDLER}.make (agent handle_register (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/activate/{token}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_activation (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/reactivate", create {WSF_URI_AGENT_HANDLER}.make (agent handle_reactivation (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/new-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_new_password (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/reset-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_reset_password (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/roc-logout", create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, ?, ?)), a_router.methods_get_post)
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
			a_response.subscribe_to_block_hook (Current)
			a_response.subscribe_to_value_table_alter_hook (Current)
		end

feature -- Hooks

	value_table_alter (a_value: CMS_VALUE_TABLE; a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			if attached current_user (a_response.request) as l_user then
				a_value.force (l_user, "user")
			end
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached a_response.current_user (a_response.request) as u then
				create lnk.make (u.name +  " (Logout)", "account/roc-logout" )
			else
				create lnk.make ("Login", "account/roc-login")
			end
			a_menu_system.primary_menu.extend (lnk)
			lnk.set_weight (98)
			if a_response.location.starts_with ("account/roc-login") then
				create lnk.make ("Basic Auth", "account/roc-basic-auth")
				lnk.set_expandable (True)
				a_response.add_to_primary_tabs (lnk)
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"login", "register", "reactivate", "new_password", "reset_password">>
			debug ("roc")
				create l_string.make_empty
				across
					Result as ic
				loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
				write_debug_log (generator + ".block_list:" + l_string )
			end
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if
				a_block_id.is_case_insensitive_equal_general ("login") and then
				a_response.location.starts_with ("account/roc-basic-auth")
			then
				get_block_view_login (a_block_id, a_response)
			elseif
				a_block_id.is_case_insensitive_equal_general ("register") and then
				a_response.location.starts_with ("account/roc-register")
			then
				get_block_view_register (a_block_id, a_response)
			elseif
				a_block_id.is_case_insensitive_equal_general ("reactivate") and then
				a_response.location.starts_with ("account/reactivate")
			then
				get_block_view_reactivate (a_block_id, a_response)
			elseif
				a_block_id.is_case_insensitive_equal_general ("new_password") and then
				a_response.location.starts_with ("account/new-password")
			then
				get_block_view_new_password (a_block_id, a_response)
			elseif
				a_block_id.is_case_insensitive_equal_general ("reset_password") and then
				a_response.location.starts_with ("account/reset-password")
			then
				get_block_view_reset_password (a_block_id, a_response)
			end
		end

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			link: CMS_LINK
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("Login", "optional_content_type")
			r.execute
		end

	handle_login_basic_auth (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			link: CMS_LINK
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("Basic Auth", "optional_content_type")
			r.execute
		end

	handle_logout (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_url: STRING
			l_cookie: WSF_COOKIE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_status_code ({HTTP_CONSTANTS}.found)
			l_url := req.absolute_script_url ("/basic_auth_logoff")
			r.set_redirection (l_url)
			r.execute
		end

	handle_register (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			u: CMS_USER
			l_roles: LIST [CMS_USER_ROLE]
			l_exist: BOOLEAN
			es: CMS_AUTHENTICATON_EMAIL_SERVICE
			l_url: STRING
			l_token: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("Register", "optional_content_type")
			if req.is_post_request_method then
				if
					attached {WSF_STRING} req.form_parameter ("name") as l_name and then
					attached {WSF_STRING} req.form_parameter ("password") as l_password and then
					attached {WSF_STRING} req.form_parameter ("email") as l_email
				then
					l_user_api := api.user_api

					if attached l_user_api.user_by_name (l_name.value) then
							-- Username already exist.
						r.values.force ("The user name exist!", "error_name")
						l_exist := True
					end
					if attached l_user_api.user_by_email (l_email.value) then
							-- Emails already exist.
						r.values.force ("The email exist!", "error_email")
						l_exist := True
					end

					if not l_exist then
							-- New user
						create {ARRAYED_LIST [CMS_USER_ROLE]}l_roles.make (1)
						l_roles.force (l_user_api.authenticated_user_role)

						create u.make (l_name.value)
						u.set_email (l_email.value)
						u.set_password (l_password.value)
						u.set_roles (l_roles)
						l_user_api.new_user (u)

							-- Create activation token
						l_token := new_token
						l_user_api.new_activation (l_token, u.id)
						l_url := req.absolute_script_url ("/account/activate/" + l_token)

							-- Send Email
						create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
						write_debug_log (generator + ".handle register: send_contact_email")
						es.send_contact_email (l_email.value, l_url)

					else
						r.values.force (l_name.value, "name")
						r.values.force (l_email.value, "email")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				end
			end

			r.execute
		end

	handle_activation (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			l_ir: INTERNAL_SERVER_ERROR_CMS_RESPONSE
		do
			l_user_api := api.user_api
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if attached {WSF_STRING} req.path_parameter ("token") as l_token then

				if attached {CMS_USER} l_user_api.user_by_activation_token (l_token.value) as l_user then
					-- Valid user_id
					l_user.mark_active
					l_user_api.update_user (l_user)
					l_user_api.remove_activation (l_token.value)
					r.set_value ("Account activated", "optional_content_type")
					r.set_main_content ("<p> Your account <i>"+ l_user.name +"</i> has been activated</p>")
				else
					-- the token does not exist, or it was already used.
					r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					r.set_value ("Account not activated", "optional_content_type")
					r.set_main_content ("<p>The token <i>" + l_token.value +"</i> is not valid " + r.link ("Reactivate Account", "account/reactivate", Void) + "</p>")
				end
				r.execute
			else
				create l_ir.make (req, res, api)
				l_ir.execute
			end
		end


	handle_reactivation (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATON_EMAIL_SERVICE
			l_user_api: CMS_USER_API
			l_token: STRING
			l_url: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_post_request_method then
				if
					attached {WSF_STRING} req.form_parameter ("email") as l_email
				then
					l_user_api := api.user_api
					if 	attached {CMS_USER} l_user_api.user_by_email (l_email.value) as l_user then
							-- User exist create a new token and send a new email.
						if l_user.is_active then
							r.values.force ("The asociated user to the given email " + l_email.value + " , is already active", "is_active")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						else
							l_token := new_token
							l_user_api.new_activation (l_token, l_user.id)
							l_url := req.absolute_script_url ("/account/activate/" + l_token)

								-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle register: send_contact_activation_email")
							es.send_contact_activation_email (l_email.value, l_url)
						end
					else
						r.values.force ("The email does not exist or !", "error_email")
						r.values.force (l_email.value, "email")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				end
			end

			r.execute
		end

	handle_new_password (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATON_EMAIL_SERVICE
			l_user_api: CMS_USER_API
			l_token: STRING
			l_url: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_post_request_method then
				l_user_api := api.user_api
				if attached {WSF_STRING} req.form_parameter ("email") as l_email then
					if 	attached {CMS_USER} l_user_api.user_by_email (l_email.value) as l_user then
								-- User exist create a new token and send a new email.
						l_token := new_token
						l_user_api.new_password (l_token, l_user.id)
						l_url := req.absolute_script_url ("/account/reset-password?token=" + l_token)

								-- Send Email
						create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
						write_debug_log (generator + ".handle register: send_contact_password_email")
						es.send_contact_password_email (l_email.value, l_url)
					else
						r.values.force ("The email does not exist !", "error_email")
						r.values.force (l_email.value, "email")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				end
			end
			r.execute
		end


	handle_reset_password (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			l_user_api := api.user_api
			if	attached {WSF_STRING} req.query_parameter ("token") as l_token then
				r.values.force (l_token.value, "token")
				if l_user_api.user_by_password_token (l_token.value) = Void  then
					r.values.force ("The token " + l_token.value + " is not valid, " + r.link ("click here" , "account/new-password", Void) + " to generate a new token.", "error_token")
					r.set_status_code ({HTTP_CONSTANTS}.bad_request)
				end
			end

			if req.is_post_request_method then

				if
					attached {WSF_STRING} req.form_parameter ("token") as l_token and then
					attached {WSF_STRING} req.form_parameter ("password") as l_password and then
					attached {WSF_STRING} req.form_parameter ("confirm_password") as l_confirm_password
				then
						-- Does the passwords match?	
					if l_password.value.same_string (l_confirm_password.value) then
							-- is the token valid?	
						if attached {CMS_USER} l_user_api.user_by_password_token (l_token.value) as l_user then
							l_user.set_password (l_password.value)
							l_user_api.update_user (l_user)
							l_user_api.remove_password (l_token.value)
						end
					else
						r.values.force ("Passwords Don't Match", "error_password")
						r.values.force (l_token.value, "token")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				end
			end
			r.execute
		end

feature {NONE} -- Helpers

	template_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id'
		local
			p: detachable PATH
		do
			create p.make_from_string ("templates")
			p := p.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")

			p := a_response.api.module_theme_resource_location (Current, p)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
		end

feature {NONE} -- Block views

	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			vals: CMS_VALUE_TABLE
		do
			if attached template_block (a_block_id, a_response) as l_tpl_block then
				create vals.make (1)
					-- add the variable to the block
				value_table_alter (vals, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end
				a_response.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				end
			end
		end

	get_block_view_register (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.request.is_get_request_method then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_name") or else a_response.values.has ("error_email") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						l_tpl_block.set_value (a_response.values.item ("error_name"), "error_name")
						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
						l_tpl_block.set_value (a_response.values.item ("email"), "email")
						l_tpl_block.set_value (a_response.values.item ("name"), "name")
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				else
					if attached template_block ("post_register", a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end


	get_block_view_reactivate (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.request.is_get_request_method then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_email") or else a_response.values.has ("is_active") then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
						l_tpl_block.set_value (a_response.values.item ("email"), "email")
						l_tpl_block.set_value (a_response.values.item ("is_active"), "is_active")
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				else
					if attached template_block ("post_reactivate", a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end

	get_block_view_new_password (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.request.is_get_request_method then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_email")  then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
						l_tpl_block.set_value (a_response.values.item ("email"), "email")
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				else
					if attached template_block ("post_password", a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end

	get_block_view_reset_password (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.request.is_get_request_method then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					l_tpl_block.set_value (a_response.values.item ("token"), "token")
					l_tpl_block.set_value (a_response.values.item ("error_token"), "error_token")
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_token") or else a_response.values.has ("error_password")   then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						l_tpl_block.set_value (a_response.values.item ("error_token"), "error_token")
						l_tpl_block.set_value (a_response.values.item ("error_password"), "error_password")
						l_tpl_block.set_value (a_response.values.item ("token"), "token")
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				else
					if attached template_block ("post_reset", a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end


feature {NONE} -- Token Generation

	new_token: STRING
			-- Generate a new token activation token
		local
			l_token: STRING
			l_security: SECURITY_PROVIDER
			l_encode: URL_ENCODER
		do
			create l_security
			l_token := l_security.token
			create l_encode
			from until l_token.same_string (l_encode.encoded_string (l_token)) loop
				-- Loop ensure that we have a security token that does not contain characters that need encoding.
			    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
				-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end
			Result := l_token
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
