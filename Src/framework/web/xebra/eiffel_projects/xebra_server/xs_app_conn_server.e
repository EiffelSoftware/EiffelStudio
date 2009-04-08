note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_APP_CONN_SERVER

inherit
	THREAD
	XU_DEBUG_OUTPUTTER
	XU_ERROR_OUTPUTTER

create make

feature -- Initialization

	make  (a_webapp_handler: XS_WEBAPP_HANDLER)
			-- Initializes current
		do
			webapp_handler := a_webapp_handler
            create socket.make_server_by_port (default_app_server_port)
            stop := False
		ensure
			webapp_handler_set: a_webapp_handler = webapp_handler
       	end

feature -- Inherited Features

	execute
			-- <Precursor>
		do
        	from
                socket.listen (max_tcp_clients.as_integer_32)
            until
            	stop
            loop
                socket.accept
                dprint ("Incoming registration...",1)
				  if attached {NETWORK_STREAM_SOCKET} socket.accepted as l_socket then
				  	-- Register application to webapp_handler
					  if attached {STRING} l_socket.retrieved as l_buf then
						 if l_buf.has_substring (Key_register) then
						  	l_buf.remove_head (l_buf.substring_index (Key_register, 1) + Key_register.count-1)
						  	webapp_handler.register (l_buf, l_socket)
						  	l_socket.independent_store (Key_register_ack)
						  	dprint ("New application registered '" + l_buf + "'.", 1)
						  else
						  	eprint ("Invalid registration, shutting down socket.")
						  	l_socket.cleanup
						  end
					  else
					  	 	eprint ("Not valid retrieved")
					  end
				end
            end
            socket.cleanup
        	check
        		socket.is_closed
        	end
		end

feature -- Access

	socket: NETWORK_STREAM_SOCKET

	webapp_handler: XS_WEBAPP_HANDLER
			-- Stores registered Webapps and is able to send/receive request and responses

	stop: BOOLEAN
			-- Set true to stop accept loop

feature -- Constants

	default_app_server_port: INTEGER = 55001
			-- Port for communication between http server and xebra server

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect

feature -- Protocol Constants

	Key_register: STRING = "#REG#"
	Key_register_ack: STRING = "#RACK#"


feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
			socket.cleanup
			check
        		socket.is_closed
        	end
		end
end
