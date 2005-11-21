indexing
	description: "C compiler launcher used in EiffelStudio"
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


feature{NONE}	-- Initialization

	make is
			-- Set up c compiler launch parameters.
			-- `l_storage' is storage for output and error from c compilation.
			-- `gen_path' is directory on which c compiler will be launched.
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

	synchronize_on_c_compilation_start is
			-- Synchronize before launch c compiler.
		do
			data_storage.reset_output_byte_count
			data_storage.reset_error_byte_count
			debugger_manager.on_compile_start

			terminate_c_compilation_cmd.enable_sensitive
			notify_development_windows_on_c_compilation_start
			c_compilation_output_manager.clear
			c_compilation_output_manager.force_display
		end

	synchronize_on_c_compilation_exit is
			-- Synchronize when c compiler exits.
		do
			debugger_manager.on_compile_stop
			terminate_c_compilation_cmd.disable_sensitive
			window_manager.synchronize_all
			notify_development_windows_on_c_compilation_stop
			data_storage.extend_block (create {EB_PROCESS_IO_STRING_BLOCK}.make ("", False, True))
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
					show_compilation_error_dialog
				else
					window_manager.display_message (Interface_names.e_c_compilation_successed)
				end
			end
		end

	on_launch_successed is
			-- Handler called when c compiler launch successed
		do
			set_last_c_compiler_launch_successful (True)
		end

	on_launch_failed is
			-- Handler called when c compiler launch failed
		do
			set_last_c_compiler_launch_successful (False)
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_C_compilation_launch_failed)
			show_compiler_launch_fail_dialog (window_manager.last_created_window.window)
		end

	on_terminate is
			-- Handler called when c compiler has been terminated
		do
			data_storage.wipe_out
			synchronize_on_c_compilation_exit
			window_manager.display_message (Interface_names.e_c_compilation_terminated)
		end

feature{NONE} -- Implementation

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

	notify_development_windows_on_c_compilation_start is
			-- Notify every development window to disable
			-- "Compile Workbench C Code" item and
			-- "Compile Finalized C Code" item in
			-- Project menu.
		local
			a_dev: EB_DEVELOPMENT_WINDOW
			cur: CURSOR
		do
			from
				cur := window_manager.managed_windows.cursor
				window_manager.managed_windows.start
			until
				window_manager.managed_windows.after
			loop
				a_dev ?= window_manager.managed_windows.item
				if a_dev /= Void then
					a_dev.c_workbench_compilation_cmd.disable_sensitive
					a_dev.c_finalized_compilation_cmd.disable_sensitive
				end
				window_manager.managed_windows.forth
			end
			window_manager.managed_windows.go_to (cur)
			Run_finalized_cmd.disable_sensitive
		end

	notify_development_windows_on_c_compilation_stop is
			-- Notify every development window to enable
			-- "Compile Workbench C Code" item and
			-- "Compile Finalized C Code" item in
			-- Project menu.
		local
			a_dev: EB_DEVELOPMENT_WINDOW
			cur: CURSOR
		do
			from
				cur := window_manager.managed_windows.cursor
				window_manager.managed_windows.start
			until
				window_manager.managed_windows.after
			loop
				a_dev ?= window_manager.managed_windows.item
				if a_dev /= Void then
					a_dev.c_workbench_compilation_cmd.enable_sensitive
					a_dev.c_finalized_compilation_cmd.enable_sensitive
				end
				window_manager.managed_windows.forth
			end
			window_manager.managed_windows.go_to (cur)
			Run_finalized_cmd.enable_sensitive
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

end
