class UTILITY

feature
	ERR_NO_ERROR: INTEGER = -1
	ERR_NOT_DEFINED: INTEGER = 0
	ERR_FILE_NOT_FOUND: INTEGER = 1
	ERR_ACCESS_VIOLATION: INTEGER = 2
	ERR_DISK_FULL: INTEGER = 3
	ERR_ILLEGAL_OP: INTEGER = 4
	ERR_UNKNOWN_TRANS_ID: INTEGER = 5
	ERR_FILE_EXISTS: INTEGER = 6
	ERR_NO_SUCH_USER: INTEGER = 7

feature

	send_ack (socket: NETWORK_DATAGRAM_SOCKET; address: INET_ADDRESS; port: INTEGER; block_number: INTEGER) is
			-- Send the TFPT ACK packet for block_number to the client identified by address and port
			-- via the socket
		require
			address_non_void: address /= Void
			socket_non_void: socket /= Void
			socket_valid: socket.is_open_write
		local
			pkt: TFTP_ACK_PACKET
		do
			create pkt.make_from_address_block (address, port, block_number)
			send_packet (socket, pkt)
		end

	send_error (socket: NETWORK_DATAGRAM_SOCKET; address: INET_ADDRESS; port: INTEGER; code: INTEGER; message: STRING) is
			-- Send the TFPT ERROR packet to the client identified by address and port
			-- via the socket
		require
			address_non_void: address /= Void
			socket_non_void: socket /= Void
			socket_valid: socket.is_open_write
		local
			pkt: TFTP_ERROR_PACKET
		do
			create pkt.make_from_address_code_message (address, port, code, message)
			send_packet (socket, pkt)
		end

	send_data_packet (socket: NETWORK_DATAGRAM_SOCKET; address: INET_ADDRESS; port: INTEGER; block_number: INTEGER; data: MANAGED_POINTER; data_length: INTEGER) is
			-- Send the TFPT DATA packet to the client identified by address and port
			-- via the socket
		require
			address_non_void: address /= Void
			socket_non_void: socket /= Void
			socket_valid: socket.is_open_write
		local
			pkt: TFTP_DATA_PACKET
		do
			create pkt.make_from_address_code_data (address, port, block_number, data, data_length)
			send_packet (socket, pkt)
		end

	send_packet (socket: NETWORK_DATAGRAM_SOCKET; packet: TFTP_PACKET) is
			--
		require
			socket_non_void: socket /= Void
			socket_valid: socket.is_open_write
			packet_not_void: packet /= Void
		do
			socket.send_to (create {PACKET}.make_from_managed_pointer (packet.data_pointer), create {NETWORK_SOCKET_ADDRESS}.make_from_address_and_port (packet.host, packet.port), 0)
		end

	receive_request (socket: NETWORK_DATAGRAM_SOCKET): TFTP_REQUEST_PACKET is
			-- Receive the TFTP read request or tftp write request packet.
			-- Other packets that are not read/write requests are silently discarded
		require
			socket_non_void: socket /= Void
			socket_valid: socket.is_bound and then socket.is_open_read
		local
			done: BOOLEAN
			packet: TFTP_PACKET
		do
			from
				done := False
			until
				done
			loop
				packet := receive (socket)
				if packet /= Void then
					if packet.opcode = {TFTP_PACKET}.rrq or else packet.opcode = {TFTP_PACKET}.wrq then
						Result ?= packet
						done := True
					end
				end
			end
		ensure
			Result /= Void
		end

	receive (socket: NETWORK_DATAGRAM_SOCKET): TFTP_PACKET is
			-- Receive the TFTP packet
		require
			socket_non_void: socket /= Void
			socket_valid: socket.is_open_read
		local
			packet: PACKET
			p: MANAGED_POINTER;
			opcode: NATURAL_16
		do
			packet := socket.received (516, 0)
			if packet /= Void then
				p := packet.data
				opcode := (p.read_natural_8 (0).as_natural_16 |<< 8) | (p.read_natural_8 (1).as_natural_16)
				if opcode >= {TFTP_PACKET}.rrq and then opcode <= {TFTP_PACKET}.error then
					Result := create_tftp_packet_from_sockaddr_managed_pointer (socket.peer_address, opcode, p)
				end
			end
		end

	create_error_message_from_id (message_id: INTEGER; default_msg: STRING): STRING is
		do
			if message_id > ERR_NOT_DEFINED and then message_id <= ERR_NO_SUCH_USER then
        			Result := err_strings.item(message_id + 1)
			else
        			Result := default_msg
			end
		end

	create_error_message_from_packet (packet: TFTP_PACKET): STRING is
		local
			p: TFTP_ERROR_PACKET
		do
			p ?= packet
			Result := p.message
		end

feature {NONE} -- Implementation

	create_tftp_packet_from_sockaddr_managed_pointer (addr: NETWORK_SOCKET_ADDRESS; opcode: NATURAL_16; p: MANAGED_POINTER): TFTP_PACKET is
			--
		require
			addr_non_void: addr /= Void
		do
			inspect opcode
			when  {TFTP_PACKET}.rrq then
				create {TFTP_REQUEST_PACKET}Result.make_from_host_port_managed_pointer (addr.host_address, addr.port, opcode, p)
			when  {TFTP_PACKET}.wrq then
				create {TFTP_REQUEST_PACKET}Result.make_from_host_port_managed_pointer (addr.host_address, addr.port,opcode, p)
			when  {TFTP_PACKET}.data then
				create {TFTP_DATA_PACKET}Result.make_from_host_port_managed_pointer (addr.host_address, addr.port,opcode, p)
			when  {TFTP_PACKET}.ack then
				create {TFTP_ACK_PACKET}Result.make_from_host_port_managed_pointer (addr.host_address, addr.port,opcode, p)
			when  {TFTP_PACKET}.error then
				create {TFTP_ERROR_PACKET}Result.make_from_host_port_managed_pointer (addr.host_address, addr.port,opcode, p)
			end
		end


	err_strings: ARRAY[STRING] is
		once
			Result := << "Unknown error","File not found","Access violation",
				"Disk full or allocation exceeded", "Illegal TFTP operation",
				"Unknown transfer ID", "File already exists","No such user">>
		end
end
