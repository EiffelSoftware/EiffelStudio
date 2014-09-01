note
	description: "Summary description for {CMS_AUTH_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_AUTH_ENGINE

feature -- Status

	valid_credential (u,p: READABLE_STRING_32): BOOLEAN
		deferred
		end

end
