indexing
	description: "Object that is responsable for launching an external command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_LAUNCHER

inherit
	EB_PROCESS_LAUNCHER
		redefine
			terminate
		end

	EB_SHARED_MANAGERS

	EB_EXTERNAL_OUTPUT_CONSTANTS

	EB_SHARED_PROCESS_IO_DATA_STORAGE

create
	initialize

feature{NONE} -- Initialization

	initialize is
		do
			set_buffer_size (initial_buffer_size)
			set_time_interval (initial_time_interval)
			set_output_handler (agent output_dispatch_handler (?))
--			set_error_handler (agent error_dispatch_handler (?))

			set_on_start_handler (agent on_start)
			set_on_exit_handler (agent on_exit)
			set_on_terminate_handler (agent on_terminate)
			set_on_fail_launch_handler (agent on_launch_failed)
			set_on_successful_launch_handler (agent on_launch_successed)
			set_launch_session_over (True)
		ensure
			buffer_size_set: buffer_size = initial_buffer_size
			time_interval_set: time_interval = initial_time_interval
		end

feature -- Command termination

	terminate is
			-- Terminate child process.
		do
			if launched and then (not has_exited) then
					-- If process is still running, terminate it.
				prc.terminate_tree
			else
					-- If process has exited, but some of its output has not been printed,
					-- discard this output.
				on_terminate
			end
		end

feature -- Status reporting

	is_launch_session_over: BOOLEAN
			-- Is an external command output printing session over?
			-- A luanch session is the time duration from process being launched to all
			-- its output and error has been printed out.

feature -- Status setting

	set_launch_session_over (b: BOOLEAN) is
			-- Set `is_launch_session_over' with `b'.
		do
			is_launch_session_over := b
		ensure
			is_launch_session_over_set: is_launch_session_over = b
		end

	set_original_command_name (name: STRING) is
			-- Set `original_command_name' with `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			create original_command_name.make_from_string (name)
		ensure
			original_command_name_set: original_command_name.is_equal (name)
		end

feature -- External commands status setting

	set_external_commands_status (b: BOOLEAN) is
			-- Enable or disable sensitive of all external commands according to `b' (True for enable, False for disable).
		local
			i, cnt: INTEGER
			eec: EB_EXTERNAL_COMMAND
		do
			from
				i := commands.lower
				cnt := commands.upper
			until
				i > cnt
			loop
				eec := commands.item (i)
				if eec /= Void then
					if b then
						eec.enable_sensitive
					else
						eec.disable_sensitive
					end
				end
				i := i + 1
			end
		end

feature{NONE} -- Synchronization

	synchronize_on_external_start is
			-- Synchronize when external command starts.
		local
			dev_win: EB_DEVELOPMENT_WINDOW
		do
			set_external_commands_status (False)
			external_storage.reset_output_byte_count
			external_storage.reset_error_byte_count
			dev_win := window_manager.last_focused_development_window
			external_output_manager.set_target_development_window (dev_win)
			external_output_manager.force_display
			external_output_manager.display_state (l_launching, False)
			external_output_manager.synchronize_on_process_starts (original_command_name)
			set_launch_session_over (False)
			idle_printing_manager.add_printer ({EB_IDLE_PRINTING_MANAGER}.external_printer)
		end

	synchronize_on_external_exit is
			-- Synchronize when external command exits.
		do
			external_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make ("", False, True))
		end

feature	-- Actions

	on_ouput_print_session_over is
			-- Agent called when an external command output printing session over
			-- to synchronize status.
		do
			set_external_commands_status (True)
			external_output_manager.synchronize_on_process_exits
			set_launch_session_over (True)
		end

feature{NONE} -- Actions

	on_start is

		do
			synchronize_on_external_start
		end

	on_exit is
		do
			external_output_manager.display_state (l_command_has_exited+" with code "+external_launcher.exit_code.out, False)
			synchronize_on_external_exit
		end

	on_terminate is
		do
			external_storage.wipe_out
			external_output_manager.display_state (l_command_has_been_terminated, False)
			synchronize_on_external_exit
		end

	on_launch_failed is
		do
			external_storage.wipe_out
			external_output_manager.display_state (l_launch_failed, True)
			synchronize_on_external_exit
		end

	on_launch_successed is
		do
			external_output_manager.display_state (l_command_is_running, False)
		end

feature{NONE} -- Implementation

	original_command_name: STRING
			-- Original external name

	commands: ARRAY [EB_EXTERNAL_COMMAND] is
			-- Abstract representation of external commands.
		do
			Result := (create {EB_EXTERNAL_COMMANDS_EDITOR}.make).commands
		end

	output_dispatch_handler (s: STRING) is
			-- Agent called when output from process arrives.
		local
			sb: EB_PROCESS_IO_STRING_BLOCK
		do
			create sb.make (s, False, False)
			external_storage.extend_block (sb)
		end

	error_dispatch_handler (s: STRING) is
			-- Agent called when error from process arrives.
		local
			sb: EB_PROCESS_IO_STRING_BLOCK
		do
			create sb.make (s, True, False)
			external_storage.extend_block (sb)
		end

feature{NONE} -- Process data storage

	data_storage: EB_PROCESS_IO_STORAGE is
			-- Data storage used to store output and error that come from the launched process
		do
			Result := external_storage
		end
end
