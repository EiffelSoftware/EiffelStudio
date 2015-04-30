note
	description: "[
			Message response to notify a forbidden access.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORBIDDEN_RESPONSE_MESSAGE

inherit
	CMS_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
			status_code := {HTTP_STATUS_CODE}.forbidden
		end

end
