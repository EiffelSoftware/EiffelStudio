note
	description: "[
		A server module that reads commands on a socket.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_CMD_MODULE

inherit
	XC_SERVER_MODULE
		rename
			make as base_make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER

create
	make

feature -- Initialization

--	make (a_main_server: like main_server)
--			-- Initializes current
--		do
--			Precursor (a_main_server)
--            stop := False
--		end

	make (a_main_server: like main_server; a_name: STRING)
			-- Initializes current
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			base_make (a_name)
			main_server := a_main_server
 		ensure
			main_server_set: equal (a_main_server, main_server)
			name_set: equal (name, a_name)
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
				            if attached {XC_SERVER_COMMAND} thread_cmd_socket.retrieved as l_command then
				            	o.dprint ("Command retreived...",2)
								l_command_response := l_command.execute (main_server)

					 	       	if l_command.has_response then
						 	       	o.dprint ("Sending back command_response...", 2)
									thread_cmd_socket.put_natural (0)
									thread_cmd_socket.independent_store (l_command_response)
					 	       	end
				 	       	end

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

	main_server: XC_SERVER_INTERFACE

feature -- Status


feature -- Constants

	default_cmd_server_port: INTEGER = 55002
			-- Port for incoming requests (commands) from webapps

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect


feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
		end


invariant
	main_server_attached: main_server /= Void
end

