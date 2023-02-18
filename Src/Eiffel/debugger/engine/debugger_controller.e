note
	description: "Objects that control the debugger session"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_CONTROLLER

inherit
	ANY

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

	SHARED_BENCH_NAMES
		rename
			Warnings as Warning_messages
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

	make (a_manager: like manager)
			-- Initialize `Current'.
		do
			manager := a_manager
		end

feature -- Debug Operation

	debug_application (param: DEBUGGER_EXECUTION_RESOLVED_PROFILE; a_execution_mode: INTEGER)
			-- Launch the program from the project target.
			-- see EXEC_MODES for `a_execution_mode' values.
		local
			launch_program: BOOLEAN
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			l_il_env: IL_ENVIRONMENT
			l_app_string: like safe_path
			is_dotnet_system: BOOLEAN
			prefstr: STRING
			dotnet_debugger: READABLE_STRING_32
		do
			launch_program := False
			if  (not Eiffel_project.system_defined) or else (Eiffel_System.name = Void) then
				warning (Warning_messages.w_No_system)
			elseif
				Eiffel_project.initialized and then
				Eiffel_project.system_defined and then
				Eiffel_system.system.il_generation and then
				Eiffel_system.system.msil_generation_type.same_string_general ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			elseif not manager.application_is_executing then
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

					create uf.make_with_path (eiffel_system.application_name (True))
					create make_f.make_with_path (project_location.workbench_path.extended (makefile_sh))

					is_dotnet_system := Eiffel_system.system.il_generation
					if uf.exists then
						if is_dotnet_system then
								--| String indicating the .NET debugger to launch if specified in the
								--| Preferences Tool.
							dotnet_debugger := manager.dotnet_debugger

							create l_il_env.make (Eiffel_system.System.clr_runtime_version)
							if dotnet_debugger /= Void and then attached l_il_env.dotnet_debugger_path (dotnet_debugger) as l_app_path then
								l_app_string := safe_path (l_app_path.name)
							end
							if l_app_string /= Void then
									--| This means we are using either dbgclr or cordbg
								if not manager.execution_ignoring_breakpoints then
										--| With BP
									if l_il_env.use_cordbg (dotnet_debugger) then
											-- Launch cordbg.exe.
										(create {COMMAND_EXECUTOR}).execute_with_args
											(l_app_string,
												safe_path (eiffel_system.application_name (True).name) + " " + param.arguments)
										launch_program := True
									elseif l_il_env.use_dbgclr (dotnet_debugger) then
											-- Launch DbgCLR.exe.
										(create {COMMAND_EXECUTOR}).execute_with_args
											(l_app_string,
												safe_path (eiffel_system.application_name (True).name))
										launch_program := True
									end
								else
										--| Without BP, we just launch the execution as it is
									(create {COMMAND_EXECUTOR}).execute_with_args (eiffel_system.application_name (True).name,
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
								if_confirmed_do (Warning_messages.w_Makefile_more_recent (make_f.path.name), agent c_compile)
							else
								launch_program := True
								if
									manager.breakpoints_manager.has_enabled_breakpoint (True)
									and manager.execution_ignoring_breakpoints
								then
										--| FIXME:2008-01-11 (jfiat): do we also ignore hidden breakpoints ?
										--| for now, yes
									prefstr := manager.confirm_ignore_all_breakpoints_preference_string
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
						warning (Warning_messages.w_No_system_generated (uf.path.name))
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

	resume_workbench_application
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

feature -- Attach

	attach_application (a_port: INTEGER)
			-- Attach the program from the project target.
		local
			attach_it: BOOLEAN
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			is_dotnet_system: BOOLEAN
		do
			attach_it := False
			if  (not Eiffel_project.system_defined) or else (Eiffel_System.name = Void) then
				warning (Warning_messages.w_No_system)
			elseif
				Eiffel_project.initialized and then
				Eiffel_project.system_defined and then
				Eiffel_system.system.il_generation and then
				Eiffel_system.system.msil_generation_type.same_string_general ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			elseif not manager.application_is_executing then
					--| Application is not running |--
				if
					Eiffel_project.initialized and then
					not Eiffel_project.Workbench.is_compiling
				then
						-- Application is not running. Attach it.
					debug("DEBUGGER")
						io.error.put_string (generator)
						io.error.put_string ("(DEBUG_RUN): attach execution%N")
					end

					create uf.make_with_path (Eiffel_system.application_name (True))
					create make_f.make_with_path (project_location.workbench_path.extended (makefile_sh))

					is_dotnet_system := Eiffel_system.system.il_generation
					if uf.exists then
						if is_dotnet_system then
							-- not yet supported
						else
							if make_f.exists and then make_f.date > uf.date then
									-- The Makefile file is more recent than the application
								if_confirmed_do (Warning_messages.w_Makefile_more_recent (make_f.path.name), agent c_compile)
							else
								attach_it := True
								attach_workbench_application (a_port)
							end
						end
					elseif make_f.exists then
							-- There is no application.
						warning (Warning_messages.w_No_system_generated (uf.path.name))
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
feature {DEBUGGER_MANAGER} -- Debugging operation

	debug_operate (a_exec_mode: INTEGER)
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			manager.application.set_execution_mode (a_exec_mode)
			resume_workbench_application
		end

	debug_step_next
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Step_next)
		end

	debug_step_into
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Step_into)
		end

	debug_step_out
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Step_out)
		end

	debug_run
		require
			safe_application_is_stopped: manager.safe_application_is_stopped
		do
			debug_operate ({EXEC_MODES}.Run)
		end

	debug_kill
		require
			application_is_executing: manager.application_is_executing
		do
			manager.application.kill
		end

	debug_interrupt
		require
			application_is_executing: manager.application_is_executing
		do
			manager.application.interrupt
		end

