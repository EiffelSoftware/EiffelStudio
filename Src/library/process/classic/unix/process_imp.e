indexing
	description:
		"[
			Object that implements PROCESS on UNIX
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_IMP

inherit
	PROCESS

	THREAD_CONTROL

create
	make, make_with_command_line

feature {NONE} -- Initialization

	make (a_exec_name: STRING; args: LIST[STRING]; a_working_directory: STRING) is
		do
			setup_defaults
			setup_command (a_exec_name, args, a_working_directory)
			create_child_process_manager
		end

	make_with_command_line (cmd_line: STRING; a_working_directory: STRING) is
		local
			ls: LIST [STRING]
			p_name :STRING
			args: ARRAYED_LIST [STRING]
		do
			ls := cmd_line.split (' ')
			create p_name.make_from_string (ls.i_th (1))
			ls.start
			ls.remove
			if ls.count > 0 then
				create args.make (ls.count)
				from
					ls.start
				until
					ls.after
				loop
					args.extend (ls.item)
					ls.forth
				end
			end
			make (p_name, args, a_working_directory)
		end

feature  -- Control

	launch is
		do
			on_start
			prepare_for_launch
				-- Process launch.
			child_process.spawn_nowait

			id := child_process.process_id
			last_operation_successful := (id /= -1)
			launched := last_operation_successful

			if launched then
				on_launch_successed
				set_internal_process_terminated (False)
				set_internal_all_finished (False)
				setup_process_listeners
			else
				on_launch_failed
			end
		end

	terminate is
		do
			internal_terminate (False)
		end

	terminate_tree is
			-- Terminate process tree starting from current launched process.
		do
			internal_terminate (True)
		end

	wait_for_exit is
		do
			destroy_timer
			wait_for_all_finished
		end

	put_string (s: STRING) is
		do
			child_process.put_string (s)
		end

feature -- Status reporting

	has_exited: BOOLEAN is
		do
			Result := all_finished
		end

	exit_code: INTEGER is
		do
			Result := child_process.exit_code_from_status (child_process.status)
		end

feature {PROCESS_TIMER}  -- Status checking

	check_exit is
			-- Check whether process has exited.
		do
			clean_up
		end

feature {PROCESS_IO_LISTENER_THREAD} -- Interprocess data transmit

	read_output_stream is
			-- Read output data from process.
			-- May block.
		do
			child_process.read_output_stream (buffer_size)
			last_output := child_process.last_output
		end

	read_error_stream is
			-- Read error data from process.
			-- May block.
		do
			child_process.read_error_stream (buffer_size)
			last_error := child_process.last_error
		end

	last_output: STRING
			-- Last output received from process

	last_error: STRING
			-- Last error received from process

feature{NONE} -- Status reporting

	has_process_terminated: BOOLEAN is
			-- Has process terminated?
		do
			if not process_terminated then
				child_process.wait_for_process (id, False)
				set_internal_process_terminated (child_process.status_available)
			end
			Result := process_terminated
		end

	all_finished: BOOLEAN is
			-- Have all launched-process-related operation finished?
		do
			mutex.lock
			Result := internal_all_finished
			mutex.unlock
		end

	output_thread_terminated: BOOLEAN is
			-- Has output listening thread terminated?
		do
			Result := (out_thread /= Void) implies out_thread.terminated
		end

	error_thread_terminated: BOOLEAN is
			-- Has error listening thread terminated?
		do
			Result := (err_thread /= Void) implies err_thread.terminated
		end

	listening_threads_terminated: BOOLEAN is
			-- Have output and error listening threads terminated?
		do
			Result := output_thread_terminated and error_thread_terminated
		end

	process_terminated: BOOLEAN is
			-- Has launched process terminated?
		do
			Result := internal_process_terminated
		end

