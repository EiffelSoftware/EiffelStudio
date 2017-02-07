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
			oauth20_api
		end

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
					api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
						-- TODO workaround.
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("data.sql")), Void)
					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize oauth2_consumers for module [" + name + "]", generating_type)
					else
							-- TODO workaround, until we have an admin module
						l_sql_storage.sql_query ("SELECT name FROM oauth2_consumers;", Void)
						if l_sql_storage.has_error then
							api.logger.put_error ("Could not initialize database for different consumers", generating_type)
						else
							from
								l_sql_storage.sql_start
								create {ARRAYED_LIST [STRING]} l_consumers.make (2)
							until
								l_sql_storage.sql_after
							loop
								if attached l_sql_storage.sql_read_string (1) as l_name then
									l_consumers.force ("oauth2_" + l_name)
								end
								l_sql_storage.sql_forth
							end
							l_sql_storage.sql_finalize

							across l_consumers as ic  loop
								if not l_sql_storage.sql_table_exists (ic.item) then
									if attached l_sql_storage.sql_script_content (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("oauth2_table.sql.tpl"))) as sql then
											-- FIXME: shouldn't we use a unique table for all oauth providers? or as it is .. one table per oauth provider?
										sql.replace_substring_all ("$table_name", ic.item)
										l_sql_storage.sql_execute_script (sql, Void)
									end
								end
							end
						end
						l_sql_storage.sql_finalize

						Precursor {CMS_AUTH_MODULE_I}(api) -- Marked as installed.
					end
				end
			end
		end

feature {CMS_API} -- Access: API

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
				a_router.handle ("/account/auth/oauth-callback/{" + oauth_callback_path_parameter + "}",
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
				r.set_value ("Login", "optional_content_type")
			end
			r.execute
		end

	handle_logout (api: CMS_API; a_oauth20_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_cookie: WSF_COOKIE
		do
			if
				attached api.user as l_user and then
				attached {WSF_STRING} req.cookie (a_oauth20_api.session_token) as l_cookie_token
			then
					-- Logout OAuth
				create l_cookie.make (a_oauth20_api.session_token, l_cookie_token.value)
				l_cookie.set_path ("/")
				l_cookie.set_max_age (-1)
				res.add_cookie (l_cookie)
				api.unset_current_user (req)

				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
				r.set_redirection (req.absolute_script_url (""))
				r.execute
			else
				fixme (generator + ": missing else implementation in handle_logout!")
			end
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
					if attached l_oauth_api.user_oauth2_by_id (a_user.id, ic.item) then
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


feature -- OAuth2 Login with Provider

	handle_login_with_oauth (api: CMS_API; a_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_oauth: CMS_OAUTH_20_WORKFLOW
		do
			if
				attached {WSF_STRING} req.path_parameter (oauth_callback_path_parameter) as p_consumer and then
				attached {CMS_OAUTH_20_CONSUMER} a_oauth_api.oauth_consumer_by_name (p_consumer.value) as l_consumer
			then
				create l_oauth.make (req.server_url, l_consumer)
				if attached l_oauth.authorization_url as l_authorization_url then
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					r.set_redirection (l_authorization_url)
					r.execute
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("Bad request")
					r.execute
				end
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("Bad request")
				r.execute
			end
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
		do
			if  attached {WSF_STRING} req.path_parameter (oauth_callback_path_parameter) as l_callback and then
			    attached {CMS_OAUTH_20_CONSUMER} a_oauth_api.oauth_consumer_by_callback (l_callback.value) as l_consumer and then
				attached {WSF_STRING} req.query_parameter (oauth_code_query_parameter) as l_code
			then
				create l_auth.make (req.server_url, l_consumer)
				l_auth.sign_request (l_code.value)
				if
					attached l_auth.access_token as l_access_token and then
					attached l_auth.user_profile as l_user_profile
				then
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						-- extract user email
						-- check if the user exist
					l_user_api := api.user_api
						-- 1 if the user exit put it in the context
					if
						attached l_auth.user_email as l_email
					then
						if attached l_user_api.user_by_email (l_email) as p_user then
								-- User with email exist
							if	attached a_oauth_api.user_oauth2_by_id (p_user.id, l_consumer.name) then
									-- Update oauth entry
								a_oauth_api.update_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_consumer.name )
							else
									-- create a oauth entry
								a_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_consumer.name )
							end
							create l_cookie.make (a_oauth_api.session_token, l_access_token.token)
							l_cookie.set_max_age (l_access_token.expires_in)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)
						elseif attached a_oauth_api.user_oauth2_by_email (l_email, l_consumer.name) as p_user then
							a_oauth_api.update_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_consumer.name )
							create l_cookie.make (a_oauth_api.session_token, l_access_token.token)
							l_cookie.set_max_age (l_access_token.expires_in)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)
						else
							create {ARRAYED_LIST [CMS_USER_ROLE]} l_roles.make (1)
							l_roles.force (l_user_api.authenticated_user_role)

								-- Create a new user and oauth entry
							create l_user.make (l_email)
							l_user.set_email (l_email)
							l_user.set_password (new_token) -- generate a random password.
							l_user.set_roles (l_roles)
							l_user.mark_active
							l_user_api.new_user (l_user)

								-- Add oauth entry
							a_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile, l_user, l_consumer.name )
							create l_cookie.make (a_oauth_api.session_token, l_access_token.token)
							l_cookie.set_max_age (l_access_token.expires_in)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)
							api.set_user (l_user)
							api.record_user_login (l_user)

								-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle_callback_oauth: send_contact_welcome_email")
							es.send_contact_welcome_email (l_email, l_user, req.absolute_script_url (""))
						end
					end
					r.set_redirection (r.front_page_url)
					r.execute
				end
			end
		end

	handle_associate (api: CMS_API; a_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

			if req.is_post_request_method then
				if
					attached {WSF_STRING} req.form_parameter ("consumer") as l_consumer and then
					attached {WSF_STRING} req.form_parameter ("email") as l_email and then
					attached r.user as l_user
				then
					l_user.set_email (l_email.value)
					a_oauth_api.new_user_oauth2 ("none", "none", l_user, l_consumer.value )
						-- TODO send email?
				end
			end
			r.set_redirection (req.absolute_script_url ("/account"))
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
