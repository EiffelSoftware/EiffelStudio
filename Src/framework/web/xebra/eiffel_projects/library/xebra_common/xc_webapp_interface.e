note
	description: "[
		API for commands that can be executed on a webapp.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_WEBAPP_INTERFACE

feature -- Basic operations

	handle_http_request (a_request: XH_REQUEST): XC_COMMAND_RESPONSE
			-- .
		require
			a_request_attached: a_request /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	get_sessions: XC_COMMAND_RESPONSE
			-- .
		deferred
		ensure
			result_attached: Result /= Void
		end


end

