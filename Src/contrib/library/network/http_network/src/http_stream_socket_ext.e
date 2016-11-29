note
	description: "[
			Extension to HTTPD_STREAM_SOCKET to support backward compatibility.
			
			TO BE REMOVED IN THE FUTURE, WHEN 16.05 IS OLD.
		]"

deferred class
	HTTP_STREAM_SOCKET_EXT

feature -- Extension

	socket: HTTP_STREAM_SOCKET
			-- Associated socket.
			-- Used to extend HTTP_STREAM_SOCKET with Current interface.
		deferred
		end

feature -- No-Exception network operation

	put_file_content_with_timeout (a_file: FILE; a_offset: INTEGER; a_byte_count: INTEGER; a_timeout: INTEGER)
			-- Send `a_count' bytes from the content of file `a_file' starting at offset `a_offset'.
			-- When relevant, use the `a_timeout` to wait on completion (if a_timeout < 0, ignored)
		require
			a_file_closed_or_openread: a_file.exists and then (a_file.is_access_readable or a_file.is_closed)
			byte_count_positive: a_byte_count > 0
			extendible: socket.extendible
		local
			l_close_needed: BOOLEAN
			l_bytes_sent: INTEGER
			cs: C_STRING
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
				create cs.make (a_file.path.name)
				l_bytes_sent := c_sendfile (socket.descriptor, a_file.file_pointer, a_byte_count, a_timeout)
				if l_bytes_sent < 0 then
					socket.report_error ("Network error: sendfile")
				end
				socket.set_bytes_sent (l_bytes_sent)
				if l_close_needed then
					a_file.close
				end
			end
		ensure
			bytes_sent_updated: not socket.was_error implies (0 <= socket.bytes_sent and socket.bytes_sent <= a_byte_count)
		end

	put_file_content (a_file: FILE; a_offset: INTEGER; a_byte_count: INTEGER)
			-- Send `a_count' bytes from the content of file `a_file' starting at offset `a_offset'.
			-- When relevant, use the `a_timeout` to wait on completion (if a_timeout < 0, ignored)
		do
			put_file_content_with_timeout (a_file, a_offset, a_byte_count, -1)
		end

feature {NONE} -- External		

	c_sendfile (a_fd: INTEGER; fp: POINTER; len: INTEGER; a_timeout: INTEGER): INTEGER
			-- External routine to write file content from `fp` of
			-- length `len' to socket `a_fd'
			-- note: On Windows, due to asynchronous potential behavior, wait for completion using `timeout` value.
			--		EIF_INTEGER c_sendfile_noexception(EIF_INTEGER out_fd, FILE* f, EIF_INTEGER length, EIF_INTEGER timeout).
		external
			"C blocking"
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
