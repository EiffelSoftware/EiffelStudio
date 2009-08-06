note
	description: "[
		A server module that listens to requests from http server plugin and forwards them to the webapp.
		The response from the webapp is then sent back to the http server plugin.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_HTTP_CONN_MODULE

inherit
	XC_SERVER_MODULE
		rename
			make as base_make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER
	XU_STOPWATCH

create make

feature -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			-- Initializes current
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			base_make (a_name)
			main_server := a_main_server
	       	current_request_message := ""
            stop := False
         ensure
           main_server_set: equal (a_main_server, main_server)
           name_set: equal (name, a_name)
		end

feature -- Inherited Features

	execute
			-- <Precursor>
		local
			l_response: XC_COMMAND_RESPONSE
			l_http_socket: detachable NETWORK_STREAM_SOCKET
			l_webapp_handler: XS_WEBAPP_HANDLER
			full_collect_counter: INTEGER
		do
			full_collect_counter := 100
			stop := False
			launched := True
			running := True
			create l_http_socket.make_server_by_port (default_http_server_port)

			if not l_http_socket.is_bound then
				o.eprint ("Socket could not be bound on port " + default_http_server_port.out , generating_type)
			else
				create l_webapp_handler
	 	       	l_http_socket.set_accept_timeout (1)
				from
	                l_http_socket.listen (max_tcp_clients.as_integer_32)
	                o.dprint("HTTP Connection Server ready on port " + default_http_server_port.out,2)
	            until
	            	stop
	            loop
	                l_http_socket.accept
	                if full_collect_counter >= 100 then
						full_collect_counter := 0
			--			{MEMORY}.full_collect
	                else
	                	full_collect_counter := full_collect_counter + 1
	                end
	                if not stop then
			            if attached {NETWORK_STREAM_SOCKET} l_http_socket.accepted as thread_http_socket then

			            	if config.args.debug_level >= 7 then
			            		start_time
			            	end

			            	 if receive_message (thread_http_socket) then
								l_response := l_webapp_handler.forward_request (current_request_message)
			            	else
								l_response := (create {XER_BAD_SERVER_ERROR}.make ("Error decoding.")).render_to_command_response
							end

							if attached {XCCR_HTTP_REQUEST} l_response as l_http_response then
								send_message_to_http (l_http_response.response.render_to_string, thread_http_socket)
							else
								o.eprint ("Could not retrieve response from webapp", generating_type)
							end

				         	thread_http_socket.cleanup
				            check
				            	thread_http_socket.is_closed
				            end
				            if config.args.debug_level >= 7 then
			            		o.dprint ("Server Request Time: " + stop_time, 7)
			            	end
						end
					end
	            end
	            l_http_socket.cleanup
	        	check
	        		l_http_socket.is_closed
	       		end
       		end
       		running := False
       		o.dprint("HTTP Connection Server ends.",2)
       		rescue
       			o.eprint ("HTTP Connection Server Module shutdown due to exception. Please relaunch manually.", generating_type)

				if attached {NETWORK_STREAM_SOCKET} l_http_socket as ll_http_socket then
					ll_http_socket.cleanup
					check
		        		ll_http_socket.is_closed
		       		end
				end

				stop := True
				running := False
       	end

feature -- Access

	stop: BOOLEAN
			-- Set true to stop accept loop

feature {NONE} -- Access

	main_server: XC_SERVER_INTERFACE

	current_request_message: STRING

	Max_fragments: INTEGER = 1000

feature -- Status

--	is_bound: BOOLEAN
--			-- Checks if the socket could be bound
--		do
--			Result := http_socket.is_bound
--		end


feature -- Constants

	default_http_server_port: INTEGER = 55001
			-- Port for communication between http server and xebra server

	max_tcp_clients: NATURAL = 100
			-- Maximal number of clients which can simultanuously connect

	max_thread_number: NATURAL = 10
			-- Maximal number of simultaneous threads



feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
		end


