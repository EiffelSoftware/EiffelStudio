indexing
	description: "C compiler launcher used in EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_C_COMPILER_LAUNCHER

inherit
	EB_PROCESS_LAUNCHER

	EB_SHARED_PROCESS_IO_DATA_STORAGE

	EB_SHARED_GRAPHICAL_COMMANDS

	EB_SHARED_DEBUGGER_MANAGER

	EB_SHARED_MANAGERS

	SHARED_PLATFORM_CONSTANTS

	PROJECT_CONTEXT

	EB_CONSTANTS

	SHARED_FLAGS

	EB_SHARED_PREFERENCES

feature{NONE}	-- Initialization

	make is
			-- Set up c compiler launch parameters.
			-- `l_storage' is storage for output and error from c compilation.
			-- `gen_path' is directory on which c compiler will be launched.
		do
			set_buffer_size (initial_buffer_size)
			set_time_interval (initial_time_interval)
			set_output_handler (agent output_dispatch_handler (?))

			set_on_start_handler (agent on_start)
			set_on_exit_handler (agent on_exit)
			set_on_terminate_handler (agent on_terminate)
			set_on_fail_launch_handler (agent on_launch_failed)
			set_on_successful_launch_handler (agent on_launch_successed)
		ensure
			buffer_size_set: buffer_size = initial_buffer_size
			time_interval_set: time_interval = initial_time_interval
		end

feature {NONE} -- Access

	c_compiiled_context: UUID
			-- Event list service context id
		once
			create Result.make_from_string ("E1FFE1CC-D45B-4A56-87C5-B64535BAFE1B")
		end

feature -- Setting

	set_c_compilation_type is
			-- Set c compilation type, either freezing or finalizing.
		deferred
		end

feature -- Path

	generation_path: STRING is
			-- Path on which c compiler will be launched.
			-- Used when we need to open a console there.
		deferred
		end

feature{NONE} -- Agents

	output_dispatch_handler (s: STRING) is
			-- Agent called to store output `s' from c compiler
		local
			sblock: EB_PROCESS_IO_STRING_BLOCK
		do
			create sblock.make (s, False, False)
			data_storage.extend_block (sblock)
		end

	error_dispatch_handler (s: STRING) is
			-- Agent called to store error `s' from c compiler	
		local
			sblock: EB_PROCESS_IO_STRING_BLOCK
		do
			create sblock.make (s, True, False)
			data_storage.extend_block (sblock)
		end

feature -- Status report

	is_last_c_compilation_successful: BOOLEAN is
			-- Is last c compilation successful?
		do
			Result := c_compilation_successful_cell.item
		end

