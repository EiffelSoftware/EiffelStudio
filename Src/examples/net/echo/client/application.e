note
	description: "Client side for processing echo."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

	INET_ADDRESS_FACTORY

	INET_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make
		local
			host: STRING
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			address: detachable INET_ADDRESS
			timeout: INTEGER
			l_socket: NETWORK_STREAM_SOCKET
		do
			host := "localhost"
			port := 12111

			if argument_count > 0  then
				host := argument (1)
				if argument_count > 1 then
					port := argument (2).to_integer
				end
				if argument_count > 2 then
					prefer_ipv4_stack := argument (3).to_boolean
				end
				if argument_count > 3 then
					timeout := argument (4).to_integer
				end
			end

			if prefer_ipv4_stack then
				set_ipv4_stack_preferred (True)
			end

			io.put_string ("start echo_client")
			io.put_string (" host = ")
			io.put_string (host)
			io.put_string (", port = ")
			io.put_integer (port)
			io.put_new_line

				-- Obtain the host address
			address := create_from_name (host)
			if address = Void then
				io.put_string ("Unknown host " + host)
				io.put_new_line
			else
					-- Create the socket connection to the Echo Server.
				create l_socket.make_client_by_address_and_port (address, port)
					-- Set the connection timeout
				l_socket.set_connect_timeout (timeout)
					-- Connect to the Server
				l_socket.connect
				if not l_socket.is_connected then
					io.put_string ("Unable to connect to host " + host + ":" + port.out)
					io.put_new_line
				else

						-- Since this is the client, we will initiate the talking.
					send_message_and_receive_reply (l_socket, "Hello")
					send_message_and_receive_reply (l_socket, "This")
					send_message_and_receive_reply (l_socket, "is")
					send_message_and_receive_reply (l_socket, "a")
					send_message_and_receive_reply (l_socket, "test")

						-- Send the special string to tell server to quit.
					send_message (l_socket, "quit")

						-- Close the connection
					l_socket.close
				end
			end
			io.put_string ("finish echo_client")
			io.put_new_line
		end

feature {NONE} --Implementation

	send_message_and_receive_reply (a_socket: SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			send_message (a_socket, message)
			receive_reply (a_socket)
		end

	send_message (a_socket: SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			a_socket.put_string (message + "%N")
		end

	receive_reply (a_socket: SOCKET)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read
		local
			l_last_string: detachable STRING
		do
			a_socket.read_line
			l_last_string := a_socket.last_string
			check l_last_string_attached: l_last_string /= Void end
			io.put_string ("Server Says: ")
			io.put_string (l_last_string)
			io.put_new_line
		end

end
