indexing
	description: "Names used in debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_NAMES

inherit
	SHARED_LOCALE

feature -- Names

	t_Application_launched: STRING_GENERAL is
			do Result := locale.translation ("Application launched") end
	t_Application_exited: STRING_GENERAL is
			do Result := locale.translation ("Application exited") end
	t_space_Application_ignoring_breakpoints: STRING_GENERAL is
			do Result := locale.translation (" (ignoring breakpoints)") end

	t_Not_running: STRING_GENERAL is
			do Result := locale.translation ("Application is not running") end
	t_Running: STRING_GENERAL is
			do Result := locale.translation ("Application is running") end
	t_Running_no_stop_points: STRING_GENERAL is
			do Result := locale.translation ("Application is running (ignoring breakpoints)") end
	t_Paused: STRING_GENERAL is
			do Result := locale.translation ("Application is paused") end
	t_debugger_excetion_menu: STRING_GENERAL is
			do Result := locale.translation ("--< Debugger execution menu >--") end
	t_debugger_menu_display: STRING_GENERAL is
			do Result := locale.translation ("--< Debugger menu :: Display >--") end
	t_debugger_menu_breakpoints: STRING_GENERAL is
			do Result := locale.translation ("--< Debugger menu :: Breakpoints >--") end
	t_debugger_main_menu: STRING_GENERAL is
			do Result := locale.translation ("--< Debugger main menu >--") end

