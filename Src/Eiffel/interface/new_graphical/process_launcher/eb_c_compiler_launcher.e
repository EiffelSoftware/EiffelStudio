note
	description: "C compiler launcher used in EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
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

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE}	-- Initialization

	make (a_is_for_finalization: like is_for_finalization)
			-- Set up c compiler launch parameters for `a_is_for_finalization' C compilation mode.
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
			is_for_finalization := a_is_for_finalization
		ensure
			is_for_finalization_set: is_for_finalization = a_is_for_finalization
			buffer_size_set: buffer_size = initial_buffer_size
			time_interval_set: time_interval = initial_time_interval
		end

feature -- Access

	is_for_finalization: BOOLEAN
			-- Is this instance made for C compilation in finalization mode?

feature {NONE} -- Access

	c_compiler_context: UUID
			-- Event list service context id.
		once
			create Result.make_from_string ("E1FFE1CC-D45B-4A56-87C5-B64535BAFE1B")
		ensure
			result_attached: attached Result
		end

	switched_output: detachable OUTPUT_I
			-- The output object the C compiler launcher switched from when launching.

feature {NONE} -- Status report

	has_output_switched: BOOLEAN
			-- Indicates if the output was switched to the C compiler output.
		do
			Result := attached switched_output
		ensure
			switched_output_attached: Result implies attached switched_output
		end

feature {NONE} -- Helpers

	event_list: SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to the event list service
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_c_compilation_type
			-- Set c compilation type, either freezing or finalizing.
		do
			set_is_last_c_compilation_freezing (not is_for_finalization)
		ensure then
			compilation_type_set: is_last_c_compilation_freezing = not is_for_finalization
			compilation_type_set: is_last_c_compilation_finalizing = is_for_finalization
		end

feature -- Path

	generation_path: PATH
			-- Path on which c compiler will be launched.
			-- Used when we need to open a console there.
		do
			if is_for_finalization then
				Result := project_location.final_path
			else
				Result := project_location.workbench_path
			end
		end

feature{NONE} -- Agents

	output_dispatch_handler (s: STRING)
			-- Agent called to store output `s' from c compiler
		local
			sblock: EB_PROCESS_IO_STRING_BLOCK
		do
			create sblock.make (s, False, False)
			data_storage.extend_block (sblock)
		end

	error_dispatch_handler (s: STRING)
			-- Agent called to store error `s' from c compiler	
		local
			sblock: EB_PROCESS_IO_STRING_BLOCK
		do
			create sblock.make (s, True, False)
			data_storage.extend_block (sblock)
		end

feature -- Status report

	is_last_c_compilation_successful: BOOLEAN
			-- Is last c compilation successful?
		do
			Result := c_compilation_successful_cell.item
		end

feature{NONE}  -- Actions

	state_message_timer: EV_TIMEOUT
			-- Timer used to display c compilation status.
		once
			create Result.default_create
			Result.actions.extend (agent window_manager.display_c_compilation_progress (Interface_names.e_C_compilation_running))
		end

	synchronize_on_c_compilation_start
			-- Synchronize before launch c compiler.
		do
			if attached c_compiler_output as l_output_pane then
					-- Lock the output to prevent others from accessing it.
				l_output_pane.lock
				l_output_pane.clear
			end

			data_storage.reset_output_byte_count
			data_storage.reset_error_byte_count
			Eb_debugger_manager.on_compile_start
			window_manager.on_c_compilation_start

			if
				attached {ES_OUTPUT_PANE_I} c_compiler_output as l_output_pane and then
				attached window_manager.last_focused_development_window as l_window and then
				attached {ES_OUTPUTS_TOOL} l_window.shell_tools.tool ({ES_OUTPUTS_TOOL}) as l_tool
			then
				if
					preferences.development_window_data.external_compilation_output_prompted or else
					(l_tool.is_shown and then l_tool.output = compiler_output)
				then
						-- Force showing of the tool.
					l_tool.show (False)
				end

					-- Activate (not show) the C compiler output.
				switched_output := l_tool.output
				l_output_pane.activate (False)
			end

			if state_message_timer.interval = 0 then
				state_message_timer.set_interval (initial_time_interval)
			end
			display_message_on_main_output (c_compilation_launched_msg, True)
		end

	synchronize_on_c_compilation_exit
			-- Synchronize when c compiler exits.
		do
			set_c_compilation_type
			eb_debugger_manager.on_compile_stop
			window_manager.on_c_compilation_stop
			data_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make ("", False, True))
			if not process_manager.is_c_compilation_running then
				state_message_timer.set_interval (0)
			end

			if attached c_compiler_output as l_output_pane then
					-- Unlock the output to prevent allowing others to access it.
				l_output_pane.unlock
			end

				-- Switch back to the previous output that was activated prior to the c compilation
			if attached window_manager.last_focused_development_window as l_window then
				if
					is_last_c_compilation_successful and then
					has_output_switched and then
					attached {ES_OUTPUTS_TOOL} l_window.shell_tools.tool ({ES_OUTPUTS_TOOL}) as l_tool and then
					attached switched_output as l_switched_output and then
					l_tool.output = c_compiler_output
				then
						-- The output was switched when starting the C compilation so now switch it back, if possible.
						-- No switching will occur if the outputs tool is now hidden or if the user switched to a different tool.
					l_switched_output.activate (False)
				elseif not is_last_c_compilation_successful and then preferences.error_list_tool_data.report_c_compiler_errors then
						-- The C compilation failed and the error list will report errors, show the error list tool.
					l_window.shell_tools.show_tool ({ES_ERROR_LIST_TOOL}, True)
				end
			end

			switched_output := Void
		ensure
			switched_output_detached: not attached switched_output
		end

	on_start
			-- Handler called before c compiler starts
		do
				-- Remove any event list error items.
			if event_list.is_service_available then
				event_list.service.prune_event_items (c_compiler_context)
			end

				-- Rest the switched from output
			switched_output := Void

			synchronize_on_c_compilation_start
			start_actions.call (Void)

			if is_for_finalization then
				idle_printing_manager.add_printer ({EB_IDLE_PRINTING_MANAGER}.finalizing_printer)
			else
				idle_printing_manager.add_printer ({EB_IDLE_PRINTING_MANAGER}.freezing_printer)
			end
		end

	on_exit
			-- Handler called when c compiler exits
		local
			l_error: C_COMPILER_ERROR
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
					if event_list.is_service_available then
						create l_error.make (locale_formatter.translation (e_see_output))
						event_list.service.put_event_item (c_compiler_context, create {EVENT_LIST_ERROR_ITEM}.make ({ENVIRONMENT_CATEGORIES}.compilation, l_error.message, l_error))
					end
				else
					window_manager.display_message (Interface_names.e_c_compilation_succeeded)
					display_message_on_main_output (c_compilation_succeeded_msg, True)
				end
			end
			exited_actions.call (Void)
			finished_actions.call (Void)
		end

	on_launch_successed
			-- Handler called when c compiler launch successed
		do
			launched_actions.call (Void)
		end

	on_launch_failed
			-- Handler called when c compiler launch failed
		local
			l_error: C_COMPILER_ERROR
		do
			c_compilation_successful_cell.put (False)
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_C_compilation_launch_failed)
			display_message_on_main_output (c_compilation_launch_failed_msg, True)
			if event_list.is_service_available then
				create l_error.make (locale_formatter.translation (e_could_not_launch))
				event_list.service.put_event_item (c_compiler_context, create {EVENT_LIST_ERROR_ITEM}.make ({ENVIRONMENT_CATEGORIES}.compilation, l_error.message, l_error))
			end
			launch_failed_actions.call (Void)
			finished_actions.call (Void)
		end

	on_terminate
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

feature {NONE} -- Implementation

	data_storage: EB_PROCESS_IO_STORAGE
			-- <Precursor>
		do
			if is_for_finalization then
				Result := finalizing_storage
			else
				Result := freezing_storage
			end
		end

	c_compilation_launched_msg: STRING_32
			-- Message to indicate c compilation launched successfully
		do
			if is_for_finalization then
				Result := interface_names.e_finalizing_launched
			else
				Result := interface_names.e_freezing_launched
			end
		end

	c_compilation_launch_failed_msg: STRING_32
			-- Message to indicate c compilation launch failed
		do
			if is_for_finalization then
				Result := interface_names.e_finalizing_launch_failed
			else
				Result := interface_names.e_freezing_launch_failed
			end
		end

	c_compilation_succeeded_msg: STRING_32
			-- Message to indicate c compilation exited successfully
		do
			if is_for_finalization then
				Result := interface_names.e_finalizing_succeeded
			else
				Result := interface_names.e_freezing_succeeded
			end
		end

	c_compilation_failed_msg: STRING_32
			-- Message to indicate c compilation failed
		do
			if is_for_finalization then
				Result := interface_names.e_finalizing_failed
			else
				Result := interface_names.e_freezing_failed
			end
		end

	c_compilation_terminated_msg: STRING_32
			-- Message to indicate c compilation has been terminated
		do
			if is_for_finalization then
				Result := interface_names.e_finalizing_terminated
			else
				Result := interface_names.e_freezing_terminated
			end
		end

	display_message_on_main_output (a_msg: STRING_32; a_suffix: BOOLEAN)
			-- Display `a_msg' on main output panel.
			-- If `a_suffix' is True, add ".%N" to end of `a_msg'.
		require
			a_msg_not_void: a_msg /= Void
			a_msg_not_emtpy: not a_msg.is_empty
		local
			l_formatter: like general_formatter
			l_locked: BOOLEAN
		do
			if (attached compiler_output as l_output) then
				l_output.lock
				l_locked := True
			end

			l_formatter := compiler_formatter
			l_formatter.process_basic_text (a_msg)
			if a_suffix then
				l_formatter.process_character_text (".")
				l_formatter.process_new_line
			end
			if l_locked and then (attached compiler_output as l_output) then
				l_locked := False
				l_output.unlock
			end
		rescue
			if l_locked and then (attached compiler_output as l_output) then
				l_output.unlock
			end
		end

	open_console
			-- Open a command line console if c-compilation failed.
		require
			generation_path_not_void: generation_path /= Void
		do
			open_console_in_dir (generation_path)
		end

	do_not_open_console
			-- Empty agent.
		do
		end

	c_compilation_successful_cell: CELL [BOOLEAN]
			-- Cell to hold c compilation successful flag
		once
			create Result.put (False)
		end

feature {NONE} -- Internationalization

	e_see_output: STRING = "Please review the External Compilation output of the Outputs Tool."
	e_could_not_launch: STRING = "Could not launch C/C++ compiler."

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
