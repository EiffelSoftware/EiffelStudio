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
		do Result := locale.translation ("The importance score of a rule is used to %
			%enable sorting of rule violations. Within rule violations that belong to the same %
			%category, you can sort by importance.") end

	fix: STRING_32
		do Result := locale.translation ("Fix: ") end

	no_issues: STRING_32
		do Result := locale.translation ("Inspector Eiffel found no issues!") end

	class_context_menu_caption (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (locale.translation ("Run Inspector Eiffel on Class '$1'"), [a_class_name]) end

	cluster_context_menu_caption: STRING_32
		do Result := locale.translation ("Run Inspector Eiffel on cluster") end

	already_running: STRING_32
		do Result := locale.translation (" (already running)") end

	already_running_long: STRING_32
		do Result := locale.translation ("Inspector Eiffel is already running.%NPlease%
						% wait until the current analysis has finished.") end

	status_bar_running: STRING_32
		do Result := locale.translation ("Inspector Eiffel running...") end

	system_scope: STRING_32
		do Result := locale.translation ("System") end

	system_scope_tooltip: STRING_32
		do Result := locale.translation ("The whole system was analyzed recently.") end

	class_scope_tooltip: STRING_32
		do Result := locale.translation ("Class that has been analyzed recently.") end

	cluster_scope_tooltip: STRING_32
		do Result := locale.translation ("Cluster that has been analyzed recently.") end

	conf_group_tooltip: STRING_32
		do Result := locale.translation ("Configuration group that has been analyzed recently.") end

	status_bar_terminated: STRING_32
		do Result := locale.translation ("Inspector Eiffel has terminated.") end

	analyze_whole_system: STRING_32
		do Result := locale.translation ("Analyze whole system") end

	analyze_current_item: STRING_32
		do Result := locale.translation ("Analyze current item") end

	analyze_parent_cluster: STRING_32
		do Result := locale.translation ("Analyze parent cluster of current item") end

	run_code_analysis: STRING_32
		do Result := locale.translation ("Run Inspector Eiffel") end

	no_trace: STRING_32
		do Result := locale.translation ("No trace available.") end

	the_following_exception: STRING_32
		do Result := locale.translation ("The following exception has occurred while Inspector Eiffel was running:") end

	exception_trace: STRING_32
		do Result := locale.translation ("Exception Trace") end

	close: STRING_32
		do Result := locale.translation ("Close") end

	inspector_eiffel_exception: STRING_32
		do Result := locale.translation ("Inspector Eiffel Exception: ") end

feature -- Messages for both GUI and command line mode

		-- Avoid any new lines in the messages of this section!

	class_skipped (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (locale.translation ("Class $1 not compiled (skipped)."), [a_class_name]) end

	analyzing_class (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (locale.translation ("Analyzing class $1 ..."), [a_class_name]) end

	error_on_class (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (locale.translation ("An error occurred when analyzing class $1!"), [a_class_name]) end

feature -- Rule Violations

	self_assignment_violation_1: STRING_32
		do Result := locale.translation ("Variable '") end

	self_assignment_violation_2: STRING_32
		do Result := locale.translation ("' is assigned to itself. Assigning a variable to %
			                        %itself is%Na meaningless instruction due to a typing%
			                        % error. Most probably, one of the two%Nvariable %
			                        %names was misspelled.") end

	unused_argument_violation_1: STRING_32
		do Result := locale.translation ("Arguments ") end

	unused_argument_violation_2: STRING_32
		do Result := locale.translation (" from routine '") end

	unused_argument_violation_3: STRING_32
		do Result := locale.translation ("' are not used.") end

	npath_violation_1: STRING_32
		do Result := locale.translation ("Routine '") end

	npath_violation_2: STRING_32
		do Result := locale.translation ("' has an NPATH measure of ") end

	npath_violation_3: STRING_32
		do Result := locale.translation (", which is greater than the defined%Nmaximum of ") end

	feature_never_called_violation_1: STRING_32
		do Result := locale.translation ("Feature '") end

	feature_never_called_violation_2: STRING_32
		do Result := locale.translation ("' is never called by any class.") end

	cq_separation_violation_1 : STRING_32
		do Result := locale.translation ("Function '") end

	cq_separation_violation_2: STRING_32
		do Result := locale.translation ("' contains a procedure call, assigns to an%
			% attribute, or%Ncreates an attribute. This indicates that the function%
			% changes the state of the%Nobject, which is a violation of the %
			%command-query separation principle.") end

	unneeded_ot_local_violation_1: STRING_32
		do Result := locale.translation ("' is either a local variable, a feature%
			% argument, or an%Nobject test local. Thus the object test is not in %
			%need of the object test%Nlocal '") end

	empty_if_violation_1: STRING_32
		do Result := locale.translation ("An empty if instruction is useless and should be removed.") end

	nested_complexity_violation_1: STRING_32
		do Result := locale.translation ("In routine '") end

	nested_complexity_violation_2: STRING_32
		do Result := locale.translation ("' there are ") end

	nested_complexity_violation_3: STRING_32
		do Result := locale.translation (" nested branches%Nor loops, which is %
			%greater than or equal to the defined threshold of ") end

	many_arguments_violation_1: STRING_32
		do Result := locale.translation ("Feature '") end

	many_arguments_violation_2: STRING_32
		do Result := locale.translation ("' has many arguments. The number of arguments of%N") end

	many_arguments_violation_3: STRING_32
		do Result := locale.translation (" is greater than or equal to the defined threshold of ") end

	creation_proc_exported_violation_1: STRING_32
		do Result := locale.translation ("The creation procedure '") end

	creation_proc_exported_violation_2: STRING_32
		do Result := locale.translation ("' is exported and may still be%Ncalled after the object has been created.") end

	unneeded_object_test_violation_1: STRING_32
		do Result := locale.translation ("This object test is redundant because the tested variable '") end

	unneeded_object_test_violation_2: STRING_32
		do Result := locale.translation ("' is already of the static type '") end

	variable_not_read_violation_1: STRING_32
		do Result := locale.translation ("The local variable '") end

	variable_not_read_violation_2: STRING_32
		do Result := locale.translation ("' is not read / used before it gets reassigned or out of scope.") end

	semicolon_arguments_violation_1: STRING_32
		do Result := locale.translation ("Some arguments of routine '") end

	semicolon_arguments_violation_2: STRING_32
		do Result := locale.translation ("' are not separated by semicolons. This is considered bad style.") end

	very_long_routine_violation_1: STRING_32
		do Result := locale.translation ("Routine '") end

	very_long_routine_violation_2: STRING_32
		do Result := locale.translation ("' contains ") end

	very_long_routine_violation_3: STRING_32
		do Result := locale.translation (" instructions, which is above the%Ndefined threshold of ") end

	very_long_routine_violation_4: STRING_32
		do Result := locale.translation (". The routine should be shortened.") end

	very_big_class_violation_1: STRING_32
		do Result := locale.translation ("Class '") end

	very_big_class_violation_2: STRING_32
		do Result := locale.translation ("' contains ") end

	very_big_class_violation_3: STRING_32
		do Result := locale.translation (" features and ") end

	very_big_class_violation_4: STRING_32
		do Result := locale.translation (" instructions, at least%None of which is above the defined thresholds of ") end

	very_big_class_violation_5: STRING_32
		do Result := locale.translation (" and ") end

	very_big_class_violation_6: STRING_32
		do Result := locale.translation (".") end

	feature_section_comment_violation: STRING_32
		do Result := locale.translation ("A feature section has no comment.") end

	feature_not_commented_violation_1: STRING_32
		do Result := locale.translation ("Feature '") end

	feature_not_commented_violation_2: STRING_32
		do Result := locale.translation ("' is not commented. A feature comment is strongly%Nrecommended to enable clients to understand what the feature does.") end

	boolean_result_violation: STRING_32
		do Result := locale.translation ("For the assignment of the boolean result this if-else instruction is not needed.%NYou can directly assign the boolean expression that you are checking to the%Nresult.") end

	boolean_comparison_violation: STRING_32
		do Result := locale.translation ("This boolean variable or query does not need to be compared to a boolean constant.") end

	very_short_identifier_violation_1: STRING_32
		do Result := locale.translation ("The name of identifier '") end

	very_short_identifier_violation_2: STRING_32
		do Result := locale.translation ("' has ") end

	very_short_identifier_violation_3: STRING_32
		do Result := locale.translation (" characters, which is below the defined minimum of ") end

	very_long_identifier_violation_1: STRING_32
		do Result := locale.translation ("The name of identifier '") end

	very_long_identifier_violation_2: STRING_32
		do Result := locale.translation ("' has ") end

	very_long_identifier_violation_3: STRING_32
		do Result := locale.translation (" characters, which is above the defined maximum of ") end

	missing_is_equal_violation_1: STRING_32
		do Result := locale.translation ("This class defines '{HASHABLE}.hash_code', but does not redefine 'is_equal'.%N'is_equal' may need to be redefined.") end

	simplifiable_boolean_violation: STRING_32
		do Result := locale.translation ("This negated boolean expression can be%
			% simplified by removing the negation and%Nusing the inverse comparison operator.") end

	self_comparison_violation_1: STRING_32
		do Result := locale.translation ("' compared to itself always evaluates to the same boolean value.") end

	self_comparison_violation_2: STRING_32
		do Result := locale.translation (" Here, since it is the loop stop condition the loop will not terminate.") end

	wrong_loop_iteration_violation_1: STRING_32
		do Result := locale.translation ("Wrong comparison suspected in loop stop condition.") end

	wrong_loop_iteration_violation_2: STRING_32
		do Result := locale.translation ("Suspectedly the loop iterates in the wrong direction.") end

	inspect_instructions_violation_1: STRING_32
		do Result := locale.translation ("This inspect case consists of ") end

	inspect_instructions_violation_2: STRING_32
		do Result := locale.translation (" instructions, which is above the defined maximum of ") end

	attribute_to_local_violation_1: STRING_32
		do Result := locale.translation ("The attribute '") end

	attribute_to_local_violation_2: STRING_32
		do Result := locale.translation ("' is used only in%Nfeature'") end

	attribute_to_local_violation_3: STRING_32
		do Result := locale.translation ("' from the same class. It can be converted into a%Nlocal variable.") end

	empty_effective_routine_violation_1: STRING_32
		do Result := locale.translation ("Routine '") end

	empty_effective_routine_violation_2: STRING_32
		do Result := locale.translation ("' has an empty body. Since it is defined %
			%within a%Ndeferred class it should be considered to be declared as deferred.") end

	if_else_not_equal_violation: STRING_32
		do Result := locale.translation ("Condition of if-else instruction checks for inequality rather than equality.") end

	short_circuit_if_violation: STRING_32
		do Result := locale.translation ("These two nested if instructions may be %
			%combined into a single if instruction%Nusing the short circuit 'and then' operator.") end

	iterable_loop_violation_1: STRING_32
		do Result := locale.translation ("Iterating through '") end

	iterable_loop_violation_2: STRING_32
		do Result := locale.translation ("' may be done using an across loop, which%Nis more recommendable than a from-until loop.") end

	count_equals_zero_violation: STRING_32
		do Result := locale.translation ("Consider replacing this comparison to zero by a call to '") end

	deeply_nested_if_violation_1: STRING_32
		do Result := locale.translation ("This if instruction is nested within ") end

	deeply_nested_if_violation_2: STRING_32
		do Result := locale.translation (" or more outer if instructions, which%Nmakes the code less readable. It should be avoided.") end

	unneeded_helper_variable_violation_1: STRING_32
		do Result := locale.translation ("The local variable '") end

	unneeded_helper_variable_violation_2: STRING_32
		do Result := locale.translation ("' used here can be replaced by the%Nexpression that this variable gets assigned before. Thus the local variable is%Nnot actually needed.") end

	unneeded_parentheses_violation_1: STRING_32
		do Result := locale.translation ("These parentheses are not needed and should be removed in order to maintain a consistent coding style.") end

	error: STRING_32
		do Result := locale.translation ("An error occurred when analyzing this class.") end

feature -- Command Line

	cmd_class: STRING_32
		do Result := locale.translation ("%NIn class '") end

	cmd_help_message: STRING_32
		do Result := locale.translation ("Inspector Eiffel performs static analyses on the source code and %
			           %outputs a list of issues found according to a set of rules.") end

	cmd_class_not_found_1: STRING_32
		do Result := locale.translation ("Warning: class '") end

	cmd_class_not_found_2: STRING_32
		do Result := locale.translation ("' was not found and will be skipped. Check the spelling %
			%and make sure the class has been compiled.%N") end

end
