note
	description: "[
		Is used to send commands to the server
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SERVER_CONTROL

inherit
	XU_SHARED_OUTPUTTER

	XWA_SHARED_CONFIG

feature -- Operations

	send (a_command: XC_SERVER_COMMAND): XC_COMMAND_RESPONSE
			-- Sends a command to the server and waits for the response
		require
			a_command_attached: a_command /= Void
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			Result := create {XCCR_INTERNAL_SERVER_ERROR}

			create l_socket.make_client_by_port ({XU_CONSTANTS}.Cmd_server_port, config.server_host)
			o.dprint ("Connecting...", o.Debug_verbose_subtasks)
			l_socket.set_connect_timeout ({XU_CONSTANTS}.Socket_connect_timeout)
			l_socket.connect
            if  l_socket.is_connected then
            	o.dprint("Sending command...", o.Debug_verbose_subtasks)
            	l_socket.put_natural (0)
		        l_socket.independent_store (a_command)

		        if a_command.has_response then
		        	o.dprint ("Waiting for response", o.Debug_verbose_subtasks)
		            l_socket.read_natural
					if attached {XC_COMMAND_RESPONSE} l_socket.retrieved as l_response then
						o.dprint ("Response retrieved", o.Debug_verbose_subtasks)
		            	Result := l_response
		            else
		            	Result := create {XCCR_CANNOT_SEND}
	            	end
		        else
		        	Result := create {XCCR_NO_RESPONSE}
		        end
	        else
	        	Result := create {XCCR_CANNOT_SEND}
	        end
		ensure
			result_attached: Result /= Void
		end


end

