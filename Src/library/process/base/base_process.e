note
	description: "[
			Interface of a multi-platform process launcher(on Win32, .Net and Unix/Linux)
			Instance of this class is not guaranteed to be thread safe.
			Usage:
				1. Use {BASE_PROCESS_FACTORY} to get new {BASE_PROCESS} object.
				2. Invoke IO redirection features to redirect io to certain devices. By default,
				   IO of launched process is not redirected.
				3. Invoke `launch' to launch process.
				4. You can use `has_exited' to check the status of launched process or use `wait_for_exit'
				   to wait for launched process.
				5. To release allocated resources promptly, call `wait_for_exit` (or a version with timeout),
				   `terminate` (possibly for the whole tree) or `close`.
			Note: Make sure that launched process has exited before you exit you application.
		]"
	performance: "[
			On Windows the pair of calls to `launch` and `wait_for_exit` runs 4.5 times faster
			than a call to `{EXECUTION_ENVIRONMENT}.system.
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASE_PROCESS

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature {NONE} -- Creation

	make (executable_name: READABLE_STRING_GENERAL; argument_list: detachable ITERABLE [READABLE_STRING_GENERAL]; work_directory: detachable READABLE_STRING_GENERAL)
			-- Create process object with `executable_name' as executable with arguments `argument_list'
			-- and with working directory `work_directory'.
			-- Apply Void to `a_working_directory' if no working directory is specified.
			-- Apply Void to `args' if no argument is necessary.
		require
			executable_name_attached: attached executable_name
			executable_name_not_empty: not executable_name.is_empty
			arguments_attached: attached argument_list as args implies ∀ a: args ¦ attached a
		deferred
		ensure
			command_line_not_empty: command_line /= Void and then not command_line.is_empty
			working_directory_set: attached work_directory implies
				attached working_directory as w and then w.same_string_general (work_directory)
			working_directory_set: attached work_directory = attached working_directory
			initialized: parameter_initialized
		end

	make_with_command_line (cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL)
			-- Create process object with `cmd_line' as command line in which executable and
			-- arguments are included and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.
		require
			command_line_not_void: cmd_line /= Void
			command_line_not_empty: not cmd_line.is_empty
		deferred
		ensure
			command_line_not_empty: command_line /= Void and then not command_line.is_empty
			working_directory_set: a_working_directory /= Void implies
				(attached working_directory as l_wd and then l_wd.same_string_general (a_working_directory))
			working_directory_set: a_working_directory = Void implies working_directory = Void
			initialized: parameter_initialized
		end

