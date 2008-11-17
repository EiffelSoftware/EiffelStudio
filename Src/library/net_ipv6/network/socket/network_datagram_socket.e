indexing

	description:
		"Network datagram sockets"
	legal: "See notice at end of class."

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_DATAGRAM_SOCKET

inherit

	INET_ADDRESS_FACTORY
		export {NONE}
			All
		undefine
			socket_ok, error, copy, is_equal
		end

	NETWORK_SOCKET
		rename
			bind as socket_bind,
			close as socket_close
		select
			address,
			peer_address
		end

	DATAGRAM_SOCKET
		rename
			address as old_socket_address,
			peer_address as old_socket_peer_address
		undefine
			set_address, set_peer_address, is_valid_peer_address
		redefine
			connect_to_peer
		end

create

	make_bound, make_targeted

feature -- Initialization

	make is
			-- Make a network datagram socket.
		do
			c_reset_error
			family := af_inet;
			type := sock_dgrm;
			make_socket;
			is_open_write := True;
			is_open_read := True
			timeout := default_timeout
		ensure then
			timeout_set_to_default: timeout = default_timeout
		end

	make_bound (a_port: INTEGER) is
			-- Make a network datagram socket bound to its well
			-- known local address with port `a_port'.
		local
			addr: INET_ADDRESS
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			addr := create_any_local
			create an_address.make_from_address_and_port (addr, a_port)
			make_bound_to_address (an_address)
			timeout := default_timeout
		ensure
			timeout_set_to_default: timeout = default_timeout
		end

	make_targeted (a_hostname: STRING; a_peer_port: INTEGER) is
			-- Make a network datagram socket connected to
			-- hostname `a_hostname' and port `a_port'.
		local
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			create an_address.make_from_hostname_and_port (a_hostname, a_peer_port);
			make_connected_to_peer (an_address)
			timeout := default_timeout
		ensure
			timeout_set_to_default: timeout = default_timeout
		end

feature -- Status report

	broadcast_enabled: BOOLEAN is
			-- Is broadcasting enabled?
		require
			valid_descriptor: exists
		local
			is_set: INTEGER
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sobroadcast);
			Result := is_set /= 0
		end

feature

	connect_to_peer (a_peer_address: like address) is
			-- Target socket to `a_peer_address'.
		do
			set_peer_address (a_peer_address)
			c_connect (fd, fd1, a_peer_address.socket_address.item)
		end

feature -- Status setting

	enable_broadcast is
			-- Enable broadcasting.
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 1)
		end;

	disable_broadcast is
			-- Disable broadcasting.
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 0)
		end

	send_to (a_packet: PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER) is
			-- Send `a_packet' to address `to_address'
		local
			retried: BOOLEAN
			return_val: INTEGER;
		do
			if not retried then
				return_val := c_send_to (fd, fd1, a_packet.data.item, a_packet.count, flags, peer_address.socket_address.item)
			end
		rescue
			retried := True
			retry
		end

	received (size: INTEGER; flags: INTEGER): PACKET is
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		local
			retried: BOOLEAN
			return_val: INTEGER;
			a_last_fd: like last_fd
			p: MANAGED_POINTER
		do
			if not retried then
				create p.make (size)
				a_last_fd := last_fd
				if peer_address = Void then
					make_peer_address
				end
				create Result.make (size);
				return_val := c_recv_from (fd, fd1, $a_last_fd, p.item, size, flags, 0, peer_address.socket_address.item)
				if return_val >= 0 then
					p.resize (return_val)
					create Result.make_from_managed_pointer (p)
				end
			end
		end

feature {NONE} -- Implementation

	make_peer_address is
			-- Create a peer address.
		do
			peer_address := address.twin
		end

	do_create is
		local
			l_fd, l_fd1: INTEGER
		do
			l_fd := fd
			l_fd1 := fd1
			c_create($l_fd, $l_fd1)
			fd := l_fd
			fd1 := l_fd1
			is_created := True
		end

	do_connect is
		do
		end

	do_bind is
		local
			l_fd, l_fd1, l_port: INTEGER
		do
			l_fd := fd
			l_fd1 := fd1
			l_port := the_local_port
			c_bind ($l_fd, $l_fd1, $l_port, address.socket_address.item)
			fd := l_fd
			fd1 := l_fd1
			the_local_port := l_port
		end

feature {NONE} -- Externals

	c_create (a_fd, a_fd1: TYPED_POINTER [INTEGER]) is
		external
			"C blocking"
		alias
			"en_socket_datagram_create"
		end

	c_bind (a_fd, a_fd1, a_port: TYPED_POINTER [INTEGER]; an_address: POINTER) is
		external
			"C blocking"
		alias
			"en_socket_datagram_bind"
		end

	c_connect (an_fd, an_fd1:INTEGER; an_address: POINTER) is
		external
			"C blocking"
		alias
			"en_socket_datagram_connect"
		end

	c_recv_from (an_fd, an_fd1:INTEGER; a_last_fd: TYPED_POINTER [INTEGER]; buf: POINTER; len:INTEGER; flags: INTEGER; a_timeout: INTEGER; an_address: POINTER): INTEGER is
		external
			"C blocking"
		alias
			"en_socket_datagram_rcv_from"
		end

	c_send_to (an_fd, an_fd1:INTEGER; buf: POINTER; len:INTEGER; flags: INTEGER; an_address: POINTER): INTEGER is
		external
			"C blocking"
		alias
			"en_socket_datagram_send_to"
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

end -- class NETWORK_DATAGRAM_SOCKET

