indexing
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

	make is
		local
			host: STRING
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			address: INET_ADDRESS
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
			address := create_from_name(host)
			if address = Void then
				io.put_string ("Unknown host " + host)
				io.put_new_line
			else
					-- Create the socket connection to the Echo Server.
				create nss.make_client_by_address_and_port (address, port)
					-- Connect to the Server
				nss.connect
				if not nss.is_connected then
					io.put_string ("Unable to connect to host " + host + ":" + port.out)
					io.put_new_line
				else

						-- Since this is the client, we will initiate the talking.
					send_message_and_receive_reply ("Hello")
					send_message_and_receive_reply ("This")
					send_message_and_receive_reply ("is")
					send_message_and_receive_reply ("a")
					send_message_and_receive_reply ("test")

						-- Send the special string to tell server to quit.
					send_message ("quit")

						-- Close the connection
					nss.close
				end
			end
			io.put_string ("finish echo_client")
			io.put_new_line
		end

feature {NONE} --Implementation

	send_message_and_receive_reply (message: STRING) is
		require
			valid_socket: nss /= Void and then nss.is_open_read and then nss.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			send_message (message)
			receive_reply
		end

	send_message (message: STRING) is
		require
			valid_socket: nss /= Void and then nss.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			nss.put_string (message + "%N")
		end

	receive_reply is
		require
			valid_socket: nss /= Void and then nss.is_open_read
		do
			nss.read_line
			io.put_string ("Server Says: ")
			io.put_string (nss.last_string)
			io.put_new_line
		end

	nss: NETWORK_STREAM_SOCKET

end
