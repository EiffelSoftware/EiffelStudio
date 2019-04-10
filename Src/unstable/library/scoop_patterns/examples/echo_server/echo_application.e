note
	description: "[
		Example application that starts an ECHO_SERVER on a separate processor and tears it down after 10 seconds.
		Using telnet, it is possible to send message on port 2000, including message "stop" to shutdown the server.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	ECHO_APPLICATION

inherit

	CP_STARTABLE_UTILS

create
	make

feature -- Constants

	listen_port: INTEGER = 2_000
			-- The port to listen for.

	listen_queue_count: INTEGER = 5
			-- The maximum number of client connections to be queued.

	accept_timeout: INTEGER = 500
			-- The socket accept timeout in milliseconds.

	second: INTEGER_64 = 1_000_000_000
			-- The number of nanoseconds in a second.

feature {NONE} -- Initialization

	make
			-- Start the application.
		local
			env: EXECUTION_ENVIRONMENT
			server: separate ECHO_SERVER
		do
			create env

			create server.make
			async_start (server)

			env.sleep (10 * second)
			stop (server)
		end

	stop (a_server: separate ECHO_SERVER)
			-- Stop `a_server'.
		do
			a_server.stop
		end

end
