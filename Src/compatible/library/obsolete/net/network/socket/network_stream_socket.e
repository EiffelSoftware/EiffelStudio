note

	description:
		"A network stream socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	NETWORK_STREAM_SOCKET

inherit

	NETWORK_SOCKET
		undefine
			support_storable
		select
			address,
			set_peer_address
		end

	STREAM_SOCKET
		rename
			address as old_socket_address,
			set_peer_address as old_socket_set_peer_address
		undefine
			is_valid_peer_address, create_from_descriptor
		end

create {NETWORK_STREAM_SOCKET}

	create_from_descriptor

create
	make, make_client_by_port, make_server_by_port

create {NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address

feature -- Initialization

	make
			-- Create a network stream socket.
		do
			c_reset_error
			family := af_inet;
			type := sock_stream;
			make_socket
			timeout := default_timeout
		ensure
			timeout_set_to_default: timeout = default_timeout
		end;

	make_client_by_port (a_peer_port: INTEGER; a_peer_host: STRING)
				-- Create a client connection to `a_peer_host' on
				-- `a_peer_port'.
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
				is_hostname := (code /= 46 and then
					(code < 48 or else code > 57));
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

	make_server_by_port (a_port: INTEGER)
			-- Create server socket on `a_port'.
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

feature {NETWORK_STREAM_SOCKET} -- Initialization

	make_from_descriptor_and_address (a_fd: INTEGER; a_address: like address)
		require
			a_fd_positive: a_fd > 0
			a_address_positive: a_address /= Void
		do
			descriptor:= a_fd
			address := a_address
			family := a_address.family
			descriptor_available := True
			is_open_read := True
			is_open_write := True
			timeout := default_timeout
		ensure
			address_set: address = a_address
			family_valid: family = a_address.family;
			opened_all: is_open_write and is_open_read
		end

feature -- Status report

	maximum_seg_size: INTEGER
			-- Maximum segment size
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

	maxium_seg_size: INTEGER
			-- Maximum segment size
		obsolete
			"Use `maximum_seg_size' instead."
		require
			socket_exists: exists
		do
			Result := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpmax_seg)
		end

	has_delay: BOOLEAN
			-- Is option TCPNO_DELAY off.
		require
			socket_exists: exists
		local
			l_value: INTEGER
		do
			l_value := c_get_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay)
			Result := l_value = 0
		end;

	is_linger_on: BOOLEAN
			-- Is lingering switched on?
		require
			socket_exists: exists
		do
			Result := c_is_linger_on (descriptor)
		end;

	is_out_of_band_inline: BOOLEAN
			-- Are out-of-band packets sent inline?
		require
			socket_exists: exists
		local
			is_inline: INTEGER
		do
			is_inline := c_get_sock_opt_int (descriptor, level_sol_socket, so_oob_inline);
			Result := is_inline /= 0
		end

	linger_time: INTEGER
			-- Linger time
		require
			socket_exists: exists
		do
			Result := c_linger_time (descriptor)
		end;

feature -- Status setting

	set_delay
			-- Switch option TCPNO_DELAY off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 0)
		end;

	set_nodelay
			-- Switch option TCPNO_DELAY on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_iproto_tcp, tcpno_delay, 1)
		end;

	set_linger (flag: BOOLEAN; time: INTEGER)
		obsolete "Use `set_linger_on'/`set_linger_off' instead."
			-- Switch lingering on/off (depending on `flag') and set linger
			-- time to `time'.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, flag, time)
		end;

	set_linger_on (time: INTEGER)
			-- Switch lingering on and set linger time to `time'.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, True, time)
		end;

	set_linger_off
			-- Switch lingering off.
		require
			socket_exists: exists
		local
			valid_return: INTEGER
		do
			valid_return := c_set_sock_opt_linger (descriptor, True, 0)
		end;

	set_out_of_band_inline
			-- Switch "out of band packets inline" on.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 1)
		end;

	set_out_of_band_not_inline
			-- Switch "out of band packets inline" off.
		require
			socket_exists: exists
		do
			c_set_sock_opt_int (descriptor, level_sol_socket, so_oob_inline, 0)
		end;

feature {NONE} -- Externals

	c_set_sock_opt_linger (fd: INTEGER flag: BOOLEAN; time: INTEGER): INTEGER
		external
			"C"
		end;

	c_is_linger_on (fd: INTEGER): BOOLEAN
		external
			"C"
		end;

	c_linger_time (fd: INTEGER): INTEGER
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NETWORK_STREAM_SOCKET

