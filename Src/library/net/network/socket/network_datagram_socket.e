indexing

	description:
		"A network datagram socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_DATAGRAM_SOCKET

inherit

	NETWORK_SOCKET
		rename
			bind as socket_bind,
			close as socket_close
		select
			address,
			set_peer_address
		end

	DATAGRAM_SOCKET
		rename
			address as socket_address,
			set_peer_address as socket_set_peer_address
		end

creation

	make, make_client_by_port, make_bound_client_by_port,
	make_server_by_port,
	make_bound, make_targeted_to_hostname, make_targeted_to_ip
		

feature -- Initialization

	make is
			-- Make a network datagram socket.
		do
			c_reset_error
			family := af_inet;
			type := sock_dgrm;
			make_socket;
			is_open_write := True;
			is_open_read := True
		end;

	make_bound (a_port: INTEGER) is
			-- Make a network datagram socket bound to its well
			-- known local address with port `a_port'.
		local
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			create an_address.make_local_from_port (a_port);
			make_bound_to_address (an_address)
		end;

	make_targeted_to_hostname (a_hostname: STRING; a_peer_port: INTEGER) is
			-- Make a network datagram socket connected to
			-- hostname `a_hostname' and port `a_port'.
		local
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			create an_address.make_from_name_and_port (a_hostname, a_peer_port);
			make_connected_to_peer (an_address)
		end;

	make_targeted_to_ip (an_ip_number: STRING; a_peer_port: INTEGER) is
			-- Make a network datagram socket connected to
			-- hostname `a_hostname' and port `a_port'.
		local
			an_address: NETWORK_SOCKET_ADDRESS
		do
			c_reset_error
			create an_address.make_from_ip_and_port (an_ip_number, a_peer_port);
			make_connected_to_peer (an_address)
		end;

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING) is
		obsolete "Use `make_targeted_to' and `target_to' features."
			-- Make a network datagram client socket.
		require
			valid_peer_host: a_peer_host /= Void and then not a_peer_host.empty;
			valid_port: a_peer_port >= 0
		local
			h_address: HOST_ADDRESS;
			i, count: INTEGER;
			code: CHARACTER;
			is_hostname: BOOLEAN
		do
			make;
			is_open_write := True;
			count := a_peer_host.count
			from i := 1 until i > count or is_hostname loop
				code := a_peer_host.item (i);
				is_hostname := (code /= '.' and then (code < '0' or else code > '9'));
				i := i + 1
			end;
			if descriptor_available then
				create h_address.make;
				if is_hostname then
					h_address.set_address_from_name (a_peer_host)
				else
					h_address.set_host_address (a_peer_host)
				end;
				create peer_address.make;
				peer_address.set_host_address (h_address);
				peer_address.set_port (a_peer_port);
				create address.make;
				bind
			end
		end;

	make_bound_client_by_port (a_local_port, a_peer_port: INTEGER; a_peer_host: STRING) is
		obsolete "Use features `make_bound' and `target_to'."
			-- Make a bound network datagram client socket.
		require
			valid_peer_host: a_peer_host /= Void and then not a_peer_host.empty;
			valid_port: a_peer_port >= 0
		local
			h_address: HOST_ADDRESS;
			i, code: INTEGER;
			is_hostname: BOOLEAN
		do
			make;
			from i := 1 until i > a_peer_host.count or is_hostname loop
				code := a_peer_host.item_code (i);
				is_hostname := (code /= 46 and then (code < 48 or else code > 57));
				i := i + 1
			end;
			if descriptor_available then
				create h_address.make;
				if is_hostname then
					h_address.set_address_from_name (a_peer_host)
				else
					h_address.set_host_address (a_peer_host)
				end
				create peer_address.make;
				peer_address.set_host_address (h_address);
				peer_address.set_port (a_peer_port);
				create address.make;
				address.set_port (a_local_port);
				bind
			end
		end;

	make_server_by_port (a_port: INTEGER) is
		obsolete "Use feature `make_bound'."
			-- Make a network datagram server socket.
		require
			valid_port: a_port >= 0
		local
			h_address: HOST_ADDRESS
		do
			make;
			if descriptor_available then
				create h_address.make;
				h_address.set_in_address_any;
				create address.make;
				address.set_host_address (h_address);
				address.set_port (a_port);
				bind
			end
		end

feature -- Miscellaneous

	target_to_hostname (a_hostname: STRING; a_peer_port: INTEGER) is
			-- Connect socket to address provided by
			-- hostname `a_hostname' and port `a_port'.
		require
			socket_exists: exists
		local
			a_peer_address: NETWORK_SOCKET_ADDRESS
		do
			create a_peer_address.make_from_name_and_port (a_hostname, a_peer_port);
			connect_to_peer (a_peer_address);
		end;

	target_to_ip (an_ip_number: STRING; a_peer_port: INTEGER) is
			-- Connect socket to address provided by
			-- hostname `a_hostname' and port `a_port'.
		require
			socket_exists: exists
		local
			a_peer_address: NETWORK_SOCKET_ADDRESS
		do
			create a_peer_address.make_from_ip_and_port (an_ip_number, a_peer_port);
			connect_to_peer (a_peer_address);
		end;

	make_peer_address is
			-- Create peer address.
		do
			create peer_address.make
		end

feature -- Status setting

	enable_broadcast is
			-- Enable broadcasting.
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 1)
		end;

	disable_broadcast is
			-- Disable broadcasting.
		require
			valid_descriptor: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, sobroadcast, 0)
		end

feature -- Status report

	broadcast_enabled: BOOLEAN is
			-- Is broadcasting enabled ?
		require
			valid_descriptor: exists
		local
			is_set: INTEGER
		do
			is_set := c_get_sock_opt_int (descriptor, level_sol_socket, sobroadcast);
			Result := is_set /= 0
		end

end -- class NETWORK_DATAGRAM_SOCKET



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

