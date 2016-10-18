note
	description: "Summary description for {WEB_SOCKET_IMPL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_IMPL

inherit

	WEB_SOCKET

create
	make, make_with_port, make_with_protocols, make_with_protocols_and_port

feature {NONE} -- Initialization

	make (a_subscriber: WEB_SOCKET_SUBSCRIBER; a_uri: READABLE_STRING_GENERAL)
			-- Create a websocket instante with a default port.
		do
			reset
			subscriber := a_subscriber
			uri := a_uri
			create protocol.make_empty
			set_default_port
			create ready_state.make
		ensure
			uri_set: a_uri = uri
			port_wss: is_secure implies port = wss_port_default
			port_ws: not is_secure implies port = ws_port_default
			ready_state_set: ready_state.state = {WEB_SOCKET_READY_STATE}.connecting
			subscriber_set: subscriber = a_subscriber
			protocol_set: protocol.is_empty
		end

	make_with_port (a_subscriber: WEB_SOCKET_SUBSCRIBER; a_uri: READABLE_STRING_GENERAL; a_port: INTEGER)
			-- Create a websocket instance with port `a_port',
		do
			make (a_subscriber, a_uri)
			port := a_port
		ensure
			uri_set: a_uri = uri
			port_set: port = a_port
			ready_state_set: ready_state.state = {WEB_SOCKET_READY_STATE}.connecting
			subscriber_set: subscriber = a_subscriber
		end

	make_with_protocols (a_subscriber: WEB_SOCKET_SUBSCRIBER; a_uri: READABLE_STRING_GENERAL; a_protocols: detachable LIST [STRING])
			-- Create a web socket instance with a list of protocols `a_protocols' and default port.
		do
			reset
			subscriber := a_subscriber
			uri := a_uri
			create protocol.make_empty
			protocols := a_protocols
			set_default_port
			create ready_state.make
		ensure
			uri_set: a_uri = uri
			port_wss: is_secure implies port = wss_port_default
			port_ws: not is_secure implies port = ws_port_default
			protocols_set: protocols = a_protocols
			ready_state_set: ready_state.state = {WEB_SOCKET_READY_STATE}.connecting
			subscriber_set: subscriber = a_subscriber
			protocol_set: protocol.is_empty
		end

	make_with_protocols_and_port (a_subscriber: WEB_SOCKET_SUBSCRIBER; a_uri: READABLE_STRING_GENERAL; a_protocols: detachable LIST [STRING]; a_port: INTEGER)
			-- Create a web socket instance with a list of protocols `a_protocols' and port `a_port'.
		do
			make_with_protocols (a_subscriber, a_uri, a_protocols)
			port := a_port
		ensure
			uri_set: a_uri = uri
			protocols_set: protocols = a_protocols
			port_set: port = a_port
			ready_state_set: ready_state.state = {WEB_SOCKET_READY_STATE}.connecting
			subscriber_set: subscriber = a_subscriber
		end

	reset
		do
			has_error := False
		end

feature -- Access

	has_error: BOOLEAN

	is_verbose: BOOLEAN

feature -- Handshake

	start_handshake (a_handshake: STRING)
		do
			subscriber.on_websocket_handshake (a_handshake)
		end

