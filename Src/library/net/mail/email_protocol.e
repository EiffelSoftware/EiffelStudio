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
		-- hostname .. ex: smtp
		
	code_number: INTEGER
		-- Last error code received from server.

	default_port: INTEGER is
		-- Default port
		deferred
		end

feature -- Status report

	is_connected: BOOLEAN
		-- Is the connection done?


feature -- Basic operations

	initiate_protocol is
			-- Initiate the protocol.
		deferred
		end

	close_protocol is
			-- Close the protocol.
		deferred
		end

feature -- Settings

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
		-- port number

	socket: NETWORK_STREAM_SOCKET
		-- Socket use to communicate

feature {NONE} -- Miscellaneous

	connect is
			-- Connect to the host machine,
			-- Use this feature only if the protocol has been created without the connection.
		do
			init_socket
		ensure
			is_connected
		end

	init_socket is
			-- Initiate the socket.
		do
			create socket.make_client_by_port (port, hostname)
			socket.connect
			decode
			if code_number = Ack_begin_connection then
				enable_connected
			end
		end

	decode is
			-- Read answer from server and set `code_number'.
		deferred
		end

end -- class EMAIL_PROTOCOL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

