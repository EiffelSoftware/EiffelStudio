indexing
	description	: "Command to update the Eiffel project."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MELT_PROJECT_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_BENCH_LICENSES
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_RESCUE_STATUS
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_PROJECT_TOOL_DATA
		export
			{NONE} all
		end

	EB_SHARED_FORMAT_TABLES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f7),
				False, False, False)
			accelerator.actions.extend (~execute)
		end

feature -- Properties

	is_precompiling: BOOLEAN is
			-- Is this compilation a precompilation?
		do
			-- False for a standard compilation
		end

feature -- Status Setting

	set_run_after_melt (b: BOOLEAN) is
			-- Request for the system to be executed after a
			-- successful melt compilation or not.
			-- Assign `b' to `run_after_melt'.
		do
			run_after_melt2 := b
		end

feature {NONE} -- Compilation implementation

	reset_debugger is
			-- Kill the application, if it is running.
		do
			Debugger_manager.on_compile_start
		end

	compile is
			-- Compile, in the one way or the other.
		local
			rescued: BOOLEAN
			st: STRUCTURED_TEXT
			wd: EV_WARNING_DIALOG
		do
			if not rescued then
				if not Eiffel_project.is_compiling then
					reset_debugger
					output_manager.clear
					Window_manager.on_compile
					perform_compilation

					if Eiffel_project.successful then
							-- If a freezing already occurred (due to a new external
							-- or new derivation of SPECIAL), no need to freeze again.
						if Eiffel_project.save_error then
							create st.make
							st.add_string ("Could not write to ")
							st.add_string (Project_directory_name)
							st.add_new_line
							st.add_string ("Please check permissions / disk space")
							st.add_new_line
							st.add_string ("and retry")
							st.add_new_line
							output_manager.process_text (st)
						else
							if not finalization_error then
								launch_c_compilation
							end
						end
					end

					tool_resynchronization
					Degree_output.finish_degree_output
				end
			else
					-- The project may be corrupted => the project
					-- becomes read-only.
				create wd.make_with_text (Warning_messages.w_Project_may_be_corrupted)
				wd.show_modal_to_window (window_manager.last_focused_window.window)

				tool_resynchronization
				Degree_output.finish_degree_output
			end

		rescue
			if not fail_on_rescue then
				if original_exception = Io_exception then
						-- We probably don't have the write permissions
						-- on the server files.
					rescued := true
					retry
				end
			end
		end

	tool_resynchronization is
			-- Resynchronize class, feature and system tools.
			-- Clear the format_context buffers.
		do
				-- Clear the format_context buffers.
			clear_format_tables

				-- Resynchronize windows
			progress_dialog.disable_cancel
			Degree_output.put_string (Interface_names.d_Resynchronizing_tools)
			window_manager.synchronize_all
			if Workbench.successful then
				window_manager.display_message (Interface_names.E_compilation_succeeded)
			else
				window_manager.display_message (Interface_names.E_compilation_failed)
			end
			Debugger_manager.on_compile_stop

			if dynamic_lib_window_is_valid and then dynamic_lib_window.is_visible then
				dynamic_lib_window.refresh
			end
		end

	launch_c_compilation is
			-- Launch the C compilation.
		local
			output_text: STRUCTURED_TEXT
		do
			create output_text.make
			if Eiffel_project.freezing_occurred then
				output_text.add_string ("System had to be frozen to include new externals and/or new agents.")
				output_text.add_new_line
			end
			output_text.add_string ("Eiffel system recompiled")
			output_text.add_new_line
	
			if start_c_compilation and then Eiffel_project.freezing_occurred then
					output_text.add_string ("Background C compilation launched.")
					output_text.add_new_line
					Eiffel_project.call_finish_freezing (True)
			end

				-- Display message.
			output_manager.process_text (output_text)
		end

	perform_compilation is
			-- The real compilation. (This is melting.)
		do
			license_display
			Eiffel_project.melt
		end

