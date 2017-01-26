note
	description: "[
				Specific implementation of HTTP_CLIENT_REQUEST based on Eiffel NET library
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NET_HTTP_CLIENT_REQUEST

inherit
	HTTP_CLIENT_REQUEST
		redefine
			session
		end

	TRANSFER_COMMAND_CONSTANTS

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Internal	

	session: NET_HTTP_CLIENT_SESSION
	net_http_client_version: STRING = "0.1"

	session_socket (a_host: READABLE_STRING_8; a_port: INTEGER; a_is_https: BOOLEAN; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_STREAM_SOCKET
			-- Session socket to use for connection.
			-- Eventually reuse the persistent connection if any.
		local
			l_socket: detachable HTTP_STREAM_SOCKET
		do
			if
				attached session.persistent_connection as l_persistent_connection and then
				l_persistent_connection.is_reusable (a_host, a_port)
			then
				l_socket := l_persistent_connection.socket
				if a_is_https then
					if attached {HTTP_STREAM_SECURE_SOCKET} l_socket as l_ssl_socket then
						Result := l_ssl_socket
					else
						l_socket := Void
					end
				elseif attached {HTTP_STREAM_SECURE_SOCKET} l_socket as l_ssl_socket then
					l_socket := Void
				end
				if l_socket /= Void and then not l_socket.is_connected then
						-- Reset persistent connection
					l_socket := Void
				end
			end
			if l_socket /= Void then
					-- Reuse persistent connection.
				Result := l_socket
			else
				session.set_persistent_connection (Void)
				if a_is_https then
					create {HTTP_STREAM_SECURE_SOCKET} Result.make_client_by_port (a_port, a_host)
				else
					create Result.make_client_by_port (a_port, a_host)
				end
				Result.set_connect_timeout (connect_timeout)
				Result.set_timeout (timeout)
				Result.connect
			end
		end

feature -- Access

	response: HTTP_CLIENT_RESPONSE
			-- <Precursor>
		local
			redirection_response: detachable like response
			l_uri: URI
			l_header_key: READABLE_STRING_8
			l_host: READABLE_STRING_8
			l_cookie: detachable READABLE_STRING_8
			l_request_uri: STRING
			l_url: HTTP_URL
			l_socket: HTTP_STREAM_SOCKET
			s: STRING
			l_message: STRING
			l_content_length: INTEGER
			l_location: detachable READABLE_STRING_8
			l_port: INTEGER
			l_is_https: BOOLEAN
			l_authorization: HTTP_AUTHORIZATION
			l_platform: STRING
			l_upload_data: detachable READABLE_STRING_8
			l_form_data: detachable HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			ctx: like context
			l_upload_file: detachable RAW_FILE
			l_upload_filename: detachable READABLE_STRING_GENERAL
			l_form_string: STRING
			l_prev_header: READABLE_STRING_8
			l_boundary: READABLE_STRING_8
			l_is_http_1_0_request: BOOLEAN
			l_is_keep_alive: BOOLEAN
			l_is_chunked_transfer_encoding: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				ctx := context
				if ctx /= Void then
					l_is_http_1_0_request := attached ctx.http_version as l_http_version and then l_http_version.same_string ("HTTP/1.0")
				end
				create Result.make (url)

					-- Get URL data
				l_is_https := url.starts_with_general ("https://")
				create l_uri.make_from_string (url)
				l_port := l_uri.port
				if l_port = 0 then
					if l_is_https then
						l_port := 443
					else
						l_port := 80
					end
				end
				if attached l_uri.host as h then
					l_host := h
				else
					create l_url.make (url)
					l_host := l_url.host
				end

				if attached session.proxy as l_proxy_settings then
					-- For now, so proxy support.
					check
						not_supported: False
					end
				end

					-- Connect
				l_socket := session_socket (l_host, l_port, l_is_https, ctx)
				if l_socket.is_connected then

					create l_form_string.make_empty

						-- add headers for authorization
					if not headers.has ("Authorization") then
						if
							attached username as u_name and
							attached password as u_pass
						then
							create l_authorization.make_basic_auth (u_name, u_pass)
							if attached l_authorization.http_authorization as auth then
								headers.extend (auth, "Authorization")
							end
							check headers.has_key ("Authorization") end
						end
					end

					create l_request_uri.make_from_string (l_uri.path)
					if attached l_uri.query as l_query then
						l_request_uri.append_character ('?')
						l_request_uri.append (l_query)
					end

						-- add computed header User-Agent if not yet set.
					if not headers.has ("User-Agent") then
						if {PLATFORM}.is_unix then
							l_platform := "Unix"
						elseif {PLATFORM}.is_windows then
							l_platform := "Windows"
						elseif {PLATFORM}.is_mac then
							l_platform := "Mac"
						elseif {PLATFORM}.is_vms then
							l_platform := "VMS"
						elseif {PLATFORM}.is_vxworks then
							l_platform := "VxWorks"
						else
							l_platform := "Unknown"
						end
						headers.extend ("eiffelhttpclient/" + net_http_client_version + " (" + l_platform + ")", "User-Agent")
					end

						-- handle sending data
					l_is_chunked_transfer_encoding := attached headers.item ("Transfer-Encoding") as l_transfer_encoding and then l_transfer_encoding.same_string ("chunked")

					if ctx /= Void then
						if ctx.has_upload_filename then
							l_upload_filename := ctx.upload_filename
						end

						if ctx.has_upload_data then
							l_upload_data := ctx.upload_data
						end

						if ctx.has_form_data then
							l_form_data := ctx.form_parameters
							if l_upload_data = Void and l_upload_filename = Void then
									-- Send as form-urlencoded
								headers.extend ("application/x-www-form-urlencoded", "Content-Type")
								l_upload_data := ctx.form_parameters_to_url_encoded_string
								headers.force (l_upload_data.count.out, "Content-Length")
								if l_is_chunked_transfer_encoding then
										-- Discard chunked transfer encoding
									headers.remove ("Transfer-Encoding")
									l_is_chunked_transfer_encoding := False
								end
							elseif l_form_data /= Void then
									-- create form using multipart/form-data encoding
								l_boundary := new_mime_boundary (l_form_data)
								headers.extend ("multipart/form-data; boundary=" + l_boundary, "Content-Type")
								l_upload_data := form_date_and_uploaded_files_to_mime_string (l_form_data, l_upload_filename, l_boundary)
								headers.extend (l_upload_data.count.out, "Content-Length")
								if l_is_chunked_transfer_encoding then
										-- Discard chunked transfer encoding
									headers.remove ("Transfer-Encoding")
									l_is_chunked_transfer_encoding := False
								end
							end
						elseif l_upload_data /= Void then
							check ctx.has_upload_data end
							if not headers.has ("Content-Type") then
								headers.extend ("application/x-www-form-urlencoded", "Content-Type")
							end
							if not l_is_chunked_transfer_encoding then
								headers.extend (l_upload_data.count.out, "Content-Length")
							end
						elseif l_upload_filename /= Void then
							check ctx.has_upload_filename end
							create l_upload_file.make_with_name (l_upload_filename)
							if l_upload_file.exists and then l_upload_file.readable then
								if not l_is_chunked_transfer_encoding then
									headers.extend (l_upload_file.count.out, "Content-Length")
								end
							end
							check l_upload_file /= Void end
						end
					end

						-- FIXME: check usage of headers and specific header variable.
						--| only one Cookie: is allowed, so merge multiple into one;
						--| if Host is in header, use that one.
						-- Compute Request line.
					create s.make_from_string (request_method.as_upper)
					s.append_character (' ')
					s.append (l_request_uri)
					s.append_character (' ')
					if l_is_http_1_0_request then
						s.append ("HTTP/1.0")
					else
						s.append ("HTTP/1.1")
					end
					s.append (Http_end_of_header_line)

						-- Compute Header Host:
					s.append (Http_host_header)
					s.append (": ")
					if attached headers [Http_host_header] as h_host then
						s.append (h_host)
					else
						s.append (l_host)
						if l_is_https then
							if l_port /= 443 then
								s.append_character (':')
								s.append_integer (l_port)
							end
						elseif l_port /= 80 then
							s.append_character (':')
							s.append_integer (l_port)
						end
					end
					s.append (http_end_of_header_line)
					if not headers.has ("Connection") then
						if l_is_http_1_0_request then
							s.append ("Connection: keep-alive")
							s.append (http_end_of_header_line)
						end
					end

						-- Append the given request headers
					l_cookie := Void
					if not headers.is_empty then
						across
							headers as ic
						loop
							l_header_key := ic.key
							if l_header_key.same_string_general ("Host") then
									-- FIXME: already handled elsewhere!
							elseif l_header_key.same_string_general ("Cookie") then
									-- FIXME: need cookie merging.
								l_cookie := ic.item
							else
								s.append (ic.key)
								s.append (": ")
								s.append (ic.item)
								s.append (Http_end_of_header_line)
							end
						end
					end

						-- Compute Header Cookie:  if needed
						-- Use session cookie
					if l_cookie = Void then
						l_cookie := session.cookie
					else
							-- Overwrite potential session cookie, if specified by the user.
					end
					if l_cookie /= Void then
						s.append ("Cookie: ")
						s.append (l_cookie)
						s.append (http_end_of_header_line)
					end

						--| End of client header.
					s.append (Http_end_of_header_line)

						--| Note that any remaining data or file to upload will be done directly via the socket
						--| to optimize memory usage


						--|-----------------------------|--
						--| Request preparation is done |--
						--|-----------------------------|--

					if l_socket.ready_for_writing then
							--| Socket is ready for writing, so let's send the request.

							--|-------------------------|--
							--| Send request            |--
							--|-------------------------|--

						if session.is_header_sent_verbose then
							log ("> Sending:%N")
							log (s)
						end
						l_socket.put_string (s)
							--| Send remaining payload data, if needed.
						if l_upload_data /= Void then
							if l_is_chunked_transfer_encoding then
								put_string_using_chunked_transfer_encoding (l_upload_data, chunk_size, l_socket)
							else
								l_socket.put_string (l_upload_data)
							end
						end
						if l_upload_file /= Void then
							if l_is_chunked_transfer_encoding then
									-- i.e: not yet processed
								append_file_content_to_socket_using_chunked_transfer_encoding (l_upload_file, l_upload_file.count, chunk_size, l_socket)
							else
								append_file_content_to_socket (l_upload_file, l_upload_file.count, l_socket)
							end
						end

							--|-------------------------|--
							--| Get response.           |--
							--| Get header message      |--
							--|-------------------------|--
						if is_ready_for_reading (l_socket) then
							create l_message.make_empty
							append_socket_header_content_to (Result, l_socket, l_message)
							if session.is_header_received_verbose then
								log ("< Receiving:%N")
								log (l_message)
							end
							l_prev_header := Result.raw_header
							Result.set_raw_header (l_message.string)
							l_message.append (http_end_of_header_line)

							if not Result.error_occurred then
									-- Get information from header
								l_content_length := -1
								if attached Result.header ("Content-Length") as s_len and then s_len.is_integer then
									l_content_length := s_len.to_integer
								end
								l_location := Result.header ("Location")
								if attached Result.header ("Set-Cookie") as s_cookies then
									session.set_cookie (s_cookies)
								end

									-- Keep-alive connection?
									-- with HTTP/1.1, this is the default, and could be changed by Connection: close
									-- with HTTP/1.0, it requires "Connection: keep-alive" header line.
								if attached Result.header ("Connection") as s_connection then
									l_is_keep_alive := s_connection.same_string ("keep-alive")
								else
									l_is_keep_alive := not Result.is_http_1_0
								end

									-- Get content if any.
								append_socket_content_to (Result, l_socket, l_content_length, l_message)
									-- Restore previous header
								Result.set_raw_header (l_prev_header)
									-- Set message
								Result.set_response_message (l_message, ctx)
									-- Check status code.
								check status_coherent: attached Result.status_line as l_status_line implies l_status_line.has_substring (Result.status.out) end

								if l_is_keep_alive then
									session.set_persistent_connection (create {NET_HTTP_CLIENT_CONNECTION}.make (l_socket, l_host, l_port))
								else
									session.set_persistent_connection (Void)
								end

									-- follow redirect
								if 
									is_redirection_http_status (Result.status) and
									l_location /= Void 
								then
									if Result.redirections_count < max_redirects then
										initialize (l_location, ctx)
										redirection_response := response
										redirection_response.add_redirection (Result.status_line, Result.raw_header, Result.body)
										Result := redirection_response
									end
								end
								if not l_is_keep_alive then
									l_socket.cleanup
								end
							end
						else
							if session.is_debug_verbose then
								log ("Debug: Read Timeout!%N")
							end
							Result.set_error_message ("Read Timeout")
						end
					else
						if session.is_debug_verbose then
							log ("Debug: Write Timeout!%N")
						end
						Result.set_error_message ("Write Timeout")
					end
				else
					if session.is_debug_verbose then
						log ("Debug: Could not connect!%N")
					end
					Result.set_error_message ("Could not connect")
				end
			else
				create Result.make (url)
				Result.set_error_message ("Error: internal error")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Helpers

	log (m: READABLE_STRING_8)
			-- Output log messages.
		do
			io.error.put_string (m)
		end

	is_ready_for_reading (a_socket: HTTP_STREAM_SOCKET): BOOLEAN
			-- Is `a_socket' ready for reading?
		do
			Result := a_socket.ready_for_reading
		end

	is_redirection_http_status (a_status: INTEGER): BOOLEAN
			-- Is http status `a_status` a redirection response?
		do
			Result := a_status >= 300 and a_status < 400
		end

	form_date_and_uploaded_files_to_mime_string (a_form_parameters: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]; a_upload_filename: detachable READABLE_STRING_GENERAL; a_mime_boundary: READABLE_STRING_8): STRING
			-- Form data and uploaded files converted to mime string.
			-- TODO: design a proper MIME... component.
		local
			l_path: PATH
			l_mime_type: READABLE_STRING_8
			l_upload_file: detachable RAW_FILE
			l_mime_type_mapping: HTTP_FILE_EXTENSION_MIME_MAPPING
		do
			create Result.make (100)
			across
				a_form_parameters as ic
			loop
				Result.append (a_mime_boundary)
				Result.append (http_end_of_header_line)
				Result.append ("Content-Disposition: form-data; name=")
				Result.append_character ('%"')
				Result.append (string_to_mime_encoded_string (ic.key))
				Result.append_character ('%"')
				Result.append (http_end_of_header_line)
				Result.append (http_end_of_header_line)
				Result.append (string_to_mime_encoded_string (ic.item))
				Result.append (http_end_of_header_line)
			end

			if a_upload_filename /= Void then
					-- get file extension, otherwise set default
				create l_mime_type_mapping.make_default
				create l_path.make_from_string (a_upload_filename)
				if
					attached l_path.extension as ext and then
					attached l_mime_type_mapping.mime_type (ext) as l_mt
				then
					l_mime_type := l_mt
				else
					l_mime_type := "application/octet-stream"
				end

				Result.append (a_mime_boundary)
				Result.append (http_end_of_header_line)
				Result.append ("Content-Disposition: form-data; name=%"")
				Result.append (string_to_mime_encoded_string (a_upload_filename))
				Result.append_character ('%"')
				Result.append ("; filename=%"")
				Result.append (string_to_mime_encoded_string (a_upload_filename))
				Result.append_character ('%"')
				Result.append (http_end_of_header_line)
				Result.append ("Content-Type: ")
				Result.append (l_mime_type)
				Result.append (http_end_of_header_line)
				Result.append (http_end_of_header_line)

				create l_upload_file.make_with_path (l_path)
				if l_upload_file.exists and then l_upload_file.is_access_readable then
					append_file_content_to (l_upload_file, l_upload_file.count, Result)
						-- Reset l_upload_file to Void, since the related content is already processed.
					l_upload_file := Void
				end
				Result.append (http_end_of_header_line)
			end
			Result.append (a_mime_boundary)
			Result.append ("--") --| end			
		end

	string_to_mime_encoded_string (s: READABLE_STRING_GENERAL): STRING
			-- Encoded unicode string for mime value.
			-- For instance uploaded filename, or form data key or values.
		local
			utf: UTF_CONVERTER
		do
				-- FIXME: find the proper encoding!
			Result := utf.utf_32_string_to_utf_8_string_8 (s)
		end

	put_string_using_chunked_transfer_encoding (a_string: READABLE_STRING_8; a_chunk_size: INTEGER; a_output: HTTP_STREAM_SOCKET)
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := a_string.count
			until
				i > n
			loop
				put_chunk (a_string.substring (i, i + a_chunk_size), Void, a_output)
				i := i + a_chunk_size
			end
			put_chunk_end (Void, Void, a_output)
		end

	put_chunk (a_content: READABLE_STRING_8; a_ext: detachable READABLE_STRING_8; a_output: HTTP_STREAM_SOCKET)
			-- Write chunk non empty `a_content' to `a_output'
			-- with optional extension `a_ext': chunk-extension= *( ";" chunk-ext-name [ "=" chunk-ext-val ] )
			-- Note: that header "Transfer-Encoding: chunked" is required.
		require
			a_content_not_empty: a_content /= Void and then not a_content.is_empty
			valid_chunk_extension: (a_ext /= Void and then not a_ext.is_empty) implies
						( a_ext.starts_with (";") and not a_ext.has ('%N') and not not a_ext.has ('%R') )
		local
			l_chunk_size_line: STRING_8
			i: INTEGER
		do
				--| Remove all left '0'
			l_chunk_size_line := a_content.count.to_hex_string
			from
				i := 1
			until
				l_chunk_size_line[i] /= '0'
			loop
				i := i + 1
			end
			if i > 1 then
				l_chunk_size_line := l_chunk_size_line.substring (i, l_chunk_size_line.count)
			end

			if a_ext /= Void then
				l_chunk_size_line.append (a_ext)
			end
			l_chunk_size_line.append (crlf)

			a_output.put_string (l_chunk_size_line)
			a_output.put_string (a_content)
			a_output.put_string (crlf)
		end

	put_chunk_end (a_ext: detachable READABLE_STRING_8; a_trailer: detachable READABLE_STRING_8; a_output: HTTP_STREAM_SOCKET)
			-- Put end of chunked content,
			-- with optional extension `a_ext': chunk-extension= *( ";" chunk-ext-name [ "=" chunk-ext-val ] )
			-- and with optional trailer `a_trailer' : trailer= *(entity-header CRLF)
		local
			l_chunk_size_line: STRING_8
		do
			-- Chunk end
			create l_chunk_size_line.make (1)
			l_chunk_size_line.append_integer (0)

			if a_ext /= Void then
				l_chunk_size_line.append (a_ext)
			end
			l_chunk_size_line.append (crlf)
			a_output.put_string (l_chunk_size_line)

				-- Optional trailer
			if a_trailer /= Void and then not a_trailer.is_empty then
				a_output.put_string (a_trailer)
			end

				-- Final CRLF
			a_output.put_string (crlf)
		end

	append_file_content_to_socket_using_chunked_transfer_encoding (a_file: FILE; a_len: INTEGER; a_chunk_size: INTEGER; a_output: HTTP_STREAM_SOCKET)
			-- Append `a_file' content as chunks of `a_chunk_size' length to `a_output'.
			-- If `a_len' >= 0 then read only `a_len' characters.
		require
			a_file_readable: a_file.exists and then a_file.is_access_readable
		local
			l_was_open: BOOLEAN
			l_count: INTEGER
		do
			if a_len >= 0 then
				l_count := a_len
			else
				l_count := a_file.count
			end
			if l_count > 0 then
				l_was_open := a_file.is_open_read
				if a_file.is_open_read then
					l_was_open := True
				else
					a_file.open_read
				end
				from
				until
					l_count = 0 or a_file.exhausted
				loop
					a_file.read_stream_thread_aware (l_count.min (a_chunk_size))
					put_chunk (a_file.last_string, Void, a_output)
					l_count := l_count - a_file.bytes_read
				end
				if not l_was_open then
					a_file.close
				end
				put_chunk_end (Void, Void, a_output)
			end
		end

	append_file_content_to_socket (a_file: FILE; a_len: INTEGER; a_output: HTTP_STREAM_SOCKET)
			-- Append `a_file' content to `a_output'.
			-- If `a_len' >= 0 then read only `a_len' characters.
		require
			a_file_readable: a_file.exists and then a_file.is_access_readable
		local
			l_was_open: BOOLEAN
			l_count, l_buffer_size: INTEGER
		do
			if a_len >= 0 then
				l_count := a_len
			else
				l_count := a_file.count
			end
			if l_count > 0 then
				l_was_open := a_file.is_open_read
				if a_file.is_open_read then
					l_was_open := True
				else
					a_file.open_read
				end
				from
					l_buffer_size := buffer_size
				until
					l_count = 0 or a_file.exhausted
				loop
					a_file.read_stream_thread_aware (l_count.min (l_buffer_size))
					a_output.put_string (a_file.last_string)
					l_count := l_count - a_file.bytes_read
				end
				if not l_was_open then
					a_file.close
				end
			end
		end

	append_file_content_to (a_file: FILE; a_len: INTEGER; a_output: STRING)
			-- Append `a_file' content to `a_output'.
			-- If `a_len' >= 0 then read only `a_len' characters.
		require
			a_file_readable: a_file.exists and then a_file.is_access_readable
		local
			l_was_open: BOOLEAN
			l_count: INTEGER
			l_buffer_size: INTEGER
		do
			if a_len >= 0 then
				l_count := a_len
			else
				l_count := a_file.count
			end
			if l_count > 0 then
				l_was_open := a_file.is_open_read
				if a_file.is_open_read then
					l_was_open := True
				else
					a_file.open_read
				end
				from
					l_buffer_size := buffer_size
				until
					l_count = 0 or a_file.exhausted
				loop
					a_file.read_stream_thread_aware (l_count.min (l_buffer_size))
					a_output.append (a_file.last_string)
					l_count := l_count - a_file.bytes_read
				end
				if not l_was_open then
					a_file.close
				end
			end
		end

	append_socket_header_content_to (a_response: HTTP_CLIENT_RESPONSE; a_socket: HTTP_STREAM_SOCKET; a_output: STRING)
			-- Get header from `a_socket' into `a_output'.
		local
			s: READABLE_STRING_8
		do
			from
				s := ""
			until
				s.same_string ("%R") or not a_socket.readable or a_response.error_occurred
			loop
				a_socket.read_line_noexception
				s := a_socket.last_string
				if s.is_empty then
					if session.is_debug_verbose then
						log ("Debug: ERROR: zero byte read when receiving header.%N")
					end
					a_response.set_error_message ("Read zero byte, expecting header line")
				elseif s.same_string ("%R") then
						-- Reach end of header
				else
					a_output.append (s)
					a_output.append_character ('%N')
				end
			end
		end

	append_socket_content_to (a_response: HTTP_CLIENT_RESPONSE; a_socket: HTTP_STREAM_SOCKET; a_len: INTEGER; a_output: STRING)
			-- Get content from `a_socket' and append it to `a_output'.
			-- If `a_len' is negative, try to get as much as possible,
			-- this is probably HTTP/1.0 without any Content-Length.
		local
			s: STRING_8
			r: INTEGER -- remaining count
			n,l_chunk_size, l_count: INTEGER
		do
			if a_socket.readable then
				if a_len >= 0 then
					if session.is_debug_verbose then
						log ("Debug: Content-Length="+ a_len.out +"%N")
					end
					from
						r := a_len
					until
						r = 0 or else not a_socket.readable or else a_response.error_occurred
					loop
						a_socket.read_stream_noexception (r)
						l_count := l_count + a_socket.bytes_read
						if session.is_debug_verbose then
							log ("Debug:   - byte read=" + a_socket.bytes_read.out + "%N")
							log ("Debug:   - current count=" + l_count.out + "%N")
						end
						r := r - a_socket.bytes_read
						a_output.append (a_socket.last_string)
					end
					check full_content_read: not a_response.error_occurred implies l_count = a_len end
				elseif attached a_response.header ("Transfer-Encoding") as l_enc and then l_enc.is_case_insensitive_equal ("chunked") then
					append_socket_chunked_content_to (a_response, a_socket, a_output)
				else
						-- No Content-Length and no chunked transfer encoding!
						-- maybe HTTP/1.0 ?
						-- FIXME: check solution!
					from
						l_count := 0
						l_chunk_size := buffer_size
						n := l_chunk_size --| value to satisfy until condition on first loop.
					until
						n < l_chunk_size or not a_socket.readable
					loop
						a_socket.read_stream_noexception (l_chunk_size)
						s := a_socket.last_string
						n := a_socket.bytes_read
						l_count := l_count + n
						a_output.append (s)
					end
				end
			end
		end

	append_socket_chunked_content_to (a_response: HTTP_CLIENT_RESPONSE; a_socket: HTTP_STREAM_SOCKET; a_output: STRING)
			-- Get chunked content from `a_socket' and append it to `a_output'.
		require
			socket_readable: a_socket.readable
			has_chunked_transfer_encoding: attached a_response.header ("Transfer-Encoding") as l_enc and then
				l_enc.is_case_insensitive_equal ("chunked")
		local
			s: STRING_8
			r: INTEGER -- remaining count
			n,pos, l_count: INTEGER
			hexa2int: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
		do
			if session.is_debug_verbose then
				log ("Debug: Chunked encoding%N")
			end
			from
				create hexa2int.make
				n := 1
			until
				n = 0 or not a_socket.readable
			loop
				a_socket.read_line_noexception
				s := a_socket.last_string
				s.right_adjust
				if session.is_debug_verbose then
					log ("Debug:   - chunk info='" + s + "'%N")
				end
				pos := s.index_of (';', 1)
				if pos > 0 then
					s.keep_head (pos - 1)
				end
				if s.is_empty then
					n := 0
				else
					hexa2int.parse_string_with_type (s, hexa2int.type_integer)
					if hexa2int.parse_successful then
						n := hexa2int.parsed_integer
					else
						n := 0
					end
				end
				if session.is_debug_verbose then
					log ("Debug:   - chunk size=" + n.out + "%N")
				end
				if n > 0 then
					from
						r := n
					until
						r = 0 or else not a_socket.readable or else a_response.error_occurred
					loop
						a_socket.read_stream_noexception (r)
						l_count := l_count + a_socket.bytes_read
						if session.is_debug_verbose then
							log ("Debug:   - byte read=" + a_socket.bytes_read.out + "%N")
							log ("Debug:   - current count=" + l_count.out + "%N")
						end
						r := r - a_socket.bytes_read
						a_output.append (a_socket.last_string)
					end

					a_socket.read_character_noexception
					check a_socket.last_character = '%R' end
					a_socket.read_character_noexception
					check a_socket.last_character = '%N' end
					if session.is_debug_verbose then
						log ("Debug:   - Found CRNL %N")
					end
				end
			end
		end

	new_mime_boundary (a_data: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]): STRING
			-- New MIME boundary.
		local
			s: STRING
			ran: RANDOM
			n: INTEGER
			i,j: INTEGER
		do
			across
				a_data as ic
			loop
				i := i + ic.item.count + ic.key.count
			end
			create ran.set_seed (i) -- FIXME: use a real random seed.
			ran.start
			ran.forth
			n := (20 * ran.real_item).truncated_to_integer
			create Result.make_filled ('-', 3 + n)
			s := "_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
			from
			until
				Result.count >= 40
			loop
				ran.forth
				j := (ran.real_item * s.count).truncated_to_integer.max (1)
				Result.append_character (s[j])
			end
			check Result.count = 40 and Result.starts_with ("---") end
		end

	crlf: STRING = "%R%N"
			-- CR and NL sequence.

invariant
note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
