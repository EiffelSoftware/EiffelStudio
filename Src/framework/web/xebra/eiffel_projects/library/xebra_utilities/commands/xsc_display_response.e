note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_DISPLAY_RESPONSE

inherit
	XS_COMMAND

create
	make_with_response

feature {NONE} -- Initialization

	make_with_response (a_response: XH_RESPONSE)
			-- Initialization for `Current'.
		require
			a_response_Attached: a_response /= Void
		do
			response := a_response
		ensure
			response_attached: response /= Void
		end

feature -- Basic operations

	response: XH_RESPONSE

	execute (a_server: XSC_SERVER_INTERFACE)
			-- <Precursor>	
		do
			a_server.display_response
		end

invariant
	response_attached: response /= Void
end

