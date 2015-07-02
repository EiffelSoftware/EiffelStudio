note
	description: "[
			WGI Response implemented using stream buffer
			for the standalone Eiffel web server connector.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_STANDALONE_RESPONSE_STREAM

inherit
	WGI_RESPONSE_STREAM
		redefine
			put_header_text
		end

create
	make

feature -- Settings

	is_http_version_1_0: BOOLEAN
			-- Is associated request using HTTP/1.0 ?

	is_persistent_connection_supported: BOOLEAN
			-- Is persistent connection supported?

	is_persistent_connection_requested: BOOLEAN
			-- Is persistent connection requested?

feature -- Settings change

	set_http_version_1_0
			-- Set associated request is using HTTP/1.0.
		do
			is_http_version_1_0 := True
		end

	set_is_persistent_connection_supported (b: BOOLEAN)
			-- Set `is_persistent_connection_supported' to `b'.
		do
			is_persistent_connection_supported := b
		end

	set_is_persistent_connection_requested (b: BOOLEAN)
			-- Set `is_persistent_connection_requested' to `b'.
		do
			is_persistent_connection_requested := b
		end

feature -- Header output operation

	put_header_text (a_text: READABLE_STRING_8)
		local
			o: like output
			l_connection: detachable STRING
			s: STRING
			i,j: INTEGER
		do
			o := output
			create s.make_from_string (a_text)

			i := s.substring_index ("%NConnection:", 1)
			if is_persistent_connection_supported then
					-- Current standalone support persistent connection.
					-- If HTTP/1.1:
					--		by default all connection are persistent
					--			then no need to return "Connection:" header
					--		unless header has "Connection: close"
					--			then return "Connection: close"
					-- If HTTP/1.0:
					--		by default, connection is not persistent
					--		unless header has "Connection: keep-alive"
					--			then return "Connection: keep-alive"
					--		if header has "Connection: Close"
					--			then return "Connection: close"					
				if is_persistent_connection_requested then
					if is_http_version_1_0 then
						if i = 0 then
								-- Existing response header does not has "Connection: " header.
							s.append ("Connection: keep-alive")
							s.append (o.crlf)
						else
								-- Do not override the application decision.
						end
					end
				else
						-- If HTTP/1.1 and persistent connection is not requested,
						-- then return "close"
					if i = 0 and not is_http_version_1_0 then
							-- Existing response header does not has "Connection: " header.
						s.append ("Connection: close")
						s.append (o.crlf)
					else
							-- Do not override the application decision.
					end
				end
			else
					-- persistent connection support is disabled.
					-- Return "Connection: close" in any case.
					-- Except for HTTP/1.0 since not required.
				if i > 0 then
					j := s.index_of ('%R', i + 12)
				end
				if j > 0 then
							-- Replace existing "Connection:" header with "Connection: close"
					l_connection := s.substring (i + 12, j - 1)
					l_connection.adjust
					if
						not is_http_version_1_0 and
						not l_connection.is_case_insensitive_equal_general ("close")
					then
						s.replace_substring ("Connection: close", i + 1, j - 1)
					end
				elseif not is_http_version_1_0 then
						-- HTTP/1.1: always return "close" since persistent connection is not supported.
					s.append ("Connection: close")
					s.append (o.crlf)
				elseif is_persistent_connection_requested then
						-- For HTTP/1.0, return "Connection: close", only if client sent a "Connection: keep-alive"
					s.append ("Connection: close")
					s.append (o.crlf)
				end
			end

				-- end of headers
			s.append (o.crlf)

			o.put_string (s)

			header_committed := True
		end

;note
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