feature -- Receive

	receive
		local
			l_frame: detachable WEB_SOCKET_FRAME
			l_client_message: detachable READABLE_STRING_8
		do
			l_frame := next_frame (subscriber.connection)
			if l_frame /= Void and then l_frame.is_valid then
				if attached l_frame.injected_control_frames as l_injections then
						-- Process injected control frames now.
						-- FIXME
					across
						l_injections as ic
					loop
						if ic.item.is_connection_close then
								-- FIXME: we should probably send this event .. after the `l_frame.parent' frame event.
							subscriber.on_websocket_close ("Normal Close")
						elseif ic.item.is_ping then
								-- FIXME reply only to the most recent ping ...
							subscriber.on_websocket_ping (ic.item.payload_data)
						elseif ic.item.is_pong then
							subscriber.on_websocket_pong (ic.item.payload_data)
						else
							subscriber.on_websocket_error ("Wrong Opcode")
						end
					end
				end
				l_client_message := l_frame.payload_data
				if l_client_message = Void then
					l_client_message := ""
				end
				debug ("ws")
					print ("%NExecute: %N")
					print (" [opcode: " + opcode_name (l_frame.opcode) + "]%N")
					if l_frame.is_text then
						print (" [client message: %"" + l_client_message + "%"]%N")
					elseif l_frame.is_binary then
						print (" [client binary message length: %"" + l_client_message.count.out + "%"]%N")
					end
					print (" [is_control: " + l_frame.is_control.out + "]%N")
					print (" [is_binary: " + l_frame.is_binary.out + "]%N")
					print (" [is_text: " + l_frame.is_text.out + "]%N")
				end
				if l_frame.is_connection_close then
					subscriber.on_websocket_close ("Normal Close")
				elseif l_frame.is_binary then
					subscriber.on_websocket_binary_message (l_client_message)
				elseif l_frame.is_text then
					subscriber.on_websocket_text_message (l_client_message)
				elseif l_frame.is_ping then
					subscriber.on_websocket_ping (l_client_message)
				elseif l_frame.is_pong then
					subscriber.on_websocket_pong (l_client_message)
				else
					subscriber.on_websocket_error ("Wrong Opcode")
				end
			else
				debug ("ws")
					print ("%NExecute: %N")
					print (" [ERROR: invalid frame]%N")
					if l_frame /= Void and then attached l_frame.error as err then
						print (" [Code: " + err.code.out + "]%N")
						print (" [Description: " + err.description + "]%N")
					end
				end
				subscriber.on_websocket_close ("")
			end

				--				if l_utf.is_valid_utf_8_string_8 (l_message) then
				--					if is_data_frame_ok then
				--						if opcode = text_frame then
				--							subscriber.on_websocket_text_message (l_message)
				--						elseif opcode = binary_frame then
				--							subscriber.on_websocket_binary_message (l_message)
				--						elseif opcode = ping_frame then
				--							subscriber.on_websocket_ping (l_message)
				--						elseif opcode = pong_frame then
				--							subscriber.on_websocket_pong (l_message)
				--						elseif opcode = Connection_close_frame then
				--							subscriber.on_websocket_close ("Normal Close")
				--						elseif opcode = ping_frame then
				--							subscriber.on_websocket_ping (l_message)
				--						elseif opcode = pong_frame then
				--							subscriber.on_websocket_pong (l_message)
				--						else
				--							subscriber.on_websocket_error ("Wrong Opcode")
				--						end
				--					else
				--						subscriber.on_websocket_close ("Invalid data frame")
				--					end
				--				else
				--					subscriber.on_websocket_error ("Invalid UTF-8")
				--				end

		end

feature -- Methods

	send (a_message: STRING)
		do
		end

	close (a_id: INTEGER)
			-- Close a websocket connection with a close id : `a_id'
		do
		end

	close_with_description (a_id: INTEGER; a_description: READABLE_STRING_GENERAL)
			-- Close a websocket connection with a close id : `a_id' and a description `a_description'
		do
		end

