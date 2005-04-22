indexing
	description	: "Command to run the system while debugging."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEBUG_RUN_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item,
			tooltext,
			is_tooltext_important
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		end

	EXEC_MODES
		export
			{NONE} all
		end

	SHARED_STATUS
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end
	
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Initialize the command, create a couple of requests and windows.
			-- Add some actions as well.
		do
			is_sensitive := True
			create run_request.make (Rqst_application)
			create cont_request.make (Rqst_cont)
		end

feature -- Callbacks

	execute_warner_help is
		do
		end

	execute_warner_ok (argument: ANY) is
		do
			if not launch_program then		
				Eiffel_project.call_finish_freezing (True)
			else
				launch_program := False
				start_program
			end
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text, use_gray_icons)
			Result.select_actions.put_front (agent execute_from (Result))
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.select_actions.put_front (agent execute_from (Result))
		end

feature -- Execution

	execute is
			-- Launch program in debugger with mode `User_stop_points' (i.e "Run").
		do
			execute_with_mode (User_stop_points)
		end
		
	execute_with_mode (execution_mode: INTEGER) is
			-- Launch program in debugger with mode `execution_mode'.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			Application.set_execution_mode (execution_mode)
			if
				Eiffel_project.initialized and then
				not Eiffel_project.Workbench.is_compiling
			then
				if not Eiffel_project.Workbench.successful then
						-- The last compilation was not successful.
						-- It is VERY dangerous to launch the debugger in these conditions.
						-- However, forbidding it completely may be too frustating.
					create cd.make_with_text (Warning_messages.w_Debug_not_compiled)
					cd.button ("OK").select_actions.extend (agent launch_application)
					cd.show_modal_to_window (Window_manager.last_focused_window.window)
				elseif not Debugger_manager.can_debug then
						-- A class was removed since the last compilation.
						-- It is VERY dangerous to launch the debugger in these conditions.
						-- However, forbidding it completely may be too frustating.
					create cd.make_with_text (Warning_messages.w_Removed_class_debug)
					cd.button ("OK").select_actions.extend (agent launch_application)
					cd.show_modal_to_window (Window_manager.last_focused_window.window)					
				else
					launch_application
				end
			end
		end

	execute_from (widget: EV_CONTAINABLE) is
			-- Set widget's top-level window as the debugging window.
		local
			trigger: EV_CONTAINABLE
			cont: EV_ANY
			window: EV_WINDOW
			wd: EV_WARNING_DIALOG
		do
			from
				trigger := widget
				cont := trigger.parent
			until
				cont = Void
			loop
				trigger ?= cont
				if trigger /= Void then
					cont := trigger.parent
				else
					cont := Void
				end
			end
			window ?= trigger
			if window /= Void then
				debugger_manager.set_debugging_window (
					window_manager.development_window_from_window (window)
				)
			else
				create wd.make_with_text ("Could not initialize debugging tools")
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	melt_and_execute is
			-- Melt system, then launch it.
		local
			melt_command: EB_MELT_PROJECT_COMMAND
		do
			if Eiffel_project.initialized then
--				melt_command ?= project_window.quick_melt_cmd
				melt_command.set_run_after_melt (True)
--				need_to_wait := True
--				melt_command.execute (Void, Void)
--				need_to_wait := False
				Application.set_execution_mode (User_stop_points)
				launch_application
--				melt_command.set_run_after_melt (false)
			end
		end

	c_compile is
			-- Freeze system.
		do
			if Eiffel_project.initialized then
				Eiffel_project.call_finish_freezing (True)
