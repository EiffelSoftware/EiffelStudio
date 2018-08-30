note
	description: "Summary description for {CMS_SESSION_AUTH_MODULE_WEBAPI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [CMS_SESSION_AUTH_MODULE]
		redefine
			filters,
			permissions
		end

create
	make

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_use_webapi_session_auth)
		end

	perm_use_webapi_session_auth: STRING = "use webapi session_auth"

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached {CMS_SESSION_API} module_api as l_session_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {CMS_SESSION_WEBAPI_AUTH_FILTER}.make (a_api, l_session_api))
			end
		end

end
