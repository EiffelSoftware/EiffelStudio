note
	description: "Windows pipe, used in WEL_PROCESS_LAUNCHER"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WEL_PIPE

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

	STRING_HANDLER

create
	make,
	make_named,
	make_client

feature {NONE} -- Initialization

	make
			-- Initialize pipe.
		local
			l_sec_attr: like security_attributes
		do
			create l_sec_attr.make
			l_sec_attr.set_inherit_handle (True)
			exists := cwin_create_pipe ($output_handle, $input_handle, l_sec_attr.item, 0)
			security_attributes := l_sec_attr
		end

	make_named (a_name: READABLE_STRING_GENERAL; a_direction: INTEGER)
			-- Create a named pipe with name `name' and 'a_direction'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			valid_direction: a_direction = inbound or a_direction = outbound or a_direction = duplex
		local
			l_handle: POINTER
			l_connected: BOOLEAN
			ws: WEL_STRING
			l_sec_attr: like security_attributes
		do
			create ws.make (format_pipe_name (a_name))
			create l_sec_attr.make
			l_sec_attr.set_inherit_handle (True)
			security_attributes := l_sec_attr

			input_closed := True
			output_closed := True

			l_handle := cwin_create_named_pipe (ws.item, a_direction, 0, 255, max_pipe_buffer_length, max_pipe_buffer_length, 0, default_pointer)
			if l_handle /= invalid_handle_value then
				if a_direction = inbound or a_direction = duplex then
					output_handle := l_handle
					output_closed := False
				end
				if a_direction = outbound or a_direction = duplex then
					input_handle := l_handle
					input_closed := False
				end

				l_connected := cwin_connect_named_pipe (l_handle, default_pointer)
				check
					connected: l_connected
				end
			end
		end

	make_client (a_name: READABLE_STRING_GENERAL; a_direction: INTEGER; a_wait_server: BOOLEAN)
			-- Create a pipe connecting to named pipe with name `name' and 'a_direction'
			-- named pipe must have previously been created.
			-- if `a_wait_server' then execution halts until a compatible server has been created
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			valid_direction: a_direction = inbound or a_direction = outbound or a_direction = duplex
		local
			l_handle: POINTER
			l_create_mode: INTEGER
			ws: WEL_STRING
		do
			create ws.make (format_pipe_name (a_name))

			input_closed := True
			output_closed := True

			if a_wait_server then
				from
				until
					cwin_wait_piped_name (ws.item, 0)
				loop
					cwin_sleep (10)
				end
			end

			if cwin_wait_piped_name (ws.item, 0) then
				inspect a_direction
				when Inbound then
					l_create_mode := generic_read
				when Outbound then
					l_create_mode := generic_write
				when Duplex then
					l_create_mode := generic_read.bit_or (generic_write)
				end
				l_handle := cwin_create_file (ws.item, l_create_mode, 0x0, default_pointer, 0x4, 0x100, default_pointer)
				if l_handle /= invalid_handle_value then
					if a_direction = inbound or a_direction = duplex then
						output_handle := l_handle
						output_closed := False
					end
					if a_direction = outbound or a_direction = duplex then
						input_handle := l_handle
						input_closed := False
					end
				end
			end
		end

feature -- Access

	inbound: INTEGER = 0x01
			-- Named pipe will be written to

	outbound: INTEGER = 0x02
			-- Named pipe will be listened to

	duplex:  INTEGER = 0x03
			-- Named pipe will be written and listened to

feature -- Status Report

	exists: BOOLEAN
			-- Does pipe exist?

	output_handle: POINTER
			-- Pipe input handle

	input_handle: POINTER
			-- Pipe output handle

	input_closed: BOOLEAN
			-- Is pipe input closed?

	output_closed: BOOLEAN
			-- Is pipe output closed?

	last_write_successful: BOOLEAN
			-- Was last write operation successful?

	last_read_successful: BOOLEAN
			-- Was last read operation successful?

	last_string: detachable STRING_8
			-- Last read string as a sequence of bytes encoded in a STRING_8 instance.

	last_written_bytes: INTEGER
			-- Last amount of bytes written to pipe

	last_read_bytes: INTEGER
			-- Last amount of bytes read from pipe

feature -- Status setting

	close
			-- Close pipe.
		do
			if not output_closed then
				output_closed := cwin_close_handle (output_handle)
			end
			if not input_closed then
				if input_handle /= output_handle then
					input_closed := cwin_close_handle (input_handle)
				else
					input_closed := True
				end
			end
		ensure
			output_has_close: output_closed
			input_has_close: input_closed
		end

	close_output
			-- Close pipe output.
		require
			output_open: not output_closed
		do
			output_closed := cwin_close_handle (output_handle)
		end

	close_input
			-- Close pipe input.
		require
			input_open: not input_closed
		do
			input_closed := cwin_close_handle (input_handle)
		end

feature -- Input

	put_string (a_string: STRING)
			-- Write `a_string' to pipe.
			-- Put number of written bytes in `last_written_bytes'.
		require
			non_void_string: a_string /= Void
			input_open: not input_closed
		local
			a_c_string: C_STRING
		do
			create a_c_string.make (a_string)
			last_write_successful := cwin_write_file (input_handle, a_c_string.item, a_string.count, $last_written_bytes, default_pointer)
		end

feature -- Output

	read_stream (count: INTEGER)
			-- Read a string of at most `count' bound characters
			-- or until end of pipe is encountered.
			-- Put number of read bytes in `last_read_bytes'.
			-- Make result available in `last_string'.
		require
			valid_count: count > 0
			output_open: not output_closed
		local
			l_str: C_STRING
			l_read_bytes: INTEGER
		do
			create l_str.make_empty (count)
			last_read_successful := cwin_read_file (output_handle, l_str.item,
				count, $l_read_bytes, default_pointer)
			last_read_bytes := l_read_bytes
			last_string := l_str.substring_8 (1, l_read_bytes)
		end

