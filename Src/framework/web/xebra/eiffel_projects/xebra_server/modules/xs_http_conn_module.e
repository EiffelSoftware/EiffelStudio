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
			make as module_make
		end

	THREAD

	XS_SHARED_SERVER_CONFIG

	XS_SHARED_SERVER_OUTPUTTER

	XU_STOPWATCH

create
	make

feature {NONE} -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			-- Initializes current
			--
			-- `a_main_server': The main server object
			-- `a_name': The name of this module
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			module_make (a_name)
			main_server := a_main_server
	       	current_request_message := ""
            is_stop_requested := False
         ensure
           main_server_set: a_main_server ~ main_server
           current_request_message_attached: current_request_message /= Void
           name_set: name ~ a_name
	end

feature -- Inherited Features

	execute
			-- <Precursor>
			-- Creates a socket and connects to the http server plugin.
			-- Waits to receive a request message from the http server plugin and sends it to the appropriate webapp.
			-- Awaits a XC_COMMAND_RESPONSE from the webapp and if it is a XCCR_HTTP_REQUEST sends it back to the http server plugin.
		local
			l_response: XC_COMMAND_RESPONSE
			l_http_socket: detachable NETWORK_STREAM_SOCKET
			l_webapp_handler: XS_WEBAPP_HANDLER
		do
			is_stop_requested := False
			is_launched := True
			is_running := True
			create l_http_socket.make_server_by_port ({XU_CONSTANTS}.Http_server_port)

			if not l_http_socket.is_bound then
				log.eprint ("Socket could not be bound on port " + {XU_CONSTANTS}.Http_server_port.out , generating_type)
			else
				create l_webapp_handler
	 	       	l_http_socket.set_accept_timeout ({XU_CONSTANTS}.Socket_accept_timeout)
				from
	                l_http_socket.listen ({XU_CONSTANTS}.Max_tcp_clients.as_integer_32)
	                log.dprint("HTTP Connection Server ready on port " + {XU_CONSTANTS}.Http_server_port.out, log.debug_start_stop_components)
	            until
	            	is_stop_requested
	            loop
	                l_http_socket.accept
	                if not is_stop_requested then
			            if attached {NETWORK_STREAM_SOCKET} l_http_socket.accepted as thread_http_socket then

			            	if config.args.debug_level >= log.debug_configuration then
			            		start_time
			            	end

			            	 if receive_message_from_http (thread_http_socket) then
								l_response := l_webapp_handler.forward_request (current_request_message)
			            	else
								l_response := (create {XER_INTERNAL_SERVER_ERROR}.make ("Error decoding message from mod_xebra.")).render_to_command_response
							end

							debug
								log.iprint ("%N%N----%N" + current_request_message + "%N")
							end

							if attached {XCCR_HTTP_REQUEST} l_response as l_http_response then
								debug
									log.iprint ("%N%N-------------%N" + l_http_response.response.render_to_string + "%N")
								end
								send_message_to_http_server (l_http_response.response.render_to_string, thread_http_socket)
							else
								send_message_to_http_server ( (create {XER_INTERNAL_SERVER_ERROR}.make ("")).render_to_response.render_to_string, thread_http_socket)
							end

				         	thread_http_socket.cleanup
				            check
				            	thread_http_socket.is_closed
				            end
				            if config.args.debug_level >= log.debug_configuration then
				            	stop_time
			            		log.dprint ("Server Request Time: " + last_elapsed_time, log.debug_configuration)
			            	end
						end
					end
	            end
	            l_http_socket.cleanup
	        	check
	        		l_http_socket.is_closed
	       		end
       		end
       		is_running := False
       		log.dprint("HTTP Connection Server ends.", log.debug_start_stop_components)
       	rescue
       		log.eprint ("HTTP Connection Server Module shutdown due to exception. Please relaunch manually.", generating_type)

			if attached {NETWORK_STREAM_SOCKET} l_http_socket as ll_http_socket then
				ll_http_socket.cleanup
				check
	        		ll_http_socket.is_closed
	       		end
			end
			is_stop_requested := True
			is_running := False
       	end

feature -- Access

	is_stop_requested: BOOLEAN
			-- Set true to stop accept loop

feature {NONE} -- Access

	main_server: XC_SERVER_INTERFACE
			-- The main server object

	current_request_message: STRING
			-- Stores the current request message received from http server

	Max_fragments: INTEGER = 1000
			-- Defines the maximum number of fragments that can be received

feature -- Status setting

	shutdown
			-- Stops the thread
		do
			is_stop_requested := True
		end

feature {NONE} -- Implementation

	send_message_to_http_server (a_message: STRING; a_http_socket: NETWORK_STREAM_SOCKET)
			-- Sends a string over the specified socket.
			--
			-- `a_message': The message to be sent
			-- `a_http_socket': The socket to be used
		require
			a_http_socket_attached: a_http_socket /= Void
			a_http_socket_is_open: not a_http_socket.is_closed
			a_message_attached: a_message /= Void
			a_message_not_empty: not a_message.is_empty
		local
			l_data: MANAGED_POINTER
			l_fragment: BOOLEAN
			l_index, l_message_size, l_fragment_size: NATURAL
		do
			log.dprint ("Sending response to http", log.debug_tasks)
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

				encode_string (l_data, a_message, l_index, l_index + l_fragment_size, l_fragment)
				a_http_socket.put_managed_pointer (l_data, 0, l_fragment_size.as_integer_32 + {PLATFORM}.natural_32_bytes)
				l_index := l_index + l_fragment_size
			end
		end

	encode_string (a_d: MANAGED_POINTER;
						   a_message: STRING;
						   a_start_index, a_end_index: NATURAL;
						   a_fragment: BOOLEAN)
			-- Encodes the string so that it can be sent over the net and be read by the http server plugin.
			--
			-- `a_d': A destination address for the data
			-- `a_message': The data source
			-- `a_start_index': Read the characters in a_message from here...
			-- `a_end_index': ...until here.
			-- `a_fragment': Defines if this is a message fragment or not.
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

	read_string_from_socket (a_socket: NETWORK_STREAM_SOCKET; a_n: NATURAL): STRING
			-- Reads `n' characters from the socket and concatenates them to a string
			--
			-- `a_socket': The socket to read from
			-- `a_n': The number of characters to read
			-- `Result': The created string
		require
			socket_is_open: not a_socket.is_closed
			n_small_enough: a_n <= {XS_MESSAGE}.message_upper_bound
		local
			l_read_size: INTEGER
			l_buf: detachable STRING
		do
			create Result.make (a_n.as_integer_32)
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

	receive_message_from_http (a_http_socket: NETWORK_STREAM_SOCKET): BOOLEAN
			-- Decodes an incoming message and stores it in current_request_message. Returns true if sucessful
			--
			-- `a_http_socket': The socket to read from
			-- `Result': Returns true if receiving was successful.
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
		           			log.eprint ("Could not decode msg length", generating_type)
		           		else
		           			l_buf := read_string_from_socket (a_http_socket, l_msg.length)
		           			l_msg.append_string(l_buf)
		           		if (l_frag_counter >= Max_fragments) then
		           			l_error := True
		           			log.eprint ("Maximumg fragments reached", generating_type)
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
            	log.eprint ("Exception while receiving message", generating_type)
            end
            rescue
            	l_retried := True
            	retry
		end

invariant
	main_server_attached: main_server /= Void
	current_request_message_attached: current_request_message /= Void
end
