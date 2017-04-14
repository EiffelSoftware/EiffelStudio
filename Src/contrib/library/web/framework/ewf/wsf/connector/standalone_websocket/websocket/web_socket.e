note
	description: "[
			Object representing the websocket connection.
			It contains the `request` and `response`, and more important the `socket` itself.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET

inherit
	WGI_STANDALONE_CONNECTOR_EXPORTER

	WSF_RESPONSE_EXPORTER

	WGI_EXPORTER

	HTTPD_LOGGER_CONSTANTS

	WEB_SOCKET_CONSTANTS

	SHARED_BASE64

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			request := req
			response := res
			is_verbose := False
			verbose_level := notice_level

			if
				attached {WGI_STANDALONE_INPUT_STREAM} req.input as r_input
			then
				socket := r_input.source
			else
				create socket.make_empty
				check has_socket: False end
			end
		end

feature -- Access		

	socket: HTTPD_STREAM_SOCKET
			-- Underlying connected socket.

feature {NONE} -- Access		

	request: WSF_REQUEST
			-- Associated request.

	response: WSF_RESPONSE
			-- Associated response stream.

feature -- Access

	is_websocket: BOOLEAN
			-- Does `open_ws_handshake' detect valid websocket upgrade handshake?

feature -- Settings

	is_verbose: BOOLEAN
			-- Output verbose log messages?

	verbose_level: INTEGER
			-- Level of verbosity.

feature -- Status

	has_error: BOOLEAN
			-- Error occured during processing?

feature -- Socket status

	is_ready_for_reading: BOOLEAN
			-- Is `socket' ready for reading?
			--| at this point, socket should be set to blocking.
		do
			Result := socket.ready_for_reading
		end

	is_open_read: BOOLEAN
			-- Is `socket' open for reading?
		do
			Result := socket.is_open_read
		end

	is_open_write: BOOLEAN
			-- Is `socket' open for writing?
		do
			Result := socket.is_open_write
		end

	socket_descriptor: INTEGER
			-- Descriptor for current `socket'.
		do
			Result := socket.descriptor
		end

feature -- Element change

	set_is_verbose (b: BOOLEAN)
		do
			is_verbose := b
		end

	set_verbose_level (lev: INTEGER)
		do
			verbose_level := lev
		end

feature -- Basic operation

	put_error (a_message: READABLE_STRING_8)
		do
			response.put_error (a_message)
		end

	log (m: READABLE_STRING_8; lev: INTEGER)
			-- Log `m' in the error channel, i.e stderr for standalone.
		do
			if is_verbose then
				put_error (m)
			end
		end

