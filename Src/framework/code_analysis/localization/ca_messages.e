note
	description: "Message strings for the Code Analyzer"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CA_MESSAGES

inherit
	SHARED_LOCALE

feature -- GUI

	severity_score_description: STRING_32
		do Result := translation_in_context ("The importance score of a rule is used to %
			%enable sorting of rule violations. Within rule violations that belong to the same %
			%category, you can sort by importance.", once "code_analyzer") end

	fix: STRING_32
		do Result := translation_in_context ("Fix: ", once "code_analyzer") end

	no_issues: STRING_32
		do Result := translation_in_context ("No issues.", once "code_analyzer.message") end

	class_context_menu_caption (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Run Eiffel Inspector on Class '$1'", once "code_analyzer"), [a_class_name]) end

	cluster_context_menu_caption: STRING_32
		do Result := translation_in_context ("Run Eiffel Inspector on cluster", once "code_analyzer") end

	already_running: STRING_32
		do Result := translation_in_context (" (already running)", once "code_analyzer") end

	already_running_long: STRING_32
		do Result := translation_in_context	("Eiffel Inspector is already running.%N%
				%Please wait until the current analysis has finished.", once "code_analyzer") end

	status_bar_running: STRING_32
		do Result := translation_in_context ("Eiffel Inspector running...", once "code_analyzer") end

	system_scope: STRING_32
		do Result := translation_in_context ("System", once "code_analyzer") end

	system_scope_tooltip: STRING_32
		do Result := translation_in_context ("The whole system was analyzed recently.", once "code_analyzer.tooltip") end

	class_scope_tooltip: STRING_32
		do Result := translation_in_context ("Class that has been analyzed recently.", once "code_analyzer.tooltip") end

	cluster_scope_tooltip: STRING_32
		do Result := translation_in_context ("Cluster that has been analyzed recently.", once "code_analyzer.tooltip") end

	conf_group_tooltip: STRING_32
		do Result := translation_in_context ("Configuration group that has been analyzed recently.", once "code_analyzer.tooltip") end

	status_bar_terminated: STRING_32
		do Result := translation_in_context ("Eiffel Inspector has terminated.", once "code_analyzer") end

	analyze_whole_system: STRING_32
		do Result := translation_in_context ("Analyze whole system", once "code_analyzer.tooltip") end

	analyze_current_item: STRING_32
		do Result := translation_in_context ("Analyze current item", once "code_analyzer.tooltip") end

	analyze_parent_cluster: STRING_32
		do Result := translation_in_context ("Analyze parent cluster of current item", once "code_analyzer.tooltip") end

	run_code_analysis: STRING_32
		do Result := translation_in_context ("Run Eiffel Inspector", once "code_analyzer") end

	no_trace: STRING_32
		do Result := translation_in_context ("No trace available.", once "code_analyzer") end

	the_following_exception: STRING_32
		do Result := translation_in_context ("The following exception has occurred while Eiffel Inspector was running:", once "code_analyzer") end

	exception_trace: STRING_32
		do Result := translation_in_context ("Exception Trace", once "code_analyzer") end

	close: STRING_32
		do Result := translation_in_context ("Close", once "code_analyzer") end

	inspector_eiffel_exception: STRING_32
		do Result := translation_in_context ("Eiffel Inspector Exception: ", once "code_analyzer") end

feature -- Messages for both GUI and command line mode

		-- Avoid any new lines in the messages of this section!

	class_skipped (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Class $1 not compiled (skipped).", once "code_analyzer"), [a_class_name]) end

	analyzing_class (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Analyzing class $1...", once "code_analyzer.status"), [a_class_name]) end

	error_on_class (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("An error occurred when analyzing class $1!", once "code_analyzer"), [a_class_name]) end

feature -- Rule Violations

	self_assignment_violation_1: STRING_32
		do Result := translation_in_context ("Variable '", once "code_analyzer.violation") end

	self_assignment_violation_2: STRING_32
		do Result := translation_in_context ("' is assigned to itself. Assigning a variable to %
			                        %itself is%Na meaningless instruction due to a typing%
			                        % error. Most probably, one of the two%Nvariable %
			                        %names was misspelled.", once "code_analyzer.violation") end

	unused_argument_violation_1: STRING_32
		do Result := translation_in_context ("Arguments ", once "code_analyzer.violation") end

	unused_argument_violation_2: STRING_32
		do Result := translation_in_context (" from routine '", once "code_analyzer.violation") end

	unused_argument_violation_3: STRING_32
		do Result := translation_in_context ("' are not used.", once "code_analyzer.violation") end

	npath_violation_1: STRING_32
		do Result := translation_in_context ("Routine '", once "code_analyzer.violation") end

	npath_violation_2: STRING_32
		do Result := translation_in_context ("' has an NPATH measure of ", once "code_analyzer.violation") end

	npath_violation_3: STRING_32
		do Result := translation_in_context (", which is greater than the defined%Nmaximum of ", once "code_analyzer.violation") end

	feature_never_called_violation_1: STRING_32
		do Result := translation_in_context ("Feature '", once "code_analyzer.violation") end

	feature_never_called_violation_2: STRING_32
		do Result := translation_in_context ("' is never called by any class.", once "code_analyzer.violation") end

	cq_separation_violation_1 : STRING_32
		do Result := translation_in_context ("Function '", once "code_analyzer.violation") end

	cq_separation_violation_2: STRING_32
		do Result := translation_in_context ("' contains a procedure call, assigns to an%
			% attribute, or%Ncreates an attribute. This indicates that the function%
			% changes the state of the%Nobject, which is a violation of the %
			%command-query separation principle.", once "code_analyzer.violation") end

	unneeded_ot_local_violation_1: STRING_32
		do Result := translation_in_context ("' is either a local variable, a feature%
			% argument, or an%Nobject test local. Thus the object test is not in %
			%need of the object test%Nlocal '", once "code_analyzer.violation") end

	empty_if_violation_1: STRING_32
		do Result := translation_in_context ("An empty if instruction is useless and should be removed.", once "code_analyzer.violation") end

	nested_complexity_violation_1: STRING_32
		do Result := translation_in_context ("In routine '", once "code_analyzer.violation") end

	nested_complexity_violation_2: STRING_32
		do Result := translation_in_context ("' there are ", once "code_analyzer.violation") end

	nested_complexity_violation_3: STRING_32
		do Result := translation_in_context (" nested branches%Nor loops, which is %
			%greater than or equal to the defined threshold of ", once "code_analyzer.violation") end

	many_arguments_violation_1: STRING_32
		do Result := translation_in_context ("Feature '", once "code_analyzer.violation") end

	many_arguments_violation_2: STRING_32
		do Result := translation_in_context ("' has many arguments. The number of arguments of%N", once "code_analyzer.violation") end

	many_arguments_violation_3: STRING_32
		do Result := translation_in_context (" is greater than or equal to the defined threshold of ", once "code_analyzer.violation") end

	creation_proc_exported_violation_1: STRING_32
		do Result := translation_in_context ("The creation procedure '", once "code_analyzer.violation") end

	creation_proc_exported_violation_2: STRING_32
		do Result := translation_in_context ("' is exported and may still be%Ncalled after the object has been created.", once "code_analyzer.violation") end

	unneeded_object_test_violation_1: STRING_32
		do Result := translation_in_context ("This object test is redundant because the tested variable '", once "code_analyzer.violation") end

	unneeded_object_test_violation_2: STRING_32
		do Result := translation_in_context ("' is already of the static type '", once "code_analyzer.violation") end

	variable_not_read_violation_1: STRING_32
		do Result := translation_in_context ("The local variable '", once "code_analyzer.violation") end

	variable_not_read_violation_2: STRING_32
		do Result := translation_in_context ("' is not read / used before it gets reassigned or out of scope.", once "code_analyzer.violation") end

	semicolon_arguments_violation_1: STRING_32
		do Result := translation_in_context ("Some arguments of routine '", once "code_analyzer.violation") end

	semicolon_arguments_violation_2: STRING_32
		do Result := translation_in_context ("' are not separated by semicolons. This is considered bad style.", once "code_analyzer.violation") end

	very_long_routine_violation_1: STRING_32
		do Result := translation_in_context ("Routine '", once "code_analyzer.violation") end

	very_long_routine_violation_2: STRING_32
		do Result := translation_in_context ("' contains ", once "code_analyzer.violation") end

	very_long_routine_violation_3: STRING_32
		do Result := translation_in_context (" instructions, which is above the%Ndefined threshold of ", once "code_analyzer.violation") end

	very_long_routine_violation_4: STRING_32
		do Result := translation_in_context (". The routine should be shortened.", once "code_analyzer.violation") end

	very_big_class_violation_1: STRING_32
		do Result := translation_in_context ("Class '", once "code_analyzer.violation") end

	very_big_class_violation_2: STRING_32
		do Result := translation_in_context ("' contains ", once "code_analyzer.violation") end

	very_big_class_violation_3: STRING_32
		do Result := translation_in_context (" features and ", once "code_analyzer.violation") end

	very_big_class_violation_4: STRING_32
		do Result := translation_in_context (" instructions, at least%None of which is above the defined thresholds of ", once "code_analyzer.violation") end

	very_big_class_violation_5: STRING_32
		do Result := translation_in_context (" and ", once "code_analyzer.violation") end

	very_big_class_violation_6: STRING_32
		do Result := translation_in_context (".", once "code_analyzer.violation") end

	feature_section_comment_violation: STRING_32
		do Result := translation_in_context ("A feature section has no comment.", once "code_analyzer.violation") end

	feature_not_commented_violation_1: STRING_32
		do Result := translation_in_context ("Feature '", once "code_analyzer.violation") end

	feature_not_commented_violation_2: STRING_32
		do Result := translation_in_context ("' is not commented. A feature comment is strongly%Nrecommended to enable clients to understand what the feature does.", once "code_analyzer.violation") end

	boolean_result_violation: STRING_32
		do Result := translation_in_context ("For the assignment of the boolean result this if-else instruction is not needed.%NYou can directly assign the boolean expression that you are checking to the%Nresult.", once "code_analyzer.violation") end

	boolean_comparison_violation: STRING_32
		do Result := translation_in_context ("This boolean variable or query does not need to be compared to a boolean constant.", once "code_analyzer.violation") end

	very_short_identifier_violation_1: STRING_32
		do Result := translation_in_context ("The name of identifier '", once "code_analyzer.violation") end

	very_short_identifier_violation_2: STRING_32
		do Result := translation_in_context ("' has ", once "code_analyzer.violation") end

	very_short_identifier_violation_3: STRING_32
		do Result := translation_in_context (" characters, which is below the defined minimum of ", once "code_analyzer.violation") end

	very_long_identifier_violation_1: STRING_32
		do Result := translation_in_context ("The name of identifier '", once "code_analyzer.violation") end

	very_long_identifier_violation_2: STRING_32
		do Result := translation_in_context ("' has ", once "code_analyzer.violation") end

	very_long_identifier_violation_3: STRING_32
		do Result := translation_in_context (" characters, which is above the defined maximum of ", once "code_analyzer.violation") end

	missing_is_equal_violation_1: STRING_32
		do Result := translation_in_context ("This class defines '{HASHABLE}.hash_code', but does not redefine 'is_equal'.%N'is_equal' may need to be redefined.", once "code_analyzer.violation") end

	simplifiable_boolean_violation: STRING_32
		do Result := translation_in_context ("This negated boolean expression can be%
			% simplified by removing the negation and%Nusing the inverse comparison operator.", once "code_analyzer.violation") end

	self_comparison_violation_1: STRING_32
		do Result := translation_in_context ("' compared to itself always evaluates to the same boolean value.", once "code_analyzer.violation") end

	self_comparison_violation_2: STRING_32
		do Result := translation_in_context (" Here, since it is the loop stop condition the loop will not terminate.", once "code_analyzer.violation") end

	wrong_loop_iteration_violation_1: STRING_32
		do Result := translation_in_context ("Wrong comparison suspected in loop stop condition.", once "code_analyzer.violation") end

	wrong_loop_iteration_violation_2: STRING_32
		do Result := translation_in_context ("Suspectedly the loop iterates in the wrong direction.", once "code_analyzer.violation") end

	inspect_instructions_violation_1: STRING_32
		do Result := translation_in_context ("This inspect case consists of ", once "code_analyzer.violation") end

	inspect_instructions_violation_2: STRING_32
		do Result := translation_in_context (" instructions, which is above the defined maximum of ", once "code_analyzer.violation") end

	attribute_to_local_violation_1: STRING_32
		do Result := translation_in_context ("The attribute '", once "code_analyzer.violation") end

	attribute_to_local_violation_2: STRING_32
		do Result := translation_in_context ("' is used only in%Nfeature'", once "code_analyzer.violation") end

	attribute_to_local_violation_3: STRING_32
		do Result := translation_in_context ("' from the same class. It can be converted into a%Nlocal variable.", once "code_analyzer.violation") end

	empty_effective_routine_violation_1: STRING_32
		do Result := translation_in_context ("Routine '", once "code_analyzer.violation") end

	empty_effective_routine_violation_2: STRING_32
		do Result := translation_in_context ("' has an empty body. Since it is defined %
			%within a%Ndeferred class it should be considered to be declared as deferred.", once "code_analyzer.violation") end

	if_else_not_equal_violation: STRING_32
		do Result := translation_in_context ("Condition of if-else instruction checks for inequality rather than equality.", once "code_analyzer.violation") end

	short_circuit_if_violation: STRING_32
		do Result := translation_in_context ("These two nested if instructions may be %
			%combined into a single if instruction%Nusing the short circuit 'and then' operator.", once "code_analyzer.violation") end

	iterable_loop_violation_1: STRING_32
		do Result := translation_in_context ("Iterating through '", once "code_analyzer.violation") end

	iterable_loop_violation_2: STRING_32
		do Result := translation_in_context ("' may be done using an across loop, which%Nis more recommendable than a from-until loop.", once "code_analyzer.violation") end

	count_equals_zero_violation: STRING_32
		do Result := translation_in_context ("Consider replacing this comparison to zero by a call to '", once "code_analyzer.violation") end

	deeply_nested_if_violation_1: STRING_32
		do Result := translation_in_context ("This if instruction is nested within ", once "code_analyzer.violation") end

	deeply_nested_if_violation_2: STRING_32
		do Result := translation_in_context (" or more outer if instructions, which%Nmakes the code less readable. It should be avoided.", once "code_analyzer.violation") end

	unneeded_helper_variable_violation_1: STRING_32
		do Result := translation_in_context ("The local variable '", once "code_analyzer.violation") end

	unneeded_helper_variable_violation_2: STRING_32
		do Result := translation_in_context ("' used here can be replaced by the%Nexpression that this variable gets assigned before. Thus the local variable is%Nnot actually needed.", once "code_analyzer.violation") end

	unneeded_parentheses_violation_1: STRING_32
		do Result := translation_in_context ("These parentheses are not needed and should be removed in order to maintain a consistent coding style.", once "code_analyzer.violation") end

	error: STRING_32
		do Result := translation_in_context ("An error occurred when analyzing this class.", once "code_analyzer.violation") end

feature -- Command Line

	cmd_class: STRING_32
		do Result := translation_in_context ("%NIn class '", once "code_analyzer.command") end

	cmd_help_message: STRING_32
		do Result := translation_in_context ("Eiffel Inspector performs static analyses on the source code and %
			           %outputs a list of issues found according to a set of rules.", once "code_analyzer.command") end

	cmd_class_not_found_1: STRING_32
		do Result := translation_in_context ("Warning: class '", once "code_analyzer.command") end

	cmd_class_not_found_2: STRING_32
		do Result := translation_in_context ("' was not found and will be skipped. Check the spelling %
			%and make sure the class has been compiled.%N", once "code_analyzer.command") end

	rule_not_found (a_rule_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Warning: rule $1 could not be found, ignoring it.", once "code_analyzer"), [a_rule_name]) end

	preference_not_found (a_full_preference_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Warning: preference $1 could not be found, ignoring it.", once "code_analyzer"), [a_full_preference_name]) end

	unknown_argument (a_argument_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Warning: argument $1 is not recognized or could not be parsed, ignoring it.", once "code_analyzer"), [a_argument_name]) end

	missing_file_name (a_option: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Missing file name after command-line option %"$1%".", once "code_analyzer"), [a_option]) end

	missing_rule (a_option: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Missing rule name (with optional settings) after command-line option %"$1%".", once "code_analyzer"), [a_option]) end

	missing_class (a_option: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Missing class name after command-line option %"$1%".", once "code_analyzer"), [a_option]) end

	rule_argument_error (a_option: attached READABLE_STRING_GENERAL; a_message: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Error in command-line option %"$1%": $2.", once "code_analyzer"), a_option, a_message) end

	invalid_rule_name: STRING_32
		do Result := translation_in_context ("Invalid rule name", once "code_analyzer") end

	invalid_rule_setting (a_rule_name: READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Invalid settings for rule %"$1%"", once "code_analyzer"), a_rule_name) end

	missing_closing_parenthesis (a_rule_name: READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Missing closing parenthesis for rule %"$1%"", once "code_analyzer"), a_rule_name) end

feature {NONE} -- Translation

	translation_in_context (s: READABLE_STRING_GENERAL; context: READABLE_STRING_GENERAL): STRING_32
			-- Translation of `s' in the context `context'.
		do
			Result := locale.translation_in_context (s, context)
		end

end
