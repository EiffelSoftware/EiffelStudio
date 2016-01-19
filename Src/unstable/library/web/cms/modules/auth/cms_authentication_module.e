note
	description: "Module Auth"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_MODULE

inherit

	CMS_MODULE
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

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

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("account register")
			Result.force ("account activate")
			Result.force ("account reject")
			Result.force ("account reactivate")
			Result.force ("admin registration")
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
			configure_web_admin (a_api, a_router)
		end

	configure_web (a_api: CMS_API; a_router: WSF_ROUTER)
		local
			m: WSF_URI_MAPPING
		do
			create m.make_trailing_slash_ignored ("/account", create {WSF_URI_AGENT_HANDLER}.make (agent handle_account(a_api, ?, ?)))
			a_router.map (m, a_router.methods_head_get)
			
			a_router.handle ("/account/roc-login", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login(a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-logout", create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout(a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-register", create {WSF_URI_AGENT_HANDLER}.make (agent handle_register(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/activate/{token}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_activation(a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/reject/{token}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_reject(a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/reactivate", create {WSF_URI_AGENT_HANDLER}.make (agent handle_reactivation(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/new-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_new_password(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/reset-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_reset_password(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/change-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_change_password(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/post-change-password", create {WSF_URI_AGENT_HANDLER}.make (agent handle_post_change_password(a_api, ?, ?)), a_router.methods_get)
		end


	configure_web_admin (a_api: CMS_API; a_router: WSF_ROUTER)
			-- Configure router mapping for admin web interface.
		do
			a_router.handle ("/admin/pending-registrations/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_pending_registrations (?, ?, a_api)), a_router.methods_get)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
			a_hooks.subscribe_to_value_table_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
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
				create lnk.make (u.name, "account")
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
				 -- Add the link to the taxonomy to the main menu
			if a_response.has_permission ("admin registration") then
				create lnk.make ("Registration", "admin/pending-registrations/")
				a_menu_system.management_menu.extend (lnk)
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
			u: CMS_TEMP_USER
			l_exist: BOOLEAN
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_url_activate: STRING
			l_url_reject: STRING
			l_token: STRING
			l_captcha_passed: BOOLEAN
			l_email: READABLE_STRING_8
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("account register") then
				if req.is_post_request_method then
					if
						attached {WSF_STRING} req.form_parameter ("name") as l_name and then
						attached {WSF_STRING} req.form_parameter ("password") as l_password and then
						attached {WSF_STRING} req.form_parameter ("email") as p_email and then
						attached {WSF_STRING} req.form_parameter ("personal_information") as l_personal_information
					then
						if p_email.value.is_valid_as_string_8 then
							l_email := p_email.value.to_string_8
							l_user_api := api.user_api
							if attached l_user_api.user_by_name (l_name.value) or else attached l_user_api.temp_user_by_name (l_name.value) then
									-- Username already exist.
								r.set_value ("User name already exists!", "error_name")
								l_exist := True
							end
							if attached l_user_api.user_by_email (l_email) or else attached l_user_api.temp_user_by_email (l_email) then
									-- Emails already exist.
								r.set_value ("An account is already associated with that email address!", "error_email")
								l_exist := True
							end
							if attached recaptcha_secret_key (api) as l_recaptcha_key then
								if attached {WSF_STRING} req.form_parameter ("g-recaptcha-response") as l_recaptcha_response and then is_captcha_verified (l_recaptcha_key, l_recaptcha_response.value) then
									l_captcha_passed := True
								else
										--| Bad or missing captcha
									l_captcha_passed := False
								end
							else
									--| reCaptcha is not setup, so no verification
								l_captcha_passed := True
							end
							if not l_exist then
									-- New temp user
								create u.make (l_name.value)
								u.set_email (l_email)
								u.set_password (l_password.value)
								u.set_personal_information (l_personal_information.value)
								l_user_api.new_temp_user (u)

									-- Create activation token
								l_token := new_token
								l_user_api.new_activation (l_token, u.id)
								l_url_activate := req.absolute_script_url ("/account/activate/" + l_token)
								l_url_reject := req.absolute_script_url ("/account/reject/" + l_token)

									-- Send Email to webmaster
								create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
								write_debug_log (generator + ".handle register: send_register_email")
								es.send_account_evaluation (u, l_personal_information.value, l_url_activate, l_url_reject, req.absolute_script_url (""))

									-- Send Email to user
								create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
								write_debug_log (generator + ".handle register: send_contact_email")
								es.send_contact_email (l_email, u, req.absolute_script_url (""))
							else
								r.set_value (l_name.value, "name")
								r.set_value (l_email, "email")
								r.set_value (l_personal_information.value, "personal_information")
								r.set_status_code ({HTTP_CONSTANTS}.bad_request)
							end
						else
							r.set_value (l_name.value, "name")
							r.set_value (p_email.value, "email")
							r.set_value (l_personal_information.value, "personal_information")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						end
					else
						create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.set_main_content ("There were issue with your application, invalid or missing values.")
					end
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("You can also contact the webmaster to ask for an account.")
			end
			r.execute
		end

	handle_activation (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			l_ir: INTERNAL_SERVER_ERROR_CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
		do
			l_user_api := api.user_api
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("account activate") then
				if attached {WSF_STRING} req.path_parameter ("token") as l_token then
					if attached {CMS_TEMP_USER} l_user_api.temp_user_by_activation_token (l_token.value) as l_user then

						-- TODO copy the personal information
						--! to CMS_USER_PROFILE and persist data
						--! check also CMS_USER.data_items

							-- Delete temporal User
						l_user_api.delete_temp_user (l_user)

							-- Valid user_id
						l_user.set_id (0)
						l_user.mark_active
						l_user_api.new_user_from_temp_user (l_user)
						l_user_api.remove_activation (l_token.value)
						r.set_main_content ("<p> The account <i>" + html_encoded (l_user.name) + "</i> has been activated</p>")
							-- Send Email
						if attached l_user.email as l_email then
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle register: send_contact_activation_confirmation_email")
							es.send_contact_activation_confirmation_email (l_email, l_user, req.absolute_script_url (""))
						end
					else
							-- the token does not exist, or it was already used.
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						r.set_main_content ("<p>The token <i>" + l_token.value + "</i> is not valid " + r.link ("Reactivate Account", "account/reactivate", Void) + "</p>")
					end
					r.execute
				else
					create l_ir.make (req, res, api)
					l_ir.execute
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.execute
			end
		end

	handle_reject (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_ir: INTERNAL_SERVER_ERROR_CMS_RESPONSE
			l_user_api: CMS_USER_API
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("account reject") then
				if attached {WSF_STRING} req.path_parameter ("token") as l_token then
					l_user_api := api.user_api
					if attached {CMS_TEMP_USER} l_user_api.temp_user_by_activation_token (l_token.value) as l_user then
						l_user_api.delete_temp_user (l_user)
						r.set_main_content ("<p> The temporal account for <i>" + html_encoded (l_user.name) + "</i> has been removed</p>")
							-- Send Email
						if attached l_user.email as l_email then
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle register: send_contact_activation_reject_email")
							es.send_contact_activation_reject_email (l_email, l_user, req.absolute_script_url (""))
						end
					else
							-- the token does not exist, or it was already used.
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						r.set_main_content ("<p>The token <i>" + l_token.value + "</i> is not valid ")
					end
					r.execute
				else
					create l_ir.make (req, res, api)
					l_ir.execute
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

	handle_reactivation (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_user_api: CMS_USER_API
			l_token: STRING
			l_url_activate: STRING
			l_url_reject: STRING
			l_email: READABLE_STRING_8
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("account reactivate") then
				if req.is_post_request_method then
					if attached {WSF_STRING} req.form_parameter ("email") as p_email then
						if p_email.value.is_valid_as_string_8 then
							l_email := p_email.value.to_string_8
							l_user_api := api.user_api
							if attached {CMS_TEMP_USER} l_user_api.temp_user_by_email (l_email) as l_user then
									-- User exist create a new token and send a new email.
								if l_user.is_active then
									r.set_value ("The asociated user to the given email " + l_email + " , is already active", "is_active")
									r.set_status_code ({HTTP_CONSTANTS}.bad_request)
								else
									l_token := new_token
									l_user_api.new_activation (l_token, l_user.id)
									l_url_activate := req.absolute_script_url ("/account/activate/" + l_token)
									l_url_reject := req.absolute_script_url ("/account/reject/" + l_token)
											-- Send Email to webmaster
									if attached l_user.personal_information as l_personal_information then
										create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
										write_debug_log (generator + ".handle register: send_register_email")
										es.send_account_evaluation (l_user, l_personal_information, l_url_activate, l_url_reject, req.absolute_script_url (""))
									end
								end
							else
								r.set_value ("The email does not exist !", "error_email")
								r.set_value (l_email, "email")
								r.set_status_code ({HTTP_CONSTANTS}.bad_request)
							end
						else
							r.set_value ("The email is not valid!", "error_email")
							r.set_value (p_email.value, "email")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						end
					end
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
			r.execute
		end

	handle_new_password (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_user_api: CMS_USER_API
			l_token: STRING
			l_url: STRING
			l_email: READABLE_STRING_8
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_post_request_method then
				l_user_api := api.user_api
				if attached {WSF_STRING} req.form_parameter ("email") as p_email then
					if p_email.value.is_valid_as_string_8 then
						l_email := p_email.value.to_string_8
						if attached {CMS_USER} l_user_api.user_by_email (l_email) as l_user then
								-- User exist create a new token and send a new email.
							l_token := new_token
							l_user_api.new_password (l_token, l_user.id)
							l_url := req.absolute_script_url ("/account/reset-password?token=" + l_token)

								-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle register: send_contact_password_email")
							es.send_contact_password_email (l_email, l_user, l_url, req.absolute_script_url (""))
						else
							r.set_value ("The email does not exist !", "error_email")
							r.set_value (p_email.value, "email")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						end
					else
						r.set_value ("The email is not valid!", "error_email")
						r.set_value (p_email.value, "email")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					end
				elseif attached {WSF_STRING} req.form_parameter ("username") as l_username then
					if
						attached {CMS_USER} l_user_api.user_by_name (l_username) as l_user and then
						attached l_user.email as l_user_email
					then
							-- User exist create a new token and send a new email.
						l_token := new_token
						l_user_api.new_password (l_token, l_user.id)
						l_url := req.absolute_script_url ("/account/reset-password?token=" + l_token)

							-- Send Email
						create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
						write_debug_log (generator + ".handle register: send_contact_password_email")
						es.send_contact_password_email (l_user_email, l_user, l_url, req.absolute_script_url (""))
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
			if attached {WSF_STRING} req.query_parameter ("token") as l_token then
				r.set_value (l_token.value, "token")
				if l_user_api.user_by_password_token (l_token.value) = Void then
					r.set_value ("The token " + l_token.value + " is not valid, " + r.link ("click here", "account/new-password", Void) + " to generate a new token.", "error_token")
					r.set_status_code ({HTTP_CONSTANTS}.bad_request)
				end
			end
			if req.is_post_request_method then
				if attached {WSF_STRING} req.form_parameter ("token") as l_token and then attached {WSF_STRING} req.form_parameter ("password") as l_password and then attached {WSF_STRING} req.form_parameter ("confirm_password") as l_confirm_password then
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
				if attached r.user as l_user then
					r.set_value (api.user_api.user_roles (l_user), "roles")
					if attached {WSF_STRING} req.form_parameter ("password") as l_password and then attached {WSF_STRING} req.form_parameter ("confirm_password") as l_confirm_password and then l_password.value.same_string (l_confirm_password.value) then
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

	handle_admin_pending_registrations (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			l_response: CMS_RESPONSE
			s: STRING
			u: CMS_TEMP_USER
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: INTEGER
			l_user_api: CMS_USER_API
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			create {FORBIDDEN_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			if
				l_response.has_permission ("admin registration")
			then
				l_user_api := api.user_api

				l_count := l_user_api.temp_users_count

				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				create s.make_empty
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " Pending Registrations")
				else
					l_response.set_title ("Listing " + l_count.out + " Pending Registration")
				end

				create s_pager.make_empty
				create l_page_helper.make ("admin/pending-registrations/?page={page}&size={size}", l_user_api.temp_users_count.as_natural_64, 25) -- FIXME: Make this default page size a global CMS settings
				l_page_helper.get_setting_from_request (req)
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (l_response, s_pager)
					if l_page_helper.page_size > 25 then
						s.append (s_pager)
					end
				end

				if attached l_user_api.temp_recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size)) as lst then
					s.append ("<ul class=%"cms-temp-users%">%N")
					across
						lst as ic
					loop
						u := ic.item
						s.append ("<li class=%"cms_temp_user%">")
						s.append ("User:" + html_encoded (u.name))
						s.append ("<ul class=%"cms_temp_user_details%">")
						if attached u.personal_information as l_information then
							s.append ("<li class=%"cms_temp_user_detail_information%">")
							s.append (html_encoded (l_information))
							s.append ("</li>%N")
						end
						if attached u.email as l_email then
							s.append ("<li class=%"cms_temp_user_detail_email%">")
							s.append (l_email)
							s.append ("</li>%N")
						end
						if attached l_user_api.token_by_temp_user_id (u.id) as l_token then
							s.append ("<li>")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url ("/account/activate/" + l_token))
							s.append ("%">")
							s.append (html_encoded ("Activate"))
							s.append ("</a>")
							s.append ("</li>%N")
							s.append ("<li>")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url ("/account/reject/" + l_token))
							s.append ("%">")
							s.append (html_encoded ("Reject"))
							s.append ("</a>")
							s.append ("</li>%N")
						end
						s.append ("</ul>%N")
						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end
					-- Again the pager at the bottom, if needed
				s.append (s_pager)

				l_response.set_main_content (s)
				l_response.execute
			else
				l_response.execute
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"register", "reactivate", "new_password", "reset_password", "registration">>
			debug ("roc")
				create l_string.make_empty
				across
					Result as ic
				loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
				write_debug_log (generator + ".block_list:" + l_string)
			end
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("register") and then a_response.location.starts_with ("account/roc-register") then
				get_block_view_register (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("reactivate") and then a_response.location.starts_with ("account/reactivate") then
				get_block_view_reactivate (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("new_password") and then a_response.location.starts_with ("account/new-password") then
				get_block_view_new_password (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("reset_password") and then a_response.location.starts_with ("account/reset-password") then
				get_block_view_reset_password (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("registration") and then a_response.location.starts_with ("admin/pending-registrations") then
				get_block_view_registration (a_block_id, a_response)
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
			from
			until
				l_token.same_string (l_encode.encoded_string (l_token))
			loop
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

	get_block_view_register (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.has_permission ("account register") then
				if a_response.request.is_get_request_method then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						if attached recaptcha_site_key (a_response.api) as l_recaptcha_site_key then
							l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
						end
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
							if attached recaptcha_site_key (a_response.api) as l_recaptcha_site_key then
								l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
							end
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
				if a_response.values.has ("error_email") or else a_response.values.has ("error_username") then
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
				if a_response.values.has ("error_token") or else a_response.values.has ("error_password") then
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

	get_block_view_registration	(a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
		end

feature -- Recaptcha

	recaptcha_secret_key (api: CMS_API): detachable READABLE_STRING_8
			-- Get recaptcha security key.
		local
			utf: UTF_CONVERTER
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if attached cfg.text_item ("recaptcha.secret_key") as l_recaptcha_key and then not l_recaptcha_key.is_empty then
					Result := utf.utf_32_string_to_utf_8_string_8 (l_recaptcha_key)
				end
			end
		end

	recaptcha_site_key (api: CMS_API): detachable READABLE_STRING_8
			-- Get recaptcha security key.
		local
			utf: UTF_CONVERTER
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if attached cfg.text_item ("recaptcha.site_key") as l_recaptcha_key and then not l_recaptcha_key.is_empty then
					Result := utf.utf_32_string_to_utf_8_string_8 (l_recaptcha_key)
				end
			end
		end

feature -- Response Alter

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_javascript_url ("https://www.google.com/recaptcha/api.js")
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/auth.css", Void), Void)
		end
feature {NONE} -- Implementation

	is_captcha_verified (a_secret, a_response: READABLE_STRING_8): BOOLEAN
		local
			api: RECAPTCHA_API
			l_errors: STRING
		do
			write_debug_log (generator + ".is_captcha_verified with response: [" + a_response + "]")
			create api.make (a_secret, a_response)
			Result := api.verify
			if not Result and then attached api.errors as l_api_errors then
				create l_errors.make_empty
				l_errors.append_character ('%N')
				across
					l_api_errors as ic
				loop
					l_errors.append (ic.item)
					l_errors.append_character ('%N')
				end
				write_error_log (generator + ".is_captcha_verified api_errors [" + l_errors + "]")
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
