note

	description:
		"A network stream socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SSL_NETWORK_STREAM_SOCKET

inherit

	INET_ADDRESS_FACTORY
		export {NONE}
			All
		undefine
			socket_ok, error, copy, is_equal
		end

	SSL_NETWORK_SOCKET
		rename
			context as ssl_network_socket_context
		undefine
			support_storable, read_to_managed_pointer, readstream, read_stream, write
		redefine
			shutdown, close_socket
		end

	SSL_STREAM_SOCKET
		undefine
			exists, is_valid_peer_address, is_valid_family, address_type,
			set_non_blocking, set_blocking
		redefine
			put_managed_pointer, read_to_managed_pointer, shutdown, readstream, read_stream, send, write
		end

create
	make, make_client_by_port, make_client_by_address_and_port, make_server_by_port, make_loopback_server_by_port

create {SSL_NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address, create_from_descriptor

feature -- Initialization

	make
			-- Create a network stream socket.
		do
			is_closed := True
			c_reset_error
			family := af_inet
			type := sock_stream;
			create last_string.make_empty
			make_socket
			timeout := default_timeout
			set_tls_protocol (default_tls_protocol)
		ensure
			timeout_set_to_default: timeout = default_timeout
			tls_protocol_set_to_default: tls_protocol = default_tls_protocol
		end

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING)
				-- Create a client connection to `a_peer_host' on
				-- `a_peer_port'.
		require
			valid_peer_host: a_peer_host /= Void and then not a_peer_host.is_empty
			valid_port: a_peer_port >= 0
		do
			check attached create_from_name (a_peer_host) as l_peer_address then
				make_client_by_address_and_port (l_peer_address, a_peer_port)
			end
		end

	make_server_by_port (a_port: INTEGER)
			-- Create server socket on `a_port' and on any incoming address.
		require
			valid_port: a_port >= 0
		local
			addr: INET_ADDRESS
		do
			make;
			addr := create_any_local
			create address.make_from_address_and_port (addr, a_port)
			bind
		end

	make_loopback_server_by_port (a_port: INTEGER)
			-- Create server socket on `a_port' that listen only for loopback interface peer.
		require
			valid_port: a_port >= 0
		local
			addr: INET_ADDRESS
		do
			make;
			addr := create_loopback
			create address.make_from_address_and_port (addr, a_port)
			bind
		end

	make_client_by_address_and_port (a_peer_address: INET_ADDRESS; a_peer_port: INTEGER)
				-- Create a client connection to `a_peer_host' on
				-- `a_peer_port'.
		require
			valid_peer_address: a_peer_address /= Void
			valid_port: a_peer_port >= 0
		do
			make
			create address.make_localhost (1)
			create peer_address.make_from_address_and_port (a_peer_address, a_peer_port)
		end

feature {SSL_NETWORK_STREAM_SOCKET} -- Initialization

	make_from_descriptor_and_address (a_fd: INTEGER; a_address: attached like address)
		require
			a_fd_positive: a_fd > 0
			a_address_positive: a_address /= Void
		do
			fd := a_fd
			address := a_address
			family := a_address.family
			descriptor_available := True
			is_closed := False
			is_created := True
			is_open_read := True
			is_open_write := True
			timeout := default_timeout
			create last_string.make_empty
			set_tls_protocol (default_tls_protocol)
		ensure
			address_set: address = a_address
			family_valid: family = a_address.family;
			opened_all: is_open_write and is_open_read
			tls_protocol_set_to_default: tls_protocol = default_tls_protocol
		end

	create_from_descriptor (a_fd: INTEGER)
			-- Given a file descriptor create the associated socket object.
		require
			a_fd_positive: a_fd > 0
		local
			l_address: like address
		do
			create l_address.make_localhost (0)
			c_sock_name (a_fd, l_address.socket_address.item, l_address.socket_address.count)
			make_from_descriptor_and_address (a_fd, l_address)
		end

