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
	CMS_MODULE
		rename
			module_api as session_api
		redefine
			filters,
			setup_hooks,
			initialize,
			install,
			session_api
		end


	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_BLOCK

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_VALUE_TABLE_ALTER

	SHARED_LOGGER

	CMS_REQUEST_UTIL

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Service to manage cookie based authentication"
			package := "authentication"
			add_dependency ({CMS_AUTHENTICATION_MODULE})
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
					Precursor {CMS_MODULE} (api) -- Mark it as installed.
				end
			end
		end

feature {CMS_API} -- Access: API

	session_api: detachable CMS_SESSION_API
			-- <Precursor>		

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached session_api as l_session_api then
				a_router.handle ("/account/roc-session-login", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/account/roc-session-logout", create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, l_session_api, ?, ?)), a_router.methods_get_post)
				a_router.handle ("/account/login-with-session", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_login_with_session (a_api,session_api, ?, ?)), a_router.methods_get_post)
			end
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
			if attached session_api as l_session_api then
				Result.extend (create {CMS_SESSION_AUTH_FILTER}.make (a_api, l_session_api))
			end
		end

feature {NONE} -- Implementation: routes

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
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
				attached {CMS_USER} current_user (req) as l_user
			then
					-- Logout Session
				create l_cookie.make (tok, l_cookie_token.value) -- FIXME: unicode issue?
				l_cookie.set_path ("/")
				l_cookie.set_max_age (-1)
				res.add_cookie (l_cookie)
				unset_current_user (req)

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
				attached {WSF_STRING} req.form_parameter ("password") as l_password and then
				api.user_api.is_valid_credential (l_username.value, l_password.value) and then
				attached api.user_api.user_by_name (l_username.value) as l_user
			then
				l_token := generate_token
				if
					a_session_api.has_user_token (l_user)
				then
					l_session_api.update_user_session_auth (l_token, l_user)
				else
					l_session_api.new_user_session_auth (l_token, l_user)
				end
				create l_cookie.make (a_session_api.session_token, l_token)
				l_cookie.set_max_age (a_session_api.session_max_age)
				l_cookie.set_path ("/")
				res.add_cookie (l_cookie)
				set_current_user (req, l_user)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_redirection (req.absolute_script_url (""))
				r.execute
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				if attached template_block ("login", r) as l_tpl_block then
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
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
			a_hooks.subscribe_to_value_table_alter_hook (Current)
		end

feature -- Hooks

	value_table_alter (a_value: CMS_VALUE_TABLE; a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			if
				attached a_response.user as u and then
				attached session_api as l_session_api and then
				attached a_response.request.cookie (l_session_api.session_token)
			then
				a_value.force ("account/roc-session-logout", "auth_login_strategy")
			end
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
			lnk2: detachable CMS_LINK
		do
			if attached a_response.user as u then
				if
					attached session_api as l_session_api and then
					attached a_response.request.cookie (l_session_api.session_token)
				then
					across
						a_menu_system.primary_menu.items as ic
					until
						lnk2 /= Void
					loop
						if
							ic.item.location.same_string ("account/roc-logout")
						 	or else ic.item.location.same_string ("basic_auth_logoff")
						 then
							lnk2 := ic.item
						end
					end
					if lnk2 /= Void then
						a_menu_system.primary_menu.remove (lnk2)
					end
					create lnk.make ("Logout", "account/roc-session-logout" )
					a_menu_system.primary_menu.extend (lnk)
				end
			elseif a_response.location.starts_with ("account/") then
				create lnk.make ("Session", "account/roc-session-login")
				a_response.add_to_primary_tabs (lnk)
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
				a_response.location.starts_with ("account/roc-session-login")
			then
				get_block_view_login (a_block_id, a_response)
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
