note
	description: "Wrappers around FastCGI C API."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FCGI_C_API

feature -- Connection

	accept: INTEGER
			-- Accept a Fast CGI connection.
			-- Return 0 for successful calls, -1 otherwise.
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"return FCGI_Accept();"
		end

	environ: POINTER
			-- Get the (char**) environ variable from the DLL.
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"return (char**) environ;"
		end

	finish
			-- Finished current request from HTTP server started from
			-- the most recent call to `fcgi_accept'.
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_Finish();"
		end

	set_exit_status (v: INTEGER)
			-- Set the exit status for the most recent request
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_SetExitStatus($v);"
		end

feature -- Input

	read_content_into (a_buffer: POINTER; a_length: INTEGER): INTEGER
			-- Read content stream into `a_buffer' but no more than `a_length' character.
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"[
				{
					size_t n;
					if (! FCGI_feof(FCGI_stdin)) {
						n = FCGI_fread($a_buffer, 1, $a_length, FCGI_stdin);
					} else {
						 n = 0;
					}
					return n;
				}
			]"
		end

feature {FCGI_IMP} -- Internal

	feof (v: POINTER): INTEGER
			-- FCGI_feof()
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_feof"
		end

feature {NONE} -- Input

	gets (s: POINTER): POINTER
			-- gets() reads a line from stdin into the buffer pointed to
			-- by s until either a terminating newline or EOF, which it
			-- replaces with '\0'
			-- No check for buffer overrun is performed
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"return FCGI_gets($s);"
		end

feature -- Output

	put_string (v: POINTER; n: INTEGER)
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_fwrite($v, 1, $n, FCGI_stdout);"
		end

feature -- Error

	put_error (v: POINTER; n: INTEGER)
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"FCGI_fwrite($v, 1, $n, FCGI_stderr);"
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
