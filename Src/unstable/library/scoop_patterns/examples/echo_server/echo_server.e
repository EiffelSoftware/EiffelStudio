note
	description: "A simple Echo server process. The server may be stopped in two ways - either by calling `stop' %
				 % from another processor, or by sending the word stop through the network."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	ECHO_SERVER

inherit

		-- It is necessary to inherit from CP_INTERMITTENT_PROCESS, such that
		-- other processors have a chance to call `stop' on `Current'.

	CP_INTERMITTENT_PROCESS
		redefine
			cleanup
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
				-- Create the socket on the specified port.
			create socket.make_server_by_port ({ECHO_APPLICATION}.listen_port)
			check initialized: socket.is_bound end

				-- Disable lingering. This fixes a bug where the application can't be executed repeatedly.
			socket.set_linger_off

				-- Set an accept timeout. That way the server has a chance to re-execute its main loop from time to time.
			socket.set_accept_timeout ({ECHO_APPLICATION}.accept_timeout)

				-- Enable the socket.
			socket.listen ({ECHO_APPLICATION}.listen_queue_count)
		end

feature -- Basic operations

	step
			-- <Precursor>
		local
			l_received: STRING
		do
				-- Accept a new message. In case of a timeout the accepted socket is Void.
			debug
				print (".")
			end
			socket.accept
			if attached socket.accepted as l_answer_socket then
					-- Read the message.
				l_answer_socket.read_line
				l_received := l_answer_socket.last_string
				debug
					print ("%NReceived: " + l_received + "%N")
				end

					-- Check if the client wants us to stop.
				if l_received.starts_with ("stop") then
					is_stopped := True

						-- Generate and send the answer.
					l_answer_socket.put_string ("stopping")
				else
						-- Generate and send the answer.
					l_answer_socket.put_string (l_received)
				end
				l_answer_socket.put_new_line
				l_answer_socket.close
			end
		end

	cleanup
			-- <Precursor>
		do
			socket.cleanup
		end

	stop
			-- Stop the current processor.
		do
			is_stopped := True
		end

feature {NONE} -- Implementation

	socket: NETWORK_STREAM_SOCKET
			-- The network socket to send and receive STRING objects.

end
