note
	description : "[
			Objects that represents the output stream
		]"
	specification: "EWSGI/connector specification https://github.com/Eiffel-World/Eiffel-Web-Framework/wiki/EWSGI-specification"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WGI_OUTPUT_STREAM

feature -- Output

	put_string (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		require
			is_open_write: is_open_write
			a_string_not_void: a_string /= Void
		deferred
		end

	put_substring (a_string: READABLE_STRING_8; s, e: INTEGER)
			-- Write substring of `a_string' between indexes
			-- `s' and `e' to output stream.
			--| Could be redefined for optimization			
		require
			is_open_write: is_open_write
			a_string_not_void: a_string /= Void
			s_large_enough: s >= 1
			e_small_enough: e <= a_string.count
			valid_interval: s <= e + 1
		do
			if s <= e then
				put_string (a_string.substring (s, e))
			end
		end

	put_file_content (a_file: FILE; a_offset: INTEGER; a_byte_count: INTEGER)
			-- Send `a_byte_count' bytes from the content of file `a_file' starting at offset `a_offset'.
			--| Could be redefined for optimization.
		require
			a_file_closed_or_openread: a_file.exists and then (a_file.is_access_readable or a_file.is_closed)
			is_open_write: is_open_write
			a_file_not_void: a_file /= Void
		local
			l_close_needed: BOOLEAN
			l_remain: INTEGER
			l_done: BOOLEAN
			s: STRING
		do
			if a_file.exists and then a_file.is_access_readable then
				if a_file.is_open_read then
					l_close_needed := False
				else
					l_close_needed := True
					a_file.open_read
				end
				if a_offset > 0 then
					a_file.move (a_offset)
				end
				from
					l_remain := a_byte_count
					l_done := False
				until
					a_file.exhausted or l_done
				loop
					a_file.read_stream (l_remain.min (4_096))
					s := a_file.last_string
					if s.is_empty then
							-- network error?
						l_done := True
					else
						put_string (s)
						l_remain := l_remain - s.count
						check l_remain >= 0 end
						l_done := l_remain = 0
					end
				end
				if l_close_needed then
					a_file.close
				end
			end			
		end

	put_character (c: CHARACTER_8)
			-- Write `c' to output stream.
			--| Could be redefined for optimization			
		require
			is_open_write: is_open_write
		deferred
		end

feature -- Specific output

	put_header_line (s: READABLE_STRING_8)
			-- Send `s' to http client as header line
		do
			put_string (s)
			put_crlf
		end

	put_crlf
			-- Send "%R%N" string
		do
			put_string (crlf)
		end

feature -- Status writing

	put_status_line (a_code: INTEGER; a_reason_phrase: detachable READABLE_STRING_8)
			-- Put status code line for `a_code'
			-- with custom `a_reason_phrase' if precised
			--| Note this is a default implementation, and could be redefined
			--| for instance in relation to NPH CGI script
		require
			a_code_positive: a_code > 0
		deferred
		end

feature -- Status report

	http_version: detachable READABLE_STRING_8
			-- Optional HTTP version.

	is_available: BOOLEAN
			-- Is output available?
			--| i.e: no issue with associated output stream, like closed socket, or related?
		deferred
		end

	is_open_write: BOOLEAN
			-- Can items be written to output stream?
		deferred
		end

feature -- Element change

	set_http_version (v: like http_version)
			-- Set `http_version' to `v'.
		require
			valid_version: v /= Void implies v.starts_with ("HTTP/")
		do
			http_version := v
		end

feature -- Basic operations

	flush
			-- Flush buffered data to disk.
		require
			is_open_write: is_open_write
		deferred
		end

feature -- Constant

	crlf: STRING = "%R%N"

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
