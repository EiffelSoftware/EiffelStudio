class
	TEST

inherit
	ARGUMENTS

	EXECUTION_ENVIRONMENT
		rename
			command_line as exec_command_line
		end

create
	make

feature {NONE} -- Initialization
	make
		local
			l_server: WORKER_THREAD
			s: NETWORK_STREAM_SOCKET
		do
			create l_server.make(agent server)
			l_server.launch

				-- Active wait until thread is fully launched
			from
			until
				is_launched
			loop
				sleep (1_000_000_000)
			end

			create s.make_client_by_port (port, "127.0.0.1")
			s.set_non_blocking
			if argument_count >= 1 and then argument (1).is_integer then
				s.set_connect_timeout (argument (1).to_integer)
			end
			s.connect
			if not s.socket_ok or not (s.is_open_write or s.connect_in_progress) then
				print("Connect failed%N")
			end

			s.read_integer
			if s.bytes_read >= 0 then
				print ("No way%N")
			end

			s.cleanup
			l_server.join
		end

feature -- Access

	port: INTEGER = 17530

	is_launched: BOOLEAN

feature {NONE} -- Implementation

	server
		local
			s: NETWORK_STREAM_SOCKET
		do
			create s.make_server_by_port (port)
			is_launched := True
			s.listen(1)
			s.accept
				-- We do not close the socket as we don't want to have the recipient getting
				-- such a notification.
		end
end