feature {NONE} -- Implementation

	format_pipe_name (a_name: READABLE_STRING_GENERAL): STRING_32
			--
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make_from_string_general ("\\.\pipe\")
			Result.append_string_general (a_name)
		ensure
			non_void_result: Result /= Void
		end

	security_attributes: detachable WEL_SECURITY_ATTRIBUTES
			-- Security attributes used to create pipe
			--
			--| Note: This is not initialized in `make_client', otherwise it could be attached, more
			--|       information needed! (Arno 01/14/2009)

	max_pipe_buffer_length: INTEGER = 4096
			-- max length for pipe buffer

	generic_read: INTEGER = 0x80000000
			-- generic read mode

	generic_write: INTEGER = 0x40000000
			-- generic write mode			

feature {NONE} -- Externals

	cwin_create_named_pipe (a_name: POINTER; an_integer, an_integer2, an_integer3, an_integer4, an_integer5, an_integer6: INTEGER; a_pointer: POINTER): like output_handle
			-- SDK CreateNamedPiper
		external
			"C [macro <winbase.h>] (LPCTSTR, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPSECURITY_ATTRIBUTES): HANDLE"
		alias
			"CreateNamedPipe"
		end

	cwin_create_file (a_name: POINTER; an_integer, an_integer2: INTEGER; a_pointer: POINTER; an_integer3, an_integer4: INTEGER; a_handle: POINTER): like input_handle
			-- SDK CreateFile
		external
			"C [macro <winbase.h>] (LPCTSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE): HANDLE"
		alias
			"CreateFile"
		end

	cwin_connect_named_pipe (a_handle: like input_handle; a_pointer: POINTER): BOOLEAN
			-- SDK ConnectNamedPipe
		external
			"C [macro <winbase.h>] (HANDLE, LPOVERLAPPED): BOOL"
		alias
			"ConnectNamedPipe"
		end

	cwin_wait_piped_name (a_name: POINTER; a_integer: INTEGER): BOOLEAN
			-- SDK WaitNamedPipe
		external
			"C [macro <winbase.h>] (LPCTSTR, DWORD): BOOL"
		alias
			"WaitNamedPipe"
		end

	cwin_read_file (a_handle: like output_handle; a_buffer: POINTER; an_integer:INTEGER; a_pointer1, a_pointer2: POINTER): BOOLEAN
			-- SDK ReadFile
		external
			"C [macro <winbase.h>] (HANDLE, LPVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL"
		alias
			"ReadFile"
		end

	cwin_write_file (a_handle: like input_handle; a_buffer: POINTER; an_integer:INTEGER; a_pointer1, a_pointer2: POINTER): BOOLEAN
			-- SDK WriteFile
		external
			"C [macro <winbase.h>] (HANDLE, LPCVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL"
		alias
			"WriteFile"
		end

	cwin_create_pipe (a_output_handle_pointer, a_input_handle_pointer, a_pointer: POINTER; a_size: INTEGER): BOOLEAN
			-- SDK CreatePipe
		external
			"C [macro <winbase.h>] (PHANDLE, PHANDLE, LPSECURITY_ATTRIBUTES, DWORD): BOOL"
		alias
			"CreatePipe"
		end

	cwin_close_handle (a_handle: POINTER): BOOLEAN
			-- SDK CloseHandle
		external
			"C [macro <winbase.h>] (HANDLE): BOOL"
		alias
			"CloseHandle"
		end

	cwin_sleep (a_milliseconds:INTEGER)
			-- SDK Sleep
		external
			"C [macro <winbase.h>] (DWORD)"
		alias
			"Sleep"
		end

	invalid_handle_value: POINTER
		external
			"C inline use <winbase.h>"
		alias
			"INVALID_HANDLE_VALUE"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
