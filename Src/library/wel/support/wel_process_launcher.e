note
	description: "[
					Launch processes and redirect output:
					  - Use `spawn' to launch a process asynchronously.
					  		Note: you cannot retrieve the ouput from a
					  		process that was spawned
					  - Use `launch' to launch a process synchronously
					  		and process its output if needed.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_LAUNCHER

inherit
	ANY

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

feature -- Element settings

	set_block_size (a_size: INTEGER)
			-- Set `block_size' woth `a_size'
		require
			valid_size: a_size > 0
		do
			internal_block_size := a_size
		ensure
			size_set: block_size = a_size
		end

	run_hidden
			-- Should process be run hidden?
		do
			hidden := True
		ensure
			hidden: hidden
		end

feature -- Basic Operations

	spawn (a_command_line, a_working_directory: ?STRING_GENERAL)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		do
			spawn_with_flags (a_command_line, a_working_directory, detached_process)
		end

	spawn_with_console (a_command_line, a_working_directory: ?STRING_GENERAL)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		do
			spawn_with_flags (a_command_line, a_working_directory, create_new_console)
		end

	launch (a_command_line: STRING_GENERAL; a_working_directory: ?STRING_GENERAL; a_output_handler: ?ROUTINE [ANY, TUPLE [STRING]])
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Wait for end of process and send output to `a_output_handler' if not void.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			l_block_size: INTEGER
			l_tuple: TUPLE [str: STRING]
			l_last_string: ?STRING_GENERAL
			l_input_pipe: like input_pipe
			l_output_pipe: like output_pipe
			l_process_info: like process_info
		do
			create l_tuple
			if hidden then
				spawn_with_flags (a_command_line, a_working_directory, create_no_window)
			else
				spawn (a_command_line, a_working_directory)
			end
			l_output_pipe := output_pipe
			check l_output_pipe /= Void end
			l_output_pipe.close_input
			l_block_size := Block_size
			from
				l_output_pipe.read_stream (l_block_size)
			until
				not l_output_pipe.last_read_successful
			loop
				if a_output_handler /= Void then
					l_last_string := l_output_pipe.last_string
					check l_last_string /= Void end
					l_tuple.str := l_last_string.as_string_8
					a_output_handler.call (l_tuple)
				end
				l_output_pipe.read_stream (l_block_size)
			end
			l_process_info := process_info
			check l_process_info /= Void end
			last_launch_successful := cwin_wait_for_single_object (l_process_info.process_handle,
				cwin_infinite) = cwin_wait_object_0
			if last_launch_successful then
				last_launch_successful := cwin_exit_code_process (l_process_info.process_handle,
					$last_process_result)
			end
			cwin_close_handle (l_process_info.process_handle)
			l_output_pipe.close_output

			l_input_pipe := input_pipe
			check l_input_pipe /= Void end
			l_input_pipe.close_input
			l_input_pipe.close_output
		end

	launch_and_refresh (a_command_line: STRING_GENERAL; a_working_directory: ?STRING_GENERAL; a_refresh_handler: ?ROUTINE [ANY, TUPLE])
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Calls `a_refresh_handler' regularly while waiting for end of process.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			an_integer: INTEGER
			a_boolean: BOOLEAN
			finished: BOOLEAN
			l_process_info: like process_info
		do
			spawn (a_command_line, a_working_directory)
			from
			until
				finished
			loop
				l_process_info := process_info
				check l_process_info /= Void end
				a_boolean := cwin_exit_code_process (l_process_info.process_handle,
					$last_process_result)
				check
					valid_external_call_2: a_boolean
				end
				if last_process_result = cwin_still_active then
					an_integer := cwin_wait_for_single_object (l_process_info.process_handle, 1)
					if an_integer = cwin_wait_object_0 then
						finished := True
					else
						if a_refresh_handler /= Void then
							a_refresh_handler.call (Void)
						end
					end
				else
					finished := True
				end
			end
			terminate_process
		end

	terminate_process
			-- Terminate current process (corresponding to `process_info').
		local
			l_boolean: BOOLEAN
			l_process_info: like process_info
		do
			if last_launch_successful then
				l_process_info := process_info
				check l_process_info /= VOid end
				l_boolean := cwin_exit_code_process (l_process_info.process_handle, $last_process_result)
				if l_boolean then
					if last_process_result = cwin_still_active then
						l_boolean := cwin_terminate_process (l_process_info.process_handle, 0)
					end
					cwin_close_handle (l_process_info.thread_handle)
					cwin_close_handle (l_process_info.process_handle)
				end
			end
		end

feature -- Access

	last_launch_successful: BOOLEAN
			-- Was last call to `launch' successful (i.e. was process started)?

	last_process_result: INTEGER
			-- Last launched process return value

	hidden: BOOLEAN
			-- Should process be hidden?

feature {NONE} -- Implementation

	spawn_with_flags (a_command_line: STRING_GENERAL; a_working_directory: ?STRING_GENERAL; a_flags: INTEGER)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			a_wel_string1, a_wel_string2: WEL_STRING
			l_process_info: like process_info
		do
			create process_info.make
			create a_wel_string1.make (a_command_line)
			l_process_info := process_info
			check l_process_info /= Void end
			if a_working_directory /= Void and then not a_working_directory.is_empty then
				create a_wel_string2.make (a_working_directory)
				last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, a_flags,
							default_pointer, a_wel_string2.item,
							startup_info.item, l_process_info.item)
			else
				last_launch_successful := cwin_create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, a_flags,
							default_pointer, default_pointer,
							startup_info.item, l_process_info.item)
			end
		end

	input_pipe: ?WEL_PIPE
			-- Input redirection pipe

	output_pipe: ?WEL_PIPE
			-- Output redirection pipe

	startup_info: WEL_STARTUP_INFO
			-- Process startup information
		local
			l_input_pipe: like input_pipe
			l_output_pipe: like output_pipe
		do
			create l_input_pipe.make
			input_pipe := l_input_pipe
			create l_output_pipe.make
			output_pipe := l_output_pipe
			create Result.make
			Result.set_flags (Startf_use_std_handles)
			if hidden then
				Result.set_show_command (Sw_hide)
			else
				Result.set_show_command (Sw_show)
			end
			Result.add_flag (Startf_use_show_window)
			Result.set_std_input (l_input_pipe.input_handle)
			Result.set_std_output(l_output_pipe.input_handle)
			Result.set_std_error (l_output_pipe.input_handle)
		ensure
			result_attached: Result /= Void
		end

	process_info: ?WEL_PROCESS_INFO
			-- Process information

	Default_block_size: INTEGER = 255
			-- Default output block size

	Block_size: INTEGER
			-- Read block size
		do
			Result := internal_block_size
			if Result = 0 then
				Result := Default_block_size
				internal_block_size := Result
			end
		end

	internal_block_size: INTEGER
			-- Output block size

