indexing

	description:
		"Resources require for EiffelNet.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SOCKET_RESOURCES

feature -- Status report

	error: STRING is
			-- Output a related error message.
		do
			if address_not_readable then
				Result := "Address not readable"
			elseif socket_ok then
				Result := "Socket Ok"
			elseif protected_address then
				Result := "Address protected"
			elseif already_bound then
				Result := "Address already bound"
			elseif address_in_use then
				Result := "Address in use"
			elseif invalid_address then
				Result := "Address not available"
			elseif invalid_socket_handle then
				Result := "Address is a file"
			elseif bad_socket_handle then
				Result := "Socket invalid"
			elseif socket_family_not_supported then
				Result := "family not supported"
			elseif no_permission then
				Result := "No permission"
			elseif no_buffers then
				Result := "No buffers"
			elseif dtable_full then
				Result := "Descriptor table full"
			elseif not_connected then
				Result := "Not connected"
			elseif protocol_not_supported then
				Result := "Protocol not supported"
			elseif socket_would_block then
				Result := "Socket would block"
			elseif socket_in_use then
				Result := "Socket in use"
			elseif expired_socket then
				Result := "Socket expired"
			elseif connection_refused then
				Result := "Connection refused"
			elseif network then
				Result := "No network"
			elseif zero_option then
				Result := "Not an option"
			elseif connect_in_progress then
				Result := "Connection in progress"
			else
				Result := "Unknown error : " + c_errorno.out
			end
		end;

	error_number: INTEGER is
			-- Returned error number
		do
			Result := c_errorno
		end;

	socket_ok: BOOLEAN is
			-- No error
		do
			Result :=	(error_number = 0)
		end;

	socket_family_not_supported: BOOLEAN is
			-- Requested family is not supported.
		do
			Result := (error_number = family_no_support)
		end;

	address_not_readable: BOOLEAN is
			-- Unreadable address
		do
			Result := (error_number = unreadable)
		end;

	protected_address: BOOLEAN is
			-- No access to this address is allowed.
		do
			Result := (error_number = no_access)
		end;

	already_bound: BOOLEAN is
			-- Socket has already been bound.
		do
			Result := (error_number = bound_address)
		end;

	address_in_use: BOOLEAN is
			-- Address is in use by another socket.
		do
			Result := (error_number = busy_address)
		end;

	invalid_address: BOOLEAN is
			-- Address is not valid.
		do
			Result := (error_number = error_address)
		end;

	invalid_socket_handle: BOOLEAN is
			-- Socket descriptor is not valid.
		do
			Result := (error_number = no_socket)
		end;

	bad_socket_handle: BOOLEAN is
			-- Socket descriptor is bad.
		do
			Result := (error_number = bad_socket)
		end;

	no_permission: BOOLEAN is
			-- No permission is given to user for this socket.
		do
			Result := (error_number = c_permission)
		end;

	no_buffers: BOOLEAN is
			-- No more buffers available
		do
			Result := (error_number = no_buffs)
		end;

	dtable_full: BOOLEAN is
			-- Descriptor table is full
		do
			Result := (error_number = table_full)
		end;

	protocol_not_supported: BOOLEAN is
			-- Protocol is not supported on this platform.
		do
			Result := (error_number = proto_no_support)
		end;

	not_connected: BOOLEAN is
			-- Socket is not connect.
		do
			Result := (error_number = no_connect)
		end;

	socket_would_block: BOOLEAN is
			-- Call to read, write, etc would have blocked.
		do
			Result := (error_number = would_block)
		end;

	connect_in_progress: BOOLEAN is
			-- Call to connect returned on a non-blocking socket.
		do
			Result := (error_number = c_einprogress)
		end;

	socket_in_use: BOOLEAN is
			-- Socket is already in use.
		do
			Result := (error_number = in_use)
		end;

	expired_socket: BOOLEAN is
			-- Socket connection has expired.
		do
			Result := (error_number = socket_expire)
		end;

	connection_refused: BOOLEAN is
			-- Connection is refused (possibly due to security).
		do
			Result := (error_number = connect_refused)
		end;

	network: BOOLEAN is
			-- Socket failed due to network problems.
		do
			Result := (error_number = no_network)
		end;

	zero_option: BOOLEAN is
			-- No options provided
		do
			Result := (error_number = no_option)
		end

