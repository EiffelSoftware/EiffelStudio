indexing

	description:
		"A unix datagram socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class UNIX_DATAGRAM_SOCKET

inherit

	UNIX_SOCKET
		rename
			send as socket_send
		export
			{NONE} accept, listen, socket_send
		redefine
			bind
		select
			bind
		end

	UNIX_SOCKET
		rename
			bind as socket_bind,
			send as socket_send
		export
			{NONE} accept, listen, socket_send
		end

	DATAGRAM_SOCKET

creation

	make 

feature -- Initialization

	make is
			-- create a unix socket datagram
		do
			family := af_unix
			type := sock_dgrm
			make_socket
		end

	bind is
			-- bind to the local address
		do
			socket_bind
			is_open_read := False
			bound := True
		ensure then
			is_bound: bound
			not_open_read: not is_open_read
		end

	bound: BOOLEAN
			-- Socket is bound

	make_peer_address is
			-- create the peer address
		do
			!!peer_address.make
		end

end -- class UNIX_DATAGRAM_SOCKET

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

