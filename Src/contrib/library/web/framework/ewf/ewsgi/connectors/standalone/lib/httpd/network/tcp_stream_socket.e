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

	TCP_STREAM_SOCKET_EXT

create
	make_server_by_address_and_port,
	make_server_by_port,
	make_client_by_address_and_port,
	make_client_by_port,
	make_from_separate,
	make_empty

create {NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address

feature {NONE} -- Initialization

	make
			-- Create a network stream socket.
		do
			Precursor
			debug
				set_reuse_address
			end
		end

	make_server_by_address_and_port (an_address: INET_ADDRESS; a_port: INTEGER)
			-- Create server socket on `an_address' and `a_port'.
		require
			valid_port: a_port >= 0
		do
			make
			create address.make_from_address_and_port (an_address, a_port)
			bind
		end

	make_from_separate (s: separate STREAM_SOCKET)
		require
			descriptor_available: s.descriptor_available
		do
			create_from_descriptor (s.descriptor)
		end

feature -- Basic operation

	peek_stream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters without removing the data from the queue.
			-- Make result available in last_string.
		require
			readable: readable
			socket_exists: exists
		local
			ext: C_STRING
			retval: INTEGER
			l: like last_string
		do
			create ext.make_empty (nb_char + 1)
			retval := clib_recv (descriptor, ext.item, nb_char, c_peekmsg)
			if retval = 0 then
				last_string.wipe_out
				socket_error := Void
			elseif retval > 0 then
				ext.set_count (retval)
				l := last_string
				l.wipe_out
				l.grow (retval)
				l.set_count (retval)
				ext.read_substring_into (l, 1, retval)
				socket_error := Void
			else
				last_string.wipe_out
				socket_error := "Socket error (MSG_PEEK)"
			end
		ensure
			last_string_not_void: last_string /= Void
		end

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

	has_incoming_data: BOOLEAN
			-- Check if Current has available data to be read.
			-- note: no data will not be removed from the queue.
		require
			socket_exists: exists
		do
			peek_stream (1)
			Result := last_string.count = 1
		end

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

feature {NONE} -- C implementation

	clib_recv (a_fd: INTEGER; buf: POINTER; len: INTEGER; flags: INTEGER): INTEGER
			-- External routine to receive at most `len' number of
			-- bytes into buffer `buf' from socket `fd' with `flags' options.
		external
			"C inline"
		alias
			"[
			return (EIF_INTEGER) recv ((int) $a_fd, (char *) $buf, (int) $len, (int) $flags);
			]"
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
