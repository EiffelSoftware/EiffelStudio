indexing

	description:
		"Resources require for EiffelNet.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SOCKET_RESOURCES

feature -- Status report

	error is
			-- output an error message 
		do
			if address_not_readable then
				io.error.putstring ("Address not readable %N")
			elseif socket_ok then
				io.error.putstring ("Socket Ok %N")
			elseif protected_address then
				io.error.putstring ("Address protected %N")
			elseif already_bound then
				io.error.putstring ("Address already bound %N")
			elseif address_in_use then
				io.error.putstring ("Address in use %N")
			elseif invalid_address then
				io.error.putstring ("Address not available %N")
			elseif invalid_socket_handle then
				io.error.putstring ("Address is a file %N")
			elseif bad_socket_handle then
				io.error.putstring ("socket_invalid %N")
			elseif socket_family_not_supported then
				io.error.putstring ("family not supported %N")
			elseif no_permission then
				io.error.putstring ("no permission %N")
			elseif no_buffers then
				io.error.putstring ("no buffers %N")
			elseif dtable_full then
				io.error.putstring ("descriptor table full %N")
			elseif not_connected then
				io.error.putstring ("not connected %N")
			elseif protocol_not_supported then
				io.error.putstring ("protocol not supported %N")
			elseif socket_would_block then
				io.error.putstring ("socket would block %N")
			elseif socket_in_use then
				io.error.putstring ("socket in use %N")
			elseif expired_socket then
				io.error.putstring ("socket expired %N")
			elseif connection_refused then
				io.error.putstring ("connection refused %N")
			elseif network then
				io.error.putstring ("no network %N")
			elseif zero_option then
				io.error.putstring ("not an option %N")
			elseif connect_in_progress then
				io.error.putstring ("Connection in progress")
			else
				io.error.putstring( "Unknown error : ")
				io.error.putint (c_errorno)
			end
		end

	error_number: INTEGER is
			-- returned error number
		do
			Result := c_errorno
		end

	socket_ok: BOOLEAN is
			-- no error state
		do
			Result :=  (error_number = 0)
		end

	socket_family_not_supported: BOOLEAN is
			-- requested family is not supported
		do
			Result := (error_number = family_no_support)
		end

	address_not_readable: BOOLEAN is
			-- unreadable address
		do
			Result := (error_number = unreadable)
		end

	protected_address: BOOLEAN is
			-- no access to this address allowed
		do
			Result := (error_number = no_access)
		end

	already_bound: BOOLEAN is
			-- socket has already been bound
		do
			Result := (error_number = bound_address)
		end

	address_in_use: BOOLEAN is
			-- address in use by another socket
		do
			Result := (error_number = busy_address)
		end

	invalid_address: BOOLEAN is
			-- address not valid
		do
			Result := (error_number = error_address)
		end

	invalid_socket_handle: BOOLEAN is
			-- socket descriptor is not valid
		do
			Result := (error_number = no_socket)
		end

	bad_socket_handle: BOOLEAN is
			-- socket descriptor is bad
		do
			Result := (error_number = bad_socket)
		end

	no_permission: BOOLEAN is
			-- no permission is given to user for this socket
		do
			Result := (error_number = c_permission)
		end

	no_buffers: BOOLEAN is
			-- no more buffers available
		do
			Result := (error_number = no_buffs)
		end

	dtable_full: BOOLEAN is
			-- descriptor table is full
		do
			Result := (error_number = table_full)
		end

	protocol_not_supported: BOOLEAN is
			-- protocol not supported on this platform
		do
			Result := (error_number = proto_no_support)
		end

	not_connected: BOOLEAN is
			-- socket is not connect
		do
			Result := (error_number = no_connect)
		end

	socket_would_block: BOOLEAN is
			-- call to read, write, etc would have blocked
		do
			Result := (error_number = would_block)
		end

	connect_in_progress: BOOLEAN is
			-- call to connect has returned on a non blocking socket
		do
			Result := (error_number = c_einprogress)
		end

	socket_in_use: BOOLEAN is
			-- socket is already in use
		do
			Result := (error_number = in_use)
		end

	expired_socket: BOOLEAN is
			-- socket connection has expired
		do
			Result := (error_number = socket_expire)
		end

	connection_refused: BOOLEAN is
			-- connection is refused (possibly due to security)
		do
			Result := (error_number = connect_refused)
		end

	network: BOOLEAN is
			-- socket failed due to network problems
		do
			Result := (error_number = no_network)
		end

	zero_option: BOOLEAN is
			-- no options provided
		do
			Result := (error_number = no_option)
		end

feature -- Externals
			-- flags for send, sendto recv and recvfrom socket calls

	c_oobmsg: INTEGER is
			-- out of bound message 
		external
			"C"
		end

	c_peekmsg: INTEGER is
			-- Peek message
		external
			"C"
		end

	c_msgdontroute: INTEGER is
			-- do not route message
		external
			"C"
		end