feature -- IO redirection

	redirect_input_to_stream
			-- Redirect input stream of process to its parent's stream
			-- so you can use `put_string' to send data into process.
		require
			process_not_running: not is_running
		do
			input_direction := {BASE_REDIRECTION}.to_stream
			input_file_name := Void
		ensure
			input_redirected_to_stream:
				input_direction = {BASE_REDIRECTION}.to_stream
			input_file_name_void: input_file_name = Void
		end

	redirect_input_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- Redirect input stream of process to a file
			-- with name`a_file_name'.
		require
			process_not_running: not is_running
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		do
			input_direction := {BASE_REDIRECTION}.to_file
			create input_file_name.make_from_string_general (a_file_name)
		ensure
			input_redirectd_to_file:
				input_direction = {BASE_REDIRECTION}.to_file
			input_file_name_set: attached input_file_name as l_file_name and then l_file_name.same_string_general (a_file_name)
		end

	cancel_input_redirection
			-- Cancel input redirection.
		require
			process_not_running: not is_running
		do
			input_direction := {BASE_REDIRECTION}.no_redirection
			create input_file_name.make_empty
		ensure
			input_redirection_canceled:
				input_direction = {BASE_REDIRECTION}.no_redirection
			input_file_name_set: input_file_name ~ ""
		end

	redirect_output_to_stream
			-- Redirect output stream of the process to its parent's stream
			-- so you can use `read_output_stream' to read data from the process.
		require
			process_not_running: not is_running
		do
			output_direction := {BASE_REDIRECTION}.to_stream
			output_file_name := Void
		ensure
			output_redirected_to_stream:
				output_direction = {BASE_REDIRECTION}.to_stream
			output_file_name_unset: output_file_name = Void
		end

	redirect_output_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- Redirect output stream of process to a file
			-- with name `a_file_name'.
		require
			process_not_running: not is_running
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			output_and_error_file_not_same: attached error_file_name as l_fn implies
				not l_fn.same_string_general (a_file_name)
		do
			output_direction := {BASE_REDIRECTION}.to_file
			create output_file_name.make_from_string_general (a_file_name)
		ensure
			output_redirected_to_file:
				output_direction = {BASE_REDIRECTION}.to_file
			output_file_name_set: attached output_file_name as fn and then fn.same_string_general (a_file_name)
		end

	cancel_output_redirection
			-- Cancel output redirection.
		require
			process_not_running: not is_running
		do
			output_direction := {BASE_REDIRECTION}.no_redirection
			create output_file_name.make_empty
		ensure
			output_redirection_canceled:
				output_direction = {BASE_REDIRECTION}.no_redirection
			output_file_name_set: attached output_file_name as l_file_name and then l_file_name.is_empty
		end

	redirect_error_to_stream
			-- Redirect error stream of the process to its parent's stream
			-- so you can use `read_error_stream' to read data from the process.
		require
			process_not_running: not is_running
		do
			error_direction := {BASE_REDIRECTION}.to_stream
			error_file_name := Void
		ensure
			error_redirected_to_stream:
				error_direction = {BASE_REDIRECTION}.to_stream
			error_file_name_unset: error_file_name = Void
		end

	redirect_error_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- Redirect the error stream of process to a file.
		require
			process_not_running: not is_running
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			output_and_error_file_not_same: attached output_file_name as l_fn implies
				not l_fn.same_string_general (a_file_name)
		do
			error_direction := {BASE_REDIRECTION}.to_file
			create error_file_name.make_from_string_general (a_file_name)
		ensure
			error_redirected_to_file:
				error_direction = {BASE_REDIRECTION}.to_file
			error_file_set: attached error_file_name as fn and then fn.same_string_general (a_file_name)
		end

	redirect_error_to_same_as_output
			-- Redirect output and error to the same location.
			-- Not applicable on .NET.
		require
			not_on_dotnet_platform: not platform.is_dotnet
			process_not_running: not is_running
		do
			if not platform.is_dotnet then
				error_direction := {BASE_REDIRECTION}.to_same_as_output
				error_file_name := Void
			end
		ensure
			error_redirected_to_same_as_output:
				error_direction = {BASE_REDIRECTION}.to_same_as_output
			error_file_name_set: error_file_name = Void
		end

	cancel_error_redirection
			-- Cancel error redirection.
		require
			process_not_running: not is_running
		do
			error_direction := {BASE_REDIRECTION}.no_redirection
			create error_file_name.make_empty
		ensure
			error_redirection_canceled:
				error_direction = {BASE_REDIRECTION}.no_redirection
			error_file_name_set: attached error_file_name as l_file_name and then l_file_name.is_empty
		end

	enable_terminal_control
			-- Make sure that launched process has terminal control over standard input, output and error.
			-- Has effect only on Unix and only when `is_launched_in_new_process_group' is True.
		require
			process_not_running: not is_running
		do
			is_terminal_control_enabled := True
		ensure
			terminal_control_enabled: is_terminal_control_enabled
		end

	disable_terminal_control
			-- Make sure that launched process doesn't has terminal control over standard input, output and error.
			-- Has effect only on Unix.
		require
			process_not_running: not is_running
		do
			is_terminal_control_enabled := False
		ensure
			is_terminal_control_disabled: not is_terminal_control_enabled
		end

