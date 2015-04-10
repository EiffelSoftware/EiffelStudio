note
	description: "Client side for processing echo via SSL connection."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

	INET_ADDRESS_FACTORY

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
			l_socket: SSL_NETWORK_STREAM_SOCKET
		do
			host := "samplechat.firebaseio-demo.com"
			port := 443
			if argument_count > 0 then
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
			io.put_string ("start ssl_client")
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
					--				l_socket.set_connect_timeout (100)
					-- Connect to the Server
				l_socket.connect
				l_socket.set_non_blocking
				if not l_socket.is_connected then
					io.put_string ("Unable to connect to host " + host + ":" + port.out)
					io.put_new_line
				else

						-- Since this is the client, we will initiate the talking.
					client_get.append ("%R%N")
					client_get.append ("Host: samplechat.firebaseio-demo.com")
					client_get.append ("%R%N")
					client_get.append ("Cache-Control: max-age=0")
					client_get.append ("%R%N")
					client_get.append ("Accept:*/*;q=0.8")
					client_get.append ("%R%N")
					client_get.append ("Connection: keep-alive")
					client_get.append ("%R%N")
					client_get.append ("%R%N")
					send_message_and_receive_reply (l_socket, client_get)

						-- Close the connection
					l_socket.close
				end
			end
			io.put_string ("finish echo_client")
			io.put_new_line
		end

feature {NONE} --Implementation

	send_message_and_receive_reply (a_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			send_message_ssl (a_socket, message)
			receive_reply (a_socket)
		end

	send_message (a_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			a_socket.put_string (message)
		end

	send_message_ssl (a_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		local
			a_package: PACKET
			a_data: MANAGED_POINTER
			c_string: C_STRING
		do
			create c_string.make (message)
			create a_data.make_from_pointer (c_string.item, message.count + 1)
			create a_package.make_from_managed_pointer (a_data)
			a_socket.send (a_package, 1)
		end

	receive_reply (a_socket: SSL_NETWORK_STREAM_SOCKET)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read
		local
			l_last_string: detachable STRING
		do
			l_last_string := receive_data (a_socket)
			if l_last_string /= Void then
				io.put_string ("Server Says: ")
				io.put_string (l_last_string)
				io.put_new_line
			else
				io.put_string ("No message from server%N")
			end
		end

	receive_data (a_socket: SSL_NETWORK_STREAM_SOCKET): detachable STRING
		local
			end_of_stream: BOOLEAN
			s: STRING
		do
			if a_socket.ready_for_reading then
				from
					a_socket.read_stream (1024)
					Result := ""
				until
					end_of_stream
				loop
					s := a_socket.last_string
					Result.append (s)
					if not s.is_empty and a_socket.socket_ok then
						a_socket.read_stream (1024)
					else
						end_of_stream := True
					end
				end
			end
		end

	client_get: STRING = "GET /users/jack/name.json HTTP/1.1"

end
