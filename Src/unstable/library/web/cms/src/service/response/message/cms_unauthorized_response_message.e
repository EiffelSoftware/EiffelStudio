note
	description: "[
			Message response to notify an unauthorized access.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_UNAUTHORIZED_RESPONSE_MESSAGE

inherit
	CMS_RESPONSE_MESSAGE

create
	make,
	make_with_basic_auth_challenge

feature {NONE} -- Initialization

	make
		do
			initialize
			status_code := {HTTP_STATUS_CODE}.unauthorized
		end

	make_with_basic_auth_challenge (a_realm: detachable READABLE_STRING_8)
		local
			l_realm: READABLE_STRING_8
		do
			make
			if a_realm /= Void then
				l_realm := a_realm
			else
				l_realm := default_realm
			end
			header.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%""+ l_realm +"%"")
		end

feature -- Access		

	default_realm: STRING = "CMS-User credential"

end