feature -- Control

	launch
			-- Launch process.
		require
			process_not_running: not is_running
			input_redirection_valid: is_input_redirection_valid (input_direction)
			output_redirection_valid: is_output_redirection_valid (output_direction)
			error_redirection_valid: is_error_redirection_valid (error_direction)
		do
			launched := False
			on_start
			platform_launch
			if launched then
				has_process_exited := False
				force_terminated := False
				last_termination_successful := True
				has_exited := False
				initialize_after_launch
				on_launch_successed
			else
				on_launch_failed
			end
		end

	terminate
			-- Terminate launched process.
			-- Check `last_termination_successful' after to see if `terminate' succeeded.
			-- `terminate' executes asynchronously. After calling `terminate', call `wait_to_exit'
			-- to wait for process to exit.
		require
			process_launched: launched
			process_not_terminated: not force_terminated
		deferred
		end

	terminate_tree
			-- Terminate process tree starting from current launched process.
			-- Check `last_termination_successful' after to see if `terminate_tree' succeeded.
			-- `terminate_tree' executes asynchronously. After calling `terminate', call `wait_to_exit'
			-- to wait for process to exit.
			-- Note: on Unix, this feature can terminate whole process tree only when `is_launched_in_new_process_group' is set to True
			-- before new process is launched.
		require
			process_launched: launched
			process_not_terminated: not force_terminated
		deferred
		end

	wait_for_exit
			-- Wait until process has exited.
			-- Note: child processes of launched process are not guaranteed to have exited after `wait_for_exit' returns.
		require
			process_launched: launched
		deferred
		ensure
			process_exited: has_exited
		end

	wait_for_exit_with_timeout (timeout: INTEGER)
			-- Wait launched process to exit for at most `timeout' milliseconds.
			-- Check `has_exited' after to see if launched process has exited.
			-- Note: child processes of launched process are not guaranteed to have exited
			-- even if `has_exited' is `True` after `wait_for_exit_with_timeout`.
		require
			process_launched: launched
			timeout_positive: timeout > 0
		local
			sleep_time: INTEGER_64
			sleep_count: INTEGER
			time_interval: INTEGER
		do
				-- This is an OS-independent version.
				-- A better one can be provided by a redeclaration.
			if timeout > 1_000 then
					-- Use fixed time interval for long timeouts.
				time_interval := 200
			else
					-- Use proportional  time interval for short timeouts.
				time_interval := timeout // 10
					-- Make sure time intervals are not too short.
				if time_interval < 20 then
					time_interval := 20
				end
			end
				-- Compute a number of iterations.
			sleep_count := timeout // time_interval + 1
				-- Normalize `sleep_time` to use nanoseconds.
			sleep_time := time_interval * 1_000_000
			from
			until
				has_exited or sleep_count = 0
			loop
				execution_environment.sleep (sleep_time)
				check_exit
				sleep_count := sleep_count - 1
			end
		end

	close
			-- Close handles associated with child process.
			-- The process may continue running.
			-- If there is any input/output redirection to/from current process, it will be closed.
		require
			launched: launched
		deferred
		end

feature {NONE} -- Control

	platform_launch
			-- Try to launch child process and update `launched' accordingly.
		require
			process_not_running: not is_running
			input_redirection_valid: is_input_redirection_valid (input_direction)
			output_redirection_valid: is_output_redirection_valid (output_direction)
			error_redirection_valid: is_error_redirection_valid (error_direction)
			not_launched: not launched
		deferred
		end

	initialize_after_launch
			-- Actions to be performed after successful launch of a process.
		require
			launched: launched
		deferred
		end

