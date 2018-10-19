note
	description: "[
			Generic OAuth Module supporting authentication using different providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_MODULE

inherit
	CMS_AUTH_MODULE_I
		rename
			module_api as oauth20_api
		redefine
			make,
			filters,
			setup_hooks,
			initialize,
			install,
			oauth20_api,
			permissions,
			has_permission_to_use_authentication
		end

	CMS_ADMINISTRABLE

	CMS_HOOK_BLOCK

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			Precursor
			version := "1.0"
			description := "OAuth20 module"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "oauth20"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.extend (perm_use_oauth2_auth)
			Result.extend (perm_account_oauth2_register)
		end

	perm_use_oauth2_auth: STRING = "use oauth2_auth"
	perm_account_oauth2_register: STRING = "oauth2 account register"

	has_permission_to_use_authentication (api: CMS_API): BOOLEAN
		do
			Result := api.has_permission (perm_use_oauth2_auth)
		end

feature {CMS_EXECUTION} -- Administration

	administration: CMS_OAUTH_20_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			l_oauth20_api: like oauth20_api
			l_auth_storage: CMS_OAUTH_20_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached a_api.storage.as_sql_storage as l_storage_sql then
				create {CMS_OAUTH_20_STORAGE_SQL} l_auth_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_OAUTH_20_STORAGE_NULL} l_auth_storage
			end

				-- API initialization
			create l_oauth20_api.make_with_storage (a_api, l_auth_storage)
			oauth20_api := l_oauth20_api
		ensure then
			user_oauth_api_set: oauth20_api /= Void
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			l_consumers: LIST [STRING]
		do
				-- Schema
			if attached api.storage.as_sql_storage as l_sql_storage then
					--| Schema
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					api.report_error ("[" + name + "]: installation failed (install)!", l_sql_storage.error_handler.as_string_representation)
				else
					Precursor {CMS_AUTH_MODULE_I}(api) -- Marked as installed.
					l_sql_storage.sql_finalize
					if attached api.user_api.authenticated_user_role as l_role then
							-- By default, user can login with OAuth!
						l_role.add_permission (perm_use_oauth2_auth)
						api.user_api.save_user_role (l_role)
					end
				end
			end
		end

feature {CMS_API, CMS_MODULE_ADMINISTRATION} -- Access: API

	oauth20_api: detachable CMS_OAUTH_20_API
			-- <Precursor>	

feature -- Filters

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached oauth20_api as l_oauth_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {CMS_OAUTH_20_FILTER}.make (a_api, l_oauth_api))
			end
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

