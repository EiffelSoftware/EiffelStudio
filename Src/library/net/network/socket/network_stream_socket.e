indexing

	description:
		"A network stream socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_STREAM_SOCKET

inherit

	STREAM_SOCKET
		rename
			address as old_socket_address,
			set_peer_address as old_socket_set_peer_address
		end

	NETWORK_SOCKET
		undefine
			support_storable
		select
			address,
			set_peer_address
		end

creation {NETWORK_STREAM_SOCKET}

	create_from_descriptor

creation

	make, make_client_by_port, make_server_by_port

feature -- Initialization

	make is
			-- Create a network stream socket
		do
			c_reset_error
			family := af_inet;
			type := sock_stream;
			make_socket
			timeout := default_timeout
		ensure
			timeout_set_to_default: timeout = default_timeout
		end;

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING) is
		require
			valid_peer_host: a_peer_host /= Void and then 
					not a_peer_host.is_empty
			valid_port: a_peer_port >= 0
		local
			h_address: HOST_ADDRESS;
			i, code: INTEGER;
			is_hostname: BOOLEAN
		do
			make;
			from
				i := 1
			until
				i > a_peer_host.count or is_hostname
			loop
				code := a_peer_host.item_code (i);
				is_hostname := (code /= 46 and then (code < 48 or else code > 57));
				i := i + 1
			end;
			create h_address.make;
			if is_hostname then
				h_address.set_address_from_name (a_peer_host)
			else
				h_address.set_host_address (a_peer_host)
			end;
			create peer_address.make;
			peer_address.set_host_address (h_address);
			peer_address.set_port (a_peer_port)
		end;

	make_server_by_port (a_port: INTEGER) is
		require
			valid_port: a_port >= 0
		local
			h_address: HOST_ADDRESS
		do
			make;
			create h_address.make;
			h_address.set_in_address_any;
			create address.make;
			address.set_host_address (h_address);
			address.set_port (a_port);
			bind
		end

feature -- Status report

	maxium_seg_size: INTEGER is
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

feature -- Status setting

	set_delay is
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 1)
		end;

	set_nodelay is
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 0)
		end;

	linger_time: INTEGER is
		require
			socket_exists: exists
		do
			Result := c_linger_time (descriptor)
		end;

	is_linger_on: BOOLEAN is
		require
			socket_exists: exists
		do
			Result := c_is_linger_on (descriptor)
		end;

	set_linger (flag: BOOLEAN; time: INTEGER) is
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, flag, time)
		end;

	set_out_of_band_inline is
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 1)
		end;

	set_out_of_band_not_inline is
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 0)
		end;

	is_out_of_band_inline: BOOLEAN is
		require
			socket_exists: exists
		local
			is_inline: INTEGER
		do
			is_inline := c_get_sock_opt_int (descriptor, level_sol_socket, so_oob_inline);
			Result := is_inline /= 0
		end

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
		end
end -- class NETWORK_STREAM_SOCKET



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

