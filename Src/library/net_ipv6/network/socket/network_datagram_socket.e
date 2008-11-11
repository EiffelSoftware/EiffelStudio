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
			copy, is_equal
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
			is_valid_peer_address
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
			create address.make_from_address_and_port (addr, a_port)
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

	send_to (a_packet: DATAGRAM_PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER) is
			-- Send `a_packet' to address `to_address'
		do
			-- TODO
		end

	received (size: INTEGER; flags: INTEGER): DATAGRAM_PACKET is
			-- Receive a packet.
			-- Who from is put into the `peer_address'.
		do
			-- TODO
		end

	put_string, putstring (s: STRING) is
		do
			-- TODO
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
		do
			-- TODO
		end

	put_character, putchar (c: CHARACTER) is
		do
			-- TODO
		end

	put_real, putreal (r: REAL) is
		do
			-- TODO
		end

	put_integer, putint, put_integer_32 (i: INTEGER) is
		do
			-- TODO
		end

	put_integer_8 (i: INTEGER_8) is
		do
			-- TODO
		end

	put_integer_16 (i: INTEGER_16) is
		do
			-- TODO
		end

	put_integer_64 (i: INTEGER_64) is
		do
			-- TODO
		end

	put_natural_8 (i: NATURAL_8) is
		do
			-- TODO
		end

	put_natural_16 (i: NATURAL_16) is
		do
			-- TODO
		end

	put_natural, put_natural_32 (i: NATURAL_32) is
		do
			-- TODO
		end

	put_natural_64 (i: NATURAL_64) is
		do
			-- TODO
		end

	put_boolean, putbool (b: BOOLEAN) is
		do
			-- TODO
		end

	put_double, putdouble (d: DOUBLE) is
		do
			-- TODO
		end

feature {NONE} -- Implementation

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
		do
		end

feature {NONE} -- Externals

	c_create (a_fd, a_fd1: TYPED_POINTER [INTEGER]) is
		external
			"C blocking"
		alias
			"en_socket_datagram_create"
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

