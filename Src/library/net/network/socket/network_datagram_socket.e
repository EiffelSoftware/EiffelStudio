indexing

	description:
		"A network socket datagram.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class NETWORK_SOCKET_DGRAM

inherit

	NETWORK_SOCKET
		export
			{NONE} accept, listen
		redefine
			bind
		select
			bind
		end;

	NETWORK_SOCKET
		rename
			bind as socket_bind
		export
			{NONE} accept, listen
		end;

	SOCKET_DGRAM


creation

	make

feature	-- Initialization

	make is
			-- make a network datagram socket
		do
			family := af_inet;
			type := sock_dgrm;
			make_socket;
		end;

feature 	-- Basic operation

	bind is
			-- Bind the socket to a local address.
		do
			socket_bind;
			is_open_read := False;
			bound := True;
		end;


	make_peer_address is
			-- make a new peer address object
		do
			!!peer_address.make;
		end;

feature -- Status setting

	enable_broadcast is
		require
			valid_descriptor: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 1);
		end;

	disable_broadcast is
		require
			valid_descriptor: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 0);
		end;

feature 	-- Status report

	bound: BOOLEAN;

	broadcast_enabled: BOOLEAN is
		require
			valid_descriptor: exists;
		local
			is_set: INTEGER;
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sobroadcast);
			Result := is_set /= 0;
		end;

end	-- class NETWORK_SOCKET_DGRAM

--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
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
