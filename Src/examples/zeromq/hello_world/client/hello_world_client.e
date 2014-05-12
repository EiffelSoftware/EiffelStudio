note
	description: "[
			Hello World Client, Connects REQ socket to tcp://localhost:5555 Sends Hello to server, expects World back
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Hello World Client", "src=https://github.com/imatix/zguide/blob/master/examples/C/hwclient.c", "protocol=uri"

class
	HELLO_WORLD_CLIENT

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_context: ZMQ_CONTEXT
			l_socket: ZMQ_SOCKET
			l_index: INTEGER
		do
			print ("Connecting Hello world server ...!%N")

				-- Initialize zmq
			create l_context.make
			l_socket := l_context.new_req_socket
			l_socket.connect ("tcp://127.0.0.1:5555")
			from
				l_index := 1
			until
				l_index > 1000
			loop
				print ("Sending Hello : " + l_index.out + "%N")
				l_socket.put_string ("Hello")
				l_socket.read_string
				print ("Received World: ");
				print (l_socket.last_string);
				print (" " + l_index.out + "%N");
				l_index := l_index + 1
			end
		end

end
