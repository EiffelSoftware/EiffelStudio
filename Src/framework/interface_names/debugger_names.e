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
			once Result := locale.translate ("Application launched") end
	t_Application_exited: STRING_GENERAL is
			once Result := locale.translate ("Application exited") end
	t_space_Application_ignoring_breakpoints: STRING_GENERAL is
			once Result := locale.translate (" (ignoring breakpoints)") end

	t_Not_running: STRING_GENERAL is
			once Result := locale.translate ("Application is not running") end
	t_Running: STRING_GENERAL is
			once Result := locale.translate ("Application is running") end
	t_Running_no_stop_points: STRING_GENERAL is
			once Result := locale.translate ("Application is running (ignoring breakpoints)") end
	t_Paused: STRING_GENERAL is
			once Result := locale.translate ("Application is paused") end
	t_debugger_excetion_menu: STRING_GENERAL is
			once Result := locale.translate ("--< Debugger execution menu >--") end
	t_debugger_menu_display: STRING_GENERAL is
			once Result := locale.translate ("--< Debugger menu :: Display >--") end
	t_debugger_menu_breakpoints: STRING_GENERAL is
			once Result := locale.translate ("--< Debugger menu :: Breakpoints >--") end
	t_debugger_main_menu: STRING_GENERAL is
			once Result := locale.translate ("--< Debugger main menu >--") end


