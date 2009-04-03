note
	description: "[
		Objects waiting for an incoming connection in a non blocking matter.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	AUT_SOCKET_LISTENER

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			create mutex.make
			create condition.make
		end

feature -- Access

	current_port: INTEGER
			-- Port we are currently listening on

feature {NONE} -- Access

	mutex: MUTEX
			-- Mutex used for `condition'

	condition: CONDITION_VARIABLE
			-- Condition variable for waiting on socket

	port_cell: CELL [INTEGER]
			-- Cell to contain port number.
		once
			create Result.put (min_port)
		ensure
			result_attached: Result /= Void
		end

	connection: detachable NETWORK_STREAM_SOCKET
			-- Connection to client once established

feature -- Status report

	is_listening: BOOLEAN
			-- Has listening started?
		do
			Result := current_port /= 0
		end

feature -- Basic functionality

	open_new_socket
			-- Start listening on the next available port
			--
			-- Note: if available port was found, `is_listening' is True.
		require
			not_listening: not is_listening
		local
			l_socket: like open_listener
			l_thread: WORKER_THREAD
		do
			connection := Void
			l_socket := open_listener
			if l_socket /= Void then
				create l_thread.make (agent start_listening (l_socket))
				l_thread.launch
			else
				current_port := 0
			end
		end

	wait_for_connection (a_timeout: NATURAL): like connection
			-- Stop listening and close open port
			--
			-- `a_timeout': Number of milliseconds spent waiting for socket. If zero, it will wait
			--              without timeout for socket to become attached.
		require
			listening: is_listening
		local
			l_res: BOOLEAN
		do
			mutex.lock
			if connection = Void then
				if a_timeout = 0 then
					condition.wait (mutex)
				else
					l_res := condition.wait_with_timeout (mutex, a_timeout.as_integer_32)
					if connection = Void then
						close_listener
					end
				end
			end
			Result := connection
			current_port := 0
			mutex.unlock
		ensure
			not_listening: not is_listening
		end

feature {NONE} -- Implementation

	open_listener: detachable NETWORK_STREAM_SOCKET
			-- Create listening socket. If no available port was found Void is returned.
		local
			l_attempts: NATURAL
		do
			from
				l_attempts := 1
			until
				(Result /= Void and then Result.is_open_read) or
					l_attempts > max_attempts
			loop
				port_cell.put (port_cell.item + 1)
				if port_cell.item < min_port or port_cell.item > max_port then
					port_cell.put (min_port)
				end
				current_port := port_cell.item
				create Result.make_server_by_port (current_port)
				--create Result.make_server_by_port (current_port)
				l_attempts := l_attempts + 1
			end
			if Result.is_open_read then
				Result.set_blocking
				Result.listen (1)
			else
				Result := Void
			end
		end

	close_listener
			-- Close listening socket by connecting to it and closing immediatly.
		require
			listening: is_listening
		local
			l_socket: like open_listener
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				create l_socket.make_client_by_port (current_port, "localhost")
				l_socket.connect
				l_socket.close
			end
		rescue
			l_rescued := True
			retry
		end

	start_listening (a_socket: attached like open_listener)
			-- Start listening to `a_socket' for incomming connection. Once connection is established and
			-- `is_listening' is still True, set `connection' to new connection with client.
			--
			-- Note: this routine is blocking.
		local
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				a_socket.accept
				mutex.lock
				if is_listening then
					connection := a_socket.accepted
					connection.set_blocking
					condition.broadcast
				end
				mutex.unlock
			end
		rescue
			l_rescued := True
			retry
		end

feature {NONE} -- Constants

	min_port: INTEGER = 49152
	max_port: INTEGER = 65535
	max_attempts: NATURAL = 20

invariant
	current_port_not_negative: current_port >= 0

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
