indexing
	description: "Handle any emails actions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	EMAIL_PROTOCOL

inherit
	EMAIL_CONSTANTS

feature -- Initialization

	make (a_hostname:STRING; a_port: INTEGER) is
			-- Create the protocol with 'a_hostname' and 'a_port'
			-- And initiate the socket
		do
			hostname:= a_hostname
			port:= a_port
			init_socket
		end

feature -- Actions

	initiate is
			-- initiate the connection with the server
		deferred
		end

	transfer is
		require
			is_initiated: initiated = True
			-- Send or retrieve data from the server.
		deferred
		end

	quit is
			-- Cut the connection to the server
		deferred
		end

feature -- Settings

	set_email (an_email: EMAIL) is
		do
			email:= an_email
		end

feature {NONE} -- Actions

	init_socket is
		do
			create socket.make_client_by_port (port, hostname)
			socket.connect
		end

	enable_initiated is
		do
			initiated:= True
		end

feature -- Access

	socket: NETWORK_STREAM_SOCKET
		-- Socket use to communicate

	email: EMAIL
		-- Email to be send using any protocol

	port: INTEGER
		-- port number

	hostname: STRING
		-- hostname .. ex: smtp

	transfer_error: BOOLEAN 
		-- Has the transfert failed ?

	initiated: BOOLEAN
		-- Has the connection has been initiated

end -- class EMAIL_PROTOCOL