feature -- warnings

	w_System_has_no_entry_and_is_not_executable: STRING_GENERAL is
		do Result := locale.translation ("The system has no entry feature, it is not executable from EiffelStudio.") end

	w_Error_occurred_during_icordebug_initialization: STRING_GENERAL is
		do Result := locale.translation (
							"An error occurred during initialization of the ICorDebug Debugger%N%
							% or during the Process creation (.NET).")
		end

	w_Cannot_launch_system: STRING_GENERAL is
		do Result := locale.translation ("Could not launch system.") end

	w_Cannot_find_valid_ecdbgd (a_ecdbgd_path, a_env_var_str, a_env_var_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation (
					"The Eiffel debugger is not found or not executable%N%
					%  current path = $1 %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the $2 $3 %N"),
					[a_ecdbgd_path, a_env_var_str, a_env_var_name]
				)
		end

	w_Cannot_launch_in_allotted_time (a_timeout: INTEGER_32; a_env_var_str, a_env_var_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation (
					"The system could not be launched in allotted time:%N%
					%%NYour current timeout is $1 second(s) %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the $2 $3 %N"),
					[a_timeout, a_env_var_str, a_env_var_name]
				)
		end

feature -- Messages

	m_Not_yet_called: STRING_GENERAL is
			do Result := locale.translation ("Not yet called") end

	m_Could_not_retrieve_once_information: STRING_GENERAL is
			do Result := locale.translation ("Could not retrieve information (do is being called or do failed)") end

	m_n_breakpoints (a_n: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation ("*** $1 Breakpoints *** %N"), [a_n]) end
	m_zero_cancel: STRING_GENERAL is
			do Result := locale.translation (" [0] Cancel %N") end
	m_expression: STRING_GENERAL is
			do Result := locale.translation (" --> Expression: ") end
	m_error_occurred: STRING_GENERAL is
			do Result := locale.translation ("Error occurred...") end
	m_class_name: STRING_GENERAL is
			do Result := locale.translation (" -> class name: ") end
	m_could_not_find_class (a_c: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" => Could not find class {$1}. %N"), [a_c]) end
	m_feature_name: STRING_GENERAL is
			do Result := locale.translation (" -> feature name: (*=all feature)") end
	m_added_breakpoints_in_class (a_c: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (" => Added breakpoints in class {$1}. %N", [a_c]) end
	m_could_not_find_feature (a_c, a_f: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" => Could not find feature {$1}.$2 %N"), [a_c, a_f]) end
	m_break_index: STRING_GENERAL is
			do Result := locale.translation (" -> break index: ") end
	m_added_breakpoint_detailed (a_c, a_f, a_index: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" => Added breakpoint {$1}.$2@$3 %N"), [a_c, a_f, a_index]) end
	m_no_breakpoint_addition: STRING_GENERAL is
			do Result := locale.translation (" => No breakpoint addition%N") end
	m_modify_breakpoint (a_s: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation ("*** Modify breakpoint $1 ***"), [a_s]) end
	m_condition_sep (a_s: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation ("--( condition: %"$1%")--"), [a_s]) end
	m_bp_message_sep (a_s: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation ("--( message: %"$1%")--"), [a_s]) end
	m_current_condition (a_s: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" -> Current condition: %"$1%" %N"), [a_s]) end
	m_current_bp_message (a_s: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" -> Current message: %"$1%" %N"), [a_s]) end
	m_edit_new_condition: STRING_GENERAL is
			do Result := locale.translation (" -> Enter new condition (empty to cancel) :") end
	m_continue_on_condition_failure_question: STRING_GENERAL is
			do Result := locale.translation("Continue if evaluation fails ?")	end
	m_print_message_when_bp_hit_question: STRING_GENERAL is
			do Result := locale.translation("Print a message ?") end
	m_continue_when_bp_hit_question: STRING_GENERAL is
			do Result := locale.translation("Continue when breakpoint hits ?") end

	m_condition_is_true_or_has_changed_question (a_it,a_hc: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation("Condition is [$1:Is True] or [$2:Has Changed] ?"), [a_it, a_hc])	end
	m_remove_or_use_current_bp_message_question (a_1,a_2: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation("Do you want to [$1:remove] or [$2:use] current print message ?"), [a_1, a_2])	end

	m_not_a_valid_boolean_condition: STRING_GENERAL is
			do Result := locale.translation (" => This is not a valid boolean condition. %N") end
	m_not_a_valid_condition: STRING_GENERAL is
			do Result := locale.translation (" => This is not a valid condition. %N") end
	m_new_condition_applied: STRING_GENERAL is
			do Result := locale.translation (" => New condition applied. %N") end
	m_debugger_environment_started: STRING_GENERAL is
			do Result := locale.translation ("Debugger environment started%N") end
	m_debugger_environment_closed: STRING_GENERAL is
			do Result := locale.translation ("Debugger environment closed%N") end
	m_no_debugging_for_dll_system: STRING_GENERAL is
			do Result := locale.translation ("No debugging for DLL system") end
	m_system_is_running_ignoring_breakpoints: STRING_GENERAL is
			do Result := locale.translation ("System is running (ignoring breakpoints)") end
	m_system_is_running: STRING_GENERAL is
			do Result := locale.translation ("System is running") end
	m_experimental_warning: STRING_GENERAL is
			do Result := locale.translation ("WARNING: the console based debugger is experimental!!%N") end
	m_parameters: STRING_GENERAL is
			do Result := locale.translation ("*** Parameters ***%N") end
	m_arguments: STRING_GENERAL is
			do Result := locale.translation ("--> Arguments: ") end
	m_none: STRING_GENERAL is
			do Result := locale.translation ("<None>") end
	m_environment_variables: STRING_GENERAL is
			do Result := locale.translation ("--> Environment variables: ") end
	m_working_directory: STRING_GENERAL is
			do Result := locale.translation ("--> Working directory: ") end
	m_remove_current_value: STRING_GENERAL is
			do Result := locale.translation ("--> Remove current value") end

	m_enter_name: STRING_GENERAL is
			do Result := locale.translation (" -> Enter name: ") end
	m_enter_value: STRING_GENERAL is
			do Result := locale.translation (" -> Enter value: ") end
	m_env_variable_already_set (a_vn, a_vv: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" (!) This variable already has a value [$1=$2].%N"), [a_vn, a_vv]) end

	m_confirm_entry_deletion_question: STRING_GENERAL is
			do Result := locale.translation (" (!) Do you want to delete this entry ?") end
	m_confirm_entry_overwrite_question: STRING_GENERAL is
			do Result := locale.translation (" (!) Do you want to overwrite the value ?") end
	m_confirm_use_this_directory_question (a_d: STRING_GENERAL): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation (" -> Use this directory [$1] ?"), [a_d]) end

	m_error_invalid_value (a_s: STRING_GENERAL): STRING_GENERAL is
			do
				if a_s /= Void then
					Result := locale.formatted_string (locale.translation (" (!) Please enter a valid value [$1]"), [a_s])
				else
					Result := locale.translation (" (!) Invalid value !")
				end
			end

