indexing
	description: "[
					Launch processes and redirect output:
					  - Use `spawn' to launch a process asynchronously.
					  		Note: you cannot retrieve the ouput from a
					  		process that was spawned
					  - Use `launch' to launch a process synchronously
					  		and process its output if needed.
					]"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_LAUNCHER

inherit
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

feature -- Basic Operations

	spawn (a_command_line, a_working_directory: STRING) is
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
			non_void_working_directory: a_working_directory /= Void
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create process_info.make
			create a_wel_string1.make (a_command_line)	
			if not a_working_directory.is_empty then
				create a_wel_string2.make (a_working_directory)
				last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, cwin_detached_process, default_pointer, a_wel_string2.item,
							startup_info.item, process_info.item)
			else
				last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, detached_process, default_pointer, default_pointer,
							startup_info.item, process_info.item)
			end
		end

	launch (a_command_line, a_working_directory: STRING; a_output_handler: ROUTINE [ANY, TUPLE [STRING]]) is
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Wait for end of process and send output to `a_output_handler' if not void.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
			non_void_working_directory: a_working_directory /= Void
		do
			spawn (a_command_line, a_working_directory)
			output_pipe.close_input
			from
				output_pipe.read_stream (Block_size)
			until
				not output_pipe.last_read_successful
			loop
				if a_output_handler /= Void then
					a_output_handler.call ([output_pipe.last_string])
				end
				output_pipe.read_stream (Block_size)
			end
			last_launch_successful := cwin_wait_for_single_object (process_info.process_handle, cwin_infinite) = cwin_wait_object_0
			if last_launch_successful then
				last_launch_successful := cwin_exit_code_process (process_info.process_handle, $last_process_result)
			end
			cwin_close_handle (process_info.process_handle)
			output_pipe.close_output
			input_pipe.close_input
			input_pipe.close_output
		end
	
	launch_and_refresh (a_command_line, a_working_directory: STRING; a_refresh_handler: ROUTINE [ANY, TUPLE]) is
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Calls `a_refresh_handler' regularly while waiting for end of process.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
			non_void_working_directory: a_working_directory /= Void
		local
			an_integer: INTEGER
			a_boolean: BOOLEAN
			finished: BOOLEAN
		do
			spawn (a_command_line, a_working_directory)
			from
			until
				finished
			loop
				a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
				check
					valid_external_call_2: a_boolean
				end
				if last_process_result = cwin_still_active then
					an_integer := cwin_wait_for_single_object (process_info.process_handle, 1)
					if an_integer = cwin_wait_object_0 then
						finished := True
					else
						if a_refresh_handler /= Void then
							a_refresh_handler.call (create {TUPLE}.make)
						end
					end
				else
					finished := True
				end
			end
			terminate_process			
		end
			
feature -- Access

	last_launch_successful: BOOLEAN
			-- Was last call to `launch' successful (i.e. was process started)?
		
	last_process_result: INTEGER
			-- Last launched process return value

feature {NONE} -- Implementation

	input_pipe: WEL_PIPE
			-- Input redirection pipe

	output_pipe: WEL_PIPE
			-- Output redirection pipe

	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		do
			create input_pipe.make
			create output_pipe.make
			create Result.make
			Result.set_flags (Startf_use_std_handles)
		--	Result.set_show_command (Sw_hide)
		--	Result.add_flag (Startf_use_show_window)
			Result.set_std_input (input_pipe.input_handle)
			Result.set_std_output(output_pipe.input_handle)
			Result.set_std_error (output_pipe.input_handle)
		end

	process_info: WEL_PROCESS_INFO
			-- Process information

	Block_size: INTEGER is 255
			-- Read block size

	terminate_process is
			-- Terminate current process (corresponding to `process_info').
		local
			a_boolean: BOOLEAN
			terminated: BOOLEAN		
		do
			a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
			check
				valid_external_call_2: a_boolean
			end
			cwin_close_handle (process_info.process_handle)
			if last_process_result = cwin_still_active then
				terminated := cwin_terminate_process (process_info.process_handle, 0)
				check
					valid_external_call_3: terminated
				end
			end
		end

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

	cwin_terminate_process (handle, exit_code: INTEGER): BOOLEAN is
			-- SDK TerminateProcess
		external
			"C [macro <winbase.h>] (HANDLE, DWORD): EIF_BOOLEAN"
		alias
			"TerminateProcess"
		end

	cwin_still_active: INTEGER is
			-- SDK STILL_ACTIVE constant
		external
			"C [macro <windows.h>]: EIF_INTEGER"
		alias
			"STILL_ACTIVE"
		end

	cwin_detached_process: INTEGER is
			-- SDK DETACHED_PROCESS constant
		external
			"C [macro <winbase.h>]: EIF_INTEGER"
		alias
			"DETACHED_PROCESS"
		end
		
end -- class PROCESS_LAUNCHER


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

