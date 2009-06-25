note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCWC_HTTP_REQUEST

inherit
	XC_WEBAPP_COMMAND

create
	make_with_request


feature {NONE} -- Initialization

	make_with_request (a_request: XH_REQUEST)

		require
			a_request_attached: a_request /= Void
		do
				request := a_request
		ensure
			request_set: equal (request, a_request)
		end


feature -- Access

	request: XH_REQUEST

	description: STRING
			-- <Precursor>
		do
			Result := "Lets the webapp handle a http request."
		end

feature -- Basic operations

	execute (a_webapp: XC_WEBAPP_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_webapp.handle_http_request (request)
		end

invariant
	request_attached: request /= Void
end

