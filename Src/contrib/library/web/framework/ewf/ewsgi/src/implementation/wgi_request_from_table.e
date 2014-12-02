note
	description: "[
				Request created from a hash_table of meta variables
		]"
	specification: "EWSGI specification https://github.com/Eiffel-World/Eiffel-Web-Framework/wiki/EWSGI-specification"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_REQUEST_FROM_TABLE

inherit
	WGI_REQUEST

create
	make

feature {NONE} -- Initialization

	make (a_vars: HASH_TABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]; a_input: like input; a_wgi_connector: like wgi_connector)
		require
			vars_attached: a_vars /= Void
		do
			wgi_connector := a_wgi_connector
			input := a_input
			set_meta_variables (a_vars)
			update_path_info
			update_input
		end

	update_input
			-- Update input, depending on Transfer-Encoding value.
		do
			if
				attached http_transfer_encoding as l_transfer_encoding and then
				l_transfer_encoding.same_string (once "chunked")
			then
				is_chunked_input := True
				create {WGI_CHUNKED_INPUT_STREAM} input.make (input)
			end
		end

feature -- Access: Input

	is_chunked_input: BOOLEAN
			-- Is request using chunked transfer-encoding?

	input: WGI_INPUT_STREAM
			-- Server input channel
			--| Could be a chunked input as well

feature -- EWSGI access

	wgi_version: STRING = "0.1"

	wgi_implementation: STRING = "Eiffel Web Framework 0.1"

	wgi_connector: WGI_CONNECTOR

feature -- Access: CGI meta parameters

	meta_variables: STRING_TABLE [READABLE_STRING_8]
			-- CGI Environment parameters

	meta_variable (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- CGI meta variable related to `a_name'
		do
			Result := meta_variables.item (a_name)
		end

	meta_string_variable_or_default (a_name: READABLE_STRING_GENERAL; a_default: READABLE_STRING_8; use_default_when_empty: BOOLEAN): READABLE_STRING_8
			-- Value for meta parameter `a_name'
			-- If not found, return `a_default'
		require
			a_name_not_empty: a_name /= Void and then not a_name.is_empty
		do
			if attached meta_variable (a_name) as val then
				Result := val.string
				if use_default_when_empty and then Result.is_empty then
					Result := a_default
				end
			else
				Result := a_default
			end
		end

	set_meta_string_variable (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_8)
		do
			meta_variables.force (a_value, a_name)
		ensure
			param_set: attached meta_variable (a_name) as val and then val ~ a_value
		end

	unset_meta_variable (a_name: READABLE_STRING_GENERAL)
		do
			meta_variables.remove (a_name)
		ensure
			param_unset: meta_variable (a_name) = Void
		end

feature -- Access: CGI meta parameters - 1.1

	auth_type: detachable READABLE_STRING_8

	content_length: detachable READABLE_STRING_8

	content_type: detachable READABLE_STRING_8

	gateway_interface: READABLE_STRING_8
		do
			Result := meta_string_variable_or_default ({WGI_META_NAMES}.gateway_interface, "", False)
		end

	path_info: READABLE_STRING_8
			-- <Precursor/>
			--
			--| For instance, if the current script was accessed via the URL
			--| http://www.example.com/eiffel/path_info.exe/some/stuff?foo=bar, then $_SERVER['PATH_INFO'] would contain /some/stuff.
			--|
			--| Note that is the PATH_INFO variable does not exists, the `path_info' value will be empty

	path_translated: detachable READABLE_STRING_8
		do
			Result := meta_string_variable ({WGI_META_NAMES}.path_translated)
		end

	query_string: READABLE_STRING_8

	remote_addr: READABLE_STRING_8

	remote_host: READABLE_STRING_8

	remote_ident: detachable READABLE_STRING_8
		do
			Result := meta_string_variable ({WGI_META_NAMES}.remote_ident)
		end

	remote_user: detachable READABLE_STRING_8
		do
			Result := meta_string_variable ({WGI_META_NAMES}.remote_user)
		end

	request_method: READABLE_STRING_8

	script_name: READABLE_STRING_8

	server_name: READABLE_STRING_8

	server_port: INTEGER

	server_protocol: READABLE_STRING_8
		do
			Result := meta_string_variable_or_default ({WGI_META_NAMES}.server_protocol, "HTTP/1.0", True)
		end

	server_software: READABLE_STRING_8
		do
			Result := meta_string_variable_or_default ({WGI_META_NAMES}.server_software, "Unknown Server", True)
		end

feature -- Access: HTTP_* CGI meta parameters - 1.1

	http_accept: detachable READABLE_STRING_8
			-- Contents of the Accept: header from the current request, if there is one.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_accept)
		end

	http_accept_charset: detachable READABLE_STRING_8
			-- Contents of the Accept-Charset: header from the current request, if there is one.
			-- Example: 'iso-8859-1,*,utf-8'.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_accept_charset)
		end

	http_accept_encoding: detachable READABLE_STRING_8
			-- Contents of the Accept-Encoding: header from the current request, if there is one.
			-- Example: 'gzip'.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_accept_encoding)
		end

	http_accept_language: detachable READABLE_STRING_8
			-- Contents of the Accept-Language: header from the current request, if there is one.
			-- Example: 'en'.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_accept_language)
		end

	http_connection: detachable READABLE_STRING_8
			-- Contents of the Connection: header from the current request, if there is one.
			-- Example: 'Keep-Alive'.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_connection)
		end

	http_expect: detachable READABLE_STRING_8
			-- The Expect request-header field is used to indicate that particular server behaviors are required by the client.
			-- Example: '100-continue'.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_expect)
		end

	http_host: detachable READABLE_STRING_8
			-- Contents of the Host: header from the current request, if there is one.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_host)
		end

	http_referer: detachable READABLE_STRING_8
			-- The address of the page (if any) which referred the user agent to the current page.
			-- This is set by the user agent.
			-- Not all user agents will set this, and some provide the ability to modify HTTP_REFERER as a feature.
			-- In short, it cannot really be trusted.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_referer)
		end

	http_user_agent: detachable READABLE_STRING_8
			-- Contents of the User-Agent: header from the current request, if there is one.
			-- This is a string denoting the user agent being which is accessing the page.
			-- A typical example is: Mozilla/4.5 [en] (X11; U; Linux 2.2.9 i586).
			-- Among other things, you can use this value to tailor your page's
			-- output to the capabilities of the user agent.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_user_agent)
		end

	http_authorization: detachable READABLE_STRING_8
			-- Contents of the Authorization: header from the current request, if there is one.
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_authorization)
		end

	http_transfer_encoding: detachable READABLE_STRING_8
			-- Transfer-Encoding
			-- for instance chunked
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_transfer_encoding)
		end

	http_access_control_request_headers: detachable READABLE_STRING_8
			-- Indicates which headers will be used in the actual request
                        -- as part of the preflight request
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_access_control_request_headers)
		end

	http_if_match: detachable READABLE_STRING_8
			-- Existence check on resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_if_match)
		end

	http_if_modified_since: detachable READABLE_STRING_8
			-- Modification check on resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_if_modified_since)
		end

	http_if_none_match: detachable READABLE_STRING_8
			-- Existence check on resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_if_none_match)
		end

	http_if_range: detachable READABLE_STRING_8
			-- Range check on resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_if_range)
		end

	http_if_unmodified_since: detachable READABLE_STRING_8
			-- Modification check on resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_if_unmodified_since)
		end

	http_last_modified: detachable READABLE_STRING_8
			-- Modification time of resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_last_modified)
		end

	http_range: detachable READABLE_STRING_8
			-- Requested byte-range of resource
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_range)
		end
	
	http_content_range: detachable READABLE_STRING_8
			-- Partial range of selected representation enclosed in message payload
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_content_range)
		end

	http_content_encoding: detachable READABLE_STRING_8
			-- Encoding (usually compression) of message payload
		do
			Result := meta_string_variable ({WGI_META_NAMES}.http_content_encoding)
		end
	
	
