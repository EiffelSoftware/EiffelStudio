indexing

	description:
		"An unix stream socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_STREAM_SOCKET

inherit

	STREAM_SOCKET
		rename
			address as old_socket_address,
			cleanup as old_socket_cleanup,
			name as old_socket_name
		end

	UNIX_SOCKET
		undefine
			support_storable
		select
			address,
			cleanup,
			name
		end

creation {UNIX_STREAM_SOCKET}

	create_from_descriptor

creation

	make, make_client, make_server

feature -- Initialization

	make is
			-- Make an unix socket stream.
		do
			family := af_unix;
			type := sock_stream;			
			make_socket
		end;

	make_client (a_peer: STRING) is
			-- Create an unix stream client socket with peer
			-- address set to `a_peer'.
		require
			valid_path: a_peer /= Void
		do
			make;
			create peer_address.make;
			peer_address.set_path (clone (a_peer))
		end;

	make_server (a_name: STRING) is
			-- Create an unix stream server socket bound to local
			-- address `a_name'.
		require
			valid_path: a_name /= Void and then not a_name.is_empty
		do
			make;
			create address.make;
			address.set_path (clone (a_name));
			bind
		end

end -- class UNIX_STREAM_SOCKET



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

