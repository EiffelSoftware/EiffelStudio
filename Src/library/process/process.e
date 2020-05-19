note
	description: "[
		Same as {BASE_PROCESS} with the following enhancements:
			- asynchronous piped I/O with the current process;
			- wait for process termination with timeout (`wait_for_exit_with_timeout');
			- asynchronous callbacks reporting child process state changes.
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS

inherit
	BASE_PROCESS
		rename
			parameter_initialized as base_parameter_initialized
		redefine
			cancel_error_redirection,
			cancel_output_redirection,
			initialize_parameter,
			is_error_redirection_valid,
			is_output_redirection_valid,
			redirect_error_to_file,
			redirect_error_to_same_as_output,
			redirect_output_to_file
		end

feature -- IO redirection

	redirect_output_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			Precursor (a_file_name)
			output_handler := Void
		ensure then
			output_handler_void: output_handler = Void
		end

	redirect_output_to_agent (a_output_handler: attached like output_handler)
			-- Redirect output stream of process to an agent
			-- so whenever some output data comes out of process,
			-- the agent will be called with it's parameter assigned to
			-- the output data.
		require
			process_not_running: not is_running
			handler_not_void: a_output_handler /= Void
			not_same_as_error_handler: are_agents_valid (a_output_handler, False)
		do
			output_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			output_handler := a_output_handler
			output_file_name := Void
		ensure
			output_redirected_to_stream: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			output_handler_set: output_handler = a_output_handler
			output_file_name_void: output_file_name = Void
		end

	cancel_output_redirection
			-- <Precursor>
		do
			Precursor
			output_handler := Void
		ensure then
			output_handler_set: output_handler = Void
		end

	redirect_error_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			Precursor (a_file_name)
			error_handler := Void
		ensure then
			error_handler_void: error_handler = Void
		end

	redirect_error_to_agent (a_error_handler: attached like error_handler)
			-- Redirect error stream of process to an agent
			-- so whenever some error data comes out of process,
			-- the agent will be called with it's parameter assigned to
			-- the error data.
		require
			process_not_running: not is_running
			handler_not_void: a_error_handler /= Void
			not_same_as_output_handler: are_agents_valid (a_error_handler, True)
		do
			error_direction := {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			error_handler := a_error_handler
			error_file_name := Void
 		ensure
			error_redirected_to_stream: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
			error_handler_set: error_handler = a_error_handler
			error_file_name_void: error_file_name = Void
		end

	redirect_error_to_same_as_output
			-- <Precursor>
		do
			if not platform.is_dotnet then
				Precursor
				error_handler := Void
			end
		ensure then
			error_handler_set: error_handler = Void
		end

	cancel_error_redirection
			-- <Precursor>
		do
			Precursor
			error_handler := Void
		ensure then
			error_handler_set: error_handler = Void
		end

feature -- Status setting

	set_buffer_size (size: INTEGER)
			-- Set `buffer_size' with `size'.
		require
			process_not_running: not is_running
			size_positive: size > 0
		do
			buffer_size := size
		ensure
			buffer_size_set: buffer_size = size
		end

	set_timer (a_timer: like timer)
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

feature -- Access

	buffer_size: INTEGER
			-- Size of buffer used for interprocess data transmission

feature -- Status report

	are_agents_valid (handler: detachable PROCEDURE [READABLE_STRING_8]; is_error: BOOLEAN): BOOLEAN
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

	is_last_wait_timeout: BOOLEAN
			-- Did the last `wait_for_exit_with_timeout' time out?
		deferred
		end

feature -- Validation checking

	is_output_redirection_valid (a_output_direction: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_output_direction) or
				a_output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		end

	is_error_redirection_valid (a_error_direction: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_error_direction) or
				a_error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream
		end

feature {PROCESS_IO_LISTENER_THREAD} -- Output/error handlers

	output_handler: detachable PROCEDURE [READABLE_STRING_8]
			-- Handler called when output from process arrives

	error_handler: detachable PROCEDURE [READABLE_STRING_8]
			-- Handler called when error from process arrives

feature {NONE} -- Implementation

	timer: PROCESS_TIMER
			-- Timer used to check process termination so that some cleanups are done

	initial_buffer_size: INTEGER = 4096
			-- Initial size of buffer used to store interprocess data temporarily

	initial_time_interval: INTEGER = 250
			-- Initial time interval in milliseconds used to check process status	

feature {NONE} -- Initializartion

	initialize_parameter
			-- <Precursor>
		do
			Precursor
			output_handler := Void
			error_handler := Void
			buffer_size := initial_buffer_size
			create {PROCESS_THREAD_TIMER} timer.make (initial_time_interval)
			timer.set_process_launcher (Current)
		ensure then
			parameter_initialized: parameter_initialized
		end

	parameter_initialized: BOOLEAN
			-- <Precursor>
		do
			Result := base_parameter_initialized and
				not attached output_handler and
				not attached error_handler and
				buffer_size = initial_buffer_size and
				attached timer
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
