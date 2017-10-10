note
	description: "Summary description for {JWT_AUTH_MODULE_WEBAPI}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [JWT_AUTH_MODULE]
		redefine
			permissions,
			setup_hooks,
			filters
		end

	CMS_HOOK_WEBAPI_RESPONSE_ALTER

	CMS_HOOK_AUTO_REGISTER

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached module.jwt_auth_api as l_jwt_auth_api then
				a_router.handle ("/user/{uid}/jwt_access_token", create {JWT_AUTH_TOKEN_WEBAPI_HANDLER}.make (l_jwt_auth_api), a_router.methods_get_post)
			end
		end

feature -- Permissions

	permissions: LIST [READABLE_STRING_8]
		do
			Result := Precursor
			Result.force (perm_use_jwt_auth)
		end

	perm_use_jwt_auth: STRING = "use jwt_auth"

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached module.jwt_auth_api as jwt_auth_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {JWT_AUTH_TOKEN_WEBAPI_FILTER}.make (a_api, jwt_auth_api))
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_webapi_response_alter_hook (Current)
		end

feature -- Hook

	webapi_response_alter (rep: WEBAPI_RESPONSE)
		do
			if
				attached rep.user as u and then
				attached {HM_WEBAPI_RESPONSE} rep as hm and then
				rep.is_root
			then
				hm.add_link ("jwt:access_token", Void, rep.api.webapi_path ("user/" + u.id.out + "/jwt_access_token"))
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
