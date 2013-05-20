note
	description: "Implementation for the FCGI_I interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FCGI_IMP

inherit
	FCGI_I

feature -- Access

	environ: POINTER
			-- Get the (char**) environ variable from the DLL.
		external
			"C inline use %"fcgi_stdio.h%""
		alias
			"return (char**) environ;"
		end

feature -- FCGI connection

	fcgi_listen: INTEGER
			-- Listen to the FCGI input stream
			-- Return 0 for successful calls, -1 otherwise.
		do
			-- Set state on first call to prevent looping indefinitely
			if fcgi_has_run then
				Result := -1
			else --if not is_interactive then
				fcgi_has_run := True
			end
		end

	fcgi_has_run: BOOLEAN
			-- For emulation only; Has fcgi_listen been called?

	fcgi_finish
			-- Finish current request from HTTP server started from
			-- the most recent call to `fcgi_accept'.
		do
		end

	set_fcgi_exit_status (v: INTEGER)
		do
		end

feature -- FCGI output

	put_string (a_str: READABLE_STRING_8)
			-- Put `a_str' on the FastCGI stdout.
		do
			io.put_string (a_str)
		end

feature -- Error

	put_error (a_str: READABLE_STRING_8)
			-- Put `a_str' on the FastCGI stdout.
		do
			io.error.put_string (a_str)
		end

feature -- FCGI Input

	read_from_stdin (n: INTEGER)
			-- Read up to n bytes from stdin and store in input buffer
		do
		end

	copy_from_stdin (n: INTEGER; tf: FILE)
			-- Read up to n bytes from stdin and write to given file
		do
		end

feature -- Status

	buffer_contents: STRING
		do
			if attached private_input_buffer as buf then
				Result := buf
			else
				Result := ""
			end
		end

	buffer_capacity: INTEGER
		do
			if attached private_input_buffer as bug then
				Result := buf.capacity
			end
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
