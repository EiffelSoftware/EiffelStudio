note
	description: "[
			This module allows the use of HTTP Basic Authentication to restrict access
			by looking up users in the given providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_AUTH_MODULE

inherit
	CMS_MODULE
		redefine
			filters,
			register_hooks
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_BLOCK

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "basic auth"
			version := "1.0"
			description := "Service to manage basic authentication"
			package := "core"
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			configure_api_login (a_api, a_router)
			configure_api_logoff (a_api, a_router)
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (2)
			Result.extend (create {CORS_FILTER})
			Result.extend (create {BASIC_AUTH_FILTER}.make (a_api))
		end

feature {NONE} -- Implementation: routes

	configure_api_login (api: CMS_API; a_router: WSF_ROUTER)
		local
			l_bal_handler: BASIC_AUTH_LOGIN_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_bal_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle_with_request_methods ("/basic_auth_login", l_bal_handler, l_methods)
		end

	configure_api_logoff (api: CMS_API; a_router: WSF_ROUTER)
		local
			l_bal_handler: BASIC_AUTH_LOGOFF_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_bal_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle_with_request_methods ("/basic_auth_logoff", l_bal_handler, l_methods)
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
--			a_response.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
		do
			Result := <<"basic_auth_login_form">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
			-- Get block object identified by `a_block_id' and associate with `a_response'.
		do
			if a_block_id.same_string ("basic_auth_login_form") then

			end
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached a_response.current_user (a_response.request) as u then
				create lnk.make (u.name +  " (Logout)", "basic_auth_logoff?destination=" + a_response.request.request_uri)
			else
				create lnk.make ("Login", "basic_auth_login?destination=" + a_response.request.request_uri)
			end
--			if not a_menu_system.primary_menu.has (lnk) then
				lnk.set_weight (99)
				a_menu_system.primary_menu.extend (lnk)
--			end
		end


end