feature {NONE} -- Attributes

	not_saved: BOOLEAN is
			-- Has the text of some tool been edited and not saved?
		do
			Result := window_manager.has_modified_windows
		end

	finalization_error: BOOLEAN is
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls
		do
		end

	start_c_compilation: BOOLEAN
			-- Do we have to start the C compilation after C Code generation?

	run_after_melt: BOOLEAN
			-- Should we execute the system after sucessful melt?

	run_after_melt2: BOOLEAN
			-- Should we execute the system after sucessful melt?
			-- This boolean value is only reliable at the beginning
			-- of the execution of this command. After a warning or
			-- confirmation panel has been popped up, this value
			-- can be cleared by the caller. To prevent that, we
			-- keep track of that value in `run_after_melt' at the 
			-- beginning of the execution, so that we can still 
			-- rely on it after a confirmation when we resume 
			-- (i.e. re-execute) the command

	retried: BOOLEAN
			-- Is this already tried?

	c_code_directory: STRING is
			-- Directory where the C code is stored.
		do
			Result := Workbench_generation_path
		end

feature -- Execution

	execute is
			-- Recompile the project, start C compilation if necessarry.
		do
			if is_sensitive then
				execute_with_c_compilation_flag (True)
			end
		end

	execute_without_c_compilation is
			-- Recompile the project, but do not start C compilation.
		do
			execute_with_c_compilation_flag (False)
		end

feature {NONE} -- Execution

	execute_with_c_compilation_flag (c_compilation_enabled: BOOLEAN) is
			-- Recompile the project and start C compilation if `c_compilation_enabled'
			-- is True.
		local
			wd: EV_WARNING_DIALOG
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			start_c_compilation := c_compilation_enabled
			if c_compilation_enabled then
					-- Should we execute the system after sucessful melt?
					-- (See header comment of `run_after_melt2'.)
				run_after_melt := run_after_melt2
			else
				run_after_melt := false
			end
			if Eiffel_project.is_read_only then
				create wd.make_with_text (Warning_messages.w_Cannot_compile)
				wd.show_modal_to_window (window_manager.last_focused_window.window)
			elseif Eiffel_project.initialized then
				if not_saved then
					create cd.make_initialized (
						3, "confirm_save_before_compile",
						Warning_messages.w_Files_not_saved_before_compiling,
						Interface_names.l_Discard_save_before_compile_dialog
					)
					cd.set_ok_action (~save_and_compile)
					cd.set_no_action (~compile_no_save)
					cd.show_modal_to_window (window_manager.last_focused_window.window)
				else
					compile_no_save
				end
			end
		end

	save_and_compile is
			-- Save all files, then launch compilation
		do
			window_manager.save_all_before_compiling
			compile_no_save
		end

	compile_no_save is
			-- Launch compilation.
		do
			confirm_and_compile
		end

	confirm_and_compile is
			-- Ask for confirmations and options, then compile.
			--| Can be redefined in descendants!
		do
			confirm_execution_halt
		end

	confirm_execution_halt is
			-- If the application is running, prompt
			-- user so and ask for a confirmation.
			-- If confirmation successful then compile.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if
				not Application.is_running
			then
				compile_and_run
			else
				create cd.make_initialized (2, "stop_execution_when_compiling", "Recompiling project will end current run.", Interface_names.L_do_not_show_again)
				cd.set_ok_action (~compile_and_run)
				cd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	compile_and_run is
			-- Compile, then run application, according
			-- to run ability and `run_after_melt' flag.
		do
			compile
			if 
				run_after_melt and then
				Eiffel_ace.file_name /= Void and then
				Eiffel_project.successful and 
				not Eiffel_project.freezing_occurred
			then
					-- The system has been successfully melted.
					-- The system can be executed as required.
				Run_project_cmd.execute
			end
		end

feature {NONE} -- License checking

	license_display is
			-- Display license reminder.
		do
			if license.demo_mode then
				number_of_compilations := number_of_compilations + 1
				if number_of_compilations \\ license_frequency = 0 then
					license.get_license
				end
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Melt_new
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_compile
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Melt
		end

	description: STRING is
			-- Description for the command.
		do
			Result := Interface_names.f_Melt
		end

	name: STRING is 
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "Melt_project"
		end

	stop_execution: ANY is
			-- Argument used when files needs to be saved before compiling.
		once
			create Result
		end

	license_frequency: INTEGER is
			-- Frequency of license appearance in demo mode.
		once
			Result := 5
		end

	number_of_compilations: INTEGER
			-- Number of compilations done in a certain mode so far.

end -- class EB_MELT_PROJECT_COMMAND
