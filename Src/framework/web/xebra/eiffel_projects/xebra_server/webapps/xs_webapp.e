note
	description: "[
			Represents a webapp and provides features to translate, compile and run it
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_WEBAPP

inherit
	XC_WEBAPP_BEAN

	XS_SHARED_SERVER_OUTPUTTER

	XS_SHARED_SERVER_CONFIG


feature  -- Access

	action_send: XSWA_SEND
		-- The action to send the request to the webapp

	current_request: XC_WEBAPP_COMMAND
		-- The last request received from the xebra server

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- Sends a_request to the webapp.		
		require
			a_request_attached: a_request /= Void
		deferred
		ensure
			Result_attached: Result /= Void
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		deferred
		end

	fire_off
			-- Sends shutdown signal no matter what
		do
			o.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", o.Debug_tasks)
			current_request := 	create {XCWC_SHUTDOWN}.make
			action_send.execute.do_nothing
		end

invariant
	config_attached: config /= Void
	current_request_attached: current_request /= Void
	action_send_attached: action_send /= Void
end