feature -- Access: Extension to CGI meta parameters - 1.1

	request_uri: READABLE_STRING_8
			-- The URI which was given in order to access this page; for instance, '/index.html'.

	orig_path_info: detachable READABLE_STRING_8
			-- Original version of `path_info' before processed by Current environment

feature {NONE} -- Element change: CGI meta parameter related to PATH_INFO

	set_meta_variables (a_vars: HASH_TABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL])
			-- Fill with variable from `a_vars'
		local
			s: like meta_string_variable
			table: STRING_TABLE [READABLE_STRING_8]
			l_query_string: like query_string
			l_request_uri: detachable READABLE_STRING_8
			s8: STRING_8
			l_empty_string: like empty_string
			enc: PERCENT_ENCODER
			utf: UTF_CONVERTER
		do
			create {STRING_8} l_empty_string.make_empty
			empty_string := l_empty_string

			create table.make_equal (a_vars.count)
			meta_variables := table
			from
				a_vars.start
			until
				a_vars.after
			loop
				if attached {READABLE_STRING_32} a_vars.item_for_iteration as s32  then
					table.force (utf.utf_32_string_to_utf_8_string_8 (s32), a_vars.key_for_iteration)
				else
					table.force (a_vars.item_for_iteration.to_string_8, a_vars.key_for_iteration)
				end
				a_vars.forth
			end

				--| QUERY_STRING
			l_query_string := meta_string_variable_or_default ({WGI_META_NAMES}.query_string, l_empty_string, False)
			query_string := l_query_string

				--| REQUEST_METHOD
			request_method := meta_string_variable_or_default ({WGI_META_NAMES}.request_method, l_empty_string, False)

				--| CONTENT_TYPE
			s := meta_string_variable ({WGI_META_NAMES}.content_type)
			if s /= Void and then not s.is_empty then
				content_type := s
			else
				content_type := Void
			end

				--| CONTENT_LENGTH
			content_length := meta_string_variable ({WGI_META_NAMES}.content_length)

				--| PATH_INFO
			path_info := meta_string_variable_or_default ({WGI_META_NAMES}.path_info, l_empty_string, False)

				--| SERVER_NAME
			server_name := meta_string_variable_or_default ({WGI_META_NAMES}.server_name, l_empty_string, False)

				--| SERVER_PORT
			s := meta_string_variable ({WGI_META_NAMES}.server_port)
			if s /= Void and then s.is_integer then
				server_port := s.to_integer
			else
				server_port := 80
			end

				--| SCRIPT_NAME
			script_name := meta_string_variable_or_default ({WGI_META_NAMES}.script_name, l_empty_string, False)

				--| REMOTE_ADDR
			remote_addr := meta_string_variable_or_default ({WGI_META_NAMES}.remote_addr, l_empty_string, False)

				--| REMOTE_HOST
			remote_host := meta_string_variable_or_default ({WGI_META_NAMES}.remote_host, l_empty_string, False)

				--| REQUEST_URI
			s := meta_string_variable ({WGI_META_NAMES}.request_uri)
			if s /= Void then
				l_request_uri := s
			else
					--| REQUEST_URI is not always available, in this case,
					--| compute it from SCRIPT_NAME, PATH_INFO and QUERY_STRING which are required by CGI.
				create s8.make_from_string (script_name)
				create enc
				enc.append_partial_percent_encoded_string_to (utf.utf_8_string_8_to_string_32 (path_info), s8, <<'/', '!', '$', '&', '%'', '(', ')', '*', '+', ',', ';', '='>>)
				if not l_query_string.is_empty then
					 s8.append_character ('?')
					 s8.append (l_query_string)
				end
				l_request_uri := s8
			end
			set_meta_string_variable ({WGI_META_NAMES}.request_uri, l_request_uri)
			request_uri := l_request_uri
		end

	set_orig_path_info (s: READABLE_STRING_8)
			-- Set ORIG_PATH_INFO to `s'
		require
			s_attached: s /= Void
		do
			orig_path_info := s
			set_meta_string_variable ({WGI_META_NAMES}.orig_path_info, s)
		end

	unset_orig_path_info
			-- Unset ORIG_PATH_INFO
		do
			orig_path_info := Void
			unset_meta_variable ({WGI_META_NAMES}.orig_path_info)
		ensure
			unset: meta_variable ({WGI_META_NAMES}.orig_path_info) = Void
		end

	update_path_info
			-- Fix and update PATH_INFO value if needed
		local
			l_path_info: STRING
		do
			l_path_info := path_info

			--| Warning
			--| on IIS: we might have   PATH_INFO = /sample.exe/foo/bar
			--| on apache:				PATH_INFO = /foo/bar
			--| So, we might need to check with SCRIPT_NAME and remove it on IIS
			--| store original PATH_INFO in ORIG_PATH_INFO
			if l_path_info.is_empty then
				unset_orig_path_info
			else
				set_orig_path_info (l_path_info)
				if attached script_name as l_script_name then
					if l_path_info.starts_with (l_script_name) then
						path_info := l_path_info.substring (l_script_name.count + 1 , l_path_info.count)
					end
				end
			end
		end

feature {NONE} -- Implementation: utilities	

	has_white_space (s: READABLE_STRING_8): BOOLEAN
			-- `s' has white space?
		do
			Result := s.has (' ') or else s.has ('%T')
		end

	single_slash_starting_string (s: READABLE_STRING_8): STRING_8
			-- Return the string `s' (or twin) with one and only one starting slash
		local
			i, n: INTEGER
		do
			n := s.count
			if n > 1 then
				if s[1] /= '/' then
					create Result.make (1 + n)
					Result.append_character ('/')
					Result.append (s)
				elseif s[2] = '/' then
					--| We need to remove all starting slash, except one
					from
						i := 3
					until
						i > n
					loop
						if s[i] /= '/' then
							n := 0 --| exit loop
						else
							i := i + 1
						end
					end
					n := s.count
					check i >= 2 and i <= n end
					Result := s.substring (i - 1, s.count)
				else
					--| starts with one '/' and only one		
					Result := s
				end
			elseif n = 1 then
				if s[1] = '/' then
					Result := s
				else
					create Result.make (2)
					Result.append_character ('/')
					Result.append (s)
				end
			else --| n = 0
				create Result.make_filled ('/', 1)
			end
		ensure
			one_starting_slash: Result[1] = '/' and (Result.count = 1 or else Result[2] /= '/')
		end

	empty_string: READABLE_STRING_8
			-- Reusable empty string

invariant
	empty_string_unchanged: empty_string.is_empty

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