feature -- Start Operation

	start_workbench_application (param: DEBUGGER_EXECUTION_RESOLVED_PROFILE)
		local
			appl_name: like {E_SYSTEM}.application_name
			cmd_exec: COMMAND_EXECUTOR
			f: RAW_FILE
			make_f: RAW_FILE
			system_name: STRING
			env8: like environment_variables_to_string_8
			env32: like environment_variables_updated_with
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
				Eiffel_system.system.msil_generation_type.same_string_general ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			else
				check
					System_defined: Eiffel_system.Workbench.system_defined
				end
				appl_name := Eiffel_system.application_name (True)
				create f.make_with_path (appl_name)
				if not f.exists then
					warning (Warning_messages.w_Unexisting_system)
				else
					if Eiffel_system.System.il_generation then
							-- No need to check the `exe' as it is guaranteed to have been
							-- generated by the Eiffel compiler.
						launch_it := True
					else
						create make_f.make_with_path (project_location.workbench_path.extended (Makefile_SH))
						if make_f.exists and then make_f.date > f.date then
							warning (Warning_messages.w_MakefileSH_more_recent)
						else
							launch_it := True
						end
					end
					if launch_it then
						env32 := environment_variables_updated_with (param.environment_variables, False)
						env32.force (project_location.workbench_path.name, {STRING_32} "MELT_PATH")
						env8 := environment_variables_to_string_8 (env32)
						check
							env8_not_void: env8 /= Void
						end
						create cmd_exec
						cmd_exec.execute_with_args_and_working_directory_and_environment (
									safe_path (appl_name.name),
									param.arguments,
									param.working_directory,
									env8
								)
					end
				end
			end
		end

	start_finalized_application (param: DEBUGGER_EXECUTION_RESOLVED_PROFILE)
		local
			appl_name: like {E_SYSTEM}.application_name
			cmd_exec: COMMAND_EXECUTOR
			f: RAW_FILE
			make_f: RAW_FILE
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
				Eiffel_system.system.msil_generation_type.same_string_general ("dll")
			then
				warning (debugger_names.m_no_debugging_for_dll_system)
			else
				check
					System_defined: Eiffel_system.Workbench.system_defined
				end
				appl_name := Eiffel_system.application_name (False)
				create f.make_with_path (appl_name)
				if not f.exists then
					warning (Warning_messages.w_Unexisting_system)
				else
					if Eiffel_system.System.il_generation then
							-- No need to check the `exe' as it is guaranteed to have been
							-- generated by the Eiffel compiler.
						launch_it := True
					else
						create make_f.make_with_path (project_location.final_path.extended (makefile_sh))
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
									safe_path (appl_name.name),
									param.arguments,
									param.working_directory,
									env8
								)
					end
				end
			end
		end

feature {NONE} -- Callbacks

	before_starting (param: detachable DEBUGGER_EXECUTION_RESOLVED_PROFILE)
		do
			manager.display_debugger_info (param)
		end

	after_starting
		do
		end

	warning (msg: STRING_GENERAL)
		do
			manager.debugger_warning_message (msg)
		end

	if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE)
		do
		end

	discardable_if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE;
			a_button_count: INTEGER; a_pref_string: STRING)
		do
		end

	activate_debugger_environment (b: BOOLEAN)
		do
		end