feature{NONE}  -- Actions

	state_message_timer: EV_TIMEOUT is
			-- Timer used to display c compilation status.
		once
			create Result.default_create
			Result.actions.extend (agent window_manager.display_c_compilation_progress (Interface_names.e_C_compilation_running))
		end

	synchronize_on_c_compilation_start is
			-- Synchronize before launch c compiler.
		do
			data_storage.reset_output_byte_count
			data_storage.reset_error_byte_count
			Eb_debugger_manager.on_compile_start
			window_manager.on_c_compilation_start
			c_compilation_output_manager.clear
			if preferences.development_window_data.c_output_panel_prompted then
				c_compilation_output_manager.force_display
			end
			if state_message_timer.interval = 0 then
				state_message_timer.set_interval (initial_time_interval)
				window_manager.for_all_development_windows (agent start_pixmap_animation_timer (?))
			end
			display_message_on_main_output (c_compilation_launched_msg, True)
		end

	synchronize_on_c_compilation_exit is
			-- Synchronize when c compiler exits.
		do
			set_c_compilation_type
			eb_debugger_manager.on_compile_stop
			window_manager.on_c_compilation_stop
			data_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make ("", False, True))
			if not process_manager.is_c_compilation_running then
				state_message_timer.set_interval (0)
				window_manager.for_all_development_windows (agent stop_pixmap_animation_timer (?))
			end
		end

	start_pixmap_animation_timer (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Start pixmap animation on `a_dev_window'.
		do
			a_dev_window.tools.c_output_tool.start_c_output_pixmap_timer
		end

	stop_pixmap_animation_timer (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Stop pixmap animation on `a_dev_window'.
		do
			a_dev_window.tools.c_output_tool.stop_c_output_pixmap_timer
		end

	on_start is
			-- Handler called before c compiler starts
		local
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
		do
			create l_consumer
			if l_consumer.is_service_available then
				l_consumer.service.prune_event_items (c_compiiled_context)
			end
			synchronize_on_c_compilation_start
			start_actions.call (Void)
		end

	on_exit is
			-- Handler called when c compiler exits
		local
			l_error: C_COMPILER_ERROR
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
		do
			if launched then
				if exit_code /= 0 then
					c_compilation_successful_cell.put (False)
				else
					c_compilation_successful_cell.put (True)
				end
			end
			synchronize_on_c_compilation_exit
			if launched then
				if exit_code /= 0 then
					window_manager.display_message (Interface_names.e_c_compilation_failed)
					display_message_on_main_output (c_compilation_failed_msg, True)
					create l_consumer
					if l_consumer.is_service_available then
						create l_error.make ("Please review the C Output Pane.")
						l_consumer.service.put_event_item (c_compiiled_context, create {EVENT_LIST_ERROR_ITEM}.make ({ENVIRONMENT_CATEGORIES}.compilation, l_error.message, l_error))
					end
				else
					window_manager.display_message (Interface_names.e_c_compilation_succeeded)
					display_message_on_main_output (c_compilation_succeeded_msg, True)
				end
			end
			exited_actions.call (Void)
			finished_actions.call (Void)
		end

	on_launch_successed is
			-- Handler called when c compiler launch successed
		do
			launched_actions.call (Void)
		end

	on_launch_failed is
			-- Handler called when c compiler launch failed
		local
			l_error: C_COMPILER_ERROR
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
		do
			c_compilation_successful_cell.put (False)
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_C_compilation_launch_failed)
			display_message_on_main_output (c_compilation_launch_failed_msg, True)
			create l_consumer
			if l_consumer.is_service_available then
				create l_error.make ("Could not launch C/C++ compiler.")
				l_consumer.service.put_event_item (c_compiiled_context, create {EVENT_LIST_ERROR_ITEM}.make ({ENVIRONMENT_CATEGORIES}.compilation, l_error.message, l_error))
			end
			launch_failed_actions.call (Void)
			finished_actions.call (Void)
		end

	on_terminate is
			-- Handler called when c compiler has been terminated
		do
			c_compilation_successful_cell.put (True)
			data_storage.wipe_out
			data_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make (c_compilation_terminated_msg+".%N", False, False))
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_c_compilation_terminated)
			display_message_on_main_output (c_compilation_terminated_msg, True)
			terminated_actions.call (Void)
			finished_actions.call (Void)
		end

feature{NONE} -- Implementation

	c_compilation_launched_msg: STRING is
			-- Message to indicate c compilation launched successfully
		deferred
		end

	c_compilation_launch_failed_msg: STRING is
			-- Message to indicate c compilation launch failed
		deferred
		end

	c_compilation_succeeded_msg: STRING is
			-- Message to indicate c compilation exited successfully
		deferred
		end

	c_compilation_failed_msg: STRING is
			-- Message to indicate c compilation failed
		deferred
		end

	c_compilation_terminated_msg: STRING is
			-- Message to indicate c compilation has been terminated
		deferred
		end

	display_message_on_main_output (a_msg: STRING; a_suffix: BOOLEAN) is
			-- Display `a_msg' on main output panel.
			-- If `a_suffix' is True, add ".%N" to end of `a_msg'.
		require
			a_msg_not_void: a_msg /= Void
			a_msg_not_emtpy: not a_msg.is_empty
		do
			output_manager.start_processing (True)
			output_manager.add_string (a_msg)
			if a_suffix then
				output_manager.add_char ('.')
				output_manager.add_new_line
			end
			output_manager.scroll_to_end
			output_manager.end_processing
		end

	open_console is
			-- Open a command line console if c-compilation failed.
		require
			generation_path_not_void: generation_path /= Void
		do
			open_console_in_dir (generation_path)
		end

	do_not_open_console is
			-- Empty agent.
		do
		end

	c_compilation_successful_cell: CELL [BOOLEAN] is
			-- Cell to hold c compilation successful flag
		once
			create Result.put (False)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
