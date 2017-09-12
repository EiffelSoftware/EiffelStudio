note
	description: "Summary description for {CMS_CORE_MODULE_WEBAPI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CORE_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [CMS_CORE_MODULE]
		redefine
			permissions,
			filters
		end

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin users")
			Result.force ("view users")
		end

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			l_root: CMS_ROOT_WEBAPI_HANDLER
		do
			create l_root.make (a_api)
			a_router.handle ("", l_root, a_router.methods_get)
			a_router.handle ("/", l_root, a_router.methods_get)
			a_router.handle ("/user/{uid}/access_token", create {CMS_ACCESS_TOKEN_WEBAPI_HANDLER}.make (a_api), a_router.methods_get_post)
			a_router.handle ("/user/{uid}", create {CMS_USER_WEBAPI_HANDLER}.make (a_api), a_router.methods_get)
			a_router.handle ("/user/", create {CMS_USERS_WEBAPI_HANDLER}.make (a_api), a_router.methods_get_post)
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (2)
			Result.extend (create {CMS_ACCESS_TOKEN_WEBAPI_AUTH_FILTER}.make (a_api))
			Result.extend (create {CMS_BASIC_WEBAPI_AUTH_FILTER}.make (a_api))
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