feature {NONE} -- debugging

	debug_workbench_application (param: DEBUGGER_EXECUTION_RESOLVED_PROFILE; a_execution_mode: INTEGER; ign_bp: BOOLEAN)
		local
			app_exec: APPLICATION_EXECUTION
			working_dir: PATH
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
				if a_execution_mode = {EXEC_MODES}.Step_next then
					app_exec.set_execution_mode ({EXEC_MODES}.Step_into)
				else
					app_exec.set_execution_mode (a_execution_mode)
				end
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
					app_exec.terminate_debugging

					activate_debugger_environment (False)
				end
			end
		end

	attach_workbench_application (a_port: INTEGER)
			-- Attach workbench application using socket connection on port `a_port'
		local
			app_exec: APPLICATION_EXECUTION
		do
			before_starting (Void)

				-- Raise debugger before launching.
			if not manager.application_initialized then
				manager.create_application
			end

			activate_debugger_environment (True)
			app_exec := manager.application
			app_exec.ignore_breakpoints (manager.execution_ignoring_breakpoints)
			app_exec.set_execution_mode ({EXEC_MODES}.Step_into)
			manager.on_application_before_launching
			app_exec.attach (a_port)
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
				warning (app_exec.can_not_attach_system_message (a_port))
				app_exec.terminate_debugging
				activate_debugger_environment (False)
			end
		end

	c_compile
			-- Freeze system.
		do
			if Eiffel_project.initialized then
				Eiffel_project.call_finish_freezing (True)
			end
		end

feature -- {DEBUGGER_MANAGER, SHARED_DEBUGGER_MANAGER} -- Implementation

	manager: DEBUGGER_MANAGER

feature {NONE} -- Implementation

	directory_exists (a_dirname: PATH): BOOLEAN
			-- Is directory named `a_dirname' exists ?
		do
			Result := (create {DIRECTORY}.make_with_path (a_dirname)).exists
		end

feature -- Environment related

	environment_variable_unset_prefix: STRING_32 = "&-"
			-- Prefix to mark an environment variable unset

	environment_variables_updated_with (env: detachable HASH_TABLE [STRING_32, STRING_32];
										return_void_if_unchanged: BOOLEAN
				): detachable HASH_TABLE [STRING_32, STRING_32]
			-- String representation of the Environment variables
		local
			k,v,n: STRING_32
			kmp: detachable KMP_WILD
			lst: ARRAYED_LIST [STRING_32]
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
					if k /= Void then
						if k.substring (1,2).same_string (environment_variable_unset_prefix) then
								--| Environment variable removal if started by "&-" such as "&-FOOBAR"
								--| this is an internal representation to precise "removal"
							if not Result.is_empty then
								n := k.substring (3, k.count)
								if n.same_string ({STRING_32} "*") then
										--| This is an optimization, since "*" will match all entries
										--| it is faster to directly wipe out the table.
									Result.wipe_out
								elseif n.has ('*') then
										-- such as "&-ISE_*"
									create kmp.make_empty
									kmp.set_pattern (n)

										-- Record the keys of items to remove.
									from
										create lst.make (Result.count)
										Result.start
									until
										Result.after
									loop
										kmp.set_text (Result.key_for_iteration)
										if kmp.pattern_matches then
											lst.force (Result.key_for_iteration)
										end
										Result.forth
									end

										--| Operate the removal
									across
										lst as ic
									loop
										Result.remove (ic.item)
									end
								else
									Result.remove (n)
								end
							end
						elseif v /= Void then
							Result.force (v, k)
						end
					end
					env.forth
				end
			end
		ensure
			Result_not_void_unless_unchanged: Result = Void implies (return_void_if_unchanged and (env = Void or else env.is_empty))
		end

	environment_variables_to_string_8 (env32: HASH_TABLE [STRING_32, STRING_32]): HASH_TABLE [STRING, STRING]
			-- String representation of the Environment variables
		do
			if attached env32 then
				create Result.make (env32.count)
				from
					env32.start
				until
					env32.after
				loop
					if
						attached env32.key_for_iteration as k and then
						attached env32.item_for_iteration as v
					then
						Result.force (v.as_string_8, k.as_string_8)
					end
					env32.forth
				end
			end
		ensure
			Result = Void implies env32 = Void
		end

invariant

	manager_not_void: manager /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
