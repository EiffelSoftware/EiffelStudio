note
	description: "Message strings for the Code Analyzer"
	author: "Stefan Zurfluh", "Eiffel Software"
	date: "$Date$"
	revision: "$Revision$"
	ca_ignore: "CA033", "CA033 — very long class"

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
		do Result := locale.formatted_string (translation_in_context ("Analyze '$1'", once "code_analyzer.menu"), [a_class_name]) end

	cluster_context_menu_caption (a_cluster_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Analyze '$1'", once "code_analyzer.menu"), [a_cluster_name]) end

	already_running_menu_suffix: STRING_32
		do Result := translation_in_context (" (already running)", once "code_analyzer.menu") end

	already_running_long: STRING_32
		do Result := translation_in_context	("Code analysis is already running.%N%
				%Please wait until it has finished.", once "code_analyzer") end

	status_bar_running: STRING_32
		do Result := translation_in_context ("Analyzing code...", once "code_analyzer") end

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
		do Result := translation_in_context ("Code analysis has finished.", once "code_analyzer") end

	analyze_last_menu (s: detachable READABLE_STRING_32): STRING_32
		do
			Result := if attached s then
				locale.formatted_string (translation_in_context ("Analyze '$1' again", once "code_analyzer.menu"), s)
			else
				translation_in_context ("Analyze Last Item Again", once "code_analyzer.menu")
			end
		end

	analyze_editor_menu (s: detachable READABLE_STRING_32): STRING_32
		do
			Result := if attached s then
				locale.formatted_string (translation_in_context ("Analyze '$1'", once "code_analyzer.menu"), s)
			else
				translation_in_context ("Analyze Editor Item", once "code_analyzer.menu")
			end
		end

	analyze_parent_menu (s: detachable READABLE_STRING_32): STRING_32
		do
			Result := if attached s then
				locale.formatted_string (translation_in_context ("Analyze Cluster '$1'", once "code_analyzer.menu"), s)
			else
				translation_in_context ("Analyze Parent Cluster of Last Item", once "code_analyzer.menu")
			end
		end

	analyze_target_menu (s: detachable READABLE_STRING_32): STRING_32
		do
			Result := if attached s then
				locale.formatted_string (translation_in_context ("Analyze System Target '$1'", once "code_analyzer.menu"), s)
			else
				translation_in_context ("Analyze System Target", once "code_analyzer.menu")
			end
		end

	analyze_again_description: STRING_32
		do Result := translation_in_context ("Analyze", once "code_analyzer") end

	analyze_editor_description: STRING_32
		do Result := translation_in_context ("Analyze Code from Editor", once "code_analyzer") end

	analyze_parent_description: STRING_32
		do Result := translation_in_context ("Analyze Parent Cluster", once "code_analyzer") end

	analyze_target_description: STRING_32
		do Result := translation_in_context ("Analyze Whole Target", once "code_analyzer") end

	no_trace: STRING_32
		do Result := translation_in_context ("No trace available.", once "code_analyzer") end

	the_following_exception: STRING_32
		do Result := translation_in_context ("The following exception has occurred during code analysis:", once "code_analyzer") end

	exception_trace: STRING_32
		do Result := translation_in_context ("Exception Trace", once "code_analyzer") end

	close: STRING_32
		do Result := translation_in_context ("Close", once "code_analyzer") end

	inspector_eiffel_exception: STRING_32
		do Result := translation_in_context ("Code Analyzer Exception: ", once "code_analyzer") end

	preferences_description: STRING_32
		do Result := translation_in_context ("Code Analyzer Preferences", once "code_analyzer") end

feature -- Messages for both GUI and command line mode

		-- Avoid any new lines in the messages of this section!

	class_skipped (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Class $1 not compiled (skipped).", once "code_analyzer"), [a_class_name]) end

	analyzing_class (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("Analyzing class $1...", once "code_analyzer.status"), [a_class_name]) end

	error_on_class (a_class_name: attached READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (translation_in_context ("An error occurred when analyzing class $1!", once "code_analyzer"), [a_class_name]) end

feature -- Rule Violations

	export_can_be_restricted_violation_1: STRING_32
		do Result := translation_in_context ("The export status of feature '", once "code_analyzer.violation") end

	export_can_be_restricted_violation_2: STRING_32
		do Result := translation_in_context ("' can be changed to {NONE}.", once "code_analyzer.violation") end

	generic_param_too_long_violation_1: STRING_32
		do Result := translation_in_context ("The formal generic parameter '", once "code_analyzer.violation") end

	generic_param_too_long_violation_2: STRING_32
		do Result := translation_in_context ("'%Nhas more than one character in its name.%NIt should only have one.", once "code_analyzer.violation") end

	mergeable_conditionals_violation_1: STRING_32
		do Result := translation_in_context ("There are two conditionals with semantically equal conditionals.%N%
									% Thus the conditional instructions can be merged into one", once "code_analyzer.violation") end

	local_used_for_result_violation_1: STRING_32
		do Result := translation_in_context ("The local variable '", once "code_analyzer.violation") end

	local_used_for_result_violation_2: STRING_32
		do Result := translation_in_context ("' is only assigned to Result and never used.%NIt can be replaced by Result directly.", once "code_analyzer.violation") end

	real_nan_comparison_violation_1: STRING_32
		do Result := translation_in_context ("Comparing of a real variable with {REAL}.nan usually does not yield%Nthe intended result.%
									% You should use the query %".is_nan%"", once "code_analyzer.violation") end

	object_test_succeeds_violation_1: STRING_32
		do Result := translation_in_context ("The object test for the variable '", once "code_analyzer.violation") end

	object_test_succeeds_violation_2: STRING_32
		do Result := translation_in_context ("The non-Void test for the variable '", once "code_analyzer.violation") end

	object_test_succeeds_violation_3: STRING_32
		do Result := translation_in_context ("' will always succeed, therefore%N the test can be removed.", once "code_analyzer.violation") end

	object_test_failing_violation_1: STRING_32
		do Result := translation_in_context ("This object test will always fail, therefore the corresponding%N block of code can be safely removed.", once "code_analyzer.violation") end

	useless_contract_violation_1: STRING_32
		do Result := translation_in_context ("Feature '", once "code_analyzer.violation") end

	useless_contract_violation_2: STRING_32
		do Result := translation_in_context ("' contains a precondition which is not needed and can be removed.", once "code_analyzer.violation") end

	unreachable_code_violation_1: STRING_32
		do Result := translation_in_context ("Class '", once "code_analyzer.violation") end

	unreachable_code_violation_2: STRING_32
		do Result := translation_in_context ("' contains unreachable code%Nthat should be considered to be removed. '", once "code_analyzer.violation") end

	loop_invariant_comp_within_loop_violation_1: STRING_32
		do Result := translation_in_context ("The instruction '", once "code_analyzer.violation") end

	loop_invariant_comp_within_loop_violation_2: STRING_32
		do Result := translation_in_context ("' is invariant in this loop and can be moved%Nin front or after%
									% the loop to increase performance.", once "code_analyzer.violation") end

	attribute_can_be_constant_violation_1: STRING_32
		do Result := translation_in_context ("Attribute '", once "code_analyzer.violation") end

	attribute_can_be_constant_violation_2: STRING_32
		do Result := translation_in_context ("' is always assigned the same value: ", once "code_analyzer.violation") end

	attribute_can_be_constant_violation_3: STRING_32
		do Result := translation_in_context (".%N This attribute can be made constant.", once "code_analyzer.violation") end

	attribute_never_assigned_violation_1: STRING_32
		do Result := translation_in_context ("Attribute '", once "code_analyzer.violation") end

	attribute_never_assigned_violation_2: STRING_32
		do Result := translation_in_context ("' is never assigned in this class.%NIt will always keep its default value.", once "code_analyzer.violation") end

	comparison_of_object_refs_violation_1: STRING_32
		do Result := translation_in_context ("You are using '=' to compare object references. This only%Nchecks whether they%
									% point to the same object.%NIf you wanted to compare their states you%Ncan do so by using%
									% the '~' operator", once "code_analyzer.violation") end

	void_check_using_is_equal_violation_1: STRING_32
		do Result := translation_in_context ("The local variable or argument '", once "code_analyzer.violation") end

	void_check_using_is_equal_violation_2: STRING_32
		do Result := translation_in_context ("' is checked being Void using 'is_equal'.%NThis should be done using the '=' or%
									% '/=' operators", once "code_analyzer.violation") end

	empty_creation_procedure_violation_1: STRING_32
		do Result := translation_in_context ("Class '", once "code_analyzer.violation") end

	empty_creation_procedure_violation_2: STRING_32
		do Result := translation_in_context ("' has an empty creation%Nprocedure. This should be considered%Nto be%
									% removed. Note that all clients need to call 'create c' instead%Nof 'create c.", once "code_analyzer.violation") end

	empty_creation_procedure_violation_3: STRING_32
		do Result := translation_in_context ("' where 'c' is an object of the%Nclass '", once "code_analyzer.violation") end

	empty_creation_procedure_violation_4: STRING_32
		do Result := translation_in_context ("'.", once "code_analyzer.violation") end

	object_creation_within_loop_violation_1: STRING_32
		do Result := translation_in_context ("Creating objects within a loop may decrease performance.%NCheck%
									% whether the object creation can be moved outside the loop.", once "code_analyzer.violation") end

	missing_creation_proc_without_args_violation_1: STRING_32
		do Result := translation_in_context ("Class '", once "code_analyzer.violation") end

	missing_creation_proc_without_args_violation_2: STRING_32
		do Result := translation_in_context ("' has at least one%N creation procedure with arguments but%
									% none without arguments.%NNormally, one should be able to create class%
									% with empty initializing data,%Nwhere the client can set or add the data later.", once "code_analyzer.violation") end

	empty_loop_violation: STRING_32
		do Result := translation_in_context ("A loop with an empty body should be removed.%NIn most cases%
									% the loop never exits.", once "code_analyzer.violation") end

	double_negation_violation: STRING_32
		do Result := translation_in_context ("Double negations in boolean expressions can be safely removed%N%
									% to increase the readability of the code.", once "code_analyzer.violation") end

	inherit_from_any_violation_1: STRING_32
		do Result := translation_in_context ("Class '", once "code_analyzer.violation") end

	inherit_from_any_violation_2: STRING_32
		do Result := translation_in_context ("' contains an explicit%Ninheritance with no adaptation from the ANY class%N%
									% which doesn't need to be defined.", once "code_analyzer.violation") end

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

	empty_if_violation_if: STRING_32
		do Result := translation_in_context ("A conditional instruction without any compound part can be removed.", once "code_analyzer.violation") end

	empty_if_violation_if_else: STRING_32
		do Result := translation_in_context ("A condition of the branch without compound can be inverted and the empty branch can be removed.", once "code_analyzer.violation") end

	empty_if_violation_elseif: STRING_32
		do Result := translation_in_context ("A branch without compound part and subsequent branches can be removed.", once "code_analyzer.violation") end

	empty_if_violation_else: STRING_32
		do Result := translation_in_context ("An empty alternative branch can be removed.", once "code_analyzer.violation") end

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
		do Result := translation_in_context ("Conditional instruction or expression with 2 branches checks for inequality rather than equality.", once "code_analyzer.violation") end

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

	class_naming_convention_violation_1: STRING_32
		do Result := locale.translation ("Class '") end

	class_naming_convention_violation_2: STRING_32
		do Result := locale.translation ("' does not respect the Eiffel naming convention for classes (all uppercase, no trailing or two consecutive underscores).") end

	feature_naming_convention_violation_1: STRING_32
		do Result := locale.translation ("Feature '") end

	feature_naming_convention_violation_2: STRING_32
		do Result := locale.translation ("' does not respect the Eiffel naming convention for features (all lowercase, no trailing or two consecutive underscores).") end

	local_naming_convention_violation_1: STRING_32
		do Result := locale.translation ("Local variable '") end

	local_naming_convention_violation_2: STRING_32
		do Result := locale.translation ("' does not respect the Eiffel naming convention for local variables (all lowercase, begin with 'l_', no trailing or two consecutive underscores).") end

	argument_naming_convention_violation_1: STRING_32
		do Result := locale.translation ("Argument '") end

	argument_naming_convention_violation_2: STRING_32
		do Result := locale.translation ("' does not respect the Eiffel naming convention for arguments (all lowercase, begin with 'a_', no trailing or two consecutive underscores).") end

	unnecessary_sign_operator_violation_1: STRING_32
		do Result := locale.translation ("Expression ") end

	unnecessary_sign_operator_violation_2: STRING_32
		do Result := locale.translation (" starts with an unnecessary sign operator. All unary sign operators for numbers are unnecessary, except for a single minus sign. They should be removed or the instruction should be checked for errors.") end

	empty_uncommented_routine_violation_1: STRING_32
		do Result := locale.translation ("Routine '") end

	empty_uncommented_routine_violation_2: STRING_32
		do Result := locale.translation ("' has an empty body and no comment. The implementation might be missing.") end

	unneeded_accessor_function_violation_1: STRING_32
		do Result := locale.translation ("Feature '") end

	unneeded_accessor_function_violation_2: STRING_32
		do Result := locale.translation ("' seems to be a %"getter%" function of the '") end

	unneeded_accessor_function_violation_3: STRING_32
		do Result := locale.translation ("' secret attribute. This is not necessary in Eiffel, as it is not allowed to write to an attribute from outside a class. An exported attribute can be used instead.") end

	mergeable_feature_clauses_violation_1: STRING_32
		do Result := locale.translation ("Feature clause ") end

	mergeable_feature_clauses_violation_2: STRING_32
		do Result := locale.translation (" has the same comment and export status of a previous feature clause in its class. They could be possibly merged into one, or their comments could be made more specific.") end

	empty_rescue_clause_violation_1: STRING_32
		do Result := locale.translation ("Feature '") end

	empty_rescue_clause_violation_2: STRING_32
		do Result := locale.translation ("' has an empty 'rescue' clause. This should be avoided as it can lead to undesirable program behaviour.") end

	inspect_no_when_with_else_violation: STRING_32
		do Result := locale.translation ("This 'inspect' instruction has no 'when' branch. The 'else' branch will always be executed.") end

	inspect_no_when_no_else_violation: STRING_32
		do Result := locale.translation ("This 'inspect' instruction is empty.  An exception will always be raised, for there is no matching branch for any value of the inspected variable.") end

	explicit_redundant_inheritance_violation_1: STRING_32
			do Result := locale.translation ("Class '") end

	explicit_redundant_inheritance_violation_2: STRING_32
			do Result := locale.translation ("' has a multiple explicit inheritance link to class '") end

	explicit_redundant_inheritance_violation_3: STRING_32
			do Result := locale.translation ("', with no renaming, redefining or change of export status. This is redundant, and the duplicate links should be removed.") end

	obsolete_feature_call_title: STRING_32
		do
			Result := locale.translation_in_context ("Call to obsolete feature {1}: {2}", "code_analyzer.violation")
		end

	obsolete_feature_call_violation: STRING_32
		do
			Result := locale.translation_in_context ("Obsolete feature {1} of class {2} is called from {3} of class {4}:{5}", "code_analyzer.violation")
		end

	obsolete_feature_invalid_date_title (feature_count: INTEGER): STRING_32
		do
			Result := locale.plural_translation_in_context
				("Obsolete message date for feature {1} is absent or unreadable.",
				"Obsolete message date for features {1} is absent or unreadable.",
				once "code_analyzer.violation",
				feature_count)
		end

	obsolete_feature_invalid_date_violation: STRING_32
		do
			Result := locale.translation_in_context ("Obsolete message date should appear at the end of the message in brackets. The default value [{1}] is used.", once "code_analyzer.violation")
		end

	obsolete_feature_call_expires_in (n: INTEGER): STRING_32
		do
			Result := locale.plural_translation_in_context ("The obsolete feature call has to be removed in a day.", "The obsolete feature call has to be removed in {1} days.",  once "code_analyzer.violation", n)
		end

	obsolete_feature_title (feature_count: INTEGER): STRING_32
		do
			Result := locale.plural_translation_in_context
				("A feature {1} is obsolete.",
				"Features {1} are obsolete.",
				once "code_analyzer.violation",
				feature_count)
		end

	obsolete_feature_violation: STRING_32
		do
			Result := locale.translation_in_context ("Obsolete features should be removed.", "code_analyzer.violation")
		end

	error: STRING_32
		do Result := translation_in_context ("An error occurred when analyzing this class.", once "code_analyzer.violation") end

feature -- Command Line

	cmd_class: STRING_32
		do Result := translation_in_context ("%NIn class '", once "code_analyzer.command") end

	cmd_help_message: STRING_32
		do Result := translation_in_context ("Code Analyzer performs static analyses on the source code and %
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
