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
	THREAD_CONTROL

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
			--       receive objects of type {TEST_OUTCOME}. If `a_status' does not have any remaining tests
			--       or something unexpected is received, the connection is closed and the listener thread
			--       terminated. `last_port' will be set to the port on which the new listener thread is
			--       waiting for incoming connections.
			--
			-- `a_status': Status to which received results are added
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
				create l_thread.make (agent start ({!NETWORK_STREAM_SOCKET} #? l_socket, a_status))
				l_thread.launch
			end
		ensure
			last_port_valid: last_port >= min_port and last_port <= max_port
		end

feature {NONE} -- Implementation

	start (a_socket: !NETWORK_STREAM_SOCKET; a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			-- Wait for incoming connection on socket and receive results.
			--
			-- `a_socket': Socket to which evaluator will connect to.
			-- `a_status': Status where new results are added.
		local
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				a_socket.accept
				if {l_receiver: !NETWORK_STREAM_SOCKET} a_socket.accepted then
					a_socket.close
					from until
						not (l_receiver.is_open_read and a_status.has_remaining_tests and a_status.is_receiving)
					loop
						if {l_outcome: !TEST_OUTCOME} l_receiver.retrieved then
							a_status.add_result (l_outcome)
						else
							l_receiver.close
						end
					end
					if not l_receiver.is_closed then
						l_receiver.close
					end
				else
					a_socket.close
				end
			end
			a_status.stop_receiving
		rescue
			l_rescued := True
			retry
		end

end
