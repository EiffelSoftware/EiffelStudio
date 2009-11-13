note
	description: "[
		Objects receiving test results through a socket.
		
		Note: although threads and mutexes are used to communicate to the evaluator, the exported
		      features in this class are not thread safe.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ETEST_EVALUATOR_CONNECTION

create
	make

feature {NONE} -- Initialization

	make
		local
			l_listener: detachable NETWORK_STREAM_SOCKET
			l_attempt: NATURAL
			l_port: like current_port
			l_thread: WORKER_THREAD
		do
			create mutex.make
			create condition.make
			from
				l_attempt := 1
			until
				current_port /= 0
			loop
				l_port := port_counter.item + 1
				if l_port < min_port or max_port < l_port then
					l_port := min_port
				end
				port_counter.put (l_port)

				create l_listener.make_loopback_server_by_port (l_port)
				if l_listener.is_open_read then
					current_port := l_port
					l_listener.set_blocking
					l_listener.listen (1)
					create l_thread.make (agent receive (l_listener))
					l_thread.launch
				else
					l_attempt := l_attempt + 1
					if l_attempt > 20 then
						current_port := -1
					end
				end
			end
		ensure
			current_port_valid: current_port < 0 or (min_port <= current_port and current_port <= max_port)
		end

feature -- Access

	test_result: EQA_RESULT
			-- Last received result
		require
			has_result: has_result
		local
			l_result: like last_result
		do
			l_result := last_result
			check l_result /= Void end
			Result := l_result
		end

	current_port: INTEGER
			-- Port used by `Current' for incoming connection
			--
			-- Note: a negative port indicates that no socket could be opened for listening

feature {NONE} -- Access

	mutex: MUTEX
			-- Mutex for synchronizing threads used in `Current'

	condition: CONDITION_VARIABLE
			-- Condition variable receiving threads waits on before receiving result

	connection: detachable NETWORK_STREAM_SOCKET
			-- Connection to evaluator

	last_result: detachable like test_result
			-- Internal storage for `test_result'

	port_counter: CELL [INTEGER]
			-- Counter for port number `Current' listens to
		once
			create Result.put (0)
		end

	min_port: INTEGER = 49152
			-- Smallest valid port number

	max_port: INTEGER = 65535
			-- Largest valid port number

feature -- Status report

	is_connected: BOOLEAN
			-- Is `Current' connected to evaluator?
		do
			Result := connection /= Void
		ensure
			result_implies_attached: Result implies connection /= Void
		end

	is_awaiting_result: BOOLEAN
			-- Is `Current' waiting to receive a result?

	has_result: BOOLEAN
			-- Did `Current' receive a new result?
		do
			Result := last_result /= Void
		end

	has_connection_died: BOOLEAN
			-- Has connection been closed by evaluator?

feature -- Status setting

	send_request (a_request: TUPLE)
			-- Send tuple containing test routine information to evaluator.
			--
			-- `a_request': Tuple containing necessary information to launch a test routine.
		require
			a_request_attached: a_request /= Void
			connected: is_connected
			not_receiving: not is_awaiting_result
		local
			l_connection: like connection
		do
			mutex.lock
			l_connection := connection
			check l_connection /= Void end
			l_connection.independent_store (a_request)
			last_result := Void
			is_awaiting_result := True
			condition.signal
			mutex.unlock
		ensure
			awaiting_or_received: is_awaiting_result or has_result
		end

	terminate
			-- Stop receiving results.
			--
			-- Note: this only has an affect if no connection has been established yet. Otherwise the socket
			--       must be closed by the evaluator.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			mutex.lock
			if attached connection as l_connection then
				if not is_awaiting_result then
					l_connection.close
				end
				if condition.is_set then
					condition.broadcast
					condition.destroy
				end
			else
				create l_socket.make_client_by_address_and_port ((create {INET_ADDRESS_FACTORY}).create_loopback, current_port)
				l_socket.connect
				l_socket.close
			end
			mutex.unlock
		end

feature {NONE} -- Status setting

	receive (a_socket: NETWORK_STREAM_SOCKET)
			-- Listen to incoming connection from evaluator.
			--
			-- `a_socket': Socket to listen to.
		require
			a_socket_attached: a_socket /= Void
			a_socket_open_read: a_socket.is_open_read
		local
			l_connection: like connection
			l_has_lock: BOOLEAN
		do
			if not has_connection_died then
				a_socket.accept
				l_connection := a_socket.accepted
				if l_connection /= Void then
					l_connection.set_blocking
					l_connection.set_nodelay

						-- Start receiving results
					from
						mutex.lock
						connection := l_connection
					until
						has_connection_died
					loop
							-- Wait until evaluator received work through `send_request'
						condition.wait (mutex)
						mutex.unlock
						if l_connection.readable then
							l_connection.read_boolean
							if
								l_connection.last_boolean and
								l_connection.readable and then
								attached {EQA_RESULT} l_connection.retrieved as l_result
							then
								mutex.lock
								last_result := l_result
								is_awaiting_result := False
							else
								has_connection_died := True
							end
						else
							has_connection_died := True
						end
					end
				end
			end
		rescue
			has_connection_died := True
				-- Note: no need to unlock `mutex' since it is never locked when using `connection' so we
				--       assume there won't be an exception.
			retry
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
