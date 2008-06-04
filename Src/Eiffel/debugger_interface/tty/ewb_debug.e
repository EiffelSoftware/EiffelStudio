indexing

	description:
		"Command to run an eiffel application."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

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
	SHARED_EXEC_ENVIRONMENT
	SHARED_EIFFEL_PROJECT
	PROJECT_CONTEXT
	SYSTEM_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	SHARED_BENCH_NAMES

feature {NONE} -- Implementation

	loop_action is
			-- Execute the generated application
		do
			execute
		end

	dbg_main_menu: EWB_TTY_MENU is
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
			Result.add_separator (" --- ")
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
			Result.add_conditional_entry ("Q", debugger_names.e_quit, agent Result.quit, agent :BOOLEAN do Result := not debugger_manager.application_is_executing end)
		end

	param_args: STRING
	param_working_directory: STRING
	param_env_variables: HASH_TABLE [STRING_32, STRING_32]

	execute is
			-- This command is available only for the `loop' mode
		local
			dbg: TTY_DEBUGGER_MANAGER
			shared_eiffel: SHARED_EIFFEL_PROJECT
		do
			localized_print (debugger_names.m_experimental_warning)
			dbg ?= debugger_manager
			if dbg = Void then
				create dbg.make
				dbg.set_events_handler (create {TTY_DEBUGGER_EVENTS_HANDLER}.make)
				set_debugger_manager (dbg)
				dbg.load_all_debugger_data

				if param_working_directory = Void or else param_working_directory.is_empty then
					create shared_eiffel
					param_working_directory := Execution_environment.current_working_directory
				end
			end

			dbg_main_menu.execute (False)
		end

	display_params is
		do
			localized_print (debugger_names.m_parameters);
			localized_print (debugger_names.m_arguments);
			if param_args /= Void then
				localized_print (param_args)
			else
				localized_print (debugger_names.m_none)
			end
			io.put_new_line
			localized_print (debugger_names.m_environment_variables);
			if param_env_variables /= Void then
				from
					param_env_variables.start
				until
					param_env_variables.after
				loop
					io.put_string ("%N%T")
					localized_print (param_env_variables.key_for_iteration)
					io.put_string ("=")
					localized_print (param_env_variables.item_for_iteration)
					param_env_variables.forth
				end
			else
				localized_print (debugger_names.m_none)
			end
			io.put_new_line
			localized_print (debugger_names.m_working_directory);
			if param_working_directory /= Void then
				localized_print (param_working_directory)
			else
				localized_print (debugger_names.m_none)
			end
			io.put_new_line
			io.put_new_line
		end

	get_arguments is
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

	get_environment_variables is
		local
			vn: STRING
			vv: STRING
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
				localized_print (" -> " + vn + "=" + vv + "%N")
			end
		end

	get_working_directory is
		local
			d: like param_working_directory
		do
			localized_print (debugger_names.m_working_directory);
			if param_working_directory /= Void and then not param_working_directory.is_empty then
				localized_print ("[" + param_working_directory + "] ")
			else
				localized_print ("[...] ")
			end
			io.read_line
			if io.last_string.is_empty then
				if param_working_directory /= Void and then not param_working_directory.is_empty then
					if command_line_io.confirmed (debugger_names.m_remove_current_value) then
						param_working_directory := Void
					end
				else
					d := Eiffel_project.lace.directory_name
					if command_line_io.confirmed (debugger_names.m_confirm_use_this_directory_question (d)) then
						param_working_directory := d
					elseif not d.is_equal (Execution_environment.current_working_directory) then
						d := Execution_environment.current_working_directory
						if command_line_io.confirmed (debugger_names.m_confirm_use_this_directory_question (d)) then
							param_working_directory := d
						end
					end
				end
			else
				param_working_directory := io.last_string.twin
			end
		end

	start_debugger (a_exec_mode: INTEGER; ign_bp: BOOLEAN) is
		require
			debugger_manager /= Void
		local
			ctlr: DEBUGGER_CONTROLLER
			wdir: STRING
			param: DEBUGGER_EXECUTION_PARAMETERS
		do
			wdir := param_working_directory
			if wdir = Void or else wdir.is_empty then
				wdir := Eiffel_project.lace.directory_name
						--Execution_environment.current_working_directory
			end
			ctlr := debugger_manager.controller
			create param
			param.set_arguments (param_args)
			param.set_working_directory (wdir)
			param.set_environment_variables (param_env_variables)
			debugger_manager.set_execution_ignoring_breakpoints (ign_bp)
			ctlr.debug_application (param, a_exec_mode)
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

end -- class EWB_RUN
