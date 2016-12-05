note
	description: "[
		API to perform actions like opening and closing the connection, sending and receiving messages, and listening
		for events triggered by the server
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_CLIENT_I

inherit
	WEB_SOCKET_SUBSCRIBER
		redefine
			on_websocket_error,
			on_websocket_text_message,
			on_websocket_binary_message,
			on_websocket_close,
			on_websocket_open,
			on_websocket_ping,
			on_websocket_pong
		end

	WEB_SOCKET

feature -- Initialization

	initialize (a_uri: READABLE_STRING_GENERAL; a_protocols: detachable ITERABLE [STRING])
			-- Initialize websocket client
		require
			is_valid_uri: is_valid_uri (a_uri)
		do
			uri := a_uri
			set_default_port
			create protocol.make_empty
			set_protocols (a_protocols)
			create ready_state.make
			socket := new_socket (port, host)
			create server_handshake.make
		end

	initialize_with_port (a_uri: READABLE_STRING_GENERAL; a_port: INTEGER; a_protocols: detachable ITERABLE [STRING])
			-- Initialize websocket client
		require
			is_valid_uri: is_valid_uri (a_uri)
		do
			uri := a_uri
			port := a_port
			create protocol.make_empty
			set_protocols (a_protocols)
			create ready_state.make
			socket := new_socket (port, host)
			create server_handshake.make
		end

	initialize_with_host_port_and_path (a_host: READABLE_STRING_GENERAL; a_port: INTEGER; a_path: READABLE_STRING_GENERAL)
		require
			is_valid_uri: is_valid_uri (a_host)
		do
			uri := a_host + ":" + a_port.out + a_path
			port := a_port
			create protocol.make_empty
			create ready_state.make
			socket := new_socket (port, host)
			create server_handshake.make
		end

feature -- Factory

	new_socket (a_port: INTEGER; a_host: STRING): HTTP_STREAM_SOCKET
			-- New socket for port `a_port' on host `a_host'.
		deferred
		end