feature -- Basic Operation	

	open_ws_handshake
			-- The opening handshake is intended to be compatible with HTTP-based
			-- server-side software and intermediaries, so that a single port can be
			-- used by both HTTP clients alking to that server and WebSocket
			-- clients talking to that server.  To this end, the WebSocket client's
			-- handshake is an HTTP Upgrade request:

			--    GET /chat HTTP/1.1
			--    Host: server.example.com
			--    Upgrade: websocket
			--    Connection: Upgrade
			--    Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
			--    Origin: http://example.com
			--    Sec-WebSocket-Protocol: chat, superchat
			--    Sec-WebSocket-Version: 13
		local
			l_sha1: SHA1
			l_key : STRING
			req: like request
			res: like response
		do
				-- Reset values.
			is_websocket := False
			has_error := False

				-- Local cache.
			req := request
			res := response

				-- Reading client's opening GT

				-- TODO extract to a validator handshake or something like that.
			if is_verbose then
				log ("%NReceive <====================", debug_level)
				if attached req.raw_header_data as rhd then
					check raw_header_is_valid_as_string_8: rhd.is_valid_as_string_8 end
					log (rhd.to_string_8, debug_level)
				end
			end
			if
				req.is_get_request_method and then -- MUST be GET request!
				attached req.meta_string_variable ("HTTP_UPGRADE") as l_upgrade_key and then
				l_upgrade_key.is_case_insensitive_equal_general ("websocket") -- Upgrade header must be present with value websocket
			then
				is_websocket := True
				socket.set_blocking
				if
					attached req.meta_string_variable ("HTTP_SEC_WEBSOCKET_KEY") as l_ws_key and then -- Sec-websocket-key must be present
					attached req.meta_string_variable ("HTTP_CONNECTION") as l_connection_key and then -- Connection header must be present with value Upgrade
					l_connection_key.has_substring ("Upgrade") and then
					attached req.meta_string_variable ("HTTP_SEC_WEBSOCKET_VERSION") as l_version_key and then -- Version header must be present with value 13
					l_version_key.is_case_insensitive_equal ("13") and then
					attached req.http_host -- Host header must be present
				then
					if is_verbose then
						log ("key " + l_ws_key, debug_level)
					end
						-- Sending the server's opening handshake
					create l_sha1.make
					check l_ws_key_is_valid_as_string_8: l_ws_key.is_valid_as_string_8 end
					l_sha1.update_from_string (l_ws_key.to_string_8 + magic_guid)
					l_key := Base64_encoder.encoded_string (digest (l_sha1))
					res.header.add_header_key_value ("Upgrade", "websocket")
					res.header.add_header_key_value ("Connection", "Upgrade")
					res.header.add_header_key_value ("Sec-WebSocket-Accept", l_key)

					if is_verbose then
						log ("%N================> Send Handshake", debug_level)
						if attached {HTTP_HEADER} res.header as h then
							log (h.string, debug_level)
						end
					end
					res.set_status_code_with_reason_phrase (101, "Switching Protocols")
					res.wgi_response.push
				else
					has_error := True
					if is_verbose then
						log ("Error (opening_handshake)!!!", debug_level)
					end
						-- If we cannot complete the handshake, then the server MUST stop processing the client's handshake and return an HTTP response with an
						-- appropriate error code (such as 400 Bad Request).
					res.set_status_code_with_reason_phrase (400, "Bad Request")
				end
			else
				is_websocket := False
			end
		end

