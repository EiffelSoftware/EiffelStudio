indexing
	description: "Launch processes and redirect output"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROCESS_LAUNCHER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WEL_PROCESS_CREATION_CONSTANTS
		export
			{NONE} all
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

	WEL_STARTUP_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_EXECUTION_ENVIRONMENT

creation
	make
	
feature {NONE} -- Initialization

	make (a_message_output: like message_output) is
			-- Set `message_output' with `a_message_output'.
		require
			non_void_message_output: a_message_output /= Void
		do
			message_output := a_message_output
		ensure
			message_output_set: message_output = a_message_output
		end

feature -- Access

	displayed_while_running: BOOLEAN
			-- Should process output be displayed while the process is running?

feature -- Element Change

	set_displayed_while_running (a_boolean: BOOLEAN) is
			-- Set `displayed_while_running' to `a_boolean'.
		do
			displayed_while_running := a_boolean
		ensure
			set: displayed_while_running = a_boolean
		end

feature -- Basic Operations

	spawn (a_command_line, a_working_directory: STRING) is
			-- Spawn process described in `a_command_line' from `a_working_directory'.
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create process_info.make
			create a_wel_string1.make (a_command_line)
			create a_wel_string2.make (a_working_directory)
			last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
				default_pointer, default_pointer, True, 0, default_pointer, a_wel_string2.item,
				startup_info.item, process_info.item)
		end

	launch (a_command_line, a_working_directory: STRING) is
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Wait for end of process and write output to `output_message'.
		require
			non_void_command_line: a_command_line /= Void
			non_void_working_directory: a_working_directory /= Void
			valid_working_directory: not a_working_directory.is_empty
		local
			a_string: STRING
			a_boolean: BOOLEAN
			an_integer: INTEGER
			a_last_process_result: INTEGER
			a_output: STRING
		do
			if not (a_command_line.item (1) = '"') then
				a_command_line.prepend ("%"")
			end
			if not (a_command_line.item (a_command_line.count) = '"') then
				a_command_line.append ("%"")
			end
			a_string := clone (Console_spawn_application)
			a_string.append (" ")
			a_string.append (a_command_line)
			spawn (a_string, a_working_directory)
			output_pipe.close_input
			from
				output_pipe.read_stream (Block_size)
				create a_output.make (10000)
			until
				not output_pipe.last_read_successful or Shared_wizard_environment.abort
			loop
				if displayed_while_running then
					message_output.add_continuous_message (Current, output_pipe.last_string)
				else
					a_output.append (output_pipe.last_string)
					message_output.refresh
				end
				output_pipe.read_stream (Block_size)
			end
			if not displayed_while_running then
				a_output.replace_substring_all ("%R%N", "%N")
				message_output.add_message (Current, a_output)
			end
			if not Shared_wizard_environment.abort then
				an_integer := cwin_wait_for_single_object (process_info.process_handle, cwin_infinite)
				check
					valid_external_call_1: an_integer = cwin_wait_object_0
				end
				a_boolean := cwin_exit_code_process (process_info.process_handle, $a_last_process_result)
				check
					valid_external_call_2: a_boolean
				end
			end
			cwin_close_handle (process_info.process_handle)
			output_pipe.close_output
			input_pipe.close_input
			input_pipe.close_output
			last_process_result := a_last_process_result
		end
		
feature -- Access

	message_output: WIZARD_MESSAGE_OUTPUT
			-- Output processor

	last_launch_successful: BOOLEAN
			-- Was last call to `launch' successful (i.e. was process started)?
		
	last_process_result: INTEGER
			-- Last launched process return value

feature {NONE} -- Implementation

	input_pipe: WIZARD_PIPE
			-- Input redirection pipe

	output_pipe: WIZARD_PIPE
			-- Output redirection pipe

	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		do
			create input_pipe.make
			create output_pipe.make
			create Result.make
			Result.set_flags (Startf_use_std_handles)
			Result.set_show_command (Sw_hide)
			Result.add_flag (Startf_use_show_window)
			Result.set_std_input (input_pipe.input_handle)
			Result.set_std_output(output_pipe.input_handle)
			Result.set_std_error (output_pipe.input_handle)
		end

	process_info: WEL_PROCESS_INFO
			-- Process information

	Console_spawn_application: STRING is 
			-- Console spawn application name
		once
			create Result.make (50)
			Result.append ("%"")
			Result.append (Eiffel4_location)
			Result.append ( "\wizards\com\conspawn.exe")
			Result.append ("%"")			
		end

	Block_size: INTEGER is 255
			-- Read block size

feature {NONE} -- Externals

	cwin_close_handle (a_handle: INTEGER) is
			-- SDK CloseHandle
		external
			"C [macro <winbase.h>] (HANDLE)"
		alias
			"CloseHandle"
		end

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN is
			-- SDK CreateProcess
		external
			"C [macro <winbase.h>] (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN"
		alias
			"CreateProcess"
		end

	cwin_wait_for_single_object (handle, type: INTEGER): INTEGER is
		external
			"C [macro <winbase.h>] (HANDLE, DWORD): EIF_INTEGER"
		alias
			"WaitForSingleObject"
		end
		
	cwin_exit_code_process (handle: INTEGER; ptr: POINTER): BOOLEAN is
		external
			"C [macro <winbase.h>] (HANDLE, LPDWORD): EIF_BOOLEAN"
		alias
			"GetExitCodeProcess"
		end

	cwin_wait_object_0: INTEGER is
			-- SDK WAIT_OBJECT_0 constant
		external
			"C [macro <windows.h>]: EIF_INTEGER"
		alias
			"WAIT_OBJECT_0"
		end
	
	cwin_infinite: INTEGER is
			-- SDK INFINITE constant
		external
			"C [macro <winbase.h>]: EIF_INTEGER"
		alias
			"INFINITE"
		end

invariant

	non_void_ouptut_message: message_output /= Void
	
end -- class PROCESS_LAUNCHER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  	