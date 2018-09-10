note
	description: "Summary description for {E2B_REMOTE_EXECUTABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_REMOTE_EXECUTABLE

inherit

	E2B_EXECUTABLE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize remote executable.
		do
		end

feature -- Access

	last_output: detachable STRING
			-- <Precursor>

feature -- Status report

	is_running: BOOLEAN
			-- <Precursor>
		do
			if attached thread as l_thread then
				Result := not is_canceled and not l_thread.terminated
			end
		end

feature -- Basic operations

	run
			-- <Precursor>
		local
			l_finished: BOOLEAN
			l_retry: BOOLEAN
		do
			is_canceled := False
			async_thread_implementation
		rescue
			l_retry := True
			retry
		end

	run_asynchronous
			-- <Precursor>
		do
			is_canceled := False
			create thread.make (agent async_thread_implementation)
			thread.launch
		end

	cancel
			-- <Precursor>
		do
			is_canceled := True
			if attached socket as l_socket and then not l_socket.is_closed then
				l_socket.close
			end
			if attached thread as l_thread and then not l_thread.terminated then
				l_thread.join
			end
		end

feature {NONE} -- Implementation

	socket: detachable NETWORK_STREAM_SOCKET
			-- Socket used for communication.

	thread: detachable WORKER_THREAD
			-- Worker thread used for asynchronous execution.

	is_canceled: BOOLEAN
			-- Is execution canceled?

	send_input
			-- Send Boogie input through socket.
		local
			l_file: PLAIN_TEXT_FILE
		do
			from
				input.boogie_files.start
			until
				input.boogie_files.after
			loop
				create l_file.make_open_read (input.boogie_files.item)
				from
					create l_file.make_open_read (input.boogie_files.item)
				until
					not l_file.readable
				loop
					l_file.read_line
					socket.put_string (l_file.last_string)
					socket.put_character ('%N')
				end
				input.boogie_files.forth
			end
			from
				input.custom_content.start
			until
				input.custom_content.after
			loop
				socket.put_string (input.custom_content.item)
				input.custom_content.forth
			end
		end

	async_thread_implementation
			-- Worker thread for asynchronous implementation.
		local
			l_finished: BOOLEAN
			l_retry: BOOLEAN
			l_exec: EXECUTION_ENVIRONMENT
		do
			if l_retry then
				if not socket.is_closed then
					socket.close
				end
			else
				create l_exec
				create socket.make_client_by_port (33892, "funk.inf.ethz.ch")
				create last_output.make (1024)
				socket.connect
				socket.put_string ("boogie%N")
				socket.read_line
				if socket.last_string.is_equal ("ready") then
					send_input

					socket.put_string ("%NFINISHED%N")

					from
						l_finished := False
					until
						l_finished or socket.is_closed or is_canceled
					loop
						if socket.is_readable then
							socket.read_line
							if socket.last_string.is_equal ("FINISHED") then
								l_finished := True
							else
								last_output.append (socket.last_string)
								last_output.append_character ('%N')
							end
						else
							l_exec.sleep (10_000_000)
						end
					end

				end

				if not socket.is_closed then
					socket.close
				end
			end
		rescue
			l_retry := True
			retry
		end

end
