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

	email: EMAIL
		-- Email to be send using any protocol.

	hostname: STRING
		-- hostname .. ex: smtp.

	default_port: INTEGER is
		-- Default port.
		deferred
		end

feature -- Status setting

	transfer_error: BOOLEAN 
		-- Has the transfert failed?

	initiated: BOOLEAN
		-- Has the connection has been initiated?


feature -- Basic operations

	connect is
			-- Connect to the host machine.
		do
			init_socket
		end

	initiate is
			-- initiate the connection with the server.
		deferred
		end

	transfer is
			-- Send or retrieve data from the server.
		require
			is_initiated: initiated = True
		deferred
		end

	terminate is
			-- Terminate the connection to the server.
		deferred
		end

feature -- Settings

	set_email (an_email: EMAIL) is
			-- Set an email to the protocol.
		do
			email:= an_email
		end

	enable_initiated is
			-- Set initiated.
		do
			initiated:= True
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
