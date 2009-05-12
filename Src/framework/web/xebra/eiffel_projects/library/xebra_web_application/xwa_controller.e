note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_CONTROLLER

feature -- Initialization

	make
			-- Initializes current
		do
			create {XH_GET_REQUEST} current_request.make_empty
		ensure
			current_request_attached: current_request /= Void
		end

feature -- Access

	current_request: XH_REQUEST
		-- Represents the current request that was sent by the user

	current_session: detachable XH_SESSION
		-- Represents the session that belongs to the user that has send the current request


feature -- Status Change

	set_current_request (a_request: XH_REQUEST)
			-- Setts current_request.
		require
			a_request_attached: a_request /= Void
		do
			current_request := a_request
		ensure
			current_request_attached: current_request /= Void
		end

	set_current_session (a_session: XH_SESSION)
			-- Sets current_session.
		require
			a_session_attached: a_session /= Void
		do
			current_session := a_session
		ensure
			current_session_attached: current_session /= Void
		end

invariant
	current_request_attached: current_request /= Void
end
