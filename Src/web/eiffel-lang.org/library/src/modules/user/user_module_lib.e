note
	description: "Summary description for {USER_MODULE_LIB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	USER_MODULE_LIB

inherit
	CMS_COMMON_API

	CMS_EXECUTION

feature -- Initialization	

	initialize_primary_tabs (u: detachable CMS_USER)
		do
			if u /= Void then
				primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("View", "/user/" + u.id.out))
				primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Edit", "/user/" + u.id.out + "/edit"))
			else
				primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Create new account", "/user/register"))
				primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Log in", "/user"))
				primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Request new password", "/user/password"))
			end
		end

end
