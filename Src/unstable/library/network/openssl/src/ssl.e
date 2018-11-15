note
	description: "SSL context"
	legal: "See notice at end of class"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL

inherit
	SSL_SHARED

create
	make_from_context,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_context (a_ctx_ptr: POINTER)
			-- Create an SSL structure from the given `a_ctx_ptr'
		require
			a_ctx_ptr_valid: a_ctx_ptr /= default_pointer
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl
			ptr := c_ssl_new (a_ctx_ptr)
		end

	make_from_pointer (a_ptr: POINTER)
			-- Create an SSL structure from the given `a_ptr' pointer.
		require
			a_ptr_valid: a_ptr /= default_pointer
		do
			ptr := a_ptr
			connected := True
		ensure
			is_connected: connected
		end

feature -- Access

	accept
			-- Accept the SSL Socket.
		local
			err: INTEGER
			ssl_err: INTEGER_64
			l_string: STRING
		do
			err := c_ssl_accept (ptr)
			ssl_error_number := err
			debug ("ssl")
				io.error.putstring ("c_ssl_accept returned ")
				io.error.putint (err)
				io.error.putstring ("%N")
			end
			if err = -1 then
				ssl_err := c_err_get_error
				create l_string.make_from_c (c_err_error_string (ssl_err, default_pointer.item))
				debug ("ssl")
					io.error.putstring ("Reason: " + l_string + "%N")
				end
				ssl_socket_error := l_string
				connected := False
			elseif err = 0 then
				ssl_err := c_err_get_error
				create l_string.make_from_c (c_err_error_string (ssl_err, default_pointer.item))
				ssl_socket_error := l_string
				debug ("ssl")
					io.error.putstring ("Reason: " + l_string + "%N")
				end
				connected := False
			else
				connected := True
			end
		end

	connect
			-- Connect the SSL Socket.
		local
			err: INTEGER
			ssl_err: INTEGER_64
			l_string: STRING
		do
			err := c_ssl_connect (ptr)
			ssl_error_number := err
			debug ("ssl")
				io.error.putstring ("c_ssl_connect returned ")
				io.error.putint (err)
				io.error.putstring ("%N")
			end
			if err = -1 then
				ssl_err := c_err_get_error
				create l_string.make_from_c (c_err_error_string (ssl_err, default_pointer.item))
				ssl_socket_error := l_string
				debug ("ssl")
					io.error.putstring ("Reason: " + l_string + "%N")
				end
				connected := False
			elseif err = 0 then
				ssl_err := c_err_get_error
				create l_string.make_from_c (c_err_error_string (ssl_err, default_pointer.item))
				ssl_socket_error := l_string
				debug ("ssl")
					io.error.putstring ("Reason: " + l_string + "%N")
				end
				connected := False
			else
				connected := True
			end
		end

	free
			-- Free the underlying SSL Structure.
		do
			c_ssl_free (ptr)
		end

	set_fd (an_fd: INTEGER)
			-- Set the SSL Socket File Descriptor to `an_fd'.
		do
			c_ssl_set_fd (ptr, an_fd)
		end

	shutdown
			-- Shutdown the SSL Socket.
		do
			c_ssl_shutdown (ptr)
		end

	context_pointer: POINTER
			-- Get ssl context from the current ssl structure pointer
		do
			Result := c_ssl_get_ctx (ptr)
		end

feature -- Input

	read (a_pointer: POINTER; nb_bytes: INTEGER): INTEGER
			-- Read at most `nb_bytes' into `a_pointer' from this SSL socket
		do
			Result := c_ssl_read (ptr, a_pointer, nb_bytes)
		end

feature -- Output

	write (a_pointer: POINTER; nb_bytes: INTEGER): INTEGER
			-- Write the first `nb_bytes' from `a_pointer' onto this SSL socket
		do
			Result := c_ssl_write (ptr, a_pointer, nb_bytes)
			if Result < 0 then
				ssl_socket_error := "No all bytes sent!"
			end
		end

