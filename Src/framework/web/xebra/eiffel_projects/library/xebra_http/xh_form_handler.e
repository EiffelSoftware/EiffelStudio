note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XH_FORM_HANDLER

feature -- Access

feature -- Status report

feature -- Status setting

feature -- Basic operations

	handle_form (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Calls the right pre_handler on the servlet
		require
			a_request_attached: a_request /= Void
			a_response_attached: a_response /= Void
		deferred
		end

feature {NONE} -- Implementation

invariant

end