feature {NONE} -- Externals

	cwin_close_handle (a_handle: POINTER)
			-- SDK CloseHandle
		external
			"C [macro <winbase.h>] (HANDLE)"
		alias
			"CloseHandle"
		end

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN
			-- SDK CreateProcess
		external
			"C [macro <winbase.h>] (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN"
		alias
			"CreateProcess"
		end

	cwin_wait_for_single_object (handle: POINTER; type: INTEGER): INTEGER
		external
			"C blocking macro signature (HANDLE, DWORD): EIF_INTEGER use <windows.h>"
		alias
			"WaitForSingleObject"
		end

	cwin_exit_code_process (handle: POINTER; ptr: POINTER): BOOLEAN
		external
			"C [macro <winbase.h>] (HANDLE, LPDWORD): EIF_BOOLEAN"
		alias
			"GetExitCodeProcess"
		end

	cwin_wait_object_0: INTEGER
			-- SDK WAIT_OBJECT_0 constant
		external
			"C blocking macro use <windows.h>"
		alias
			"WAIT_OBJECT_0"
		end

	cwin_infinite: INTEGER
			-- SDK INFINITE constant
		external
			"C [macro <winbase.h>]: EIF_INTEGER"
		alias
			"INFINITE"
		end

	cwin_terminate_process (handle: POINTER; exit_code: INTEGER): BOOLEAN
			-- SDK TerminateProcess
		external
			"C [macro <winbase.h>] (HANDLE, DWORD): EIF_BOOLEAN"
		alias
			"TerminateProcess"
		end

	cwin_still_active: INTEGER
			-- SDK STILL_ACTIVE constant
		external
			"C [macro <windows.h>]: EIF_INTEGER"
		alias
			"STILL_ACTIVE"
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class PROCESS_LAUNCHER

