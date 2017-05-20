note
	description: "[
			Extension to HTTP_STREAM_SOCKET to support backward compatibility.
			
			TO BE REMOVED IN THE FUTURE, WHEN 16.05 IS OLD.
		]"

deferred class
	HTTP_STREAM_SECURE_SOCKET_EXT

feature {NONE} -- SSL bridge

	ssl_write (a_ssl: SSL; a_pointer: POINTER; a_byte_count: INTEGER): INTEGER
		do
				-- In delivery until 16.05
				-- SSL.write does not return any value!
				-- So let's use `c_ssl_write' from Current class
				-- instead of:
				--		a_ssl.write (a_pointer, a_byte_count)

			Result := c_ssl_write (a_ssl.ptr, a_pointer, a_byte_count)
			if a_ssl.was_error then
					-- Until 16.05, there is no error check for `SSL.write'
					-- so nothing can be done here.

				if Result >= 0 then
					Result := -1
				end
			end
		end

	c_ssl_write (an_ssl_ptr: POINTER; buffer: POINTER; nb_bytes: INTEGER_32): INTEGER_32
			-- External call to SSL_write
			-- (export status {NONE})
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_write"
		end

end
