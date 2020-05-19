note

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
		export
			{NONE} all
		undefine
			socket_ok, error, copy, is_equal
		end

	NETWORK_SOCKET
		rename
			bind as socket_bind,
			close as socket_close
		end

	DATAGRAM_SOCKET
		undefine
			exists, is_valid_peer_address, is_valid_family, address_type,
			set_blocking, set_non_blocking
		redefine
			connect_to_peer
		end

create
	make_bound, make_loopback_bound, make_targeted

feature -- Initialization

	make
			-- Make a network datagram socket.
		do
			c_reset_error
			family := af_inet;
			type := sock_dgrm;
			make_socket;
			is_open_write := True;
			is_open_read := True
			set_default_timeout
		ensure then
			timeout_set_to_default: is_default_timeout
		end

	make_bound (a_port: INTEGER)
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
			set_default_timeout
		ensure
			timeout_set_to_default: is_default_timeout
		end

	make_loopback_bound (a_port: INTEGER)
			-- Make a network datagram socket bound to its well
			-- known loopback address with port `a_port'.
		local
			addr: INET_ADDRESS
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			addr := create_loopback
			create an_address.make_from_address_and_port (addr, a_port)
			make_bound_to_address (an_address)
			set_default_timeout
		ensure
			timeout_set_to_default: is_default_timeout
		end

	make_targeted (a_hostname: STRING_8; a_peer_port: INTEGER)
			-- Make a network datagram socket connected to
			-- hostname `a_hostname' and port `a_port'.
		local
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			create an_address.make_from_hostname_and_port (a_hostname, a_peer_port);
			make_connected_to_peer (an_address)
		ensure
			timeout_set_to_default: is_default_timeout
		end

feature -- Status report

	broadcast_enabled: BOOLEAN
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

	connect_to_peer (a_peer_address: like address)
			-- Target socket to `a_peer_address'.
		do
			set_peer_address (a_peer_address)
			if a_peer_address /= Void then
				c_connect (fd, fd1, a_peer_address.socket_address.item)
			else
					-- Per precondition
				check has_peer_address: False end
			end
		end

feature -- Status setting

	enable_broadcast
			-- Enable broadcasting.
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 1)
		end;

	disable_broadcast
			-- Disable broadcasting.
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 0)
		end

	send_to (a_packet: PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER)
			-- Send `a_packet' to address `to_address'
		local
			retried: BOOLEAN
			return_val: INTEGER;
		do
			if not retried then
				return_val := c_send_to (fd, fd1, a_packet.data.item, a_packet.count, flags, to_address.socket_address.item)
			end
		rescue
			retried := True
			retry
		end

	received (size: INTEGER; flags: INTEGER): PACKET
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		local
			return_val: INTEGER;
			a_last_fd: like last_fd
			p: MANAGED_POINTER
			l_peer_address: like peer_address
		do
			create p.make (size)
			a_last_fd := last_fd
			l_peer_address := peer_address
			if l_peer_address = Void then
				make_peer_address
					-- Per postcondition.
				check attached peer_address as l_address then
					l_peer_address := l_address
				end
			end
			create Result.make (size);
			return_val := c_recv_from (fd, fd1, $a_last_fd, p.item, size, flags, 0, l_peer_address.socket_address.item)
			if return_val >= 0 then
				p.resize (return_val)
				create Result.make_from_managed_pointer (p)
			end
		end

feature {NONE} -- Implementation

	make_peer_address
			-- Create a peer address.
		require
			address_attached: address /= Void
		do
			check address_attached: attached address as l_address then
				peer_address := l_address.twin
			end
		ensure
			peer_address_attached: peer_address /= Void
		end

	do_create
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

	do_connect (a_peer_address: like peer_address)
		do
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

feature {NONE} -- Externals

	c_create (a_fd, a_fd1: TYPED_POINTER [INTEGER])
		external
			"C blocking"
		alias
			"en_socket_datagram_create"
		end

	c_bind (a_fd, a_fd1, a_port: TYPED_POINTER [INTEGER]; an_address: POINTER)
		external
			"C blocking"
		alias
			"en_socket_datagram_bind"
		end

	c_connect (an_fd, an_fd1:INTEGER; an_address: POINTER)
		external
			"C blocking"
		alias
			"en_socket_datagram_connect"
		end

	c_recv_from (an_fd, an_fd1:INTEGER; a_last_fd: TYPED_POINTER [INTEGER]; buf: POINTER; len:INTEGER; flags: INTEGER; a_timeout: INTEGER; an_address: POINTER): INTEGER
		external
			"C blocking"
		alias
			"en_socket_datagram_rcv_from"
		end

	c_send_to (an_fd, an_fd1:INTEGER; buf: POINTER; len:INTEGER; flags: INTEGER; an_address: POINTER): INTEGER
		external
			"C blocking"
		alias
			"en_socket_datagram_send_to"
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

end -- class NETWORK_DATAGRAM_SOCKET

