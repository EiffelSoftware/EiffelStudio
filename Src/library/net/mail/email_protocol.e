indexing
	description: "Handle any emails actions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_PROTOCOL

inherit
	EMAIL_CONSTANTS

	PROTOCOL_RESOURCE

feature -- Initialization

	make (host:STRING; port_number: INTEGER) is
			-- Create the protocol with 'a_hostname' and 'a_port'
		do
			hostname:= host
			port:= port_number
		end

feature -- Access

	socket: NETWORK_STREAM_SOCKET
		-- Socket use to communicate.

	hostname: STRING
		-- hostname .. ex: smtp.

	default_port: INTEGER is
		-- Default port.
		deferred
		end

feature -- Status setting

	is_initiated: BOOLEAN
		-- Has the connection has been initiated?

	is_connected: BOOLEAN
		-- Is the connection done?


feature -- Basic operations

	connect is
			-- Connect to the host machine.
		do
			init_socket
			enable_connected
		end

	initiate is
			-- initiate the connection with the server.
		deferred
		end

	terminate is
			-- Terminate the connection to the server.
		deferred
		end

feature -- Settings

	enable_initiated is
			-- Set is_initiated.
		do
			is_initiated:= True
		end

	enable_connected is
			-- Set is_connected.
		do
			is_connected:= True
		end

	set_default_port (new_port: INTEGER) is
			-- Set the default port
		do
			port:= new_port
		end

feature {NONE} -- Implementation 

	port: INTEGER
		-- port number.


feature {NONE} -- Miscellaneous

	init_socket is
			-- Initiate the socket.
		do
			create socket.make_client_by_port (port, hostname)
			socket.connect
		end

end -- class EMAIL_PROTOCOL
