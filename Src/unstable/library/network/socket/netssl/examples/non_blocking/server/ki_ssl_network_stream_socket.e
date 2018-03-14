note
	description: "Summary description for {KI_SSL_NETWORK_STREAM_SOCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KI_SSL_NETWORK_STREAM_SOCKET
inherit
	SSL_NETWORK_STREAM_SOCKET
		redefine
			read_stream,
			readstream,
			read_into_pointer
		end
create
	make, make_empty,
	make_client_by_port, make_client_by_address_and_port,
	make_server_by_port, make_server_by_address_and_port, make_loopback_server_by_port

create {KI_SSL_NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address, create_from_descriptor

feature -- Input

	read_stream, readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' characters.
			-- Make result available in `last_string'.
		local
			ext: C_STRING
			return_val: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				create ext.make_empty (nb_char + 1)
				return_val := ssl_read (l_ssl,ext.item , nb_char)
				bytes_read := return_val
				if return_val >= 0 then
					ext.set_count (return_val)
					last_string := ext.substring (1, return_val)
				else
					socket_error := "Peer error [0x" + return_val.to_hex_string + "]"
					last_string.wipe_out
				end
			else
				check has_context: False end
			end
		end

	read_into_pointer (p: POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.	
		local
			l_read: INTEGER
			l_last_read: INTEGER
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				from
					l_last_read := 1
				until
					l_read = nb_bytes or l_last_read <= 0
				loop
					l_last_read := ssl_read (l_ssl,p + start_pos + l_read, nb_bytes - l_read)
					if l_last_read >= 0 then
						l_read := l_read + l_last_read
					end
				end
				bytes_read := l_read
			else
				check has_context: False end
			end
		end

	ssl_read_mh (a_ssl : SSL;a_pointer: POINTER; nb_bytes: INTEGER): INTEGER
			-- Read at most `nb_bytes' into `a_pointer' from this SSL socket
		local
			l_iteration,l_error,l_last_error : INTEGER
		do
			from until Result > 0 or else l_iteration > 1000 loop
				Result := a_ssl.read (a_pointer, nb_bytes)
				if Result <= 0 then
					l_error := c_ssl_get_error (a_ssl.ptr, Result)
					if l_error = c_ssl_want_read then
						print("SSL error want read%N")
						execution_environment.sleep(1000)
						l_iteration := l_iteration + 1
					else
						l_iteration := 1002
					end
				end
			end
			debug ("ssl_error")
				if l_iteration > 0 then
					print(l_iteration.out)
				end
			end
		end

	ssl_read (a_ssl : SSL;a_pointer: POINTER; nb_bytes: INTEGER): INTEGER
			-- Read at most `nb_bytes' into `a_pointer' from this SSL socket
		note
			EIS: "name:=SSL_Read", "src=http://jmarshall.com/stuff/handling-nbio-errors-in-openssl.html", "protocol=uri"
			EIS: "name=An Introduction to OpenSSL Programming, Part I of II", "src=http://www.linuxjournal.com/article/4822", "protocol=uri"
			EIS: "name=An Introduction to OpenSSL Programming, Part II of II", "src=http://www.linuxjournal.com/node/5487/print", "protocol=uri"
		local
			l_iteration,l_error,l_last_error : INTEGER
			exit: BOOLEAN
			read_blocked: BOOLEAN
			ssl_pending: BOOLEAN
		do
			print ("%N -----------------------------%N")
			print (generator +  ".ssl_read")
			print ("%N -----------------------------%N")
			from
				ssl_pending := True
			until
				exit or (not read_blocked and then not ssl_pending)
			loop
				read_blocked := False
				Result := a_ssl.read (a_pointer, nb_bytes)
					l_error := c_ssl_get_error (a_ssl.ptr, Result)
					if l_error = c_ssl_error_none then
						exit := True
						print("%NSSL c_ssl_error_none%N")
					elseif l_error = c_ssl_error_zero_return then
						exit := True
						print("%NSSL c_ssl_error_zero_return%N")
					elseif l_error = c_ssl_want_read then
						read_blocked := True
						print("%NSSL c_ssl_want_read%N")
					elseif l_error = c_ssl_error_want_write then
						read_blocked := True
						print("%NSSL c_ssl_error_want_write%N")
					elseif l_error = c_ssl_error_syscall then
						exit := True
						print("%NSSL c_ssl_error_syscall%N")
					else
						-- some other error
						exit := True
						print("%NSSL Unknown error%N")
					end

					if not exit then
						if c_ssl_pending (a_ssl.ptr) > 0  then
							ssl_pending := True
							print ("%NSSL pending True")
						else
							ssl_pending := False
							print ("%NSSL pending False")
						end
					end
			end
		end

	execution_environment : EXECUTION_ENVIRONMENT
		once
			create Result
		end

feature {NONE} -- External

	c_ssl_get_error (an_ssl_ptr: POINTER; a_err: INTEGER): INTEGER
			-- External call to SSL_write
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_get_error"
		end

	c_ssl_want_read : INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_ERROR_WANT_READ"
		end

	c_ssl_error_none: INTEGER
	 	external "C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_NONE"
	 	end

	c_ssl_error_zero_return: INTEGER
	 	external "C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_ZERO_RETURN"
	 	end

	c_ssl_error_want_write: INTEGER
	 	external "C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_WANT_WRITE"
	 	end

	 c_ssl_error_syscall: INTEGER
	 	external "C inline use %"eif_openssl.h%""
	 	alias
	 		"SSL_ERROR_SYSCALL"
	 	end

	 c_ssl_pending (a_ssl: POINTER): INTEGER
	 		-- SSL_pending() returns the number of bytes which are available inside ssl for immediate read.	
	 	external "C inline use %"eif_openssl.h%""
	 	alias
	 		"return SSL_pending((const SSL *)$a_ssl);"
	 	end

	c_ssl_auto_retry : NATURAL_32
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SSL_MODE_AUTO_RETRY"
		end

	c_ssl_set_mode (a_ssl : POINTER;a_mode : NATURAL_32)
		external
			"C use %"eif_openssl.h%""
		alias
			"SSL_set_mode"
		end
end
