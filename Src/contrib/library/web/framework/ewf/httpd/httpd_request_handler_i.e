note
	description: "HTTPD handler interface processing request."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_REQUEST_HANDLER_I

inherit
	HTTPD_DEBUG_FACILITIES

	HTTPD_LOGGER_CONSTANTS

	HTTPD_SOCKET_FACTORY

feature {NONE} -- Initialization

	make (a_request_settings: HTTPD_REQUEST_SETTINGS)
		do
			reset
				-- Import global request settings.
			timeout := a_request_settings.timeout -- seconds
			socket_recv_timeout := a_request_settings.socket_recv_timeout -- seconds
			keep_alive_timeout := a_request_settings.keep_alive_timeout -- seconds
			max_keep_alive_requests := a_request_settings.max_keep_alive_requests

			is_verbose := a_request_settings.is_verbose
			verbose_level := a_request_settings.verbose_level
			is_secure := a_request_settings.is_secure
		end

	reset
		do
			reset_request (False)

			reset_error
			if attached internal_client_socket as l_sock then
				l_sock.cleanup
			end
			internal_client_socket := Void
		end

	reset_request (a_is_reusing_connection: BOOLEAN)
			-- Reset the request, and `a_is_reusing_connection' says if the peristent connection is
			-- still alive.
		do
			if a_is_reusing_connection then
					-- Keep `remote_info' as it stays the same for the successive
					-- persistent connections.
			else
				remote_info := Void
			end

			version := Void

				-- FIXME: optimize to just wipe_out if needed
			create method.make_empty
			create uri.make_empty
			create request_header.make_empty
			create request_header_map.make (10)

			is_persistent_connection_requested := False
		end

feature -- Status report

	is_connected: BOOLEAN
			-- Is handler connected to incoming request via `client_socket'?
		do
			Result := client_socket.descriptor_available
		end

feature -- Access

	internal_client_socket: detachable HTTPD_STREAM_SOCKET

	client_socket: HTTPD_STREAM_SOCKET
		local
			s: like internal_client_socket
		do
			s := internal_client_socket
			if s = Void then
				s := new_client_socket (is_secure)
				internal_client_socket := s
			end
			Result := s
		end

	request_header: STRING
			-- Header' source

	request_header_map: HASH_TABLE [STRING, STRING]
			-- Contains key:value of the header

	method: STRING
			-- http verb

	uri: STRING
			--  http endpoint

	version: detachable STRING
			--  http_version
			--| unused for now

	remote_info: detachable TUPLE [addr: STRING; hostname: STRING; port: INTEGER]
			-- Information related to remote client

	is_persistent_connection_requested: BOOLEAN
			-- Persistent connection requested?
			-- either has "Connection: keep-alive" header,
			-- or is HTTP/1.1 and no header "Connection: close".

	is_http_version_1_0: BOOLEAN
		do
			Result := not attached version as v or else v.same_string ("HTTP/1.0")
		end

	is_http_version_1_1: BOOLEAN
		do
			Result := not attached version as v or else v.same_string ("HTTP/1.1")
		end

	is_http_version_2: BOOLEAN
		do
			Result := not attached version as v or else v.same_string ("HTTP/2.0")
		end

feature -- Settings	

	is_verbose: BOOLEAN
			-- Output messages?

	verbose_level: INTEGER
			-- Output verbosity.

	is_secure: BOOLEAN
			-- Is secure socket?
			-- i.e: SSL?			

	is_persistent_connection_supported: BOOLEAN
			-- Is persistent connection supported?
		do
			Result := {HTTPD_SERVER}.is_persistent_connection_supported and then max_keep_alive_requests > 0
		end

	is_next_persistent_connection_supported: BOOLEAN
			-- Is next persistent connection supported?
			-- note: it is relevant only if `is_persistent_connection_supported' is True.

	timeout: INTEGER -- seconds
			-- Amount of seconds that the server waits for receipts and transmissions during communications.

	socket_recv_timeout: INTEGER -- seconds
			-- Amount of seconds that the server waits for receiving data on socket during communications.

	max_keep_alive_requests: INTEGER
			-- Maximum number of requests allowed per persistent connection.

	keep_alive_timeout: INTEGER -- seconds
			-- Number of seconds for persistent connection timeout.

