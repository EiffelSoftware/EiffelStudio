note
	description: "Module Auth"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_MODULE

inherit
	CMS_MODULE
		rename
			module_api as auth_api
		redefine
			install,
			initialize,
			setup_hooks,
			permissions,
			auth_api
		end

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_VALUE_TABLE_ALTER

	CMS_HOOK_BLOCK
		redefine
			setup_block
		end

	CMS_HOOK_BLOCK_HELPER

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
			description := "Authentication module"
			package := "authentication"
			create root_dir.make_current
			cache_duration := 0
			enable -- Is enabled by default
		end

feature {CMS_API} -- Initialization

	initialize (api: CMS_API)
			-- <PRecursor>
		do
			create auth_api.make (api)
			Precursor (api)
		end

	install (api: CMS_API)
		do
			Precursor (api)
			if attached api.user_api.authenticated_user_role as l_auth_role then
				l_auth_role.add_permission (perm_view_own_account)
				api.user_api.save_user_role (l_auth_role)
			end
		end

feature -- Access

	name: STRING = "auth"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_account_register)
			Result.force ("account auto activate")
			Result.force (perm_view_own_account)
			Result.force (perm_edit_own_account)
			Result.force ("change own username")
			Result.force ("change own password")
			Result.force (perm_view_users)
		end

	auth_api: detachable CMS_AUTHENTICATION_API

	perm_view_own_account: STRING = "view own account"
	perm_edit_own_account: STRING = "edit own account"

	perm_view_users: STRING = "view users"

	perm_account_register: STRING = "account register"

