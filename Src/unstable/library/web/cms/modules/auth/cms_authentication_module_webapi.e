note
	description: "Summary description for {CMS_AUTHENTICATION_MODULE_WEBAPI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [CMS_AUTHENTICATION_MODULE]
		redefine
			permissions
		end

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin users")
		end

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/info", create {WSF_URI_AGENT_HANDLER}.make (agent handle_info (?, ?, a_api)), a_router.methods_get)
		end

feature -- Request handling

	handle_info (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			m: WSF_HTML_PAGE_RESPONSE
		do
			create m.make
			m.set_body ("{%"info%":%"" + api.setup.site_name + "%"}")
			res.send (m)
		end

end
