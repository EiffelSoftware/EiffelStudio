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

	translation_namespace: STRING = "code_analyzer"
			-- A namespace used for translations.

	tool_description: STRING_32
		do Result := translation_in_context ("Performs a static code analysis based on a rule set %
			%and the current code analysis preferences.", once "code_analyzer") end

feature -- Rules

	self_assignment_title: STRING_32
		do Result := translation_in_context ("Self-assignment", once "code_analyzer") end

	self_assignment_description: STRING_32
		do Result := translation_in_context ("Assigning a variable to itself is a meaningless instruction%
			               % due to a typing error. Most probably, one of the two%
			               % variable names was misspelled. One example among many%
			               % others: the programmer wanted to assign a local variable%
			               % to a class attribute and used one of the variable names twice.", once "code_analyzer") end

	unused_argument_title: STRING_32
		do Result := translation_in_context ("Unused argument", once "code_analyzer") end

	unused_argument_description: STRING_32
		do Result := translation_in_context ("A feature should only have arguments which are actually %
			           %needed and used in the computation.", once "code_analyzer") end

	unused_argument_fix: STRING_32
		do Result := translation_in_context ("Remove unused argument ", once "code_analyzer") end

	npath_title: STRING_32
		do Result := translation_in_context ("High NPath", once "code_analyzer") end

	npath_description: STRING_32
		do Result := translation_in_context ("NPath is the number of acyclic execution%
			% paths through a routine. A routine's NPath complexity should not be too%
			% high. In order to reduce the NPath complexity one can move some %
			%functionality to separate routines.", once "code_analyzer") end

	npath_threshold_option: STRING_32
		do Result := translation_in_context ("Minimum NPath threshold", once "code_analyzer") end

	empty_if_title: STRING_32
		do Result := translation_in_context ("Empty if instruction", once "code_analyzer") end

	empty_if_description: STRING_32
		do Result := translation_in_context ("An empty conditional instruction is useless and should be removed.", once "code_analyzer") end

	variable_not_read_title: STRING_32
		do Result := translation_in_context ("Variable not read after assignment", once "code_analyzer") end

	variable_not_read_description: STRING_32
		do Result := translation_in_context ("An assignment to a local variable has no %
			%effect at all if the variable is not read after the assignment, and %
			%before it is reassigned or out of scope. This rule is only checked on %
			%variables of expanded types.", once "code_analyzer") end

	feature_never_called_title: STRING_32
		do Result := translation_in_context ("Feature never called", once "code_analyzer") end

	feature_never_called_description: STRING_32
		do Result := translation_in_context ("There is no use for a feature that is %
			%never called by any class (including the one where it is defined).", once "code_analyzer") end

	feature_never_called_fix: STRING_32
		do Result := translation_in_context ("Remove feature '", once "code_analyzer") end

	cq_separation_title: STRING_32
		do Result := translation_in_context ("No command-query separation (possible function side effect)", once "code_analyzer") end

	cq_separation_description: STRING_32
		do Result := translation_in_context ("To the client of a class it is not %
			%important whether a query is implemented as an attribute or as a %
			%function. When a class evolves an attribute may be changed into a %
			%function, for example. A function should never change the state of%
			% an object. A function containing a procedure call, assigning to an %
			%attribute, or creating an attribute is a strong indication that this %
			%principle is violated. This rule applies exactly in these three %
			%last-mentioned cases. There are rather exceptional but sometimes useful%
			% class designs in which the externally visible state of an object (i. e.%
			% the values of exported queries) does not change even though the function%
			% contains a rule-violating instruction.", once "code_analyzer") end

	unneeded_ot_local_title: STRING_32
		do Result := translation_in_context ("Unneeded object test local", once "code_analyzer") end

	unneeded_ot_local_description: STRING_32
		do Result := translation_in_context ("For local variables, feature arguments, %
			%and object test locals it is unnecessary to let the attached keyword %
			%create a new and safe local reference.", once "code_analyzer") end

	unneeded_ot_local_fix: STRING_32
		do Result := translation_in_context ("Remove object test local '", once "code_analyzer") end

	unneeded_object_test_title: STRING_32
		do Result := translation_in_context ("Object test typing not needed", once "code_analyzer") end

	unneeded_object_test_description: STRING_32
		do Result := translation_in_context ("An object test is redundant if the static %
			%type of the tested variable is the same as the type (in curly braces) %
			%that the variable is tested for.", once "code_analyzer") end

	nested_complexity_title: STRING_32
		do Result := translation_in_context ("High complexity of nested branches and loops", once "code_analyzer") end

	nested_complexity_description: STRING_32
		do Result := translation_in_context ("With the number of nested braches or loops %
			%increasing the code get less readable. If the branch and loop complexity %
			%is too high then the code should be refactored in such a way as to reduce%
			% its complexity.", once "code_analyzer") end

	nested_complexity_threshold_option: STRING_32
		do Result := translation_in_context ("Minimum nested branches and loops threshold", once "code_analyzer") end

	many_arguments_title: STRING_32
		do Result := translation_in_context ("Many feature arguments", once "code_analyzer") end

	many_arguments_description: STRING_32
		do Result := translation_in_context ("A feature that has many arguments should be%
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
			% an option is not called then the class assumes the default value for this option.", once "code_analyzer") end

	arguments_threshold_option: STRING_32
		do Result := translation_in_context ("Minimum arguments threshold", once "code_analyzer") end

	creation_proc_exported_title: STRING_32
		do Result := translation_in_context ("Creation procedure is exported", once "code_analyzer") end

	creation_proc_exported_description: STRING_32
		do Result := translation_in_context ("If the creation procedure is exported then%
			% it may still be called by clients after the object has been created.%
			% Ususally, this is not intended and ought to be changed. A client might,%
			% for example, by accident call 'x.make' instead of 'create x.make',%
			% causing the class invariant or postconditions of make not to hold anymore.", once "code_analyzer") end

	semicolon_arguments_title: STRING_32
		do Result := translation_in_context ("Semicolon to separate arguments", once "code_analyzer") end

	semicolon_arguments_description: STRING_32
		do Result := translation_in_context ("Routine arguments should be separated with%
			% semicolons. Although this is optional, it is bad style not to put semicolons.", once "code_analyzer") end

	very_long_routine_title: STRING_32
		do Result := translation_in_context ("Very long routine implementation", once "code_analyzer") end

	very_long_routine_description: STRING_32
		do Result := translation_in_context ("A routine implementation that contains%
			% many instructions should be shortened. It might contain %
			%copy-and-pasted code, or computations that are not part of what the %
			%feature should do, or computation that can be moved to separate routines.", once "code_analyzer") end

	very_long_routine_threshold_option: STRING_32
		do Result := translation_in_context ("Number of instructions threshold", once "code_analyzer") end

	very_big_class_title: STRING_32
		do Result := translation_in_context ("Very big class", once "code_analyzer") end

	very_big_class_description: STRING_32
		do Result := translation_in_context ("A class declaration that is very large%
			% (that is not including inherited features) may be problematic. The%
			% class might provide features it is not responsible for.", once "code_analyzer") end

	very_big_class_features_threshold_option: STRING_32
		do Result := translation_in_context ("Number of features limit", once "code_analyzer") end

	very_big_class_instructions_threshold_option: STRING_32
		do Result := translation_in_context ("Number of instructions limit", once "code_analyzer") end

	feature_section_comment_title: STRING_32
		do Result := translation_in_context ("Feature section not commented", once "code_analyzer") end

	feature_section_comment_description: STRING_32
		do Result := translation_in_context ("A feature section should have a comment.%
			% This comment serves as caption and is used for example by the 'Features' panel.", once "code_analyzer") end

	feature_not_commented_title: STRING_32
		do Result := translation_in_context ("Feature not commented", once "code_analyzer") end

	feature_not_commented_description: STRING_32
		do Result := translation_in_context ("A feature should have a comment. Feature %
			%comments are particularly helpful for writing clients of this class. To%
			% the programmer, feature comments will appear as tooltip documentation.", once "code_analyzer") end

	boolean_result_title: STRING_32
		do Result := translation_in_context ("Boolean result can be returned directly", once "code_analyzer") end

	boolean_result_description: STRING_32
		do Result := translation_in_context ("For a boolean result there is no need for%
			% an If/Else clause with Result := True and and Result := False, %
			%respectively. One can directly assign the If condition (or its %
			%negation) to the result.", once "code_analyzer") end

	boolean_comparison_title: STRING_32
		do Result := translation_in_context ("Unneeded comparison of boolean variables or queries", once "code_analyzer") end

	boolean_comparison_description: STRING_32
		do Result := translation_in_context ("In expressions, boolean variables or %
			%queries need not be compared to True or False.", once "code_analyzer") end

	very_short_identifier_title: STRING_32
		do Result := translation_in_context ("Very short identifier", once "code_analyzer") end

	very_short_identifier_description: STRING_32
		do Result := translation_in_context ("A name of a feature, an argument, or a %
			%local variable that is very short is bad for code readability.", once "code_analyzer") end

	-- Options for {CA_VERY_SHORT_IDENTIFIER_RULE}:

	min_feature_name_length_option: STRING_32
		do Result := translation_in_context ("Minimum feature name length", once "code_analyzer") end

	min_argument_name_length_option: STRING_32
		do Result := translation_in_context ("Minimum argument name length", once "code_analyzer") end

	min_local_name_length_option: STRING_32
		do Result := translation_in_context ("Minimum local name length", once "code_analyzer") end

	count_argument_prefix_option: STRING_32
		do Result := translation_in_context ("Count argument prefix %"a_%"", once "code_analyzer") end

	count_local_prefix_option: STRING_32
		do Result := translation_in_context ("Count local prefix %"l_%"", once "code_analyzer") end


	very_long_identifier_title: STRING_32
		do Result := translation_in_context ("Very long identifier", once "code_analyzer") end

	very_long_identifier_description: STRING_32
		do Result := translation_in_context ("A name of a feature, an argument, or a %
			%local variable that is very long is bad for code readability.", once "code_analyzer") end

	-- Options for {CA_VERY_LONG_IDENTIFIER_RULE}:	

	max_feature_name_length_option: STRING_32
		do Result := translation_in_context ("Maximum feature name length", once "code_analyzer") end

	max_argument_name_length_option: STRING_32
		do Result := translation_in_context ("Maximum argument name length", once "code_analyzer") end

	max_local_name_length_option: STRING_32
		do Result := translation_in_context ("Maximum local name length", once "code_analyzer") end

	missing_is_equal_title: STRING_32
		do Result := translation_in_context ("Missing 'is_equal' redefinition", once "code_analyzer") end

	missing_is_equal_description: STRING_32
		do Result := translation_in_context ("The class defines '{HASHABLE}.hash_code',%
			% but does not redefine 'is_equal'. 'is_equal' may need to be redefined.", once "code_analyzer") end

	simplifiable_boolean_title: STRING_32
		do Result := translation_in_context ("Simplifiable boolean expression", once "code_analyzer") end

	simplifiable_boolean_description: STRING_32
		do Result := translation_in_context ("Some negated boolean expressions can be%
			% simplified using the inverse comparison operator.", once "code_analyzer") end

	self_comparison_title: STRING_32
		do Result := translation_in_context ("Self-comparison", once "code_analyzer") end

	self_comparison_description: STRING_32
		do Result := translation_in_context ("An expression comparing a variable to %
			%itself always evaluates to the same boolean value. The comparison is %
			%thus redundant. In an Until expression it may lead to non-termination. %
			%Usually it is a typing error.", once "code_analyzer") end

	todo_title: STRING_32
		do Result := translation_in_context ("TODO", once "code_analyzer") end

	todo_description: STRING_32
		do Result := translation_in_context ("A comment line starting with the string %
			%'TODO' or 'To do' means remaining work to be done.", once "code_analyzer") end

	wrong_loop_iteration_title: STRING_32
		do Result := translation_in_context ("Wrong loop iteration", once "code_analyzer") end

	wrong_loop_iteration_description: STRING_32
		do Result := translation_in_context ("Often, from-until loops use an integer %
			%variable for iteration. Initialization, stop condition and the loop %
			%body follow a simple scheme. A loop following this scheme but violating%
			% it at some point is an indication for an error.", once "code_analyzer") end

	inspect_instructions_title: STRING_32
		do Result := translation_in_context ("Many instructions in an Inspect case", once "code_analyzer") end

	inspect_instructions_description: STRING_32
		do Result := translation_in_context ("A case of an inspect construct %
			%containing many instructions decreases code readability. The number%
			% of instructions should be lowered, for example by moving functionality %
			%to separate features.", once "code_analyzer") end

	inspect_instructions_max_instructions_option: STRING_32
		do Result := translation_in_context ("Maximum number of instructions per inspect case", once "code_analyzer") end

	count_equals_zero_title: STRING_32
		do Result := translation_in_context ("Number of elements of a structure is compared to zero", once "code_analyzer") end

	count_equals_zero_description: STRING_32
		do Result := translation_in_context ("In a data structure, comparing the number%
			% of elements to zero can be transformed into the boolean query 'is_empty'.", once "code_analyzer") end

	attribute_to_local_title: STRING_32
		do Result := translation_in_context ("Attribute is only used inside a single routine", once "code_analyzer") end

	attribute_to_local_description: STRING_32
		do Result := translation_in_context ("An attribute that is only used inside a %
			%single routine of the class where it is defined (and that is not read %
			%by any other class) can be transformed into a local variable.", once "code_analyzer") end

	empty_effective_routine_title: STRING_32
		do Result := translation_in_context ("Empty routine in deferred class", once "code_analyzer") end

	empty_effective_routine_description: STRING_32
		do Result := translation_in_context ("A routine with an empty body in a deferred%
			% class should be considered to be declared as deferred. That way it will%
			% not be forgotten to implement the routine in the descendant classes and %
			%errors can be avoided.", once "code_analyzer") end

	if_else_not_equal_title: STRING_32
		do Result := translation_in_context ("Avoid 'not equal' in If-Else instructions", once "code_analyzer") end

	if_else_not_equal_description: STRING_32
		do Result := translation_in_context ("Having an If-Else instruction with a %
			%condition that checks for inequality is not optimal for readability. %
			%Instead an equality comparison should be made. Refactoring by negating %
			%the condition and by switching the instructions solves this issue.", once "code_analyzer") end

	short_circuit_if_title: STRING_32
		do Result := translation_in_context ("Two if instructions can be combined using%
			% short-circuit operator", once "code_analyzer") end

	short_circuit_if_description: STRING_32
		do Result := translation_in_context ("Two nested if instructions, where the %
			%inner one does not have an else clause, should be combined into a single%
			% if instruction using the short circuit 'and then' operator.", once "code_analyzer") end

	iterable_loop_title: STRING_32
		do Result := translation_in_context ("From-until loop on ITERABLE can be reduced to across loop", once "code_analyzer") end

	iterable_loop_description: STRING_32
		do Result := translation_in_context ("A from-until loop iterating through an %
			%{ITERABLE} data structure from beginning to end can be transformed into %
			%a (more recommendable) across loop.", once "code_analyzer") end

	deeply_nested_if_title: STRING_32
		do Result := translation_in_context ("Deeply nested If instructions", once "code_analyzer") end

	deeply_nested_if_description: STRING_32
		do Result := translation_in_context ("Deeply nested If instructions make the code%
			% less readable. They should be avoided; one can refactor the affected %
			%code by changing the decision logic or by introducing separate routines.", once "code_analyzer") end

	deeply_nested_if_threshold_option: STRING_32
		do Result := translation_in_context ("Depth threshold", once "code_analyzer") end

	unneeded_helper_variable_title: STRING_32
		do Result := translation_in_context ("Unneeded helper variable", once "code_analyzer") end

	unneeded_helper_variable_description: STRING_32
		do Result := translation_in_context ("A variable that is assigned a value only %
			%once and is then used only once can be replaced with the expression %
			%that computes this value. This applies as long as the line where the %
			%expression is inserted will not have too many characters.", once "code_analyzer") end

	max_line_length_option: STRING_32
		do Result := translation_in_context ("Maximum line length", once "code_analyzer") end

	unneeded_parentheses_title: STRING_32
		do Result := translation_in_context ("Unneeded parentheses", once "code_analyzer") end

	unneeded_parentheses_description: STRING_32
		do Result := translation_in_context ("Parentheses that are not needed should be %
			%removed. This helps enforcing a consistent coding style.", once "code_analyzer") end

feature -- Preferences

	preference_translation_namespace: STRING = "code_analysis.preference"
			-- A namespace used for translations.

	preferences_window_title: STRING_32
		do Result := translation_in_context ("Eiffel Inspector Preferences", once "code_analysis.preference") end

feature -- GUI

	analyze_system: STRING_32
		do Result := translation_in_context ("Analyze System", once "code_analyzer.toolbar.item") end

	analyze_system_tooltip: STRING_32
		do Result := translation_in_context ("Analyze whole system.", once "code_analyzer.toolbar.item.tooltip") end

	analyze_item: STRING_32
		do Result := translation_in_context ("Analyze Item", once "code_analyzer.toolbar.item") end

	analyze_item_tooltip: STRING_32
		do Result := translation_in_context ("Click to analyze the current item. Drop a stone to analyze any class, cluster, or configuration group.", once "code_analyzer.toolbar.item.tooltip") end

	tool_errors (n: INTEGER_32): STRING_32
			-- Label of an error selector for `n' messages.
		do Result := plural_translation_in_context (once "$1 Error", once "$1 Errors", once "code_analyzer.toolbar.selector", n) end

	tool_warnings (n: INTEGER_32): STRING_32
			-- Label of an warning selector for `n' messages.
		do Result := plural_translation_in_context (once "$1 Warning", once "$1 Warnings", once "code_analyzer.toolbar.selector", n) end

	tool_suggestions (n: INTEGER_32): STRING_32
			-- Label of an suggestion selector for `n' messages.
		do Result := plural_translation_in_context (once "$1 Suggestion", once "$1 Suggestions", once "code_analyzer.toolbar.selector", n) end

	tool_hints (n: INTEGER_32): STRING_32
			-- Label of an hint selector for `n' messages.
		do Result := plural_translation_in_context (once "$1 Hint", once "$1 Hints", once "code_analyzer.toolbar.selector", n) end

	tool_text_filter: STRING_32
		do Result := translation_in_context ("Filter: ", once "code_analyzer.toolbar.item") end

	analysis_not_run: STRING_32
		do Result := translation_in_context ("(Eiffel Inspector has not run yet.)", once "code_analyzer.toolbar.item") end

	go_to_previous_tooltip: STRING_32
		do Result := translation_in_context ("Go to previous rule violation", once "code_analyzer.toolbar.item.tooltip") end

	go_to_next_tooltip: STRING_32
		do Result := translation_in_context ("Go to next rule violation", once "code_analyzer.toolbar.item.tooltip") end

	options_tooltip: STRING_32
		do Result := translation_in_context ("Eiffel Inspector options", once "code_analyzer.toolbar.item.tooltip") end

	description_column: STRING_32
		do Result := translation_in_context ("Description", once "code_analyzer.column") end

	class_column: STRING_32
		do Result := translation_in_context ("Class", once "code_analyzer.column") end

	location_column: STRING_32
		do Result := translation_in_context ("Location", once "code_analyzer.column") end

	rule_id_column: STRING_32
		do Result := translation_in_context ("Rule ID", once "code_analyzer.column") end

	severity_score_column: STRING_32
		do Result := translation_in_context ("Severity Score", once "code_analyzer.column") end

feature -- GUI: Show Preferences Command

	pref_menu_name: STRING_32
		do Result := translation_in_context ("Eiffel Inspector Preferences...", once "code_analyzer") end

	pref_tooltext: STRING_32
		do Result := translation_in_context ("Preferences", once "code_analyzer.toolbar.item") end

	pref_tooltip: STRING_32
		do Result := translation_in_context ("Show Dialog for Eiffel Inspector Preferences", once "code_analyzer.toolbar.item.tooltip") end

feature {NONE} -- Translation

	translation_in_context (s: READABLE_STRING_GENERAL; context: READABLE_STRING_GENERAL): STRING_32
			-- Translation of `s' in the context `context'.
		do
			Result := locale.translation_in_context (s, context)
		end

	plural_translation_in_context (singular, plural, context: READABLE_STRING_GENERAL; value: INTEGER_32): STRING_32
			-- Translation of `singular' and `plural' in the context `context' with value `value'.
		do
			Result := locale.formatted_string (locale.plural_translation_in_context (singular, plural, context, value), [value])
		end

end
