indexing
	description: "[
		Interface of a multi-platform process launcher(on Win32, .Net and Unix/Linux)
		Instance of this class is not guaranteed to be thread safe.
		Usage:
			1. Use {PROCESS_FACTORY} to get new PROCESS object.
			2. Invoke IO redirection features to redirect io to certain devices. By default,
			   IO of launched process is not redirected.
			3. Invoke `launch' to launch process.
			4. You can use `has_exited' to check the status of launched process or use `wait_for_exit'/`wait_for_exit_with_timeout'
			   to wait for launched process.
		Note: Make sure that launched process has exited before you exit you application.
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS

feature {NONE} -- Initialization

	make (a_exec_name: STRING; args: LIST [STRING]; a_working_directory: STRING) is
			-- Create process object with `a_exec_name' as executable with `args'
			-- as arguments, and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.
			-- Apply Void to `args' if no argument is necessary.
		require
			a_exec_name_not_void: a_exec_name /= Void
			thread_capable: {PLATFORM}.is_thread_capable
		deferred
		ensure
			command_line_not_void: command_line /= Void
			comand_line_not_empty: not command_line.is_empty
			working_directory_set: (a_working_directory /= Void) implies (working_directory.is_equal (a_working_directory)) and
								   (a_working_directory = Void) implies (working_directory = Void)
			init_succeeded: parameter_initialized
		end

	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
			-- Create process object with `cmd_line' as command line in which executable and
			-- arguments are included and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.		
		require
			command_line_not_void: cmd_line /= Void
			command_line_not_empty: not cmd_line.is_empty
			thread_capable: {PLATFORM}.is_thread_capable
		deferred
		ensure
			command_line_not_void: command_line /= Void
			comand_line_not_empty: not command_line.is_empty
			working_directory_set: (a_working_directory /= Void) implies (working_directory.is_equal (a_working_directory)) and
								   (a_working_directory = Void) implies (working_directory = Void)
			init_succeeded: parameter_initialized
		end

