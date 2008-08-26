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

feature -- Access

	last_port: INTEGER
			-- Port on which new socket is listening

feature {NONE} -- Access

	port_counter: !INTEGER_REF
			-- Counter for port number `Current' listens to
		once
			create Result
		end

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
			l_thread: WORKER_THREAD
		do
			port_counter.set_item (port_counter.item + 1)
			if port_counter < 49152 or port_counter > 65535 then
				port_counter.set_item (49152)
			end
			last_port := port_counter.item
			create l_thread.make (agent start (last_port, a_status))
			l_thread.launch
		ensure
			last_port_valid: last_port >= 49152 and last_port <= 65535
		end

feature {NONE} -- Implementation

	start (a_port: INTEGER; a_status: !EIFFEL_TEST_EVALUATOR_STATUS) is
			-- Wait for incoming connection on given port.
			--
			-- `a_port': Port on which a listener socket should be created.
			-- `a_status': Status to which new results are added.
		require
			a_port_valid: a_port >= 49152 and a_port <= 65535
		local
			l_rescued: BOOLEAN
			l_listener: !NETWORK_STREAM_SOCKET
		do
			if not l_rescued then
				create l_listener.make_server_by_port (a_port)
				l_listener.listen (1)
				l_listener.accept
				if {l_receiver: !NETWORK_STREAM_SOCKET} l_listener.accepted then
					l_listener.close
					from until
						not (l_receiver.is_open_read and a_status.has_remaining_tests)
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
					l_listener.close
				end
			end
		rescue
			l_rescued := True
			retry
		end

end
