note
	description: "[
			Extension to HTTPD_STREAM_SOCKET to support backward compatibility.
			
			TO BE REMOVED IN THE FUTURE, WHEN 17.01 IS OLD.
		]"

deferred class
	HTTP_STREAM_SOCKET_EXT

feature -- Access

	socket_buffer: MANAGED_POINTER
		deferred
		end

	read_socket_buffer: MANAGED_POINTER
		do
			Result := socket_buffer
		end

	put_socket_buffer: MANAGED_POINTER
		do
			Result := socket_buffer
		end

feature {NONE} -- No-Exception network operation

end
