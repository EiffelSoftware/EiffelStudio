indexing
	description: "Manipulate Windows handle to file"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_HANDLE

feature -- Factory

	open_file_inheritable (a_filename: STRING): POINTER is
			-- Open a file `a_filename' and made returned handle inheritable by child
			-- process if any, so that it can be read from by child.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: not a_filename.is_empty
		local
			l_sec: WEL_SECURITY_ATTRIBUTES
			l_str: WEL_STRING
		do
			create l_sec.make
			l_sec.set_inherit_handle (True)
			create l_str.make (a_filename)
			Result := cwin_create_file (l_str.item,
				{WEL_FILE_CONSTANTS}.generic_read,
				{WEL_FILE_CONSTANTS}.file_share_read | {WEL_FILE_CONSTANTS}.file_share_write,
				l_sec.item,
				{WEL_FILE_CONSTANTS}.open_existing,
				{WEL_FILE_CONSTANTS}.file_attribute_normal, default_pointer)
		end

	create_file_inheritable (a_filename: STRING; is_append: BOOLEAN): POINTER is
			-- If not `is_append' create a file `a_filename' and overwrite if it exists.
			-- Otherwise append to existing file.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: not a_filename.is_empty
		local
			l_sec: WEL_SECURITY_ATTRIBUTES
			l_str: WEL_STRING
			l_mode: INTEGER
			l_null: TYPED_POINTER [INTEGER]
		do
			create l_sec.make
			l_sec.set_inherit_handle (True)
			create l_str.make (a_filename)
			if is_append then
				l_mode := {WEL_FILE_CONSTANTS}.open_always
			else
				l_mode := {WEL_FILE_CONSTANTS}.create_always
			end
			Result := cwin_create_file (l_str.item,
				{WEL_FILE_CONSTANTS}.generic_write,
				{WEL_FILE_CONSTANTS}.file_share_read,
				l_sec.item,
				l_mode,
				{WEL_FILE_CONSTANTS}.file_flag_write_through, default_pointer)

			if is_append then
				cwin_set_file_pointer (Result, 0, l_null, {WEL_FILE_CONSTANTS}.file_end)
			end
		end

	create_pipe_write_inheritable: TUPLE [POINTER, POINTER] is
			-- Create pipe where `write' part of pipe can be written to.
			-- Actual type is TUPLE [read, write: POINTER]
		local
			l_read, l_write, l_temp: POINTER
		do
			if cwin_create_pipe ($l_read, $l_temp, default_pointer, 0) then
				if duplicate_handle (l_temp, $l_write) then
					if close (l_temp) then
						Result := [l_read, l_write]
					else
						display_error
					end
				else
					display_error
				end
			else
				display_error
			end
		end

	create_pipe_read_inheritable: TUPLE [POINTER, POINTER] is
			-- Create pipe where `write' part of pipe can be written to.
			-- Actual type is TUPLE [read, write: POINTER]
		local
			l_read, l_write, l_temp: POINTER
		do
			if cwin_create_pipe ($l_temp, $l_write, default_pointer, 0) then
				if duplicate_handle (l_temp, $l_read) then
					if close (l_temp) then
						Result := [l_read, l_write]
					else
						display_error
					end
				else
					display_error
				end
			else
				display_error
			end
		end

feature -- Status report

	last_write_successful: BOOLEAN
			-- Was last write operation successful?

	last_read_successful: BOOLEAN
			-- Was last read operation successful?

	last_string: STRING
			-- Last read string

	last_written_bytes: INTEGER
			-- Last amount of bytes written to pipe

	last_read_bytes: INTEGER
			-- Last amount of bytes read from pipe

feature -- Status setting

	close (a_handle: POINTER): BOOLEAN is
			-- Close `a_handle'.
		do
			Result := cwin_close_handle (a_handle)
		end

feature -- Input

	read_stream (a_handle: POINTER; a_count: INTEGER) is
			-- Read a string of at most `count' bound characters
			-- or until end of pipe is encountered.
			-- Put number of read bytes in `last_read_bytes'.
			-- Make result available in `last_string'.
		require
			valid_count: a_count > 0
		local
			l_str: C_STRING
			l_success: BOOLEAN
			l_bytes: like last_read_bytes
		do
			create l_str.make_empty (a_count)
			from
				l_success := cwin_read_file (a_handle, l_str.item, a_count, $l_bytes, default_pointer)
			until
				not l_success or else l_bytes > 0
			loop
					-- Per MSDN documentation, when we are here if the call to `ReadFile' read `0' bytes
					-- on a successful read, which means we are beyond the current end of the file at
					-- the time of the read operation. So we have to repeat the call until we get something.
				l_success := cwin_read_file (a_handle, l_str.item, a_count, $l_bytes, default_pointer)
			end
			if l_success then
				check l_bytes > 0 end
				last_read_successful := True
				l_str.set_count (l_bytes)
				last_string := l_str.substring (1, l_bytes)
			else
				last_read_successful := False
				last_string := Void
			end
			last_read_bytes := l_bytes
		end

	read_line (a_handle: POINTER) is
			-- Read a line or until end of pipe is encountered.
			-- Put number of read bytes in `last_read_bytes'.
			-- Make result available in `last_string'.
		local
			l_str: C_STRING
			l_done, l_success: BOOLEAN
			l_bytes: like last_read_bytes
		do
			from
				create last_string.make (10)
				create l_str.make_empty (1)
				last_read_successful := True
			until
				not last_read_successful or l_done
			loop
				from
					l_success := cwin_read_file (a_handle, l_str.item, 1, $l_bytes, default_pointer)
				until
					not l_success or else l_bytes > 0
				loop
						-- Per MSDN documentation, when we are here if the call to `ReadFile' read `0' bytes
						-- on a successful read, which means we are beyond the current end of the file at
						-- the time of the read operation. So we have to repeat the call until we get something.
					l_success := cwin_read_file (a_handle, l_str.item, 1, $l_bytes, default_pointer)
				end
				if l_success then
					check l_bytes > 0 end
					last_read_successful := True
					l_str.set_count (l_bytes)
					last_string.append (l_str.substring (1, l_bytes))
					l_done := last_string.item (last_string.count) = '%N'
				else
					last_read_successful := False
					last_string := Void
				end
			end
			last_read_bytes := l_bytes
		end

