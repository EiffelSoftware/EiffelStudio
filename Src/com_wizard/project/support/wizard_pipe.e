class
	WIZARD_PIPE

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

	STRING_HANDLER

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize pipe.
		do
			create security_attributes.make
			security_attributes.set_inherit_handle (True)
			exists := cwin_create_pipe ($output_handle, $input_handle, security_attributes.item, 0)
		end
		
feature -- Status Report

	exists: BOOLEAN
			-- Does pipe exist?

	output_handle: INTEGER
			-- Pipe input handle

	input_handle: INTEGER
			-- Pipe output handle

	input_closed: BOOLEAN
			-- Is pipe input closed?

	output_closed: BOOLEAN
			-- Is pipe output closed?

	last_write_successful: BOOLEAN
			-- Was last write operation successful?

	last_read_successful: BOOLEAN
			-- Was last read operation successful?

	last_string: STRING
			-- Last read string

feature -- Status setting

	close is
			-- Close pipe.
		do
			output_closed := cwin_close_handle (output_handle)
			input_closed := cwin_close_handle (input_handle)
		end

	close_output is
			-- Close pipe output.
		do
			output_closed := cwin_close_handle (output_handle)
		end

	close_input is
			-- Close pipe input.
		do
			input_closed := cwin_close_handle (input_handle)
		end

feature -- Input

	put_string (a_string: STRING) is
			-- Write `a_string' to pipe.
		local
			a_wel_string: WEL_STRING
			written_bytes: INTEGER
		do
			create a_wel_string.make (a_string)
			last_write_successful := cwin_write_file (input_handle, a_wel_string.item, a_string.count, $written_bytes, default_pointer)
		end

feature -- Output

	read_stream (count: INTEGER) is
			-- Read a string of at most `count' bound characters
			-- or until end of pipe is encountered.
			-- Make result available in `last_string'.
		local
			new_count: INTEGER
			str_area: ANY
		do
			create last_string.make (count)
			str_area := last_string.area
			last_read_successful := cwin_read_file (output_handle, $str_area, count, $new_count, default_pointer)
			last_string.set_count (new_count)
		end

feature {NONE} -- Implementation

	security_attributes: WEL_SECURITY_ATTRIBUTES
			-- Security attributes used to create pipe

feature {NONE} -- Externals

	cwin_read_file (a_handle: like output_handle; a_buffer: POINTER; an_integer:INTEGER; a_pointer1, a_pointer2: POINTER): BOOLEAN is
			-- SDK ReadFile
		external
			"C [macro <winbase.h>] (HANDLE, LPVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL"
		alias
			"ReadFile"
		end

	cwin_write_file (a_handle: like input_handle; a_buffer: POINTER; an_integer:INTEGER; a_pointer1, a_pointer2: POINTER): BOOLEAN is
			-- SDK WriteFile
		external
			"C [macro <winbase.h>] (HANDLE, LPCVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL"
		alias
			"WriteFile"
		end

	cwin_create_pipe (a_output_handle_pointer, a_input_handle_pointer, a_pointer: POINTER; a_size: INTEGER): BOOLEAN is
			-- SDK CreatePipe
		external
			"C [macro <winbase.h>] (PHANDLE, PHANDLE, LPSECURITY_ATTRIBUTES, DWORD): BOOL"
		alias
			"CreatePipe"
		end

	cwin_close_handle (a_handle: INTEGER): BOOLEAN is
			-- SDK CloseHandle
		external
			"C [macro <winbase.h>] (HANDLE): BOOL"
		alias
			"CloseHandle"
		end

end -- class WIZARD_PIPE

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