--				Application.set_execution_mode (User_stop_points)
--				launch_application
			end
		end

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone: i.e. run to cursor.
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			old_bp_status: INTEGER
			wd: EV_WARNING_DIALOG
			cond: EB_EXPRESSION
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index
						-- Remember the status of the breakpoint
					old_bp_status := Application.breakpoint_status (f, index)
					if old_bp_status /= 0 then
						cond := Application.condition (f, index)
					end
						-- Enable the breakpoint
					Application.enable_breakpoint (f, index)
					Application.remove_condition (f, index)
						-- Run the program
					execute
						-- Put back the status of the modified breakpoint This will prevent
						-- the display of the temporary breakpoint (if not already present
						-- at `index' in `f'.)
					Application.set_breakpoint_status (f, index, old_bp_status)
					if old_bp_status /= 0 and cond /= Void then
							-- Restore condition after we stopped, otherwise if the evaluation
							-- does not evaluate to True then it will not stopped.
						debugger_manager.set_on_stopped_action (
							agent application.set_condition (f, index, cond))
					end
				end
			else
				create wd.make_with_text (Warning_messages.w_Cannot_debug)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	launch_application is
			-- Launch the program from the project target.
		local
			makefile_sh_name: FILE_NAME
			status: APPLICATION_STATUS
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			kept_objects: LINKED_SET [STRING]
			wd: EV_WARNING_DIALOG
			cd: EV_CONFIRMATION_DIALOG
			ignore_all_breakpoints_confirmation_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			l_il_env: IL_ENVIRONMENT
			l_app_string: STRING
			is_dotnet_system: BOOLEAN
		do
			launch_program := False
			if  (not Eiffel_project.system_defined) or else (Eiffel_System.name = Void) then
				create wd.make_with_text (Warning_messages.w_No_system)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			elseif 
				Eiffel_project.initialized and then
				Eiffel_project.system_defined and then
				Eiffel_system.system.il_generation and then 
				Eiffel_system.system.msil_generation_type.is_equal ("dll")
			then
				create wd.make_with_text ("No debugging for DLL system")
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			elseif (not Application.is_running) then
				if
					Eiffel_project.initialized and then
					not Eiffel_project.Workbench.is_compiling
				then
						-- Application is not running. Start it.
	debug("DEBUGGER")
		io.error.put_string (generator)
		io.error.put_string ("(DEBUG_RUN): Start execution%N")
	end
					create makefile_sh_name.make_from_string (Workbench_generation_path)
					makefile_sh_name.set_file_name (Makefile_SH)
					
					create uf.make (Eiffel_system.application_name (True))
					create make_f.make (makefile_sh_name)
	
					is_dotnet_system := Eiffel_system.system.il_generation
					if uf.exists then
						if is_dotnet_system then
							create l_il_env.make (Eiffel_system.System.clr_runtime_version)
							if dotnet_debugger /= Void then
								l_app_string := l_il_env.Dotnet_debugger_path (dotnet_debugger)
							end
							if l_app_string /= Void then
									--| This means we are using either dbgclr or cordbg
								if Application.execution_mode = {EXEC_MODES}.User_stop_points then
										--| With BP
									if l_il_env.use_cordbg (dotnet_debugger) then
											-- Launch cordbg.exe.
										(create {COMMAND_EXECUTOR}).execute_with_args
											(l_app_string, 
												"%"" + eiffel_system.application_name (True) + "%" " + current_cmd_line_argument)
										launch_program := True
									elseif l_il_env.use_dbgclr (dotnet_debugger) then
											-- Launch DbgCLR.exe.
										(create {COMMAND_EXECUTOR}).execute_with_args 
											(l_app_string,
												"%"" + eiffel_system.application_name (True) + "%"")
										launch_program := True
									end
								else
										--| Without BP, we just launch the execution as it is
									(create {COMMAND_EXECUTOR}).execute_with_args (eiffel_system.application_name (True),
										current_cmd_line_argument)
									launch_program := True
								end
							end
								--| if launch_program is False this mean we haven't launch the application yet
								--| for dotnet, this means we are using the EiffelStudio Debugger facilities.
						end
						if not launch_program then
							if 
								not is_dotnet_system and then
								make_f.exists and then make_f.date > uf.date 
							then
									-- The Makefile file is more recent than the 
									-- application
								create cd.make_with_text_and_actions (Warning_messages.w_Makefile_more_recent (makefile_sh_name),
									<<agent c_compile>>)
								cd.show_modal_to_window (window_manager.last_focused_development_window.window)
							else
								Output_manager.clear

								launch_program := True
								if Application.has_breakpoints and then Application.is_ignoring_stop_points then
									create ignore_all_breakpoints_confirmation_dialog.make_initialized (
										2, preferences.dialog_data.confirm_ignore_all_breakpoints_string,
										Warning_messages.w_Ignoring_all_stop_points, Interface_names.l_Do_not_show_again,
										preferences.preferences
									)
									ignore_all_breakpoints_confirmation_dialog.set_ok_action (agent start_program)
									ignore_all_breakpoints_confirmation_dialog.show_modal_to_window (window_manager.last_focused_development_window.window)
								else
									start_program
								end
							end
						end
					elseif make_f.exists then
							-- There is no application.
						create wd.make_with_text (Warning_messages.w_No_system_generated)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					elseif Eiffel_project.Lace.compile_all_classes then
						create wd.make_with_text (Warning_messages.w_None_system)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					else
						create wd.make_with_text (Warning_messages.w_Must_compile_first)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					end
				end
			else
				status := Application.status
				if status /= Void and then status.is_stopped then
					-- Application is stopped. Continue execution.
debug("DEBUGGER")
	io.error.put_string (generator)
	io.error.put_string (": Continue execution%N")
end
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
--| FIXME ARNAUD
--					kept_objects := window_manager.object_tool_mgr.objects_kept
--					kept_objects.merge (debug_target.kept_objects)
					if debugger_manager /= Void then
						kept_objects := debugger_manager.kept_objects
					else
						create kept_objects.make
					end
					Application.continue (kept_objects)
--					window_manager.object_tool_mgr.hang_on
--					if status.e_feature /= Void then
--						window_manager.feature_tool_mgr.show_stoppoint 
--							(status.e_feature, status.break_index)
--						target.show_stoppoint
--							(status.e_feature, status.break_index)
--					end
--					target.refresh_current_stoppoint
--					Window_manager.feature_tool_mgr.synchronize_with_callstack
--					debug_target.save_current_cursor_position
--					debug_target.display_string ("System is running%N")
					if debugger_manager /= Void then
						debugger_manager.on_application_resumed
					end
--| END FIXME
				end
			end
		end
 
	start_program is
			-- Launch the program to be debugged.
		local
			output_text: STRUCTURED_TEXT
			wd: EV_WARNING_DIALOG
			working_dir: STRING
			l_cmd_line_arg: STRING
		do
			create output_text.make
			if not Application.is_running then
					-- First time we launch the program, we clear the output tool.
				output_manager.clear
			end
			working_dir := application_working_directory
			l_cmd_line_arg := current_cmd_line_argument
			
			output_text.add_string ("Launching system :")
			output_text.add_new_line
			output_text.add_comment ("  - directory = ")
			output_text.add_quoted_text (working_dir)
			output_text.add_new_line
			output_text.add_comment_text ("  - arguments = ")
			if l_cmd_line_arg.is_empty then
				output_text.add_string ("<Empty>")
			else
				output_text.add_quoted_text (l_cmd_line_arg)			
			end
			output_text.add_new_line
			
			if not (create {DIRECTORY} .make (working_dir)).exists then
				create wd.make_with_text (Warning_messages.w_Invalid_working_directory (working_dir))
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				output_text.add_string (Warning_messages.w_Invalid_working_directory (working_dir))
			else
				debugger_manager.raise
				Application.set_critical_stack_depth (preferences.debugger_data.critical_stack_depth)
				Application.run (l_cmd_line_arg, working_dir)
				if Application.is_running then
					output_text.add_string ("System is running")
					output_text.add_new_line
					debugger_manager.on_application_launched
				else
						-- Something went wrong
					if Eiffel_system.system.il_generation then						
						create wd.make_with_text (Application.eiffel_error_dotnet_initialization_message)
					else
						create wd.make_with_text (Application.eiffel_timeout_message)
					end
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					output_text.add_string ("Could not launch system")
					Debugger_manager.unraise
				end
			end
			output_manager.process_text (output_text)
		end

feature {NONE} -- Implementation / Attributes

	tooltext: STRING is
			-- Toolbar button text for the command
		do
			Result := Interface_names.b_Launch
		end

	tooltip: STRING is
			-- Tooltip for the command.
		do
			Result := Interface_names.f_Debug_run
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	description: STRING is
			-- Description for the command.
		do
			Result := Interface_names.f_Debug_run
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_run
		end

	name: STRING is "Run"
			-- Name of the command. Used to store the command in the
			-- preferences.

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_run
		end

	run_request: RUN_REQUEST
			-- Request for the run.

	cont_request: EWB_REQUEST
			-- Request for continuation.

	launch_program: BOOLEAN
			-- Are we currently trying to launch the program.
	
	need_to_wait: BOOLEAN
			-- Do we need to wait until the end of the compilation?

	dotnet_debugger: STRING is
			-- String indicating the .NET debugger to launch if specified in the
			-- Preferences Tool.
		do
			Result := preferences.debugger_data.dotnet_debugger.item (1)
		end

end -- class EB_DEBUG_RUN_COMMAND