feature -- IO redirection

	redirect_input_to_stream is
			-- Redirect input stream of process to its parent's stream
			-- so you can use `put_string' to send data into process.
		require
			process_not_running: not is_running
		do
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			input_file_name := Void
		ensure
			input_redirected_to_stream:
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			input_file_name_void: input_file_name = Void
		end

	redirect_input_to_file (a_file_name: STRING) is
			-- Redirect input stream of process to a file
			-- with name`a_file_name'.
		require
			process_not_running: not is_running
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		do
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_file
			input_file_name := a_file_name
		ensure
			input_redirectd_to_file:
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file
			input_file_name_set: input_file_name = a_file_name
		end

	cancel_input_redirection is
			-- Cancel input redirection.
		require
			process_not_running: not is_running
		do
			input_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			input_file_name := ""
		ensure
			input_redirection_canceled:
				input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			input_file_name_set: input_file_name.is_equal ("")
		end

	redirect_output_to_file (a_file_name: STRING) is
			-- Redirect output stream of process to a file
			-- with name `a_file_name'.
		require
			process_not_running: not is_running
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			output_and_error_file_not_same:
				(error_file_name /= Void) implies not error_file_name.is_equal (a_file_name)
		do
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_file
			output_file_name := a_file_name
			output_handler := Void
		ensure
			output_redirected_to_file:
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file
			output_file_name_set: output_file_name = a_file_name
			output_handler_void: output_handler = Void
		end

	redirect_output_to_agent (a_output_handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Redirect output stream of process to an agent
			-- so whenever some output data comes out of process,
			-- the agent will be called with it's parameter assigned to
			-- the output data.
		require
			process_not_running: not is_running
			handler_not_void: a_output_handler /= Void
			not_same_as_error_handler: are_agents_valid (a_output_handler, False)
		do
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			output_handler := a_output_handler
			output_file_name := Void
		ensure
			output_redirected_to_agent: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			output_handler_set: output_handler = a_output_handler
			output_file_name_void: output_file_name = Void
		end

	cancel_output_redirection is
			-- Cancel output redirection.
		require
			process_not_running: not is_running
		do
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_file_name := ""
			output_handler := Void
		ensure
			output_redirection_canceled:
				output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_file_name_set: output_file_name.is_equal ("")
			output_handler_set: output_handler = Void
		end

	redirect_error_to_file (a_file_name: STRING) is
			-- Redirect the error stream of process to a file.
		require
			process_not_running: not is_running
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			output_and_error_file_not_same:
				(output_file_name /= Void) implies (not output_file_name.is_equal (a_file_name))
		do
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_file
			error_file_name := a_file_name
			error_handler := Void
		ensure
			error_redirected_to_file: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file
			error_file_set: error_file_name = a_file_name
			error_handler_void: error_handler = Void
		end

	redirect_error_to_agent (a_error_handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Redirect error stream of process to an agent
			-- so whenever some error data comes out of process,
			-- the agent will be called with it's parameter assigned to
			-- the error data.
		require
			process_not_running: not is_running
			handler_not_void: a_error_handler /= Void
			not_same_as_output_handler: are_agents_valid (a_error_handler, True)
		do
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			error_handler := a_error_handler
			error_file_name := Void
 		ensure
			error_redirected_to_agent: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent
			error_handler_set: error_handler = a_error_handler
			error_file_name_void: error_file_name = Void
		end

	redirect_error_to_same_as_output is
			-- Redirect output and error to the same location.
			-- Not applicable on .NET.
		require
			not_on_dotnet_platform: not platform.is_dotnet
			process_not_running: not is_running
		do
			if not platform.is_dotnet then
				error_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
				error_file_name := Void
				error_handler := Void
			end
		ensure
			error_redirected_to_same_as_output:
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
			error_file_name_set: error_file_name = Void
			error_handler_set: error_handler = Void
		end

	cancel_error_redirection is
			-- Cancel error redirection.
		require
			process_not_running: not is_running
		do
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_file_name := ""
			error_handler := Void
		ensure
			error_redirection_canceled:
				error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_file_name_set: error_file_name.is_equal ("")
			error_handler_set: error_handler = Void
		end

	enable_terminal_control is
			-- Make sure that launched process has terminal control over standard input, output and error.
			-- Has effect only on Unix and only when `is_launched_in_new_process_group' is True.
		require
			process_not_running: not is_running
		do
			is_terminal_control_enabled := True
		ensure
			terminal_control_enabled: is_terminal_control_enabled
		end

	disable_terminal_control is
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

	launch is
			-- Launch process.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_not_running: not is_running
			input_redirection_valid: is_input_redirection_valid (input_direction)
			output_redirection_valid: is_output_redirection_valid (output_direction)
			error_redirection_valid: is_error_redirection_valid (error_direction)
		deferred
		end

	terminate is
			-- Terminate launched process.
			-- Check `last_termination_successful' after to see if `terminate' succeeded.
			-- `terminate' executes asynchronously. After calling `terminate', call `wait_to_exit' or `wait_to_exit_with_timeout'
			-- to wait for process to exit.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launched: launched
			process_not_terminated: not force_terminated
		deferred
		end

	terminate_tree is
			-- Terminate process tree starting from current launched process.
			-- Check `last_termination_successful' after to see if `terminate_tree' succeeded.
			-- `terminate_tree' executes asynchronously. After calling `terminate', call `wait_to_exit' or `wait_to_exit_with_timeout'
			-- to wait for process to exit.
			-- Note: on Unix, this feature can terminate whole process tree only when `is_launched_in_new_process_group' is set to True
			-- before new process is launched.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launched: launched
			process_not_terminated: not force_terminated
		deferred
		end

	wait_for_exit is
			-- Wait until process has exited.
			-- Note: child processes of launched process are not guaranteed to have exited after `wait_for_exit' returns.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launched: launched
		deferred
		ensure
			process_exited: has_exited
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER) is
			-- Wait launched process to exit for at most `a_timeout' milliseconds.
			-- Check `has_exited' after to see if launched process has exited.
			-- Note: child processes of launched process are not guaranteed to have exited even `wait_for_exit_with_timeout' returns
			-- with True.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launched: launched
			a_timeout_positive: a_timeout > 0
		deferred
		end

