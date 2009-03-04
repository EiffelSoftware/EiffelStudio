note
	description: "Handles incoming requests from http_module and sends it to the appropriate XebraApp {XB_MOD_HANDLER}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_MOD_HANDLER

create
	make

feature --Initialization

	make (message_default_bound, message_upper_bound: NATURAL)
			-- Must be pooled in `thread_pool'
			-- Upper and lower `message_upperbound', `message_default_bound') bound for the buffer.
			-- If messages are bigger than lower, upper is allocated
		require
			default_smaller_than_max: message_default_bound < message_upper_bound
		do
			internal_max_size := message_upper_bound
			internal_default_size := message_default_bound
			create data.make (message_default_bound.as_integer_32 + {PLATFORM}.natural_32_bytes)
			create encoder.make
		end

feature {NONE} -- Access

	data: MANAGED_POINTER
			-- Buffer for sending and receiving messages

	internal_max_size: NATURAL
			-- Maximal size of a data packet

	internal_default_size: NATURAL
			-- Initial size of data packet. Will be expanded to `internal_default_size' if needed.

	encoder: ENCODING_FACILITIES
			-- Encodes and decodes incoming and outgoing messages

feature --Execution

	do_execute (socket: NETWORK_STREAM_SOCKET)
			-- <Predecessor>
			-- Waits for one incoming module request and delegates it to the appropriate XebraApp
		require
			socket_open: not socket.is_closed
		local
			response, message: STRING
			header: TUPLE [size: NATURAL; fragment: BOOLEAN]
			i: INTEGER
		do
			print (".")
			from
				message := ""
          		header := [{NATURAL}0, true]
           		i := 1
           	until
				not header.fragment
           	loop
           		socket.read_natural_32
           		header := encoder.decode_natural_and_flag (socket.last_natural_32)
           		if header.size > internal_max_size then
           			header.fragment := false
           		else
           			message.append_string(read_string (socket, header.size))
           			i := i + 1
           		end
           	end

			response := send_request (message, socket) --FIXME: last argument is WRONG!
			send_string (response, socket)
         	socket.cleanup
            check
            	socket.is_closed
            end
		end

feature {NONE} -- Implementation

	send_request (a_message: STRING; webapp_socket: NETWORK_STREAM_SOCKET): STRING
			--Sends a request to the correct webserver.
		require
			webapp_connected: not webapp_socket.is_closed
		local
			soc1: NETWORK_STREAM_SOCKET
			message: STRING
		do
			create soc1.make_client_by_port (3491, "localhost")
            soc1.connect

            message := a_message

            soc1.independent_store (message)
            Result := "Error"
            if attached {STRING} soc1.retrieved as rec_message then
            	Result := rec_message
            end

            soc1.cleanup

		end

	send_string (message: STRING; app_socket: NETWORK_STREAM_SOCKET)
			-- Sends a string over the specified socket.
		require
			socket_is_open: not app_socket.is_closed
		local
			 fragment: BOOLEAN
			 index, message_size, fragment_size: NATURAL
		do
			fragment := false
			message_size := message.count.as_natural_32
			if message_size > internal_default_size then
				create data.make (internal_max_size.as_integer_32 + {PLATFORM}.natural_32_bytes)
			end
			from
				index := 1
			until
				index > message.count.as_natural_32
			loop
				fragment := (message.count.as_natural_32 - index) > internal_max_size
				fragment_size := internal_max_size.min (message.count.as_natural_32-index+1)

				write_message_to_data (data, message, index, index + fragment_size, fragment)
				app_socket.put_managed_pointer (data, 0, fragment_size.as_integer_32 + {PLATFORM}.natural_32_bytes)
				index := index + fragment_size
			end
		end

	write_message_to_data ( d: MANAGED_POINTER;
							message: STRING;
							start_index, end_index: NATURAL;
							fragment: BOOLEAN)
			-- Encodes the string so that it can be sent over the net and be read by mod_xebra.
		require
			data_attached: d /= Void
			data_is_allocatd: d.count > 0
			index_plausible: start_index < end_index
			start_index_in_boundaries: start_index > 0 and start_index <= message.count.as_natural_32
			end_index_in_boundaries: end_index > 0 and end_index <= message.count.as_natural_32+1
		local
			i: NATURAL
		do
			d.put_natural_32_be
				(encoder.encode_natural ((end_index - start_index).as_natural_32, fragment), 0)
			from
				i := start_index
			until
				i > end_index-1
			loop
				d.put_character (message [i.as_integer_32], i.as_integer_32 - start_index.as_integer_32 + {PLATFORM}.natural_32_bytes)
				i := i + 1
			variant
				(end_index -i).as_integer_32
			end
		end


	read_string (socket: NETWORK_STREAM_SOCKET; n: NATURAL): STRING
			-- Reads `n' characters from the socket and concatenates them to a string
		require
			socket_is_open: not socket.is_closed
			n_small_enough: n <= internal_max_size
		local
			read_size: INTEGER
			buf: detachable STRING
		do
			create Result.make (n.as_integer_32)
			create buf.make (n.as_integer_32)
			from
				read_size := 0
				Result := ""
			until
				(n.as_integer_32-read_size) = 0
			loop
				socket.read_stream_thread_aware (n.as_integer_32-read_size)
				buf := socket.last_string
				if buf /= void then
					Result.append (buf)
				end
				read_size := Result.count
			end
		end

end