feature -- Messages

	m_n_breakpoints (a_n: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate ("*** $1 Breakpoints *** %N"), [a_n]) end
	m_zero_cancel: STRING_GENERAL is
			once Result := locale.translate (" [0] Cancel %N") end
	m_expression: STRING_GENERAL is
			once Result := locale.translate (" --> Expression: ") end
	m_error_occurred: STRING_GENERAL is
			once Result := locale.translate ("Error occurred...") end
	m_class_name: STRING_GENERAL is
			once Result := locale.translate (" -> class name: ") end
	m_could_not_find_class (a_c: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate (" => Could not find class {$1}. %N"), [a_c]) end
	m_feature_name: STRING_GENERAL is
			once Result := locale.translate (" -> feature name: (*=all feature)") end
	m_added_breakpoints_in_class (a_c: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (" => Added breakpoints in class {$1}. %N", [a_c]) end
	m_could_not_find_feature (a_c, a_f: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate (" => Could not find feature {$1}.$2 %N"), [a_c, a_f]) end
	m_break_index: STRING_GENERAL is
			once Result := locale.translate (" -> break index: ") end
	m_added_breakpoint_detailed (a_c, a_f, a_index: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate (" => Added breakpoint {$1}.$2@$3 %N"), [a_c, a_f, a_index]) end
	m_no_breakpoint_addition: STRING_GENERAL is
			once Result := locale.translate (" => No breakpoint addition%N") end
	m_modify_breakpoint (a_s: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate ("*** Modify breakpoint $1 ***"), [a_s]) end
	m_condition_sep (a_s: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate ("--( condition: %"$1%")--"), [a_s]) end
	m_current_condition (a_s: STRING_GENERAL): STRING_GENERAL is
			once Result := locale.format_string (locale.translate (" -> Current condition: %"$1%" %N"), [a_s]) end
	m_edit_new_condition: STRING_GENERAL is
			once Result := locale.translate (" -> Enter new condition (empty to cancel) :") end
	m_not_a_valid_boolean_condition: STRING_GENERAL is
			once Result := locale.translate (" => This is not a valid boolean condition. %N") end
	m_new_condition_applied: STRING_GENERAL is
			once Result := locale.translate (" => New condition applied. %N") end
	m_debugger_environment_started: STRING_GENERAL is
			once Result := locale.translate ("Debugger environment started%N") end
	m_debugger_environment_closed: STRING_GENERAL is
			once Result := locale.translate ("Debugger environment closed%N") end
	m_no_debugging_for_dll_system: STRING_GENERAL is
			once Result := locale.translate ("No debugging for DLL system") end
	m_system_is_running_ignoring_breakpoints: STRING_GENERAL is
			once Result := locale.translate ("System is running (ignoring breakpoints)") end
	m_system_is_running: STRING_GENERAL is
			once Result := locale.translate ("System is running") end
	m_experimental_warning: STRING_GENERAL is
			once Result := locale.translate ("WARNING: the console based debugger is experimental!!%N") end
	m_parameters: STRING_GENERAL is
			once Result := locale.translate ("*** Parameters ***%N") end
	m_arguments: STRING_GENERAL is
			once Result := locale.translate ("--> Arguments: ") end
	m_none: STRING_GENERAL is
			once Result := locale.translate ("<None>") end
	m_environment_variables: STRING_GENERAL is
			once Result := locale.translate ("--> Environment variables: ") end
	m_working_directory: STRING_GENERAL is
			once Result := locale.translate ("--> Working directory: ") end
	m_remove_current_value: STRING_GENERAL is
			once Result := locale.translate ("--> Remove current value") end

feature -- Conditional entries

	c_step_next: STRING_GENERAL is
			once Result := locale.translate ("Step next") end
	c_step_into: STRING_GENERAL is
			once Result := locale.translate ("Step into") end
	c_step_out: STRING_GENERAL is
			once Result := locale.translate ("Step out") end
	c_run_to_next_stop_point: STRING_GENERAL is
			once Result := locale.translate ("Run to next stop point") end
	c_run_without_stop_point: STRING_GENERAL is
			once Result := locale.translate ("Run without stop point") end
	c_kill_application: STRING_GENERAL is
			once Result := locale.translate ("Kill application") end
	c_pause_application: STRING_GENERAL is
			once Result := locale.translate ("Pause application") end
	c_breakpoints_controls: STRING_GENERAL is
			once Result := locale.translate ("Breakpoints control") end
	c_display_information: STRING_GENERAL is
			once Result := locale.translate ("Display information") end

feature -- Entries

	e_quit: STRING_GENERAL is
			once Result := locale.translate ("Quit") end
	e_help: STRING_GENERAL is
			once Result := locale.translate ("Help") end
	e_locales: STRING_GENERAL is
			once Result := locale.translate ("locals") end
	e_arguments: STRING_GENERAL is
			once Result := locale.translate ("arguments") end
	e_callstack: STRING_GENERAL is
			once Result := locale.translate ("callstack") end
	e_status: STRING_GENERAL is
			once Result := locale.translate ("status") end
	e_exception: STRING_GENERAL is
			once Result := locale.translate ("exception") end
	e_expression_evaluation: STRING_GENERAL is
			once Result := locale.translate ("Expression evaluation") end
	e_back_to_parent_menu: STRING_GENERAL is
			once Result := locale.translate ("Back to parent menu") end
	e_add_breakpoint: STRING_GENERAL is
			once Result := locale.translate ("Add breakpoint") end
	e_modify_exsiting_breakpoint: STRING_GENERAL is
			once Result := locale.translate ("Modify existing breakpoint") end
	e_list_breakpoints: STRING_GENERAL is
			once Result := locale.translate ("list breakpoints") end
	e_enable_breakpoint: STRING_GENERAL is
			once Result := locale.translate ("Enable breakpoint") end
	e_disable_breakpoint: STRING_GENERAL is
			once Result := locale.translate ("Disable breakpoint") end
	e_remove_breakpoint: STRING_GENERAL is
			once Result := locale.translate ("Remove breakpoint") end
	e_edit_condition: STRING_GENERAL is
			once Result := locale.translate ("Edit condition") end
	e_remove_condition: STRING_GENERAL is
			once Result := locale.translate ("Remove condition") end
	e_add_condition: STRING_GENERAL is
			once Result := locale.translate ("Add condition") end
	e_back_to_previous_menu: STRING_GENERAL is
			once Result := locale.translate ("Back to previous menu") end
	e_set_arguments: STRING_GENERAL is
			once Result := locale.translate ("Set arguments") end
	e_set_environment: STRING_GENERAL is
			once Result := locale.translate ("Set environment") end
	e_set_working_directory: STRING_GENERAL is
			once Result := locale.translate ("Set working directory") end
	e_display_parameters: STRING_GENERAL is
			once Result := locale.translate ("Display parameters") end
	e_start_and_stop_at_breakpoints: STRING_GENERAL is
			once Result := locale.translate ("Start and stop at breakpoints") end
	e_start_without_stopping_at_breakpoints: STRING_GENERAL is
			once Result := locale.translate ("Start without stopping at breakpoints") end



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
