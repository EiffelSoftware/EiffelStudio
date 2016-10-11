note
	description: "[
			Extension to HTTPD_STREAM_SOCKET to support backward compatibility.
			
			TO BE REMOVED IN THE FUTURE, WHEN 16.05 IS OLD.
		]"

deferred class
	HTTPD_STREAM_SSL_SOCKET_EXT

feature {NONE} -- SSL bridge

	ssl_write (a_ssl: SSL; a_pointer: POINTER; a_byte_count: INTEGER): INTEGER
		do
			Result := a_ssl.write (a_pointer, a_byte_count)
			if a_ssl.was_error then
				if Result >= 0 then
					Result := -1
				end
			end
		end

end
