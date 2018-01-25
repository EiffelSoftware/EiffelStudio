note
	description: "Summary description for {SSL_MODE_WITH_AUTHENTICATION_TAG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_MODE_WITH_AUTHENTICATION_TAG

feature -- Access

	tag: detachable MANAGED_POINTER
			-- The value of the tag supplied to the constructor of this mode.
		note
			option: stable
		attribute
		end
		
end
