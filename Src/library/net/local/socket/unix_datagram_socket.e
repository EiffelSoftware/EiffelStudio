indexing

	description:
		"A unix socket datagram.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class UNIX_SOCKET_DGRAM

inherit

	UNIX_SOCKET
		export
			{NONE} accept, listen
		redefine
			bind
		select
			bind
		end;

	UNIX_SOCKET
		rename
			bind as socket_bind
		end;

	SOCKET_DGRAM

creation

	make

feature 	-- Initialization

	make is
			-- create a unix socket datagram
		do
			family := af_unix;
			type := sock_dgrm;			
			make_socket;
		end;

	bind is
			-- bind to the local address
		do
			socket_bind;
			is_open_read := False;
			bound := True;
		ensure then
			is_bound_ : bound;
			not_open_read: not is_open_read;
		end;

	bound: BOOLEAN;
		-- Socket is bound

	make_peer_address is
			-- create the peer address 
		do
			!!peer_address.make;
		end;


end 	-- class UNIX_SOCKET_DGRAM

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

