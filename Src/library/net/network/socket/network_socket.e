indexing

	description:
		"A network socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	NETWORK_SOCKET

inherit

	SOCKET
		undefine
			send, put_character, putchar, put_string, putstring,
			put_integer, putint, put_boolean, putbool,
			put_real, putreal, put_double, putdouble
		redefine
			address, set_peer_address
	end

feature -- Status Report

	address: NETWORK_SOCKET_ADDRESS;
			-- Local address of socket

	port: INTEGER is
			-- Port socket is bound to.
		require
			valid_socket: exists
		local
			ext: ANY;
			temp_addr: like address
		do
			create temp_addr.make;
			ext := temp_addr.socket_address;
			c_sock_name (descriptor, $ext, temp_addr.count);
			Result := temp_addr.port
		end

feature -- Status_setting

	set_peer_address (addr: like address) is
			-- Set peer address to `addr'.
		require else
			same_type: addr.family = family
		do
			peer_address := addr
		end;

	set_reuse_address is
			-- Set the reuse_address option on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 1)
		end;

	do_not_reuse_address is
			-- Set reuse_address option off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr, 0)
		end;

	reuse_address: BOOLEAN is
			-- Is reuse_address option set ?
		require
			socket_exists: exists
		local
			reuse: INTEGER
		do
			reuse := c_get_sock_opt_int (descriptor, level_sol_socket, so_reuse_addr);
			Result := reuse /= 0
		end

end -- class NETWORK_SOCKET



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

