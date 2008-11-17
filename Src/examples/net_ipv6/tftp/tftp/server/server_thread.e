class
	SERVER_THREAD

inherit

	THREAD

	UTILITY

create
	make, make_with_port

feature -- Constants

	default_port: NATURAL_16 = 69

feature -- Initialization

	make (a_frontend: TFTP_FRONTEND) is
		require
			frontend_non_void: a_frontend /= Void
		do
			make_with_port (a_frontend, default_port)
		end

	make_with_port (a_frontend: TFTP_FRONTEND; a_port: NATURAL_16) is
		require
			frontend_non_void: a_frontend /= Void
		do
			create listeners.make (0)
			frontend := a_frontend
			port := a_port
			create server_socket.make_bound (port)
			-- TODO workerHash = new Hashtable (64);
		end

feature

	execute is
			-- Routine executed by new thread.
		local
			packet: TFTP_REQUEST_PACKET
			opcode: INTEGER
			can_read, can_write: BOOLEAN
			done: BOOLEAN
			wt: SERVER_WORKER_THREAD
		do
			frontend.log_message_by_source ("SERVER:", 2, "Tftp Server thread started.");
			from
				done := False
			until
				done
			loop
				packet := receive_request (server_socket)
				if packet /= Void then
					opcode := packet.opcode
					dispatch_tftp_event (Create {TFTP_EVENT}.make (packet.host, packet.port, {TFTP_EVENT}.REQUEST_RECEIVED, opcode, Void))
					if opcode = {TFTP_PACKET}.wrq or else opcode = {TFTP_PACKET}.rrq then
						can_read := frontend.allow_read (packet.host)
						can_write := frontend.allow_write (packet.host)
						if opcode = {TFTP_PACKET}.RRQ and then not can_read  then
							frontend.log_message_by_address (packet.host, 2, "Read requests not allowed for this client.")
						end
						if opcode = {TFTP_PACKET}.WRQ and then not can_write then
							frontend.log_message_by_address (packet.host, 2, "Write requests not allowed for this client.");
						end
						if (opcode = {TFTP_PACKET}.RRQ and then can_read) or (opcode = {TFTP_PACKET}.WRQ and then can_write) then
							create wt.make (Current, frontend, packet)
							-- TODO workerHash.put (ct.getID(), ct)
							-- wt.launch
							wt.execute
						end
					end
				end
			end
			frontend.log_message_by_source ("SERVER:", 2,"Tftp Server thread stopped.")
		end

	worker_terminated (id: STRING) is
		require
			id_non_void: id /= Void
			id_non_epty: not id.is_empty
		do
			-- TODO worker_hash.remove (id)
		end

	dispatch_tftp_event (event: TFTP_EVENT) is
		require
			event_non_void: event /= Void
		do
			from
				listeners.start
			until
				listeners.after
			loop
				listeners.item.tftp_message (event)
				listeners.forth
			end
		end

	sent_data (data_length: INTEGER) is
		do
			from
				listeners.start
			until
				listeners.after
			loop
				listeners.item.sent_data (data_length)
				listeners.forth
			end
		end

	received_data (data_length: INTEGER) is
		do
			from
				listeners.start
			until
				listeners.after
			loop
				listeners.item.received_data (data_length)
				listeners.forth
			end
		end

	add_tftp_event_listener (listener: TFTP_EVENT_LISTENER) is
		require
			listener_non_void: listener /= Void
		do
			listeners.extend (listener)
		end

	remove_tftp_event_listener (listener: TFTP_EVENT_LISTENER) is
		require
			listener_non_void: listener /= Void
		do
			listeners.prune_all (listener)
		end

feature {NONE} -- Implementation

	server_socket: NETWORK_DATAGRAM_SOCKET
	frontend: TFTP_FRONTEND
	port: NATURAL_16
	listeners: ARRAYED_LIST[TFTP_EVENT_LISTENER]

end
