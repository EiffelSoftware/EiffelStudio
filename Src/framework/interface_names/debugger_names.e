note
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

	t_Application_launched: STRING_32
			do Result := locale.translation ("Application launched") end
	t_Application_exited: STRING_32
			do Result := locale.translation ("Application exited") end
	t_space_Application_ignoring_breakpoints: STRING_32
			do Result := locale.translation (" (ignoring breakpoints)") end

	t_Running: STRING_32
			do Result := locale.translation ("Application is running") end
	t_Running_no_stop_points: STRING_32
			do Result := locale.translation ("Application is running (ignoring breakpoints)") end
	t_Paused: STRING_32
			do Result := locale.translation ("Application is paused") end
	t_debugger_excetion_menu: STRING_32
			do Result := locale.translation ("--< Debugger execution menu >--") end
	t_debugger_menu_display: STRING_32
			do Result := locale.translation ("--< Debugger menu :: Display >--") end
	t_debugger_menu_breakpoints: STRING_32
			do Result := locale.translation ("--< Debugger menu :: Breakpoints >--") end
	t_debugger_main_menu: STRING_32
			do Result := locale.translation ("--< Debugger main menu >--") end

feature -- warnings

	w_System_has_no_entry_and_is_not_executable: STRING_32
		do Result := locale.translation ("The system has no entry feature, it is not executable from EiffelStudio.") end

	w_Error_occurred_during_icordebug_initialization: STRING_32
		do Result := locale.translation (
							"An error occurred during initialization of the ICorDebug Debugger%N%
							% or during the Process creation (.NET).")
		end

	w_Cannot_attach_system (a_port: INTEGER): STRING_32
		do Result := locale.formatted_string (locale.translation ("Could not attach application using port $1"), [a_port]) end

	w_Cannot_launch_system: STRING_32
		do Result := locale.translation ("Could not launch system.") end

	w_Cannot_find_valid_ecdbgd_non_vms (a_ecdbgd_path: PATH; a_env_var_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
					"The Eiffel debugger is not found or not executable%N%
					%  current path = $1 %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the environment variable $2 %N"),
					[a_ecdbgd_path.name, a_env_var_name]
				)
		end

	w_Cannot_find_valid_ecdbgd_vms (a_ecdbgd_path: PATH; a_env_var_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
					"The Eiffel debugger is not found or not executable%N%
					%  current path = $1 %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the logical name $2 %N"),
					[a_ecdbgd_path.name, a_env_var_name]
				)
		end

	w_Cannot_launch_in_allotted_time_non_vms (a_timeout: INTEGER_32; a_env_var_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
					"The system could not be launched in allotted time:%N%
					%%NYour current timeout is $1 second(s) %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the environment variable $2 %N"),
					[a_timeout, a_env_var_name]
				)
		end

	w_Cannot_launch_in_allotted_time_vms (a_timeout: INTEGER_32; a_env_var_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
					"The system could not be launched in allotted time:%N%
					%%NYour current timeout is $1 second(s) %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the logical name $2 %N"),
					[a_timeout, a_env_var_name]
				)
		end

	w_Cannot_attach_in_allotted_time_non_vms (a_timeout: INTEGER_32; a_env_var_name: READABLE_STRING_GENERAL; a_port: INTEGER): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
					"The application could not be attached using port $3 in allotted time:%N%
					%%NYour current timeout is $1 second(s) %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the environment variable $2 %N"),
					[a_timeout, a_env_var_name, a_port]
				)
		end

	w_Cannot_attach_in_allotted_time_vms (a_timeout: INTEGER_32; a_env_var_name: READABLE_STRING_GENERAL; a_port: INTEGER): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
					"The application could not be attached using port $3 in allotted time:%N%
					%%NYour current timeout is $1 second(s) %N%
					%%NYou can change this value in the preferences%N%
					% or restart after setting the logical name $2 %N"),
					[a_timeout, a_env_var_name, a_port]
				)
		end

	w_Invalid_hit_count_condition_target: STRING_32
		do Result := locale.translation ("The specified hit count target is not valid.") end

