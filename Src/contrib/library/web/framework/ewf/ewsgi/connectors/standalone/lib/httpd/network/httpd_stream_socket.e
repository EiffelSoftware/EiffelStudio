note
	description: "[
			Summary description for {HTTPD_STREAM_SOCKET}
			that can be used for http or https connection.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_STREAM_SOCKET

create
	make_server_by_address_and_port,
	make_server_by_port,
	make_client_by_address_and_port,
	make_client_by_port,
	make_from_separate,
	make_empty

create {HTTPD_STREAM_SOCKET}
	make

feature {NONE} -- Initialization

	make_server_by_address_and_port (an_address: INET_ADDRESS; a_port: INTEGER)
		do
			create {TCP_STREAM_SOCKET} socket.make_server_by_address_and_port (an_address, a_port)
		end

	make_server_by_port (a_port: INTEGER)
		do
			create {TCP_STREAM_SOCKET} socket.make_server_by_port (a_port)
		end

	make_client_by_address_and_port (an_address: INET_ADDRESS; a_port: INTEGER)
		do
			create {TCP_STREAM_SOCKET} socket.make_client_by_address_and_port (an_address, a_port)
		end

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING)
		do
			create {TCP_STREAM_SOCKET} socket.make_client_by_port (a_peer_port, a_peer_host)
		end

	make_from_separate (s: separate HTTPD_STREAM_SOCKET)
		require
			descriptor_available: s.descriptor_available
		do
			create {TCP_STREAM_SOCKET} socket.make_from_separate (s.socket)
		end

	make_empty
		do
			create {TCP_STREAM_SOCKET} socket.make_empty
		end

	retrieve_socket (s: HTTPD_STREAM_SOCKET): INTEGER
		do
			Result := s.socket.descriptor
		end

feature -- Change

	set_timeout (n: INTEGER)
		do
			if attached {NETWORK_STREAM_SOCKET} socket as l_socket then
				l_socket.set_timeout (n)
			end
		end

	set_connect_timeout (n: INTEGER)
		do
			if attached {NETWORK_STREAM_SOCKET} socket as l_socket then
				l_socket.set_connect_timeout (n)
			end
		end

	set_accept_timeout (n: INTEGER)
		do
			if attached {NETWORK_STREAM_SOCKET} socket as l_socket then
				l_socket.set_accept_timeout (n)
			end
		end

feature -- Access

	last_string: STRING
		do
			Result := socket.last_string
		end

	last_character: CHARACTER
		do
			Result := socket.last_character
		end

	peer_address: detachable NETWORK_SOCKET_ADDRESS
			-- Peer address of socket
		do
			if attached {NETWORK_SOCKET_ADDRESS} socket.peer_address as l_peer_address then
				Result := l_peer_address
			end
		end

feature -- Input

	read_line_thread_aware
		do
			socket.read_line_thread_aware
		end

	read_stream_thread_aware (nb: INTEGER)
		do
			socket.read_stream_thread_aware (nb)
		end

	read_stream (nb: INTEGER)
		do
			socket.read_stream (nb)
		end

	read_character
		do
			socket.read_character
		end

	bytes_read: INTEGER
		do
			Result := socket.bytes_read
		end

feature -- Output

	send_message (a_msg: STRING)
		do
			put_string (a_msg)
		end

	put_readable_string_8 (s: READABLE_STRING_8)
			-- Write readable string `s' to socket.
		do
			if attached {TCP_STREAM_SOCKET} socket as l_tcp_stream_socket then
				l_tcp_stream_socket.put_readable_string_8 (s)
			else
				put_string (s)
			end
		end

	put_string (s: STRING)
		do
			socket.put_string (s)
		end

	put_character (c: CHARACTER)
		do
			socket.put_character (c)
		end

feature -- Status Report

	descriptor_available: BOOLEAN
			-- Is descriptor available?
		do
			Result := socket.descriptor_available
		end

	descriptor: INTEGER
		do
			Result := socket.descriptor
		end

	port: INTEGER
		do
			if attached {TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.port
			end
		end

	exists: BOOLEAN
		do
			Result := socket.exists
		end

	is_blocking: BOOLEAN
		do
			Result := socket.is_blocking
		end

	is_bound: BOOLEAN
		do
			if attached {TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.is_bound
			end
		end

	is_connected: BOOLEAN
		do
			if attached {TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.is_connected
			end
		end

	is_created: BOOLEAN
		do
			if attached {NETWORK_SOCKET} socket as l_socket then
				Result := l_socket.is_created
			end
		end

	socket_ok: BOOLEAN
		do
			Result := socket.socket_ok
		end

	is_open_read: BOOLEAN
		do
			Result := socket.is_open_read
		end

	is_open_write: BOOLEAN
		do
			Result := socket.is_open_write
		end

	is_closed: BOOLEAN
		do
			Result := socket.is_closed
		end

	is_readable: BOOLEAN
		do
			Result := socket.is_readable
		end

	cleanup
		do
			socket.cleanup
		end

	ready_for_writing: BOOLEAN
		do
			if attached {TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.ready_for_writing
			end
		end

	connect
		do
			socket.connect
		end

	close
		do
			socket.close
		end

	listen (a_queue: INTEGER)
		do
			socket.listen (a_queue)
		end

	accept
		do
			socket.accept
		end

	accept_to (other: separate HTTPD_STREAM_SOCKET)
			-- Accept a new connection on listen socket.
			-- Socket of accepted connection is available in `other'.
		do
			if
				attached {NETWORK_STREAM_SOCKET} socket as l_socket and then
				attached {separate NETWORK_STREAM_SOCKET} other.socket as l_other_socket
			then
				l_socket.accept_to (l_other_socket)
			end
		end

	set_blocking
		do
			socket.set_blocking
		end

	set_non_blocking
		do
			socket.set_non_blocking
		end

	readable: BOOLEAN
		do
			Result := socket.readable
		end

	ready_for_reading: BOOLEAN
		do
			if attached {TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.ready_for_reading
			end
		end

	try_ready_for_reading: BOOLEAN
		do
			if attached {TCP_STREAM_SOCKET} socket as l_socket then
				Result := l_socket.try_ready_for_reading
			end
		end

	accepted: detachable HTTPD_STREAM_SOCKET
		do
			if attached {NETWORK_STREAM_SOCKET} socket.accepted as l_accepted then
				create Result.make (l_accepted)
			end
		end

feature {HTTPD_STREAM_SOCKET} -- Implementation

	make (a_socket: STREAM_SOCKET)
		do
			socket := a_socket
		end

	socket: STREAM_SOCKET

	network_stream_socket: detachable NETWORK_STREAM_SOCKET
		do
			if attached {NETWORK_STREAM_SOCKET} socket as s then
				Result := s
			end
		end

;note
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
