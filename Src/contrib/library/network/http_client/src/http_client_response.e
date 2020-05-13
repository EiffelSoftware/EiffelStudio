note
	description : "[
			Response retrieved by the client
		]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HTTP_CLIENT_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_url: READABLE_STRING_8)
			-- Initialize `Current'.
		do
				--| Default values
			status := 200
			create url.make_from_string (a_url)
			create {STRING_8} raw_header.make_empty
		end

feature -- Status

	error_occurred: BOOLEAN
			-- Error occurred during request

	error_message: detachable READABLE_STRING_8

feature {HTTP_CLIENT_REQUEST} -- Status setting

	set_error_occurred (b: BOOLEAN)
			-- Set `error_occurred' to `b'
		do
			error_occurred := b
		end

	set_error_message (m: READABLE_STRING_8)
			-- Set `error_message' to `m'
		do
			set_error_occurred (True)
			error_message := m
		end

feature -- Access

	url: IMMUTABLE_STRING_8
			-- URL associated with Current response

	status: INTEGER assign set_status
			-- Status code of the response.

	status_line: detachable READABLE_STRING_8

	http_version: detachable READABLE_STRING_8
			-- http version associated with `status_line'.

	raw_header: READABLE_STRING_8
			-- Raw http header of the response.	

	redirections: detachable ARRAYED_LIST [TUPLE [status_line: detachable READABLE_STRING_8; raw_header: READABLE_STRING_8; body: detachable READABLE_STRING_8]]
			-- Header of previous redirection if any.

	redirections_count: INTEGER
			-- Number of redirections.
		do
			if attached redirections as lst then
				Result := lst.count
			end
		end

	header (a_name: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Header entry value related to `a_name'
			-- if multiple entries, just concatenate them using comma character
			--| See: http://www.w3.org/Protocols/rfc2616/rfc2616-sec4.html
			--| Multiple message-header fields with the same field-name MAY be present in a message
			--| if and only if the entire field-value for that header field is defined as a comma-separated list [i.e., #(values)].
			--| It MUST be possible to combine the multiple header fields into one "field-name: field-value" pair,
			--| without changing the semantics of the message, by appending each subsequent field-value to the first, each separated by a comma.
			--| The order in which header fields with the same field-name are received is therefore significant
			--| to the interpretation of the combined field value, and thus a proxy MUST NOT change the order of
			--| these field values when a message is forwarded.			
		local
			s: detachable STRING_8
			k,v: READABLE_STRING_8
		do
			across
				headers as hds
			loop
				k := hds.item.name
				if k.same_string (a_name) then
					v := hds.item.value
					if s = Void then
						create s.make_from_string (v)
					else
						s.append_character (',')
						s.append (v)
					end
				end
			end
			Result := s
		end

	multiple_header (a_name: READABLE_STRING_8): detachable LIST [READABLE_STRING_8]
			-- Header multiple entries related to `a_name'
		local
			k: READABLE_STRING_8
		do
			across
				headers as hds
			loop
				k := hds.item.name
				if k.same_string (a_name) then
					if Result = Void then
						create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (1)
					end
					Result.force (hds.item.value)
				end
			end
		end

	headers: LIST [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]
			-- Computed table of http headers of the response.
			--| We use a LIST since one might have multiple message-header fields with the same field-name
			--| Then the user can handle those case using default or custom concatenation
			--| (note: `header' is concatenating using comma)
		local
			tb: like internal_headers
			pos, l_start, l_end, n, c: INTEGER
			h: like raw_header
			k: STRING_8
		do
			tb := internal_headers
			if tb = Void then
				create tb.make (3)
				h := raw_header
				from
					pos := 1
					n := h.count
				until
					pos = 0 or pos > n
				loop
					l_start := pos
						--| Left justify
					from until not h [l_start].is_space loop
						l_start := l_start + 1
					end
					pos := h.index_of ('%N', l_start)
					if pos > 0 then
						l_end := pos - 1
					elseif l_start < n then
						l_end := n + 1
					else
							-- Empty line
						l_end := 0
					end
					if l_end > 0 then
							--| Right justify
						from until not h [l_end].is_space loop
							l_end := l_end - 1
						end
						c := h.index_of (':', l_start)
						if c > 0 then
							k := h.substring (l_start, c - 1).to_string_8
							k.right_adjust
							c := c + 1
							from until c <= n and not h[c].is_space loop
								c := c + 1
							end
							tb.force ([k, h.substring (c, l_end)])
						else
							check header_has_colon: c > 0 end
						end
					end
					pos := pos + 1
				end
				internal_headers := tb
			end
			Result := tb
		end

	body: detachable READABLE_STRING_8 assign set_body
			-- Content of the response

	response_message_source (a_include_redirection: BOOLEAN): STRING_8
			-- Full message source including redirection if any
		do
			create Result.make (1_024)
			if
				a_include_redirection and then
				attached redirections as lst
			then
				across
					lst as c
				loop
					if attached c.item.status_line as s then
						Result.append (s)
						Result.append ("%R%N")
					end
					Result.append (c.item.raw_header)
					Result.append ("%R%N")
					if attached c.item.body as l_body then
						Result.append (l_body)
					end
				end
			end
			if attached status_line as s then
				Result.append (s)
				Result.append ("%R%N")
			end
			Result.append (raw_header)
			Result.append ("%R%N")
			if attached body as l_body then
				Result.append (l_body)
			end
		end

feature -- Status report

	is_http_1_0: BOOLEAN
			-- Is response using HTTP/1.0 protocole?
			--| Note: it is relevant once the raw header are set.		
		do
			Result := attached http_version as v and then v.same_string ("1.0")
		end

	is_http_1_1: BOOLEAN
			-- Is response using HTTP/1.1 protocole?
			--| Note: it is relevant once the raw header are set.		
		do
			Result := attached http_version as v and then v.same_string ("1.1")
		end

feature -- Change

	set_http_version (v: like http_version)
			-- Set `http_version' to `v'.
		do
			http_version := v
		end

	set_status (s: INTEGER)
			-- Set response `status' code to `s'
		do
			status := s
		end

	set_status_line (a_line: detachable READABLE_STRING_8)
			-- Set status line to `a_line',
			-- and also `status' extracted from `a_line' if possible.
		local
			i,j: INTEGER
			s: READABLE_STRING_8
		do
			status_line := a_line
			http_version := Void

			if a_line /= Void then
				if a_line.starts_with ("HTTP/") then
					i := a_line.index_of (' ', 1)
					if i > 0 then
						http_version := a_line.substring (1 + 5, i - 1) -- ("HTTP/").count = 5
						i := i + 1
					end
				else
					i := 1
				end
					-- Get status code token.
				if i > 0 then
					j := a_line.index_of (' ', i)
					if j > i then
						s := a_line.substring (i, j - 1)
						if s.is_integer then
							set_status (s.to_integer)
						end
					end
				end
			end
		end

	set_response_message (a_source: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT)
			-- Parse `a_source' response message
			-- and set `status_line', `status', `header' and `body'.
			--| ctx is the context associated with the request
			--| it might be useful to deal with redirection customization...
		local
			i, j, pos: INTEGER
			l_has_location: BOOLEAN
			l_content_length: INTEGER
			s: READABLE_STRING_8
			l_status_line,h: detachable READABLE_STRING_8
		do
			from
				i := 1
				j := 1
				pos := 1

				i := a_source.substring_index ("%R%N", i)
			until
				i = 0 or i > a_source.count
			loop
				s := a_source.substring (j, i - 1)
				if s.starts_with ("HTTP/") then
					--| Skip first line which is the status line
					--| ex: HTTP/1.1 200 OK%R%N
					j := i + 2
					l_status_line := s
					pos := j
				elseif s.is_empty then
					-- End of header  %R%N%R%N
					if attached raw_header as l_raw_header and then not l_raw_header.is_empty then
						add_redirection (status_line, l_raw_header, body)
					end

					h := a_source.substring (pos, i - 1)

					j := i + 2
					pos := j
					set_status_line (l_status_line)
					set_raw_header (h)

--					libcURL does not cache redirection content.
--					FIXME: check if this is customizable
--					if l_has_location then
--						if l_content_length > 0 then
--							j := pos + l_content_length - 1
--							l_body := a_source.substring (pos, j)
--							pos := j
--						else
--							l_body := Void
--						end
--						set_body (l_body)
--					end
					if not l_has_location then
						i := 0 -- exit loop
					end
					l_content_length := 0
					l_status_line := Void
					l_has_location := False
				else
					if s.starts_with ("Location:") then
						l_has_location := True
					elseif s.starts_with ("Content-Length:") then
						s := s.substring (16, s.count)
						if s.is_integer then
							l_content_length := s.to_integer
						end
					end
					j := i + 2
				end
				if i > 0 then
					i := a_source.substring_index ("%R%N", j)
				end
			end
			set_body (a_source.substring (pos, a_source.count))
		ensure
			parsed: response_message_source (True).count = a_source.count
		end

	set_raw_header (h: READABLE_STRING_8)
			-- Set http header `raw_header' to `h'
		local
			i: INTEGER
			rs: READABLE_STRING_8
			s: STRING_8
		do
			raw_header := h
				--| Reset internal headers
			internal_headers := Void

				--| Set status line, right away.
			i := h.index_of ('%N', 1)
			if i > 0 then
				rs := h.substring (1, i - 1)
				if rs.starts_with ("HTTP/") then
					s := rs.to_string_8
					s.right_adjust
					set_status_line (s)
				end
			end
		end

	add_redirection (s: detachable READABLE_STRING_8; h: READABLE_STRING_8; a_body: detachable READABLE_STRING_8)
			-- Add redirection with status line `s' and raw header `h' and body `a_body' if any
		local
			lst: like redirections
		do
			lst := redirections
			if lst = Void then
				create lst.make (1)
				redirections := lst
			end
			lst.force ([s,h, a_body])
		end

	set_body (s: like body)
			-- Set `body' message to `s'
		do
			body := s
		end

feature {NONE} -- Implementation

	internal_headers: detachable ARRAYED_LIST [TUPLE [key: READABLE_STRING_8; value: READABLE_STRING_8]]
			-- Internal cached value for the headers			

;note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
