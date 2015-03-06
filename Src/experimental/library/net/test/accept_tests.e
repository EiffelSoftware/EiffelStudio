note
	description: "EiffelNet tests for accept handling."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCEPT_TESTS

inherit

	SCOOP_UTILS

	EQA_TEST_SET
		redefine
			on_prepare, on_clean
		end

feature -- Constants

	port: INTEGER = 2000

	listen_queue_count: INTEGER = 5

feature -- Access

	socket: NETWORK_STREAM_SOCKET
			-- The network stream socket to accept on.

feature -- Tests

	test_sequential_accept
			-- Test the sequential way of accepting connections.
		note
			testing: "execution/serial"
		local
			message: STRING
			client: separate CLIENT_STUB
			received: STRING
		do
			message := "Hello World"
			create client.make (message, port)
			client_stub_send_message (client)

			socket.accept

			assert ("accepted", attached socket.accepted)

			check attached socket.accepted as l_accepted then

				assert ("created", l_accepted.is_created)
				assert ("connected", l_accepted.is_open_read and l_accepted.is_open_write)

				l_accepted.read_line
				received := l_accepted.last_string

				assert ("is_equal", message ~ received)
				assert ("not_reference_equal", message /= received)
				l_accepted.close

				assert ("closed", l_accepted.is_closed and not l_accepted.is_open_read and not l_accepted.exists)
			end
		end

	test_scoop_accept
			-- Test the SCOOP accept features
		note
			testing: "execution/serial"
		local
			message: STRING
			client: separate CLIENT_STUB
			l_accepted: NETWORK_STREAM_SOCKET
			received: STRING
		do
			message := "Hello World"
			create client.make (message, port)
			client_stub_send_message (client)

			create l_accepted.make_empty

			assert ("not_attached", socket.accepted = Void)
			assert ("not_initialized", not l_accepted.is_created)

			socket.accept_to (l_accepted)

			assert ("not_attached", socket.accepted = Void)
			assert ("accepted", l_accepted.is_created)
			assert ("connected", l_accepted.is_open_read and l_accepted.is_open_write)


			l_accepted.read_line
			received := l_accepted.last_string

			assert ("is_equal", message ~ received)
			assert ("not_reference_equal", message /= received)

			l_accepted.close

			assert ("closed", l_accepted.is_closed and not l_accepted.is_open_read and not l_accepted.exists)
		end


	test_accept_timeout
			-- Test if an accept timeout is handled correctly.
		note
			testing: "execution/serial"
		local
			connection: like socket
		do
			socket.set_accept_timeout (10)

			create connection.make_empty
			assert ("not_initialized", not connection.is_created)
			assert ("invariant", connection.is_closed and not connection.exists)

			socket.accept_to (connection)

			assert ("not_initialized", not connection.is_created)
			assert ("invariant", connection.is_closed and not connection.exists)
		end


feature {NONE} -- Preparation and cleanup


	on_prepare
			-- <Precursor>
		do
			create socket.make_server_by_port (port)

				-- Disable lingering to be able to re-execute the tests.
			socket.set_linger_off

			socket.listen (listen_queue_count)
		ensure then
			open: not socket.is_closed and socket.is_bound
			readable: socket.is_open_read
		end

	on_clean
			-- <Precursor>
		do
			socket.close
		ensure then
			closed: socket.is_closed and not socket.is_open_read
			removed: not socket.exists
		end


note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