feature {CMS_EXECUTION} -- Administration

	administration: CMS_AUTHENTICATION_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature -- Webapi

	webapi: CMS_AUTHENTICATION_MODULE_WEBAPI
		do
			create Result.make (Current)
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

	roc_register_location: STRING = "account/roc-register"

	roc_login_location: STRING = "account/roc-login"

	roc_logout_location: STRING = "account/roc-logout"

	roc_account_location: STRING = "account"

	roc_new_password_location: STRING = "account/new-password"

	roc_reset_password_location: STRING = "account/reset-password"

	roc_reactivate_location: STRING = "account/reactivate"

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached auth_api as l_auth_api then
				configure_web (l_auth_api, a_router)
			end
		end

	configure_web (a_api: CMS_AUTHENTICATION_API; a_router: WSF_ROUTER)
		local
			m: WSF_URI_MAPPING
		do
			create m.make_trailing_slash_ignored ("/" + roc_account_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_account (a_api, ?, ?)))
			a_router.map (m, a_router.methods_head_get)

			create m.make_trailing_slash_ignored ("/" + roc_account_location + "/edit", create {WSF_URI_AGENT_HANDLER}.make (agent handle_edit_account (a_api, ?, ?)))
			a_router.map (m, a_router.methods_head_get)


			a_router.handle ("/" + roc_login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login(a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/" + roc_logout_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout(a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/" + roc_register_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_register(a_api, ?, ?)), a_router.methods_get_post)

			a_router.handle ("/" + roc_new_password_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_new_password(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/" + roc_reset_password_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_reset_password(a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/" + roc_account_location + "/change/{field}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_change_field (a_api, ?, ?)), a_router.methods_get_post)
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
		local
			l_destination: detachable READABLE_STRING_GENERAL
			l_url: STRING
			l_url_name: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} a_response.request.item ("destination") as p_destination then
				l_destination := secured_url_content (p_destination.url_encoded_value)
			else
				l_destination := a_response.location
			end
			if l_destination.starts_with ("account/auth/") then
				l_destination := Void
			end

			if attached a_response.user as u then
				a_value.force (u, "user")

				l_url_name := "site_sign_out_url"
				l_url := a_response.url (roc_logout_location, Void)
			else
				a_value.force (Void, "user")

				l_url_name := "site_sign_in_url"
				l_url := a_response.url (roc_login_location, Void)
			end
			if l_destination /= Void and then not l_url.has_substring ("?destination") then
				l_url.append ("?destination=" + percent_encoded (l_destination))
			end
			a_value.force (l_url, l_url_name)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached a_response.user as u then
				if a_response.has_permission (perm_view_own_account) then
					create lnk.make (a_response.api.translation ("Your Account", Void), "account")
						-- it could also use the display username
					-- create lnk.make (u.name, "account")

					lnk.set_weight (97)
					a_menu_system.primary_menu.extend (lnk)
				end
				create lnk.make (a_response.api.translation ("Logout", Void), roc_logout_location)
			else
				create lnk.make (a_response.api.translation ("Login", Void), roc_login_location)
			end
			lnk.set_weight (98)
			if
				a_response.location.starts_with_general ("account/auth/")
				or a_response.location.starts_with_general ("account/roc-log") -- in ou out
			then
					-- ignore destination
			else
				lnk.add_query_parameter ("destination", percent_encoded (a_response.location))
			end
			a_menu_system.primary_menu.extend (lnk)

				 -- Add the link to the Administration page
			if a_response.has_permission ("access admin") then
				if attached {CMS_LOCAL_LINK} a_menu_system.management_menu.new_composite_item ("Admin", a_response.api.administration_path_location ("")) as adm_lnk then
					adm_lnk.set_weight (999)
					adm_lnk.set_permission_arguments (<<"access admin">>)
	--				a_menu_system.navigation_menu.extend (adm_lnk)
				end
			end
		end

feature -- Handler / Constants

	auth_strategy_execution_variable_name: STRING = "auth_strategy"
			-- Exevc

	auth_strategy (req: WSF_REQUEST): detachable READABLE_STRING_8
			-- Strategy used by current authentication.
			-- note: if user is authenticated..
		do
			if
				attached {READABLE_STRING_GENERAL} req.execution_variable (auth_strategy_execution_variable_name) as s and then
				s.is_valid_as_string_8
			then
				Result := s.to_string_8
			end
		end

feature -- Handler

	view_account_form_id: STRING = "roccms-user-view"
	edit_account_form_id: STRING = "roccms-user-edit"
	register_account_form_id: STRING = "roccms-user-register"

	handle_account (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user: detachable CMS_USER
			b: STRING
			lnk: CMS_LOCAL_LINK
			f: CMS_FORM
			tf: WSF_FORM_TEXT_INPUT
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
			create b.make_empty
			if r.is_authenticated then
				if r.has_permission (perm_edit_own_account) then
					create lnk.make ("View", "account/")
					lnk.set_weight (1)
					r.add_to_primary_tabs (lnk)

					create lnk.make ("Edit", "account/edit")
					lnk.set_weight (2)
					r.add_to_primary_tabs (lnk)
				end
			end

			l_user := r.user
			create f.make (r.location, view_account_form_id)
			if attached smarty_template_block (Current, "account_info", a_auth_api.cms_api) as l_tpl_block then
				l_tpl_block.set_weight (-1)
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [resources_page]")
				end
				if l_user /= Void then
					create tf.make_with_text ("username", l_user.name)
					tf.set_label ("Username")
					f.extend (tf)
					if attached l_user.email as l_email then
						create tf.make_with_text ("email", l_email.to_string_32)
						tf.set_label ("Email")
						f.extend (tf)
					end
					if attached l_user.profile_name as l_prof_name then
						create tf.make_with_text ("profile_name", l_prof_name)
						tf.set_label ("Profile name")
						f.extend (tf)
					end
					create tf.make_with_text ("creation", a_auth_api.cms_api.formatted_date_time_yyyy_mm_dd (l_user.creation_date))
					tf.set_label ("Creation date")
					f.extend (tf)

					if attached l_user.last_login_date as dt then
						create tf.make_with_text ("last_login", a_auth_api.cms_api.formatted_date_time_ago (dt))
						tf.set_label ("Last login")
						f.extend (tf)
					end
				end
			end

			a_auth_api.cms_api.hooks.invoke_form_alter (f, Void, r)
			f.append_to_html (r.wsf_theme, b)

			r.set_main_content (b)

			if l_user = Void then
				if
					attached {WSF_STRING} req.item ("destination") as l_destination and then
					attached l_destination.value as v and then
					v.is_valid_as_string_8
				then
					r.set_redirection (roc_login_location + "?destination=" + secured_url_content (v.to_string_8))
				else
					r.set_redirection (roc_login_location)
				end
--				r.set_redirection (roc_login_location)
			end
			r.execute
		end

	handle_edit_account (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user: detachable CMS_USER
			b: STRING
			lnk: CMS_LOCAL_LINK
			l_form: CMS_FORM
		do
			if a_auth_api.cms_api.has_permission (perm_edit_own_account) then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
				create b.make_empty
				l_user := r.user
				create l_form.make (r.location, edit_account_form_id)
				if attached smarty_template_block (Current, "account_edit", a_auth_api.cms_api) as l_tpl_block then
					l_tpl_block.set_weight (-1)
					r.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						r.add_warning_message ("Error with block [resources_page]")
					end
					-- Build CMS form...
				end
				create lnk.make ("View", "account/")
				lnk.set_weight (1)
				r.add_to_primary_tabs (lnk)

				create lnk.make ("Edit", "account/edit")
				lnk.set_weight (2)
				r.add_to_primary_tabs (lnk)

				if
					r.has_permission ("change own username") and then
					attached new_change_username_form (r) as f
				then
					f.append_to_html (r.wsf_theme, b)
				end
				if attached new_change_profile_name_form (r) as f then
					f.append_to_html (r.wsf_theme, b)
				end

				if
					r.has_permission ("change own password") and then
					attached new_change_password_form (r) as f
				then
					f.append_to_html (r.wsf_theme, b)
				end
				if attached new_change_email_form (r) as f then
					f.append_to_html (r.wsf_theme, b)
				end

				l_form.append_to_html (r.wsf_theme, b)

				r.set_main_content (b)

				if l_user = Void then
					r.set_redirection ("account")
				end
				r.execute
			else
				a_auth_api.cms_api.response_api.send_access_denied ("Can not edit your acocunt", req, res)
			end
		end

	handle_login (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if a_auth_api.cms_api.user_is_authenticated then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
				r.set_redirection ("account")
				r.execute
			else
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
				if
					attached {WSF_STRING} req.item ("destination") as l_destination and then
					attached l_destination.value as v and then
					v.is_valid_as_string_8
				then
					a_auth_api.invoke_get_login_redirection (r, v.to_string_8)
				else
					a_auth_api.invoke_get_login_redirection (r, Void)
				end
				r.execute
			end
		end

	handle_logout (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			loc: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
			if attached auth_strategy (req) as l_auth_strategy and then l_auth_strategy.is_valid_as_string_8 then
				loc := l_auth_strategy.to_string_8
			else
				loc := ""
			end
				-- Do not try to redirect to previous page or destination!
--			if attached {WSF_STRING} req.query_parameter ("destination") as l_destination then
--				loc.append ("?destination=" + secured_html_content (l_destination.url_encoded_value))
--			end
			r.set_redirection (loc)
			r.execute
		end

	handle_register (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: CMS_FORM
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			u: CMS_TEMP_USER
			l_exist: BOOLEAN
			l_captcha_passed: BOOLEAN
			l_email: READABLE_STRING_8
		do
			if a_auth_api.cms_api.has_permission ("account register") then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
				if req.is_post_request_method then
					create f.make (req.percent_encoded_path_info, register_account_form_id)
					f.extend_text_field ("name", Void)
					f.extend_password_field ("password", Void)
					f.extend_text_field ("email", Void)
					f.extend_text_field ("personal_information", Void)

					f.process (r)
					if
						attached f.last_data as fd and then not fd.has_error and then
						attached fd.string_item ("name") as l_name and then
						attached fd.string_item ("password") as l_password and then
						attached fd.string_item ("email") as s_email and then
						attached fd.string_item ("personal_information") as l_personal_information
					then
						if s_email.is_valid_as_string_8 then
							l_email := s_email.to_string_8
							l_user_api := a_auth_api.cms_api.user_api
							if attached l_user_api.user_by_name (l_name) or else attached l_user_api.temp_user_by_name (l_name) then
									-- Username already exist.
								r.set_value ("User name already exists!", "error_name")
								l_exist := True
							end
							if attached l_user_api.user_by_email (l_email) or else attached l_user_api.temp_user_by_email (l_email) then
									-- Email already exists.
								r.set_value ("An account is already associated with that email address!", "error_email")
								l_exist := True
							end
							l_captcha_passed := is_form_captcha_verified (req, a_auth_api.cms_api)
							if l_captcha_passed and then not l_exist then
									-- New temp user
								create u.make (l_name)
								u.set_email (l_email)
								u.set_password (l_password)
								u.set_personal_information (l_personal_information)
								a_auth_api.register_user (u, l_email, l_personal_information)
							else
								r.set_value (l_name, "name")
								r.set_value (l_email, "email")
								r.set_value (l_personal_information, "personal_information")
								r.set_status_code ({HTTP_CONSTANTS}.bad_request)
							end
						else
							r.set_value (l_name, "name")
							r.set_value (l_email, "email")
							r.set_value (l_personal_information, "personal_information")
							r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						end
						r.execute
					else
						a_auth_api.cms_api.response_api.send_bad_request ("There were issue with your application, invalid or missing values.", req, res)
					end
				else
						-- Using registration block ... return empty content for now.
						-- FIXME: find a way to know if block will be displayed, if not generate default web form.
						-- maybe using block is also not recommended for this part.
					r.add_to_primary_tabs (create {CMS_LOCAL_LINK}.make ("Sign in", "account/"))
					r.set_title ("Register an account")
					r.execute
				end
			else
				a_auth_api.cms_api.response_api.send_permissions_access_denied ("You can also contact the webmaster to ask for an account.", Void, req, res)
			end
		end

	handle_new_password (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_user_api: CMS_USER_API
			l_token: STRING
			l_url: STRING
			l_email: READABLE_STRING_8
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
			if req.is_post_request_method then
				l_user_api := a_auth_api.cms_api.user_api
				if attached {WSF_STRING} req.form_parameter ("email") as p_email then
					if p_email.value.is_valid_as_string_8 then
						l_email := p_email.value.to_string_8
						if attached {CMS_USER} l_user_api.user_by_email (l_email) as l_user then
								-- User exist create a new token and send a new email.
							l_token := a_auth_api.new_token
							l_user_api.new_password (l_token, l_user.id)
							l_url := req.absolute_script_url ("/"+ roc_reset_password_location + "?token=" + l_token)

								-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (a_auth_api.cms_api))
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
						attached {CMS_USER} l_user_api.user_by_name (l_username.value) as l_user and then
						attached l_user.email as l_user_email
					then
							-- User exist create a new token and send a new email.
						l_token := a_auth_api.new_token
						l_user_api.new_password (l_token, l_user.id)
						l_url := req.absolute_script_url ("/" + roc_reset_password_location + "?token=" + l_token)

							-- Send Email
						create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (a_auth_api.cms_api))
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

	handle_reset_password (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)
			l_user_api := a_auth_api.cms_api.user_api
			if attached {WSF_STRING} req.query_parameter ("token") as l_token then
				r.set_value (l_token.value, "token")
				if l_user_api.user_by_password_token (l_token.value) = Void then
					r.set_value ({STRING_32} "The token " + l_token.value + " is not valid, " + r.link ("click here", "account/new-password", Void) + " to generate a new token.", "error_token")
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

	handle_change_field (a_auth_api: CMS_AUTHENTICATION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			f: CMS_FORM
			l_fieldname: detachable READABLE_STRING_8
			b: STRING
			lnk: CMS_LOCAL_LINK
		do
			if attached {WSF_STRING} req.path_parameter ("field") as p_field then
				l_fieldname := p_field.url_encoded_value
			end
			if l_fieldname = Void then
				a_auth_api.cms_api.response_api.send_bad_request (Void, req, res)
			else
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_auth_api.cms_api)

				if r.is_authenticated then
					create lnk.make ("View", "account/")
					lnk.set_weight (1)
					r.add_to_primary_tabs (lnk)

					create lnk.make ("Edit", "account/edit")
					lnk.set_weight (2)
					r.add_to_primary_tabs (lnk)
				end

				l_user_api := a_auth_api.cms_api.user_api
				if req.is_post_request_method then
					if attached r.user as l_user then
						if l_fieldname.is_case_insensitive_equal ("password") then
							if
								attached {WSF_STRING} req.form_parameter ("password") as l_password and then
								attached {WSF_STRING} req.form_parameter ("confirm_password") as l_confirm_password and then
								l_password.value.same_string (l_confirm_password.value)
							then
									-- passwords matched?
								l_user.set_password (l_password.value)
								l_user_api.update_user (l_user)
								r.add_success_message ("Password updated.")
								r.set_redirection ("account/")
								r.set_redirection_delay (3)
							else
								r.add_error_message ("Passwords do not match!")
								f := new_change_password_form (r)
								r.set_main_content (f.to_html (r.wsf_theme))
							end
						elseif l_fieldname.is_case_insensitive_equal ("email") then
								-- FIXME: find a safer workflow .. allow multiple emails, and have a primary email?
							if
								attached {WSF_STRING} req.form_parameter ("email") as l_email and then
								attached {WSF_STRING} req.form_parameter ("confirm_email") as l_confirm_email and then
								l_email.value.same_string (l_confirm_email.value) and then
								l_email.value.is_valid_as_string_8
							then
									-- emails matched?
								l_user.set_email (l_email.value.to_string_8)
								l_user_api.update_user (l_user)
								r.add_success_message ("Email updated.")
								r.set_redirection ("account/")
								r.set_redirection_delay (3)
							else
								r.add_error_message ("Emails do not match!")
								f := new_change_email_form (r)
								r.set_main_content (f.to_html (r.wsf_theme))
							end
						elseif l_fieldname.is_case_insensitive_equal ("profile_name") then
							f := new_change_profile_name_form (r)
							f.process (r)
							if
								attached f.last_data as fd and then
								not fd.has_error and then
								attached fd.string_item ("new_profile_name") as l_new_profile_name
							then
								check a_auth_api.cms_api.user_api.is_valid_profile_name (l_new_profile_name) end
								l_user.set_profile_name (l_new_profile_name)
								l_user_api.update_user (l_user)
								r.add_success_message ("Profile name updated.")
								r.set_redirection ("account/")
								r.set_redirection_delay (3)
							else
								r.add_error_message ("Invalid form data!")
								r.set_main_content (f.to_html (r.wsf_theme))
							end
						elseif l_fieldname.is_case_insensitive_equal ("username") then
							if a_auth_api.cms_api.has_permission ("change own username") then
								f := new_change_username_form (r)
								f.process (r)
								if
									attached f.last_data as fd and then
									not fd.has_error and then
									attached fd.string_item ("new_username") as l_new_username
								then
									check a_auth_api.cms_api.user_api.is_valid_username (l_new_username) end
									check a_auth_api.cms_api.user_api.user_by_name (l_new_username) = Void end

									l_user_api.update_username (l_user, l_new_username)
									r.add_success_message ("Username updated.")
									r.set_redirection ("account/")
									r.set_redirection_delay (3)
								else
									r.add_error_message ("Invalid form data!")
									r.set_main_content (f.to_html (r.wsf_theme))
								end
							else
								r.add_error_message ("You are not allowed to change your username!")
							end
						else
							r.add_error_message ("You can not change %"" + l_fieldname + "%" information!")
						end
					end
				else
					create b.make_empty
					if l_fieldname.is_case_insensitive_equal_general ("password") then
						f := new_change_password_form (r)
						f.append_to_html (r.wsf_theme, b)
					elseif l_fieldname.is_case_insensitive_equal_general ("email") then
						f := new_change_email_form (r)
						f.append_to_html (r.wsf_theme, b)
					elseif l_fieldname.is_case_insensitive_equal_general ("new_username") then
						if a_auth_api.cms_api.has_permission ("change own username") then
							f := new_change_username_form (r)
							f.append_to_html (r.wsf_theme, b)
						end
					end
					r.set_main_content (b)
				end
				r.execute
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"register", "reactivate", "new_password", "reset_password">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			loc: READABLE_STRING_8
		do
			loc := a_response.location
			if a_block_id.is_case_insensitive_equal_general ("register") and then loc.starts_with (roc_register_location) then
				get_block_view_register (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("reactivate") and then loc.starts_with (roc_reactivate_location) then
				get_block_view_reactivate (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("new_password") and then loc.starts_with (roc_new_password_location) then
				get_block_view_new_password (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("reset_password") and then loc.starts_with (roc_reset_password_location) then
				get_block_view_reset_password (a_block_id, a_response)
			end
		end

	setup_block (a_block: CMS_BLOCK; a_response: CMS_RESPONSE)
			-- Setup block `a_block` and perform additional setup on `a_response` if needed
			-- (such as linking with css, js, ...).
			--| To be redefined if needed.
		do
--			if
--				a_block.name.is_case_insensitive_equal_general ("register")
--			then
--				a_response.add_javascript_url ("https://www.google.com/recaptcha/api.js")
--			end
			a_response.add_javascript_url ("https://www.google.com/recaptcha/api.js")
		end

	new_change_username_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			fs: WSF_FORM_FIELD_SET
			txt: WSF_FORM_TEXT_INPUT
		do
			create Result.make (a_response.url ("account/change/username", Void), "change-username-form")
			create fs.make
			fs.set_legend ("Change username")
			Result.extend (fs)

			create txt.make ("new_username")
			txt.set_label ("Username")
			txt.set_validation_action (agent (fd: WSF_FORM_DATA; api: CMS_API)
					do
						if
							attached fd.string_item ("new_username") as l_new and then
							api.user_api.is_valid_username (l_new)
						then
							if api.user_api.user_by_name (l_new) /= Void then
								fd.report_invalid_field ("new_username", "Username is already taken!")
							end
						else
							fd.report_invalid_field ("new_username", "Invalid username!")
						end
					end (?, a_response.api)
				)
			txt.enable_required
			fs.extend (txt)
			fs.extend_html_text ("<button type=%"submit%">Confirm</button>")
		end

	new_change_profile_name_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			fs: WSF_FORM_FIELD_SET
			txt: WSF_FORM_TEXT_INPUT
		do
			create Result.make (a_response.url ("account/change/profile_name", Void), "change-profile-name-form")
			create fs.make
			fs.set_legend ("Change profile name (i.e the name displayed on pages)")
			Result.extend (fs)

			create txt.make ("new_profile_name")
			txt.set_label ("Profile name")
			txt.set_validation_action (agent (fd: WSF_FORM_DATA; api: CMS_API)
					do
						if
							attached fd.string_item ("new_profile_name") as l_new and then
							api.user_api.is_valid_profile_name (l_new)
						then
								-- Ok
						else
							fd.report_invalid_field ("new_profile_name", "Invalid profile name!")
						end
					end (?, a_response.api)
				)
			txt.enable_required
			fs.extend (txt)
			fs.extend_html_text ("<button type=%"submit%">Confirm</button>")
		end

	new_change_password_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			fs: WSF_FORM_FIELD_SET
			pwd: WSF_FORM_PASSWORD_INPUT
		do
			create Result.make (a_response.url ("account/change/password", Void), "change-password-form")
			create fs.make
			fs.set_legend ("Change password")
			Result.extend (fs)

			create pwd.make ("password")
			pwd.set_label ("Password")
			pwd.enable_required
			fs.extend (pwd)
			create pwd.make ("confirm_password")
			pwd.set_label ("Confirm password")
			pwd.enable_required
			fs.extend (pwd)

--			create but.make_with_text ("op", "Confirm")
--			fs.extend (but)

			fs.extend_html_text ("<button type=%"submit%">Confirm</button>")
		end

	new_change_email_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			fs: WSF_FORM_FIELD_SET
			tf: WSF_FORM_EMAIL_INPUT
		do
			create Result.make (a_response.url ("account/change/email", Void), "change-email-form")
			create fs.make
			fs.set_legend ("Change email")
			Result.extend (fs)

			create tf.make ("email")
			tf.set_label ("Email")
			tf.enable_required
			fs.extend (tf)
			create tf.make ("confirm_email")
			tf.set_label ("Confirm email")
			tf.enable_required
			fs.extend (tf)

			fs.extend_html_text ("<button type=%"submit%">Confirm</button>")
		end

feature {NONE} -- Block views

	get_block_view_register (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_response.has_permission ("account register") then
				if
					a_response.request.is_get_request_method
					or else (
						a_response.values.has ("error_name")
						or else a_response.values.has ("error_email")
					)
				then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
--						l_tpl_block.set_value (a_response.values.item ("error_name"), "error_name")
--						l_tpl_block.set_value (a_response.values.item ("error_email"), "error_email")
--						l_tpl_block.set_value (a_response.values.item ("email"), "email")
--						l_tpl_block.set_value (a_response.values.item ("name"), "name")
						l_tpl_block.set_value (form_registration_application_description (a_response.api), "application_description")
						l_tpl_block.set_value (register_account_form_id, "form_id")
						if attached recaptcha_site_html (register_account_form_id, a_response.api) as l_recaptcha_site_html then
							l_tpl_block.set_value (l_recaptcha_site_html, "recaptcha_site_html")
						end
						if
							attached recaptcha_config (a_response.api) as cfg and then
							attached cfg.site_key as l_recaptcha_site_key
						then
								-- Backward compatiblity
							l_tpl_block.set_value (l_recaptcha_site_key, "recaptcha_site_key")
						end
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				elseif a_response.request.is_post_request_method then
					if attached smarty_template_block (Current, "post_register", a_response.api) as l_tpl_block then
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
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_email") or else a_response.values.has ("is_active") then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
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
					if attached smarty_template_block (Current, "post_reactivate", a_response.api) as l_tpl_block then
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
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_response.request.is_post_request_method then
				if a_response.values.has ("error_email") or else a_response.values.has ("error_username") then
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
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
					if attached smarty_template_block (Current, "post_password", a_response.api) as l_tpl_block then
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
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
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
					if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
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
					if attached smarty_template_block (Current, "post_reset", a_response.api) as l_tpl_block then
						a_response.add_block (l_tpl_block, "content")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end

feature -- WebUI helpers

	append_login_or_register_box_to_html (api: CMS_API; a_destination: detachable READABLE_STRING_8; a_html: STRING_8)
		local
			d: STRING
		do
			if a_destination = Void then
				d := ""
			else
				d := "?destination=" + url_encoded (a_destination)
			end
			a_html.append ("<div class=%"login_box%">")
			a_html.append ("<a href=%"" + api.location_absolute_url (roc_login_location, Void) + d +"%">Login</a>")
			a_html.append (" / ")
			a_html.append ("<a href=%"" + api.location_absolute_url (roc_register_location, Void) + d +"%">Register</a>")
			a_html.append ("</div>")
		end

feature -- Access: configuration

	form_registration_application_description (api: CMS_API): detachable READABLE_STRING_8
			-- Application description value for the form.
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if attached cfg.text_item ("forms.registration.application_description") as l_desc and then not l_desc.is_whitespace then
					Result := api.utf_8_encoded (l_desc)
				end
			end
		end

	recaptcha_action: STRING = "register"

	recaptcha_config (api: CMS_API): detachable RECAPTCHA_CONFIG
		do
			if attached api.module_configuration (Current, Void) as cfg then
				if
					attached cfg.text_item ("recaptcha.version") as v and then
					not v.is_empty
				then
					create Result.make_with_version (api.utf_8_encoded (v))
				else
					create Result.make
				end
				if
					attached cfg.text_item ("recaptcha.secret_key") as k and then
					not k.is_empty
				then
					Result.set_secret_key (api.utf_8_encoded (k))
				end
				if
					attached cfg.text_item ("recaptcha.site_key") as k and then
					not k.is_empty
				then
					Result.set_site_key (api.utf_8_encoded (k))
				end
			end
		end

	recaptcha_site_html (a_form_id: READABLE_STRING_8; api: CMS_API): detachable READABLE_STRING_8
		local
			l_client: RECAPTCHA_CLIENT
		do
			if
				attached recaptcha_config (api) as cfg and then
				attached cfg.site_key as l_recaptcha_site_key
			then
				create l_client.make (cfg, l_recaptcha_site_key)
				Result := l_client.client_html (a_form_id, recaptcha_action)
			end
		end

feature -- Response Alter

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/auth.css", Void), Void)
		end

feature {NONE} -- Implementation

	is_form_captcha_verified (req: WSF_REQUEST; api: CMS_API): BOOLEAN
		do
			if
				attached recaptcha_config (api) as cfg and then
				attached cfg.secret_key as l_secret_key
			then
				if attached {WSF_STRING} req.form_parameter ("g-recaptcha-response") as l_recaptcha_response then
					Result := is_captcha_verified (cfg, l_secret_key, l_recaptcha_response.value)
				else
						--| missing captcha
				end
			else
					--| reCaptcha is not setup, so no verification
				Result := True
			end
		end

	is_captcha_verified (cfg: RECAPTCHA_CONFIG; a_secret: READABLE_STRING_8; a_response: READABLE_STRING_GENERAL): BOOLEAN
		local
			api: RECAPTCHA_API
			l_errors: STRING
		do
			write_debug_log (generator + ".is_captcha_verified with response: [" + utf_8_encoded (a_response) + "]")
			create api.make (a_secret, a_response)
			if cfg.is_version_3 then
				Result := api.verify_score (0.5, recaptcha_action)
			else
				Result := api.verify
			end
			if
				not Result and then
				attached api.errors as l_api_errors
			then
				create l_errors.make_empty
				l_errors.append_character ('%N')
				across l_api_errors as ic loop
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
