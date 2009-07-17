note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_HTTP_REQUEST

inherit
	XC_COMMAND_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_response: XH_RESPONSE)
			-- Initialization for `Current'.
		require
			a_response_attached: a_response /= Void
		do
			response := a_response
		ensure
			response_set: equal (response, a_response)
		end

feature -- Access

	response: XH_RESPONSE

invariant
	response_attached: response /= Void
end

