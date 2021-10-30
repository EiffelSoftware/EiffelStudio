note

	description: "Command to run an eiffel application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EWB_DEBUG

inherit

	EWB_CMD
		rename
			name as debug_cmd_name,
			help_message as debug_help,
			abbreviation as debug_abb
		redefine
			loop_action
		end
	SHARED_EXECUTION_ENVIRONMENT
	SHARED_EIFFEL_PROJECT
	PROJECT_CONTEXT
	SYSTEM_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	SHARED_BENCH_NAMES

feature {NONE} -- Implementation

	loop_action
			-- Execute the generated application
		do
			execute
		end

	dbg_main_menu: EWB_TTY_MENU
		once
			create Result.make (debugger_names.t_debugger_main_menu)
			Result.enter_actions.extend_kamikaze (agent Result.request_menu_display)

			Result.add_entry ("A", debugger_names.e_set_arguments, agent get_arguments)
			Result.add_entry ("E", debugger_names.e_set_environment, agent get_environment_variables)
			Result.add_entry ("D", debugger_names.e_set_working_directory, agent get_working_directory)
			Result.add_entry ("I", debugger_names.e_display_parameters, agent display_params)
			Result.add_separator (" --- ")
			Result.add_entry ("R", debugger_names.e_start_and_stop_at_breakpoints, agent start_debugger ({EXEC_MODES}.run, False))
			Result.add_entry ("L", debugger_names.e_start_without_stopping_at_breakpoints, agent start_debugger ({EXEC_MODES}.run, True))
			Result.add_entry ("S", debugger_names.c_step_into, agent start_debugger ({EXEC_MODES}.step_into, False))
			Result.add_entry ("C", debugger_names.e_attach_debuggee_execution, agent attach_debuggee)
			Result.add_separator (" --- ")
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
			Result.add_conditional_entry ("Q", debugger_names.e_quit, agent Result.quit, agent :BOOLEAN do Result := not debugger_manager.application_is_executing end)
		end

	param_args: STRING
	param_working_path: PATH
	param_env_variables: HASH_TABLE [STRING_32, STRING_32]

	execute
			-- This command is available only for the `loop' mode
		local
			dbg: TTY_DEBUGGER_MANAGER
		do
			localized_print (debugger_names.m_experimental_warning)
			if attached {TTY_DEBUGGER_MANAGER} debugger_manager as tty_dbg then
				dbg := tty_dbg
			else
				create dbg.make
				dbg.set_events_handler (create {TTY_DEBUGGER_EVENTS_HANDLER}.make)
				dbg.register
				dbg.load_all_debugger_data

				if not attached param_working_path as wp or else wp.is_empty then
					param_working_path := Execution_environment.current_working_path
				end
			end

			dbg_main_menu.execute (False)
		end

	display_params
		do
			localized_print (debugger_names.m_parameters);
			localized_print (debugger_names.m_arguments);
			if attached param_args as l_args then
				localized_print (l_args)
			else
				localized_print (debugger_names.m_none)
			end
			io.put_new_line
			localized_print (debugger_names.m_environment_variables);
			if attached param_env_variables as l_param_env_variables then
				across
					l_param_env_variables as v
				loop
					io.put_string ("%N%T")
					localized_print (v.key)
					io.put_string ("=")
					localized_print (v.item)
				end
			else
				localized_print (debugger_names.m_none)
			end
			io.put_new_line
			localized_print (debugger_names.m_working_directory);
			if attached param_working_path as wp then
				localized_print (wp.name)
			else
				localized_print (debugger_names.m_none)
			end
			io.put_new_line
			io.put_new_line
		end

	get_arguments
		do
			localized_print (debugger_names.m_arguments);
			if param_args /= Void and then not param_args.is_empty then
				localized_print ("[" + param_args + "] ");
			end

			io.read_line
			if
				(param_args /= Void and then not param_args.is_empty)
				and io.last_string.is_empty
			then
				if command_line_io.confirmed (debugger_names.m_remove_current_value) then
					param_args := Void
				end
			else
				param_args := io.last_string.twin
			end
		end

	get_environment_variables
		local
			vn: STRING_32
			vv: STRING_32
		do
			localized_print (debugger_names.m_environment_variables)
			io.put_new_line
			localized_print (debugger_names.m_enter_name)
			command_line_io.get_name
			command_line_io.get_last_input
			vn := command_line_io.last_input
			if vn /= Void and then not vn.is_empty then
				vn := vn.twin
			end

			if param_env_variables /= Void and then param_env_variables.has_key (vn) then
				vv := param_env_variables.item (vn)
			else
				vv := Void
			end
			if vv /= Void then
				localized_print (debugger_names.m_env_variable_already_set (vn, vv))
				if command_line_io.confirmed (debugger_names.m_confirm_entry_deletion_question) then
					param_env_variables.remove (vn)
					vn := Void
				end
				if vn /= Void and then command_line_io.confirmed (debugger_names.m_confirm_entry_overwrite_question) then
					vv := Void
				end
			end
			if vn /= Void and then vv = Void then
				localized_print (debugger_names.m_enter_value)
				io.read_line
				vv := io.last_string.twin
				if param_env_variables = Void then
					create param_env_variables.make (5)
				end
				param_env_variables.force (vv, vn)
				localized_print ({STRING_32} " -> " + vn + "=" + vv + "%N")
			end
		end

	get_working_directory
		local
			wp: like param_working_path
		do
			localized_print (debugger_names.m_working_directory);
			wp := param_working_path
			if wp /= Void and then not wp.is_empty then
				localized_print ({STRING_32} "[" + wp.name + {STRING_32} "] ")
			else
				localized_print ("[...] ")
			end
			io.read_line
			if io.last_string.is_empty then
				wp := param_working_path
				if wp /= Void and then not wp.is_empty then
					if command_line_io.confirmed (debugger_names.m_remove_current_value) then
						param_working_path := Void
					end
				else
					create wp.make_from_string (Eiffel_project.lace.directory_name)
					if command_line_io.confirmed (debugger_names.m_confirm_use_this_directory_question (wp)) then
						param_working_path := wp
					elseif not wp.same_as (Execution_environment.current_working_path) then
						wp := Execution_environment.current_working_path
						if command_line_io.confirmed (debugger_names.m_confirm_use_this_directory_question (wp)) then
							param_working_path := wp
						end
					end
				end
			else
				create param_working_path.make_from_string (io.last_string) -- FIXME: Unicode .. should we consider it as UTF-8 ?
			end
		end

	attach_debuggee
			-- Ask portnumber and try to attach debuggee.
		require
			debugger_manager /= Void
		local
			l_port: INTEGER
		do
			l_port := 50505
			localized_print (debugger_names.m_enter_debuggee_port_number (l_port))
			io.read_line
			if not io.last_string.is_empty and io.last_string.is_integer then
				l_port := io.last_string.to_integer
			end
			if l_port >= 1024 then
				debugger_manager.controller.attach_application (l_port)
			end
		end

	start_debugger (a_exec_mode: INTEGER; ign_bp: BOOLEAN)
		require
			debugger_manager /= Void
		local
			ctlr: DEBUGGER_CONTROLLER
			wdir: PATH
			prof: DEBUGGER_EXECUTION_PROFILE
		do
			wdir := param_working_path
			if wdir = Void or else wdir.is_empty then
				create wdir.make_from_string (Eiffel_project.lace.directory_name)
						--Execution_environment.current_working_directory
			end
			ctlr := debugger_manager.controller
			create prof.make
			if attached param_args as l_args then
				prof.set_arguments (l_args)
			else
				prof.set_arguments ("")
			end
			prof.set_working_directory (wdir)
			prof.set_environment_variables (param_env_variables)
			debugger_manager.set_execution_ignoring_breakpoints (ign_bp)
			ctlr.debug_application
				(create {DEBUGGER_EXECUTION_RESOLVED_PROFILE}.make_from_profile (prof), a_exec_mode)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
