indexing

	description:
		"A unix stream socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class UNIX_STREAM_SOCKET

inherit

	UNIX_SOCKET

creation {UNIX_STREAM_SOCKET}

	create_from_descriptor

creation

	make, make_client, make_server

feature -- Initialization

	make is
			-- Make a unix socket stream
		do
			family := af_unix
			type := sock_stream;			
			make_socket
		end

	make_client (a_peer: STRING) is
			-- create a unix stream socket and
			-- create the peer address with a path
			-- of 'a_name'
		require
			valid_path: a_peer /= Void
		do
			make
			!!peer_address.make
			peer_address.set_path (clone (a_peer))
		end

	make_server (a_name: STRING) is
			-- create a unix stream socket bind
			-- it to path 'a_name'  
		require
			valid_path: a_name /= Void and then not a_name.empty
		do
			make
			!!address.make
			address.set_path (clone (a_name))
			bind
		end

end -- class UNIX_STREAM_SOCKET

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