feature -- Status Report

	connected: BOOLEAN
			-- Is the underlying SSL Socket connected?

	was_error: BOOLEAN
			-- Indicates that there was an error during the last operation
		do
			Result := ssl_socket_error /= Void
		end

	socket_ok: BOOLEAN
			-- No error
		do
			Result := not was_error
		end

	ssl_error: STRING
			-- Output a related error message.
		do
			if attached ssl_socket_error as l_error then
				Result := l_error
			else
				Result := "SSL_SOCKET_OK"
			end
		end

	ssl_error_number: INTEGER
			-- Returned error number.

	ssl_pending: INTEGER
			-- SSL_pending() returns the number of bytes which are available inside ssl for immediate read.	
		do
			Result := c_ssl_pending (ptr)
		end

feature -- SSL Errors

	ssl_want_read : INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_ERROR_WANT_READ"
		end

	ssl_error_none: INTEGER
	 	external
	 		"C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_NONE"
	 	end

	ssl_error_zero_return: INTEGER
	 	external
	 		"C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_ZERO_RETURN"
	 	end

	ssl_error_want_write: INTEGER
	 	external
	 		"C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_WANT_WRITE"
	 	end

	 ssl_error_syscall: INTEGER
	 	external
	 		"C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_SYSCALL"
	 	end

	 ssl_get_error (a_err: INTEGER): INTEGER
	 		-- int SSL_get_error(const SSL *ssl, int ret);
			-- SSL_get_error() returns a result code (suitable for the C "switch" statement) for a preceding call to SSL_connect(), SSL_accept(), SSL_do_handshake(), SSL_read(), SSL_peek(), or SSL_write() on ssl.
			-- The value returned by that TLS/SSL I/O function must be passed to SSL_get_error() in parameter ret.
		do
			Result := c_ssl_get_error (ptr, a_err)
		end

feature {NONE} -- Implementation	

	ssl_socket_error: detachable STRING
			-- Error description in case of an error.			

feature -- Attributes

	ptr: POINTER
			-- External SSL structure

feature {NONE} -- Externals

	c_err_error_string (ssl_err: INTEGER_64; buf_ptr: POINTER): POINTER
			-- External call to ERR_error_string
		external
			"C signature (unsigned long, char *): EIF_POINTER use %"eif_openssl.h%""
		alias
			"ERR_error_string"
		end

	c_err_get_error: INTEGER_64
			-- External call to ERR_get_error
		external
			"C use %"eif_openssl.h%""
		alias
			"ERR_get_error"
		end

	c_ssl_accept (an_ssl_ptr: POINTER): INTEGER
			-- External call to SSL_accept
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_accept"
		end

	c_ssl_connect (an_ssl_ptr: POINTER): INTEGER
			-- External call to SSL_connect
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_connect"
		end

	c_ssl_free (an_ssl_ptr: POINTER)
			-- External call to SSL_free
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_free"
		end

	c_ssl_new (a_ctx_ptr: POINTER): POINTER
			-- External call to SSL_new
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_new"
		end

	c_ssl_read (an_ssl_ptr: POINTER; buffer: POINTER; nb_bytes: INTEGER): INTEGER
			-- External call to SSL_read
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_read"
		end

	c_ssl_set_fd (a_ctx_ptr: POINTER; an_fd: INTEGER)
			-- External call to SSL_set_fd
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_set_fd"
		end

	c_ssl_shutdown (an_ssl_ptr: POINTER)
			-- External call to SSL_shutdown
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_shutdown"
		end

	c_ssl_write (an_ssl_ptr: POINTER; buffer: POINTER; nb_bytes: INTEGER): INTEGER
			-- External call to SSL_write
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_write"
		end

	c_ssl_get_error (an_ssl_ptr: POINTER; a_err: INTEGER): INTEGER
			-- External call to SSL_write
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_get_error"
		end

	 c_ssl_pending (a_ssl: POINTER): INTEGER
	 		-- SSL_pending() returns the number of bytes which are available inside ssl for immediate read.	
	 	external
	 		"C inline use %"eif_openssl.h%""
	 	alias
	 		"return SSL_pending((const SSL *)$a_ssl);"
	 	end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