feature -- Conditional entries

	c_step_next: STRING_GENERAL is
			do Result := locale.translation ("Step next") end
	c_step_into: STRING_GENERAL is
			do Result := locale.translation ("Step into") end
	c_step_out: STRING_GENERAL is
			do Result := locale.translation ("Step out") end
	c_run_to_next_stop_point: STRING_GENERAL is
			do Result := locale.translation ("Run to next stop point") end
	c_run_without_stop_point: STRING_GENERAL is
			do Result := locale.translation ("Run without stop point") end
	c_kill_application: STRING_GENERAL is
			do Result := locale.translation ("Kill application") end
	c_pause_application: STRING_GENERAL is
			do Result := locale.translation ("Pause application") end
	c_breakpoints_controls: STRING_GENERAL is
			do Result := locale.translation ("Breakpoints control") end
	c_display_information: STRING_GENERAL is
			do Result := locale.translation ("Display information") end

feature -- Entries

	e_quit: STRING_GENERAL is
			do Result := locale.translation ("Quit") end
	e_help: STRING_GENERAL is
			do Result := locale.translation ("Help") end
	e_locales: STRING_GENERAL is
			do Result := locale.translation ("Locals") end
	e_arguments: STRING_GENERAL is
			do Result := locale.translation ("Arguments") end
	e_callstack: STRING_GENERAL is
			do Result := locale.translation ("Callstack") end
	e_status: STRING_GENERAL is
			do Result := locale.translation ("Status") end
	e_exception: STRING_GENERAL is
			do Result := locale.translation ("Exception") end
	e_expression_evaluation: STRING_GENERAL is
			do Result := locale.translation ("Expression evaluation") end
	e_back_to_parent_menu: STRING_GENERAL is
			do Result := locale.translation ("Back to parent menu") end
	e_add_breakpoint: STRING_GENERAL is
			do Result := locale.translation ("Add breakpoint") end
	e_modify_exsiting_breakpoint: STRING_GENERAL is
			do Result := locale.translation ("Modify existing breakpoint") end
	e_list_breakpoints: STRING_GENERAL is
			do Result := locale.translation ("List breakpoints") end
	e_enable_breakpoint: STRING_GENERAL is
			do Result := locale.translation ("Enable breakpoint") end
	e_disable_breakpoint: STRING_GENERAL is
			do Result := locale.translation ("Disable breakpoint") end
	e_remove_breakpoint: STRING_GENERAL is
			do Result := locale.translation ("Remove breakpoint") end
	e_edit_condition: STRING_GENERAL is
			do Result := locale.translation ("Edit condition") end
	e_remove_condition: STRING_GENERAL is
			do Result := locale.translation ("Remove condition") end
	e_add_condition: STRING_GENERAL is
			do Result := locale.translation ("Add condition") end
	e_enter_print_message: STRING_GENERAL is
			do Result := locale.translation ("Enter message: ") end
	e_reset_bp_hits_count (a_count: INTEGER): STRING_GENERAL is
			do Result := locale.formatted_string (locale.translation ("Reset hits count ($1)"), [a_count]) end
	e_bp_when_hits: STRING_GENERAL is
			do Result := locale.translation ("When hits ...") end
	e_back_to_previous_menu: STRING_GENERAL is
			do Result := locale.translation ("Back to previous menu") end
	e_set_arguments: STRING_GENERAL is
			do Result := locale.translation ("Set arguments") end
	e_set_environment: STRING_GENERAL is
			do Result := locale.translation ("Set environment") end
	e_set_working_directory: STRING_GENERAL is
			do Result := locale.translation ("Set working directory") end
	e_display_parameters: STRING_GENERAL is
			do Result := locale.translation ("Display parameters") end
	e_start_and_stop_at_breakpoints: STRING_GENERAL is
			do Result := locale.translation ("Start and stop at breakpoints") end
	e_start_without_stopping_at_breakpoints: STRING_GENERAL is
			do Result := locale.translation ("Start without stopping at breakpoints") end

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