feature -- Element change

	duplicate_handle (a_handle: POINTER; a_duplicated_handle: TYPED_POINTER [POINTER]): BOOLEAN is
			-- Duplicate `a_handle', mostly used for:
			-- We've set the SA so the pipe handles are inheritable.  However,
			-- we only want the write end of the pipe inheritable, so we use
			-- DuplicateHandle to change the Inheritability of the read
			-- handle.
		external
			"C inline use <windows.h>"
		alias
			"[
				return EIF_TEST(DuplicateHandle (
					GetCurrentProcess(),
					(HANDLE) $a_handle,
					GetCurrentProcess(),
					(HANDLE *) $a_duplicated_handle,
					0,
					TRUE,
					DUPLICATE_SAME_ACCESS));
			]"
		end

	flush (a_handle: POINTER) is
			-- Flush buffered data.
		do
			if cwin_flush_file_buffers (a_handle) then
			end
		end

	put_string (a_handle: POINTER; a_string: STRING) is
			-- Write `a_string' to `a_handle'.
			-- Put number of written bytes in `last_written_bytes'.
		require
			non_void_string: a_string /= Void
		local
			l_str: C_STRING
			l_bytes: like last_written_bytes
		do
			create l_str.make (a_string)
			last_write_successful := cwin_write_file (a_handle, l_str.item,
				a_string.count, $l_bytes, default_pointer)
			last_written_bytes := l_bytes
		end

feature -- Error reporting

	display_error is
		do
			-- By default do nothing, it can be used for debugging
			-- Most likely it will use {WEL_ERROR}.display_last_error
		end

feature {NONE} -- Implementation

	cwin_create_pipe (a_output_handle_pointer, a_input_handle_pointer, a_pointer: POINTER; a_size: INTEGER): BOOLEAN is
			-- SDK CreatePipe
		external
			"C [macro <winbase.h>] (PHANDLE, PHANDLE, LPSECURITY_ATTRIBUTES, DWORD): BOOL"
		alias
			"CreatePipe"
		end

	cwin_create_file (a_name: POINTER; an_integer, an_integer2: INTEGER; a_pointer: POINTER; an_integer3, an_integer4: INTEGER; a_handle: POINTER): POINTER is
			-- SDK CreateFile
		external
			"C macro signature (LPCTSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE): HANDLE use <windows.h>"
		alias
			"CreateFile"
		end

	cwin_read_file (a_handle: POINTER; a_buffer: POINTER; an_integer:INTEGER; a_pointer1, a_pointer2: POINTER): BOOLEAN is
			-- SDK ReadFile
		external
			"C blocking macro signature (HANDLE, LPVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL use <windows.h>"
		alias
			"ReadFile"
		end

	cwin_write_file (a_handle: POINTER; a_buffer: POINTER; an_integer:INTEGER; a_pointer1, a_pointer2: POINTER): BOOLEAN is
			-- SDK WriteFile
		external
			"C blocking macro signature (HANDLE, LPCVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL use <windows.h>"
		alias
			"WriteFile"
		end

	cwin_close_handle (a_handle: POINTER): BOOLEAN is
			-- SDK CloseHandle
		external
			"C macro signature (HANDLE): BOOL use <windows.h>"
		alias
			"CloseHandle"
		end

	cwin_flush_file_buffers (a_handle: POINTER): BOOLEAN is
			-- SDK CloseHandle
		external
			"C macro signature (HANDLE): BOOL use <windows.h>"
		alias
			"CloseHandle"
		end

	cwin_set_file_pointer (a_handle: POINTER; a_dist_to_move: INTEGER; a_dist_to_move_high: TYPED_POINTER [INTEGER]; a_method: INTEGER) is
			-- Move File pointer to given location
		external
			"C macro signature (HANDLE, LONG, PLONG, DWORD) use <windows.h>"
		alias
			"SetFilePointer"
		end

end