feature -- Access

	socket: HTTP_STREAM_SOCKET
			-- Socket

	has_error: BOOLEAN
		do
			Result := implementation.has_error
		end

	is_server_hanshake_accepted: BOOLEAN

	is_valid_uri (a_uri: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_uri' a valid URI?
		local
			l_uri: URI
		do
			if a_uri.is_valid_as_string_8 then
				create l_uri.make_from_string (a_uri.to_string_8)
				Result := l_uri.is_valid
			end
		end

	server_handshake: WEB_SOCKET_HANDSHAKE_DATA
			-- Handshake data received from the server

feature -- Access: secure

	is_secure_connection_supported: BOOLEAN
			-- Is SSL supported?
		deferred
		end

	secure_protocol: detachable READABLE_STRING_GENERAL
			-- SSL protocol , if `is_secure_connection_supported'.

	secure_certificate_file: detachable PATH
			-- SSL certificate file , if `is_secure_connection_supported'.

	secure_certificate_key_file: detachable PATH
			-- SSL key file , if `is_secure_connection_supported'.

feature -- Element change

	set_secure_protocol (a_prot: like secure_protocol)
		do
			secure_protocol := a_prot
		end

	set_secure_certificate_file (p: detachable PATH)
			-- Set SSL certificate from file at `p'.
		do
			secure_certificate_file := p
		end

	set_secure_certificate_key_file (p: detachable PATH)
			-- Set SSL key from file at `p'.
		do
			secure_certificate_key_file := p
		end

feature -- Events API

	on_open (a_message: STRING)
		deferred
		end

	on_text_message (a_message: STRING)
		deferred
		end

	on_binary_message (a_message: STRING)
		deferred
		end

	on_close (a_code: INTEGER; a_reason: STRING)
		deferred
		end

	on_error (a_error: STRING)
		deferred
		end

feature -- Subscriber Events

	on_websocket_handshake (a_request: STRING)
			-- Send handshake message
		do
			socket.put_string (a_request)
		end

	on_websocket_text_message (a_message: STRING)
		do
			on_text_message (a_message)
		end

	on_websocket_binary_message (a_message: STRING)
		do
			on_binary_message (a_message)
		end

	on_websocket_open (a_message: STRING)
		do
			on_open (a_message)
		end

	on_websocket_close (a_message: STRING)
		do
			close_with_description (1000, a_message)
			on_close (1000, a_message)
		end

	on_websocket_error (a_error: STRING)
		do
			on_error (a_error)
			close_with_description (1002,"")
		end

	on_websocket_ping (a_message: STRING)
		do
			do_send (10, a_message)
		end

	on_websocket_pong (a_message: STRING)
		do
--			do_send (9, a_message)
		end

feature -- Execute

	execute
		require else
			is_socket_valid: socket.exists
		do
			set_implementation
			socket.connect
			check
				socket_connected: socket.is_connected
			end
			send_handshake
			receive_handshake
			if is_server_hanshake_accepted then
				ready_state.set_state ({WEB_SOCKET_READY_STATE}.open)
				on_websocket_open ("Open Connection")
				from
				until
					ready_state.is_closed or has_error
				loop
					receive
				end
			else
				on_websocket_error ("Server Handshake not accepted")
					--log(Not connected)
				socket.close
			end
		rescue
			on_websocket_close ("")
			socket.close
		end

feature -- Methods

	send (a_message: STRING)
		do
			do_send (1, a_message)
		end

	send_binary (a_message: STRING)
		do
			do_send (2, a_message)
		end

	close (a_id: INTEGER)
			-- Close a websocket connection with a close id : `a_id'
		do
			do_send (8, "")
			ready_state.set_state ({WEB_SOCKET_READY_STATE}.closed)
		end

	close_with_description (a_id: INTEGER; a_description: READABLE_STRING_GENERAL)
			-- Close a websocket connection with a close id : `a_id' and a description `a_description'
		do
			do_send (8, "")
			ready_state.set_state ({WEB_SOCKET_READY_STATE}.closed)
		end

feature {NONE} -- Implementation

	set_implementation
		do
			create implementation.make_with_protocols_and_port (Current, host, protocols, port)
		end

	send_handshake
		local
			l_uri: URI
			l_handshake: STRING
			l_random: SALT_XOR_SHIFT_64_GENERATOR
			l_secure_protocol: STRING
		do
			create l_uri.make_from_string (uri.as_string_8)
			create l_handshake.make_empty
			if l_uri.path.is_empty then
				l_handshake.append ("GET / HTTP/1.1")
				l_handshake.append (crlf)
			elseif l_uri.query = Void then
				l_handshake.append ("GET " + l_uri.path + " HTTP/1.1")
				l_handshake.append (crlf)
			else
				if attached l_uri.query as l_query then
					l_handshake.append ("GET " + l_uri.path + "?" + l_query + " HTTP/1.1")
					l_handshake.append (crlf)
				end
			end
			if attached l_uri.host as l_host then
				l_handshake.replace_substring_all ("$host", l_host)
				l_handshake.append ("Host: " + l_host + ":" + port.out)
				l_handshake.append (crlf)
			end
			l_handshake.append_string ("Upgrade: websocket")
			l_handshake.append (crlf)
			l_handshake.append_string ("Connection: Upgrade")
			l_handshake.append (crlf)
			l_handshake.append_string ("Sec-WebSocket-Key: ")
			create l_random.make (16)
			l_handshake.append_string (base64_encode_array (l_random.new_sequence))
			l_handshake.append (crlf)
			if attached protocols as l_protocols then
				create l_secure_protocol.make_empty
				across
					l_protocols as c
				loop
					l_secure_protocol.append (c.item)
					l_secure_protocol.append (" ,")
				end
				l_secure_protocol.remove_tail (1)
				l_handshake.append_string ("Sec-WebSocket-Protocol:" + l_secure_protocol)
				l_handshake.append (crlf)
			end
			l_handshake.append_string ("Sec-WebSocket-Version: 13")
			l_handshake.append (crlf)
			l_handshake.append (crlf)
			implementation.start_handshake (l_handshake)
		end

	receive_handshake
		do
			analyze_request_message
			if server_handshake.request_header.has_substring ("HTTP/1.1 101") and then attached server_handshake.request_header_map.item ("Upgrade") as l_upgrade_key and then -- Upgrade header must be present with value websocket
				l_upgrade_key.is_case_insensitive_equal ("websocket") and then attached server_handshake.request_header_map.item ("Connection") as l_connection_key and then -- Connection header must be present with value Upgrade
				l_connection_key.has_substring ("Upgrade")
			then
				is_server_hanshake_accepted := True
				if attached server_handshake.request_header_map.item ("Sec-WebSocet-Protocol") as l_protocol then
					set_protocol (l_protocol)
				end
			end
		end

	receive
		do
			implementation.receive
		end

	set_default_port
		do
			if is_secure then
				port := wss_port_default
			else
				port := ws_port_default
			end
		end

	client_handshake_required_template: STRING = "[
			GET $resource HTTP/1.1
			Host: $host
			Upgrade: websocket
			Connection: Upgrade
			Sec-WebSocket-Key: $key
			Sec-WebSocket-Version: 13
		]"

	base64_encode_array (a_sequence: ARRAY [NATURAL_8]): STRING_8
			-- Encode a byte array `a_sequence' into Base64 notation.
		local
			l_result: STRING
			l_base_64: BASE64
		do
			create l_result.make_empty
			across
				a_sequence as i
			loop
				l_result.append_character (i.item.to_character_8)
			end
			create l_base_64
			Result := l_base_64.encoded_string (l_result)
		end

	host: STRING
		local
			l_uri: URI
		do
			create Result.make_empty
			create l_uri.make_from_string (uri.as_string_8)
			if attached l_uri.host as l_host then
				Result := l_host
			end
		end

feature -- Parse Request line

	analyze_request_message
			-- Analyze message extracted from `socket' as HTTP request
		require
			input_readable: socket /= Void and then socket.is_open_read
		local
			end_of_stream: BOOLEAN
			pos, n: INTEGER
			line: detachable STRING
			k, val: STRING
			txt: STRING
		do
			create txt.make (64)
			server_handshake.set_request_header (txt)
			if attached next_line as l_request_line and then not l_request_line.is_empty then
				txt.append (l_request_line)
				txt.append_character ('%N')
			else
				server_handshake.mark_error
			end
				--			l_is_verbose := is_verbose
			if not server_handshake.has_error then -- or l_is_verbose then
					-- if `is_verbose' we can try to print the request, even if it is a bad HTTP request
				from
					line := next_line
				until
					line = Void or end_of_stream
				loop
					n := line.count
						--					if l_is_verbose then
						--						log (line)
						--					end
					pos := line.index_of (':', 1)
					if pos > 0 then
						k := line.substring (1, pos - 1)
						if line [pos + 1].is_space then
							pos := pos + 1
						end
						if line [n] = '%R' then
							n := n - 1
						end
						val := line.substring (pos + 1, n)
						server_handshake.put_header (k, val)
					end
					txt.append (line)
					txt.append_character ('%N')
					if line.is_empty or else line [1] = '%R' then
						end_of_stream := True
					else
						line := next_line
					end
				end
			end
		end

	next_line: detachable STRING
			-- Next line fetched from `socket' is available.
		require
			is_readable: socket.is_open_read
		do
			if socket.socket_ok then
				socket.read_line_thread_aware
				Result := socket.last_string
			end
		end