feature -- Externals: flags for send, sendto recv and recvfrom socket calls

	c_oobmsg: INTEGER is
			-- Out of bound message 
		external
			"C"
		end;

	c_peekmsg: INTEGER is
			-- Peek message
		external
			"C"
		end;

	c_msgdontroute: INTEGER is
			-- Do not route message
		external
			"C"
		end

feature {NONE} -- Externals: socket option levels

	level_sol_socket: INTEGER is
			-- SOL_SOCKET level of options
		external
			"C"
		end;

	level_nsproto_raw: INTEGER is
			-- NS_PROTO_RAW level of options
		external
			"C"
		end;

	level_nsproto_pe: INTEGER is
			-- NS_PROTO_PE level of options
		external
			"C"
		end;

	level_nsproto_spp: INTEGER is
			-- NS_PROTO_SPP level of options
		external
			"C"
		end;

	level_iproto_tcp: INTEGER is
			-- IP_PROTO_TCP level of options
		external
			"C"
		end;

	level_iproto_ip: INTEGER is
			-- IPPROTO_IP level of options	
		external
			"C"
		end;


feature {NONE} -- Externals: socket option names

	ipoptions: INTEGER is
			-- IP_OPTIONS option name
		external
			"C"
		end;

	tcpmax_seg: INTEGER is
			-- TCP_MAXSEG option name
		external
			"C"
		end;

	tcpno_delay: INTEGER is
			-- TCP_NODELAY option name
		external
			"C"
		end;

	so_headerson_input: INTEGER is
			-- SO_HEADERS_ON_INPUT option name
		external
			"C"
		end;

	so_headerson_output: INTEGER is
			-- SO_HEADERS_ON_OUTPUT option name
		external
			"C"
		end;

	so_defaultheaders: INTEGER is
			-- SO_DEFAULT_HEADERS option name
		external
			"C"
		end;

	so_lastheader: INTEGER is
			-- SO_LAST_HEADER option name
		external
			"C"
		end;

	somtu: INTEGER is
			-- SO_MTU option name
		external
			"C"
		end;

	soseqno: INTEGER is
			-- SO_SEQNO option name
		external
			"C"
		end;

	so_allpackets: INTEGER is
			-- SO_ALL_PACKETS option name
		external
			"C"
		end;

	so_nsiproute: INTEGER is
			-- SO_NSIP_ROUTE option name
		external
			"C"
		end;

	sobroadcast: INTEGER is
			-- SO_BROADCAST option name
		external
			"C"
		end;

	sodebug: INTEGER is
			-- SO_DEBUG option name
		external
			"C"
		end;

	so_dont_route: INTEGER is
			-- SO_DONTROUTE option name
		external
			"C"
		end;

	soerror: INTEGER is
			-- SO_ERROR option name
		external
			"C"
		end;

	so_keep_alive: INTEGER is
			-- SO_KEEPALIVE option name
		external
			"C"
		end;

	solinger: INTEGER is
			-- SO_LINGER option name
		external
			"C"
		end;

	so_oob_inline: INTEGER is
			-- SO_OOBINLINE option name
		external
			"C"
		end;

	so_rcv_buf: INTEGER is
			-- SO_RCVBUF option name
		external
			"C"
		end;

	so_snd_buf: INTEGER is
			-- SO_SNDBUF option name
		external
			"C"
		end;

	so_rcv_lowat: INTEGER is
			-- SO_RCVLOWAT option name
		external
			"C"
		end;

	so_snd_lowat: INTEGER is
			-- SO_SNDLOWAT option name
		external
			"C"
		end;

	so_rcv_timeo: INTEGER is
			-- SO_RCVTIMEO option name
		external
			"C"
		end;

	so_snd_timeo: INTEGER is
			-- SO_SNDTIMEO option name
		external
			"C"
		end;

	so_reuse_addr: INTEGER is
			-- SO_REUSEADDR option name
		external
			"C"
		end;

	sotype: INTEGER is
			-- SO_TYPE option name
		external
			"C"
		end;

	so_use_loopback: INTEGER is
			-- SO_USELOOPBACK option name
		external
			"C"
		end