feature -- Access

	close_socket
			-- Close this socket, and cleanup the SSL context
		local
			l_context: detachable SSL_CONTEXT
		do
				--| Close the descriptor, from NETWORK_SOCKET
			Precursor

			if is_closed then
				l_context := context
				if l_context = Void then
					l_context := ssl_network_socket_context
				end
				if l_context /= Void then
					if attached l_context.last_ssl as l_ssl then
						l_ssl.free
					end
					l_context.free
				end
			end
		end

	listen (queue: INTEGER)
			-- Listen on socket for at most `queue' connections.
		local
			l_fd, l_fd1: INTEGER
		do
			check address_attached: attached address as l_address then
				l_fd := fd
				l_fd1 := fd1
					-- Per inherited assertion.
				c_listen ($l_fd, $l_fd1, l_address.socket_address.item, queue)
				fd := l_fd;
				fd1 := l_fd1;
			end
		end

	accept
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		local
			retried: BOOLEAN
			pass_address: like address
			return: INTEGER;
			l_last_fd: like fd
			l_accepted: like accepted
		do
			if not retried then
				accepted := Void
					-- Per inherited assertion
				check address_attached: attached address as l_address then
					pass_address := l_address.twin
					l_last_fd := last_fd
					return := c_accept (fd, fd1, $l_last_fd, pass_address.socket_address.item, accept_timeout);
					last_fd := l_last_fd
					if return > 0 then
						create l_accepted.make_from_descriptor_and_address (return, l_address.twin);
						l_accepted.set_peer_address (pass_address)
						l_accepted.initialize_server_ssl (certificate_file_name, key_file_name)
						if is_blocking then
							l_accepted.set_blocking
						else
							l_accepted.set_non_blocking
						end
						accepted := l_accepted
					end
				end
			end
		rescue
			if not assertion_violation then
				retried := True
				retry
			end
		end

feature -- Input

	read_stream, readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		local
			ext: C_STRING
			return_val: INTEGER
			l_context: detachable SSL_CONTEXT
		do
			if context /= Void then
				l_context := context
			elseif ssl_network_socket_context /= Void then
				l_context := ssl_network_socket_context
			end
			if l_context /= Void and then attached l_context.last_ssl as l_ssl then
				create ext.make_empty (nb_char + 1)
				return_val :=l_ssl.read (ext.item , nb_char)
				bytes_read := return_val
				if return_val >= 0 then
					ext.set_count (return_val)
					last_string := ext.substring (1, return_val)
				else
					last_string.wipe_out
				end
			else
				check has_context: False end
			end
		end


	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result available in `p' at position
			-- `start_pos'
		local
			l_read: INTEGER
			l_last_read: INTEGER
			l_context: detachable SSL_CONTEXT
		do
			if context /= Void then
				l_context := context
			elseif ssl_network_socket_context /= Void then
				l_context := ssl_network_socket_context
			end
			if l_context /= Void and then attached l_context.last_ssl as l_ssl then
				from
					l_last_read := 1
				until
					l_read = nb_bytes or l_last_read <= 0
				loop
					l_last_read :=l_ssl.read (p.item + start_pos + l_read, nb_bytes - l_read)
					if l_last_read >= 0 then
						l_read := l_read + l_last_read
					end
				end
				bytes_read := l_read
			else
				check has_context: False end
			end
		end

feature -- Output

	write (a_packet: PACKET)
			-- Write packet `a_packet' to socket.
		local
			ext_data: POINTER
			count: INTEGER
			l_context: detachable SSL_CONTEXT
		do
			if context /= Void then
				l_context := context
			elseif ssl_network_socket_context /= Void then
				l_context := ssl_network_socket_context
			end
			if l_context /= Void and then attached l_context.last_ssl as l_ssl  then
				ext_data := a_packet.data.item
				count := a_packet.count
				l_ssl.write (ext_data, count)
			else
				check has_last_ssl: False end
			end
		end

	send (a_packet: PACKET; flags: INTEGER)
			-- Send a packet `a_packet' of data to socket.
		do
			write (a_packet)
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at current position
		local
			l_context: detachable SSL_CONTEXT
		do
			if context /= Void then
				l_context := context
			elseif ssl_network_socket_context /= Void then
				l_context := ssl_network_socket_context
			end
			if l_context /= Void and then attached l_context.last_ssl as l_ssl  then
				l_ssl.write (p.item + start_pos, nb_bytes)
			else
				check has_last_ssl: False end
			end
		end

feature -- Status Report

	accept_timeout: INTEGER
			-- The connect timeout in milliseconds

	certificate_file_name: detachable FILE_NAME
			-- Name of the file that holds the certificate

	connect_timeout: INTEGER
			-- The connect timeout in milliseconds

	key_file_name: detachable FILE_NAME
			-- Name of the file that holds the private key

	maximum_seg_size: INTEGER
			-- Maximum segment size
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

	maxium_seg_size: INTEGER
			-- Maximum segment size
		obsolete
			"Use `maximum_seg_size' instead."
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

	has_delay: BOOLEAN
			-- Is option TCPNO_DELAY off.
		require
			socket_exists: exists
		local
			l_value: INTEGER
		do
			l_value := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay)
			Result := l_value = 0
		end;

	is_linger_on: BOOLEAN
			-- Is lingering switched on?
		require
			socket_exists: exists
		do
			Result := c_is_linger_on (descriptor)
		end;

	is_out_of_band_inline: BOOLEAN
			-- Are out-of-band packets sent inline?
		require
			socket_exists: exists
		local
			is_inline: INTEGER
		do
			is_inline := c_get_sock_opt_int (descriptor, level_sol_socket, so_oob_inline);
			Result := is_inline /= 0
		end

	linger_time: INTEGER
			-- Linger time
		require
			socket_exists: exists
		do
			Result := c_linger_time (descriptor)
		end;