feature {NONE} -- Implementation

	set_default_port
		do
			if is_secure then
				port := wss_port_default
			else
				port := ws_port_default
			end
		end

	subscriber: WEB_SOCKET_SUBSCRIBER

	next_frame (a_socket: HTTP_STREAM_SOCKET): detachable WEB_SOCKET_FRAME
			-- TODO Binary messages
			-- Handle error responses in a better way.
			-- IDEA:
			-- class FRAME
			-- 		is_fin: BOOLEAN
			--		opcode: WEB_SOCKET_STATUS_CODE (TEXT, BINARY, CLOSE, CONTINUE,PING, PONG)
			--		data/payload
			--      status_code: #see Status Codes http://tools.ietf.org/html/rfc6455#section-7.3
			--		has_error
			--
			--	See Base Framing Protocol: http://tools.ietf.org/html/rfc6455#section-5.2
			--      0                   1                   2                   3
			--      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
			--     +-+-+-+-+-------+-+-------------+-------------------------------+
			--     |F|R|R|R| opcode|M| Payload len |    Extended payload length    |
			--     |I|S|S|S|  (4)  |A|     (7)     |             (16/64)           |
			--     |N|V|V|V|       |S|             |   (if payload len==126/127)   |
			--     | |1|2|3|       |K|             |                               |
			--     +-+-+-+-+-------+-+-------------+ - - - - - - - - - - - - - - - +
			--     |     Extended payload length continued, if payload len == 127  |
			--     + - - - - - - - - - - - - - - - +-------------------------------+
			--     |                               |Masking-key, if MASK set to 1  |
			--     +-------------------------------+-------------------------------+
			--     | Masking-key (continued)       |          Payload Data         |
			--     +-------------------------------- - - - - - - - - - - - - - - - +
			--     :                     Payload Data continued ...                :
			--     + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
			--     |                     Payload Data continued ...                |
			--     +---------------------------------------------------------------+
		note
			EIS: "name=WebSocket RFC", "protocol=URI", "src=http://tools.ietf.org/html/rfc6455#section-5.2"
		require
			a_socket_in_blocking_mode: a_socket.is_blocking
		local
			l_opcode: INTEGER
			l_len: INTEGER
			l_remaining_len: INTEGER
			l_payload_len: NATURAL_64
			l_chunk: STRING
			l_rsv: BOOLEAN
			l_fin: BOOLEAN
			l_has_mask: BOOLEAN
			l_chunk_size: INTEGER
			l_byte: INTEGER
			l_fetch_count: INTEGER
			l_bytes_read: INTEGER
			s: STRING
			is_data_frame_ok: BOOLEAN -- Is the last process data framing ok?
			retried: BOOLEAN
		do
			if not retried then
				debug ("ws")
					print ("next_frame:%N")
				end
				from
					is_data_frame_ok := True
				until
					l_fin or not is_data_frame_ok
				loop
						-- multi-frames or continue is only valid for Binary or Text
					s := next_bytes (a_socket, 1)
					if s.is_empty then
						is_data_frame_ok := False
						debug ("ws")
							print ("[ERROR] incomplete_data!%N")
						end
					else
						l_byte := s [1].code
						debug ("ws")
							print ("   fin,rsv(3),opcode(4)=")
							print (to_byte_representation (l_byte))
							print ("%N")
						end
						l_fin := l_byte & (0b10000000) /= 0
						l_rsv := l_byte & (0b01110000) = 0
						l_opcode := l_byte & 0b00001111
						if Result /= Void then
							if l_opcode = Result.opcode then
									-- should not occur in multi-fragment frame!
								create Result.make (l_opcode, l_fin)
								Result.report_error (protocol_error, "Unexpected injected frame")
							elseif l_opcode = continuation_frame then
									-- Expected
								Result.update_fin (l_fin)
							elseif is_control_frame (l_opcode) then
									-- Control frames (see Section 5.5) MAY be injected in the middle of
									-- a fragmented message.  Control frames themselves MUST NOT be fragmented.
									-- if the l_opcode is a control frame then there is an error!!!
									-- CLOSE, PING, PONG
								create Result.make_as_injected_control (l_opcode, Result)
							else
									-- should not occur in multi-fragment frame!
								create Result.make (l_opcode, l_fin)
								Result.report_error (protocol_error, "Unexpected frame")
							end
						else
							create Result.make (l_opcode, l_fin)
							if Result.is_continuation then
									-- Continuation frame is not expected without parent frame!
								Result.report_error (protocol_error, "There is no message to continue!")
							end
						end
						if Result.is_valid then
								--| valid frame/fragment
							if is_verbose then
								log ("+ frame " + opcode_name (l_opcode) + " (fin=" + l_fin.out + ")")
							end

								-- rsv validation
							if not l_rsv then
									-- RSV1, RSV2, RSV3:  1 bit each

									-- MUST be 0 unless an extension is negotiated that defines meanings
									-- for non-zero values.  If a nonzero value is received and none of
									-- the negotiated extensions defines the meaning of such a nonzero
									-- value, the receiving endpoint MUST _Fail the WebSocket
									-- Connection_

									-- FIXME: add support for extension ?
								Result.report_error (protocol_error, "RSV values MUST be 0 unless an extension is negotiated that defines meanings for non-zero values")
							end
						else
							if is_verbose then
								log ("+ INVALID frame " + opcode_name (l_opcode) + " (fin=" + l_fin.out + ")")
							end
						end

							-- At the moment only TEXT, (pending Binary)
						if Result.is_valid then
							if Result.is_text or Result.is_binary or Result.is_control then
									-- Reading next byte (mask+payload_len)
								s := next_bytes (a_socket, 1)
								if s.is_empty then
									Result.report_error (invalid_data, "Incomplete data for mask and payload len")
								else
									l_byte := s [1].code
									debug ("ws")
										print ("   mask,payload_len(7)=")
										print (to_byte_representation (l_byte))
										io.put_new_line
									end
									l_has_mask := l_byte & (0b10000000) /= 0 -- MASK
									l_len := l_byte & 0b01111111 -- 7bits

									debug ("ws")
										print ("   payload_len=" + l_len.out)
										io.put_new_line
									end
									if Result.is_control and then l_len > 125 then
											-- All control frames MUST have a payload length of 125 bytes or less
											-- and MUST NOT be fragmented.
										Result.report_error (protocol_error, "Control frame MUST have a payload length of 125 bytes or less")
									elseif l_len = 127 then -- TODO proof of concept read 8 bytes.
											-- the following 8 bytes interpreted as a 64-bit unsigned integer
											-- (the most significant bit MUST be 0) are the payload length.
											-- Multibyte length quantities are expressed in network byte order.
										s := next_bytes (a_socket, 8) -- 64 bits
										debug ("ws")
											print ("   extended payload length=" + string_to_byte_representation (s))
											io.put_new_line
										end
										if s.count < 8 then
											Result.report_error (Invalid_data, "Incomplete data for 64 bit Extended payload length")
										else
											l_payload_len := s [8].natural_32_code.to_natural_64
											l_payload_len := l_payload_len | (s [7].natural_32_code.to_natural_64 |<< 8)
											l_payload_len := l_payload_len | (s [6].natural_32_code.to_natural_64 |<< 16)
											l_payload_len := l_payload_len | (s [5].natural_32_code.to_natural_64 |<< 24)
											l_payload_len := l_payload_len | (s [4].natural_32_code.to_natural_64 |<< 32)
											l_payload_len := l_payload_len | (s [3].natural_32_code.to_natural_64 |<< 40)
											l_payload_len := l_payload_len | (s [2].natural_32_code.to_natural_64 |<< 48)
											l_payload_len := l_payload_len | (s [1].natural_32_code.to_natural_64 |<< 56)
										end
									elseif l_len = 126 then
										s := next_bytes (a_socket, 2) -- 16 bits
										debug ("ws")
											print ("   extended payload length bits=" + string_to_byte_representation (s))
											io.put_new_line
										end
										if s.count < 2 then
											Result.report_error (Invalid_data, "Incomplete data for 16 bit Extended payload length")
										else
											l_payload_len := s [2].natural_32_code.to_natural_64
											l_payload_len := l_payload_len | (s [1].natural_32_code.to_natural_64 |<< 8)
										end
									else
										l_payload_len := l_len.to_natural_64
									end
									debug ("ws")
										print ("   Full payload length=" + l_payload_len.out)
										io.put_new_line
									end
									if Result.is_valid then
										if l_has_mask then
											Result.report_error (protocol_error, "Server sent a masked frame!")
										else
										end
										if Result.is_valid then
											l_chunk_size := 0x4000 -- 16 K
											if l_payload_len > {INTEGER_32}.max_value.to_natural_64 then
													-- Issue .. to big to store in STRING
													-- FIXME !!!
												Result.report_error (Message_too_large, "Can not handle payload data (len=" + l_payload_len.out + ")")
											else
												l_len := l_payload_len.to_integer_32
											end
											from
												l_fetch_count := 0
												l_remaining_len := l_len
											until
												l_fetch_count >= l_len or l_len = 0 or not Result.is_valid
											loop
												if l_remaining_len < l_chunk_size then
													l_chunk_size := l_remaining_len
												end
												a_socket.read_stream (l_chunk_size)
												l_bytes_read := a_socket.bytes_read
												debug ("ws")
													print ("read chunk size=" + l_chunk_size.out + " fetch_count=" + l_fetch_count.out + " l_len=" + l_len.out + " -> " + l_bytes_read.out + "bytes%N")
												end
												if a_socket.bytes_read > 0 then
													l_remaining_len := l_remaining_len - l_bytes_read
													l_chunk := a_socket.last_string
													l_fetch_count := l_fetch_count + l_bytes_read
													Result.append_payload_data_chop (l_chunk, l_bytes_read, l_remaining_len = 0)
												else
													Result.report_error (internal_error, "Issue reading payload data...")
												end
											end
											if is_verbose then
												log ("  Received " + l_fetch_count.out + " out of " + l_len.out + " bytes <===============")
											end
											debug ("ws")
												print (" -> ")
												if attached Result.payload_data as l_payload_data then
													s := l_payload_data.tail (l_fetch_count)
													if s.count > 50 then
														print (string_to_byte_hexa_representation (s.head (50) + ".."))
													else
														print (string_to_byte_hexa_representation (s))
													end
													print ("%N")
													if Result.is_text and Result.is_fin and Result.fragment_count = 0 then
														print (" -> ")
														if s.count > 50 then
															print (s.head (50) + "..")
														else
															print (s)
														end
														print ("%N")
													end
												end
											end
										end
									end
								end
							end
						end
					end
					if Result /= Void then
						if attached Result.error as err then
							if is_verbose then
								log ("  !Invalid frame: " + err.string)
							end
						end
						if Result.is_injected_control then
							if attached Result.parent as l_parent then
								if not Result.is_valid then
									l_parent.report_error (protocol_error, "Invalid injected frame")
								end
								if Result.is_connection_close then
										-- Return this and process the connection close right away!
									l_parent.update_fin (True)
									l_fin := Result.is_fin
								else
									Result := l_parent
									l_fin := l_parent.is_fin
									check
											-- This is a control frame but occurs in fragmented frame.
										inside_fragmented_frame: not l_fin
									end
								end
							else
								check
									has_parent: False
								end
								l_fin := False -- This is a control frame but occurs in fragmented frame.
							end
						end
						if not Result.is_valid then
							is_data_frame_ok := False
						end
					else
						is_data_frame_ok := False
					end
				end
			end
		rescue
			retried := True
			if Result /= Void then
				Result.report_error (internal_error, "Internal error")
			end
			retry
		end

	next_bytes (a_socket: HTTP_STREAM_SOCKET; nb: INTEGER): STRING
		require
			nb > 0
		local
			n, l_bytes_read: INTEGER
		do
			create Result.make (nb)
			from
				n := nb
			until
				n = 0
			loop
				a_socket.read_stream (nb)
				l_bytes_read := a_socket.bytes_read
				if l_bytes_read > 0 then
					Result.append (a_socket.last_string)
					n := n - l_bytes_read
				else
					n := 0
				end
			end
		end

	unmask (a_chunk: STRING_8; a_pos: INTEGER; a_key: READABLE_STRING_8)
		local
			i, n: INTEGER
		do
			from
				i := 1
				n := a_chunk.count
			until
				i > n
			loop
				a_chunk.put_code (a_chunk.code (i).bit_xor (a_key [((i + (a_pos - 1) - 1) \\ 4) + 1].natural_32_code), i)
				i := i + 1
			end
		end

	append_chunk_unmasked (a_chunk: READABLE_STRING_8; a_pos: INTEGER; a_key: READABLE_STRING_8; a_target: STRING)
			--	 To convert masked data into unmasked data, or vice versa, the following
			--   algorithm is applied.  The same algorithm applies regardless of the
			--   direction of the translation, e.g., the same steps are applied to
			--   mask the data as to unmask the data.

			--   Octet i of the transformed data ("transformed-octet-i") is the XOR of
			--   octet i of the original data ("original-octet-i") with octet at index
			--   i modulo 4 of the masking key ("masking-key-octet-j"):

			--     j                   = i MOD 4
			--     transformed-octet-i = original-octet-i XOR masking-key-octet-j

			--   The payload length, indicated in the framing as frame-payload-length,
			--   does NOT include the length of the masking key.  It is the length of
			--   the "Payload data", e.g., the number of bytes following the masking
			--   key.
		note
			EIS: "name=Masking", "src=http://tools.ietf.org/html/rfc6455#section-5.3", "protocol=uri"
		local
			i, n: INTEGER
		do
				--			debug ("ws")
				--				print ("append_chunk_unmasked (%"" + string_to_byte_representation (a_chunk) + "%",%N%Ta_pos=" + a_pos.out+ ", a_key, a_target #.count=" + a_target.count.out + ")%N")
				--			end
			from
				i := 1
				n := a_chunk.count
			until
				i > n
			loop
				a_target.append_code (a_chunk.code (i).bit_xor (a_key [((i + (a_pos - 1) - 1) \\ 4) + 1].natural_32_code))
				i := i + 1
			end
		end

