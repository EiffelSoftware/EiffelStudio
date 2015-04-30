note
	description: "[
			Message response to redirect client to new location.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_REDIRECTION_RESPONSE_MESSAGE

inherit
	CMS_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (a_location: READABLE_STRING_8)
		do
			initialize
			status_code := {HTTP_STATUS_CODE}.see_other
			header.put_location (a_location)
		end

end
