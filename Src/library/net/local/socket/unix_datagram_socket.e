indexing

	description:
		"An unix datagram socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_DATAGRAM_SOCKET

inherit

	UNIX_SOCKET
		rename
			bind as socket_bind,
			close as socket_close
		select
			name,
			cleanup,
			address
		end

	DATAGRAM_SOCKET
		rename
			name as socket_name,
			cleanup as socket_cleanup,
			address as socket_address
		end

creation

	make, make_bound, make_targeted

feature -- Initialization

	make is
			-- Create an unix datagram socket.
		do
			c_reset_error
			family := af_unix;
			type := sock_dgrm;
			make_socket;
			is_open_write := True
		end;

	make_bound (a_path: STRING) is
			-- Create an unix socket bound to a local well known
			-- address `a_path'.
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_path);
			make_bound_to_address (an_address)
		end;

	make_targeted (a_peer_path: STRING) is
			-- Create an unix socket targeted to `a_peer_path'.
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_peer_path);
			make_connected_to_peer (an_address)
		end

feature -- Miscellaneous

	target_to (a_peer_path: STRING) is
			-- Target socket to `a_peer_path'.
		require
			socket_exists: exists
		local
			an_address: UNIX_SOCKET_ADDRESS
		do
			create an_address.make_from_path (a_peer_path);
			connect_to_peer (an_address)
		end;

	make_peer_address is
			-- Create a peer address.
		do
			create peer_address.make
		end



end -- class UNIX_DATAGRAM_SOCKET



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

