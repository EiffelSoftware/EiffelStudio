note
	description: "Summary description for {WSF_SIMPLE_REVERSE_PROXY_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SIMPLE_REVERSE_PROXY_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_remote_uri: READABLE_STRING_8)
		do
			create remote_uri.make_from_string (a_remote_uri)
			timeout := 30 -- seconds. See {NETWORK_SOCKET}.default_timeout
			connect_timeout := 5_000 -- 5 seconds.
			is_via_header_supported := True
		end

feature -- Access

	remote_uri: URI
			-- Url for the targetted service.

	uri_rewriter: detachable WSF_URI_REWRITER assign set_uri_rewriter
			-- URI rewriter component, to compute the URI on targetted service
			-- based on current request.

feature -- Settings

	connect_timeout: INTEGER assign set_connect_timeout
			-- In milliseconds.

	timeout: INTEGER assign set_timeout
			-- In seconds.

	is_via_header_supported: BOOLEAN
			-- Via: header supported.
			-- Default: True.

feature -- Change

	set_uri_rewriter (a_rewriter: like uri_rewriter)
		do
			uri_rewriter := a_rewriter
		end

	set_timeout (a_timeout_in_seconds: INTEGER)
			-- in seconds.
		do
			timeout := a_timeout_in_seconds
		end

	set_connect_timeout (a_timeout_in_milliseconds: INTEGER)
			-- in milliseconds.
		do
			connect_timeout := a_timeout_in_milliseconds
		end

	set_is_via_header_supported (b: BOOLEAN)
			-- Set `is_via_header_supported' to `b'.
		do
			is_via_header_supported := b
		end

feature -- Execution

	proxy_uri (request: WSF_REQUEST): STRING
			-- URI to query on proxyfied host.
		do
			if attached uri_rewriter as r then
				Result := r.uri (request)
			else
				Result := request.request_uri
			end
		end

	execute (request: WSF_REQUEST; response: WSF_RESPONSE)
			-- Execute reverse proxy request.
		local
			h: HTTP_HEADER
			l_http_query: STRING
			l_status_line: STRING
			l_max_forward: INTEGER
			l_via: detachable STRING
			l_protocol: STRING
			i: INTEGER
			l_completed: BOOLEAN
			l_remote_uri: like remote_uri
			l_socket_factory: WSF_PROXY_SOCKET_FACTORY
		do
			l_remote_uri := remote_uri
			create l_socket_factory
			if not l_socket_factory.is_uri_supported (l_remote_uri) then
				send_error (request, response, {HTTP_STATUS_CODE}.bad_gateway, l_remote_uri.scheme + " is not supported! [for remote " + l_remote_uri.string + "]")
			elseif attached l_socket_factory.socket_from_uri (l_remote_uri) as l_socket then
				l_socket.set_connect_timeout (connect_timeout) -- milliseconds
				l_socket.set_timeout (timeout) -- seconds

				l_socket.connect
				if l_socket.is_connected then
					create l_http_query.make_from_string (request.request_method)
					l_http_query.append_character (' ')
					l_http_query.append (l_remote_uri.path)
					l_http_query.append (proxy_uri (request))
					l_http_query.append_character (' ')
					l_http_query.append (request.server_protocol)
					if attached request.raw_header_data as l_raw_header then
						i := l_raw_header.substring_index ("%R%N", 1)
						if i > 0 then
								-- Skip the first status line.
							create h.make_from_raw_header_data (l_raw_header.substring (i + 2, l_raw_header.count))
						else
							create h.make_from_raw_header_data (l_raw_header)
						end
						if attached l_remote_uri.host as l_remote_host then
							if l_remote_uri.port > 0 then
								h.put_header_key_value ("Host", l_remote_host + ":" + l_remote_uri.port.out)
							else
								h.put_header_key_value ("Host", l_remote_host)
							end
						end

							-- Via header
						if is_via_header_supported then
							if attached h.item ("Via") as v then
								l_via := v
								l_via.append (", ")
							else
								create l_via.make_empty
							end
							l_via.append (request.server_protocol + " " + request.server_name + " (PROXY-" + request.server_software + ")")
							h.put_header_key_value ("Via", l_via)
						end

							-- Max-Forwards header handling
						if attached h.item ("Max-Forwards") as h_max_forward then
								-- Max-Forwards: 0 stop, otherwise decrement by one.
								--	see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.31
							if h_max_forward.is_integer then
								l_max_forward := h_max_forward.to_integer - 1
								if l_max_forward >= 0 then
									h.put_header_key_value ("Max-Forwards", l_max_forward.out)
								end
							end
						end
						if l_max_forward < 0 then
								-- i.e previous Max-Forwards was '0'
							send_error (request, response, {HTTP_STATUS_CODE}.bad_gateway, "Reached maximum number of Forwards, not forwarded to " + l_remote_uri.string)
						else
							l_socket.put_string (l_http_query)
							l_socket.put_string ("%R%N")
							l_socket.put_string (h.string)
							l_socket.put_string ("%R%N")
							if request.content_length_value > 0 then
								request.read_input_data_into_file (l_socket)
							end

								-- Get HTTP status
							l_socket.read_line_thread_aware
							create l_status_line.make_from_string (l_socket.last_string)
								-- Get HTTP header block
							if attached next_http_header_block (l_socket) as l_resp_header then
								create h.make_from_raw_header_data (l_resp_header)
								if attached status_line_info (l_status_line) as l_status_info then
									l_protocol := l_status_info.protocol
									if attached l_status_info.reason_phrase as l_phrase then
										response.set_status_code_with_reason_phrase (l_status_info.status_code, l_phrase)
									else
										response.set_status_code (l_status_info.status_code)
									end
								else
									check has_status_line: False end
									l_protocol := "1.0" -- Default?
									response.set_status_code (80)
								end

								if is_via_header_supported then
									if attached h.item ("Via") as v then
										l_via := v
										l_via.append (", ")
									else
										create l_via.make_empty
									end
									l_via.append (l_protocol + " " + request.server_name + " (PROXY-" + request.server_software + ")")
									h.put_header_key_value ("Via", l_via)
								end

								response.add_header_lines (h)
								from
									l_socket.read_stream (2_048)
								until
									l_socket.was_error
									or not l_socket.is_connected
									or l_socket.bytes_read <= 0
									or l_completed
								loop
									response.put_string (l_socket.last_string)
									if l_socket.bytes_read = 2_048 then
										l_socket.read_stream (2_048)
									else
										l_completed := True
									end
								end
							else
								send_error (request, response, {HTTP_STATUS_CODE}.internal_server_error, "Invalid response header!")
							end
						end
					else
						send_error (request, response, {HTTP_STATUS_CODE}.internal_server_error, "Can not access request header!")
					end
				else
					send_error (request, response, {HTTP_STATUS_CODE}.gateway_timeout, "Unable to connect " + l_remote_uri.string)
				end
			else
				send_error (request, response, {HTTP_STATUS_CODE}.bad_gateway, "Unable to connect " + l_remote_uri.string)
			end
		end