feature {NONE}  -- Implementation

	internal_terminate (is_tree: BOOLEAN) is
			-- Terminate current launched process.
			-- If `is_tree' is True, terminate whole process group.
		require
			process_launched: launched
		do
			child_process.terminate_hard (is_tree)
			force_terminated := True
			last_operation_successful := True
			wait_for_exit
		ensure
			process_terminated: has_exited
		end

	set_internal_all_finished (b: BOOLEAN) is
			-- Set `internal_all_finished' with `b'.
		do
			mutex.lock
			internal_all_finished := b
			mutex.unlock
		ensure
			internal_all_finished_set: internal_all_finished = b
		end

	set_internal_process_terminated (b: BOOLEAN) is
			-- Set `internal_process_terminated' with `b'.
		do
			internal_process_terminated := b
		ensure
			internal_process_terminated_set: internal_process_terminated = b
		end

	prepare_for_launch is
			-- Prepare for launch.
		do
			launched := False
			force_terminated := False
			create_child_process_manager
			child_process.set_input_file_name (input_file_name)
			child_process.set_output_file_name (output_file_name)
			out_thread := Void
			err_thread := Void
			if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output then
				child_process.set_error_same_as_output
			else
				child_process.set_error_file_name (error_file_name)
			end
		ensure
			launched_set: not launched
			force_terminated_set: not force_terminated
			out_thread_set: out_thread = Void
			err_thread_set: err_thread = Void
		end

	setup_process_listeners is
			-- Setup listeners for process output/error and for process status acquiring.
		do
				-- Start  output listening thread is necessory
			if output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
				create out_thread.make (Current)
			   	out_thread.launch
			end
				-- Start a error listening thread is necessory	
			if (error_direction /= {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output)  then
				if error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_agent then
					create err_thread.make (Current)
					err_thread.launch
				end
			end
					-- Start a timer for process status acquiring.
			if timer /= Void then
				timer.start
			else
				create {PROCESS_THREAD_TIMER}timer.make (initial_time_interval // 1000)
				timer.set_process_launcher (Current)
				timer.start
			end
		end

	destroy_timer is
			-- Destroy `timer' and (if necessary) wait for it to exit.
		do
			if timer /= Void then
				timer.destroy
				from

				until
					timer.destroyed
				loop
					sleep (initial_time_interval)
				end
			end
		ensure
			timer_destroyed: (timer /= Void) implies timer.destroyed
		end

	wait_for_all_finished is
			-- Wait until `has_exited' is True.
		do
			from

			until
				has_exited
			loop
				clean_up
				sleep (initial_time_interval)
			end
		ensure
			all_process_related_operations_finished: has_exited
		end

	clean_up is
			-- Clean up threads, timer, pipes if process has exited and we have read all its output and error.
		do
			if not all_finished and then
			   listening_threads_terminated and then
			   has_process_terminated
			then
				if timer /= Void then
					timer.destroy
				end
				child_process.close_pipes
				set_internal_all_finished (True)
				if force_terminated then
					on_terminate
				else
					on_exit
				end
			end
		end

feature{NONE} -- Initialization

	setup_defaults is
			-- Setup defaults.
		do
			create mutex.default_create
			out_thread := Void
			err_thread := Void
			hidden := False
			separate_console := False
			last_error := Void
			last_output := Void
			buffer_size := initial_buffer_size

			cancel_input_redirection
			cancel_output_redirection
			cancel_error_redirection

			set_internal_process_terminated (True)
			set_internal_all_finished (True)

			last_operation_successful := True
			launched := False
		ensure
			out_thread_set: out_thread = Void
			err_thread_set: err_thread = Void
			hidden_set: hidden = False
			separate_console_set: not separate_console
			last_error_set: last_error = Void
			last_output_set: last_output = Void
			buffer_size_set: buffer_size = initial_buffer_size
			input_redirection_set: input_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			output_redirection_set: output_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
			error_redirection_set: error_direction = {PROCESS_REDIRECTION_CONSTANTS}.no_redirection
		end

	setup_command (a_exec_name: STRING; args: LIST[STRING]; a_working_directory: STRING) is
			-- Setup command line.
		require
			a_exec_name_not_void: a_exec_name /= Void
			a_exec_name_not_empty: not a_exec_name.is_empty
		do
			create command_line.make_from_string (a_exec_name)
			create executable.make_from_string (a_exec_name)
			if a_working_directory = Void then
				working_directory := Void
			else
				create working_directory.make_from_string (a_working_directory)
			end

			if args /= Void then
				create arguments.make
				from
					args.start
				until
					args.after
				loop
					command_line.append_character (' ')
					command_line.append (args.item)
					arguments.extend (args.item)
					args.forth
				end
			end
		ensure
			command_line_not_void: command_line /= Void
			command_line_not_empty: not command_line.is_empty
			executable_not_void: executable /= Void
			executable_not_empty: not executable.is_empty
			working_directory_set:
					((a_working_directory /= Void) implies working_directory.is_equal (a_working_directory)) and
					((a_working_directory = Void) implies working_directory = Void)
			arguments_set:
					(args /= Void implies (arguments /= Void and then arguments.count = args.count)) and
					(args = Void implies arguments = Void)
		end

	create_child_process_manager is
			-- Create child process manager
		require
			executable_not_void: executable /= Void
			executable_not_empty: not executable.is_empty
		do
			create child_process.make (executable, arguments, working_directory)
			child_process.set_close_nonstandard_files (True)
		end

feature {NONE} -- Implementation

	executable: STRING
			-- Program which will be launched

	out_thread: PROCESS_OUTPUT_LISTENER_THREAD
	err_thread: PROCESS_ERROR_LISTENER_THREAD
			-- Threads to listen to output and error from process

	Initial_buffer_size: INTEGER is 1024
			-- Initial size of buffer used to store interprocess data temporarily

	initial_time_interval: INTEGER is 10000
			-- Initial time interval in nanoseconds used to check process status

	mutex: MUTEX
			-- Internal mutex

	child_process: PROCESS_UNIX_PROCESS_MANAGER

	internal_process_terminated: BOOLEAN
			-- Launched process termination indicator

	internal_all_finished: BOOLEAN
			-- Internal indicator to show if launched process has exited and also its listeners have exited.

invariant
	child_process_not_void: child_process /= Void
	mutex_not_void: mutex /= Void

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
