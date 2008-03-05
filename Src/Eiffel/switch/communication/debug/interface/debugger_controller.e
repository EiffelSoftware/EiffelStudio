indexing
	description: "Objects that control the debugger session"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_CONTROLLER

inherit

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

	SAFE_PATH_BUILDER
		export
			{NONE} all
		end

create {DEBUGGER_MANAGER}
	make

feature {NONE} -- Initialization

	make (a_manager: DEBUGGER_MANAGER) is
			-- Initialize `Current'.
		do
			manager := a_manager
		end

feature -- Debug Operation

	debug_application (param: DEBUGGER_EXECUTION_PARAMETERS; a_execution_mode: INTEGER) is
			-- Launch the program from the project target.
			-- see EXEC_MODES for `a_execution_mode' values.
		local
			launch_program: BOOLEAN
			makefile_sh_name: FILE_NAME
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			l_il_env: IL_ENVIRONMENT
			l_app_string: STRING
			is_dotnet_system: BOOLEAN
			prefstr: STRING
			dotnet_debugger: STRING
		do
			launch_program := False
			if  (not Eiffel_project.system_defined) or else (Eiffel_System.name = Void) then
				warning (Warning_messages.w_No_system)
			elseif
				Eiffel_project.initialized and then
				Eiffel_project.system_defined and then
				Eiffel_system.system.il_generation and then
				Eiffel_system.system.msil_generation_type.is_equal ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			elseif (not manager.application_is_executing) then
					--| Application is not running |--
				if
					Eiffel_project.initialized and then
					not Eiffel_project.Workbench.is_compiling
				then
						-- Application is not running. Start it.
					debug("DEBUGGER")
						io.error.put_string (generator)
						io.error.put_string ("(DEBUG_RUN): Start execution%N")
					end
					create makefile_sh_name.make_from_string (project_location.workbench_path)
					makefile_sh_name.set_file_name (Makefile_SH)

					create uf.make (Eiffel_system.application_name (True))
					create make_f.make (makefile_sh_name)

					is_dotnet_system := Eiffel_system.system.il_generation
					if uf.exists then
						if is_dotnet_system then
								--| String indicating the .NET debugger to launch if specified in the
								--| Preferences Tool.
							check preferences.debugger_data /= Void end
							dotnet_debugger := preferences.debugger_data.dotnet_debugger.item (1)

							create l_il_env.make (Eiffel_system.System.clr_runtime_version)
							if dotnet_debugger /= Void then
								l_app_string := safe_path (l_il_env.Dotnet_debugger_path (dotnet_debugger))
							end
							if l_app_string /= Void then
									--| This means we are using either dbgclr or cordbg
								if not manager.execution_ignoring_breakpoints then
										--| With BP
									if l_il_env.use_cordbg (dotnet_debugger) then
											-- Launch cordbg.exe.
										(create {COMMAND_EXECUTOR}).execute_with_args
											(l_app_string,
												safe_path (eiffel_system.application_name (True)) + " " + param.arguments)
										launch_program := True
									elseif l_il_env.use_dbgclr (dotnet_debugger) then
											-- Launch DbgCLR.exe.
										(create {COMMAND_EXECUTOR}).execute_with_args
											(l_app_string,
												safe_path (eiffel_system.application_name (True)))
										launch_program := True
									end
								else
										--| Without BP, we just launch the execution as it is
									(create {COMMAND_EXECUTOR}).execute_with_args (eiffel_system.application_name (True),
										param.arguments)
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
									-- The Makefile file is more recent than the application
								if_confirmed_do (Warning_messages.w_Makefile_more_recent (makefile_sh_name), agent c_compile)
							else
								launch_program := True
								if
									manager.breakpoints_manager.has_enabled_breakpoint (True)
									and manager.execution_ignoring_breakpoints
								then
										--| FIXME:2008-01-11 (jfiat): do we also ignore hidden breakpoints ?
										--| for now, yes
									if preferences.dialog_data /= Void then
										prefstr := preferences.dialog_data.confirm_ignore_all_breakpoints_string
									else
										prefstr := Void
									end
									discardable_if_confirmed_do (Warning_messages.w_Ignoring_all_stop_points,
														agent debug_workbench_application (param, a_execution_mode, True),
														2, prefstr
													)
								else
									debug_workbench_application (param, a_execution_mode, False)
								end
							end
						end
					elseif make_f.exists then
							-- There is no application.
						warning (Warning_messages.w_No_system_generated (uf.name))
					elseif Eiffel_project.Lace.compile_all_classes then
						warning (Warning_messages.w_None_system)
					else
						warning (Warning_messages.w_Must_compile_first)
					end
				end
			else
					--| Should not occurs
				check application_should_not_be_running: False end
			end
		end

	resume_workbench_application is
			-- Continue the execution of the program (stepping ...)
		require
			debugger_running_and_stopped: manager.safe_application_is_stopped
			execution_replay_mode_not_activated: not manager.application_status.replay_activated
		local
			status: APPLICATION_STATUS
			app_exec: APPLICATION_EXECUTION
		do
			app_exec := manager.application

			status := app_exec.status
			if status /= Void and then status.is_stopped then
				-- Application is stopped. Continue execution.
				debug("DEBUGGER")
					io.error.put_string (generator + ": Continue execution%N")
				end
				app_exec.on_application_before_resuming

					--| Continue the execution |--
				app_exec.continue

				if app_exec.is_running and then not app_exec.is_stopped then
					app_exec.on_application_resumed
				else
					debug ("debugger_trace")
						print ("Application is stopped, but it should not")
					end
				end
			end
		end

