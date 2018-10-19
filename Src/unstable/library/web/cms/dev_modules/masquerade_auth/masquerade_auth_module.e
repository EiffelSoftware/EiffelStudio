note
	description: "[
			This module allows the use Session Based Authentication using Cookies to restrict access
			by looking up users in the given providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MASQUERADE_AUTH_MODULE

inherit
	CMS_AUTH_MODULE_I
		rename
			module_api as masquerade_api
		redefine
			make,
			setup_hooks,
			initialize,
			install,
			permissions,
			masquerade_api,
			menu_system_alter,
			has_permission_to_use_authentication
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			version := "1.0"
			description := "Service to easily log as user at development time"
			package := "debug"
			disable -- Disabled by default
			add_dependency ({CMS_SESSION_AUTH_MODULE})
		end

feature -- Access

	name: STRING = "masquerade_auth"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.extend (perm_masquerade)
		end

	perm_masquerade: STRING = "masquerade"

	has_permission_to_use_authentication (api: CMS_API): BOOLEAN
		do
			Result := api.has_permission (perm_masquerade)
		end

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		do
			Precursor (a_api)

			if attached {CMS_SESSION_API} a_api.module_api ({CMS_SESSION_AUTH_MODULE}) as l_session_api then
					-- API initialization
				create masquerade_api.make_with_session_api (a_api, l_session_api)
			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
			Precursor {CMS_AUTH_MODULE_I} (api) -- Mark it as installed.
		end

feature {CMS_API} -- Access: API

	masquerade_api: detachable MASQUERADE_API
			-- <Precursor>	

feature -- Access: auth strategy	

	login_title: STRING = "Masquerade"
			-- Module specific login title.

	login_location: STRING = "account/auth/roc-masquerade-login"

	logout_location: STRING = "account/auth/roc-masquerade-logout"

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
			-- <Precursor>
		do
			if attached masquerade_api as l_masquerade_api then
				Result := l_masquerade_api.is_authenticating (a_response)
			end
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached masquerade_api as l_masquerade_api then
				a_router.handle ("/" + login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + logout_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, l_masquerade_api, ?, ?)), a_router.methods_get_post)
				a_router.handle ("/" + login_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_login_with_masquerade (a_api, l_masquerade_api,?, ?)), a_router.methods_post)
			end
		end

feature {NONE} -- Implementation: routes

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if
				attached masquerade_api as l_masquerade_api and then
				l_masquerade_api.has_permission_to_masquerade (api.user)
			then
				if api.user_is_authenticated then
					r.add_warning_message ("You are signed.")
				end
				r.add_block (login_block ("login", Void, r), "content")
			else
				r.add_error_message ("You are not allowed to use masquerade authentication!")
			end
			r.execute
		end

	handle_logout (api: CMS_API; a_masquerade_api: MASQUERADE_API ; req: WSF_REQUEST; res: WSF_RESPONSE)		local
			r: CMS_RESPONSE
		do
			if attached api.user as l_user then
				a_masquerade_api.process_user_logout (l_user, req, res)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			else
					-- Not loggued in ... redirect to home
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
			end
			if
				attached {WSF_STRING} req.item ("destination") as p_destination and then
				attached p_destination.value as v and then
				v.is_valid_as_string_8
			then
				r.set_redirection (secured_html_content (v.to_string_8))
			else
				r.set_redirection (req.absolute_script_url (""))
			end

			r.execute
		end

	handle_login_with_masquerade (api: CMS_API; a_masquerade_api: MASQUERADE_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if a_masquerade_api.has_permission_to_masquerade (api.user) then
				if
					attached {WSF_STRING} req.form_parameter ("username") as l_username
				then
					if
						attached api.user_api.user_by_name (l_username.value) as l_user
					then
						a_masquerade_api.process_user_login (l_user, req, res)

						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						if
							attached {WSF_STRING} req.item ("destination") as p_destination and then
							attached p_destination.value as v and then
							v.is_valid_as_string_8
						then
							r.set_redirection (secured_html_content (v.to_string_8))
						else
							r.set_redirection ("")
						end
					else
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						r.add_block (login_block ("login", Void, r), "content")
					end
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.add_block (login_block ("login", "Wrong username", r), "content")
				end
				r.execute
			else
				api.response_api.send_access_denied (Void, req, res)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			Precursor (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"?login">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("login") then
				a_response.add_block (login_block (a_block_id, Void, a_response), "content")
			end
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			u: detachable CMS_USER
		do
			u := a_response.api.user
			if
				attached masquerade_api as l_masquerade_api and then
				l_masquerade_api.has_permission_to_masquerade (u)
			then
				Precursor (a_menu_system, a_response)
				if u /= Void then
					a_menu_system.navigation_menu.extend (a_response.local_link ("Masquerade", login_location))
				end
			end
		end

feature {NONE} -- Block views

	login_block (a_block_id: READABLE_STRING_8; a_err: detachable READABLE_STRING_8; a_response: CMS_RESPONSE): CMS_CONTENT_BLOCK
		do
			create Result.make (a_block_id, Void, login_html (a_err, a_response), Void)
		end

	login_html (a_err: detachable READABLE_STRING_8; a_response: CMS_RESPONSE): STRING
		local
			params: CMS_DATA_QUERY_PARAMETERS
			u: CMS_USER
		do
			create Result.make_from_string ("<div class=%"login-box%">")
			if a_err /= Void then
				Result.append ("<div class=%"error%">")
				Result.append (a_err)
				Result.append ("</div>")
			end
			Result.append ("<form name=%"masquerade_auth%" action=%"" + a_response.site_url + login_location + "%" method=%"POST%">%N")
			Result.append ("<div><input type=%"text%" name=%"username%" id=%"username%" required value=%"%"><label>Username</label></div>")
			Result.append ("<button type=%"submit%">Login</button>")

			create params.make (0, a_response.api.user_api.users_count.as_natural_32)
			across
				a_response.api.user_api.recent_users (params) as ic
			loop
				u := ic.item
				Result.append ("<li>")
				Result.append (a_response.html_encoded (a_response.api.user_display_name (u)))
				Result.append ("</li>%N")
			end
			Result.append ("</form></div>")
		end

end
