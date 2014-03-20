note
	description: "Name strings for the Code Analyzer."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CA_NAMES

inherit
	SHARED_LOCALE

feature -- General

	tool_description: STRING_32
		do Result := locale.translation ("Performs a static code analysis based on a rule set %
			%and the current code analysis preferences.") end

feature -- Rules

	self_assignment_title: STRING_32
		do Result := locale.translation ("Self-assignment") end

	self_assignment_description: STRING_32
		do Result := locale.translation ("Assigning a variable to itself is a meaningless instruction%
			               % due to a typing error. Most probably, one of the two%
			               % variable names was misspelled. One example among many%
			               % others: the programmer wanted to assign a local variable%
			               % to a class attribute and used one of the variable names twice.") end

	unused_argument_title: STRING_32
		do Result := locale.translation ("Unused argument") end

	unused_argument_description: STRING_32
		do Result := locale.translation ("A feature should only have arguments which are actually %
			           %needed and used in the computation.") end

	unused_argument_fix: STRING_32
		do Result := locale.translation ("Remove unused argument ") end

	npath_title: STRING_32
		do Result := locale.translation ("High NPATH") end

	npath_description: STRING_32
		do Result := locale.translation ("NPATH is the number of acyclic execution%
			% paths through a routine. A routine's NPATH complexity should not be too%
			% high. In order to reduce the NPATH complexity one can move some %
			%functionality to separate routines.") end

	npath_threshold_option: STRING_32
		do Result := locale.translation ("Minimum NPATH threshold") end

	empty_if_title: STRING_32
		do Result := locale.translation ("Empty if instruction") end

	empty_if_description: STRING_32
		do Result := locale.translation ("An empty conditional instruction is useless and should be removed.") end

	variable_not_read_title: STRING_32
		do Result := locale.translation ("Variable not read after assignment") end

	variable_not_read_description: STRING_32
		do Result := locale.translation ("An assignment to a local variable has no %
			%effect at all if the variable is not read after the assignment, and %
			%before it is reassigned or out of scope. This rule is only checked on %
			%variables of expanded types.") end

	feature_never_called_title: STRING_32
		do Result := locale.translation ("Feature never called") end

	feature_never_called_description: STRING_32
		do Result := locale.translation ("There is no use for a feature that is %
			%never called by any class (including the one where it is defined).") end

	feature_never_called_fix: STRING_32
		do Result := locale.translation ("Remove feature '") end

	cq_separation_title: STRING_32
		do Result := locale.translation ("No command-query separation (possible function side effect)") end

	cq_separation_description: STRING_32
		do Result := locale.translation ("To the client of a class it is not %
			%important whether a query is implemented as an attribute or as a %
			%function. When a class evolves an attribute may be changed into a %
			%function, for example. A function should never change the state of%
			% an object. A function containing a procedure call, assigning to an %
			%attribute, or creating an attribute is a strong indication that this %
			%principle is violated. This rule applies exactly in these three %
			%last-mentioned cases. There are rather exceptional but sometimes useful%
			% class designs in which the externally visible state of an object (i. e.%
			% the values of exported queries) does not change even though the function%
			% contains a rule-violating instruction.") end

	unneeded_ot_local_title: STRING_32
		do Result := locale.translation ("Unneeded object test local") end

	unneeded_ot_local_description: STRING_32
		do Result := locale.translation ("For local variables, feature arguments, %
			%and object test locals it is unnecessary to let the attached keyword %
			%create a new and safe local reference.") end

	unneeded_ot_local_fix: STRING_32
		do Result := locale.translation ("Remove object test local '") end

	unneeded_object_test_title: STRING_32
		do Result := locale.translation ("Object test typing not needed") end

	unneeded_object_test_description: STRING_32
		do Result := locale.translation ("An object test is redundant if the static %
			%type of the tested variable is the same as the type (in curly braces) %
			%that the variable is tested for.") end

	nested_complexity_title: STRING_32
		do Result := locale.translation ("High complexity of nested branches and loops") end

	nested_complexity_description: STRING_32
		do Result := locale.translation ("With the number of nested braches or loops %
			%increasing the code get less readable. If the branch and loop complexity %
			%is too high then the code should be refactored in such a way as to reduce%
			% its complexity.") end

	nested_complexity_threshold_option: STRING_32
		do Result := locale.translation ("Minimum nested branches and loops threshold") end

	many_arguments_title: STRING_32
		do Result := locale.translation ("Many feature arguments") end

	many_arguments_description: STRING_32
		do Result := locale.translation ("A feature that has many arguments should be%
			% avoided since it makes the class interface complicated and it is not%
			% easy to use. The feature arguments may include options, which should be%
			% considered to be moved to separate features. Interfaces of features with%
			% a large number of arguments are complicated, in the sense for example%
			% that they are hard to remember for the programmer. Often many arguments%
			% are of the same type (such as INTEGER). So, in a call, the passed%
			% arguments are likely to get mixed up, too, without the compiler detecting%
			% it. Arguments where in most of the cases the same value is passed--the%
			% default value--are called options. As opposed to operands, which are%
			% necessary in each feature call, each option should be moved to a separate%
			% feature. The features for options can then be called before the operational%
			% feature call in order to set (or unset) certain options. If a feature for%
			% an option is not called then the class assumes the default value for this option.") end

	arguments_threshold_option: STRING_32
		do Result := locale.translation ("Minimum arguments threshold") end

	creation_proc_exported_title: STRING_32
		do Result := locale.translation ("Creation procedure is exported") end

	creation_proc_exported_description: STRING_32
		do Result := locale.translation ("If the creation procedure is exported then%
			% it may still be called by clients after the object has been created.%
			% Ususally, this is not intended and ought to be changed. A client might,%
			% for example, by accident call 'x.make' instead of 'create x.make',%
			% causing the class invariant or postconditions of make not to hold anymore.") end

	semicolon_arguments_title: STRING_32
		do Result := locale.translation ("Semicolon to separate arguments") end

	semicolon_arguments_description: STRING_32
		do Result := locale.translation ("Routine arguments should be separated with%
			% semicolons. Although this is optional, it is bad style not to put semicolons.") end

	very_long_routine_title: STRING_32
		do Result := locale.translation ("Very long routine implementation") end

	very_long_routine_description: STRING_32
		do Result := locale.translation ("A routine implementation that contains%
			% many instructions should be shortened. It might contain %
			%copy-and-pasted code, or computations that are not part of what the %
			%feature should do, or computation that can be moved to separate routines.") end

	very_long_routine_threshold_option: STRING_32
		do Result := locale.translation ("Number of instructions threshold") end

	very_big_class_title: STRING_32
		do Result := locale.translation ("Very big class") end

	very_big_class_description: STRING_32
		do Result := locale.translation ("A class declaration that is very large%
			% (that is not including inherited features) may be problematic. The%
			% class might provide features it is not responsible for.") end

	very_big_class_features_threshold_option: STRING_32
		do Result := locale.translation ("Number of features limit") end

	very_big_class_instructions_threshold_option: STRING_32
		do Result := locale.translation ("Number of instructions limit") end

	feature_section_comment_title: STRING_32
		do Result := locale.translation ("Feature section not commented") end

	feature_section_comment_description: STRING_32
		do Result := locale.translation ("A feature section should have a comment.%
			% This comment serves as caption and is used for example by the 'Features' panel.") end

	feature_not_commented_title: STRING_32
		do Result := locale.translation ("Feature not commented") end

	feature_not_commented_description: STRING_32
		do Result := locale.translation ("A feature should have a comment. Feature %
			%comments are particularly helpful for writing clients of this class. To%
			% the programmer, feature comments will appear as tooltip documentation.") end

	boolean_result_title: STRING_32
		do Result := locale.translation ("Boolean result can be returned directly") end

	boolean_result_description: STRING_32
		do Result := locale.translation ("For a boolean result there is no need for%
			% an If/Else clause with Result := True and and Result := False, %
			%respectively. One can directly assign the If condition (or its %
			%negation) to the result.") end

	boolean_comparison_title: STRING_32
		do Result := locale.translation ("Unneeded comparison of boolean variables or queries") end

	boolean_comparison_description: STRING_32
		do Result := locale.translation ("In expressions, boolean variables or %
			%queries need not be compared to True or False.") end

	very_short_identifier_title: STRING_32
		do Result := locale.translation ("Very short identifier") end

	very_short_identifier_description: STRING_32
		do Result := locale.translation ("A name of a feature, an argument, or a %
			%local variable that is very short is bad for code readability.") end

	-- Options for {CA_VERY_SHORT_IDENTIFIER_RULE}:

	min_feature_name_length_option: STRING_32
		do Result := locale.translation ("Minimum feature name length") end

	min_argument_name_length_option: STRING_32
		do Result := locale.translation ("Minimum argument name length") end

	min_local_name_length_option: STRING_32
		do Result := locale.translation ("Minimum local name length") end

	count_argument_prefix_option: STRING_32
		do Result := locale.translation ("Count argument prefix %"a_%"") end

	count_local_prefix_option: STRING_32
		do Result := locale.translation ("Count local prefix %"l_%"") end


	very_long_identifier_title: STRING_32
		do Result := locale.translation ("Very long identifier") end

	very_long_identifier_description: STRING_32
		do Result := locale.translation ("A name of a feature, an argument, or a %
			%local variable that is very long is bad for code readability.") end

	-- Options for {CA_VERY_LONG_IDENTIFIER_RULE}:	

	max_feature_name_length_option: STRING_32
		do Result := locale.translation ("Maximum feature name length") end

	max_argument_name_length_option: STRING_32
		do Result := locale.translation ("Maximum argument name length") end

	max_local_name_length_option: STRING_32
		do Result := locale.translation ("Maximum local name length") end

	missing_is_equal_title: STRING_32
		do Result := locale.translation ("Missing 'is_equal' redefinition") end

	missing_is_equal_description: STRING_32
		do Result := locale.translation ("The class defines '{HASHABLE}.hash_code',%
			% but does not redefine 'is_equal'. 'is_equal' may need to be redefined.") end

	simplifiable_boolean_title: STRING_32
		do Result := locale.translation ("Simplifiable boolean expression") end

	simplifiable_boolean_description: STRING_32
		do Result := locale.translation ("Some negated boolean expressions can be%
			% simplified using the inverse comparison operator.") end

	self_comparison_title: STRING_32
		do Result := locale.translation ("Self-comparison") end

	self_comparison_description: STRING_32
		do Result := locale.translation ("An expression comparing a variable to %
			%itself always evaluates to the same boolean value. The comparison is %
			%thus redundant. In an Until expression it may lead to non-termination. %
			%Usually it is a typing error.") end

	todo_title: STRING_32
		do Result := locale.translation ("TODO") end

	todo_description: STRING_32
		do Result := locale.translation ("A comment line starting with the string %
			%'TODO' or 'To do' means remaining work to be done.") end

	wrong_loop_iteration_title: STRING_32
		do Result := locale.translation ("Wrong loop iteration") end

	wrong_loop_iteration_description: STRING_32
		do Result := locale.translation ("Often, from-until loops use an integer %
			%variable for iteration. Initialization, stop condition and the loop %
			%body follow a simple scheme. A loop following this scheme but violating%
			% it at some point is an indication for an error.") end

	inspect_instructions_title: STRING_32
		do Result := locale.translation ("Many instructions in an Inspect case") end

	inspect_instructions_description: STRING_32
		do Result := locale.translation ("A case of an inspect construct %
			%containing many instructions decreases code readability. The number%
			% of instructions should be lowered, for example by moving functionality %
			%to separate features.") end

	inspect_instructions_max_instructions_option: STRING_32
		do Result := locale.translation ("Maximum number of instructions per inspect case.") end

	count_equals_zero_title: STRING_32
		do Result := locale.translation ("Number of elements of a structure is compared to zero") end

	count_equals_zero_description: STRING_32
		do Result := locale.translation ("In a data structure, comparing the number%
			% of elements to zero can be transformed into the boolean query 'is_empty'.") end

	attribute_to_local_title: STRING_32
		do Result := locale.translation ("Attribute is only used inside a single routine") end

	attribute_to_local_description: STRING_32
		do Result := locale.translation ("An attribute that is only used inside a %
			%single routine of the class where it is defined (and that is not read %
			%by any other class) can be transformed into a local variable.") end

	empty_effective_routine_title: STRING_32
		do Result := locale.translation ("Empty routine in deferred class") end

	empty_effective_routine_description: STRING_32
		do Result := locale.translation ("A routine with an empty body in a deferred%
			% class should be considered to be declared as deferred. That way it will%
			% not be forgotten to implement the routine in the descendant classes and %
			%errors can be avoided.") end

	if_else_not_equal_title: STRING_32
		do Result := locale.translation ("Avoid 'not equal' in If-Else instructions") end

	if_else_not_equal_description: STRING_32
		do Result := locale.translation ("Having an If-Else instruction with a %
			%condition that checks for inequality is not optimal for readability. %
			%Instead an equality comparison should be made. Refactoring by negating %
			%the condition and by switching the instructions solves this issue.") end

	short_circuit_if_title: STRING_32
		do Result := locale.translation ("Two if instructions can be combined using%
			% short-circuit operator") end

	short_circuit_if_description: STRING_32
		do Result := locale.translation ("Two nested if instructions, where the %
			%inner one does not have an else clause, should be combined into a single%
			% if instruction using the short circuit 'and then' operator.") end

	iterable_loop_title: STRING_32
		do Result := locale.translation ("From-until loop on ITERABLE can be reduced to across loop") end

	iterable_loop_description: STRING_32
		do Result := locale.translation ("A from-until loop iterating through an %
			%{ITERABLE} data structure from beginning to end can be transformed into %
			%a (more recommendable) across loop.") end

	deeply_nested_if_title: STRING_32
		do Result := locale.translation ("Deeply nested If instructions") end

	deeply_nested_if_description: STRING_32
		do Result := locale.translation ("Deeply nested If instructions make the code%
			% less readable. They should be avoided; one can refactor the affected %
			%code by changing the decision logic or by introducing separate routines.") end

	deeply_nested_if_threshold_option: STRING_32
		do Result := locale.translation ("Depth threshold") end

	unneeded_helper_variable_title: STRING_32
		do Result := locale.translation ("Unneeded helper variable") end

	unneeded_helper_variable_description: STRING_32
		do Result := locale.translation ("A variable that is assigned a value only %
			%once and is then used only once can be replaced with the expression %
			%that computes this value. This applies as long as the line where the %
			%expression is inserted will not have too many characters.") end

	max_line_length_option: STRING_32
		do Result := locale.translation ("Maximum line length") end

	unneeded_parentheses_title: STRING_32
		do Result := locale.translation ("Unneeded parentheses") end

	unneeded_parentheses_description: STRING_32
		do Result := locale.translation ("Parentheses that are not needed should be %
			%removed. This helps enforcing a consistent coding style.") end

feature -- Preferences

	preferences_window_title: STRING_32
		do Result := locale.translation ("Inspector Eiffel Preferences") end

	general_category: STRING_32
		do Result := locale.translation ("General") end

	rules_category: STRING_32
		do Result := locale.translation ("Rules") end

	color_category: STRING_32
		do Result := locale.translation ("Colors") end

	are_errors_enabled: STRING_32
		do Result := locale.translation ("Enable errors") end

	are_warnings_enabled: STRING_32
		do Result := locale.translation ("Enable warnings") end

	are_suggestions_enabled: STRING_32
		do Result := locale.translation ("Enable suggestions") end

	are_hints_enabled: STRING_32
		do Result := locale.translation ("Enable hints") end

	enable_rule: STRING_32
		do Result := locale.translation ("Enable rule") end

	severity_score: STRING_32
		do Result := locale.translation ("Importance score") end

	error_bgcolor: STRING_32
		do Result := locale.translation ("Error background color") end

	warning_bgcolor: STRING_32
		do Result := locale.translation ("Warning background color") end

	suggestion_bgcolor: STRING_32
		do Result := locale.translation ("Suggestion background color") end

	hint_bgcolor: STRING_32
		do Result := locale.translation ("Hint background color") end

	fixed_violation_bgcolor: STRING_32
		do Result := locale.translation ("Fixed violation background color") end

feature -- GUI

	analyze_item: STRING_32
		do Result := locale.translation ("Analyze Item") end

	analyze_item_tooltip: STRING_32
		do Result := locale.translation ("Click to analyze the current item. Drop a stone to analyze any class, cluster, or configuration group.") end

	analyze_system: STRING_32
		do Result := locale.translation ("Analyze System") end

	analyze_system_tooltip: STRING_32
		do Result := locale.translation ("Analyze whole system.") end

	tool_errors: STRING_32
		do Result := locale.translation ("Errors") end

	tool_warnings: STRING_32
		do Result := locale.translation ("Warnings") end

	tool_suggestions: STRING_32
		do Result := locale.translation ("Suggestions") end

	tool_hints: STRING_32
		do Result := locale.translation ("Hints") end

	tool_text_filter: STRING_32
		do Result := locale.translation ("Filter: ") end

	scope: STRING_32
		do Result := locale.translation ("Scope: ") end

	scope_tooltip: STRING_32
		do Result := locale.translation ("Scope of Last Analysis") end

	analysis_not_run: STRING_32
		do Result := locale.translation ("(Inspector Eiffel has not run yet.)") end

	go_to_previous_tooltip: STRING_32
		do Result := locale.translation ("Go to previous rule violation") end

	go_to_next_tooltip: STRING_32
		do Result := locale.translation ("Go to next rule violation") end

	options_tooltip: STRING_32
		do Result := locale.translation ("Inspector Eiffel options") end

	description_column: STRING_32
		do Result := locale.translation ("Description") end

	class_column: STRING_32
		do Result := locale.translation ("Class") end

	location_column: STRING_32
		do Result := locale.translation ("Location") end

	rule_id_column: STRING_32
		do Result := locale.translation ("Rule ID") end

	severity_score_column: STRING_32
		do Result := locale.translation ("Severity Score") end

feature -- GUI: Show Preferences Command

	pref_menu_name: STRING_32
		do Result := locale.translation ("Inspector Eiffel Preferences...") end

	pref_tooltext: STRING_32
		do Result := locale.translation ("Preferences") end

	pref_tooltip: STRING_32
		do Result := locale.translation ("Show Dialog for Inspector Eiffel Preferences") end

end
