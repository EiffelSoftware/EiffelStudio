note
	description: "HTTPD handler interface processing request."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_REQUEST_HANDLER_I

inherit
	HTTPD_DEBUG_FACILITIES

feature {NONE} -- Initialization

	make
		do
			reset
		end

	reset
		do
			reset_request

			has_error := False
			if attached internal_client_socket as l_sock then
				l_sock.cleanup
			end
			internal_client_socket := Void
		end

	reset_request
		do
			version := Void
			remote_info := Void

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
				create s.make_empty
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

	is_persistent_connection_supported: BOOLEAN
			-- Is persistent connection supported?
		do
			Result := {HTTPD_SERVER}.is_persistent_connection_supported
		end	

	persistent_connection_timeout: INTEGER = 5 -- seconds
			-- Number of seconds for persistent connection timeout.
			-- Default: 5 sec.

feature -- Status report

	has_error: BOOLEAN
			-- Error occurred during `analyze_request_message'

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
			l_exit: BOOLEAN
			n: INTEGER
		do
			l_socket := client_socket
			check
				socket_attached: l_socket /= Void
				socket_valid: l_socket.is_open_read and then l_socket.is_open_write
			end
			from
					-- Process persistent connection as long the socket is not closed.
				n := 0
			until
				l_exit
			loop
				n := n + 1
					-- FIXME: it seems to be called one more time, mostly to see this is done.
				execute_request
				l_exit := not is_persistent_connection_supported
						or has_error or l_socket.is_closed or not l_socket.is_open_read
						or not is_persistent_connection_requested
				reset_request
			end
		end

	execute_request
		require
			is_connected: is_connected
		local
			l_remote_info: detachable like remote_info
			l_socket: like client_socket
			l_is_ready: BOOLEAN
			i: INTEGER
		do
			l_socket := client_socket
			check
				socket_attached: l_socket /= Void
				socket_valid: l_socket.is_open_read and then l_socket.is_open_write
			end
			if l_socket.is_closed then
				debug ("dbglog")
					dbglog (generator + ".execute_request {socket is Closed!}")
				end
			else
				debug ("dbglog")
					dbglog (generator + ".execute_request  socket=" + l_socket.descriptor.out + " ENTER")
				end

					--| TODO: add configuration options for socket timeout.
					--| set by default 5 seconds.
--				l_socket.set_timeout (persistent_connection_timeout) -- 5 seconds!
				l_socket.set_timeout (1) -- 1 second!
				from
					i := persistent_connection_timeout -- * 1 sec
				until
					l_is_ready or i <= 0 or has_error
				loop
					l_is_ready := l_socket.ready_for_reading
					check not l_socket.is_closed end
					i := i - 1
				end

				if l_is_ready then
					create l_remote_info
					if attached l_socket.peer_address as l_addr then
						l_remote_info.addr := l_addr.host_address.host_address
						l_remote_info.hostname := l_addr.host_address.host_name
						l_remote_info.port := l_addr.port
						remote_info := l_remote_info
					end
            		analyze_request_message (l_socket)
            	else
					has_error := True
					debug ("dbglog")
						dbglog (generator + ".execute_request socket=" + l_socket.descriptor.out + "} timeout!")
	            	end
				end

	            if has_error then
					if l_is_ready then
	--					check catch_bad_incoming_connection: False end
						if is_verbose then
							log ("ERROR: invalid HTTP incoming request")
						end
					end
				else
					process_request (l_socket)
	            end
	            debug ("dbglog")
		            dbglog (generator + ".execute_request {" + l_socket.descriptor.out + "} LEAVE")
	            end
			end
		end

	release
		do
			reset
		end

feature -- Request processing

	process_request (a_socket: HTTPD_STREAM_SOCKET)
			-- Process request ...
		require
			no_error: not has_error
			a_uri_attached: uri /= Void
			a_method_attached: method /= Void
			a_header_map_attached: request_header_map /= Void
			a_header_text_attached: request_header /= Void
			a_socket_attached: a_socket /= Void
		deferred
		end

feature -- Parsing

	analyze_request_message (a_socket: HTTPD_STREAM_SOCKET)
			-- Analyze message extracted from `a_socket' as HTTP request
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
			if a_socket.is_readable and then attached next_line (a_socket) as l_request_line and then not l_request_line.is_empty then
				txt.append (l_request_line)
				txt.append_character ('%N')
				analyze_request_line (l_request_line)
			else
				has_error := True
			end
			l_is_verbose := is_verbose
			if not has_error or l_is_verbose then
					-- if `is_verbose' we can try to print the request, even if it is a bad HTTP request
				from
					line := next_line (a_socket)
				until
					line = Void or end_of_stream
				loop
					n := line.count
					if l_is_verbose then
						log (line)
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
					is_persistent_connection_requested := attached request_header_map.item ("Connection") as l_connection and then
								l_connection.is_case_insensitive_equal_general ("keep-alive")
				else
						-- By default HTTP:1/1 support persistent connection.
					if attached request_header_map.item ("Connection") as l_connection then
						if l_connection.is_case_insensitive_equal_general ("close") then
							is_persistent_connection_requested := False
						end
					else
						is_persistent_connection_requested := True
					end
				end
			end
		end

	analyze_request_line (line: STRING)
			-- Analyze `line' as a HTTP request line
		require
			valid_line: line /= Void and then not line.is_empty
		local
			n, pos, next_pos: INTEGER
		do
			if is_verbose then
				log ("%N## Parse HTTP request line ##")
				log (line)
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
			has_error := method.is_empty
		end

	next_line (a_socket: HTTPD_STREAM_SOCKET): detachable STRING
			-- Next line fetched from `a_socket' is available.
		require
			is_readable: a_socket.is_open_read
		local
			retried: BOOLEAN
		do
			if retried then
				Result := Void
			elseif a_socket.socket_ok then
				a_socket.read_line_thread_aware
				Result := a_socket.last_string
			end
		rescue
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

	log (m: STRING)
			-- Log message `m'.
		do
			if attached logger as l_logger then
				l_logger.log (m)
			else
				io.put_string (m + "%N")
			end
		end

invariant
	request_header_attached: request_header /= Void

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
