note

	description:
		"Resources require for EiffelNet."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SOCKET_RESOURCES

feature -- Status report

	error: STRING
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
				Result := {STRING} "Unknown error : " + c_errorno.out
			end
		end;

	error_number: INTEGER
			-- Returned error number
		do
			Result := c_errorno
		end;

	socket_ok: BOOLEAN
			-- No error
		do
			Result := (error_number = 0)
		end;

	socket_family_not_supported: BOOLEAN
			-- Requested family is not supported.
		do
			Result := (error_number = family_no_support)
		end;

	address_not_readable: BOOLEAN
			-- Unreadable address
		do
			Result := (error_number = unreadable)
		end;

	protected_address: BOOLEAN
			-- No access to this address is allowed.
		do
			Result := (error_number = no_access)
		end;

	already_bound: BOOLEAN
			-- Socket has already been bound.
		do
			Result := (error_number = bound_address)
		end;

	address_in_use: BOOLEAN
			-- Address is in use by another socket.
		do
			Result := (error_number = busy_address)
		end;

	invalid_address: BOOLEAN
			-- Address is not valid.
		do
			Result := (error_number = error_address)
		end;

	invalid_socket_handle: BOOLEAN
			-- Socket descriptor is not valid.
		do
			Result := (error_number = no_socket)
		end;

	bad_socket_handle: BOOLEAN
			-- Socket descriptor is bad.
		do
			Result := (error_number = bad_socket)
		end;

	no_permission: BOOLEAN
			-- No permission is given to user for this socket.
		do
			Result := (error_number = c_permission)
		end;

	no_buffers: BOOLEAN
			-- No more buffers available
		do
			Result := (error_number = no_buffs)
		end;

	dtable_full: BOOLEAN
			-- Descriptor table is full
		do
			Result := (error_number = table_full)
		end;

	protocol_not_supported: BOOLEAN
			-- Protocol is not supported on this platform.
		do
			Result := (error_number = proto_no_support)
		end;

	not_connected: BOOLEAN
			-- Socket is not connect.
		do
			Result := (error_number = no_connect)
		end;

	socket_would_block: BOOLEAN
			-- Call to read, write, etc would have blocked.
		do
			Result := (error_number = would_block)
		end;

	connect_in_progress: BOOLEAN
			-- Call to connect returned on a non-blocking socket.
		do
			Result := (error_number = c_einprogress)
		end;

	socket_in_use: BOOLEAN
			-- Socket is already in use.
		do
			Result := (error_number = in_use)
		end;

	expired_socket: BOOLEAN
			-- Socket connection has expired.
		do
			Result := (error_number = socket_expire)
		end;

	connection_refused: BOOLEAN
			-- Connection is refused (possibly due to security).
		do
			Result := (error_number = connect_refused)
		end;

	network: BOOLEAN
			-- Socket failed due to network problems.
		do
			Result := (error_number = no_network)
		end;

	zero_option: BOOLEAN
			-- No options provided
		do
			Result := (error_number = no_option)
		end

feature -- Externals: flags for send, sendto recv and recvfrom socket calls

	c_oobmsg: INTEGER
			-- Out of bound message
		external
			"C"
		end;

	c_peekmsg: INTEGER
			-- Peek message
		external
			"C"
		end;

	c_msgdontroute: INTEGER
			-- Do not route message
		external
			"C"
		end

feature {NONE} -- Externals: socket option levels

	level_sol_socket: INTEGER
			-- SOL_SOCKET level of options
		external
			"C"
		end;

	level_nsproto_raw: INTEGER
			-- NS_PROTO_RAW level of options
		external
			"C"
		end;

	level_nsproto_pe: INTEGER
			-- NS_PROTO_PE level of options
		external
			"C"
		end;

	level_nsproto_spp: INTEGER
			-- NS_PROTO_SPP level of options
		external
			"C"
		end;

	level_iproto_tcp: INTEGER
			-- IP_PROTO_TCP level of options
		external
			"C"
		end;

	level_iproto_ip: INTEGER
			-- IPPROTO_IP level of options
		external
			"C"
		end;


