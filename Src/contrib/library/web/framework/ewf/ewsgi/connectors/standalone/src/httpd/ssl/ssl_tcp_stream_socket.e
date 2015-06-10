note
	description: "SSL tcp stream socket."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_TCP_STREAM_SOCKET

inherit

	SSL_NETWORK_STREAM_SOCKET

create
	make_server_by_address_and_port, make_server_by_port,
	make_empty

create {SSL_NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address

feature {NONE} -- Initialization

	make_server_by_address_and_port (an_address: INET_ADDRESS; a_port: INTEGER)
			-- Create server socket on `an_address' and `a_port'.
		require
			valid_port: a_port >= 0
		do
			make
			create address.make_from_address_and_port (an_address, a_port)
			bind
		end

feature -- Basic operation

	send_message (a_msg: STRING)
		do
			put_string (a_msg)
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

feature {NONE}-- Implementation




note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
