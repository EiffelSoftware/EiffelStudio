indexing
	description	: "Command to run the system while debugging."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Access

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
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
			app_exec: APPLICATION_EXECUTION
		do
				--| At this point we define the 'type' on debug operation
				--| either step next, step into, step out, continue ...
				--| this will be used in APPLICATION_EXECUTION_IMP.continue_ignoring_kept_objects
			app_exec := eb_debugger_manager.application
			app_exec.set_execution_mode (execution_mode)

				--| Now let's check the application status
			if
				Eiffel_project.initialized and then
				not Eiffel_project.Workbench.is_compiling
			then
				if not app_exec.is_running then
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
				elseif app_exec.is_stopped then
					resume_application
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
				Eb_debugger_manager.set_debugging_window (
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
				eb_debugger_manager.application.set_execution_mode (User_stop_points)
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
			app_exec: APPLICATION_EXECUTION
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index
						-- Remember the status of the breakpoint
					app_exec := eb_debugger_manager.application
					old_bp_status := app_exec.breakpoint_status (f, index)
					if old_bp_status /= 0 then
						cond := app_exec.condition (f, index)
					end
						-- Enable the breakpoint
					app_exec.enable_breakpoint (f, index)
					app_exec.remove_condition (f, index)
						-- Run the program
					execute
						-- Put back the status of the modified breakpoint This will prevent
						-- the display of the temporary breakpoint (if not already present
						-- at `index' in `f'.)
					app_exec.set_breakpoint_status (f, index, old_bp_status)
					if old_bp_status /= 0 and cond /= Void then
							-- Restore condition after we stopped, otherwise if the evaluation
							-- does not evaluate to True then it will not stopped.
						Eb_debugger_manager.set_on_stopped_action (
							agent app_exec.set_condition (f, index, cond))
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
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
			cd: EV_CONFIRMATION_DIALOG
			ignore_all_breakpoints_confirmation_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			l_il_env: IL_ENVIRONMENT
			l_app_string: STRING
			is_dotnet_system: BOOLEAN
			app_exec: APPLICATION_EXECUTION
		do
			launch_program := False
			app_exec := eb_debugger_manager.application
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
			elseif (not app_exec.is_running) then
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
								if app_exec.execution_mode = {EXEC_MODES}.User_stop_points then
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
								if app_exec.has_breakpoints and then app_exec.is_ignoring_stop_points then
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
					--| Should not occurs
				check  application_should_not_be_running: False end
			end
		end

	resume_application is
			-- Continue the execution of the program (stepping ...)
		local
			status: APPLICATION_STATUS
			app_exec: APPLICATION_EXECUTION
		do
			check debugger_running_and_stopped: eb_debugger_manager.application_is_executing and then eb_debugger_manager.application_is_stopped end
			app_exec := eb_debugger_manager.application

			status := app_exec.status
			if status /= Void and then status.is_stopped then
				-- Application is stopped. Continue execution.
				debug("DEBUGGER")
					io.error.put_string (generator + ": Continue execution%N")
				end
				if debugger_manager /= Void
					and (
						debugger_manager.application_is_executing
						and then debugger_manager.application_is_stopped
					)
				then
					app_exec.on_application_before_resuming
				end

					--| Continue the execution |--
				app_exec.continue

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
				if debugger_manager /= Void
					and (
						debugger_manager.application_is_executing
						and then not debugger_manager.application_is_stopped
					)
				then
					app_exec.on_application_resumed
				else
					debug ("debugger_trace")
						print ("Application is stopped, but it should not")
					end
				end
--| END FIXME
			end
		end

	start_program is
			-- Launch the program to be debugged.
		local
			wd: EV_WARNING_DIALOG
			working_dir: STRING
			l_cmd_line_arg: STRING
			app_exec: APPLICATION_EXECUTION
		do
			if not eb_debugger_manager.application_is_executing then
					-- First time we launch the program, we clear the output tool.
				output_manager.clear
			end
			working_dir := application_working_directory
			l_cmd_line_arg := current_cmd_line_argument
			output_manager.add_string ("Launching system :")
			output_manager.add_new_line
			output_manager.add_comment ("  - directory = ")
			output_manager.add_quoted_text (working_dir)
			output_manager.add_new_line
			output_manager.add_comment_text ("  - arguments = ")
			if l_cmd_line_arg.is_empty then
				output_manager.add_string ("<Empty>")
			else
				output_manager.add_quoted_text (l_cmd_line_arg)
			end
			output_manager.add_new_line

			if not (create {DIRECTORY} .make (working_dir)).exists then
				create wd.make_with_text (Warning_messages.w_Invalid_working_directory (working_dir))
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				output_manager.add_string (Warning_messages.w_Invalid_working_directory (working_dir))
			else
				Eb_debugger_manager.raise
				app_exec := eb_debugger_manager.application
				app_exec.run (l_cmd_line_arg, working_dir)
				if app_exec.is_running then
					output_manager.add_string ("System is running")
					if app_exec.execution_mode = No_stop_points then
						output_manager.add_string (" (ignoring breakpoints)")
					end
					output_manager.add_new_line
					app_exec.on_application_launched
				else
						-- Something went wrong
					if Eiffel_system.system.il_generation then
						create wd.make_with_text (app_exec.eiffel_error_dotnet_initialization_message)
					else
						create wd.make_with_text (app_exec.eiffel_timeout_message)
					end
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					output_manager.add_string ("Could not launch system")
					Eb_debugger_manager.unraise
				end
			end
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

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_DEBUG_RUN_COMMAND
