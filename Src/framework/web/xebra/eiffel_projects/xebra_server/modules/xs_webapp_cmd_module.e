note
	description: "[
		Listens for commands from webapps
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_CMD_MODULE

inherit
	XC_SERVER_MODULE
		redefine
			make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER

create
	make

feature -- Initialization

	make (a_main_server: like main_server)
			-- Initializes current
		do
			Precursor (a_main_server)
            stop := False
		end

feature -- Inherited Features

	execute
			-- <Precursor>
		local
			l_command_response: XC_COMMAND_RESPONSE
			l_cmd_socket: NETWORK_STREAM_SOCKET

		do
			stop := False
			launched := True
			running := True

			create l_cmd_socket.make_server_by_port (default_cmd_server_port)

			if not l_cmd_socket.is_bound then
				o.eprint ("Socket could not be bound on port " + default_cmd_server_port.out, generating_type)
			else

	 	       	l_cmd_socket.set_accept_timeout (500)
				from
	                l_cmd_socket.listen (max_tcp_clients.as_integer_32)
	                o.dprint("Command Server ready on port " + default_cmd_server_port.out, 2)
	            until
	            	stop
	            loop
	                l_cmd_socket.accept

	                if not stop then
			            if attached {NETWORK_STREAM_SOCKET} l_cmd_socket.accepted as thread_cmd_socket then
	 					 	o.dprint ("Command connection to Webapp accepted",2)
	 					 	thread_cmd_socket.read_natural
				            if attached {XC_COMMAND} thread_cmd_socket.retrieved as l_command then
				            	o.dprint ("Command retreived...",2)
								l_command_response := l_command.execute (main_server)
				 	       	else
				 	       		l_command_response := create {XCCR_CANNOT_SEND}.make
				 	       	end

							o.dprint ("Sending back command_response...", 2)
							thread_cmd_socket.put_natural (0)
							thread_cmd_socket.independent_store (l_command_response)

				         	thread_cmd_socket.cleanup
				            check
				            	thread_cmd_socket.is_closed
				            end

						end
					end
				end

	            l_cmd_socket.cleanup
	        	check
	        		l_cmd_socket.is_closed
	       		end
	       		o.dprint("Command Server ends.",2)
	       		running := False
	       	end
       		rescue
       			o.eprint ("Exception occured.", generating_type)
       			retry
       	end

feature -- Access

	stop: BOOLEAN
			-- Set true to stop accept loop

feature {NONE} -- Access


feature -- Status


feature -- Constants

	default_cmd_server_port: INTEGER = 55001
			-- Port for incoming requests (commands) from webapps

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect


feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
		end


feature {NONE} -- Implementation


end