feature {NONE} -- Implementation		

	status_line_info (a_line: READABLE_STRING_8): detachable TUPLE [protocol: READABLE_STRING_8; status_code: INTEGER; reason_phrase: detachable READABLE_STRING_8]
			-- Info from status line
			--| Such as "HTTP/1.1 200 OK" -> ["1.1", 200, "OK"]
		local
			i,j: INTEGER
			p,s: detachable READABLE_STRING_8
			c: INTEGER
		do
			i := a_line.index_of (' ', 1)
			if i > 0 then
				p := a_line.substring (1, i - 1)
				if p.starts_with_general ("HTTP/") then
					p := p.substring (6, p.count) -- We could also keep HTTP/
				end
				j := i + 1
				i := a_line.index_of (' ', j)
				if i > 0 then
					s := a_line.substring (j, i - 1)
					if s.is_integer then
						c := s.to_integer
						s := a_line.substring (i + 1, a_line.count)
						if s.is_whitespace then
							s := Void
						elseif s[s.count].is_space then
							s := s.substring (1, s.count - 1)
						end
						Result := [p, c, s]
					end
				end
			end
		end

	next_http_header_block (a_socket: NETWORK_STREAM_SOCKET): detachable STRING
		local
			h: STRING
		do
			create h.make_empty
			from
				a_socket.read_line_thread_aware
			until
				Result /= Void
				or a_socket.was_error
				or (a_socket.bytes_read = 0 or a_socket.bytes_read = -1)
				or not a_socket.is_connected
			loop
				if a_socket.last_string.same_string ("%R") then
						-- End of header
					Result := h
				else
					h.append (a_socket.last_string)
					h.append ("%N")
					a_socket.read_line_thread_aware
				end
			end
		end

	send_error (request: WSF_REQUEST; response: WSF_RESPONSE; a_status_code: INTEGER; a_message: READABLE_STRING_8)
		local
			s: STRING
 		do
	 			-- To send a response we need to setup, the status code and
	 			-- the response headers.
 			create s.make_from_string (a_message)
			debug
				s.append ("%N(UTC time is " + (create {HTTP_DATE}.make_now_utc).rfc850_string + ").%N")
			end
			response.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "plain/text"], ["Content-Length", s.count.out]>>)
			response.set_status_code (a_status_code)
			response.header.put_content_type_text_html
			response.header.put_content_length (s.count)
			if
				attached request.http_connection as l_connection and then
				l_connection.is_case_insensitive_equal_general ("keep-alive")
			then
				response.header.put_header_key_value ("Connection", "keep-alive")
			end
			response.put_string (s)
		end

end
