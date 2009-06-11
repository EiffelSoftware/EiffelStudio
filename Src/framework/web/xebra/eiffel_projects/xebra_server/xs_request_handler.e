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
	XS_SHARED_SERVER_OUTPUTTER

create
	make

feature --Initialization

	make
			-- Must be pooled in `thread_pool' (or not)
		do
			create data.make ({XS_MESSAGE}.message_upper_bound.as_integer_32 + {PLATFORM}.natural_32_bytes)
			create encoder.make
		end

feature {NONE} -- Access

	data: MANAGED_POINTER
			-- Buffer for sending and receiving messages

	encoder: XS_ENCODING_FACILITIES
			-- Encodes and decodes incoming and outgoing messages

feature {NONE} -- Constans

	Max_fragments: INTEGER = 1000

feature --Execution

	receive_message (a_http_socket: NETWORK_STREAM_SOCKET)
			-- <Predecessor>
			-- Waits for one incoming module request and
		require
			a_http_socket: not a_http_socket.is_closed
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_response: XH_RESPONSE
			l_msg: XS_MESSAGE
			l_frag_counter: INTEGER
			l_request_factory: XH_REQUEST_FACTORY
			l_buf: STRING
			l_error: BOOLEAN
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_webapp_handler.make
				create l_msg.make
				create l_request_factory.make
				from
		           		l_frag_counter := 0
		           		l_msg.flag := True
		           		l_error := False
		           	until
					not l_msg.flag or l_error
		           	loop
		           		a_http_socket.read_natural_32
		           		l_msg.length := encoder.decode_natural (a_http_socket.last_natural_32)
		          		l_msg.flag := encoder.decode_flag (a_http_socket.last_natural_32)
		           		if not l_msg.is_length_valid then
		          			l_error := True
		           			o.eprint ("Could not decode msg length", generating_type)
		           		else
		           			l_buf := read_string (a_http_socket, l_msg.length)
		           			l_msg.append_string(l_buf)
		           		if (l_frag_counter >= Max_fragments) then
		           			l_error := True
		           			o.eprint ("Maximumg fragments reached", generating_type)
		           		end
		           		l_frag_counter := l_frag_counter + 1
		           		end
		           	end

				if (l_error) then
					l_response := (create {XER_BAD_SERVER_ERROR}.make ("Error decoding.")).render_to_response
				else
					l_response := l_webapp_handler.forward_request_to_app (l_msg.string)
				end

				o.dprint ("Sending response to http",2)
				send_message_to_http (l_response.render_to_string, a_http_socket)

		         	a_http_socket.cleanup
		            check
		            	a_http_socket.is_closed
		            end
            else
            	o.eprint ("Exception while receiving message", generating_type)
            end
            rescue
            	l_retried := True
            	retry
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
			o.dprint ("Sending response to http",2)
			l_fragment := false
			l_message_size := a_message.count.as_natural_32
			if l_message_size > {XS_MESSAGE}.message_upper_bound then
				create data.make ({XS_MESSAGE}.message_upper_bound.as_integer_32 + {PLATFORM}.natural_32_bytes)
			end
			from
				l_index := 1
			until
				l_index > a_message.count.as_natural_32
			loop
				l_fragment := (a_message.count.as_natural_32 - l_index) > {XS_MESSAGE}.message_upper_bound
				l_fragment_size := {XS_MESSAGE}.message_upper_bound.min (a_message.count.as_natural_32-l_index+1)

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
			n_small_enough: n <= {XS_MESSAGE}.message_upper_bound
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
		ensure
			Result_attached: Result /= Void
		end

invariant
	data_attached: data /= Void
	encoder_attached: encoder /= Void
end
