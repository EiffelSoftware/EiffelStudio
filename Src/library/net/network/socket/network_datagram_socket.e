indexing

	description:
		"A network datagram socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class NETWORK_DATAGRAM_SOCKET

inherit

	NETWORK_SOCKET
		rename
			send as socket_send
		export
			{NONE} accept, listen, socket_send
		redefine
			bind
		select
			bind
		end

	NETWORK_SOCKET
		rename
			bind as socket_bind,
			send as socket_send
		export
			{NONE} accept, listen, socket_send
		end

	DATAGRAM_SOCKET

creation

	make, make_client_by_port, make_server_by_port

feature -- Initialization

	make is
			-- make a network datagram socket
		do
			family := af_inet
			type := sock_dgrm
			make_socket
		end

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING) is
		require
			valid_peer_host: a_peer_host /= Void and then not a_peer_host.empty
			valid_port: a_peer_port >= 0
		local
			h_address: HOST_ADDRESS
			i, code: INTEGER
			is_hostname: BOOLEAN
		do
			make
			from i := 1 until i > a_peer_host.count or is_hostname loop
				code := a_peer_host.item_code (i)
				is_hostname := (code /= 46 and then (code < 48 or else code > 57))
				i := i + 1
			end
			!!h_address.make
			if is_hostname then
				h_address.set_address_from_name (a_peer_host)
			else
				h_address.set_host_address (a_peer_host)
			end
			!!peer_address.make
			peer_address.set_host_address (h_address)
			peer_address.set_port (a_peer_port)
			!!address.make
			bind
		end

	make_bound_client_by_port (a_local_port, a_peer_port: INTEGER; a_peer_host: STRING) is
		require
			valid_peer_host: a_peer_host /= Void and then not a_peer_host.empty
			valid_port: a_peer_port >= 0
		local
			h_address: HOST_ADDRESS
			i, code: INTEGER
			is_hostname: BOOLEAN
		do
			make
			from i := 1 until i > a_peer_host.count or is_hostname loop
				code := a_peer_host.item_code (i)
				is_hostname := (code /= 46 and then (code < 48 or else code > 57))
				i := i + 1
			end
			!!h_address.make
			if is_hostname then
				h_address.set_address_from_name (a_peer_host)
			else
				h_address.set_host_address (a_peer_host)
			end
			!!peer_address.make
			peer_address.set_host_address (h_address)
			peer_address.set_port (a_peer_port)
			!!address.make
			address.set_port (a_local_port)
			bind
		end

	make_server_by_port (a_port: INTEGER) is
		require
			valid_port: a_port >= 0
		local
			h_address: HOST_ADDRESS
		do
			make
			!!h_address.make
			h_address.set_in_address_any
			!!address.make
			address.set_host_address (h_address)
			address.set_port (a_port)
			bind
		end

feature -- Basic operation

	bind is
			-- Bind the socket to a local address.
		do
			socket_bind
			is_open_read := False
			bound := True
		end

	make_peer_address is
			-- make a new peer address object
		do
			!!peer_address.make
		end

feature -- Status setting

	enable_broadcast is
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 1)
		end

	disable_broadcast is
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 0)
		end

feature -- Status report

	bound: BOOLEAN

	broadcast_enabled: BOOLEAN is
		require
			valid_descriptor: exists
		local
			is_set: INTEGER
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sobroadcast)
			Result := is_set /= 0
		end

end -- class NETWORK_DATAGRAM_SOCKET

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

