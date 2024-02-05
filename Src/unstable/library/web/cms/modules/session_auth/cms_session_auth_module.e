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
			permissions,
			has_permission_to_use_authentication,
			session_api
		end

	CMS_WITH_WEBAPI

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTHENTICATION

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

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_use_session_auth)
		end

	perm_use_session_auth: STRING = "use session_auth"

	has_permission_to_use_authentication (api: CMS_API): BOOLEAN
		do
			Result := api.has_permission (perm_use_session_auth)
			if not Result then
				Result := attached api.setup.text_item ("modules." + name + ".login") as s and then s.is_case_insensitive_equal ("on")
			end
		end

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
					api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
				else
					Precursor {CMS_AUTH_MODULE_I} (api) -- Mark it as installed.
					if attached api.user_api.anonymous_user_role as ano then
						ano.add_permission (perm_use_session_auth)
						api.user_api.save_user_role (ano)
					end
				end
			end
		end

feature {CMS_EXECUTION} -- Administration

	webapi: CMS_SESSION_AUTH_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

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
				attached session_api as l_session_api
			then
				Result := l_session_api.is_authenticating (a_response)
			end
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached session_api as l_session_api then
				a_router.handle ("/" + login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + logout_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, l_session_api, ?, ?)), a_router.methods_get_post)
				a_router.handle ("/" + login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login_with_session (a_api, l_session_api, ?, ?)), a_router.methods_post)
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
					l_tpl_block.set_value (api.site_url, "site_url")
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
		do
			if attached api.user as l_user then
				a_session_api.process_user_logout (l_user, req, res)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			else
					-- Not loggued in ... redirect to home
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
			end
			if attached api.logout_destination_location (req) as v then
				r.set_redirection (secured_url_content (v))
			elseif attached api.destination_location (req) as v then
				r.set_redirection (secured_url_content (v))
			else
				r.set_redirection (r.absolute_url ("", Void))
			end

			r.execute
		end

	handle_login_with_session (api: CMS_API; a_session_api: CMS_SESSION_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_username_or_email, l_password: detachable READABLE_STRING_GENERAL
			l_user: detachable CMS_USER
		do
			if
				attached {WSF_STRING} req.form_parameter ("username") as p_username and then
				attached {WSF_STRING} req.form_parameter ("password") as p_password
			then
				l_username_or_email := p_username.value
				l_password := p_password.value
				l_user := api.user_api.user_with_credential (l_username_or_email, l_password)
				if l_user /= Void then
					if not l_user.is_active or attached {CMS_TEMP_USER} l_user as l_temp_user then
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						if attached smarty_template_login_block (req, Current, "login", api) as l_tpl_block then
							l_tpl_block.set_value (l_username_or_email, "username")
							l_tpl_block.set_value ("Error: the account is inactive, or not yet validated!", "error")
							r.add_block (l_tpl_block, "content")
						end
					else
						a_session_api.process_user_login (l_user, req, res)
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						if attached api.destination_location (req) as v then
							r.set_redirection (secured_url_content (v))
						else
							r.set_redirection ("")
						end
					end
				else
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					if attached smarty_template_login_block (req, Current, "login", api) as l_tpl_block then
						l_tpl_block.set_value (l_username_or_email, "username")
						l_tpl_block.set_value ("Wrong username or password ", "error")
						r.add_block (l_tpl_block, "content")
					end
				end
				r.execute
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				if attached smarty_template_login_block (req, Current, "login", api) as l_tpl_block then
					if attached {WSF_STRING} req.form_parameter ("username") as p_username then
						l_tpl_block.set_value (p_username.value, "username")
					end
					l_tpl_block.set_value ("Wrong username or password ", "error")
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
			a_hooks.subscribe_to_hook (Current, {CMS_HOOK_AUTHENTICATION})
		end

feature -- Hooks

	get_login_redirection (a_response: CMS_RESPONSE; a_destination_url: detachable READABLE_STRING_8)
		local
			loc: READABLE_STRING_8
		do
			if has_permission_to_use_authentication (a_response.api) then
				loc := a_response.redirection
				if loc = Void or else loc.has_substring ("basic") then
					if a_destination_url /= Void then
						a_response.set_redirection (login_location + "?destination=" + secured_url_content (a_destination_url))
					else
						a_response.set_redirection (login_location)
					end
				end
			end
		end

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

end
