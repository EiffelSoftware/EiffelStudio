note
	description: "Client side for processing echo via SSL connection."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS_32
	INET_ADDRESS_FACTORY
	INET_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make
		local
			host: IMMUTABLE_STRING_8
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			address: detachable INET_ADDRESS
			timeout: INTEGER
			l_socket: SSL_NETWORK_STREAM_SOCKET
			client_get: STRING
		do
			host := "requestb.in"
--			host := "www.openssl.org"
			port := 443
			if argument_count > 0 then
				if attached argument (1) as arg_host and then arg_host.is_valid_as_string_8 then
					host := arg_host.to_string_8
				else
					io.error.put_string ("Error: the first argument is an unsupported host name (no Unicode in host name for now)!")
				end
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
				if timeout > 0 then
					l_socket.set_connect_timeout (timeout)
				end
					-- Connect to the Server
				l_socket.set_tls_server_name_indication ("www.requestb.in")

				l_socket.connect
				if not l_socket.is_connected then
					io.put_string ("Unable to connect to host " + host + ":" + port.out)
					io.put_new_line
				else
						-- Since this is the client, we will initiate the talking.
					client_get := "POST /api/v1/bins HTTP/1.1"
--					client_get := "GET / HTTP/1.1"
					client_get.append ("%R%N")
					client_get.append ("Host: " + host)
					client_get.append ("%R%N")
					client_get.append ("Cache-Control:max-age=0")
					client_get.append ("%R%N")
					client_get.append ("Accept:*/*;q=0.8")
					client_get.append ("%R%N")
					client_get.append ("upgrade-insecure-requests:1")
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
			send_message (a_socket, message)
			receive_reply (a_socket)
		end

	send_message (a_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			a_socket.put_string (message)
		end

	receive_reply (a_socket: SSL_NETWORK_STREAM_SOCKET)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read
		local
			l_last_string: STRING
		do
			l_last_string := receive_data (a_socket)
			io.put_string ("Server Says: ")
			io.put_string (l_last_string)
			io.put_new_line
		end

	receive_data (a_socket: SSL_NETWORK_STREAM_SOCKET): STRING
		local
			end_of_stream: BOOLEAN
		do
			from
				a_socket.read_line
				Result := ""
			until
				end_of_stream
			loop
				Result.append (a_socket.last_string)
				if a_socket.last_string /= Void and not a_socket.last_string.is_empty and a_socket.socket_ok then
					a_socket.read_line
				else
					end_of_stream := True
				end
			end
		end

end
