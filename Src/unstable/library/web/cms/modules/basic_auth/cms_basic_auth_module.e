note
	description: "[
			This module allows the use of HTTP Basic Authentication to restrict access
			by looking up users in the given providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BASIC_AUTH_MODULE

inherit
	CMS_MODULE
		redefine
			filters,
			register_hooks
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
			description := "Service to manage basic authentication"
			package := "authentication"
			add_dependency ({CMS_AUTHENTICATION_MODULE})
		end

feature -- Access

	name: STRING = "basic_auth"

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			configure_api_login (a_api, a_router)
			configure_api_logoff (a_api, a_router)
			a_router.handle ("/account/roc-basic-auth", create {WSF_URI_AGENT_HANDLER}.make (agent handle_login_basic_auth (a_api, ?, ?)), a_router.methods_head_get)
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (2)
			Result.extend (create {CMS_CORS_FILTER})
			Result.extend (create {CMS_BASIC_AUTH_FILTER}.make (a_api))
		end

feature {NONE} -- Implementation: routes

	configure_api_login (api: CMS_API; a_router: WSF_ROUTER)
		local
			l_bal_handler: CMS_BASIC_AUTH_LOGIN_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_bal_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle ("/basic_auth_login", l_bal_handler, l_methods)
		end

	configure_api_logoff (api: CMS_API; a_router: WSF_ROUTER)
		local
			l_bal_handler: CMS_BASIC_AUTH_LOGOFF_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_bal_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle ("/basic_auth_logoff", l_bal_handler, l_methods)
		end


	handle_login_basic_auth (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("Basic Auth", "optional_content_type")
			r.execute
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
			a_value.force ("basic_auth_logoff", "strategy")
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
			lnk2: detachable CMS_LINK
		do
			if attached a_response.current_user (a_response.request) as u then
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

				create lnk.make (u.name +  " (Logout)", "basic_auth_logoff" )
				lnk.set_weight (98)
				a_menu_system.primary_menu.extend (lnk)
			else
				if a_response.location.starts_with ("account/") then
					create lnk.make ("Basic Auth", "account/roc-basic-auth")
					lnk.set_expandable (True)
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
				a_response.location.starts_with ("account/roc-basic-auth")
			then
				a_response.add_javascript_url (a_response.url ("module/" + name + "/files/js/roc_basic_auth.js", Void))
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

end
