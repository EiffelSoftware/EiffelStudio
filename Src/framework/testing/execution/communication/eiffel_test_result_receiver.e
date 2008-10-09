indexing
	description: "[
		Objects that receive testing results through a socket. Since this is done in a seperate thread,
		the receiver only has access to the evaluator status.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EIFFEL_TEST_RESULT_RECEIVER

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	last_port: INTEGER
			-- Port on which new socket is listening

feature {NONE} -- Access

	port_counter: !CELL [INTEGER]
			-- Counter for port number `Current' listens to
		once
			create Result
		end

	min_port: INTEGER = 49152
			-- Smallest valid port number

	max_port: INTEGER = 65535
			-- Largest valid port number

feature -- Status setting

	receive (a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			-- Wait for incoming connection on socket.
			--
			-- Note: `receive' will open a listener socket on a arbitrary available port and simply try to
			--       receive objects of type {EQA_TEST_OUTCOME}. If `a_status' does not have any remaining tests
			--       or something unexpected is received, the connection is closed and the listener thread
			--       terminated. `last_port' will be set to the port on which the new listener thread is
			--       waiting for incoming connections.
			--
			-- `a_status': Status to which received results are added
		require
			a_status_is_listening: a_status.is_listening
		local
			l_socket: ?NETWORK_STREAM_SOCKET
			l_thread: WORKER_THREAD
			l_tries: NATURAL
		do
			from until
				(l_socket /= Void and then l_socket.is_open_read) or l_tries > 20
			loop
				port_counter.put (port_counter.item + 1)
				if port_counter.item < min_port or port_counter.item > max_port then
					port_counter.put (min_port)
				end
				last_port := port_counter.item
				create l_socket.make_server_by_port (last_port)
				l_tries := l_tries + 1
			end
			if l_tries <= 20 then
						-- TODO: error handling
				l_socket.set_blocking
				l_socket.listen (1)
				create l_thread.make (agent listen ({!NETWORK_STREAM_SOCKET} #? l_socket, a_status))
				l_thread.launch
			end
		ensure
			last_port_valid: last_port >= min_port and last_port <= max_port
		end

feature {NONE} -- Implementation

	listen (a_socket: !NETWORK_STREAM_SOCKET; a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			-- Wait for incoming connection on socket and receive results.
			--
			-- `a_socket': Socket to which evaluator will connect to.
			-- `a_status': Status where new results are added.
		require
			a_status_is_listening: a_status.is_listening
		local
			l_rescued: BOOLEAN
			c: CHARACTER
			i: INTEGER
		do
			if not l_rescued then
				a_socket.accept
				a_status.set_receiving
				if {l_receiver: !NETWORK_STREAM_SOCKET} a_socket.accepted then
					receive_results (l_receiver, a_status)
				end
			end
			a_socket.close
			a_status.stop_receiving
		rescue
			l_rescued := True
			retry
		end

	receive_results (a_socket: NETWORK_STREAM_SOCKET; a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			-- Receive results from socket.
			--
			-- `a_socket': Socket through which evaluator sends results.
			-- `a_status': Status where new results are added.
		local
			l_rescued: BOOLEAN
			l_flag: CHARACTER
		do
			a_status.set_receiving
			if not l_rescued then
				from until
					not a_socket.is_open_read or a_status.results_complete or not a_status.is_receiving
				loop
					l_flag := evaluator_status (a_socket)
					if l_flag = '1' then
						if {l_outcome: !EQA_TEST_OUTCOME} a_socket.retrieved then
							a_status.add_result (l_outcome)
						else
							a_socket.close
						end
					else
						a_status.stop_receiving
					end
				end
			end
			a_socket.close
			a_status.stop_receiving
		ensure
			a_socket_closed: a_socket.is_closed
			a_status_not_listening: not a_status.is_listening
			a_status_not_receiving: not a_status.is_receiving
		rescue
			l_rescued := True
			retry
		end

	evaluator_status (a_socket: NETWORK_STREAM_SOCKET): CHARACTER
			-- Current status of evaluator.
			--
			-- Note: this routine will block until evaluator sends its status through the socket.
			--
			-- `a_socket': Socket through which evaluator sends results
			-- `Result': '1' if evaluator is about to send a result, '0' otherwise
		local
			l_rescued: BOOLEAN
		do
			Result := '0'
			if not l_rescued then
				from
				until
					a_socket.readable or a_socket.is_closed
				loop
					sleep (100000000)
				end
				if a_socket.readable then
					--a_socket.read_stream (1)
					a_socket.read_stream_thread_aware (1)
					if not a_socket.last_string.is_empty then
						Result := a_socket.last_string.item (1)
						if Result /= '1' then
							Result := '0'
						end
					end
				end
			end
		rescue
			l_rescued := True
			retry
		end


end
