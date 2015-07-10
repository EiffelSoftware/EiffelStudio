﻿note
	description: "Generic OAuth Module supporting authentication using different providers."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_MODULE

inherit
	CMS_MODULE
		rename
			module_api as user_oauth_api
		redefine
			filters,
			register_hooks,
			initialize,
			install,
			user_oauth_api
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
			version := "1.0"
			description := "OAuth20 module"
			package := "authentication"

			add_dependency ({CMS_AUTHENTICATION_MODULE})

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "oauth20"

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			l_user_auth_api: like user_oauth_api
			l_user_auth_storage: CMS_OAUTH_20_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached {CMS_STORAGE_SQL_I} a_api.storage as l_storage_sql then
				create {CMS_OAUTH_20_STORAGE_SQL} l_user_auth_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_OAUTH_20_STORAGE_NULL} l_user_auth_storage
			end

				-- API initialization
			create l_user_auth_api.make_with_storage (a_api, l_user_auth_storage)
			user_oauth_api := l_user_auth_api
		ensure then
			user_oauth_api_set: user_oauth_api /= Void
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			l_consumers: LIST [STRING]
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				if not l_sql_storage.sql_table_exists ("oauth2_consumers") then
					--| Schema
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("oauth2_consumers.sql")), Void)

					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize database for blog module", generating_type)
					end
						-- TODO workaround.
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("oauth2_consumers_initialize.sql")), Void)
				end

					-- TODO workaround, until we have an admin module
				l_sql_storage.sql_query ("SELECT name FROM oauth2_consumers;", Void)
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not initialize database for differnent consumerns", generating_type)
				else
					from
						l_sql_storage.sql_start
						create {ARRAYED_LIST[STRING]} l_consumers.make (2)
					until
						l_sql_storage.sql_after
					loop
						if attached l_sql_storage.sql_read_string (1) as l_name then
							l_consumers.force ("oauth2_" + l_name)
						end
						l_sql_storage.sql_forth
					end
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
				Precursor {CMS_MODULE}(api)
			end
		end

feature {CMS_API} -- Access: API

	user_oauth_api: detachable CMS_OAUTH_20_API
			-- <Precursor>		

feature -- Filters

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
			if attached user_oauth_api as l_user_oauth_api then
				Result.extend (create {CMS_OAUTH_20_FILTER}.make (a_api, l_user_oauth_api))
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

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached user_oauth_api as l_user_oauth_api then
				configure_web (a_api, l_user_oauth_api, a_router)
			end
		end

	configure_web (a_api: CMS_API; a_user_oauth_api: CMS_OAUTH_20_API; a_router: WSF_ROUTER)
		do
			a_router.handle ("/account/roc-oauth-login", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/account/roc-oauth-logout", create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/login-with-oauth/{callback}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_login_with_oauth (a_api,a_user_oauth_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/oauth-callback/{callback}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_callback_oauth (a_api, a_user_oauth_api, ?, ?)), a_router.methods_get_post)
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
			lnk2: detachable CMS_LINK
		do
			if
				attached a_response.current_user (a_response.request) as u and then
				attached {WSF_STRING} a_response.request.cookie ({CMS_OAUTH_20_CONSTANTS}.oauth_session) as l_roc_auth_session_token
			then
				across
					a_menu_system.primary_menu.items as ic
				until
					lnk2 /= Void
				loop
					if ic.item.title.has_substring ("(Logout)") then
						lnk2 := ic.item
					end
				end
				if lnk2 /= Void then
					a_menu_system.primary_menu.remove (lnk2)
				end
				create lnk.make (u.name +  " (Logout)", "account/roc-oauth-logout" )
				a_menu_system.primary_menu.extend (lnk)
			else
				if a_response.location.starts_with ("account/") then
					create lnk.make ("OAuth", "account/roc-oauth-login")
					a_response.add_to_primary_tabs (lnk)
				end
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"login">>
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
				a_response.location.starts_with ("account/roc-oauth-login")
			then
				get_block_view_login (a_block_id, a_response)
			end
		end

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("Login", "optional_content_type")
			r.execute
		end

	handle_logout (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_cookie: WSF_COOKIE
		do
			if
				attached {WSF_STRING} req.cookie ({CMS_OAUTH_20_CONSTANTS}.oauth_session) as l_cookie_token and then
				attached {CMS_USER} current_user (req) as l_user
			then
					-- Logout OAuth
				create l_cookie.make ({CMS_OAUTH_20_CONSTANTS}.oauth_session, l_cookie_token.value)
				l_cookie.set_path ("/")
				l_cookie.set_max_age (-1)
				res.add_cookie (l_cookie)
				unset_current_user (req)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
				r.set_redirection (req.absolute_script_url (""))
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
				if
					attached user_oauth_api as l_auth_api and then
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
				attached {WSF_STRING} req.path_parameter ({CMS_OAUTH_20_CONSTANTS}.oauth_callback) as p_consumer and then
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

	handle_callback_oauth (api: CMS_API; a_user_oauth_api: CMS_OAUTH_20_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_auth: CMS_OAUTH_20_WORKFLOW
			l_user_api: CMS_USER_API
			l_user: CMS_USER
			l_roles: LIST [CMS_USER_ROLE]
			l_cookie: WSF_COOKIE
			es: CMS_AUTHENTICATON_EMAIL_SERVICE
		do
			if  attached {WSF_STRING} req.path_parameter ({CMS_OAUTH_20_CONSTANTS}.oauth_callback) as l_callback and then
			    attached {CMS_OAUTH_20_CONSUMER} a_user_oauth_api.oauth_consumer_by_callback (l_callback.value) as l_consumer and then
				attached {WSF_STRING} req.query_parameter ({CMS_OAUTH_20_CONSTANTS}.oauth_code) as l_code
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
							if	attached a_user_oauth_api.user_oauth2_by_id (p_user.id, l_consumer.name)	then
									-- Update oauth entry
								a_user_oauth_api.update_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_consumer.name )
							else
									-- create a oauth entry
								a_user_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile, p_user, l_consumer.name )
							end
							create l_cookie.make ({CMS_OAUTH_20_CONSTANTS}.oauth_session, l_access_token.token)
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
							a_user_oauth_api.new_user_oauth2 (l_access_token.token, l_user_profile, l_user, l_consumer.name )
							create l_cookie.make ({CMS_OAUTH_20_CONSTANTS}.oauth_session, l_access_token.token)
							l_cookie.set_max_age (l_access_token.expires_in)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)
							set_current_user (req, l_user)


									-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle_callback_oauth: send_contact_welcome_email")
							es.send_contact_welcome_email (l_email, "")
						end
					end
					r.set_redirection (r.front_page_url)
					r.execute
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