feature {NONE} -- Externals
			-- for socket options

	level_sol_socket: INTEGER is
		external
			"C"
		end

	level_nsproto_raw: INTEGER is
		external
			"C"
		end

	level_nsproto_pe: INTEGER is
		external
			"C"
		end

	level_nsproto_spp: INTEGER is
		external
			"C"
		end

	level_iproto_tcp: INTEGER is
		external
			"C"
		end

	level_iproto_ip: INTEGER is
		external
			"C"
		end

	ipoptions: INTEGER is
		external
			"C"
		end

	tcpmax_seg: INTEGER is
		external
			"C"
		end

	tcpno_delay: INTEGER is
		external
			"C"
		end

	so_headerson_input: INTEGER is
		external
			"C"
		end

	so_headerson_output: INTEGER is
		external
			"C"
		end

	so_defaultheaders: INTEGER is
		external
			"C"
		end

	so_lastheader: INTEGER is
		external
			"C"
		end

	somtu: INTEGER is
		external
			"C"
		end

	soseqno: INTEGER is
		external
			"C"
		end

	so_allpackets: INTEGER is
		external
			"C"
		end

	so_nsiproute: INTEGER is
		external
			"C"
		end

	sobroadcast: INTEGER is
		external
			"C"
		end

	sodebug: INTEGER is
		external
			"C"
		end

	so_dont_route: INTEGER is
		external
			"C"
		end

	soerror: INTEGER is
		external
			"C"
		end

	so_keep_alive: INTEGER is
		external
			"C"
		end

	solinger: INTEGER is
		external
			"C"
		end

	so_oob_inline: INTEGER is
		external
			"C"
		end

	so_rcv_buf: INTEGER is
		external
			"C"
		end

	so_snd_buf: INTEGER is
		external
			"C"
		end

	so_rcv_lowat: INTEGER is
		external
			"C"
		end

	so_snd_lowat: INTEGER is
		external
			"C"
		end

	so_rcv_timeo: INTEGER is
		external
			"C"
		end

	so_snd_timeo: INTEGER is
		external
			"C"
		end

	so_reuse_addr: INTEGER is
		external
			"C"
		end

	sotype: INTEGER is
		external
			"C"
		end

	so_use_loopback: INTEGER is
		external
			"C"
		end

feature {NONE} -- Externals 
			-- for error messages

	c_errorno: INTEGER is
			-- c error number
		external
			"C"
		end

	family_no_support: INTEGER is
			-- family not supported on this machine
		external
			"C"
		end

	proto_no_support: INTEGER is
			-- Protocol not supported on this machine
		external
			"C"
		end

	table_full: INTEGER is
			-- Descriptor table full
		external
			"C"
		end

	no_buffs: INTEGER is
			-- No buffers available
		external
			"C"
		end

	c_permission: INTEGER is
		external
			"C"
		end

	bad_socket: INTEGER is
		external
			"C"
		end

	no_socket: INTEGER is
		external
			"C"
		end

	error_address: INTEGER is
		external
			"C"
		end

	busy_address: INTEGER is
		external
			"C"
		end

	bound_address: INTEGER is
		external
			"C"
		end

	no_access: INTEGER is
		external
			"C"
		end

	unreadable: INTEGER is
		external
			"C"
		end

	no_connect: INTEGER is
		external
			"C"
		end

	would_block: INTEGER is
		external
			"C"
		end

	in_use: INTEGER is
		external
			"C"
		end

	socket_expire: INTEGER is
		external
			"C"
		end

	connect_refused: INTEGER is
		external
			"C"
		end

	no_network: INTEGER is
		external
			"C"
		end

	no_option: INTEGER is
		external
			"C"
		end

	c_einprogress: INTEGER is
		external
			"C"
		end

feature  {NONE} -- External
			-- socket types

	sock_raw: INTEGER is
			-- raw socket
		external
			"C"
		end

	sock_dgrm: INTEGER is
			-- datagram socket
		external
			"C"
		end

	sock_stream: INTEGER is
			-- stream socket
		external
			"C"
		end

feature {NONE} -- External
			-- socket families

	af_ns: INTEGER is
			-- NS socket
		external
			"C"
		end

	af_inet: INTEGER is
			-- network socket
		external
			"C"
		end

	af_unix: INTEGER is
			-- unix socket
		external
			"C"
		end

feature {NONE} -- Externals
			-- constants for fcnlt calls

	c_fgetown: INTEGER is
			-- C constant FGETOWN
		external
			"C"
		end

	c_fsetown: INTEGER is
			-- C constant FSETOWN
		external
			"C"
		end

	c_fsetfl: INTEGER is
			-- C constant FSETFL
		external
			"C"
		end

	c_fgetfl: INTEGER is
			-- C constant FGETFL
		external
			"C"
		end

	c_fndelay: INTEGER is
			-- C constant FNDELAY
		external
			"C"
		end

	c_fasync: INTEGER is
			-- C constant FASYNC
		external
			"C"
		end

end -- class SOCKET_RESOURCES

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