feature {NONE} -- Implementation

	send_message_to_http (a_message: STRING; a_http_socket: NETWORK_STREAM_SOCKET)
			-- Sends a string over the specified socket.
		require
			a_http_socket_is_open: not a_http_socket.is_closed
		local
			l_data: MANAGED_POINTER
			l_fragment: BOOLEAN
			l_index, l_message_size, l_fragment_size: NATURAL
		do
			o.dprint ("Sending response to http",2)
			create l_data.make ({XS_MESSAGE}.message_upper_bound.as_integer_32 + {PLATFORM}.natural_32_bytes)
			l_fragment := false
			l_message_size := a_message.count.as_natural_32
			if l_message_size > {XS_MESSAGE}.message_upper_bound then
				create l_data.make ({XS_MESSAGE}.message_upper_bound.as_integer_32 + {PLATFORM}.natural_32_bytes)
			end
			from
				l_index := 1
			until
				l_index > a_message.count.as_natural_32
			loop
				l_fragment := (a_message.count.as_natural_32 - l_index) > {XS_MESSAGE}.message_upper_bound
				l_fragment_size := {XS_MESSAGE}.message_upper_bound.min (a_message.count.as_natural_32-l_index+1)

				write_message_to_data (l_data, a_message, l_index, l_index + l_fragment_size, l_fragment)
				a_http_socket.put_managed_pointer (l_data, 0, l_fragment_size.as_integer_32 + {PLATFORM}.natural_32_bytes)
				l_index := l_index + l_fragment_size
			end
		end



	write_message_to_data (a_d: MANAGED_POINTER;
						   a_message: STRING;
						   a_start_index, a_end_index: NATURAL;
						   a_fragment: BOOLEAN)
			-- Encodes the string so that it can be sent over the net and be read by mod_xebra.
		require
			data_attached: a_d /= Void
			data_is_allocatd: a_d.count > 0
			index_plausible: a_start_index < a_end_index
			start_index_in_boundaries: a_start_index > 0 and a_start_index <= a_message.count.as_natural_32
			end_index_in_boundaries: a_end_index > 0 and a_end_index <= a_message.count.as_natural_32+1
		local
			l_encoder: XS_ENCODING_FACILITIES
			l_i: NATURAL
		do
			create l_encoder.make
			a_d.put_natural_32_be
				(l_encoder.encode_natural ((a_end_index - a_start_index).as_natural_32, a_fragment), 0)
			from
				l_i := a_start_index
			until
				l_i > a_end_index-1
			loop
				a_d.put_character (a_message [l_i.as_integer_32], l_i.as_integer_32 - a_start_index.as_integer_32 + {PLATFORM}.natural_32_bytes)
				l_i := l_i + 1
			variant
				(a_end_index - l_i).as_integer_32
			end
		end

	read_string (a_socket: NETWORK_STREAM_SOCKET; a_n: NATURAL): STRING
			-- Reads `n' characters from the socket and concatenates them to a string
		require
			socket_is_open: not a_socket.is_closed
			n_small_enough: a_n <= {XS_MESSAGE}.message_upper_bound
		local
			l_read_size: INTEGER
			l_buf: detachable STRING
		do
			create Result.make (a_n.as_integer_32)
			create l_buf.make (a_n.as_integer_32)
			from
				l_read_size := 0
				Result := ""
			until
				(a_n.as_integer_32 - l_read_size) = 0
			loop
				a_socket.read_stream_thread_aware (a_n.as_integer_32 - l_read_size)
				l_buf := a_socket.last_string
				if l_buf /= void then
					Result.append (l_buf)
				end
				l_read_size := Result.count
			end
		ensure
			Result_attached: Result /= Void
		end

	receive_message (a_http_socket: NETWORK_STREAM_SOCKET): BOOLEAN
			-- Decodes an incoming message and stores it in current_request_message. Returns true if sucessfull
		require
			a_http_socket: a_http_socket /= Void and then not a_http_socket.is_closed
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_response: XH_RESPONSE
			l_msg: XS_MESSAGE
			l_frag_counter: INTEGER
			l_request_factory: XH_REQUEST_PARSER
			l_buf: STRING
			l_error: BOOLEAN
			l_retried: BOOLEAN
			encoder: XS_ENCODING_FACILITIES
		do
			create encoder.make
			if not l_retried then
				create l_webapp_handler
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
					Result := False
					current_request_message := ""
				else
					current_request_message := l_msg.string
					Result := True

				end
            else
            	o.eprint ("Exception while receiving message", generating_type)
            end
            rescue
            	l_retried := True
            	retry
		end

invariant
	main_server_attached: main_server /= Void
end
