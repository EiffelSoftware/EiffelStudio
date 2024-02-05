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
		local
			h: JWT_AUTH_TOKEN_WEBAPI_HANDLER
			h_si: JWT_AUTH_SIGN_IN_WEBAPI_HANDLER
		do
			if attached module.jwt_auth_api as l_jwt_auth_api then
				create h.make (Current, l_jwt_auth_api)
				a_router.handle ("/user/{uid}/jwt_access_token", h, a_router.methods_get_post)
				a_router.handle ("/user/{uid}/new_jwt_magic_link", h, a_router.methods_get_post)

				create h_si.make (Current, l_jwt_auth_api)
				a_router.handle ("/auth/client-sign-in/", h_si, a_router.methods_post)
				a_router.handle ("/auth/client-sign-in/{challenge}", h_si, a_router.methods_post)
			end
		end

feature -- Permissions

	permissions: LIST [READABLE_STRING_8]
		do
			Result := Precursor
			Result.force (perm_use_jwt_auth)
			Result.append (module.permissions)
		end

	perm_use_jwt_auth: STRING = "use jwt_auth"

feature -- Link factory

	client_sign_in_request_link (a_api: CMS_API; a_challenge: JWT_AUTH_SIGN_IN_CHALLENGE): STRING_8
		do
			Result := a_api.webapi_path ("/auth/client-sign-in/" + percent_encoded (a_challenge.challenge))
		end

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
				attached {HM_WEBAPI_RESPONSE} rep as hm and then
				rep.is_root
			then
				if attached rep.user as u then
					hm.add_link ("jwt:access_token", Void, rep.api.webapi_path ("user/" + u.id.out + "/jwt_access_token"))
					if
						not rep.api.user_is_administrator and then -- Forbid this magic link for administrator! (security)
						rep.has_permission ({JWT_AUTH_MODULE}.perm_use_magic_login)
					then
						hm.add_link ("jwt:new_magic_login", Void, rep.api.webapi_path ("user/" + u.id.out + "/new_jwt_magic_link"))
					end
				end
--				if rep.has_permission ({JWT_AUTH_MODULE}.perm_use_client_sign_in) then
					hm.add_link ("jwt:client_sign_in", Void, rep.api.webapi_path ("auth/client-sign-in/"))
--				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