feature -- Interprocess data transmission

	put_string (s: READABLE_STRING_8)
			-- Send `s' into launched process as its input data.
			-- Report result in `has_input_error'.
		require
			input_redirect_to_stream: input_direction = {BASE_REDIRECTION}.to_stream
			process_launched: launched
			string_not_void: s /= Void
		deferred
		end

	has_input_error: BOOLEAN
			-- Was there an error when calling `put_string'?
		attribute
		end

	read_output_to_special (buffer: SPECIAL [NATURAL_8])
			-- Wait for and read data from the process standard output into `buffer` with a maximum of `buffer.count` bytes
			-- and update `buffer.count` with the number of actually read bytes that can range between `0` and `old buffer.count`.
			-- Report result in `has_output_stream_error`.
		require
			output_redirect_to_stream: output_direction = {BASE_REDIRECTION}.to_stream
			process_launched: launched
		deferred
		ensure
			buffer_count_in_range: buffer.count <= old buffer.count
		end

	has_output_stream_error: BOOLEAN
			-- Was there an error when calling `read_output_to_special'?
		attribute
		end

	has_output_stream_closed: BOOLEAN
			-- Was standard output of the process closed?
		attribute
		end

	read_error_to_special (buffer: SPECIAL [NATURAL_8])
			-- Wait for and read data from the process standard error into `buffer` with a maximum of `buffer.count` bytes
			-- and update `buffer.count` with the number of actually read bytes that can range between `0` and `old buffer.count`.
			-- Report result in `has_error_stream_error`.
		require
			error_redirect_to_stream: error_direction = {BASE_REDIRECTION}.to_stream
			process_launched: launched
		deferred
		ensure
			buffer_count_in_range: buffer.count <= old buffer.count
		end

	has_error_stream_error: BOOLEAN
			-- Was there an error when calling `read_error_to_special'?
		attribute
		end

	has_error_stream_closed: BOOLEAN
			-- Was standard error of the process closed?
		attribute
		end

feature {NONE} -- Status update

	check_exit
			-- Check if process has exited.
		do
			if not has_exited then
				if not has_process_exited then
					update_process_state
				end
				if has_process_exited then
					close_process
					has_exited := True
						-- Call registered actions.
					if force_terminated then
						on_terminate
					else
						on_exit
					end
				end
			end
		end

	update_process_state
			-- Check if process has exited and update `has_process_exited' accordingly.
		require
			launched: launched
		deferred
		end

	close_process
			-- Close handles associated with `child_process'.
		require
			has_process_exited: has_process_exited
			launched: launched
		deferred
		end

feature {NONE} -- Status report

	has_process_exited: BOOLEAN
			-- Has external process exited?
			-- Resources allocated by the current process are not taken into account.

feature -- Status setting

	set_hidden (h: BOOLEAN)
			-- Set `is_hidden' with `h'.
			-- Has effects on Windows.
		require
			process_not_running: not is_running
		do
			hidden := h
		ensure
			hidden_flag_set: hidden = h
		end

	set_separate_console (b: BOOLEAN)
			-- Set `separate_console' with `b'.
			-- Has effects on Windows.
		require
			process_not_running: not is_running
		do
			separate_console := b
		ensure
			separate_console_set: separate_console = b
		end

	set_detached_console (b: BOOLEAN)
			-- Set `detached_console' with `b'.
			-- Has effects on Windows.
		require
			process_not_running: not is_running
		do
			detached_console := b
		ensure
			detached_console_set: detached_console = b
		end

	set_abort_termination_when_failed (b: BOOLEAN)
			-- Set `abort_termination_when_failed' with `b'.
		require
			process_not_running: not is_running
		do
			abort_termination_when_failed := b
		ensure
			abort_termination_when_failed_set: abort_termination_when_failed = b
		end

	set_environment_variable_table (a_table: like environment_variable_table)
			-- Set `environment_variable_table' with `a_table'.
		require
			process_not_running: not is_running
		do
			environment_variable_table := a_table
		ensure
			environment_variable_table_set: environment_variable_table = a_table
		end

	set_environment_variables (a_table: HASH_TABLE [NATIVE_STRING, READABLE_STRING_GENERAL])
			-- Set `environment_variable_table' with `a_table'.
			-- `a_table' can be retrieved directly from {EXECUTION_ENVIRONMENT}.`environ'.
		require
			process_not_running: not is_running
			a_table_attached: a_table /= Void
		local
			l_tbl: like environment_variable_table
		do
			l_tbl := environment_variable_table
			if l_tbl /= Void then
				l_tbl.wipe_out
			else
				create l_tbl.make (20)
				environment_variable_table := l_tbl
			end
			across
				a_table as t
			loop
				if attached @ t.key as k and then attached t as i then
					l_tbl.force (i.string, k)
				end
			end
		end

	set_environment_variable_use_unicode (b: BOOLEAN)
			-- Set `is_environment_variable_unicode' with `b'.
		obsolete
			"Do not use as it has no effect. [2017-05-31]"
		require
			process_not_running: not is_running
		do
		end

