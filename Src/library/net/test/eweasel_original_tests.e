note
	description: "Original test cases ported from Eweasel test suite."
	date: "$Date$"
	revision: "$Revision$"

class
	EWEASEL_ORIGINAL_TESTS

inherit

	SCOOP_UTILS

	EQA_TEST_SET

feature -- Tests

	test_many_disposals
			-- If you create too many sockets without connecting them, we ran out of descriptors.
		local
			s: NETWORK_STREAM_SOCKET
			i: INTEGER
		do

			from
				i := 1
			until
				i = 100000
			loop
				create s.make
				s.dispose
				i := i + 1
			end
		end

	test_non_blocking_no_timeout
			-- Test non-blocking behaviour without timeout.
		do
			test_non_blocking (-1)
		end

	test_non_blocking_with_timeout
			-- Test non-blocking behaviour with a timeout of 10 ms.
		do
			test_non_blocking (10)
		end

feature {NONE} -- Test implementation

	test_non_blocking (connect_timeout: INTEGER)
			-- Test non-blocking behaviour.
			-- If you connect a socket in non-blocking mode it reports it is not connected where in fact it is,
			-- plus it ends up blocking indefinitely when connected with a timeout.
		local
			l_server: separate SERVER_STUB
			l_port: INTEGER

			s: NETWORK_STREAM_SOCKET
		do
			create l_server.make (0)

				-- Wait until server is fully launched
			l_port := server_stub_port (l_server)

			server_stub_accept (l_server)


			create s.make_client_by_port (l_port, "127.0.0.1")
			s.set_non_blocking

			if connect_timeout >= 0 then
				s.set_connect_timeout (connect_timeout)
			end

			s.connect

			assert ("connected", s.socket_ok and (s.is_open_write or s.connect_in_progress))

			s.read_integer

			assert ("no_bytes_read", s.bytes_read <= 0)

			s.cleanup
			server_stub_close (l_server)
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
