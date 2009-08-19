note
	description: "[
			Represents an unmanaged webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_UNMANAGED_WEBAPP

inherit
	XS_WEBAPP

	XS_SHARED_SERVER_OUTPUTTER

	XS_SHARED_SERVER_CONFIG

create
	make_with_attributes

feature {NONE} -- Initialization

	make_with_attributes (a_name: STRING; a_host: STRING; a_port: INTEGER)
			-- Initialization for `Current'.
			-- Initializes the actions. The action chain is:
			-- -> SEND
			--
			-- `a_name': The name of the webapp
			-- `a_host': The host address of the webapp
			-- `a_post': The port of the webapp
		local
			l_config: XC_WEBAPP_CONFIG
		do
			create l_config.make_empty
			l_config.set_name (a_name)
			l_config.set_webapp_host (a_host)
			l_config.set_port (a_port)
			make_with_config (l_config)
			current_request := create {XCWC_EMPTY}.make
			create action_send.make
			action_send.set_webapp (current)
			is_running := True
		ensure then
			action_send_attached: action_send /= Void
		end

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			current_request := a_request
			if is_disabled then
				Result := (create {XER_DISABLED}.make(app_config.name)).render_to_command_response
			else
				Result := action_send.execute
			end
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		do
			Result := True
			current_request :=  create {XCWC_GET_SESSIONS}.make
			if attached {XCCR_GET_SESSIONS} action_send.execute as l_response then
				sessions := l_response.sessions
			else
				Result := False
			end
		end

end
