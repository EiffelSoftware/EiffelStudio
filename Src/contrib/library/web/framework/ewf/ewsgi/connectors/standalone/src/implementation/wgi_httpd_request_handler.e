note
	description: "[
			WGI implementation of HTTPD_REQUEST_HANDLER, will process the incoming connection
			 and extract information on the request and the server
			 ]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_HTTPD_REQUEST_HANDLER [G -> WGI_EXECUTION create make end]

inherit
	HTTPD_REQUEST_HANDLER

	WGI_EXPORTER

	REFACTORING_HELPER

	SHARED_HTML_ENCODER

create
	make,
	make_with_connector

feature {NONE} -- Initialization

	make_with_connector (conn: like connector)
		do
			make
			connector := conn
--			if conn /= Void then
--				set_is_verbose (is_connector_verbose (conn))
--			end
		end

feature -- Access		

	connector: detachable separate WGI_STANDALONE_CONNECTOR [G]
			-- httpd solution.

	base: detachable IMMUTABLE_STRING_8
			-- Root url base.
		do
			if attached connector as conn then
				if attached connector_base (conn) as l_base then
					create Result.make_from_separate (l_base)
				end
			end
		end

feature -- SCOOP helpers		

	connector_base (conn: separate WGI_STANDALONE_CONNECTOR [G]): detachable separate READABLE_STRING_8
			-- Rool url based from a connector `conn'.
		do
			Result := conn.base
		end

	is_connector_verbose (conn: separate WGI_STANDALONE_CONNECTOR [G]): BOOLEAN
		do
			Result := conn.is_verbose
		end

feature -- Request processing

	process_request (a_socket: HTTPD_STREAM_SOCKET)
			-- Process request ...
		local
			l_input: WGI_INPUT_STREAM
			l_output: detachable WGI_OUTPUT_STREAM
			l_error: WGI_ERROR_STREAM
			req: WGI_REQUEST_FROM_TABLE
			res: detachable WGI_STANDALONE_RESPONSE_STREAM
			exec: detachable WGI_EXECUTION
			retried: BOOLEAN
		do
			if not retried then
				create {WGI_STANDALONE_INPUT_STREAM} l_input.make (a_socket)
				create {WGI_STANDALONE_OUTPUT_STREAM} l_output.make (a_socket)
				create {WGI_STANDALONE_ERROR_STREAM} l_error.make_stderr (a_socket.descriptor.out)

				create req.make (httpd_environment (a_socket), l_input, connector)
				create res.make (l_output, l_error)
				if is_http_version_1_0 then
					l_output.set_http_version ({HTTP_CONSTANTS}.http_version_1_0)
					res.set_http_version_1_0
				else
					l_output.set_http_version (version)
				end
				res.set_is_persistent_connection_requested (is_persistent_connection_requested)

				req.set_meta_string_variable ("RAW_HEADER_DATA", request_header)

				create {G} exec.make (req, res)
				exec.execute
				res.push
				exec.clean
			else
				if not has_error then
					process_rescue (res)
				end
				if exec /= Void then
					exec.clean
				end
			end
		rescue
			has_error := l_output = Void or else not l_output.is_available
			if not retried then
				retried := True
				retry
			end
		end

	process_rescue (res: detachable WGI_RESPONSE)
		do
			if attached (create {EXCEPTION_MANAGER}).last_exception as e and then attached e.trace as l_trace then
				if res /= Void then
					if not res.status_is_set then
						res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error, Void)
					end
					if res.message_writable then
						res.put_string ("<pre>")
						res.put_string (html_encoder.encoded_string (l_trace))
						res.put_string ("</pre>")
					end
					res.push
				end
			end
		end

	httpd_environment (a_socket: HTTPD_STREAM_SOCKET): STRING_TABLE [READABLE_STRING_8]
		local
			p: INTEGER
			l_request_uri, l_script_name, l_query_string, l_path_info: STRING
			l_server_name, l_server_port: detachable STRING
			l_headers_map: HASH_TABLE [STRING, STRING]
			l_base: detachable READABLE_STRING_8
			vn: STRING

			e: EXECUTION_ENVIRONMENT
			enc: URL_ENCODER
			utf: UTF_CONVERTER
		do
			l_request_uri := uri
			l_headers_map := request_header_map
			create e
			create enc
			if attached e.starting_environment as vars then
				create Result.make_equal (vars.count)
				across
					vars as c
				loop
					Result.force (utf.utf_32_string_to_utf_8_string_8 (c.item), utf.utf_32_string_to_utf_8_string_8 (c.key))
				end
			else
				create Result.make (0)
			end

				--| for Any Abc-Def-Ghi add (or replace) the HTTP_ABC_DEF_GHI variable to `Result'
			from
				l_headers_map.start
			until
				l_headers_map.after
			loop
				create vn.make_from_string (l_headers_map.key_for_iteration.as_upper)
				vn.replace_substring_all ("-", "_")
				if
					vn.starts_with ("CONTENT_") and then
					(vn.same_string_general ({WGI_META_NAMES}.content_type) or vn.same_string_general ({WGI_META_NAMES}.content_length))
				then
					--| Keep this name
				else
					vn.prepend ("HTTP_")
				end
				add_environment_variable (l_headers_map.item_for_iteration, vn, Result)
				l_headers_map.forth
			end

			--| Specific cases

			p := l_request_uri.index_of ('?', 1)
			if p > 0 then
				l_script_name := l_request_uri.substring (1, p - 1)
				l_query_string := l_request_uri.substring (p + 1, l_request_uri.count)
			else
				l_script_name := l_request_uri.string
				l_query_string := ""
			end
			if attached l_headers_map.item ("Host") as l_host then
				check has_host: Result.has ("HTTP_HOST") end
