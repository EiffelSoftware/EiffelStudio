note
	description: "Wrappers around FastCGI C API."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FCGI_C_API

feature -- Connections

	accept: INTEGER
			-- Accept a Fast CGI connection.
			-- Return 0 for successful calls, -1 otherwise.
		external
			"dll libfcgi.dll signature (): EIF_INTEGER use fcgi_stdio.h "
		alias
			"FCGI_Accept"
		end

	environ: POINTER
			-- Get the (char**) environ variable from the DLL.
		external
			"dll libfcgi.dll signature (): EIF_POINTER use fcgi_stdio.h "
		alias
			"FCGI_Environ"
		end

	finish
			-- Finished current request from HTTP server started from
			-- the most recent call to `accept'.
		external
			"dll libfcgi.dll signature () use fcgi_stdio.h "
		alias
			"FCGI_Finish"
		end

	set_exit_status (v: INTEGER)
			-- Set the exit status for the most recent request
		external
			"dll libfcgi.dll signature (EIF_INTEGER) use fcgi_stdio.h "
		alias
			"FCGI_SetExitStatus"
		end

feature -- Input

	read_content_into (a_buffer: POINTER; a_length: INTEGER): INTEGER
			-- Read content stream into `a_buffer' but no more than `a_length' character.
		local
			i: INTEGER
			l_stdin: POINTER
		do
			l_stdin := stdin
			i := feof (l_stdin)
			if i /= 0 then
				Result := 0
			else
				Result := fread(a_buffer, 1, a_length, l_stdin)
			end
		end

feature {FCGI_IMP} -- Internal

	feof (v: POINTER): INTEGER
			-- FCGI_feof()
		external
			"dll libfcgi.dll signature (EIF_POINTER): EIF_INTEGER use fcgi_stdio.h "
		alias
			"FCGI_feof"
		end

feature {NONE} -- Input

	fread (v: POINTER; a_size: INTEGER; n: INTEGER; fp: POINTER): INTEGER
			-- FCGI_fread() read from input `fp' and put into `v'
		external
			"dll libfcgi.dll signature (EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_POINTER): EIF_INTEGER use fcgi_stdio.h "
		alias
			"FCGI_fread"
		end

	gets (s: POINTER): POINTER
			-- gets() reads a line from stdin into the buffer pointed to
			-- by `s' until either a terminating newline or EOF, which it
			-- replaces with '\0'
			-- No check for buffer overrun is performed
		external
			"dll libfcgi.dll signature (EIF_POINTER): EIF_POINTER use fcgi_stdio.h "
		alias
			"FCGI_gets"
		end

feature -- Output

	put_string (v: POINTER; n: INTEGER)
		local
			i: INTEGER
		do
			i := fwrite (v, 1, n, stdout)
		end

feature -- Error

	put_error (v: POINTER; n: INTEGER)
		local
			i: INTEGER
		do
			i := fwrite (v, 1, n, stderr)
		end

feature {NONE} -- Output

	fwrite (v: POINTER; a_size: INTEGER; n: INTEGER; fp: POINTER): INTEGER
			-- FCGI_fwrite() ouput `v' to `fp'
		external
			"dll libfcgi.dll signature (EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_POINTER): EIF_INTEGER use fcgi_stdio.h "
		alias
			"FCGI_fwrite"
		end

feature -- Access

	stdout: POINTER
			-- FCGI_stdout() return pointer on output FCGI_FILE
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_stdout"
		end

	stdin: POINTER
			-- FCGI_stdin() return pointer on input FCGI_FILE
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_stdin"
		end

	stderr: POINTER
			-- FCGI_stderr() return pointer on error FCGI_FILE
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_stderr"
		end
		

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