feature -- Messages

	m_Not_yet_called: STRING_32
			do Result := locale.translation ("Not yet called") end

	m_Could_not_retrieve_once_information: STRING_32
			do Result := locale.translation ("Could not retrieve information (do is being called or do failed)") end

	m_n_breakpoints (a_n: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation ("*** $1 Breakpoints *** %N"), [a_n]) end
	m_zero_cancel: STRING_32
			do Result := locale.translation (" [0] Cancel %N") end
	m_expression: STRING_32
			do Result := locale.translation (" --> Expression: ") end
	m_error_occurred: STRING_32
			do Result := locale.translation ("Error occurred...") end
	m_class_name: STRING_32
			do Result := locale.translation (" -> class name: ") end
	m_could_not_find_class (a_c: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation (" => Could not find class {$1}. %N"), [a_c]) end
	m_feature_name: STRING_32
			do Result := locale.translation (" -> feature name: (*=all feature)") end
	m_added_breakpoints_in_class (a_c: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (" => Added breakpoints in class {$1}. %N", [a_c]) end
	m_could_not_find_feature (a_c, a_f: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation (" => Could not find feature {$1}.$2 %N"), [a_c, a_f]) end
	m_break_index: STRING_32
			do Result := locale.translation (" -> break index: ") end
	m_added_breakpoint_detailed (a_c, a_f, a_index: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation (" => Added breakpoint {$1}.$2@$3 %N"), [a_c, a_f, a_index]) end
	m_no_breakpoint_addition: STRING_32
			do Result := locale.translation (" => No breakpoint addition%N") end
	m_modify_breakpoint (a_s: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation ("*** Modify breakpoint $1 ***"), [a_s]) end
	m_current_condition (a_s: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation (" -> Current condition: %"$1%" %N"), [a_s]) end
	m_current_bp_message (a_s: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation (" -> Current message: %"$1%" %N"), [a_s]) end
	m_edit_new_condition: STRING_32
			do Result := locale.translation (" -> Enter new condition (empty to cancel) :") end
	m_continue_on_condition_failure_question: STRING_32
			do Result := locale.translation("Continue if evaluation fails ?")	end
	m_print_message_when_bp_hit_question: STRING_32
			do Result := locale.translation("Print a message ?") end
	m_continue_when_bp_hit_question: STRING_32
			do Result := locale.translation("Continue when breakpoint hits ?") end

	m_condition_is_true_or_has_changed_question (a_it,a_hc: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation("Condition is [$1:Is True] or [$2:Has Changed] ?"), [a_it, a_hc])	end
	m_remove_or_use_current_bp_message_question (a_1,a_2: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation("Do you want to [$1:remove] or [$2:use] current print message ?"), [a_1, a_2])	end

	m_not_a_valid_boolean_condition: STRING_32
			do Result := locale.translation (" => This is not a valid boolean condition. %N") end
	m_not_a_valid_condition: STRING_32
			do Result := locale.translation (" => This is not a valid condition. %N") end
	m_new_condition_applied: STRING_32
			do Result := locale.translation (" => New condition applied. %N") end
	m_debugger_environment_started: STRING_32
			do Result := locale.translation ("Debugger environment started%N") end
	m_debugger_environment_closed: STRING_32
			do Result := locale.translation ("Debugger environment closed%N") end
	m_no_debugging_for_dll_system: STRING_32
			do Result := locale.translation ("No debugging for DLL system") end
	m_system_is_running_ignoring_breakpoints: STRING_32
			do Result := locale.translation ("System is running (ignoring breakpoints)") end
	m_system_is_running: STRING_32
			do Result := locale.translation ("System is running") end
	m_experimental_warning: STRING_32
			do Result := locale.translation ("WARNING: the console based debugger is experimental!!%N") end
	m_parameters: STRING_32
			do Result := locale.translation ("*** Parameters ***%N") end
	m_arguments: STRING_32
			do Result := locale.translation ("--> Arguments: ") end
	m_none: STRING_32
			do Result := locale.translation ("<None>") end
	m_environment_variables: STRING_32
			do Result := locale.translation ("--> Environment variables: ") end
	m_working_directory: STRING_32
			do Result := locale.translation ("--> Working directory: ") end
	m_remove_current_value: STRING_32
			do Result := locale.translation ("--> Remove current value") end

	m_enter_name: STRING_32
			do Result := locale.translation (" -> Enter name: ") end
	m_enter_value: STRING_32
			do Result := locale.translation (" -> Enter value: ") end
	m_env_variable_already_set (a_vn, a_vv: READABLE_STRING_GENERAL): STRING_32
			do Result := locale.formatted_string (locale.translation (" (!) This variable already has a value [$1=$2].%N"), [a_vn, a_vv]) end

	m_confirm_entry_deletion_question: STRING_32
			do Result := locale.translation (" (!) Do you want to delete this entry ?") end
	m_confirm_entry_overwrite_question: STRING_32
			do Result := locale.translation (" (!) Do you want to overwrite the value ?") end
	m_confirm_use_this_directory_question (a_d: PATH): STRING_32
			do Result := locale.formatted_string (locale.translation (" -> Use this directory [$1] ?"), [a_d.name]) end

	m_error_invalid_value (a_s: detachable READABLE_STRING_GENERAL): STRING_32
			do
				if a_s /= Void then
					Result := locale.formatted_string (locale.translation (" (!) Please enter a valid value [$1]"), [a_s])
				else
					Result := locale.translation (" (!) Invalid value !")
				end
			end

	m_enter_debuggee_port_number (a_dft: INTEGER): STRING_32
			do
				if a_dft > 0 then
					Result := locale.formatted_string (locale.translation (" -> Enter port number to attach debuggee [$1]:"), [a_dft])
				else
					Result := locale.translation (" -> Enter port number to attach debuggee:")
				end
			end

feature -- Conditional entries

	c_step_next: STRING_32
			do Result := locale.translation ("Step next") end
	c_step_into: STRING_32
			do Result := locale.translation ("Step into") end
	c_step_out: STRING_32
			do Result := locale.translation ("Step out") end
	c_run_to_next_stop_point: STRING_32
			do Result := locale.translation ("Run to next stop point") end
	c_run_without_stop_point: STRING_32
			do Result := locale.translation ("Run without stop point") end
	c_toggle_ignore_breakpoint: STRING_32
			do Result := locale.translation ("Toggle 'Ignore stop point'") end
	c_kill_application: STRING_32
			do Result := locale.translation ("Kill application") end
	c_pause_application: STRING_32
			do Result := locale.translation ("Pause application") end
	c_breakpoints_controls: STRING_32
			do Result := locale.translation ("Breakpoints control") end
	c_display_information: STRING_32
			do Result := locale.translation ("Display information") end

feature -- Entries

	e_quit: STRING_32
			do Result := locale.translation ("Quit") end
	e_help: STRING_32
			do Result := locale.translation ("Help") end
	e_locales: STRING_32
			do Result := locale.translation ("Locals") end
	e_arguments: STRING_32
			do Result := locale.translation ("Arguments") end
	e_callstack: STRING_32
			do Result := locale.translation ("Callstack") end
	e_status: STRING_32
			do Result := locale.translation ("Status") end
	e_exception: STRING_32
			do Result := locale.translation ("Exception") end
	e_expression_evaluation: STRING_32
			do Result := locale.translation ("Expression evaluation") end
	e_back_to_parent_menu: STRING_32
			do Result := locale.translation ("Back to parent menu") end
	e_add_breakpoint: STRING_32
			do Result := locale.translation ("Add breakpoint") end
	e_modify_exsiting_breakpoint: STRING_32
			do Result := locale.translation ("Modify existing breakpoint") end
	e_list_breakpoints: STRING_32
			do Result := locale.translation ("List breakpoints") end
	e_enable_breakpoint: STRING_32
			do Result := locale.translation ("Enable breakpoint") end
	e_disable_breakpoint: STRING_32
			do Result := locale.translation ("Disable breakpoint") end
	e_remove_breakpoint: STRING_32
			do Result := locale.translation ("Remove breakpoint") end
	e_edit_condition: STRING_32
			do Result := locale.translation ("Edit condition") end
	e_remove_condition: STRING_32
			do Result := locale.translation ("Remove condition") end
	e_add_condition: STRING_32
			do Result := locale.translation ("Add condition") end
	e_enter_print_message: STRING_32
			do Result := locale.translation ("Enter message: ") end
	e_reset_bp_hits_count (a_count: INTEGER): STRING_32
			do Result := locale.formatted_string (locale.translation ("Reset hits count ($1)"), [a_count]) end
	e_bp_when_hits: STRING_32
			do Result := locale.translation ("When hits ...") end
	e_back_to_previous_menu: STRING_32
			do Result := locale.translation ("Back to previous menu") end
	e_set_arguments: STRING_32
			do Result := locale.translation ("Set arguments") end
	e_set_environment: STRING_32
			do Result := locale.translation ("Set environment") end
	e_set_working_directory: STRING_32
			do Result := locale.translation ("Set working directory") end
	e_display_parameters: STRING_32
			do Result := locale.translation ("Display parameters") end
	e_start_and_stop_at_breakpoints: STRING_32
			do Result := locale.translation ("Start and stop at breakpoints") end
	e_start_without_stopping_at_breakpoints: STRING_32
			do Result := locale.translation ("Start without stopping at breakpoints") end
	e_attach_debuggee_execution: STRING_32
			do Result := locale.translation ("Attach debuggee execution") end

feature -- Object grid line values

	l_no_object: STRING_32
			do Result := locale.translation ("No object") end

	l_no_information: STRING_32
			do Result := locale.translation ("No information") end

	l_exception_data: STRING_32
			do Result := locale.translation ("Exception data") end

feature -- Thread tool

	t_id: STRING_32
			do Result := locale.translation ("Id") end

	t_name: STRING_32
			do Result := locale.translation ("Name") end

	t_priority: STRING_32
			do Result := locale.translation ("Priority") end

	t_note: STRING_32
			do Result := locale.translation ("Note") end

	t_debuggees_active_thread: STRING_32
			do Result := locale.translation ("Debuggee's active thread") end

	t_no_information_about_thread: STRING_32
			do Result := locale.translation ("Sorry no information available on Threads for now") end

	t_no_information_when_not_stopped: STRING_32
			do Result := locale.translation ("Sorry no information when application is not stopped") end

	t_scoop_processors_title (a_nb: INTEGER): STRING_32
			do Result := locale.formatted_string (locale.plural_translation ("One SCOOP Processor", "$1 SCOOP Processors", a_nb), [a_nb]) end

	t_threads_title (a_nb: INTEGER): STRING_32
			do Result := locale.formatted_string (locale.plural_translation ("One Thread", "$1 Threads", a_nb), [a_nb]) end

feature -- Expression evaluation messages

	msg_error_call_on_void_target (fname: READABLE_STRING_GENERAL): STRING_32
		require
			fname /= Void
		do Result := locale.formatted_string (locale.translation ("Error: Call on void target for `$1'."), [fname]) end

	msg_error_vst1_on_class_context (clname, fname: READABLE_STRING_GENERAL): STRING_32
		require
			clname_not_void: clname /= Void
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("Error: Can not evaluate `{$1}.$2'.%NOnly once, constant and static call can be evaluated on 'Class' context.%N"), [clname, fname]) end

	msg_error_during_context_preparation (s: READABLE_STRING_GENERAL): STRING_32
		require
			s_not_void: s /= Void
		do Result := locale.formatted_string (locale.translation ("$1%N$2"), [cst_error_during_context_preparation, s]) end

	msg_error_not_supported (a: ANY): STRING_32
		require
			a_not_void: a /= Void
		do Result := locale.formatted_string (locale.translation ("[$1] is not supported."), [a.generator]) end

	msg_error_not_yet_ready (a: ANY; s: READABLE_STRING_GENERAL): STRING_32
		require
			a_not_void: a /= Void
			s_not_void: s /= Void
		do Result := locale.formatted_string (locale.translation ("$1$2 : sorry not yet ready."), [a.generator, s]) end

	msg_error_not_yet_ready_for (a: ANY; s, f: READABLE_STRING_GENERAL): STRING_32
		require
			a_not_void: a /= Void
			s_not_void: s /= Void
			f_not_void: f /= Void
		do Result := locale.formatted_string (locale.translation ("$1$2 : sorry not yet ready for `$3'."), [a.generator, s, f]) end

	msg_error_condition_expression_must_have_boolean_condition: STRING_32
		do Result := locale.translation ("Condition expression must have a boolean condition.") end

	msg_error_should_not_occur_during_evaluation (a: ANY): STRING_32
		require
			a_not_void: a /= Void
		do Result := locale.formatted_string (locale.translation ("$1 => this should not occur during expression evaluation."), [a.generator]) end

	msg_error_unable_to_evaluate_creation_expression (tn: detachable READABLE_STRING_GENERAL): STRING_32
		require
			tn_attached: tn /= Void
		do
			if tn = Void then
				Result := locale.formatted_string (locale.translation ("Evaluation of creation expression for type {$1} is not supported."), [tn])
			else
				Result := locale.translation ("Evaluation of creation expression for this type is not supported.")
			end
		end

	msg_error_evaluating_parameter (a: ANY): STRING_32
		require
			a_not_void: a /= Void
		do Result := locale.formatted_string (locale.translation ("$1 => An error occurred during the evaluation of parameter(s)"), [a.generator]) end

	msg_error_unknown_constant_type_for (fname: READABLE_STRING_GENERAL): STRING_32
		require
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("Unknown constant type for `$1'"), [fname]) end

	msg_error_during_evaluation_of_call (a: ANY; fname: READABLE_STRING_GENERAL): STRING_32
		require
			a_not_void: a /= Void
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("$1 => An error occurred during the evaluation of call : `$2'"), [a.generator, fname]) end

	msg_error_unable_to_get_valid_target_for (add: READABLE_STRING_GENERAL): STRING_32
		require
			add_not_void: add /= Void
		do Result := locale.formatted_string (locale.translation ("Unable to get valid target object for $1"), [add]) end

	msg_error_can_not_instantiate_type (tname, s: READABLE_STRING_GENERAL): STRING_32
		require
			tname_not_void: tname /= Void
			s_not_void: s /= Void
		do Result := locale.formatted_string (locale.translation ("Cannot instantiate type {$1} : $2."), [tname, s]) end

	msg_error_instantiation_of_type_raised_error (tname: READABLE_STRING_GENERAL): STRING_32
		require
			tname_not_void: tname /= Void
		do Result := locale.formatted_string (locale.translation ("Creation of type {$1} raised an error."), [tname]) end

	msg_error_with_retrieving_attribute (aname: READABLE_STRING_GENERAL): STRING_32
		require
			aname_not_void: aname /= Void
		do Result := locale.formatted_string (locale.translation ("Error: issue with attribute `$1'."), [aname]) end

	msg_error_instruction_eval_not_yet_available (a: ANY): STRING_32
		require
			a_not_void: a /= Void
		do Result := locale.formatted_string (locale.translation ("$1:  Instruction evaluation not yet available."), [a.generator]) end

	msg_error_expression_not_yet_available (a: ANY): STRING_32
		require
			a_not_void: a /= Void
		do Result := locale.formatted_string (locale.translation ("$1:  Not yet available."), [a.generator]) end

	msg_error_report_to_support (s: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("$1 => ERROR : please report to support."), [s])
		end

	msg_error_other_than_func_cst_once_not_available (a: ANY): STRING_32
		require
			a_not_void: a /= Void
		do Result := locale.formatted_string (locale.translation ("$1 => ERROR : other than function, constant and once : not available."), [a.generator]) end

	cst_error_evaluation_side_effect_forbidden: STRING_32
		do Result := locale.translation ("Evaluation stopped to avoid potential side effect.") end

	cst_error_evaluation_unable_to_get_context_object: STRING_32
		do Result := locale.translation ("Unable to get the context object.") end

	cst_error_context_corrupted_or_not_found: STRING_32
		do Result := locale.translation ("Context corrupted or not found") end

	cst_error_during_context_preparation: STRING_32
		do Result := locale.translation ("An error occurred while retrieving the expression's context.") end

	cst_error_during_expression_analyse: STRING_32
		do Result := locale.translation ("An error occurred during the analysis of the expression.") end

	cst_error_type_checking_failed : STRING_32
		do Result := locale.translation ("Type checking failed") end

	cst_error_evaluation_failed_with_internal_exception: STRING_32
		do Result := locale.translation ("Evaluation failed due to internal exception") end

	cst_unable_to_get_current_object: STRING_32
		do Result := locale.translation ("Unable to get Current object.") end

	cst_error_special_not_yet_supported: STRING_32
		do Result := locale.translation ("{SPECIAL} is not yet supported") end

	cst_error_formal_type_not_yet_supported: STRING_32
		do Result := locale.translation ("formal type is not yet supported") end

	cst_error_not_compiled: STRING_32
		do Result := locale.translation ("not compiled") end

	Cst_error_evaluation_aborted: STRING_32
		once Result := locale.translation ("Evaluation aborted") end
	Cst_error_exception_during_evaluation: STRING_32
		once Result := locale.translation ("Exception occurred during evaluation") end
	Cst_error_occurred: STRING_32
		once Result := locale.translation ("Error occurred") end
	Cst_error_unable_to_get_target_object: STRING_32
		once Result := locale.translation ("Unable to get target object") end
	Cst_error_occurred_during_parameters_preparation: STRING_32
		once Result := locale.translation ("Error during parameters preparation") end
	Cst_error_unable_to_get_icd_function: STRING_32
		once Result := locale.translation ("Unable to get ICorDebugFunction") end

	Cst_error_cannot_find_complete_dynamic_type_of_expanded_type: STRING_32
		do Result := locale.translation ("Cannot find complete dynamic type of an expanded type.") end

	msg_error_native_array_partially_supported (fname: detachable READABLE_STRING_GENERAL): STRING_32
		do
			if fname = Void then
				Result := locale.translation ("NATIVE_ARRAY is not yet fully supported.")
			else
				Result := locale.formatted_string (locale.translation ("NATIVE_ARRAY is not yet fully supported, unable to evaluate `$1'."), [fname])
			end
		end

	msg_error_unable_to_evaluate_call (cname,fname: READABLE_STRING_GENERAL; addr: detachable READABLE_STRING_GENERAL; desc: detachable READABLE_STRING_GENERAL): STRING_32
		require
			cname_not_void: cname /= Void
			fname_not_void: fname /= Void
		local
			s32: STRING_32
		do
			if desc = Void then
				s32 := ""
			else
				s32 := "%N"
				s32.append_string_general (desc)
			end
			if addr = Void then
				Result := locale.formatted_string (locale.translation ("Unable to evaluate {$1}.$2$3"), [cname, fname, s32])
			else
				Result := locale.formatted_string (locale.translation ("Unable to evaluate {$1}.$2 on <$3>$4"), [cname, fname, addr, s32])
			end
		end

	msg_error_evaluation_wrong_nb_of_args (fnb,pnb: INTEGER): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Wrong number of argument: $2 instead of $1 ."), [fnb, pnb])
		end

	msg_error_evaluation_aborted (cname,fname: READABLE_STRING_GENERAL): STRING_32
		require
			cname_not_void: cname /= Void
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("Evaluation aborted: {$1}.$2"), [cname, fname]) end

	msg_error_unable_to_evaluate_once_call (cname,fname: READABLE_STRING_GENERAL): STRING_32
		require
			cname_not_void: cname /= Void
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("Unable to evaluate once routine {$1}.$2"), [cname, fname]) end

	msg_error_unable_to_evaluate_non_once_call_with_any_object (cname,fname: READABLE_STRING_GENERAL): STRING_32
		require
			cname_not_void: cname /= Void
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("Unable to evaluate (non once) routine {$1}.$2 on Void object or type name"), [cname, fname]) end

	msg_error_exception_occurred_during_evaluation (cname, fname: READABLE_STRING_GENERAL; a_trace: detachable READABLE_STRING_GENERAL): STRING_32
		require
			cname_not_void: cname /= Void
			fname_not_void: fname /= Void
		local
			l_trace: detachable READABLE_STRING_GENERAL
		do
			l_trace := a_trace
			if l_trace = Void then
				l_trace := ""
			end
			Result := locale.formatted_string (locale.translation ("Exception occurred during evaluation of {$1}.$2:%N$3"), [cname, fname, l_trace])
		end

	msg_error_once_evaluation_failed (fname: READABLE_STRING_GENERAL; msg: detachable READABLE_STRING_GENERAL): STRING_32
		require
			fname_not_void: fname /= Void
		do
			if msg = Void then
				Result := locale.formatted_string (locale.translation ("Once function `$1': an exception occurred."), [fname])
			else
				Result := locale.formatted_string (locale.translation ("Once function `$1': $2."), [fname, msg])
			end
		end

	msg_error_once_routine_not_yet_called (fname: READABLE_STRING_GENERAL): STRING_32
		require
			fname_not_void: fname /= Void
		do
			Result := locale.formatted_string (locale.translation ("Once routine `$1': not yet called."), [fname])
		end

	msg_error_once_procedure_evaluation_not_yet_available (fname: READABLE_STRING_GENERAL): STRING_32
		require
			fname_not_void: fname /= Void
		do
			Result := locale.formatted_string (locale.translation ("Once procedure `$1': once procedure evaluation is not yet available."), [fname])
		end

	msg_error_unable_to_evaluate_deferred_call (cname,fname: READABLE_STRING_GENERAL): STRING_32
		require
			cname_not_void: cname /= Void
			fname_not_void: fname /= Void
		do Result := locale.formatted_string (locale.translation ("Unable to evaluate deferred routine {$1}.$2"), [cname, fname]) end

	msg_error_cannot_find_attribute (aname: READABLE_STRING_GENERAL): STRING_32
		require
			aname_not_void: aname /= Void
		do Result := locale.formatted_string (locale.translation ("Could not find attribute value for `$1'"), [aname]) end

	msg_error_cannot_evaluate_attribute_of_expanded (aname: READABLE_STRING_GENERAL): STRING_32
		require
			aname_not_void: aname /= Void
		do Result := locale.formatted_string (locale.translation ("Cannot evaluate attribute `$1' of an expanded value."), [aname]) end

	msg_error_cannot_evaluate_attribute_of_manifest_string (aname: READABLE_STRING_GENERAL): STRING_32
		require
			aname_not_void: aname /= Void
		do Result := locale.formatted_string (locale.translation ("Cannot evaluate attribute `$1' of a manisfest string declared in expression."), [aname]) end

	msg_error_cannot_find_context_object (addr: READABLE_STRING_GENERAL): STRING_32
		require
			addr_not_void: addr /= Void
		do Result := locale.formatted_string (locale.translation ("Error occurred: unable to find the context object <$1>."), [addr]) end

	msg_error_type_not_compiled (tname: READABLE_STRING_GENERAL): STRING_32
		require
			tname_not_void: tname /= Void
		do Result := locale.formatted_string (locale.translation ("Type {$1} is not compiled."), [tname]) end




note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
