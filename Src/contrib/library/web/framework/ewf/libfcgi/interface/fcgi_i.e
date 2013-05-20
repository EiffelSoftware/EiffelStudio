note
	description: "Abstract interface to FCGI C library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class FCGI_I

inherit
	STRING_HANDLER

feature {NONE} -- Initialization

	make
			-- Initialize FCGI interface
		deferred
		end

feature -- Access

	updated_environ_variables: HASH_TABLE [STRING, STRING]
		local
			i: INTEGER
			p, v, null: POINTER
		do
			p := fcgi_environ
			create Result.make (50)
			if p /= null then
				from
					i := 0
					v := fcgi_i_th_environ (i,p)
				until
					v = null
				loop
					if attached separated_variables (create {STRING}.make_from_c (v)) as t then
						Result.force (t.value, t.key)
					end
					i := i + 1
					v := fcgi_i_th_environ (i,p)
				end
			end
		end

feature -- FCGI interface

	fcgi_listen: INTEGER
			-- Listen to the FCGI input stream
			-- Return 0 for successful calls, -1 otherwise.
		deferred
		end

	fcgi_environ: POINTER
			-- Get the (char**) environ variable from the DLL.
		deferred
		end

	fcgi_finish
			-- Finish current request from HTTP server started from
			-- the most recent call to `fcgi_accept'.
		deferred
		end

	set_fcgi_exit_status (v: INTEGER)
		deferred
		end

feature -- Status

	is_interactive: BOOLEAN
			-- Is execution interactive? (for debugging)
		do
		end

feature -- Input

	fill_string_from_stdin (s: STRING; n: INTEGER)
			-- Read up to `n' bytes from stdin and store in string `s'
		local
			new_count: INTEGER
			str_area: ANY
		do
			s.grow (n)
			str_area := s.area
			new_count := fill_pointer_from_stdin ($str_area, n)
			s.set_count (new_count)
		end

	read_from_stdin (n: INTEGER)
			-- Read up to n bytes from stdin and store in input buffer
		require
			small_enough: n <= buffer_capacity
		local
			l_c_str: C_STRING
			l_count: INTEGER
		do
			last_read_is_empty_ref.set_item (False)
			l_c_str := c_buffer
			l_count := fill_pointer_from_stdin (l_c_str.item, n)
			last_read_count_ref.set_item (l_count)
			if l_count <= 0 then
				last_read_is_empty_ref.set_item (True)
			end
		end

	fill_pointer_from_stdin (p: POINTER; n: INTEGER): INTEGER
			-- Read up to `n' bytes from stdin and store in pointer `p'
			-- and return number of bytes read.
		deferred
		end

	copy_from_stdin (n: INTEGER; f: FILE)
			-- Read up to n bytes from stdin and write to given file
		require
--			small_enough: n <= buffer_capacity
			file_exists: f /= Void
			file_open: f.is_open_write or f.is_open_append
		deferred
		end

feature -- Output

	put_string (a_str: READABLE_STRING_8)
			-- Put `a_str' on the FastCGI stdout.
		require
			a_str_not_void: a_str /= Void
		deferred
		end

feature -- Implementation		

	buffer_contents: STRING
		local
			n: like last_read_count
		do
			n := last_read_count
			create Result.make (n)
			Result.set_count (n)
			c_buffer.read_substring_into (Result, 1, n)
		end

	buffer_capacity: INTEGER
		do
			Result := c_buffer.capacity
		end

--RFO	last_string: STRING
--RFO		once
--RFO			create Result.make (K_input_bufsize)
--RFO		end

	last_read_count: INTEGER
		do
			Result := last_read_count_ref.item
		end

	last_read_is_empty: BOOLEAN
		do
			Result := last_read_is_empty_ref.item
		end

feature {NONE} -- Shared buffer

	c_buffer: C_STRING
			-- Buffer for Eiffel to C and C to Eiffel string conversions.
		once
			create Result.make_empty (K_input_bufsize)
		ensure
			c_buffer_not_void: Result /= Void
		end


feature {NONE} -- Constants

	last_read_count_ref: INTEGER_REF
		once
			create Result
		end

	last_read_is_empty_ref: BOOLEAN_REF
		once
			create Result
		end

	K_input_bufsize: INTEGER = 1024_000

feature {NONE} -- Implementation: Environment

	fcgi_i_th_environ (i: INTEGER; p: POINTER): POINTER
			-- Environment variable at `i'-th position of `p'.
		require
			i_valid: i >=0
		external
			"C inline use <string.h>"
		alias
			"return ((char **)$p)[$i];"
		end

	separated_variables (a_var: STRING): detachable TUPLE [value: STRING; key: STRING]
			-- Given an environment variable `a_var' in form of "key=value",
			-- return separated key and value.
			-- Return Void if `a_var' is in incorrect format.
		require
			a_var_attached: a_var /= Void
		local
			i, j: INTEGER
			done: BOOLEAN
		do
			j := a_var.count
			from
				i := 1
			until
				i > j or done
			loop
				if a_var.item (i) = '=' then
					done := True
				else
					i := i + 1
				end
			end
			if i > 1 and then i < j then
				Result := [a_var.substring (i + 1, j), a_var.substring (1, i - 1)]
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