feature -- Access: auth strategy	

	login_title: STRING = "OAuth"
			-- Module specific login title.

	login_location: STRING = "account/auth/roc-oauth-login"

	logout_location: STRING = "account/auth/roc-oauth-logout"

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
			-- <Precursor>
		do
			if
				a_response.is_authenticated and then
				attached oauth20_api as l_oauth20_api and then
				attached a_response.request.cookie (l_oauth20_api.session_token)
			then
				Result := True
			end
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached oauth20_api as l_oauth_api then
				a_router.handle ("/" + login_location,
						create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + logout_location,
						create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, l_oauth_api, ?, ?)),
						a_router.methods_get_post)
				a_router.handle ("/account/auth/login-with-oauth/{" + oauth_callback_path_parameter + "}",
						create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_login_with_oauth (a_api, l_oauth_api, ?, ?)),
						a_router.methods_get_post)
				a_router.handle (oauth_callback_path + "{" + oauth_callback_path_parameter + "}",
						create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_callback_oauth (a_api, l_oauth_api, ?, ?)),
						a_router.methods_get_post)
				a_router.handle ("/account/auth/oauth-associate",
						create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_associate (a_api, l_oauth_api, ?, ?)),
						a_router.methods_post)
				a_router.handle ("/account/auth/oauth-un-associate",
						create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_un_associate (a_api, l_oauth_api, ?, ?)),
						a_router.methods_post)
			end
		end

	oauth_callback_path_parameter: STRING = "callback"
			-- Callback path parameter.	

	oauth_callback_path: STRING = "/account/auth/oauth-callback/"

	oauth_code_query_parameter: STRING = "code"
			-- Code query parameter, specific to OAuth protocol.
			-- FIXME: should we have a way to change this value?
			--      : if a OAuth provider is not using "code" query name.

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			Precursor (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"login", "account">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if
				a_block_id.is_case_insensitive_equal_general ("login") and then
				a_response.location.starts_with (login_location)
			then
				get_block_view_login (a_block_id, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("account") and then
				a_response.location.same_string ("account")
			then
				if
					attached smarty_template_block (Current, "account_info", a_response.api) as l_tpl_block and then
					attached a_response.user as l_user
				then
					associate_account (l_user, a_response.values)
					l_tpl_block.set_weight (5)
					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [resources_page]")
					end
				end
			end
		end

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if r.is_authenticated then
				r.add_error_message ("You are already signed in!")
			else
				r.set_optional_content_type ("Login")
			end
			r.execute
		end

	handle_logout (api: CMS_API; a_oauth20_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_cookie: WSF_COOKIE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if
				attached api.user as l_user and then
				attached {WSF_STRING} req.cookie (a_oauth20_api.session_token) as l_cookie_token
			then
					-- Logout OAuth
				create l_cookie.make (a_oauth20_api.session_token, "DELETED")
				l_cookie.set_path ("/")
				l_cookie.set_max_age (0) --| Remove cookie
				res.add_cookie (l_cookie)
				api.unset_current_user (req)
			else
				debug ("refactor_fixme")
					fixme (generator + ": missing else implementation in handle_logout!")
				end
			end
			r.set_status_code ({HTTP_CONSTANTS}.found)
			r.set_redirection (req.absolute_script_url (""))
			r.execute
		end

feature {NONE} -- Associate

	associate_account (a_user: CMS_USER; a_value: CMS_VALUE_TABLE)
		local
			l_associated: LIST [STRING]
			l_not_associated: LIST [STRING]
		do
			if attached oauth20_api as l_oauth_api then
				create {ARRAYED_LIST [STRING]} l_associated.make (1)
				create {ARRAYED_LIST [STRING]} l_not_associated.make (1)
				across l_oauth_api.oauth2_consumers as ic loop
					if attached l_oauth_api.user_oauth2_by_user_id (a_user.id, ic.item) then
						l_associated.force (ic.item)
					else
						l_not_associated.force (ic.item)
					end
				end
				a_value.force (l_associated, "oauth_associated")
				a_value.force (l_not_associated, "oauth_not_associated")
			end
		end

feature {NONE} -- Block views

	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			vals: CMS_VALUE_TABLE
		do
			if a_response.api.has_permission (perm_use_oauth2_auth) then
				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
					create vals.make (1)
						-- add the variable to the block
					a_response.api.hooks.invoke_value_table_alter (vals, a_response)
					across
						vals as ic
					loop
						l_tpl_block.set_value (ic.item, ic.key)
					end
					if
						attached oauth20_api as l_auth_api and then
						attached l_auth_api.oauth2_consumers as l_list
					then
						l_tpl_block.set_value (l_list, "oauth_consumers")
					end

					a_response.add_block (l_tpl_block, "content")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			end
		end


feature -- OAuth2 Login with Provider

	handle_login_with_oauth (api: CMS_API; a_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_oauth: CMS_OAUTH_20_WORKFLOW
		do
			if api.has_permission (perm_use_oauth2_auth) then
				if
					attached {WSF_STRING} req.path_parameter (oauth_callback_path_parameter) as p_consumer and then
					attached {CMS_OAUTH_20_CONSUMER} a_oauth_api.oauth_consumer_by_name (p_consumer.value) as l_consumer
				then
					create l_oauth.make (req.server_url, l_consumer)
					if attached l_oauth.authorization_url as l_authorization_url then
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						r.set_redirection (l_authorization_url)
					else
						create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.set_main_content ("Bad request")
					end
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("Bad request")
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("You are not allowed to login with " + name + " account!")
			end
			r.execute
		end

	handle_callback_oauth (api: CMS_API; a_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_auth: CMS_OAUTH_20_WORKFLOW
			l_user_api: CMS_USER_API
			l_user: CMS_USER
			l_roles: LIST [CMS_USER_ROLE]
			l_cookie: WSF_COOKIE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			l_oauth_id: READABLE_STRING_GENERAL
		do
			if
				attached {WSF_STRING} req.path_parameter (oauth_callback_path_parameter) as l_callback and then
			    attached {CMS_OAUTH_20_CONSUMER} a_oauth_api.oauth_consumer_by_callback (l_callback.value) as l_consumer and then
				attached {WSF_STRING} req.query_parameter (oauth_code_query_parameter) as l_code
			then
				create l_auth.make (req.server_url, l_consumer)
				l_auth.sign_request (l_code.value)
				if
					attached l_auth.access_token as l_access_token and then
					attached l_auth.user_profile as l_user_profile
				then
						-- extract user email
					if attached l_auth.user_id as l_id then
						l_oauth_id := l_id
					elseif attached l_auth.user_email as l_email then
						l_oauth_id := l_email
					elseif attached l_auth.user_login as l_login then
						l_oauth_id := l_login
					end
					if l_oauth_id /= Void then
							-- check if the user exist
						l_user_api := api.user_api
							-- if the user exits put it in the context
							-- FIXME: what if the email is not available, should it check for unique id such as `id`, `login`, .. if available? [2018-10-18]
						if attached api.user as l_current_user then
								-- Try to associate.
							if api.has_permission (perm_use_oauth2_auth) then
									-- User with email exist
								if	attached a_oauth_api.user_oauth2_by_user_id (l_current_user.id, l_consumer.name) as l_oauth_user then
										-- Update oauth entry
									create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
									r.set_main_content ("An user is already associated with that " + name + " account!")
								else
									create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
										-- create a oauth entry
									a_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile.to_string_32, l_current_user, l_oauth_id, l_consumer.name)
									r.set_redirection (api.location_absolute_url ("account", Void))
								end
							else
								create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
								r.set_main_content ("You are not allowed to associate with " + name + " account!")
							end
						else
							create l_cookie.make (a_oauth_api.session_token, l_access_token.token)
							if l_access_token.expires_in > 0 then
								l_cookie.set_max_age (l_access_token.expires_in)
							end
							l_cookie.set_path ("/")

							if
								attached l_auth.user_email as l_email and then
								attached l_user_api.user_by_email (l_email) as p_user
							then
								if api.user_has_permission (p_user, perm_use_oauth2_auth) then
									create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
										-- User with oauth id association exist
									if	attached a_oauth_api.user_oauth2_by_user_id (p_user.id, l_consumer.name) as l_oauth_user then
											-- Update oauth entry
										a_oauth_api.update_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_oauth_id, l_consumer.name )
									else
											-- create a oauth entry
										a_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile.to_string_32, p_user, l_oauth_id, l_consumer.name )
									end
									res.add_cookie (l_cookie)
									r.set_redirection (r.front_page_url)
								else
									create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
									r.set_main_content ("You are not allowed to login with " + name + " account!")
								end
							elseif attached a_oauth_api.user_oauth2_by_id (l_oauth_id, l_consumer.name) as p_user then
								create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
								a_oauth_api.update_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_oauth_id, l_consumer.name )
								res.add_cookie (l_cookie)
								r.set_redirection (r.front_page_url)
							elseif api.has_permission (perm_account_oauth2_register) then
								create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
								create {ARRAYED_LIST [CMS_USER_ROLE]} l_roles.make (1)
								l_roles.force (l_user_api.authenticated_user_role)

									-- Create a new user and oauth entry
								create l_user.make (l_oauth_id)
								if attached l_auth.user_email as l_email then
									l_user.set_email (l_email)
								end
								l_user.set_password (new_token) -- generate a random password.
								l_user.set_roles (l_roles)
								l_user.mark_active
								l_user_api.new_user (l_user)

									-- Add oauth entry
								a_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile, l_user, l_oauth_id, l_consumer.name )
								api.set_user (l_user)
								api.record_user_login (l_user)

								res.add_cookie (l_cookie)
								r.set_redirection (r.front_page_url)

									-- Send Email
								if attached l_user.email as l_email then
									create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
									write_debug_log (generator + ".handle_callback_oauth: send_contact_welcome_email")
									es.send_contact_welcome_email (l_email, l_user, req.absolute_script_url (""))
								end
							else
								create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
								r.set_main_content ("You are not allowed to register with " + name + " account!")
							end
						end
					else
						create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.add_error_message ("Missing unique oauth id such as email, login, id information!")
					end
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	handle_associate (api: CMS_API; a_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_oauth: CMS_OAUTH_20_WORKFLOW
		do
			if
				attached api.user as l_user and then
				api.has_permission (perm_use_oauth2_auth)
			then
				if
					attached {WSF_STRING} req.form_parameter ("consumer") as p_consumer and then
					attached {CMS_OAUTH_20_CONSUMER} a_oauth_api.oauth_consumer_by_name (p_consumer.value) as l_consumer
				then
					create l_oauth.make (req.server_url, l_consumer)
					if attached l_oauth.authorization_url as l_authorization_url then
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						r.set_redirection (l_authorization_url)
					else
						create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.set_main_content ("Bad request")
					end
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("Bad request")
				end

--				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

--				if req.is_post_request_method then
--					if
--						attached {WSF_STRING} req.form_parameter ("consumer") as l_consumer and then
--						attached {WSF_STRING} req.form_parameter ("email") as l_email and then
--						attached r.user as l_user
--					then
--						l_user.set_email (api.utf_8_encoded (l_email.value))
--						a_oauth_api.new_user_oauth2 ("none", "none", l_user, l_consumer.value )
--							-- TODO send email?
--					end
--				end
--				r.set_redirection (req.absolute_script_url ("/account"))
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.add_error_message ("You are not allowed to associate with " + name + " account!")
			end
			r.execute
		end

	handle_un_associate (api: CMS_API; a_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_post_request_method then
				if
					attached {WSF_STRING} req.form_parameter ("consumer") as l_consumer and then
					attached r.user as l_user
				then
					a_oauth_api.remove_user_oauth2 (l_user, l_consumer.value)
					-- TODO send email?
				end
			end
			r.set_redirection (req.absolute_script_url ("/account"))
			r.execute
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
