indexing

	description:
		"A network socket stream.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class NETWORK_SOCKET_STREAM

inherit

	NETWORK_SOCKET

creation {NETWORK_SOCKET_STREAM}

	create_from_descriptor

creation

	make

feature	-- Initialization

	make is
			-- Create a network stream socket
		do
			family := af_inet;
			type := sock_stream;
			make_socket;
		end;

feature 	-- Status report
	
	maxium_seg_size: INTEGER is
		require
			socket_exists: exists;
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg);
		end;

feature	-- Status setting

	set_delay is
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 1);
		end;

	set_nodelay is
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 0);
		end;

	linger_time: INTEGER is
		require
			socket_exists: exists;
		do
			Result := c_linger_time (descriptor);
		end;

	is_linger_on: BOOLEAN is
		require
			socket_exists: exists;
		do
			Result := c_is_linger_on (descriptor);
		end;

	set_linger (flag: BOOLEAN; time: INTEGER) is
		require
			socket_exists: exists;
		local
			valid_return: INTEGER;
		do
			valid_return := c_set_sock_opt_linger (descriptor, flag, time);
		end;

	set_out_of_band_inline is
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 1);
		end;


	set_out_of_band_not_inline is
		require
			socket_exists: exists;
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 0);
		end;

	is_out_of_band_inline: BOOLEAN is
		require
			socket_exists: exists;
		local
			is_inline: INTEGER
		do
			is_inline := c_get_sock_opt_int (descriptor, level_sol_socket, so_oob_inline);
			Result := is_inline /= 0;
		end;


feature {NONE} -- Externals

	c_set_sock_opt_linger (fd: INTEGER flag: BOOLEAN; time: INTEGER): INTEGER is
		external
			"C"
		end;

	c_is_linger_on (fd: INTEGER): BOOLEAN is
		external
			"C"
		end;

	c_linger_time (fd: INTEGER): INTEGER is
		external
			"C"
		end;
end

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
