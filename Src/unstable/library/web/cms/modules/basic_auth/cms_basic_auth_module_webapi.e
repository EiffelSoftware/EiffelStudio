note
	description: "Summary description for {CMS_BASIC_AUTH_MODULE_WEBAPI}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BASIC_AUTH_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [CMS_BASIC_AUTH_MODULE]
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
			Result.force (perm_use_webapi_basic_auth)
		end

	perm_use_webapi_basic_auth: STRING = "use webapi basic_auth"

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
			Result.extend (create {CMS_BASIC_WEBAPI_AUTH_FILTER}.make (a_api))
		end
note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