feature {DEBUGGER_MANAGER} -- Debugging operation

	debug_operate (a_exec_mode: INTEGER) is
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			manager.application.set_execution_mode (a_exec_mode)
			resume_workbench_application
		end

	debug_step_next is
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Step_next)
		end

	debug_step_into is
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Step_into)
		end

	debug_step_out is
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Step_out)
		end

	debug_run is
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Run)
		end

	debug_kill is
		require
			application_is_executing: manager.application_is_executing
		do
			manager.application.kill
		end

	debug_interrupt is
		require
			application_is_executing: manager.application_is_executing
		do
			manager.application.interrupt
		end

feature -- Start Operation

	start_workbench_application (param: DEBUGGER_EXECUTION_PARAMETERS) is
		local
			appl_name: STRING
			cmd_exec: COMMAND_EXECUTOR
			f: RAW_FILE
			f_name: FILE_NAME
			make_f: INDENT_FILE
			system_name: STRING
			env8: like environment_variables_to_string_8
			launch_it: BOOLEAN
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				system_name := Eiffel_system.name.twin
			end
			if system_name = Void then
				warning (Warning_messages.w_Must_compile_first)
			elseif
				Eiffel_system.system /= Void and then
				Eiffel_system.system.il_generation and then
				Eiffel_system.system.msil_generation_type.is_equal ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			else
				check
					System_defined: Eiffel_system.Workbench.system_defined
				end
				appl_name := Eiffel_system.application_name (True)
				create f.make (appl_name)
				if not f.exists then
					warning (Warning_messages.w_Unexisting_system)
				else
					if Eiffel_system.System.il_generation then
							-- No need to check the `exe' as it is guaranteed to have been
							-- generated by the Eiffel compiler.
						launch_it := True
					else
						create f_name.make_from_string (project_location.workbench_path)
						f_name.set_file_name (Makefile_SH)
						create make_f.make (f_name)
						if make_f.exists and then make_f.date > f.date then
							warning (Warning_messages.w_MakefileSH_more_recent)
						else
							launch_it := True
						end
					end
					if launch_it then
						create cmd_exec
						env8 := environment_variables_to_string_8 (environment_variables_updated_with (param.environment_variables, False))
						check
							env8_not_void: env8 /= Void
						end
						env8.force (project_location.workbench_path, "MELT_PATH")
						cmd_exec.execute_with_args_and_working_directory_and_environment (
									safe_path (appl_name),
									param.arguments,
									param.working_directory,
									env8
								)
					end
				end
			end
		end

	start_finalized_application (param: DEBUGGER_EXECUTION_PARAMETERS) is
		local
			appl_name: STRING
			cmd_exec: COMMAND_EXECUTOR
			f: RAW_FILE
			f_name: FILE_NAME
			make_f: INDENT_FILE
			system_name: STRING
			env8: like environment_variables_to_string_8
			launch_it: BOOLEAN
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				system_name := Eiffel_system.name.twin
			end
			if system_name = Void then
				warning (Warning_messages.w_Must_finalize_first)
			elseif
				Eiffel_system.system /= Void and then
				Eiffel_system.system.il_generation and then
				Eiffel_system.system.msil_generation_type.is_equal ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			else
				check
					System_defined: Eiffel_system.Workbench.system_defined
				end
				appl_name := Eiffel_system.application_name (False)
				create f.make (appl_name)
				if not f.exists then
					warning (Warning_messages.w_Unexisting_system)
				else
					if Eiffel_system.System.il_generation then
							-- No need to check the `exe' as it is guaranteed to have been
							-- generated by the Eiffel compiler.
						launch_it := True
					else
						create f_name.make_from_string (project_location.final_path)
						f_name.set_file_name (Makefile_SH)
						create make_f.make (f_name)
						if make_f.exists and then make_f.date > f.date then
							warning (Warning_messages.w_MakefileSH_more_recent)
						else
							launch_it := True
						end
					end
					if launch_it then
						create cmd_exec
						env8 := environment_variables_to_string_8 (environment_variables_updated_with (param.environment_variables, True))
						cmd_exec.execute_with_args_and_working_directory_and_environment (
									safe_path (appl_name),
									param.arguments,
									param.working_directory,
									env8
								)

					end

				end
			end
		end

