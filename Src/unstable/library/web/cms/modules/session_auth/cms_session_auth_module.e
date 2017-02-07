note
	description: "[
			This module allows the use Session Based Authentication using Cookies to restrict access
			by looking up users in the given providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_MODULE

inherit
	CMS_AUTH_MODULE_I
		rename
			module_api as session_api
		redefine
			make,
			filters,
			setup_hooks,
			initialize,
			install,
			session_api
		end

	CMS_HOOK_BLOCK

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			version := "1.0"
			description := "Service to manage cookie based authentication"
			enable -- Enabled by default
		end

feature -- Access

	name: STRING = "session_auth"

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			l_session_auth_api: like session_api
			l_session_auth_storage: CMS_SESSION_AUTH_STORAGE_I
		do
			Precursor (a_api)

					-- Storage initialization
			if attached a_api.storage.as_sql_storage as l_storage_sql then
				create {CMS_SESSION_AUTH_STORAGE_SQL} l_session_auth_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_SESSION_AUTH_STORAGE_NULL} l_session_auth_storage
			end

				-- API initialization
			create l_session_auth_api.make_with_storage (a_api, l_session_auth_storage)
			session_api := l_session_auth_api
		ensure then
			session_auth_api_set: session_api /= Void
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
			if attached api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
					Precursor {CMS_AUTH_MODULE_I} (api) -- Mark it as installed.
				end
			end
		end

feature {CMS_API} -- Access: API

	session_api: detachable CMS_SESSION_API
			-- <Precursor>	

feature -- Access: auth strategy	

	login_title: STRING = "Session"
			-- Module specific login title.

	login_location: STRING = "account/auth/roc-session-login"

	logout_location: STRING = "account/auth/roc-session-logout"

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
			-- <Precursor>
		do
			if
				a_response.is_authenticated and then
				attached session_api as l_session_api and then
				attached a_response.request.cookie (l_session_api.session_token)
			then
				Result := True
			end
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached session_api as l_session_api then
				a_router.handle ("/" + login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + logout_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, l_session_api, ?, ?)), a_router.methods_get_post)
				a_router.handle ("/" + login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login_with_session (a_api,session_api, ?, ?)), a_router.methods_post)
			end
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached session_api as l_session_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {CMS_SESSION_AUTH_FILTER}.make (a_api, l_session_api))
			end
		end

feature {NONE} -- Implementation: routes

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			vals: CMS_VALUE_TABLE
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if api.user_is_authenticated then
				r.add_error_message ("You are already signed in!")
			else
				if attached smarty_template_login_block (req, Current, "login", api) as l_tpl_block then
					create vals.make (1)
						-- add the variable to the block
					l_tpl_block.set_value (api.user, "user")
					l_tpl_block.set_value (r.url ("", Void), "site_url")
					api.hooks.invoke_value_table_alter (vals, r)
					across
						vals as ic
					loop
						l_tpl_block.set_value (ic.item, ic.key)
					end
					r.add_block (l_tpl_block, "content")
				else
					r.add_error_message ("Error: missing block [login]")
				end
			end
			r.execute
		end

	handle_logout (api: CMS_API; a_session_api: CMS_SESSION_API ; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_cookie: WSF_COOKIE
			tok: STRING
		do
			tok := a_session_api.session_token
			if
				attached {WSF_STRING} req.cookie (tok) as l_cookie_token and then
				attached api.user as l_user
			then
					-- Logout Session
				create l_cookie.make (tok, "") -- l_cookie_token.value) -- FIXME: unicode issue?
				l_cookie.set_path ("/")
				l_cookie.unset_max_age
				l_cookie.set_expiration_date (create {DATE_TIME}.make_from_epoch (0))
				res.add_cookie (l_cookie)
				api.unset_user

				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
				r.set_redirection (req.absolute_script_url (""))
				r.execute
			else
				fixme (generator + ": missing else implementation in handle_logout!")
			end
		end

	handle_login_with_session (api: CMS_API; a_session_api: detachable CMS_SESSION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_token: STRING
			l_cookie: WSF_COOKIE
		do
			if
				attached a_session_api as l_session_api and then
				attached {WSF_STRING} req.form_parameter ("username") as l_username and then
				attached {WSF_STRING} req.form_parameter ("password") as l_password
			then
				if
					api.user_api.is_valid_credential (l_username.value, l_password.value) and then
					attached api.user_api.user_by_name (l_username.value) as l_user
				then
					l_token := generate_token
					if a_session_api.has_user_token (l_user) then
						l_session_api.update_user_session_auth (l_token, l_user)
					else
						l_session_api.new_user_session_auth (l_token, l_user)
					end
					create l_cookie.make (a_session_api.session_token, l_token)
					l_cookie.set_max_age (a_session_api.session_max_age)
					l_cookie.set_path ("/")
					res.add_cookie (l_cookie)
					api.set_user (l_user)
					api.record_user_login (l_user)

					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					if
						attached {WSF_STRING} req.item ("destination") as p_destination and then
						attached p_destination.value as v and then
						v.is_valid_as_string_8
					then
						r.set_redirection (v.to_string_8)
					else
						r.set_redirection ("")
					end
				else
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					if attached smarty_template_login_block (req, Current, "login", api) as l_tpl_block then
						l_tpl_block.set_value (l_username.value, "username")
						l_tpl_block.set_value ("Wrong: Username or password ", "error")
						r.add_block (l_tpl_block, "content")
					end
				end
				r.execute
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				if attached smarty_template_login_block (req, Current, "login", api) as l_tpl_block then
					if attached {WSF_STRING} req.form_parameter ("username") as l_username then
						l_tpl_block.set_value (l_username.value, "username")
					end
					l_tpl_block.set_value ("Wrong: Username or password ", "error")
					r.add_block (l_tpl_block, "content")
				end
				r.execute
			end
		end

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
			Result := <<"?login">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("login") then
				get_block_view_login (a_block_id, a_response)
			end
		end

feature {NONE} -- Block views

	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			vals: CMS_VALUE_TABLE
		do
			if attached smarty_template_login_block (a_response.request, Current, a_block_id, a_response.api) as l_tpl_block then
				create vals.make (1)
					-- add the variable to the block
				a_response.api.hooks.invoke_value_table_alter (vals, a_response)
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

	generate_token: STRING
			-- Generate token to use in a Session.
		local
			l_token: STRING
			l_security: CMS_TOKEN_GENERATOR
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

end
