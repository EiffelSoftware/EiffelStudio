note
	description: "[
		Translation for Hellow world C example, which opens
		a ØMQ socket on port 5555, reads requests on it, and replies with "World" to each
		request.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Hello World Example", "src=https://github.com/imatix/zguide/blob/master/examples/C/hwserver.c", "protocol=uri"

class
	HELLO_WORLD_SERVER

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Hello World Server
		local
			l_context: ZMQ_CONTEXT
			l_socket: ZMQ_SOCKET
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env

				-- Initialie 0MQ context
			create l_context.make
			l_socket := l_context.new_rep_socket
			l_socket.bind ("tcp://127.0.0.1:5555")


			from
			until
				False
			loop
					--  Wait for next request from client
				l_socket.read_string
				io.put_string ("Receive Hello: ")
				io.put_string (l_socket.last_string)
				io.put_new_line

					-- Do some work
				l_env.sleep (1)

					-- Send replay back to client
				l_socket.put_string ("World")
			end
		end

end
