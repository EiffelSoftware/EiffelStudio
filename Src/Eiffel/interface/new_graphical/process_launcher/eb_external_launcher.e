note
	description: "Object that is responsable for launching an external command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_LAUNCHER

inherit
	EB_PROCESS_LAUNCHER

	EB_SHARED_MANAGERS

	EB_EXTERNAL_OUTPUT_CONSTANTS

	EB_SHARED_PROCESS_IO_DATA_STORAGE

create
	initialize

feature{NONE} -- Initialization

	initialize
		do
			set_buffer_size (initial_buffer_size)
			set_time_interval (initial_time_interval)
			set_output_handler (agent output_dispatch_handler (?))

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

feature -- Status reporting

	is_launch_session_over: BOOLEAN
			-- Is an external command output printing session over?
			-- A luanch session is the time duration from process being launched to all
			-- its output and error has been printed out.

feature -- Status setting

	set_launch_session_over (b: BOOLEAN)
			-- Set `is_launch_session_over' with `b'.
		do
			is_launch_session_over := b
		ensure
			is_launch_session_over_set: is_launch_session_over = b
		end

	set_original_command_name (name: STRING)
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

	set_external_commands_status (b: BOOLEAN)
			-- Enable or disable sensitive of all external commands according to `b' (True for enable, False for disable).
		local
			eec: EB_EXTERNAL_COMMAND
		do
			from
				commands.start
			until
				commands.after
			loop
				eec := commands.item_for_iteration
				if eec /= Void then
					if b then
						eec.enable_sensitive
					else
						eec.disable_sensitive
					end
				end
				commands.forth
			end
		end

feature{NONE} -- Synchronization

	synchronize_on_external_start
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

	synchronize_on_external_exit
			-- Synchronize when external command exits.
		do
			external_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make ("", False, True))
		end

feature	-- Actions

	on_ouput_print_session_over
			-- Agent called when an external command output printing session over
			-- to synchronize status.
		do
			set_external_commands_status (True)
			external_output_manager.synchronize_on_process_exits
			set_launch_session_over (True)
		end

feature{NONE} -- Actions

	on_start

		do
			synchronize_on_external_start
			start_actions.call (Void)
		end

	on_exit
		do
			external_output_manager.display_state (l_command_has_exited_with_code (external_launcher.exit_code), False)
			synchronize_on_external_exit
			exited_actions.call (Void)
			finished_actions.call (Void)
		end

	on_terminate
		do
			external_storage.wipe_out
			external_output_manager.display_state (l_command_has_been_terminated, False)
			synchronize_on_external_exit
			terminated_actions.call (Void)
			finished_actions.call (Void)
		end

	on_launch_failed
		do
			external_storage.wipe_out
			external_output_manager.display_state (l_launch_failed, True)
			synchronize_on_external_exit
			launch_failed_actions.call (Void)
			finished_actions.call (Void)
		end

	on_launch_successed
		do
			external_output_manager.display_state (l_command_is_running, False)
			launched_actions.call (Void)
		end

feature{NONE} -- Implementation

	original_command_name: STRING
			-- Original external name

	commands: HASH_TABLE [EB_EXTERNAL_COMMAND, INTEGER]
			-- Abstract representation of external commands.
		do
			Result := (create {EB_EXTERNAL_COMMANDS_EDITOR}.make).commands
		end

	output_dispatch_handler (s: STRING)
			-- Agent called when output from process arrives.
		local
			sb: EB_PROCESS_IO_STRING_BLOCK
		do
			create sb.make (s, False, False)
			external_storage.extend_block (sb)
		end

	error_dispatch_handler (s: STRING)
			-- Agent called when error from process arrives.
		local
			sb: EB_PROCESS_IO_STRING_BLOCK
		do
			create sb.make (s, True, False)
			external_storage.extend_block (sb)
		end

feature{NONE} -- Process data storage

	data_storage: EB_PROCESS_IO_STORAGE
			-- Data storage used to store output and error that come from the launched process
		do
			Result := external_storage
		end
note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