--				set_environment_variable (l_host, "HTTP_HOST", Result)
				p := l_host.index_of (':', 1)
				if p > 0 then
					l_server_name := l_host.substring (1, p - 1)
					l_server_port := l_host.substring (p+1, l_host.count)
				else
					l_server_name := l_host
					l_server_port := "80" -- Default
				end
			else
				check host_available: False end
			end

			if attached l_headers_map.item ("Authorization") as l_authorization then
				check has_authorization: Result.has ("HTTP_AUTHORIZATION") end
--				set_environment_variable (l_authorization, "HTTP_AUTHORIZATION", Result)
				p := l_authorization.index_of (' ', 1)
				if p > 0 then
					set_environment_variable (l_authorization.substring (1, p - 1), "AUTH_TYPE", Result)
				end
			end

			set_environment_variable ("CGI/1.1", "GATEWAY_INTERFACE", Result)
			set_environment_variable (l_query_string, "QUERY_STRING", Result)

			if attached remote_info as l_remote_info then
				set_environment_variable (l_remote_info.addr, "REMOTE_ADDR", Result)
				set_environment_variable (l_remote_info.hostname, "REMOTE_HOST", Result)
				set_environment_variable (l_remote_info.port.out, "REMOTE_PORT", Result)
--				set_environment_variable (Void, "REMOTE_IDENT", Result)
--				set_environment_variable (Void, "REMOTE_USER", Result)			
			end

			set_environment_variable (l_request_uri, "REQUEST_URI", Result)
			set_environment_variable (method, "REQUEST_METHOD", Result)

			set_environment_variable (l_script_name, "SCRIPT_NAME", Result)
			set_environment_variable (l_server_name, "SERVER_NAME", Result)
			set_environment_variable (l_server_port, "SERVER_PORT", Result)
			set_environment_variable (version, "SERVER_PROTOCOL", Result)
			set_environment_variable ({HTTPD_CONFIGURATION}.Server_details, "SERVER_SOFTWARE", Result)

				--| Apply `base' value
			l_base := base
			if l_base = Void then
				l_base := ""
			end
			if l_request_uri /= Void then
				if l_request_uri.starts_with (l_base) then
					l_path_info := l_request_uri.substring (l_base.count + 1, l_request_uri.count)
					p := l_path_info.index_of ('?', 1)
					if p > 0 then
						l_path_info.keep_head (p - 1)
					end
					Result.force (l_base, "SCRIPT_NAME")
				else
						-- This should not happen, this means the `base' is not correctly set.
						-- It is better to consider base as empty, rather than having empty PATH_INFO
					check valid_base_value: False end

					l_path_info := l_request_uri
					p := l_request_uri.index_of ('?', 1)
					if p > 0 then
						l_path_info := l_request_uri.substring (1, p - 1)
					else
						l_path_info := l_request_uri.string
					end
					Result.force ("", "SCRIPT_NAME")
				end
					--| In order to have same path value for PATH_INFO on various connectors and servers
					--| the multiple slashes must be stripped to single slash.
					--| tested with: CGI+apache, libfcgi+apache on Windows and Linux
					--|
					--| For example: "////abc/def///end////" to "/abc/def/end/" ?
				convert_multiple_slashes_to_single (l_path_info)
				Result.force (enc.decoded_utf_8_string (l_path_info), "PATH_INFO")
			end
		end

	add_environment_variable (a_value: detachable STRING; a_var_name: READABLE_STRING_GENERAL; env: STRING_TABLE [READABLE_STRING_8])
			-- Add variable `a_var_name => a_value' to `env'
		do
			if a_value /= Void then
				if env.has_key (a_var_name) and then attached env.found_item as l_existing_value then
						--| Check http://www.ietf.org/rfc/rfc3875 4.1.18
					check find_proper_rewrite_for_same_header: False end
					env.force (l_existing_value + " " + a_value, a_var_name)
				else
					env.force (a_value, a_var_name)
				end
			end
		end

	set_environment_variable (a_value: detachable STRING; a_var_name: READABLE_STRING_GENERAL; env: STRING_TABLE [READABLE_STRING_8])
			-- Add variable `a_var_name => a_value' to `env'
		do
			if a_value /= Void then
				env.force (a_value, a_var_name)
			end
		end

feature {NONE} -- Implementation

	convert_multiple_slashes_to_single (s: STRING_8)
			-- Replace multiple slashes sequence by a single slash character.
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := s.count
			until
				i > n
			loop
				if s[i] = '/' then
						-- Remove following slashes '/'.
					from
						i := i + 1
					until
						i > n or s[i] /= '/'
					loop
						s.remove (i)
						n := n - 1
					end
				else
					i := i + 1
				end
			end
		end



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