feature {NONE} -- Externals: socket option names

	ipoptions: INTEGER
			-- IP_OPTIONS option name
		external
			"C"
		end;

	tcpmax_seg: INTEGER
			-- TCP_MAXSEG option name
		external
			"C"
		end;

	tcpno_delay: INTEGER
			-- TCP_NODELAY option name
		external
			"C"
		end;

	so_headerson_input: INTEGER
			-- SO_HEADERS_ON_INPUT option name
		external
			"C"
		end;

	so_headerson_output: INTEGER
			-- SO_HEADERS_ON_OUTPUT option name
		external
			"C"
		end;

	so_defaultheaders: INTEGER
			-- SO_DEFAULT_HEADERS option name
		external
			"C"
		end;

	so_lastheader: INTEGER
			-- SO_LAST_HEADER option name
		external
			"C"
		end;

	somtu: INTEGER
			-- SO_MTU option name
		external
			"C"
		end;

	soseqno: INTEGER
			-- SO_SEQNO option name
		external
			"C"
		end;

	so_allpackets: INTEGER
			-- SO_ALL_PACKETS option name
		external
			"C"
		end;

	so_nsiproute: INTEGER
			-- SO_NSIP_ROUTE option name
		external
			"C"
		end;

	sobroadcast: INTEGER
			-- SO_BROADCAST option name
		external
			"C"
		end;

	sodebug: INTEGER
			-- SO_DEBUG option name
		external
			"C"
		end;

	so_dont_route: INTEGER
			-- SO_DONTROUTE option name
		external
			"C"
		end;

	soerror: INTEGER
			-- SO_ERROR option name
		external
			"C"
		end;

	so_keep_alive: INTEGER
			-- SO_KEEPALIVE option name
		external
			"C"
		end;

	solinger: INTEGER
			-- SO_LINGER option name
		external
			"C"
		end;

	so_oob_inline: INTEGER
			-- SO_OOBINLINE option name
		external
			"C"
		end;

	so_rcv_buf: INTEGER
			-- SO_RCVBUF option name
		external
			"C"
		end;

	so_snd_buf: INTEGER
			-- SO_SNDBUF option name
		external
			"C"
		end;

	so_rcv_lowat: INTEGER
			-- SO_RCVLOWAT option name
		external
			"C"
		end;

	so_snd_lowat: INTEGER
			-- SO_SNDLOWAT option name
		external
			"C"
		end;

	so_rcv_timeo: INTEGER
			-- SO_RCVTIMEO option name
		external
			"C"
		end;

	so_snd_timeo: INTEGER
			-- SO_SNDTIMEO option name
		external
			"C"
		end;

	so_reuse_addr: INTEGER
			-- SO_REUSEADDR option name
		external
			"C"
		end;

	sotype: INTEGER
			-- SO_TYPE option name
		external
			"C"
		end;

	so_use_loopback: INTEGER
			-- SO_USELOOPBACK option name
		external
			"C"
		end

feature {NONE} -- Externals: error messages

	c_errorno: INTEGER
			-- C error number
		external
			"C"
		end;

	c_reset_error
			-- Reset C error number.
		external
			"C"
		end;

	family_no_support: INTEGER
			-- Family is not supported on this machine.
		external
			"C"
		end;

	proto_no_support: INTEGER
			-- Protocol is not supported on this machine.
		external
			"C"
		end;

	table_full: INTEGER
			-- Descriptor table is full.
		external
			"C"
		end;

	no_buffs: INTEGER
			-- No buffer is available.
		external
			"C"
		end;

	c_permission: INTEGER
			 -- No permission is given to user for this socket.
		external
			"C"
		end;

	bad_socket: INTEGER
			-- Socket descriptor is bad.
		external
			"C"
		end;

	no_socket: INTEGER
			-- Socket descriptor is not valid.
		external
			"C"
		end;

	error_address: INTEGER
			-- Address is not valid.
		external
			"C"
		end;

	busy_address: INTEGER
			-- Address is in use by another socket.
		external
			"C"
		end;

	bound_address: INTEGER
			-- Socket has already been bound.
		external
			"C"
		end;

	no_access: INTEGER
			-- No access to this address is allowed.
		external
			"C"
		end;

	unreadable: INTEGER
			-- Unreadable address
		external
			"C"
		end;

	no_connect: INTEGER
			-- Socket is not connect.
		external
			"C"
		end;

	would_block: INTEGER
			-- Call to read, write, etc would have blocked.
		external
			"C"
		end;

	in_use: INTEGER
			 -- Socket is already in use.
		external
			"C"
		end;

	socket_expire: INTEGER
			-- Socket connection has expired.
		external
			"C"
		end;

	connect_refused: INTEGER
			-- Connection is refused (possibly due to security).
		external
			"C"
		end;

	no_network: INTEGER
			-- Socket failed due to network problems.
		external
			"C"
		end;

	no_option: INTEGER
			-- No options provided
		external
			"C"
		end;

	c_einprogress: INTEGER
			-- Call to connect returned on a non-blocking socket.
		external
			"C"
		end

feature	{NONE} -- Externals: socket types

	sock_raw: INTEGER
			-- Raw socket
		external
			"C"
		end;

	sock_dgrm: INTEGER
			-- Datagram socket
		external
			"C"
		end;

	sock_stream: INTEGER
			-- Stream socket
		external
			"C"
		end

feature {NONE} -- Externals: socket families

	af_ns: INTEGER
			-- Xerox Network System socket family.
		external
			"C"
		end;

	af_inet: INTEGER
			-- Network (internet) socket family
		external
			"C"
		end;

	af_inet6: INTEGER
			-- Network (internet) socket family
		external
			"C"
		end;

	af_unix: INTEGER
			-- Unix socket family
		external
			"C"
		end

feature {NONE} -- Externals: constants for fcnlt calls

	c_fgetown: INTEGER
			-- C constant FGETOWN
		external
			"C"
		end;

	c_fsetown: INTEGER
			-- C constant FSETOWN
		external
			"C"
		end;

	c_fsetfl: INTEGER
			-- C constant FSETFL
		external
			"C"
		end;

	c_fgetfl: INTEGER
			-- C constant FGETFL
		external
			"C"
		end;

	c_fndelay: INTEGER
			-- C constant FNDELAY
		external
			"C"
		end;

	c_fasync: INTEGER
			-- C constant FASYNC
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SOCKET_RESOURCES

