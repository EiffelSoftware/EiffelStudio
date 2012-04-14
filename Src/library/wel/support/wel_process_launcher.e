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

	set_environment_variables (a_env_vars: like environment_variables)
			-- Set `environment_variables' with `a_env_vars'
		do
			environment_variables := a_env_vars
		ensure
			environment_variables_set: environment_variables = a_env_vars
		end

	run_hidden
			-- Should process be run hidden?
		do
			hidden := True
		ensure
			hidden: hidden
		end

feature -- Basic Operations

	spawn (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		do
			spawn_with_flags (a_command_line, a_working_directory, detached_process)
		end

	spawn_with_console (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		do
			spawn_with_flags (a_command_line, a_working_directory, create_new_console)
		end

	launch (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_output_handler: detachable ROUTINE [ANY, TUPLE [STRING]])
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Wait for end of process and send output to `a_output_handler' if not void.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			l_block_size: INTEGER
			l_tuple: TUPLE [str: STRING]
			l_last_string: detachable READABLE_STRING_GENERAL
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
			last_launch_successful := {WEL_API}.wait_for_single_object (l_process_info.process_handle,
				{WEL_API}.infinite) = {WEL_API}.wait_object_0
			if last_launch_successful then
				last_launch_successful := {WEL_API}.get_exit_code_process (l_process_info.process_handle,
					$last_process_result)
			end
			if {WEL_API}.close_handle (l_process_info.thread_handle) = 0 then
				check close_thread_handle_success: False end
			end
			l_process_info.set_thread_handle (default_pointer)
			if {WEL_API}.close_handle (l_process_info.process_handle) = 0 then
				check close_process_handle_success: False end
			end
			l_process_info.set_process_handle (default_pointer)
			l_output_pipe.close_output

			l_input_pipe := input_pipe
			check l_input_pipe /= Void end
			l_input_pipe.close_input
			l_input_pipe.close_output
		end

	launch_and_refresh (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_refresh_handler: detachable ROUTINE [ANY, TUPLE])
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
				a_boolean := {WEL_API}.get_exit_code_process (l_process_info.process_handle, $last_process_result)
				check
					valid_external_call_2: a_boolean
				end
				if last_process_result = {WEL_API}.still_active then
					an_integer := {WEL_API}.wait_for_single_object (l_process_info.process_handle, 1)
					if an_integer = {WEL_API}.wait_object_0 then
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
				check l_process_info /= Void end
				l_boolean := {WEL_API}.get_exit_code_process (l_process_info.process_handle, $last_process_result)
				if l_boolean then
					if last_process_result = {WEL_API}.still_active then
						l_boolean := {WEL_API}.terminate_process (l_process_info.process_handle, 0)
					end
					if {WEL_API}.close_handle (l_process_info.thread_handle) = 0 then
						check close_thread_handle_success: False end
					end
					l_process_info.set_thread_handle (default_pointer)
					if {WEL_API}.close_handle (l_process_info.process_handle) = 0 then
						check close_process_handle_success: False end
					end
					l_process_info.set_process_handle (default_pointer)
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

	environment_variables: detachable HASH_TABLE [STRING, STRING]
			-- Table of environment variables to be passed to new process.
			-- Key is variable name and value is the value of the variable.
			-- If this table is Void or empty, environment variables of the
			-- parent process will be passed to the new process.

feature {NONE} -- Implementation

	spawn_with_flags (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_flags: INTEGER)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			a_wel_string1, a_wel_string2: WEL_STRING
			l_process_info: like process_info
			l_envs: detachable C_STRING
			l_envs_ptr: POINTER
		do
			create process_info.make
			create a_wel_string1.make (a_command_line)
			l_process_info := process_info
			check l_process_info /= Void end
			l_envs := environment_variables_as_c_string
			if l_envs /= Void then
				l_envs_ptr := l_envs.item
			end
			if a_working_directory /= Void and then not a_working_directory.is_empty then
				create a_wel_string2.make (a_working_directory)
				last_launch_successful := {WEL_API}.create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, a_flags,
							l_envs_ptr, a_wel_string2.item,
							startup_info.item, l_process_info.item)
			else
				last_launch_successful := {WEL_API}.create_process (default_pointer, a_wel_string1.item,
							default_pointer, default_pointer, True, a_flags,
							l_envs_ptr, default_pointer,
							startup_info.item, l_process_info.item)
			end
		end

	environment_variables_as_c_string: detachable C_STRING
			-- {POINTER} representation of `environment_variables'
			-- Return `default_pointer' if `environment_variables' is Void or empty.
		local
			l_str: STRING
			l_tbl: like environment_variables
		do
			l_tbl := environment_variables
			if l_tbl /= Void and then not l_tbl.is_empty then
				create l_str.make (512)
				from
					l_tbl.start
				until
					l_tbl.after
				loop
					if l_tbl.key_for_iteration /= Void and then l_tbl.item_for_iteration /= Void then
						l_str.append (l_tbl.key_for_iteration)
						l_str.append_character ('=')
						l_str.append (l_tbl.item_for_iteration)
						l_str.append_character ('%U')
					end
					l_tbl.forth
				end
				l_str.append_character ('%U')
				create {C_STRING} Result.make (l_str)
			end
		end

	input_pipe: detachable WEL_PIPE
			-- Input redirection pipe

	output_pipe: detachable WEL_PIPE
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

	process_info: detachable WEL_PROCESS_INFO
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
		obsolete
			"Use {WEL_API}.close_handle instead."
		do
			if {WEL_API}.close_handle (a_handle) = 0 then
				check close_handle_success: False end
			end
		end

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN
			-- SDK CreateProcess
		obsolete
			"Use {WEL_API}.create_process instead."
		do
			Result := {WEL_API}.create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2,
				a_herit_handles, a_flags, an_environment, a_directory, a_startup_info, a_process_info)
		end

	cwin_wait_for_single_object (handle: POINTER; type: INTEGER): INTEGER
		obsolete
			"Use {WEL_API}.wait_for_single_object instead."
		do
			Result := {WEL_API}.wait_for_single_object (handle, type)
		end

	cwin_exit_code_process (handle: POINTER; ptr: POINTER): BOOLEAN
		obsolete
			"Use {WEL_API}.get_exit_code_process instead."
		do
			Result := {WEL_API}.get_exit_code_process (handle, ptr)
		end

	cwin_wait_object_0: INTEGER
			-- SDK WAIT_OBJECT_0 constant
		obsolete
			"Use {WEL_API}.wait_object_0 instead."
		do
			Result := {WEL_API}.wait_object_0
		end

	cwin_infinite: INTEGER
			-- SDK INFINITE constant
		obsolete
			"Use {WEL_API}.infinite instead."
		do
			Result := {WEL_API}.infinite
		end

	cwin_terminate_process (handle: POINTER; exit_code: INTEGER): BOOLEAN
			-- SDK TerminateProcess
		obsolete
			"Use {WEL_API}.terminate_process instead."
		do
			Result := {WEL_API}.terminate_process (handle, exit_code)
		end

	cwin_still_active: INTEGER
			-- SDK STILL_ACTIVE constant
		obsolete
			"Use {WEL_API}.still_active instead."
		do
			Result := {WEL_API}.still_active
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