feature {NONE} -- Externals: error messages

	c_errorno: INTEGER is
			-- C error number
		external
			"C"
		end;

	c_reset_error is
			-- Reset C error number.
		external
			"C"
		end;

	family_no_support: INTEGER is
			-- Family is not supported on this machine.
		external
			"C"
		end;

	proto_no_support: INTEGER is
			-- Protocol is not supported on this machine.
		external
			"C"
		end;

	table_full: INTEGER is
			-- Descriptor table is full.
		external
			"C"
		end;

	no_buffs: INTEGER is
			-- No buffer is available.
		external
			"C"
		end;

	c_permission: INTEGER is
			 -- No permission is given to user for this socket.
		external
			"C"
		end;

	bad_socket: INTEGER is
			-- Socket descriptor is bad.
		external
			"C"
		end;

	no_socket: INTEGER is
			-- Socket descriptor is not valid.
		external
			"C"
		end;

	error_address: INTEGER is
			-- Address is not valid.
		external
			"C"
		end;

	busy_address: INTEGER is
			-- Address is in use by another socket.
		external
			"C"
		end;

	bound_address: INTEGER is
			-- Socket has already been bound.
		external
			"C"
		end;

	no_access: INTEGER is
			-- No access to this address is allowed.
		external
			"C"
		end;

	unreadable: INTEGER is
			-- Unreadable address
		external
			"C"
		end;

	no_connect: INTEGER is
			-- Socket is not connect.
		external
			"C"
		end;

	would_block: INTEGER is
			-- Call to read, write, etc would have blocked.
		external
			"C"
		end;

	in_use: INTEGER is
			 -- Socket is already in use.
		external
			"C"
		end;

	socket_expire: INTEGER is
			-- Socket connection has expired.
		external
			"C"
		end;

	connect_refused: INTEGER is
			-- Connection is refused (possibly due to security).
		external
			"C"
		end;

	no_network: INTEGER is
			-- Socket failed due to network problems.
		external
			"C"
		end;

	no_option: INTEGER is
			-- No options provided
		external
			"C"
		end;

	c_einprogress: INTEGER is
			-- Call to connect returned on a non-blocking socket.
		external
			"C"
		end

feature	{NONE} -- Externals: socket types

	sock_raw: INTEGER is
			-- Raw socket
		external
			"C"
		end;

	sock_dgrm: INTEGER is
			-- Datagram socket
		external
			"C"
		end;

	sock_stream: INTEGER is
			-- Stream socket
		external
			"C"
		end

feature {NONE} -- Externals: socket families

	af_ns: INTEGER is
			-- Xerox Network System socket family.
		external
			"C"
		end;

	af_inet: INTEGER is
			-- Network (internet) socket family
		external
			"C"
		end;

	af_unix: INTEGER is
			-- Unix socket family
		external
			"C"
		end

feature {NONE} -- Externals: constants for fcnlt calls

	c_fgetown: INTEGER is
			-- C constant FGETOWN
		external
			"C"
		end;

	c_fsetown: INTEGER is
			-- C constant FSETOWN
		external
			"C"
		end;

	c_fsetfl: INTEGER is
			-- C constant FSETFL
		external
			"C"
		end;

	c_fgetfl: INTEGER is
			-- C constant FGETFL
		external
			"C"
		end;

	c_fndelay: INTEGER is
			-- C constant FNDELAY
		external
			"C"
		end;

	c_fasync: INTEGER is
			-- C constant FASYNC
		external
			"C"
		end

end -- class SOCKET_RESOURCES




--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