feature -- Actions setting

	set_on_start_handler (handler: like on_start_handler)
			-- Set a `handler' which will be called when process starts.
			-- Set with Void to disable start handler.
		require
			process_not_running: not is_running
		do
			on_start_handler := handler
		ensure
			handler_set: on_start_handler = handler
		end

	set_on_exit_handler (handler: like on_exit_handler)
			-- Set a `handler' which will be called when process exits.
			-- Set with Void to disable exit handler.
		require
			process_not_running: not is_running
		do
			on_exit_handler := handler
		ensure
			handler_set: on_exit_handler = handler
		end

	set_on_terminate_handler (handler: like on_terminate_handler)
			-- Set a `handler' which will be called when process has been terminated.
			-- Set with Void to disable terminate handler.
		require
			process_not_running: not is_running
		do
			on_terminate_handler := handler
		ensure
			handler_set: on_terminate_handler = handler
		end

	set_on_fail_launch_handler (handler: like on_fail_launch_handler)
			-- Set a `handler' which will be called when process launch failed.
			-- Set with Void to disable fail launch handler.
		require
			process_not_running: not is_running
		do
			on_fail_launch_handler := handler
		ensure
			handler_set: on_fail_launch_handler = handler
		end

	set_on_successful_launch_handler (handler: like on_successful_launch_handler)
			-- Set a `handler' which will be called when process launch successed.
			-- Set with Void to disable successful launch handler.
		require
			process_not_running: not is_running
		do
			on_successful_launch_handler := handler
		ensure
			handler_set: on_successful_launch_handler = handler
		end

	enable_launch_in_new_process_group
			-- Ensure new process is launched in a new process group.
			-- Only has effect on Windows.
			-- Note: If process is launched in new process group, then `terminate_tree' can terminate
			-- whole process tree (including all children processes),
			-- otherwise, it can only terminate the new process itself.
		require
			process_not_running: not is_running
		do
			is_launched_in_new_process_group := True
		ensure
			launched_in_new_process_group_enabled: is_launched_in_new_process_group
		end

	disable_launch_in_new_process_group
			-- Ensure new process is launched in current process group.
		require
			process_not_running: not is_running
		do
			is_launched_in_new_process_group := False
		ensure
			launched_in_new_process_group_enabled: not is_launched_in_new_process_group
		end

feature {NONE} -- Actions

	on_start
			-- Agent called when process launched
		do
			if attached on_start_handler as l_handler then
				l_handler.call
			end
		end

	on_terminate
			-- Agent called when process has been terminated.
		do
			if attached on_terminate_handler as l_handler then
				l_handler.call
			end
		end

	on_exit
			-- Agent called when process has exited.
		do
			if attached on_exit_handler as l_handler then
				l_handler.call
			end
		end

	on_launch_failed
			-- Agent called when process launch failed
		do
			if attached on_fail_launch_handler as l_handler then
				l_handler.call
			end
		end

	on_launch_successed
			-- Agent called when process launch succeeded
		do
			if attached on_successful_launch_handler as l_handler then
				l_handler.call
			end
		end

feature -- Access

	id: INTEGER
			-- Process identifier of last launched process.
		require
			process_launched: launched
		attribute
		end

	exit_code: INTEGER
			-- Exit code of child process
			-- Should be called after process has exited.
		require
			process_launched: launched
		deferred
		end

	platform: PLATFORM
			-- Facility to tell us which `platform' we are on
		once
			create Result
		ensure
			platform_created: Result /= Void
		end

	command_line: IMMUTABLE_STRING_32
			-- Program name, with its arguments, if any, which will be run
			-- in launched process

	working_directory: detachable IMMUTABLE_STRING_32
			-- Working directory of the program to be launched

	input_file_name: detachable IMMUTABLE_STRING_32
			-- File name served as the redirected input stream of the new process

	output_file_name: detachable IMMUTABLE_STRING_32
			-- File name served as the redirected output stream of the new process

	error_file_name: detachable IMMUTABLE_STRING_32
			-- File name served as the redirected error stream of the new process

	input_direction: INTEGER
			-- Where will input stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `BASE_REDIRECTION'

	output_direction: INTEGER
			-- Where will the output stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `BASE_REDIRECTION'

	error_direction: INTEGER
			-- Where will the error stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `BASE_REDIRECTION'

	environment_variable_table: detachable HASH_TABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]
			-- Table of environment variables to be passed to new process.
			-- Key is variable name and value is the value of the variable.
			-- If this table is Void or empty, environment variables of the
			-- parent process will be passed to the new process.

