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


	shutdown: XC_COMMAND_RESPONSE
			-- Shuts down a webapp.
		deferred
		ensure
			result_attached: Result /= Void
		end


	handle_http_request (a_request: STRING): XC_COMMAND_RESPONSE
			-- Lets the webapp handle a http request.
		require
			a_request_attached: a_request /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	get_sessions: XC_COMMAND_RESPONSE
			-- Retrieves the number of sessions.
		deferred
		ensure
			result_attached: Result /= Void
		end


end

