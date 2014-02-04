note
	description: "Single threaded echo server."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name:OpenSSL certificates how to", "src=http://pages.cs.wisc.edu/~zmiller/ca-howto/", "protocol=uri"

class
	APPLICATION

inherit

	ARGUMENTS

	INET_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make
		local
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			listen_socket: SSL_NETWORK_STREAM_SOCKET
			accept_timeout: INTEGER
			l_address: detachable NETWORK_SOCKET_ADDRESS
			a_file_name: FILE_NAME
		do
			port := 12111

			if argument_count > 0  then
				port := argument (1).to_integer
				if argument_count > 1 then
					prefer_ipv4_stack := argument (2).to_boolean
				end
				if argument_count > 2 then
					accept_timeout := argument (3).to_integer
				end
			end

			if prefer_ipv4_stack then
				set_ipv4_stack_preferred (True)
			end

			io.put_string ("starting echo_server")
			io.put_string (" port = ")
			io.put_integer (port)
			io.put_new_line

				-- Create the Server socket
			create listen_socket.make_server_by_port (port)
			create a_file_name.make_from_string (ca_crt)
			listen_socket.set_certificate_file_name (a_file_name)
			create a_file_name.make_from_string (ca_key)
			listen_socket.set_key_file_name (a_file_name)

			if not listen_socket.is_bound then
				io.put_string ("Unable bind to port "+ port.out)
				io.put_new_line
			else
				l_address := listen_socket.address
				check l_address_attached: l_address /= Void end
				io.put_string ("Listening on address = " + l_address.host_address.host_address + " port = " + l_address.port.out)
				io.put_new_line
					-- Listen on Server Socket with queue length = 2
				listen_socket.listen (2)
					-- Set the accept timeout
				listen_socket.set_accept_timeout (accept_timeout)
				perform_accept_serve_loop (listen_socket)
			end
			listen_socket.close
			io.put_string ("finish echo_server%N")
		end

feature {NONE} -- Implementation

	perform_accept_serve_loop (socket: SSL_NETWORK_STREAM_SOCKET)
		require
			valid_socket: socket /= Void and then socket.is_bound
		local
			client_socket: detachable SSL_NETWORK_STREAM_SOCKET
		do
				socket.accept
				client_socket := socket.accepted
				if client_socket = Void then
						-- Some error occured, perhaps because of the timeout
						-- We probably should provide some diagnostics here
					io.put_string ("accept result = Void")
					io.put_new_line
				else
					perform_client_communication (client_socket)
				end
		end

	perform_client_communication (socket: SSL_NETWORK_STREAM_SOCKET)
		require
			socket_attached: socket /= Void
			socket_valid: socket.is_open_read and then socket.is_open_write
		local
			done: BOOLEAN
			l_address, l_peer_address: detachable NETWORK_SOCKET_ADDRESS
		do
			l_address := socket.address
			l_peer_address := socket.peer_address
			check
				l_address_attached: l_address /= Void
				l_peer_address_attached: l_peer_address /= Void
			end
			io.put_string ("Accepted client on the listen socket address = "+ l_address.host_address.host_address + " port = " + l_address.port.out +".")
			io.put_new_line
			io.put_string ("%T Accepted client address = " + l_peer_address.host_address.host_address + " , port = " + l_peer_address.port.out)
			io.put_new_line
			from
				done := False
			until
				done
			loop
				done := receive_message_and_send_replay (socket)
			end
			io.put_string ("Finished processing the client, address = "+ l_peer_address.host_address.host_address + " port = " + l_peer_address.port.out + ".")
			io.put_new_line
		end

	receive_message_and_send_replay (client_socket: SSL_NETWORK_STREAM_SOCKET): BOOLEAN
		require
			socket_attached: client_socket /= Void
			socket_valid: client_socket.is_open_read and then client_socket.is_open_write
		local
			message: detachable STRING
		do
				-- Limit client message size to 10
				-- It's here just to demonstrate the usage of the `read_line_until' routine
			client_socket.read_line_until (10)
			message := client_socket.last_string
			if message /= Void then
				if message.ends_with ("%R") then
					message.keep_head (message.count-1)
				end
				io.put_string ("Client Says :")
				io.put_string (message)
				io.put_new_line
				if message.is_case_insensitive_equal ("quit") then
					Result := True
					client_socket.close
				else
					send_reply (client_socket, message)
				end
			end
		end

	send_reply (client_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			socket_attached: client_socket /= Void
			socket_valid: client_socket.is_open_write
			message_attached: message /= Void
		do
			client_socket.put_string (message + "%N")
		end


feature -- SSL Certificates

			--| Chnage the following two path's to your own crt and key files.

	ca_crt: STRING = "C:/OpenSSL-Win64/bin/ca.crt"
		-- seff signed certificate.

	ca_key: STRING = "C:/OpenSSL-Win64/bin/ca.key"
		-- ca key.

end
