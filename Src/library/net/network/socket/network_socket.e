indexing

	description:
		"A network socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class NETWORK_SOCKET

inherit

	SOCKET
		redefine
			address, set_peer_address
	end

creation {NETWORK_SOCKET}

	create_from_descriptor

feature -- Status Report

	address: NETWORK_SOCKET_ADDRESS
			-- local address of the socket

	port: INTEGER is
			--  port socket is bound to.
		require
			valid_socket: exists
			is_bound: is_open_read
		local
			ext: ANY
			temp_addr: like address
		do
			!!temp_addr.make
			ext := temp_addr.socket_address
			c_sock_name (descriptor, $ext, temp_addr.count)
			Result := temp_addr.port
		end

feature -- Status_setting

	set_peer_address (addr: like address) is
			-- set the peer address to addr
		require else
			same_type: addr.family = family
		do
			peer_address := addr
		end

	set_reuse_address is
			-- set the reuse option
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 1)
		end

	do_not_reuse_address is
			-- remove reuse option
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 0)
		end

	reuse_address: BOOLEAN is
			-- is reuse option set
		require
			socket_exists: exists
		local
			reuse: INTEGER
		do
			reuse := c_get_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr)
			Result := reuse /= 0
		end

end -- class NETWORK_SOCKET

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

