indexing
	description: "Server side for processing echo."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make is
		local
			port: INTEGER
			done: BOOLEAN
			listen_socket: NETWORK_STREAM_SOCKET
			client_socket: NETWORK_STREAM_SOCKET
		do
			port := 12111

			if argument_count > 0  then
				port := argument (1).to_integer
			end

			io.put_string ("starting echo_server")
			io.put_string (" port = ")
			io.put_integer (port)
			io.put_new_line

				-- Create the Server socket
			create listen_socket.make_server_by_port (port)
				-- Listen on Server Socket
			listen_socket.listen (2)
			from
				done := False
			until
				done
			loop
				listen_socket.accept
				client_socket := listen_socket.accepted
				perform_client_communication (client_socket)
			end
			listen_socket.close
			io.put_string ("finish echo_server%N")
		end

feature {NONE} -- Implementation

	perform_client_communication (socket: NETWORK_STREAM_SOCKET) is
		require
			socket_attached: socket /= Void
		local
			done: BOOLEAN
		do
			from
				done := False
			until
				done
			loop
				done := receive_message_and_send_replay (socket)
			end

		end

	receive_message_and_send_replay (client_socket: NETWORK_STREAM_SOCKET): BOOLEAN is
		require
			socket_attached: client_socket /= Void
			socket_valid: not client_socket.is_closed
		local
			message: STRING
		do
			client_socket.read_line
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

	send_reply (client_socket: NETWORK_STREAM_SOCKET; message: STRING) is
		require
			socket_attached: client_socket /= Void
			socket_valid: not client_socket.is_closed
			message_attached: message /= Void
			message_not_empty: not message.is_empty
		do
			client_socket.put_string (message + "%N")
		end

end