feature -- Interprocess data transmission

	put_string (s: STRING) is
			-- Send `s' into launched process as its input data.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			input_redirect_to_stream: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			process_launched: launched
			string_not_void: s /= Void
		deferred
		end

feature -- Status setting

	set_buffer_size (size: INTEGER) is
			-- Set `buffer_size' with `size'.
		require
			process_not_running: not is_running
			size_positive: size > 0
		do
			buffer_size := size
		ensure
			buffer_size_set: buffer_size = size
		end

	set_timer (a_timer: PROCESS_TIMER) is
			-- Set `a_timer' as timer used by this process launcher.
			-- If no timer is set, a `PROCESS_THREAD_TIMER' will be used
			-- when launch a process.
			-- In Vision2, `PROCESS_VISION2_TIMER' is recommended.
		require
			process_not_running: not is_running
			a_timer_not_void: a_timer /= Void
		do
			timer := a_timer
			timer.set_process_launcher (Current)
		ensure
			timer_set: timer = a_timer
		end

	set_hidden (h: BOOLEAN) is
			-- Set `is_hidden' with `h'.
			-- Has effects on Windows.
		require
			process_not_running: not is_running
		do
			hidden := h
		ensure
			hidden_flag_set: hidden = h
		end

	set_separate_console (b: BOOLEAN) is
			-- Set `separate_console' with `b'.
			-- Has effects on Windows.
		require
			process_not_running: not is_running
		do
			separate_console := b
		ensure
			separate_console_set: separate_console = b
		end

	set_detached_console (b: BOOLEAN) is
			-- Set `detached_console' with `b'.
			-- Has effects on Windows.
		require
			process_not_running: not is_running
		do
			detached_console := b
		ensure
			detached_console_set: detached_console = b
		end

	set_abort_termination_when_failed (b: BOOLEAN) is
			-- Set `abort_termination_when_failed' with `b'.
		require
			process_not_running: not is_running
		do
			abort_termination_when_failed := b
		ensure
			abort_termination_when_failed_set: abort_termination_when_failed = b
		end

	set_environment_variable_table (a_table: like environment_variable_table) is
			-- Set `environment_variable_table' with `a_table'.
		require
			process_not_running: not is_running
		do
			environment_variable_table := a_table
		ensure
			environment_variable_table_set: environment_variable_table /= a_table
		end

	set_environment_variables (a_table: HASH_TABLE [C_STRING, STRING]) is
			-- Set `environment_variable_table' with `a_table'.
			-- `a_table' can be retrieved directly from {EXECUTION_ENVIRONMENT}.`environ'.
		require
			process_not_running: not is_running
			a_table_attached: a_table /= Void
		local
			l_tbl: like environment_variable_table
		do
			if environment_variable_table /= Void then
				environment_variable_table.clear_all
			else
				create environment_variable_table.make (20)
			end
			l_tbl := environment_variable_table
			from
				a_table.start
			until
				a_table.after
			loop
				if a_table.key_for_iteration /= Void and then a_table.item_for_iteration /= Void then
					l_tbl.force (a_table.item_for_iteration.string, a_table.key_for_iteration)
				end
				a_table.forth
			end
		end

	set_environment_variable_use_unicode (b: BOOLEAN) is
			-- Set `is_environment_variable_unicode' with `b'.
		require
			process_not_running: not is_running
		do
			is_environment_variable_unicode := b
		ensure
			is_environment_variable_unicode_set: is_environment_variable_unicode = b
		end

