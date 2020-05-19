note

	description: "A network stream socket."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class

	NETWORK_STREAM_SOCKET

inherit

	INET_ADDRESS_FACTORY
		export
			{NONE} all
		undefine
			socket_ok, error, copy, is_equal
		end

	NETWORK_SOCKET
		undefine
			support_storable
		end

	STREAM_SOCKET
		undefine
			exists, is_valid_peer_address, is_valid_family, address_type,
			set_blocking, set_non_blocking
		end

create
	make, make_empty,
	make_client_by_port, make_client_by_address_and_port,
	make_server_by_port, make_server_by_address_and_port, make_loopback_server_by_port

create {NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address, create_from_descriptor

feature {NONE} -- Initialization

	make_empty
			-- Initialize an empty {NETWORK_STREAM_SOCKET}.
			-- The object does not have a C socket.
		do
			is_closed := True
			c_reset_error
			family := af_inet
			type := sock_stream;
			create last_string.make_empty
			timeout_ns := one_second_in_nanoseconds * default_timeout.to_natural_64
		ensure
			timeout_set_to_default: timeout_ns = one_second_in_nanoseconds * default_timeout.to_natural_64
			no_socket_created: not is_created
		end

feature -- Initialization

	make
			-- Create a network stream socket.
		do
			make_empty
			make_socket
		ensure
			timeout_set_to_default: timeout_ns = one_second_in_nanoseconds * default_timeout.to_natural_64
			socket_created: is_created
		end

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: READABLE_STRING_8)
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

	make_server_by_address_and_port (a_address: INET_ADDRESS; a_port: INTEGER)
			-- Create server socket on `a_address' and `a_port'.
		require
			valid_port: a_port >= 0
		do
			make
			create address.make_from_address_and_port (a_address, a_port)
			bind
		end

	make_server_by_port (a_port: INTEGER)
			-- Create server socket on `a_port' and on any incoming address.
		require
			valid_port: a_port >= 0
		do
			make_server_by_address_and_port (create_any_local, a_port)
		end

	make_loopback_server_by_port (a_port: INTEGER)
			-- Create server socket on `a_port' that listen only for loopback interface peer.
		require
			valid_port: a_port >= 0
		do
			make_server_by_address_and_port (create_loopback, a_port)
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

feature {NETWORK_STREAM_SOCKET} -- Initialization

	make_from_descriptor_and_address (a_fd: INTEGER; a_address: attached separate like address)
		require
			a_fd_positive: a_fd > 0
			a_address_positive: a_address /= Void
		local
			l_address: attached like address
		do
			if attached {like address} a_address as non_separate_address then
				l_address := non_separate_address
			else
				create l_address.make_from_separate (a_address)
			end

			fd := a_fd
			address := l_address
			family := l_address.family
			descriptor_available := True
			is_closed := False
			is_created := True
			is_open_read := True
			is_open_write := True
			timeout_ns := one_second_in_nanoseconds * default_timeout.to_natural_64
			create last_string.make_empty
		ensure
			address_set: address ~ a_address
			address_equal: attached {like address} a_address implies address = a_address
			family_valid: family = a_address.family;
			opened_all: is_open_write and is_open_read
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

feature

	connect_timeout: INTEGER
			-- The connect timeout in milliseconds

	set_connect_timeout (a_timeout_ms: INTEGER)
			--  Sets the connect timeout in milliseconds
		do
			connect_timeout := a_timeout_ms
		end

	accept_timeout: INTEGER
			-- The connect timeout in milliseconds

	set_accept_timeout (a_timeout_ms: INTEGER)
			--  Sets the accept timeout in milliseconds
		do
			accept_timeout := a_timeout_ms
		end

	listen (queue: INTEGER)
			-- Listen on socket for at most `queue' connections.
		local
			l_fd, l_fd1: INTEGER
		do
			check address_attached: attached address as l_address then
				l_fd := fd
				l_fd1 := fd1
				c_listen ($l_fd, $l_fd1, l_address.socket_address.item, queue)
				fd := l_fd;
				fd1 := l_fd1;
			end
		end

	accept_to (other: separate like Current)
			-- Accept a new connection on listen socket.
			-- Socket of accepted connection is available in `other'.
		require
			not_created: not other.is_created
		do
			if attached address as l_address then
				do_accept (other, l_address)
			else
					-- Per inherited assertion
				check address_attached: False end
			end
		end

	accept
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		local
			l_accepted: like accepted
		do
			if attached address as l_address then
				accepted := Void
				create l_accepted.make_empty
				do_accept (l_accepted, l_address.twin)

				if l_accepted.is_created then
					accepted := l_accepted
				end
			else
					-- Per inherited assertion
				check address_attached: False end
			end
		end

feature -- Status report

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
			"Use `maximum_seg_size' instead [2017-05-31]."
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

	set_delay
			-- Switch option TCPNO_DELAY off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 0)
		end;

	set_nodelay
			-- Switch option TCPNO_DELAY on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 1)
		end;

	set_linger (flag: BOOLEAN; time: INTEGER)
		obsolete "Use `set_linger_on'/`set_linger_off' instead [2017-05-31]."
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

	do_connect (a_peer_address: like address)
		local
			l_fd, l_fd1, l_port: INTEGER
		do
			if a_peer_address /= Void then
				l_fd := fd
				l_fd1 := fd1
				l_port := internal_port
				c_connect ($l_fd, $l_fd1, $l_port, a_peer_address.socket_address.item, connect_timeout, is_blocking)
				fd := l_fd
				fd1 := l_fd1
				internal_port := l_port
			else
					-- Per precondition
				check has_peer_address: False end
			end
		end

	do_bind (a_address: like address)
		local
			l_fd, l_fd1, l_port: INTEGER
		do
			if a_address /= Void then
				l_fd := fd
				l_fd1 := fd1
				l_port := internal_port
				c_bind ($l_fd, $l_fd1, $l_port, a_address.socket_address.item)
				fd := l_fd
				fd1 := l_fd1
				internal_port := l_port
			else
					-- Per precondition
				check has_address: False end
			end
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

	do_accept (other: separate like Current; a_address: attached like address)
			-- Accept a new connection.
			-- The new socket is stored in `other'.
			-- If the accept fails, `other.is_created' is still False.
		require
			not_created: not other.is_created
		local
			retried: BOOLEAN
			pass_address: like address
			return: INTEGER;
			l_last_fd: like fd
		do
			if not retried then
				pass_address := a_address.twin
				l_last_fd := last_fd
				return := c_accept (fd, fd1, $l_last_fd, pass_address.socket_address.item, accept_timeout);
				last_fd := l_last_fd
				if return > 0 then
					other.make_from_descriptor_and_address (return, a_address)
					other.set_peer_address (pass_address)
						-- We preserve the blocking state specified on Current.
					if is_blocking then
						other.set_blocking
					else
						other.set_non_blocking
					end
				end
			end
		rescue
			if not assertion_violation then
				retried := True
				retry
			end
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
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
