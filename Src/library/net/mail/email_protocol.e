indexing
	description: "Handle any emails actions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_PROTOCOL

inherit
	PROTOCOL_RESOURCE

feature -- Access

	hostname: STRING
		-- hostname .. ex: smtp.

	default_port: INTEGER is
		-- Default port.
		deferred
		end

feature -- Status report

	is_initiated: BOOLEAN
		-- Has the connection has been initiated?

	is_connected: BOOLEAN
		-- Is the connection done?


feature -- Basic operations

	initiate_protocol is
		deferred
		end

	close_protocol is
		deferred
		end

	connect is
			-- Connect to the host machine.
			-- Use this feature only if the protocol has been created without the connection.
		do
			init_socket
		ensure
			is_connected
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

	disable_connected is
			-- Unset is_connected.
		do
			is_connected:= False
		end

	set_default_port (new_port: INTEGER) is
			-- Set the default port to 'new_port'.
		do
			port:= new_port
		end

feature {NONE} -- Implementation 

	port: INTEGER
		-- port number.

	socket: NETWORK_STREAM_SOCKET
		-- Socket use to communicate.

feature {NONE} -- Miscellaneous

	init_socket is
			-- Initiate the socket.
		do
			create socket.make_client_by_port (port, hostname)
			socket.connect
			socket.read_line
			if decode (socket.last_string) = Ack_begin_connection then
				enable_connected
			end
		end

	decode (s: STRING): INTEGER is
			-- Decode the answer and retrieve the code number.
		deferred
		end

end -- class EMAIL_PROTOCOL
