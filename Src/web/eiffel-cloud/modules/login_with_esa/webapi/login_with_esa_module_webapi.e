note
	description: "Summary description for {LOGIN_WITH_ESA_MODULE_WEBAPI}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [LOGIN_WITH_ESA_MODULE]
		redefine
			permissions,
			filters,
			setup_hooks
		end

	CMS_HOOK_WEBAPI_RESPONSE_ALTER

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			l_reg: LOGIN_WITH_ESA_REGISTER_WEBAPI_HANDLER
		do
			if attached module.login_with_esa_api as l_esa_api then
				create l_reg.make_with_esa_api (l_esa_api)
				a_router.handle ("/esa/register", l_reg, a_router.methods_get_post)
			end
		end

feature -- Permissions

	permissions: LIST [READABLE_STRING_8]
		do
			Result := Precursor
			Result.force (module.perm_use_login_with_esa)
			Result.force (module.perm_register_with_esa)
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached module.login_with_esa_api as l_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {LOGIN_WITH_ESA_WEBAPI_FILTER}.make (a_api, l_api))
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_webapi_response_alter_hook (Current)
		end

feature -- Hook

	webapi_response_alter (a_response: WEBAPI_RESPONSE)
		do
			if
				attached {HM_WEBAPI_RESPONSE} a_response as hm and then
				a_response.is_root
			then
				hm.add_link ("esa:register", Void, a_response.api.webapi_path ("esa/register"))
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