feature -- Status report

	launched: BOOLEAN
			-- Has the process been launched?

	is_running: BOOLEAN
			-- Is process running?
		do
			Result := launched and then not has_exited
		end

	has_exited: BOOLEAN
			-- Has launched process exited and have allocated resources been cleaned up?
			-- Important: If you register either terminate or exit agents, `has_exited' doesn't mean those agents have finished.
			-- Use `wait_for_exit' to ensure that all registered agents are finished.
		require
			process_launched: launched
		attribute
		end

	abort_termination_when_failed: BOOLEAN
			-- Will termination be aborted when there is a child process which can not be terminated
			-- when `terminate_tree'?
			-- Have effect only on Windows.

	force_terminated: BOOLEAN
			-- Has process been terminated by user?

	last_termination_successful: BOOLEAN
			-- Is last process termination operation successful?

	hidden: BOOLEAN
			-- Will the process be launched silently?
			-- e.g., no console window will prompt out.
			-- Has effects on Windows.

	separate_console: BOOLEAN
			-- Will process be launched with a new console instead of inheriting parent's console?
			-- Has effects on Windows.

	detached_console: BOOLEAN
			-- Will process be launched without any console ?
			-- Has effects on Windows.

	is_terminal_control_enabled: BOOLEAN
			-- Should launched process has terminal control over standard input, output and error?
			-- If terminal control is not enabled, launched process won't be able to get access to terminals.
			-- Has effect only on Unix.

	is_environment_variable_unicode: BOOLEAN
			-- Does `environment_variable_table' use Unicode?
			-- Only has effect on Windows.
		obsolete
			"Do not use since it has no effect. [2017-05-31]"
		do
		end

	is_launched_in_new_process_group: BOOLEAN
			-- Will process be launched in a new process group?
			-- Only has effect on Windows.

feature -- Validation checking

	is_input_redirection_valid (a_input_direction: INTEGER): BOOLEAN
			-- Can input of process be redirected to `a_input_direction'?
		do
			Result :=
				a_input_direction = {BASE_REDIRECTION}.to_file or
				a_input_direction = {BASE_REDIRECTION}.to_stream or
				a_input_direction = {BASE_REDIRECTION}.no_redirection
		end

	is_output_redirection_valid (a_output_direction: INTEGER): BOOLEAN
			-- Can output of process be redirected to `a_output_direction'?
		do
			Result :=
				a_output_direction = {BASE_REDIRECTION}.to_file or
				a_output_direction = {BASE_REDIRECTION}.to_stream or
				a_output_direction = {BASE_REDIRECTION}.no_redirection
		end

	is_error_redirection_valid (a_error_direction: INTEGER): BOOLEAN
			-- Can error of process be redirected to `a_error_direction'?
		do
			Result :=
				a_error_direction = {BASE_REDIRECTION}.to_file or
				a_error_direction = {BASE_REDIRECTION}.to_stream or
				a_error_direction = {BASE_REDIRECTION}.no_redirection or
				(not platform.is_dotnet) and then a_error_direction = {BASE_REDIRECTION}.to_same_as_output
		end

feature {NONE} -- Implementation

	on_start_handler: detachable ROUTINE
			-- Agent called when process starts.

	on_exit_handler: detachable ROUTINE
			-- Agent called when process exits.

	on_terminate_handler: detachable ROUTINE
			-- Agent called when process has been terminated.

	on_fail_launch_handler: detachable ROUTINE
			-- Agent called when process launch failed.

	on_successful_launch_handler: detachable ROUTINE
			-- Agent called when process launch is successful.

	arguments: detachable LIST [READABLE_STRING_GENERAL]
			-- Arguments of the program indicated.

	initialize_working_directory (a_working_directory: detachable READABLE_STRING_GENERAL)
			-- Setup `working_directory' according to `a_working_directory'.
		do
			if a_working_directory /= Void then
				create working_directory.make_from_string_general (a_working_directory)
			else
				working_directory := Void
			end
		end

