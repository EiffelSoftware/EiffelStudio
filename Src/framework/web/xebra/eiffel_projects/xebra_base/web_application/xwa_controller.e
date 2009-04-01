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

feature -- Access

	current_request: detachable  XH_REQUEST
		-- Represents the current request that was sent by the user

	current_session: detachable XH_SESSION
		-- Represents the session that belongs to the user that has send the current request

feature -- Events

	on_page_load
			--
		deferred
		end

feature -- Status Change

	set_current_request (a_request: XH_REQUEST)
			--
		do
			current_request := a_request
		ensure
			current_request_attached: current_request /= Void
		end

	set_current_session (a_session: XH_SESSION)
			--
		do
			current_session := a_session
		ensure
			current_session_attached: current_session /= Void
		end

end