feature -- {WEB_SOCKET_CLIENT}

--	do_send (a_opcode: NATURAL_32; a_message: STRING)
--		local
--			l_chunks: INTEGER
--			i: INTEGER
--			l_index: INTEGER
--			l_chunk_size: INTEGER
--			l_key: STRING
--			l_message: STRING
--			l_frame : STRING
--		do
--			print ("%NMessage count:" + a_message.count.out)
--			create l_frame.make_empty
--			create l_message.make_empty
--			if  a_message.count > 65535 then
--					--!Improve. this code need to be checked.
--				print("%N Case:1")
--				l_frame.append_code ((0x80 | a_opcode).to_natural_32)
--				l_frame.append_code ((0x80 | 127).to_natural_32)

--				l_frame.append_code (0x0)
--				l_frame.append_code (0x0)
--				l_frame.append_code (0x0)
--				l_frame.append_code (0x0)
--				l_frame.append_code (((a_message.count) |>> 32).to_character_8.code.as_natural_32)
--				l_frame.append_code (((a_message.count) |>> 16).to_character_8.code.as_natural_32)
--				l_frame.append_code (((a_message.count ) |>> 8).to_character_8.code.as_natural_32)
--				l_frame.append_code ((a_message.count).to_character_8.code.as_natural_32)
--			elseif a_message.count > 125 then
--				print("%N Case:2")
--				print ("Message count:" + a_message.count.out)
--				l_frame.append_code ((0x80 | a_opcode).to_natural_32)
--				l_frame.append_code ((0x80 | 126).to_natural_32)
--				l_frame.append_code (((a_message.count ) |>> 8).as_natural_32)
--				l_frame.append_code ((a_message.count).to_character_8.code.as_natural_32)
--				print ("%NHeaderMessage:" + l_frame)
--			else
--				print("%N Case:3")
--				print ("Message count:" + a_message.count.out)
--				l_frame.append_code ((0x80 | a_opcode).to_natural_32)
--				l_frame.append_code ((0x80 | a_message.count).to_natural_32)
--			end
--			
--			l_key := new_key
--			l_frame.append (l_key.substring (1, 4))
--			l_message := implementation.unmmask (a_message, l_key.substring (1, 4))
--			l_frame.append (l_message)
--			socket.send_message (l_frame)
--		end

	do_send (a_opcode:INTEGER; a_message: READABLE_STRING_8)
		local
			i: INTEGER
			l_chunk_size: INTEGER
			l_chunk: READABLE_STRING_8
			l_header_message: STRING
			l_message_count: INTEGER
			n: NATURAL_64
			retried: BOOLEAN
			l_message : STRING
			l_key: STRING
		do
			if not retried then
				create l_header_message.make_empty
				l_header_message.append_code ((0x80 | a_opcode).to_natural_32)
				l_message_count := a_message.count
				n := l_message_count.to_natural_64
				if l_message_count > 0xffff then
						--! Improve. this code needs to be checked.
					l_header_message.append_code ((0x80 | 127).to_natural_32)
					l_header_message.append_character ((n |>> 56).to_character_8)
					l_header_message.append_character ((n |>> 48).to_character_8)
					l_header_message.append_character ((n |>> 40).to_character_8)
					l_header_message.append_character ((n |>> 32).to_character_8)
					l_header_message.append_character ((n |>> 24).to_character_8)
					l_header_message.append_character ((n |>> 16).to_character_8)
					l_header_message.append_character ((n |>> 8).to_character_8)
					l_header_message.append_character ( n.to_character_8)
				elseif l_message_count > 125 then
					l_header_message.append_code ((0x80 | 126).to_natural_32)
					l_header_message.append_code ((n |>> 8).as_natural_32)
					l_header_message.append_character (n.to_character_8)
				else
					l_header_message.append_code ((0x80 | n).as_natural_32)
				end

				l_key := new_key
				l_header_message.append (l_key.substring (1, 4))

				socket.put_string (l_header_message)

				l_message := implementation.unmmask (a_message, l_key.substring (1, 4))


				l_chunk_size := 16_384 -- 16K
				if l_message_count < l_chunk_size  then
					socket.put_string (l_message)
				else
					from
						i := 0
					until
						l_chunk_size = 0
					loop
						debug ("ws")
							print ("Sending chunk " + (i + 1).out + " -> " + (i + l_chunk_size).out +" / " + l_message_count.out + "%N")
						end
						l_chunk := l_message.substring (i + 1, l_message_count.min (i + l_chunk_size))
						socket.put_string (l_chunk)
						if l_chunk.count < l_chunk_size then
							l_chunk_size := 0
						end
						i := i + l_chunk_size
					end
					debug ("ws")
						print ("Sending chunk done%N")
					end
				end
			else
					-- FIXME: what should be done on rescue?
			end
		rescue
			retried := True
			io.put_string ("Internal error in " + generator + ".do_send (conn, a_opcode=" + a_opcode.out + ", a_message) !%N")
			retry
		end

	new_key: STRING
		local
			l_random: SALT_XOR_SHIFT_64_GENERATOR
		do
			create Result.make_empty
			create l_random.make (4)
			across
				l_random.new_sequence as i
			loop
				Result.append_integer (i.item)
			end
		end

	implementation: WEB_SOCKET_IMPL
			-- Web Socket implementation

	crlf: STRING = "%R%N"

end