feature {NONE} -- Debug

	log (m: STRING)
		do
			io.put_string (m + "%N")
		end

	to_byte (a_integer: INTEGER): ARRAY [INTEGER]
		require
			valid: a_integer >= 0 and then a_integer <= 255
		local
			l_val: INTEGER
			l_index: INTEGER
		do
			create Result.make_filled (0, 1, 8)
			from
				l_val := a_integer
				l_index := 8
			until
				l_val < 2
			loop
				Result.put (l_val \\ 2, l_index)
				l_val := l_val // 2
				l_index := l_index - 1
			end
			Result.put (l_val, l_index)
		end

feature -- Masking

	unmmask (a_frame: READABLE_STRING_8; a_key: READABLE_STRING_8): STRING
			--	 To convert masked data into unmasked data, or vice versa, the following
			--   algorithm is applied.  The same algorithm applies regardless of the
			--   direction of the translation, e.g., the same steps are applied to
			--   mask the data as to unmask the data.

			--   Octet i of the transformed data ("transformed-octet-i") is the XOR of
			--   octet i of the original data ("original-octet-i") with octet at index
			--   i modulo 4 of the masking key ("masking-key-octet-j"):

			--     j                   = i MOD 4
			--     transformed-octet-i = original-octet-i XOR masking-key-octet-j

			--   The payload length, indicated in the framing as frame-payload-length,
			--   does NOT include the length of the masking key.  It is the length of
			--   the "Payload data", e.g., the number of bytes following the masking
			--   key.
		note
			EIS: "name=Masking", "src=S", "protocol=uri"
		local
			l_frame: STRING
			i: INTEGER
		do
			l_frame := a_frame.twin
			from
				i := 1
			until
				i > l_frame.count
			loop
				l_frame [i] := (l_frame [i].code.to_integer_8.bit_xor (a_key [((i - 1) \\ 4) + 1].code.to_integer_8)).to_character_8
				i := i + 1
			end
			Result := l_frame
		end

	to_byte_representation (a_integer: INTEGER): STRING
		require
			valid: a_integer >= 0 and then a_integer <= 255
		local
			l_val: INTEGER
		do
			create Result.make (8)
			from
				l_val := a_integer
			until
				l_val < 2
			loop
				Result.prepend_integer (l_val \\ 2)
				l_val := l_val // 2
			end
			Result.prepend_integer (l_val)
		end

	string_to_byte_representation (s: STRING): STRING
		require
			valid: s.count > 0
		local
			i, n: INTEGER
		do
			n := s.count
			create Result.make (8 * n)
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					if not Result.is_empty then
						Result.append_character (':')
					end
					Result.append (to_byte_representation (s [i].code))
					i := i + 1
				end
			end
		end

	string_to_byte_hexa_representation (s: STRING): STRING
		local
			i, n: INTEGER
			c: INTEGER
		do
			n := s.count
			create Result.make (8 * n)
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					if not Result.is_empty then
						Result.append_character (':')
					end
					c := s [i].code
					check
						c <= 0xFF
					end
					Result.append_character (((c |>> 4) & 0xF).to_hex_character)
					Result.append_character (((c) & 0xF).to_hex_character)
					i := i + 1
				end
			end
		end

end