feature -- Status report

	has_error: BOOLEAN
			-- Error occurred during `get_request_header'

feature -- Status change

	report_error (m: detachable READABLE_STRING_GENERAL)
			-- Report error occurred, with optional message `m'.
		do
			has_error := True
		end

	reset_error
			-- Reset previous error for current request handler.
		do
			has_error := False
		end

feature -- Change

	set_is_verbose (b: BOOLEAN)
			-- Set `is_verbose' with `b'.
		do
			is_verbose := b
		ensure
			is_verbose_set: is_verbose = b
		end

feature -- Execution

	safe_execute
			-- Execute accepted incoming connection as request.
		local
			retried: BOOLEAN
		do
			if retried then
				release
			else
				if
					not has_error and then
					is_connected
				then
					execute
				end
				release
			end
		rescue
			retried := True
			retry
		end

	execute
		require
			is_connected: is_connected
		local
			l_socket: like client_socket
			l_remote_info: detachable like remote_info
			l_exit: BOOLEAN
			n,m: INTEGER
		do
			l_socket := client_socket

				-- Compute remote info once for the persistent connection.			
			create l_remote_info
			if attached l_socket.peer_address as l_addr then
				l_remote_info.addr := l_addr.host_address.host_address
				l_remote_info.hostname := l_addr.host_address.host_name
				l_remote_info.port := l_addr.port
			end
			remote_info := l_remote_info

			check
				socket_attached: l_socket /= Void
				socket_valid: l_socket.is_open_read and then l_socket.is_open_write
			end
			from
					-- Process persistent connection as long the socket is not closed.
				n := 0
				m := max_keep_alive_requests
				is_next_persistent_connection_supported := True
			until
				l_exit
			loop
				n := n + 1
				if n >= m then
					is_next_persistent_connection_supported := False
				elseif n > 1 and is_verbose then
					log ("Reuse connection (" + n.out + ")", information_level)
				end
					-- FIXME: it seems to be called one more time, mostly to see this is done.
				execute_request (n > 1)
				l_exit := not is_persistent_connection_supported
						or not is_next_persistent_connection_supported -- related to `max_keep_alive_requests'
						or not is_persistent_connection_requested
						or has_error or l_socket.is_closed or not l_socket.is_open_read
				reset_request (not l_exit)
			end
			if l_exit and has_error and not l_socket.is_closed then
				l_socket.close
			end
		end

	execute_request (a_is_reusing_connection: BOOLEAN)
			-- Execute http request, and if `a_is_reusing_connection' is True
			-- the execution is reusing the persistent connection.
		require
			is_connected: is_connected
			reuse_connection_when_possible: a_is_reusing_connection implies is_persistent_connection_supported
			no_error: not has_error
			remote_info_set: remote_info /= Void
		local
			l_socket: like client_socket
		do
			debug ("dbglog")
				if a_is_reusing_connection then
					dbglog ("execute_request: wait on persistent connection.")
				end
			end
			reset_error
			l_socket := client_socket
			check
				socket_attached: l_socket /= Void
				socket_valid: l_socket.is_open_read and then l_socket.is_open_write
			end
			if l_socket.is_closed then
				debug ("dbglog")
					dbglog ("execute_request {socket is Closed!}")
				end
			else
				debug ("dbglog")
					dbglog ("execute_request  socket=" + l_socket.descriptor.out + " ENTER")
				end

					-- Try to get request header.
					-- If the request is reusing persistent connection, use `keep_alive_timeout',
					-- otherwise `socket_recv_timeout'.
				get_request_header (l_socket, a_is_reusing_connection)

				if has_error then
					if a_is_reusing_connection and then request_header.is_empty then
							-- Close persistent connection, since no new connection occurred in the delay `keep_alive_timeout'.
						debug ("dbglog")
							dbglog ("execute_request socket=" + l_socket.descriptor.out + "} close persistent connection.")
						end
					else
						if is_verbose then
							log (request_header + "%NWARNING: invalid HTTP incoming request", warning_level)
						end
						process_bad_request (l_socket)
					end
					is_persistent_connection_requested := False
				else
					if is_verbose then
						log (request_header, information_level)
					end
					process_request (l_socket)
				end

				debug ("dbglog")
					dbglog ("execute_request {" + l_socket.descriptor.out + "} LEAVE")
				end
			end
		end

	release
		do
			reset
		end

feature -- Request processing

	process_request (a_socket: HTTPD_STREAM_SOCKET)
			-- Process request on socket `a_socket'.
		require
			no_error: not has_error
			a_uri_attached: uri /= Void
			a_method_attached: method /= Void
			a_header_map_attached: request_header_map /= Void
			a_header_text_attached: request_header /= Void
			a_socket_attached: a_socket /= Void
		deferred
		end

	process_bad_request (a_socket: HTTPD_STREAM_SOCKET)
			-- Process bad request catched on `a_socket'.
		require
			has_error: has_error
			a_socket_attached: a_socket /= Void
		local
--			h: STRING
--			s: STRING
		do
				-- NOTE: this is experiment code, and not ready yet.

--			if a_socket.ready_for_writing then
--				s := "{
--<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
--<html><head>
--<title>400 Bad Request</title>
--</head><body>
--<h1>Bad Request</h1>
--</body></html>
--				}"
--				create h.make (1_024)
--				h.append ("HTTP/1.1 400 Bad Request%R%N")
--				h.append ("Content-Length: " + s.count.out + "%R%N")
--				h.append ("Connection: close%R%N")
--				h.append ("Content-Type: text/html; charset=iso-8859-1%R%N")
--				h.append ("%R%N")
--				a_socket.put_string (h)
--				if a_socket.ready_for_writing then
--					a_socket.put_string (s)
--				end
--			end
		end

feature -- Parsing

	get_request_header (a_socket: HTTPD_STREAM_SOCKET; a_is_reusing_connection: BOOLEAN)
			-- Analyze message extracted from `a_socket' as HTTP request.
			-- If `a_is_reusing_connection' is True, then first use
			-- Note: it reads from socket.
			-- Note: it updates `request_header' and `request_header_map', and eventually `is_persistent_connection_requested'.
		require
			input_readable: a_socket /= Void and then a_socket.is_open_read
		local
			end_of_stream: BOOLEAN
			pos, n: INTEGER
			line: detachable STRING
			k, val: STRING
			txt: STRING
			l_is_verbose: BOOLEAN
		do
			create txt.make (64)
			request_header := txt
			l_is_verbose := is_verbose

			if
				not has_error and then
				a_socket.readable
			then
				if a_is_reusing_connection then
					a_socket.set_recv_timeout (keep_alive_timeout) -- in seconds!
				else
					a_socket.set_recv_timeout (socket_recv_timeout) -- FIXME: return a 408 Request Timeout response ..
				end

				if
					attached next_line (a_socket) as l_request_line and then
					not l_request_line.is_empty and then
					not has_error
				then
					txt.append (l_request_line)
					txt.append_character ('%N')
					analyze_request_line (l_request_line)

					if not has_error then
						if a_is_reusing_connection then
								-- Restore normal recv timeout!
							a_socket.set_recv_timeout (socket_recv_timeout) -- FIXME: return a 408 Request Timeout response ..
						end
						from
							line := next_line (a_socket)
						until
							line = Void or end_of_stream or has_error
						loop
							n := line.count
							debug ("ew_standalone")
								if l_is_verbose then
									log (line, debug_level)
								end
							end
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
								request_header_map.put (val, k)
							end
							txt.append (line)
							txt.append_character ('%N')
							if line.is_empty or else line [1] = '%R' then
								end_of_stream := True
							else
								line := next_line (a_socket)
							end
						end
							-- Except for HTTP/1.0, persistent connection is the default.
						is_persistent_connection_requested := True
						if is_http_version_1_0 then
							is_persistent_connection_requested := has_keep_alive_http_connection_header (request_header_map)
						else
								-- By default HTTP:1/1 support persistent connection.
							if has_close_http_connection_header (request_header_map) then
								is_persistent_connection_requested := False
							else
								is_persistent_connection_requested := True
							end
						end
					end
				else
					report_error ("Bad header line (empty)")
				end
			else
				report_error ("Socket is not readable")
			end
		end

	has_keep_alive_http_connection_header (h_map: like request_header_map): BOOLEAN
			-- Does Current request header map `h_map' have "keep-alive" connection header?
		local
			i: INTEGER
		do
			if attached h_map.item ("Connection") as l_connection then
					-- Could be for instance "keep-alive, Upgrade"
				i := l_connection.substring_index ("keep-alive", 1)
				if i > 0 then
					i := i + 9 -- "keep-alive" has 10 characters
					check i <= l_connection.count end
					if i = l_connection.count then
						Result := True
					else
						Result := l_connection [i + 1] = ',' or l_connection [i + 1].is_space
					end
				end
			end
		end

	has_close_http_connection_header (h_map: like request_header_map): BOOLEAN
			-- Does Current request header map `h_map' have "close" connection header?
		local
			i: INTEGER
		do
			if attached h_map.item ("Connection") as l_connection then
					-- Could be for instance "close, ..."
				i := l_connection.substring_index ("close", 1)
				if i > 0 then
					i := i + 4 -- "close" has 5 characters
					check i <= l_connection.count end
					if i = l_connection.count then
						Result := True
					else
						Result := l_connection [i + 1] = ',' or l_connection [i + 1].is_space
					end
				end
			end
		end

	analyze_request_line (line: STRING)
			-- Analyze `line' as a HTTP request line.
			-- note: may update `has_error'.
		require
			valid_line: line /= Void and then not line.is_empty
		local
			n, pos, next_pos: INTEGER
		do
			debug ("ew_standalone")
				if is_verbose then
					log ("%N## Parse HTTP request line ##", debug_level)
					log (line, debug_level)
				end
			end
			pos := line.index_of (' ', 1)
			method := line.substring (1, pos - 1)
			next_pos := line.index_of (' ', pos + 1)
			uri := line.substring (pos + 1, next_pos - 1)
			n := line.count
			if line[n] = '%R' then
				n := n - 1
			end
			version := line.substring (next_pos + 1, n)
			if method.is_empty then
				report_error ("Missing request method data")
			end
		end

	next_line (a_socket: HTTPD_STREAM_SOCKET): detachable STRING
			-- Next line fetched from `a_socket' is available.
			-- note: may update `has_error'.
		require
			not_has_error: not has_error
			is_readable: a_socket.is_open_read
		local
			retried: BOOLEAN
		do
			if retried then
				report_error ("Rescue in next_line")
				a_socket.close
				Result := Void
			elseif a_socket.readable then
				a_socket.read_line_noexception
				Result := a_socket.last_string
					-- Do no check `was_error' before socket operation,
					-- otherwise it may be False, due to error during other socket operation in same thread.
				if a_socket.was_error then
					report_error ("Socket error")
					if is_verbose then
						log (request_header +"%N" + Result + "%N## Network error: " + a_socket.error + " ##", debug_level)
					end
				end
			else
					-- Error with socket...
				report_error ("Socket error: not readable")
				if is_verbose then
					log (request_header + "%N## Socket is not readable! ##", debug_level)
				end
			end
		rescue
				-- In case of network error exception (as EiffelNet reports error raising exception)
			retried := True
			retry
		end

feature -- Output

	logger: detachable HTTPD_LOGGER

	set_logger (a_logger: like logger)
			-- Set `logger' with `a_logger'.
		do
			logger := a_logger
		ensure
			logger_set: logger = a_logger
		end

	log (m: STRING; a_level: INTEGER)
			-- Log message `m'.
		require
			is_verbose: is_verbose
		do
			if is_verbose and (verbose_level & a_level) = a_level then
				if attached logger as l_logger then
					l_logger.log (m)
				else
					io.put_string (m + "%N")
				end
			end
		end

feature {NONE} -- Helpers

	socket_has_incoming_data (a_socket: HTTPD_STREAM_SOCKET): BOOLEAN
			-- Is there any data to read on `a_socket' ?
		require
			a_socket.readable
		do
				-- FIXME: check if both are really needed.			
--			Result := a_socket.ready_for_reading --and then a_socket.has_incoming_data
--			Result := a_socket.has_incoming_data
			Result := True
		end

invariant
	request_header_attached: request_header /= Void

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
