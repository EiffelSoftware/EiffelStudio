indexing
	description: "Object that is responsible for launching c compiler in workbench mode."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FREEZING_LAUNCHER

inherit
	EB_C_COMPILER_LAUNCHER

create
	make

feature{NONE} -- Initialization

	make is
		do
			set_buffer_size (initial_buffer_size)
			set_time_interval (initial_time_interval)

			set_output_handler (agent output_dispatch_handler (?))
			set_error_handler (agent error_dispatch_handler (?))

			set_on_start_handler (agent on_start)
			set_on_exit_handler (agent on_exit)
			set_on_terminate_handler (agent on_terminate)
			set_on_fail_launch_handler (agent on_launch_failed)
			set_on_successful_launch_handler (agent on_launch_successed)
		ensure
			buffer_size_set: buffer_size = initial_buffer_size
			time_interval_set: time_interval = initial_time_interval
		end

feature{NONE}  -- Actions

	on_start is
			--
		do
			freezing_storage.reset_output_byte_count
			freezing_storage.reset_error_byte_count

			if is_gui then
				debugger_manager.on_compile_start
				terminate_c_compilation_cmd.enable_sensitive
				notify_development_windows_on_c_compilation_start
				c_compilation_output_manager.clear
				c_compilation_output_manager.force_display
			end
		end

	on_exit is
			--
		do
			if is_gui then
				debugger_manager.on_compile_stop
				terminate_c_compilation_cmd.disable_sensitive
				window_manager.synchronize_all
				notify_development_windows_on_c_compilation_stop
				if freezing_launcher.launched and then not freezing_launcher.force_terminated then
					if freezing_launcher.exit_code /= 0 then
						window_manager.display_message (Interface_names.e_c_compilation_failed)
						show_compilation_error_dialog
					else
						window_manager.display_message (Interface_names.e_c_compilation_successed)
					end
				end
			end
		end

	on_terminate is
			-- handler called when c compiler has been terminated.
		do
			if is_gui then
				freezing_storage.wipe_out
				freezing_storage.extend_block (create {EB_PROCESS_IO_STRUCTURED_TEXT_BLOCK}.make (" ", False, True))
			end
			on_exit
			if is_gui then
				window_manager.display_message (Interface_names.e_c_compilation_terminated)
			end
		end

	on_launch_successed is
			--
		do
			set_last_c_compilation_successful (True)
		end

	on_launch_failed is
			--
		do
			if is_gui then
				set_last_c_compilation_successful (False)
				debugger_manager.on_compile_stop
				terminate_c_compilation_cmd.disable_sensitive
				window_manager.synchronize_all
				notify_development_windows_on_c_compilation_stop
				freezing_storage.extend_block (create {EB_PROCESS_IO_STRUCTURED_TEXT_BLOCK}.make ("Background C compilation launch failed.%N", True, True))
				freezing_storage.reset_error_byte_count
				window_manager.display_message (Interface_names.e_C_compilation_launch_failed)
				show_compiler_launch_fail_dialog (window_manager.last_created_window.window)
			end
		end

	output_dispatch_handler (s: STRING) is
			-- Agent called to store output `s' from c compiler	
		local
			sb: EB_PROCESS_IO_STRUCTURED_TEXT_BLOCK
		do
			create sb.make (s, False, False)
			freezing_storage.extend_block (sb)
		end

	error_dispatch_handler (s: STRING) is
			-- Agent called to store error `s' from c compiler		
		local
			sb: EB_PROCESS_IO_STRUCTURED_TEXT_BLOCK
		do
			create sb.make (s, True, False)
			freezing_storage.extend_block (sb)
		end

	open_console is
			-- Open a command line console if c-compilation failed.
		do
			open_console_in_dir (workbench_generation_path)
		end

end
