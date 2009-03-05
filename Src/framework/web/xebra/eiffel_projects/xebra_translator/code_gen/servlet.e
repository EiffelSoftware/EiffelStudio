note
	description: "The {SERVLET} handles a page request."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SERVLET

feature -- Access

	handle_request (request: REQUEST): RESPONSE
			-- Handles a request from a client.
		deferred
		end

end
