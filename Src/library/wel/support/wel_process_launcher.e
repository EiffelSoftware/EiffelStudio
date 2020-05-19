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
			-- Set `block_size' with `a_size'.
		require
			valid_size: a_size > 0
		do
			internal_block_size := a_size
		ensure
			size_set: block_size = a_size
		end

	set_environment_variables (a_env_vars: like environment_variables)
			-- Set `environment_variables' with `a_env_vars'.
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

	launch (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_output_handler: detachable ROUTINE [STRING_8])
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Wait for end of process and send output to `a_output_handler' if not void.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			l_block_size: INTEGER
			l_input_pipe: like input_pipe
			l_output_pipe: like output_pipe
		do
			if hidden then
				spawn_with_flags (a_command_line, a_working_directory, create_no_window)
			else
				spawn (a_command_line, a_working_directory)
			end
				-- Per postcondition
			l_output_pipe := output_pipe
			check l_output_pipe /= Void then end
			l_output_pipe.close_input
			l_block_size := Block_size
			from
				l_output_pipe.read_stream (l_block_size)
			until
				not l_output_pipe.last_read_successful
			loop
				if a_output_handler /= Void and attached l_output_pipe.last_string as l_last_string then
					a_output_handler.call ([l_last_string])
				end
				l_output_pipe.read_stream (l_block_size)
			end
			if
				attached process_handle as p and then
				attached thread_handle as t
			then
				if {WEL_API}.wait_for_single_object (p.item, {WEL_API}.infinite) = {WEL_API}.wait_object_0 then
					last_launch_successful := {WEL_API}.get_exit_code_process (p.item, $last_process_result)
				else
					last_launch_successful := False
				end
				t.close
				p.close
			else
				last_launch_successful := False
			end
			l_output_pipe.close_output

			l_input_pipe := input_pipe
			check l_input_pipe /= Void then end
			l_input_pipe.close_input
			l_input_pipe.close_output
		end

	launch_and_refresh (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_refresh_handler: detachable ROUTINE)
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Calls `a_refresh_handler' regularly while waiting for end of process.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			an_integer: INTEGER
			a_boolean: BOOLEAN
			finished: BOOLEAN
		do
			spawn (a_command_line, a_working_directory)
				-- Per postcondition
			check attached process_handle as h then
				from
				until
					finished
				loop
					a_boolean := {WEL_API}.get_exit_code_process (h.item, $last_process_result)
					check
						valid_external_call_2: a_boolean
					end
					if last_process_result = {WEL_API}.still_active then
						an_integer := {WEL_API}.wait_for_single_object (h.item, 1)
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
			end
			terminate_process
		end

	terminate_process
			-- Terminate current process.
		do
			if
				attached process_handle as p and then p.is_open and then
				attached thread_handle as t
			then
				if {WEL_API}.get_exit_code_process (p.item, $last_process_result) then
					if last_process_result = {WEL_API}.still_active then
						{WEL_API}.terminate_process (p.item, 0).do_nothing
					end
					if t.is_open then
						t.close
					end
					thread_handle := Void
					p.close
					process_handle := Void
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

	environment_variables: detachable HASH_TABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]
			-- Table of environment variables to be passed to new process.
			-- Key is variable name and value is the value of the variable.
			-- If this table is Void or empty, environment variables of the
			-- parent process will be passed to the new process.

	process_handle: detachable WEL_HANDLE
			-- Handle of the launched process.

	thread_handle: detachable WEL_HANDLE
			-- Handle of the launched process main thread.

	process_id: NATURAL_32
			-- Process ID when it is started.

feature {NONE} -- Implementation

	spawn_with_flags (a_command_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_flags: INTEGER)
			-- Spawn asynchronously process described in `a_command_line' from `a_working_directory'.
			-- The new process is passed environment variables from `environment_variables' if set
			-- or from the environment of the current process, in which case it is assumed to be in Unicode rather than ANSI.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
		local
			l_ws_command_line, l_ws_working_directory: WEL_STRING
			l_process_info: WEL_PROCESS_INFO
			l_envs: detachable WEL_STRING
			l_envs_ptr: POINTER
			l_directory: POINTER
			b: BOOLEAN
		do
			create l_ws_command_line.make (a_command_line)
			create l_process_info.make
			l_envs := environment_variables_as_wel_string
			if l_envs /= Void then
				l_envs_ptr := l_envs.item
			end
			if a_working_directory /= Void and then not a_working_directory.is_empty then
				create l_ws_working_directory.make (a_working_directory)
				l_directory := l_ws_working_directory.item
			end
			b := {WEL_API}.create_process (default_pointer, l_ws_command_line.item,
					default_pointer, default_pointer, True, a_flags | create_unicode_environment,
					l_envs_ptr, l_directory,
					startup_info.item, l_process_info.item)
			last_launch_successful := b
			if b then
				create process_handle.make (l_process_info.process_handle)
				create thread_handle.make (l_process_info.thread_handle)
				process_id := l_process_info.process_id.as_natural_32
			end
		end

	environment_variables_as_wel_string: detachable WEL_STRING
			-- {POINTER} representation of `environment_variables'
			-- Return `default_pointer' if `environment_variables' is Void or empty.
		local
			l_str: STRING_32
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
						l_str.append (l_tbl.key_for_iteration.to_string_32)
						l_str.append_character ('=')
						l_str.append (l_tbl.item_for_iteration.to_string_32)
						l_str.append_character ('%U')
					end
					l_tbl.forth
				end
				l_str.append_character ('%U')
				create Result.make (l_str)
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
			-- Output block size.

;note
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
