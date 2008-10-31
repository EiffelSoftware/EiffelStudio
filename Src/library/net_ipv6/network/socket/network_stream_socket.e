indexing

	description:
		"A network stream socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_STREAM_SOCKET

inherit

	INET_ADDRESS_FACTORY
		export {NONE}
			All
		undefine
			copy, is_equal
		end

	NETWORK_SOCKET
		undefine
			support_storable
		select
			address,
			peer_address,
			set_peer_address
		end

	STREAM_SOCKET
		rename
			address as old_socket_address,
			peer_address as old_socket_peer_address,
			set_peer_address as old_socket_set_peer_address
		undefine
			is_valid_peer_address
		end

create

	make, make_client_by_port, make_client_by_address_and_port, make_server_by_port

create {NETWORK_STREAM_SOCKET}

	make_from_fd

feature -- Initialization

	make is
			-- Create a network stream socket.
		do
			is_closed := True
			c_reset_error
			family := af_inet
			type := sock_stream;
			make_socket
			timeout := default_timeout
		ensure
			timeout_set_to_default: timeout = default_timeout
		end

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING) is
				-- Create a client connection to `a_peer_host' on
				-- `a_peer_port'.
		require
			valid_peer_host: a_peer_host /= Void and then not a_peer_host.is_empty
			valid_port: a_peer_port >= 0
		local
			an_address: INET_ADDRESS
		do
			an_address := create_from_name (a_peer_host)
			make_client_by_address_and_port (an_address, a_peer_port)
		end

	make_server_by_port (a_port: INTEGER) is
			-- Create server socket on `a_port'.
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

	make_client_by_address_and_port (a_peer_address: INET_ADDRESS; a_peer_port: INTEGER) is
				-- Create a client connection to `a_peer_host' on
				-- `a_peer_port'.
		require
			valid_peer_address: a_peer_address /= Void
			valid_port: a_peer_port >= 0
		do
			make
			create peer_address.make_from_address_and_port (a_peer_address, a_peer_port)
		end

feature {NETWORK_STREAM_SOCKET} -- Initialization

	make_from_fd (an_fd: INTEGER; an_address: like address) is
		do
			fd :=an_fd
			address := an_address
			family := address.family;
			descriptor_available := True;
			is_closed := False
			is_created := True
			is_open_read := True
			is_open_write := True
			timeout := default_timeout
		ensure
			family_valid: family = address.family;
			opened_all: is_open_write and is_open_read
		end

feature

	listen (queue: INTEGER) is
			-- Listen on socket for at most `queue' connections.
		do
			c_listen (Current, address.socket_address.item, queue)
		end

	accept is
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		local
			retried: BOOLEAN
			pass_address: like address
			return: INTEGER;
		do
			if not retried then
				pass_address := address.twin
				return := c_accept (Current, pass_address.socket_address.item, 0);
				if return > 0 then
					create accepted.make_from_fd (return, address.twin);
					accepted.set_peer_address (pass_address)
				else
					accepted := Void
				end
			end
		rescue
			if not assertion_violation then
				retried := True
				retry
			end
		end

feature -- Status report

	maximum_seg_size: INTEGER is
			-- Maximum segment size
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

	maxium_seg_size: INTEGER is
			-- Maximum segment size
		obsolete
			"Use `maximum_seg_size' instead."
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

	has_delay: BOOLEAN is
			-- Is option TCPNO_DELAY off.
		require
			socket_exists: exists
		local
			l_value: INTEGER
		do
			l_value := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay)
			Result := l_value = 0
		end;

	is_linger_on: BOOLEAN is
			-- Is lingering switched on?
		require
			socket_exists: exists
		do
			Result := c_is_linger_on (descriptor)
		end;

	is_out_of_band_inline: BOOLEAN is
			-- Are out-of-band packets sent inline?
		require
			socket_exists: exists
		local
			is_inline: INTEGER
		do
			is_inline := c_get_sock_opt_int (descriptor, level_sol_socket, so_oob_inline);
			Result := is_inline /= 0
		end

	linger_time: INTEGER is
			-- Linger time
		require
			socket_exists: exists
		do
			Result := c_linger_time (descriptor)
		end;

feature -- Status setting

	set_delay is
			-- Switch option TCPNO_DELAY off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 0)
		end;

	set_nodelay is
			-- Switch option TCPNO_DELAY on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 1)
		end;

	set_linger (flag: BOOLEAN; time: INTEGER) is
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

	set_linger_on (time: INTEGER) is
			-- Switch lingering on and set linger time to `time'.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, True, time)
		end;

	set_linger_off is
			-- Switch lingering off.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, True, 0)
		end;

	set_out_of_band_inline is
			-- Switch "out of band packets inline" on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 1)
		end;

	set_out_of_band_not_inline is
			-- Switch "out of band packets inline" off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 0)
		end;

feature {NONE} -- Implementation

	do_connect is
		do
			c_connect (Current, peer_address.socket_address.item, 0)
		end

	do_bind is
		do
			c_bind (Current, address.socket_address.item)
		end

	do_create
		do
			c_create(Current)
			is_created := True
		end

feature {NONE} -- Externals

	c_create (obj: NETWORK_STREAM_SOCKET) is
		external
			"C"
		alias
			"en_socket_stream_create"
		end

	c_connect (obj: NETWORK_STREAM_SOCKET; an_address: POINTER; a_timeout: INTEGER) is
		external
			"C"
		alias
			"en_socket_stream_connect"
		end

	c_bind (obj: NETWORK_STREAM_SOCKET; an_address: POINTER) is
		external
			"C"
		alias
			"en_socket_stream_bind"
		end

	c_listen (obj: NETWORK_STREAM_SOCKET; an_address: POINTER; a_queue: INTEGER) is
		external
			"C"
		alias
			"en_socket_stream_listen"
		end

	c_accept (obj: NETWORK_STREAM_SOCKET; an_address: POINTER; a_timeout: INTEGER): INTEGER is
		external
			"C"
		alias
			"en_socket_stream_accept"
		end

	c_set_sock_opt_linger (an_fd: INTEGER flag: BOOLEAN; time: INTEGER): INTEGER is
		external
			"C"
		end;

	c_is_linger_on (an_fd: INTEGER): BOOLEAN is
		external
			"C"
		end;

	c_linger_time (an_fd: INTEGER): INTEGER is
		external
			"C"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NETWORK_STREAM_SOCKET

