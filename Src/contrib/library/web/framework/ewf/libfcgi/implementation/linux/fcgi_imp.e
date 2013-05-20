note
	description: "Implementation for the FCGI_I interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class FCGI_IMP

inherit
	FCGI_I
	STRING_HANDLER

feature {NONE} -- Initialization

	make
			-- Initialize FCGI interface
		do
			create fcgi
		end

	fcgi: FCGI_C_API
			-- FastCGI C API primitives


feature -- Access

	fcgi_environ: POINTER
		do
			Result := fcgi.environ
		end

	fcgi_end_of_input: BOOLEAN
		do
			Result := fcgi.feof (fcgi.stdin) = 0
		end

feature -- FCGI Connection

	fcgi_listen: INTEGER
			-- Listen to the FCGI input stream
			-- Return 0 for successful calls, -1 otherwise.
		do
			Result := {FCGI_C_API}.accept
		end

	update_eif_environ
		external
			"C inline use <string.h>"
		alias
			"[
				eif_environ = (char**) environ;
			]"
		end
		
	fcgi_finish
			-- Finish current request from HTTP server started from
			-- the most recent call to `fcgi_accept'.
		do
			{FCGI_C_API}.finish
		end

	set_fcgi_exit_status (v: INTEGER)
		do
			{FCGI_C_API}.set_exit_status (-2)
		end

feature -- FCGI output

	put_string (a_str: READABLE_STRING_8)
			-- Put `a_str' on the FastCGI stdout.
		local
			l_c_str: C_STRING
		do
			l_c_str := c_buffer
			l_c_str.set_string (a_str)
			{FCGI_C_API}.put_string (l_c_str.item, l_c_str.count)
		end

feature -- Error		

	put_error (a_message: READABLE_STRING_8)
			-- Put error message `a_message' on the FastCGI stderr
		local
			l_c_str: C_STRING
		do
			l_c_str := c_buffer
			l_c_str.set_string (a_message)
			fcgi.put_error (l_c_str.item, l_c_str.count)
		end

feature -- FCGI Input

	copy_from_stdin (n: INTEGER; tf: FILE)
			-- Read up to n bytes from stdin and write to given file
		local
			l_c_str: C_STRING
			num, readsize, writecount: INTEGER
			done: BOOLEAN
		do
			readsize := n.min (K_input_bufsize)
			l_c_str := c_buffer
			from
			until done or writecount >= n
			loop
				num := {FCGI_C_API}.read_content_into (l_c_str.item, readsize)
				if num  = 0 then
					-- EOF
					done := True
				else
					tf.put_managed_pointer (c_buffer.managed_data, 0, num)
					writecount := writecount + num
				end
			end
		end

feature {NONE} -- Implementation: FCGI Input

	fill_pointer_from_stdin (p: POINTER; n: INTEGER): INTEGER
			-- Read up to `n' bytes from stdin and store in pointer `p'
			-- and return number of bytes read.
		do
			Result := {FCGI_C_API}.read_content_into (p, n)
		end

feature -- I/O Routines

--RFO	read_stdin_into (a_str: STRING)
--RFO			-- Read a string from the `stdin' into `a_str'.
--RFO		require
--RFO			a_str_not_void: a_str /= Void
--RFO		local
--RFO			l_c_str: C_STRING
--RFO			n: INTEGER
--RFO		do
--RFO			l_c_str := c_buffer
--RFO			n := {FCGI_C_API}.read_content_into (l_c_str.item, l_c_str.capacity)
--RFO			a_str.set_count (n)
--RFO			l_c_str.read_substring_into (a_str, 1, n)
--RFO		end

--RFO	read_string_into (a_str: STRING)
--RFO		require
--RFO			exists: a_str /= Void
--RFO		local
--RFO			l_c_str: C_STRING
--RFO			p: POINTER
--RFO		do
--RFO			create l_c_str.make_empty (1024)
--RFO			p := {FCGI_C_API}.gets (l_c_str.item)
--RFO--			if p /= default_pointer and p = l_c_str.item then
--RFO				a_str.resize (l_c_str.count)
--RFO				l_c_str.read_string_into (a_str)
--RFO--			else
--RFO--				put_error_line ("Bad pointer from gets")
--RFO--			end
--RFO		end

--RFO	read_line
--RFO			-- Read up to the next end of line, or end of input
--RFO			-- Leave result in last_string
--RFO			-- Newline character is absent from result
--RFO		do
--RFO			if last_string = Void then
--RFO				create Result.make (K_input_bufsize)
--RFO			else
--RFO				last_string.wipe_out
--RFO			end
--RFO--			if input_filename /= Void then
--RFO--				io.read_line
--RFO--				last_string.append (io.last_string)
--RFO--			else
--RFO				read_string_into (last_string)
--RFO--			end
--RFO		end

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
