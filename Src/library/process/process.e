indexing
	description: "[
		Interface of a multi-platform process launcher(on Win32, .Net and Unix/Linux)
		note: This library is not thread safe.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		deferred
		ensure
			command_line_not_void: command_line /= Void
			comand_line_not_empty: not command_line.is_empty
			working_directory_set: (a_working_directory /= Void) implies (working_directory.is_equal (a_working_directory)) and
								   (a_working_directory = Void) implies (working_directory = Void)
			process_not_launched: not launched
			process_not_terminated: not force_terminated
			process_not_hidden_on_windows: platform.is_windows implies not hidden
			separate_console_on_windows: platform.is_windows implies not separate_console
			buffer_size_positive: buffer_size > 0
			operation_succcessful: last_operation_successful
			init_succeeded: initialization_successful
		end

	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
			-- Create process object with `cmd_line' as command line in which executable and
			-- arguments are included and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.		
		require
			command_line_not_void: cmd_line /= Void
			command_line_not_empty: not cmd_line.is_empty
		deferred
		ensure
			command_line_not_void: command_line /= Void
			comand_line_not_empty: not command_line.is_empty
			working_directory_set: (a_working_directory /= Void) implies (working_directory.is_equal (a_working_directory)) and
								   (a_working_directory = Void) implies (working_directory = Void)
			process_not_launched: not launched
			process_not_terminated: not force_terminated
			process_not_hidden_on_windows: platform.is_windows implies not hidden
			separate_console_on_windows: platform.is_windows implies not separate_console
			buffer_size_positive: buffer_size > 0
			operation_succcessful: last_operation_successful
			init_succeeded: initialization_successful
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
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
			error_file_name := Void
			error_handler := Void
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

feature -- Control

	launch is
			-- Launch process.
		require
			process_not_running: not is_running
			input_redirection_valid: is_input_redirection_valid (input_direction)
			output_redirection_valid: is_output_redirection_valid (output_direction)
			error_redirection_valid: is_error_redirection_valid (error_direction)
		deferred
		end

	terminate is
			-- Terminate launched process.
		require
			process_launched: launched
			process_not_terminated: not force_terminated
		deferred
		ensure
			process_exited: has_exited
		end

	terminate_tree is
			-- Terminate process tree starting from current launched process.
		require
			process_launched: launched
			process_not_terminated: not force_terminated
		deferred
		end

	wait_for_exit is
			-- Wait until process has exited.
		require
			process_launched: launched
		deferred
		ensure
			process_exited: has_exited
		end

feature -- Interprocess data transmission

	put_string (s: STRING) is
			-- Send `s' into launched process as its input data.
		require
			input_redirect_to_stream: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			process_running : is_running
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
			on_windows: platform.is_windows
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
			on_windows: platform.is_windows
		do
			separate_console := b
		ensure
			separate_console_set: separate_console = b
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

feature {NONE} -- Actions

	on_start is
		-- Agent called when process launched
		do
			if on_start_handler /= Void then
				on_start_handler.call ([])
			end
		end

	on_terminate is
			-- Agent called when process has been terminated
		do
			if on_terminate_handler /= Void then
				on_terminate_handler.call ([])
			end
		end

	on_exit is
			-- Agent called when process has exited
		do
			if on_exit_handler /= Void then
				on_exit_handler.call ([])
			end
		end

	on_launch_failed is
			-- Agent called when process launch failed
		do
			if on_fail_launch_handler /= Void then
				on_fail_launch_handler.call ([])
			end

		end

	on_launch_successed is
			-- Agent called when process launch succeeded
		do
			if on_successful_launch_handler /= Void then
				on_successful_launch_handler.call ([])
			end
		end

feature -- Status report

	id: INTEGER
			-- Process identifier of last launched process.

	launched: BOOLEAN
			-- Has the process been launched?

	is_running: BOOLEAN is
			-- Is process running?
		do
			Result := (launched and then not has_exited)
		end

	has_exited: BOOLEAN is
			-- Has the process finished?
		require
			process_launched: launched
		deferred
		end

	exit_code: INTEGER is
			-- Exit code of child process
		require
			process_launched: launched
			process_has_exited: has_exited
		deferred
		end

	force_terminated: BOOLEAN
			-- Has process been terminated by user?

	platform: PLATFORM is
			-- Facility to tell us which `platform' we are on
		once
			create Result
		ensure
			platform_created: Result /= Void
		end

	buffer_size: INTEGER
			-- Size of buffer used to store data read from process

	hidden: BOOLEAN
			-- Will the process be launched silently?
			-- e.g., no console window will prompt out.
			-- Has effects on Windows.

	separate_console: BOOLEAN
			-- Will process be launched with a new console instead of inheriting parent's console?
			-- Has effects on Windows.

	command_line: STRING
			-- Program name, with its arguments, if any, which will be run
			-- in launched process

	working_directory: STRING
			-- Working directory of the program to be launched

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

	input_file_name: STRING
			-- File name served as the redirected input stream of the new process

	output_file_name: STRING
			-- File name served as the redirected output stream of the new process

	error_file_name: STRING
			-- File name served as the redirected error stream of the new process

	last_operation_successful: BOOLEAN
			-- Is last operation successful?

	input_direction: INTEGER
			-- Where will input stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `PROCESS_REDIRECTION_CONSTANTS'

	output_direction: INTEGER
			-- Where will the output stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `PROCESS_REDIRECTION_CONSTANTS'

	error_direction: INTEGER
			-- Where will the error stream of the to-be launched process be redirected.
			-- Valid values are those constants defined in class `PROCESS_REDIRECTION_CONSTANTS'

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

	initialization_successful: BOOLEAN is
			-- Is initialization successful?
		do
			Result :=
			    (input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) and
				(output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) and
				(error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection) and
				(output_handler = Void) and
				(error_handler = Void) and
				(input_file_name.is_equal ("")) and
				(output_file_name.is_equal ("")) and
				(error_file_name.is_equal ("")) and
				(timer = Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
