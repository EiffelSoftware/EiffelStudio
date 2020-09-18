note
	description: "[
		Objects receiving test results through a socket.
		
		Note: although threads and mutexes are used to communicate to the evaluator, the exported
		      features in this class are not thread safe.
	]"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ETEST_EVALUATOR_CONNECTION [G -> detachable ANY, H]

inherit
	ANY

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

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

	last_result: detachable H
			-- Last result received from client

	current_port: INTEGER
			-- Port used by `Current' for incoming connection
			--
			-- Note: a negative port indicates that no socket could be opened for listening

feature {NONE} -- Access

	mutex: MUTEX
			-- Mutex for synchronizing threads used in `Current'

	condition: CONDITION_VARIABLE
			-- Condition variable receiving threads waits on before receiving result

	next_request: detachable G
			-- Request data that should be sent to the client next

	connection: detachable NETWORK_STREAM_SOCKET
			-- Connection to evaluator

	port_counter: CELL [INTEGER]
			-- Counter for port number `Current' listens to
		once
			create Result.put (0)
		end

	min_port: INTEGER = 49200
			-- Smallest valid port number.
			-- The smallest port is 49152, but some program are using
			-- them. To make debugging easier we start at 49200.

	max_port: INTEGER = 65535
			-- Largest valid port number

feature -- Status report

	is_awaiting_result: BOOLEAN
			-- Is `Current' waiting to receive a result?
		do
			Result := next_request /= ({detachable G}).default
		end

	has_connection_died: BOOLEAN
			-- Has connection been closed by evaluator?

feature -- Implementation

	send_request (a_request: G)
			-- Send tuple containing test routine information to evaluator.
			--
			-- `a_request': Tuple containing necessary information to launch a test routine.
		require
			a_request_attached: a_request /= Void
			not_receiving: not is_awaiting_result
		do
			mutex.lock
			last_result := ({detachable H}).default
			next_request := a_request.deep_twin
			condition.signal
			mutex.unlock
		ensure
			awaiting_or_received: is_awaiting_result or last_result /= Void
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
			next_request := ({detachable G}).default
			last_result := ({detachable H}).default
			if not has_connection_died then
				if current_port > 0 then
					create l_socket.make_client_by_address_and_port ((create {INET_ADDRESS_FACTORY}).create_loopback, current_port)
					l_socket.connect
					l_socket.close
				else
						-- Invalid port!
				end
				has_connection_died := True
				condition.broadcast
			end
			mutex.unlock
		ensure
			died: has_connection_died
		end

feature {NONE} -- Status setting

	receive (a_socket: NETWORK_STREAM_SOCKET)
			-- Listen to incoming connection from evaluator.
			--
			-- `a_socket': Socket to listen to.
		require
			a_socket_attached: a_socket /= Void
			a_socket_open_read: a_socket.is_open_read
			a_socket_blocking: a_socket.is_blocking
		local
			l_connection: detachable NETWORK_STREAM_SOCKET
		do
			if not has_connection_died then
				a_socket.accept
				l_connection := a_socket.accepted
				if l_connection /= Void then
					check is_blocking: l_connection.is_blocking end
					l_connection.set_nodelay

						-- Start receiving results
					from
						mutex.lock
					until
						has_connection_died
					loop
						if attached next_request as l_request then
							mutex.unlock

								-- Send request
							store_in_medium (l_request, l_connection)

								-- Wait for response
							l_connection.read_boolean
							if
								l_connection.readable and then
								l_connection.last_boolean and then
								attached {H} retrieved_from_medium (l_connection) as l_retrieved
							then
								mutex.lock
								next_request := ({detachable G}).default
								last_result := l_retrieved
							else
									--| Need to lock in order to perform clean unlock at end of loop. Can not lock before
									--| retrieval because `retrieved' can through exception.
								mutex.lock
								has_connection_died := True
							end
						else
								-- Wait until work is received through `send_request'
							condition.wait (mutex)
						end
					end
					mutex.unlock
				else
					has_connection_died := True
				end
			end
			if l_connection /= Void and then not l_connection.is_closed then
				l_connection.close
			end
		ensure
			connection_dies: has_connection_died
		rescue
			has_connection_died := True
			retry
		end

invariant
	valid_port: not has_connection_died implies (min_port <= current_port and current_port <= max_port)

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
