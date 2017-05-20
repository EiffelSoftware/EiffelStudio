note
	description: "Summary description for {TCP_STREAM_SOCKET}."
	date: "$Date$"
	revision: "$Revision$"

class
	TCP_STREAM_SOCKET

inherit
	NETWORK_STREAM_SOCKET
		redefine
			make
		end

create
	make_server_by_address_and_port,
	make_server_by_port

create {NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address,
	make_empty

feature {NONE} -- Initialization

	make_server_by_address_and_port (a_address: INET_ADDRESS; a_port: INTEGER)
			-- Create server socket on `a_address' and `a_port'.
		require
			valid_port: a_port >= 0
		do
			make
			create address.make_from_address_and_port (a_address, a_port)
			bind
		end	

	make
			-- Create a network stream socket.
		do
			Precursor
			set_reuse_address
		end

feature -- Basic operation

	send_message (a_msg: STRING)
		local
			a_package : PACKET
			a_data : MANAGED_POINTER
			c_string : C_STRING
		do
			create c_string.make (a_msg)
			create a_data.make_from_pointer (c_string.item, a_msg.count + 1)
			create a_package.make_from_managed_pointer (a_data)
			send (a_package, 1)
		end

feature -- Output

	put_readable_string_8 (s: READABLE_STRING_8)
			-- Write readable string `s' to socket.
		local
			ext: C_STRING
		do
			create ext.make (s)
			put_managed_pointer (ext.managed_data, 0, s.count)
		end

feature -- Status report

	try_ready_for_reading: BOOLEAN
			-- Is data available for reading from the socket right now?
		require
			socket_exists: exists
		local
			retval: INTEGER
		do
			retval := c_select_poll_with_timeout (descriptor, True, 0)
			Result := (retval > 0)
		end

note
	copyright: "2011-2015, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
