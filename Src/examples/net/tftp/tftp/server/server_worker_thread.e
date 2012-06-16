class SERVER_WORKER_THREAD

inherit
	THREAD
		rename
			make as thread_make
		end

	UTILITY

create
	make

feature

	state_begin: INTEGER = 1

	state_runt_packet: INTEGER = 1

	state_complete: INTEGER = 10

    block_number_window: INTEGER = 0x10000

feature

	server: SERVER_THREAD

	frontend: TFTP_FRONTEND

	id: STRING

	remote_address: INET_ADDRESS

	remote_port: INTEGER

	source_port: INTEGER

	opcode: NATURAL_16

	filename: STRING

	mode: INTEGER

	file: detachable RAW_FILE

	state: INTEGER

	socket: NETWORK_DATAGRAM_SOCKET

feature {NONE} -- Initialization

	make (a_server: SERVER_THREAD; a_frontend: TFTP_FRONTEND; a_packet: TFTP_REQUEST_PACKET)
		require
			server_non_void: a_server /= Void
			frontend_non_void: a_frontend /= Void
			packet_non_void: a_packet /= Void
			packet_valid: a_packet.opcode = {TFTP_PACKET}.wrq or else a_packet.opcode = {TFTP_PACKET}.rrq
		local
			temp: STRING
			a_filename: STRING
		do
			thread_make
			server := a_server
			frontend := a_frontend
			remote_address := a_packet.host
			remote_port := a_packet.port
			opcode := a_packet.opcode
			mode := a_packet.mode
			a_filename := a_packet.filename

			temp := frontend.base_path (remote_address)
			filename := ""
			if temp /= Void  and then not temp.is_empty  then
            	filename := temp + "/" + a_filename
			end

			create socket.make_targeted (remote_address.host_address, remote_port)
				-- TODO socket.setSoTimeout (frontend.getTimeout (remote_address));
			source_port := socket.port

			id := remote_address.host_address + ":" + source_port.out + "-" + remote_port.out
		end