feature -- Actions setting

	set_on_start_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process starts.
			-- Set with Void to disable start handler.
		require
			process_not_running: not is_running
		do
			on_start_handler := handler
		ensure
			handler_set: on_start_handler = handler
		end

	set_on_exit_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process exits.
			-- Set with Void to disable exit handler.			
		require
			process_not_running: not is_running
		do
			on_exit_handler := handler
		ensure
			handler_set: on_exit_handler = handler
		end

	set_on_terminate_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process has been terminated.
			-- Set with Void to disable terminate handler.
		require
			process_not_running: not is_running
		do
			on_terminate_handler := handler
		ensure
			handler_set: on_terminate_handler = handler
		end

	set_on_fail_launch_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process launch failed.
			-- Set with Void to disable fail launch handler.			
		require
			process_not_running: not is_running
		do
			on_fail_launch_handler := handler
		ensure
			handler_set: on_fail_launch_handler = handler
		end

	set_on_successful_launch_handler (handler: ROUTINE [ANY, TUPLE]) is
			-- Set a `handler' which will be called when process launch successed.
			-- Set with Void to disable successful launch handler.
		require
			process_not_running: not is_running
		do
			on_successful_launch_handler := handler
		ensure
			handler_set: on_successful_launch_handler = handler
		end

	enable_launch_in_new_process_group is
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

	disable_launch_in_new_process_group is
			-- Ensure new process is launched in current process group.
		require
			process_not_running: not is_running
		do
			is_launched_in_new_process_group := False
		ensure
			launched_in_new_process_group_enabled: not is_launched_in_new_process_group
		end

feature {NONE} -- Actions

	on_start is
		-- Agent called when process launched
		do
			if on_start_handler /= Void then
				on_start_handler.call (Void)
			end
		end

	on_terminate is
			-- Agent called when process has been terminated
		do
			if on_terminate_handler /= Void then
				on_terminate_handler.call (Void)
			end
		end

	on_exit is
			-- Agent called when process has exited
		do
			if on_exit_handler /= Void then
				on_exit_handler.call (Void)
			end
		end

	on_launch_failed is
			-- Agent called when process launch failed
		do
			if on_fail_launch_handler /= Void then
				on_fail_launch_handler.call (Void)
			end
		end

	on_launch_successed is
			-- Agent called when process launch succeeded
		do
			if on_successful_launch_handler /= Void then
				on_successful_launch_handler.call (Void)
			end
		end

feature -- Access

	id: INTEGER is
			-- Process identifier of last launched process.
		require
			process_launched: launched
		deferred
		end

	exit_code: INTEGER is
			-- Exit code of child process
			-- Should be called after process has exited.
		require
			process_launched: launched
		deferred
		end

	platform: PLATFORM is
			-- Facility to tell us which `platform' we are on
		once
			create Result
		ensure
			platform_created: Result /= Void
		end

	buffer_size: INTEGER
			-- Size of buffer used for interprocess data transmission

	command_line: STRING
			-- Program name, with its arguments, if any, which will be run
			-- in launched process

	working_directory: STRING
			-- Working directory of the program to be launched

	input_file_name: STRING
			-- File name served as the redirected input stream of the new process

	output_file_name: STRING
			-- File name served as the redirected output stream of the new process

	error_file_name: STRING
			-- File name served as the redirected error stream of the new process

	input_direction: INTEGER
			-- Where will input stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `PROCESS_REDIRECTION_CONSTANTS'

	output_direction: INTEGER
			-- Where will the output stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `PROCESS_REDIRECTION_CONSTANTS'

	error_direction: INTEGER
			-- Where will the error stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `PROCESS_REDIRECTION_CONSTANTS'

	environment_variable_table: HASH_TABLE [STRING, STRING]
			-- Table of environment variables to be passes to new process.
			-- Key is variable name and value is the value of the variable.
			-- If this table is Void or empty, environment variables of the parent process will be passes to the new process.

feature -- Status report


	launched: BOOLEAN
			-- Has the process been launched?

	is_running: BOOLEAN is
			-- Is process running?
		do
			Result := (launched and then not has_exited)
		end

	has_exited: BOOLEAN is
			-- Has launched process exited?
			-- Important: When default timer which is a thread is used, and you register either terminate or exit agents,
			-- `has_exited' is True doesn't mean those agents have finished. Use `wait_for_exit' to ensure that all registered
			-- agents are finished.
		require
			process_launched: launched
		deferred
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

	are_agents_valid (handler: PROCEDURE [ANY, TUPLE [STRING]]; is_error: BOOLEAN): BOOLEAN is
			-- Are output redirection agent and error redirection agent valid?
			-- If you redirect both output and error to one agent,
			-- they are not valid. You must redirect output and error to
			-- different agents.
		do
			if is_error then
				Result := handler /= output_handler
			else
				Result := handler /= error_handler
			end
		end

	is_terminal_control_enabled: BOOLEAN
			-- Should launched process has terminal control over standard input, output and error?
			-- If terminal control is not enabled, launched process won't be able to get access to terminals.
			-- Has effect only on Unix.

	is_environment_variable_unicode: BOOLEAN
			-- Does `environment_variable_table' use unicode?
			-- Only has effect on Windows.

	is_launched_in_new_process_group: BOOLEAN
			-- Will process be launched in a new process group?
			-- Only has effect on Windows.