feature -- Response!

	send (a_opcode:INTEGER; a_message: READABLE_STRING_8)
		local
			i: INTEGER
			l_chunk_size: INTEGER
			l_chunk: READABLE_STRING_8
			l_header_message: STRING
			l_message_count: INTEGER
			n: NATURAL_64
			retried: BOOLEAN
		do
			debug ("ws")
				print (">>do_send (..., "+ opcode_name (a_opcode) +", ..)%N")
			end
			if not retried then
				create l_header_message.make_empty
				l_header_message.append_code ((0x80 | a_opcode).to_natural_32)
				l_message_count := a_message.count
				n := l_message_count.to_natural_64
				if l_message_count > 0xffff then
						--! Improve. this code needs to be checked.
					l_header_message.append_code ((0 | 127).to_natural_32)
					l_header_message.append_character ((n |>> 56).to_character_8)
					l_header_message.append_character ((n |>> 48).to_character_8)
					l_header_message.append_character ((n |>> 40).to_character_8)
					l_header_message.append_character ((n |>> 32).to_character_8)
					l_header_message.append_character ((n |>> 24).to_character_8)
					l_header_message.append_character ((n |>> 16).to_character_8)
					l_header_message.append_character ((n |>> 8).to_character_8)
					l_header_message.append_character ( n.to_character_8)
				elseif l_message_count > 125 then
					l_header_message.append_code ((0 | 126).to_natural_32)
					l_header_message.append_code ((n |>> 8).as_natural_32)
					l_header_message.append_character (n.to_character_8)
				else
					l_header_message.append_code (n.as_natural_32)
				end
				socket.put_string_8_noexception (l_header_message)
				if not socket.was_error then
					l_chunk_size := 16_384 -- 16K TODO: see if we should make it customizable.
					if l_message_count < l_chunk_size then
						socket.put_string_8_noexception (a_message)
					else
						from
							i := 0
						until
							l_chunk_size = 0 or socket.was_error
						loop
							debug ("ws")
								print ("Sending chunk " + (i + 1).out + " -> " + (i + l_chunk_size).out +" / " + l_message_count.out + "%N")
							end
							l_chunk := a_message.substring (i + 1, l_message_count.min (i + l_chunk_size))
							socket.put_string_8_noexception (l_chunk)
							if l_chunk.count < l_chunk_size then
								l_chunk_size := 0
							end
							i := i + l_chunk_size
						end
						debug ("ws")
							print ("Sending chunk done%N")
						end
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

	next_frame: detachable WEB_SOCKET_FRAME
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
			socket_in_blocking_mode: socket.is_blocking
		local
			l_socket: like socket
			l_opcode: INTEGER
			l_len: INTEGER
			l_remaining_len: INTEGER
			l_payload_len: NATURAL_64
			l_masking_key: detachable READABLE_STRING_8
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
				l_socket := socket
				debug ("ws")
					print ("next_frame:%N")
				end
				from
					is_data_frame_ok := True
				until
					l_fin or not is_data_frame_ok
				loop
						-- multi-frames or continue is only valid for Binary or Text
					s := next_bytes (l_socket, 1)
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
								log ("+ frame " + opcode_name (l_opcode) + " (fin=" + l_fin.out + ")", debug_level)
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
								log ("+ INVALID frame " + opcode_name (l_opcode) + " (fin=" + l_fin.out + ")", debug_level)
							end
						end

							-- At the moment only TEXT, (pending Binary)
						if Result.is_valid then
							if Result.is_text or Result.is_binary or Result.is_control then
									-- Reading next byte (mask+payload_len)
								s := next_bytes (l_socket, 1)
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
										s := next_bytes (l_socket, 8) -- 64 bits
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
										s := next_bytes (l_socket, 2) -- 16 bits
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
											l_masking_key := next_bytes (l_socket, 4) -- 32 bits
											debug ("ws")
												print ("   Masking key bits=" + string_to_byte_representation (l_masking_key))
												io.put_new_line
											end
											if l_masking_key.count < 4 then
												debug ("ws")
													print ("masking-key read stream -> " + l_socket.bytes_read.out + " bits%N")
												end
												Result.report_error (Invalid_data, "Incomplete data for Masking-key")
												l_masking_key := Void
											end
										else
											Result.report_error (protocol_error, "All frames sent from client to server are masked!")
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
												l_socket.read_stream (l_chunk_size)
												l_bytes_read := l_socket.bytes_read
												debug ("ws")
													print ("read chunk size=" + l_chunk_size.out + " fetch_count=" + l_fetch_count.out + " l_len=" + l_len.out + " -> " + l_bytes_read.out + "bytes%N")
												end
												if l_bytes_read > 0 then
													l_remaining_len := l_remaining_len - l_bytes_read
													l_chunk := l_socket.last_string
													if l_masking_key /= Void then
															--  Masking
															--  http://tools.ietf.org/html/rfc6455#section-5.3
														unmask (l_chunk, l_fetch_count + 1, l_masking_key)
													else
														check
															client_frame_should_always_be_encoded: False
														end
													end
													l_fetch_count := l_fetch_count + l_bytes_read
													Result.append_payload_data_chop (l_chunk, l_bytes_read, l_remaining_len = 0)
												else
													Result.report_error (internal_error, "Issue reading payload data...")
												end
											end
											if is_verbose then
												log ("  Received " + l_fetch_count.out + " out of " + l_len.out + " bytes <===============", debug_level)
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
								log ("  !Invalid frame: " + err.string, debug_level)
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
			has_error := Result = Void or else Result.has_error
		rescue
			retried := True
			if Result /= Void then
				Result.report_error (internal_error, "Internal error")
			end
			retry
		end


feature -- Encoding

	digest (a_sha1: SHA1): STRING
			-- Digest of `a_sha1'.
			-- Should by in SHA1 class
		local
			l_digest: SPECIAL [NATURAL_8]
			index, l_upper: INTEGER
		do
			l_digest := a_sha1.digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.Lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.append_character (l_digest [index].to_character_8)
				index := index + 1
			end
		end

feature {NONE} -- Socket helpers		

	next_bytes (a_socket: HTTPD_STREAM_SOCKET; nb: INTEGER): STRING
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

feature -- Masking Data Client - Server

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


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
