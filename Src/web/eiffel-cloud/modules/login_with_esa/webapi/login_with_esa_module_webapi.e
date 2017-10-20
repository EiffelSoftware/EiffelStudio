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
			filters
		end

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
		end

feature -- Permissions

	permissions: LIST [READABLE_STRING_8]
		do
			Result := Precursor
			Result.force (module.perm_use_login_with_esa)
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

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
