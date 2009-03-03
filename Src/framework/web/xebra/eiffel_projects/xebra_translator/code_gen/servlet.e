note
	description: "Summary description for {SERVLET}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SERVLET

feature -- Access

	handle_request (request: REQUEST): RESPONSE
			-- handles a request from a client
		deferred
		end

end
