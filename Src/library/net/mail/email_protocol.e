note
	description: "Handle any emails actions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_PROTOCOL

inherit
	PROTOCOL_RESOURCE

feature -- Access

	hostname: READABLE_STRING_8
		-- hostname .. ex: smtp

	code_number: INTEGER
		-- Last error code received from server.

	default_port: INTEGER
		-- Default port
		deferred
		end

feature -- Status report

	is_connected: BOOLEAN
		-- Is the connection done?


feature -- Basic operations

	initiate_protocol
			-- Initiate the protocol.
		deferred
		end

	close_protocol
			-- Close the protocol.
		deferred
		end

feature -- Settings

	enable_connected
			-- Set is_connected.
		do
			is_connected:= True
		end

	disable_connected
			-- Unset is_connected.
		do
			is_connected:= False
		end

	set_default_port (new_port: INTEGER)
			-- Set the default port to 'new_port'.
		do
			port:= new_port
		end

feature {NONE} -- Implementation

	port: INTEGER
		-- port number

	socket: detachable NETWORK_STREAM_SOCKET
		-- Socket use to communicate

feature {NONE} -- Miscellaneous

	connect
			-- Connect to the host machine,
			-- Use this feature only if the protocol has been created without the connection.
		do
			init_socket
		ensure
			is_connected
		end

	init_socket
			-- Initiate the socket.
		local
			l_socket: like socket
		do
			create l_socket.make_client_by_port (port, hostname)
			l_socket.connect
			decode (l_socket)
			socket := l_socket
			if code_number = Ack_begin_connection then
				enable_connected
			end
		ensure
			socket_attached: socket /= Void
		end

	decode (a_socket: attached like socket)
			-- Read answer from server and set `code_number'.
		require
			a_socket_attached: a_socket /= Void
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EMAIL_PROTOCOL