feature {NONE} -- Callbacks

	before_starting (param: DEBUGGER_EXECUTION_PARAMETERS) is
		do
			manager.display_debugger_info (param)
		end

	after_starting is
		do
		end

	warning (msg: STRING_GENERAL) is
		do
			manager.debugger_warning_message (msg)
		end

	if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE]) is
		do
		end

	discardable_if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE];
			a_button_count: INTEGER; a_pref_string: STRING) is
		do
		end

	activate_debugger_environment (b: BOOLEAN) is
		do
		end

feature {NONE} -- debugging

	debug_workbench_application (param: DEBUGGER_EXECUTION_PARAMETERS; a_execution_mode: INTEGER; ign_bp: BOOLEAN) is
		require
			param.working_directory /= Void
		local
			working_dir: STRING
			app_exec: APPLICATION_EXECUTION
		do
			before_starting (param)

				--| Getting well formatted workind directory path
			working_dir := param.working_directory

			if not directory_exists (working_dir) then
				warning (Warning_messages.w_Invalid_working_directory (working_dir))
				activate_debugger_environment (False)
			else
					-- Raise debugger before launching.
				if not manager.application_initialized then
					manager.create_application
				end

				activate_debugger_environment (True)
				app_exec := manager.application
				app_exec.ignore_breakpoints (manager.execution_ignoring_breakpoints)
				app_exec.set_execution_mode (a_execution_mode)
				manager.on_application_before_launching
				app_exec.run (param)
				if manager.application_is_executing then
					manager.init_application
					if app_exec.ignoring_breakpoints then
						manager.debugger_status_message (debugger_names.m_system_is_running_ignoring_breakpoints)
					else
						manager.debugger_message (debugger_names.m_system_is_running)
					end
					manager.on_application_launched
				else
						-- Something went wrong
					warning (app_exec.can_not_launch_system_message)
					app_exec.on_application_quit

					activate_debugger_environment (False)
				end
			end
		end

	c_compile is
			-- Freeze system.
		do
			if Eiffel_project.initialized then
				Eiffel_project.call_finish_freezing (True)
			end
		end

feature -- {DEBUGGER_MANAGER, SHARED_DEBUGGER_MANAGER} -- Implementation

	manager: DEBUGGER_MANAGER

feature {NONE} -- Implementation

	directory_exists (a_dirname: STRING): BOOLEAN is
			-- Is directory named `a_dirname' exists ?
		local
			d: DIRECTORY
		do
			create d.make (a_dirname)
			Result := d.exists
		end

feature -- Environment related

	environment_variables_updated_with (env: HASH_TABLE [STRING_32, STRING_32]; return_void_if_unchanged: BOOLEAN): HASH_TABLE [STRING_32, STRING_32] is
			-- String representation of the Environment variables
		local
			k,v: STRING_32
		do
			if (env = Void or else env.is_empty) and return_void_if_unchanged then
				--| Result := Void
			else
				Result := manager.environment_variables_table
			end
			if
				Result /= Void
				and (env /= Void and then not env.is_empty)
			then
				from
					env.start
				until
					env.after
				loop
					k := env.key_for_iteration
					v := env.item_for_iteration
					if k /= Void and then v /= Void then
						Result.force (v, k)
					end
					env.forth
				end
			end
		ensure
			Result_not_void_unless_unchanged: Result = Void implies (return_void_if_unchanged and (env = Void or else env.is_empty))
		end

	environment_variables_to_string_8 (env32: HASH_TABLE [STRING_32, STRING_32]): HASH_TABLE [STRING, STRING] is
			-- String representation of the Environment variables
		local
			k,v: STRING_32
		do
			if env32 /= Void then
				create Result.make (env32.count)
				from
					env32.start
				until
					env32.after
				loop
					k := env32.key_for_iteration
					v := env32.item_for_iteration
					if k /= Void and v /= Void then --| let's be careful ...
						Result.force (env32.item_for_iteration.as_string_8, env32.key_for_iteration.as_string_8)
					end
					env32.forth
				end
			end
		ensure
			Result = Void implies env32 = Void
		end

invariant

	manager_not_void: manager /= Void

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