feature -- Status setting

	set_accept_timeout (a_timeout: INTEGER)
			--  Sets the accept timeout in milliseconds
		do
			accept_timeout := a_timeout
		end

	set_certificate_file_name (a_file_name: FILE_NAME)
			-- Set `certificate_file_name' to `a_file_name'
		do
			certificate_file_name := a_file_name.twin
		end

	set_connect_timeout (a_timeout: INTEGER)
			--  Sets the connect timeout in milliseconds
		do
			connect_timeout := a_timeout
		end

	set_delay
			-- Switch option TCPNO_DELAY off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 0)
		end;

	set_key_file_name (a_file_name: FILE_NAME)
			-- Set `key_file_name' to `a_file_name'
		do
			key_file_name := a_file_name.twin
		end

	set_linger (flag: BOOLEAN; time: INTEGER)
		obsolete "Use `set_linger_on'/`set_linger_off' instead."
			-- Switch lingering on/off (depending on `flag') and set linger
			-- time to `time'.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, flag, time)
		end;

	set_linger_on (time: INTEGER)
			-- Switch lingering on and set linger time to `time'.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, True, time)
		end;

	set_linger_off
			-- Switch lingering off.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, True, 0)
		end;

	set_nodelay
			-- Switch option TCPNO_DELAY on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 1)
		end;

	set_out_of_band_inline
			-- Switch "out of band packets inline" on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 1)
		end;

	set_out_of_band_not_inline
			-- Switch "out of band packets inline" off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 0)
		end;

feature {NONE} -- Implementation

	shutdown
			-- Send SSL/TLS close_notify
		local
			l_ssl: detachable SSL
		do
			if attached context as l_context then
				l_ssl := l_context.last_ssl
			elseif attached ssl_network_socket_context as l_ssl_network_socket_context then
				l_ssl := l_ssl_network_socket_context.last_ssl
			end
			if l_ssl /= Void then
				l_ssl.shutdown
			end
		end

	do_connect (a_peer_address: like address)
		local
			l_fd, l_fd1, l_port: INTEGER
		do
			l_fd := fd
			l_fd1 := fd1
			l_port := internal_port
			c_connect ($l_fd, $l_fd1, $l_port, a_peer_address.socket_address.item, connect_timeout, is_blocking)
			fd := l_fd
			fd1 := l_fd1
			internal_port := l_port
		end

	do_bind (a_address: like address)
		local
			l_fd, l_fd1, l_port: INTEGER
		do
			l_fd := fd
			l_fd1 := fd1
			l_port := internal_port
			c_bind ($l_fd, $l_fd1, $l_port, a_address.socket_address.item)
			fd := l_fd
			fd1 := l_fd1
			internal_port := l_port
		end

	do_create
		local
			l_fd, l_fd1: like fd
		do
			l_fd := fd
			l_fd1 := fd1
			c_create ($l_fd, $l_fd1)
			fd := l_fd
			fd1 := l_fd1
			is_created := True
		end

feature {NONE} -- Externals

	c_create (a_fd, a_fd1: TYPED_POINTER [INTEGER])
		external
			"C blocking"
		alias
			"en_socket_stream_create"
		end

	c_connect (a_fd, a_fd1, a_port: TYPED_POINTER [INTEGER]; an_address: POINTER; a_timeout: INTEGER; a_is_blocking: BOOLEAN)
		external
			"C blocking"
		alias
			"en_socket_stream_connect"
		end

	c_bind (a_fd, a_fd1, a_port: TYPED_POINTER [INTEGER]; an_address: POINTER)
		external
			"C blocking"
		alias
			"en_socket_stream_bind"
		end

	c_listen (a_fd, a_fd1: TYPED_POINTER [INTEGER]; an_address: POINTER; a_queue: INTEGER)
		external
			"C blocking"
		alias
			"en_socket_stream_listen"
		end

	c_accept (a_fd, a_fd1: INTEGER; a_last_fd: TYPED_POINTER [INTEGER]; an_address: POINTER; a_timeout: INTEGER): INTEGER
		external
			"C blocking"
		alias
			"en_socket_stream_accept"
		end

	c_sock_name (soc: INTEGER; addr: POINTER; length: INTEGER)
			-- External c routine that returns the socket name.
		external
			"C"
		end;

	c_set_sock_opt_linger (an_fd: INTEGER flag: BOOLEAN; time: INTEGER): INTEGER
		external
			"C"
		end;

	c_is_linger_on (an_fd: INTEGER): BOOLEAN
		external
			"C"
		end;

	c_linger_time (an_fd: INTEGER): INTEGER
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class NETWORK_STREAM_SOCKET