feature {NONE} -- Initialization

	initialize_parameter
			-- Initialize parameters.
		do
			cancel_input_redirection
			cancel_output_redirection
			cancel_error_redirection
			hidden := False
			separate_console := False
			abort_termination_when_failed := False
			launched := False
			force_terminated := False
			last_termination_successful := True
		ensure
			initialized: parameter_initialized
		end

	parameter_initialized: BOOLEAN
			-- Are parameters initialized successfully?
		do
			Result :=
				input_direction = {BASE_REDIRECTION}.no_redirection and
				output_direction = {BASE_REDIRECTION}.no_redirection and
				error_direction = {BASE_REDIRECTION}.no_redirection and
				attached input_file_name as l_ifn and then l_ifn.is_empty and
				attached output_file_name as l_ofn and then l_ofn.is_empty and
				attached error_file_name as l_efn and then l_efn.is_empty and
				not hidden and
				not separate_console and
				not abort_termination_when_failed and
				not launched and
				not force_terminated and
				last_termination_successful
		end

	is_separator (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' a separator for argument in command line?
		do
			Result := a_char = ' '
		end

	separated_words (a_cmd: READABLE_STRING_GENERAL): ARRAYED_LIST [STRING_32]
			-- Break shell command held in 'a_cmd' into words and
			-- return retrieved word list.
		require
			a_cmd_attached: a_cmd /= Void
		local
			l_in_simple: BOOLEAN
			l_in_quote: BOOLEAN
			l_was_closing_quote: BOOLEAN
			l_was_backslash: BOOLEAN
			l_current_word: STRING_32
			l_pos: INTEGER
			l_pos_all: INTEGER
			l_length: INTEGER
			l_char: CHARACTER_32
			l_should_process: BOOLEAN
		do
			create {ARRAYED_LIST [STRING_32]} Result.make (1)
			if not a_cmd.is_empty then
				create l_current_word.make (128)
				from
					l_length := a_cmd.count
					l_pos := 1
					l_pos_all := 1
					l_char := a_cmd.item (l_pos_all)
				until
					l_pos_all > l_length or else l_char = '%U'
				loop
					l_should_process := True
					if l_in_simple then
						if l_was_backslash then
							l_was_backslash := False
							if l_char = '\' then
								l_should_process := False
							elseif l_char = '%'' then
								check not l_current_word.is_empty end
								l_current_word.put (l_char, l_current_word.count)
								l_should_process := False
							end
						end
						if
							l_should_process and then
							l_char = '%''
						then
							l_in_simple := False
							l_was_closing_quote := True
							l_should_process := False
						end
					elseif l_in_quote then
						if l_was_backslash then
							l_was_backslash := False
							check not l_current_word.is_empty end
							l_current_word.put (l_char, l_current_word.count)
							l_should_process := False
						end
						if
							l_should_process and then
							l_char = '"'
						then
							l_in_quote := False
							l_was_closing_quote := True
							l_should_process := False
						end
					end
					if l_should_process then
						inspect
							l_char
						when '\' then
							l_was_backslash := True
							l_current_word.append_character (l_char)
							l_pos := l_pos + 1
							l_char := a_cmd.item (l_pos)
						when '%'' then
							l_in_simple := True
						when '"' then
							if not l_in_simple then
								l_in_quote := True
							else
								if platform.is_windows then
									if not l_in_quote then
										l_current_word.append_character (l_char)
										l_pos := l_pos + 1
									else
										l_in_quote := False
										l_should_process := False
									end
								else
									l_current_word.append_character (l_char)
									l_pos := l_pos + 1
								end
							end
						else
							if l_in_simple or l_in_quote then
								l_current_word.append_character (l_char)
								l_pos := l_pos + 1
							elseif is_separator (l_char) then
								if l_pos > 1 or else l_was_closing_quote then
									Result.extend (l_current_word.twin)
									l_current_word.wipe_out
									l_pos := 1
									l_was_closing_quote := False
									l_was_backslash := False
								end
							else
								l_current_word.append_character (l_char)
								l_pos := l_pos + 1
							end
						end
					end
					if l_should_process then
						l_was_closing_quote := False
					end
					l_pos_all := l_pos_all + 1
					if l_pos_all <= l_length then
						l_char := a_cmd.item (l_pos_all)
					end
				end
				if l_pos > 1 then
					Result.extend (l_current_word)
				end
			end
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