feature -- Validation checking

	is_input_redirection_valid (a_input_direction: INTEGER): BOOLEAN is
			-- Can input of process be redirected to `a_input_direction'?
		do
			Result :=
				(a_input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file) or
				(a_input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream) or
				(a_input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection)
		end

	is_output_redirection_valid (a_output_direction: INTEGER): BOOLEAN is
			-- Can output of process be redirected to `a_output_direction'?
		do
			Result :=
				(a_output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file) or
				(a_output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent) or
				(a_output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection)
		end

	is_error_redirection_valid (a_error_direction: INTEGER): BOOLEAN is
			-- Can error of process be redirected to `a_error_direction'?
		do
			Result :=
				(a_error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file) or
				(a_error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent) or
				(a_error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) or
				((not platform.is_dotnet) and then a_error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output)
		end

feature {PROCESS_IO_LISTENER_THREAD} -- Output/error handlers

	output_handler: PROCEDURE [ANY, TUPLE [STRING]]
			-- Handler called when output from process arrives

	error_handler: PROCEDURE [ANY, TUPLE [STRING]]
			-- Handler called when error from process arrives

feature {NONE} -- Implementation

	on_start_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process starts

	on_exit_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process exits

	on_terminate_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process has been terminated

	on_fail_launch_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process launch failed

	on_successful_launch_handler: ROUTINE [ANY, TUPLE]
			-- Agent called when process launch is successful

	arguments: LINKED_LIST [STRING]
			-- Arguments of the program indicated by file_name

	timer: PROCESS_TIMER
			-- Timer used to check process termination so that some cleanups are done

	initialize_working_directory (a_working_directory: STRING) is
			-- Setup `working_directory' according to `a_working_directory'.
		do
			if a_working_directory /= Void then
				create working_directory.make_from_string (a_working_directory)
			else
				working_directory := Void
			end
		end

	initial_buffer_size: INTEGER is 1024
			-- Initial size of buffer used to store interprocess data temporarily

	initial_time_interval: INTEGER is 100
			-- Initial time interval in milliseconds used to check process status	

feature{NONE} -- Implementation

	initialize_parameter is
			-- Initialize parameters.
		do
			cancel_input_redirection
			cancel_output_redirection
			cancel_error_redirection
			output_handler := Void
			error_handler := Void
			hidden := False
			separate_console := False
			buffer_size := initial_buffer_size
			create {PROCESS_THREAD_TIMER}timer.make (initial_time_interval)
			timer.set_process_launcher (Current)
			abort_termination_when_failed := False
			launched := False
			force_terminated := False
			last_termination_successful := True
		ensure
			initialized: parameter_initialized
		end

	parameter_initialized: BOOLEAN is
			-- Are parameters initialized successfully?
		do
			Result :=
			    (input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) and
				(output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) and
				(error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) and
				(input_file_name.is_equal ("")) and
				(output_file_name.is_equal ("")) and
				(error_file_name.is_equal ("")) and
				(output_handler = Void) and
				(error_handler = Void) and
				(not hidden) and
				(not separate_console) and
				(buffer_size = initial_buffer_size) and
				(timer /= Void) and
				(not abort_termination_when_failed) and
				(not launched) and
				(not force_terminated) and
				(last_termination_successful)
		end

	environment_table_as_pointer: POINTER is
			-- {POINTER} representation of `environment_variable_table'
			-- Return `default_pointer' if `environment_variable_table' is Void or empty.
		deferred
		end

	is_separator (a_char: CHARACTER): BOOLEAN is
			-- Is `a_char' a separator for argument in command line?
		do
			Result := a_char = ' '
		end

	separated_words (a_cmd: STRING): LIST [STRING] is
			-- Break shell command held in 'a_cmd' into words and
			-- return retrieved word list.
		require
			a_cmd_attached: a_cmd /= Void
		local
			l_in_simple: BOOLEAN
			l_in_quote: BOOLEAN
			l_was_closing_quote: BOOLEAN
			l_was_backslash: BOOLEAN
			l_current_word: STRING
			l_pos: INTEGER
			l_pos_all: INTEGER
			l_length: INTEGER
			l_char: CHARACTER
			l_should_process: BOOLEAN
		do
			create {LINKED_LIST [STRING]} Result.make
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
						if l_should_process then
							if l_char = '%'' then
								l_in_simple := False
								l_was_closing_quote := True
								l_should_process := False
							end
						end
					elseif l_in_quote then
						if l_was_backslash then
							l_was_backslash := False
							check not l_current_word.is_empty end
							l_current_word.put (l_char, l_current_word.count)
							l_should_process := False
						end
						if l_should_process then
							if l_char = '"' then
								l_in_quote := False
								l_was_closing_quote := True
								l_should_process := False
							end
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

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
