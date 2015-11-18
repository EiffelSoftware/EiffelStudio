note
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


	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_VALUE_TABLE_ALTER

	CMS_HOOK_BLOCK

	CMS_HOOK_MENU_SYSTEM_ALTER

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
			version := "1.0"
			description := "Authentication module"
			package := "authentication"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "auth"

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
			a_router.handle ("/account", create {WSF_URI_AGENT_HANDLER}.make (agent handle_account (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-login", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-logout", create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-register", create {WSF_URI_AGENT_HANDLER}.make (agent handle_register (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/activate/{token}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_activation (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/reactivate", create {WSF_URI_AGENT_HANDLER}.make (agent handle_reactivation (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/new-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_new_password (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/reset-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_reset_password (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/change-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_change_password (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/post-change-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_post_change_password (a_api, ?, ?)), a_router.methods_get)
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
			a_response.hooks.subscribe_to_block_hook (Current)
			a_response.hooks.subscribe_to_value_table_alter_hook (Current)
		end

	value_table_alter (a_value: CMS_VALUE_TABLE; a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_value.force (a_response.user, "user")
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached a_response.user as u then
				create lnk.make (u.name, "account" )
				lnk.set_weight (97)
				a_menu_system.primary_menu.extend (lnk)
				create lnk.make ("Logout", "account/roc-logout")
				lnk.set_weight (98)
				a_menu_system.primary_menu.extend (lnk)
			else
				create lnk.make ("Login", "account/roc-login")
				lnk.set_weight (98)
				a_menu_system.primary_menu.extend (lnk)
			end

		end

feature -- Handler

	handle_account (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

			if attached template_block ("account_info", r) as l_tpl_block then
				if attached r.user as l_user then
					r.set_value (api.user_api.user_roles (l_user), "roles")
				end
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [resources_page]")
				end
			end
			r.execute
		end

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if attached api.module_by_name ("basic_auth") then
					-- FIXME: find better solution to support a default login system.
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_redirection (r.absolute_url ("/account/roc-basic-auth", Void))
				r.execute
			else
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

	handle_logout (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_redirection (r.absolute_url ("", Void))
			r.execute
		end

	handle_register (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			u: CMS_USER
			l_exist: BOOLEAN
			es: CMS_AUTHENTICATON_EMAIL_SERVICE
			l_url: STRING
			l_token: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("account register") then
				if req.is_post_request_method then
					if
						attached {WSF_STRING} req.form_parameter ("name") as l_name and then
						attached {WSF_STRING} req.form_parameter ("password") as l_password and then
						attached {WSF_STRING} req.form_parameter ("email") as l_email
					then
						l_user_api := api.user_api

						if attached l_user_api.user_by_name (l_name.value) then
								-- Username already exist.
							r.set_value ("User name already exists!", "error_name")
							l_exist := True
						end
						if attached l_user_api.user_by_email (l_email.value) then
								-- Emails already exist.
							r.set_value ("An account is already associated with that email address!", "error_email")
							l_exist := True
						end

						if not l_exist then
								-- New user
							create u.make (l_name.value)
							u.set_email (l_email.value)
							u.set_password (l_password.value)
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
							r.set_value (l_name.value, "name")
							r.set_value (l_email.value, "email")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						end
					end
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
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
					r.set_main_content ("<p> Your account <i>"+ l_user.name +"</i> has been activated</p>")
				else
					-- the token does not exist, or it was already used.
					r.set_status_code ({HTTP_CONSTANTS}.bad_request)
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
							r.set_value ("The asociated user to the given email " + l_email.value + " , is already active", "is_active")
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
						r.set_value ("The email does not exist or !", "error_email")
						r.set_value (l_email.value, "email")
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
						r.set_value ("The email does not exist !", "error_email")
						r.set_value (l_email.value, "email")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				elseif attached {WSF_STRING} req.form_parameter ("username") as l_username then
					if 	attached {CMS_USER} l_user_api.user_by_name (l_username) as l_user and then
						attached l_user.email as l_email
					then
								-- User exist create a new token and send a new email.
						l_token := new_token
						l_user_api.new_password (l_token, l_user.id)
						l_url := req.absolute_script_url ("/account/reset-password?token=" + l_token)

								-- Send Email
						create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
						write_debug_log (generator + ".handle register: send_contact_password_email")
						es.send_contact_password_email (l_email, l_url)
					else
						r.set_value ("The username does not exist !", "error_username")
						r.set_value (l_username.value, "username")
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
				r.set_value (l_token.value, "token")
				if l_user_api.user_by_password_token (l_token.value) = Void  then
					r.set_value ("The token " + l_token.value + " is not valid, " + r.link ("click here" , "account/new-password", Void) + " to generate a new token.", "error_token")
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
						r.set_value ("Passwords Don't Match", "error_password")
						r.set_value (l_token.value, "token")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				end
			end
			r.execute
		end

	handle_change_password (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			l_user_api := api.user_api

			if req.is_post_request_method then
				if attached r.user as l_user  then
					r.set_value (api.user_api.user_roles (l_user), "roles")
					if
						attached {WSF_STRING} req.form_parameter ("password") as l_password and then
						attached {WSF_STRING} req.form_parameter ("confirm_password") as l_confirm_password and then
						l_password.value.same_string (l_confirm_password.value)
					then
							-- Does the passwords match?	
						l_user.set_password (l_password.value)
						l_user_api.update_user (l_user)
						r.set_redirection (req.absolute_script_url ("/account/post-change-password"))
					else
						if attached template_block ("account_info", r) as l_tpl_block then
--							r.set_value (l_user, "user")
							r.set_value ("Passwords Don't Match", "error_password")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
							r.add_block (l_tpl_block, "content")
						end
					end
				end
			end
			r.execute
		end

	handle_post_change_password (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if attached template_block ("post_change", r) as l_tpl_block then
				r.add_block (l_tpl_block, "content")
			end
			r.execute
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"register", "reactivate", "new_password", "reset_password">>
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

--	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
--		local
----			vals: CMS_VALUE_TABLE
--		do
--			if attached template_block (a_block_id, a_response) as l_tpl_block then
----				create vals.make (1)
----					-- add the variable to the block
----				value_table_alter (vals, a_response)
----				across
----					vals as ic
----				loop
----					l_tpl_block.set_value (ic.item, ic.key)
----				end
--				a_response.put_required_block (l_tpl_block, "content")
--			else
--				debug ("cms")
--					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
--				end
--			end
--		end

	get_block_view_register (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.has_permission ("account register") then
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
	--						l_tpl_block.set_value (a_response.values.item ("error_name"), "error_name")
	--						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
	--						l_tpl_block.set_value (a_response.values.item ("email"), "email")
	--						l_tpl_block.set_value (a_response.values.item ("name"), "name")
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
--						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
--						l_tpl_block.set_value (a_response.values.item ("email"), "email")
--						l_tpl_block.set_value (a_response.values.item ("is_active"), "is_active")
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
				if a_response.values.has ("error_email") or else a_response.values.has ("error_username")   then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
--						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
--						l_tpl_block.set_value (a_response.values.item ("email"), "email")
--						l_tpl_block.set_value (a_response.values.item ("error_username"), "error_username")
--						l_tpl_block.set_value (a_response.values.item ("username"), "username")
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
--					l_tpl_block.set_value (a_response.values.item ("token"), "token")
--					l_tpl_block.set_value (a_response.values.item ("error_token"), "error_token")
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_token") or else a_response.values.has ("error_password")   then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
--						l_tpl_block.set_value (a_response.values.item ("error_token"), "error_token")
--						l_tpl_block.set_value (a_response.values.item ("error_password"), "error_password")
--						l_tpl_block.set_value (a_response.values.item ("token"), "token")
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
