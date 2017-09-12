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
			Result.force ("account register")
		end

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached module.auth_api as l_auth_api then
				a_router.handle ("/account/register", create {CMS_USER_REGISTER_WEBAPI_HANDLER}.make_with_auth_api (l_auth_api), a_router.methods_post)
			end
		end

end
