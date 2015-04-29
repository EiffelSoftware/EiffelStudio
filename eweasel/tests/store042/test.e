class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			a: ARGUMENTS_32
		do
			create a
			if a.argument_count > 0 and then a.argument (1).same_string_general ("client") then
				do_client
			else
				do_server
			end
		end

	do_server
		local
			l_retry: BOOLEAN
			l_socket: NETWORK_STREAM_SOCKET
			l_socket2: NETWORK_STREAM_SOCKET
			l_array: ARRAY[STRING]
			i: INTEGER
			l_count: INTEGER
			l_size: INTEGER
		do
			if not l_retry then
				l_size := 100000		-- 1000 is too small to notice.
				create l_array.make_filled (Void, 1, l_size)

				from
					i := 1
				until
					i > l_size
				loop
					l_array.force("hi", i)
					i := i + 1
				end

				create l_socket.make_server_by_port (2345)
				l_socket.listen(5)
			else
				print(l_count.out + " sends.%N")
			end

			l_socket.accept
			l_socket2 := l_socket.accepted

			from
				l_count := 0
			until
				False
			loop
				l_socket2.independent_store (l_array)
				l_count := l_count + 1
			end
		rescue
			l_retry := True
			retry
		end

	do_client
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			create l_socket.make_client_by_port(2345, "localhost")
			l_socket.connect

			from
				do_nothing
			until
				False
			loop
				if l_socket.retrieved.generating_type /~ "ARRAY [STRING]"
				then
					do_nothing
				end
			end
		end

end
