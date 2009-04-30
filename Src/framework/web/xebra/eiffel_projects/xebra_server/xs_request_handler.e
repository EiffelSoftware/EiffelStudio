note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_REQUEST_HANDLER

inherit
	XU_SHARED_OUTPUTTER

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

	encoder: XS_ENCODING_FACILITIES
			-- Encodes and decodes incoming and outgoing messages


feature --Execution

	do_execute (a_http_socket: NETWORK_STREAM_SOCKET; a_compile_service: XS_COMPILE_SERVICE)
			-- <Predecessor>
			-- Waits for one incoming module request and
		require
			a_http_socket: not a_http_socket.is_closed
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_request_message: STRING
			l_response: XH_RESPONSE
			l_header: TUPLE [size: NATURAL; fragment: BOOLEAN]
			l_i: INTEGER
			l_request_factory: XH_REQUEST_FACTORY
		do
			create l_webapp_handler.make (a_compile_service)
			create l_request_factory.make
			from
				l_request_message := ""
          		l_header := [{NATURAL}0, true]
           		l_i := 1
           	until
				not l_header.fragment
           	loop
           		a_http_socket.read_natural_32
           		l_header := encoder.decode_natural_and_flag (a_http_socket.last_natural_32)
           		if l_header.size > internal_max_size then
           			l_header.fragment := false
           		else
           			l_request_message.append_string(read_string (a_http_socket, l_header.size))
           			l_i := l_i + 1
           		end
           	end

			l_response := l_webapp_handler.forward_request_to_app (l_request_message)

			o.dprint ("Sending response to http",2)
			send_message_to_http (l_response.render_to_string, a_http_socket)

         	a_http_socket.cleanup
            check
            	a_http_socket.is_closed
            end
		end

feature {NONE} -- Implementation

	send_message_to_http (a_message: STRING; a_http_socket: NETWORK_STREAM_SOCKET)
			-- Sends a string over the specified socket.
		require
			a_http_socket_is_open: not a_http_socket.is_closed
		local
			 l_fragment: BOOLEAN
			 l_index, l_message_size, l_fragment_size: NATURAL
		do
			l_fragment := false
			l_message_size := a_message.count.as_natural_32
			if l_message_size > internal_default_size then
				create data.make (internal_max_size.as_integer_32 + {PLATFORM}.natural_32_bytes)
			end
			from
				l_index := 1
			until
				l_index > a_message.count.as_natural_32
			loop
				l_fragment := (a_message.count.as_natural_32 - l_index) > internal_max_size
				l_fragment_size := internal_max_size.min (a_message.count.as_natural_32-l_index+1)

				write_message_to_data (data, a_message, l_index, l_index + l_fragment_size, l_fragment)
				a_http_socket.put_managed_pointer (data, 0, l_fragment_size.as_integer_32 + {PLATFORM}.natural_32_bytes)
				l_index := l_index + l_fragment_size
			end
		end



	write_message_to_data (d: MANAGED_POINTER;
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