feature

	execute
			-- Routine executed by new thread.
		do
			if opcode = {TFTP_PACKET}.wrq then
				process_write_request
			elseif opcode = {TFTP_PACKET}.rrq then
				process_read_request
			end
    	end

	process_write_request
		local
			block_number: INTEGER
			in_block_number: INTEGER
			in_opcode: INTEGER
			done: BOOLEAN
			last_time: INTEGER
			now: INTEGER
			setup: INTEGER
			retransmits: INTEGER
		do
				-- If filename that came with WWQ is bogus, report error
			if filename.is_empty then
				bad_file ("Illegal filename " + filename)
				dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, "Illegal file name in write request")
				terminate
			else
					-- Try to open the file stream. If we can't, report error.
				setup := setup_file_writer
				if setup /= ERR_NO_ERROR then
					if setup /= ERR_NOT_DEFINED then
						send_error (socket, remote_address, remote_port, setup, create_error_message_from_id (setup, "Could not open file " + filename))
					end
					dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, create_error_message_from_id (setup, "Could not open file " + filename))
				end

				dispatch_tftp_event (remote_address, remote_port,  {TFTP_EVENT}.REQUEST_PROCESSING, {TFTP_PACKET}.wrq, filename)

					-- Send the first ack letting the remote guy know it's
					-- okay to start sending data packets
				send_ack (socket, remote_address, remote_port, block_number)
				last_time := milliseconds
				from
					done := False
				until
					done
				loop
					-- Wait for DATA packet
					if attached {TFTP_PACKET} receive (socket) as in_packet then
						in_opcode := in_packet.opcode
						if in_opcode = {TFTP_PACKET}.error then
							frontend.log_message_by_address (remote_address, 1, create_error_message_from_packet (in_packet))
							dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, create_error_message_from_packet (in_packet))
							terminate
						elseif attached {TFTP_DATA_PACKET} in_packet as data_packet then
							in_block_number := data_packet.block_number
							if in_block_number = block_number then
								dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_OUTOFORDER, in_opcode,
									"Received data packet #" + in_block_number.out + " instead of #" + ((block_number + 1) \\ block_number_window).out)
								now := milliseconds
								if now - last_time > 1000 then
									send_ack (socket, remote_address,remote_port, block_number)
									dispatch_tftp_event (remote_address,remote_port,{TFTP_EVENT}.REQUEST_RETRANSMIT, {TFTP_PACKET}.ack,"Retransmitting ACK for packet #" + block_number.out);
									last_time := milliseconds
								end
							elseif in_block_number /= ((block_number + 1) \\ block_number_window) then
								dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_OUTOFORDER, in_opcode,"Received data packet #" + in_block_number.out + " instead of #" + ((block_number + 1) \\ block_number_window).out)
								send_ack (socket, remote_address, remote_port, block_number)
								dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_RETRANSMIT, {TFTP_PACKET}.ack, "Retransmitting ACK for packet #" + block_number.out)
								last_time := milliseconds
							else
									-- We got the data packet, so write it out to
									-- disk, send the ack for it, and wait again.
								server.received_data (data_packet.data_length)
								write_data (data_packet)
								retransmits := 0
								block_number := (block_number + 1) \\ block_number_window
								send_ack (socket, remote_address, remote_port, block_number)
								last_time := milliseconds
								if data_packet.data_length < {TFTP_DATA_PACKET}.block_size then
									done := True
								end
							end
						end
					end
				end
				dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_COMPLETE, {TFTP_PACKET}.wrq, filename)
				terminate
			end
		end

	process_read_request
		local
			block_number: INTEGER
			in_block_number: INTEGER
			in_opcode: INTEGER
			in_buffer: MANAGED_POINTER
			count: INTEGER
			done: BOOLEAN
			setup: INTEGER
			retransmits: INTEGER
		do
			if filename.is_empty then
				bad_file ("Bad file " + filename)
				dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, "Illegal file name in read request")
				terminate
			else
				setup := setup_file_reader
				if setup /= ERR_NO_ERROR then
					if setup /= ERR_NOT_DEFINED then
						send_error (socket, remote_address, remote_port, setup, "Could not open file.")
					end
					dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, create_error_message_from_id (setup, "Could not open file for read request"))
					terminate
 				else
 					block_number := 1
 					create in_buffer.make ({TFTP_PACKET}.max_data_length)
					count := read_data (in_buffer, {TFTP_PACKET}.max_data_length)
					retransmits := 0
					if count < 0  then
						send_error (socket, remote_address, remote_port, setup, "Could not read file " + filename)
						dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, "Could not open file for read request")
						terminate
					else
						dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_PROCESSING,{TFTP_PACKET}.rrq,filename)
						from
							done := False
						until
							done or else state = state_complete
						loop
							send_data_packet (socket, remote_address, remote_port, block_number, in_buffer, count)
								-- Wait for response ack
							if attached {TFTP_PACKET} receive (socket) as in_packet then
								in_opcode := in_packet.opcode
								if in_opcode = {TFTP_PACKET}.error then
									frontend.log_message_by_address (remote_address, 1, create_error_message_from_packet (in_packet))
									dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_INCOMPLETE, {TFTP_PACKET}.error, create_error_message_from_packet (in_packet))
									done := True
									terminate
								elseif attached {TFTP_ACK_PACKET} in_packet as ack_packet then
									in_block_number := ack_packet.block_number
									if in_block_number /= block_number then
										dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_OUTOFORDER, in_opcode, "Received ACK packet #" + in_block_number.out + " instead of #" + block_number.out)
									else
										server.sent_data (count)
										if state = state_runt_packet then
											state := state_complete
										else
											-- Got it! Read more data
											count := read_data (in_buffer, {TFTP_PACKET}.max_data_length)
											retransmits := 0
											if count < {TFTP_PACKET}.max_data_length then
												state := state_runt_packet
											end
											block_number := (block_number + 1) \\ block_number_window
										end
									end
								end
							end
						end
						dispatch_tftp_event (remote_address, remote_port, {TFTP_EVENT}.REQUEST_COMPLETE, {TFTP_PACKET}.rrq, filename)
						terminate
					end
				end
			end
		end

	write_data (data_packet: TFTP_DATA_PACKET)
			--
		require
			data_packet_non_void: data_packet /= Void
			valid_file: attached file as l_file and then l_file.is_open_write
		local
			l_file_loc: like file
		do
			l_file_loc := file
				-- Per precondition of `write_data'
			check l_file_attached: l_file_loc /= Void end
			l_file_loc.put_managed_pointer (data_packet.data_pointer, data_packet.data_offset, data_packet.data_length)
		end

	read_data (p: MANAGED_POINTER; length: INTEGER): INTEGER
			--
		require
			p_non_void: p /= Void
			valid_file: attached file as l_file and then l_file.is_open_read
		local
			l_file_loc: like file
		do
			l_file_loc := file
				-- Per precondition of `write_data'
			check l_file_attached: l_file_loc /= Void end
			l_file_loc.read_to_managed_pointer (p, 0, length)
			Result := l_file_loc.bytes_read
		end

	terminate
		do
			if attached file as l_file then
				l_file.close
				file := Void
			end
			if socket /= Void then
				socket.close
			end
			server.worker_terminated (id)
		end

	setup_file_writer: INTEGER
		local
			l_file: like file
		do
			Result := ERR_NO_ERROR
			create l_file.make (filename)
			if l_file.exists and then not frontend.allow_overwrite (remote_address) then
				file := Void
				Result := ERR_FILE_EXISTS
			else
				file := l_file
				l_file.open_write
			end
		end

	setup_file_reader: INTEGER
		local
			l_file: like file
		do
			Result := ERR_NO_ERROR;
			create l_file.make (filename)
			if not l_file.exists then
				Result := ERR_FILE_NOT_FOUND
				file := Void
			else
				if not l_file.is_readable then
					file := Void
					Result := ERR_ACCESS_VIOLATION
				else
					file := l_file
					l_file.open_read
				end
			end
		end

	dispatch_tftp_event (an_address: INET_ADDRESS; a_port: INTEGER; an_id: INTEGER; an_opcode: INTEGER; an_arg: STRING)
		require
			server_non_void: server /= Void
			addres_non_void: an_address /= Void
		do
      			server.dispatch_tftp_event (create {TFTP_EVENT}.make (an_address, a_port, an_id, an_opcode, an_arg))
		end

	bad_file(a_message: STRING)
		require
			message_non_void: a_message /= Void
		do
      			send_error (socket, remote_address, remote_port, 0, a_message)
		end

	build_request_info
		do
			-- TODO
		end

	time: C_DATE
		once
			create Result
		end

	milliseconds: INTEGER
		do
			time.update
			Result := time.millisecond_now + time.second_now * 1000 + time.minute_now * 60000
		end

end


