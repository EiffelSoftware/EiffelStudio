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

	EB_SHARED_MANAGERS

	SHARED_PLATFORM_CONSTANTS

	PROJECT_CONTEXT

	EB_CONSTANTS

	EB_SHARED_FLAGS

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
			eb_debugger_manager.on_compile_start
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
			a_dev_window.start_c_output_pixmap_timer
		end

	stop_pixmap_animation_timer (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Stop pixmap animation on `a_dev_window'.
		do
			a_dev_window.stop_c_output_pixmap_timer
		end

	on_start is
			-- Handler called before c compiler starts
		do
			synchronize_on_c_compilation_start
		end

	on_exit is
			-- Handler called when c compiler exits
		do
			synchronize_on_c_compilation_exit
			if launched then
				if exit_code /= 0 then
					window_manager.display_message (Interface_names.e_c_compilation_failed)
					display_message_on_main_output (c_compilation_failed_msg, True)
					show_compilation_error_dialog
				else
					window_manager.display_message (Interface_names.e_c_compilation_succeeded)
					display_message_on_main_output (c_compilation_succeeded_msg, True)
				end
			end
		end

	on_launch_successed is
			-- Handler called when c compiler launch successed
		do
		end

	on_launch_failed is
			-- Handler called when c compiler launch failed
		do
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_C_compilation_launch_failed)
			display_message_on_main_output (c_compilation_launch_failed_msg, True)
			show_compiler_launch_fail_dialog (window_manager.last_created_window.window)
		end

	on_terminate is
			-- Handler called when c compiler has been terminated
		do
			data_storage.wipe_out
			data_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make (c_compilation_terminated_msg+".%N", False, False))
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_c_compilation_terminated)
			display_message_on_main_output (c_compilation_terminated_msg, True)
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
			output_manager.add_string (a_msg)
			if a_suffix then
				output_manager.add_char ('.')
				output_manager.add_new_line
			end
			output_manager.scroll_to_end
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

	show_compilation_error_dialog is
			-- Dialog box showed when c compilation generates any error
		local
			str: STRING

			dlg: EV_CONFIRMATION_DIALOG
			actions: ARRAY [PROCEDURE [ANY, TUPLE]]
			maps: EV_STOCK_PIXMAPS
		do
				-- C compilation failed.
				-- Ask user whether open a console.
			create actions.make (1, 2)
			actions.put (agent do_not_open_console, 1)
			actions.put (agent open_console, 2)
			str := "C-compilation produced errors.%N"


			if platform_constants.is_windows then
				str.append ("Run `nmake -s -nologo` from the directory `")
			else
				str.append ("Run `make -s -nologo` from the directory `")
			end
			str.append (working_directory)
			str.append ("`%Nto see what went wrong.%N%NClick OK to terminate.")
			if platform_constants.is_windows then
				str.append ("%NClick Cancel to open a command line console.%N")
			else
				str.append ("%NClick Cancel to open a command line console.%N")
			end
			create dlg.make_with_text_and_actions (str, actions)
			dlg.set_title ("Finish Freezing Status")
			create maps
			dlg.set_icon_pixmap (maps.warning_pixmap)
			dlg.set_pixmap (maps.warning_pixmap)
			dlg.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	show_compiler_launch_fail_dialog (win: EV_WINDOW) is
			-- Dialog box showed when c compiler launch failed
		local
			str: STRING

			dlg: EV_WARNING_DIALOG
			--actions: ARRAY [PROCEDURE [ANY, TUPLE]]
			maps: EV_STOCK_PIXMAPS
		do
				-- C compilation launch failed.
			str := "C-compilation manager launch failed.%NCheck if finish_freezing"
			if platform_constants.is_windows then
				str.append (".exe")
			else
					-- No action				
			end
			str.append (" exists and works correctly.")

			create dlg.make_with_text (str)
			dlg.set_title ("finish_freezing Launch Error")
			create maps
			dlg.set_icon_pixmap (maps.warning_pixmap)
			dlg.set_pixmap (maps.warning_pixmap)
			dlg.show_modal_to_window (win)
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
