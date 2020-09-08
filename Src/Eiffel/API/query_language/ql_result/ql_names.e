note
	description: "Name constants used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Predefined metrics configuration", "src=https://svn.eiffel.com/eiffelstudio/trunk/Src/Delivery/studio/metrics/predefined_metrics.xml", "tag=Metrics"

class
	QL_NAMES

feature -- Scope item

	ql_target: STRING = "target"
	ql_group: STRING = "group"
	ql_class: STRING = "class"
	ql_feature: STRING = "feature"
	ql_invariant: STRING = "invariant"
	ql_quantity: STRING = "quantity"
	ql_line: STRING = "line"
	ql_local: STRING = "local"
	ql_assertion: STRING = "assertion"
	ql_argument: STRING = "argument"
	ql_generic: STRING = "generic"

feature -- Units

	ql_target_unit: STRING = "target"
	ql_group_unit: STRING = "group"
	ql_class_unit: STRING = "class"
	ql_feature_unit: STRING = "feature"
	ql_compilation_unit: STRING = "compilation"
	ql_local_unit: STRING = "local"
	ql_argument_unit: STRING = "argument"
	ql_ratio_unit: STRING = "ratio"
	ql_line_unit: STRING = "line"
	ql_assertion_unit: STRING = "assertion"
	ql_no_unit: STRING = "no unit"
	ql_generic_unit: STRING = "generic"

feature -- Titles

	ql_name: STRING = "name"
	ql_path: STRING = "path"

feature -- Criterion names

	ql_cri_true: STRING = "true"
	ql_cri_false: STRING = "false"
	ql_cri_and: STRING = "and"
	ql_cri_or: STRING = "or"
	ql_cri_not: STRING = "not"
	ql_cri_eq: STRING = "eq"
	ql_cri_ne: STRING = "ne"
	ql_cri_num: STRING = "num"
	ql_cri_is_compiled: STRING = "is_compiled"
	ql_cri_name_is: STRING = "name_is"

	ql_cri_is_assembly: STRING = "is_assembly"
	ql_cri_is_library: STRING = "is_library"
	ql_cri_is_cluster: STRING = "is_cluster"
	ql_cri_is_override: STRING = "is_override"
	ql_cri_is_valid: STRING = "is_valid"
	ql_cri_is_used_in_library: STRING = "is_used_in_library"
	ql_cri_is_class_set: STRING = "is_class_set"

	ql_cri_has_invariant: STRING = "has_immediate_invariant"
	ql_cri_ancestor_is: STRING = "ancestor_is"
	ql_cri_proper_ancestor_is: STRING = "proper_ancestor_is"
	ql_cri_parent_is: STRING = "parent_is"
	ql_cri_indirect_parent_is: STRING = "indirect_parent_is"
	ql_cri_descendant_is: STRING = "descendant_is"
	ql_cri_proper_descendant_is: STRING = "proper_descendant_is"
	ql_cri_heir_is: STRING = "heir_is"
	ql_cri_indirect_heir_is: STRING = "indirect_heir_is"
	ql_cri_client_is: STRING = "client_is"
	ql_cri_supplier_is: STRING = "supplier_is"
	ql_cri_is_deferred: STRING = "is_deferred"
	ql_cri_is_expanded: STRING = "is_expanded"
	ql_cri_is_external: STRING = "is_external"
	ql_cri_is_frozen: STRING = "is_frozen"
	ql_cri_is_generic: STRING = "is_generic"
	ql_cri_is_obsolete: STRING = "is_obsolete"
	ql_cri_is_precompiled: STRING = "is_precompiled"
	ql_cri_has_top_indexing: STRING = "has_top_indexing"
	ql_cri_has_bottom_indexing: STRING = "has_bottom_indexing"
	ql_cri_has_indexing: STRING = "has_indexing"
	ql_cri_is_enum: STRING = "is_enum"
	ql_cri_is_effective: STRING = "is_effective"
	ql_cri_path_in: STRING = "path_in"
	ql_cri_path_is: STRING = "path_is"
	ql_cri_text_contain: STRING = "text_is"
	ql_cri_top_indexing_has_tag: STRING = "top_indexing_has_tag"
	ql_cri_bottom_indexing_has_tag: STRING = "bottom_indexing_has_tag"
	ql_cri_indexing_has_tag: STRING = "indexing_has_tag"
	ql_cri_top_indexing_contain: STRING = "top_indexing_contain"
	ql_cri_bottom_indexing_contain: STRING = "bottom_indexing_contain"
	ql_cri_indexing_contain: STRING = "indexing_contain"
	ql_cri_is_always_compiled: STRING = "is_always_compiled"
	ql_cri_is_partial: STRING = "is_partial"
	ql_cri_is_read_only: STRING = "is_read_only"
	ql_cri_is_overridden: STRING = "is_overridden"
	ql_cri_is_overrider: STRING = "is_overrider"
	ql_cri_is_visible: STRING = "is_visible"
	ql_cri_is_from_any: STRING = "is_from_any"

	ql_cri_has_argument: STRING = "has_argument"
	ql_cri_has_assertion: STRING = "has_assertion"
	ql_cri_has_assigner: STRING = "has_assigner"
	ql_cri_has_comment: STRING = "has_comment"
	ql_cri_has_local: STRING = "has_local"
	ql_cri_has_postcondition: STRING = "has_postcondition"
	ql_cri_has_class_postcondition: STRING = "has_class_postcondition"
	ql_cri_has_precondition: STRING = "has_precondition"
	ql_cri_has_rescue: STRING = "has_rescue"
	ql_cri_is_attribute: STRING = "is_attribute"
	ql_cri_is_caller: STRING = "is_caller_of"
	ql_cri_is_constant: STRING = "is_constant"
	ql_cri_is_function: STRING = "is_function"
	ql_cri_is_immediate: STRING = "is_immediate"
	ql_cri_is_implementor: STRING = "is_implementor_of"
	ql_cri_is_infix: STRING = "is_infix"
	ql_cri_is_once: STRING = "is_once"
	ql_cri_is_class: STRING = "is_class"
	ql_cri_is_ghost: STRING = "is_ghost"
	ql_cri_is_origin: STRING = "is_origin"
	ql_cri_is_prefix: STRING = "is_prefix"
	ql_cri_is_procedure: STRING = "is_procedure"
	ql_cri_is_unique: STRING = "is_unique"
	ql_cri_is_feature: STRING = "is_feature"
	ql_cri_is_invariant: STRING = "is_invariant"
	ql_cri_is_creator: STRING = "is_creator"
	ql_cri_is_exported: STRING = "is_exported"
	ql_cri_is_hidden: STRING = "is_hidden"
	ql_cri_implementors_of: STRING = "is_implementors_of"
	ql_cri_is_exported_to: STRING = "is_exported_to"
	ql_cri_callee_is: STRING = "callee_is"
	ql_cri_caller_is: STRING = "caller_is"
	ql_cri_assignee_is: STRING = "assignee_is"
	ql_cri_assigner_is: STRING = "assigner_is"
	ql_cri_createe_is: STRING = "createe_is"
	ql_cri_creator_is: STRING = "creator_is"
	ql_cri_is_invariant_feature: STRING = "is_invariant_feature"
	ql_cri_is_query: STRING = "is_query"
	ql_cri_is_command: STRING = "is_command"
	ql_cri_return_type_is: STRING = "return_type_is"

	ql_cri_has_constraint: STRING = "has_constraint"
	ql_cri_has_creation_constraint: STRING = "has_creation_constraint"
	ql_cri_is_reference: STRING = "is_reference"

	ql_cri_is_used: STRING = "is_used"

	ql_cri_has_expression: STRING = "has_expression"
	ql_cri_has_tag: STRING = "has_tag"
	ql_cri_is_require: STRING = "is_require"
	ql_cri_is_require_else: STRING = "is_require_else"
	ql_cri_is_ensure: STRING = "is_ensure"
	ql_cri_is_ensure_then: STRING = "is_ensure_then"
	ql_cri_is_precondition: STRING = "is_precondition"
	ql_cri_is_postcondition: STRING = "is_postcondition"

	ql_cri_is_blank: STRING = "is_blank"
	ql_cri_is_comment: STRING = "is_comment"
	ql_cri_contain_ast: STRING = "contain_ast"

	ql_cri_value_of_metric_is: STRING = "value_of_metric_is"
	ql_cri_is_implementation_comment: STRING = "is_implementation_comment"

	ql_cri_is_satisfied_by: STRING = "is_satisfied_by"

feature -- Metric names

	ql_metric_target: STRING = "Number of targets"
	ql_metric_group: STRING = "Number of groups"
	ql_metric_class: STRING = "Number of classes"
	ql_metric_feature: STRING = "Number of features"
	ql_metric_local: STRING = "Number of locals"
	ql_metric_argument: STRING = "Number of arguments"
	ql_metric_line: STRING = "Number of lines"
	ql_metric_compilation: STRING = "Number of compilation"
	ql_metric_assertion: STRING = "Number of assertions"
	ql_metric_sum: STRING = "Sum"
	ql_metric_average: STRING = "Average"
	ql_metric_count: STRING = "Number of items"
	ql_metric_generic: STRING = "Number of generics"

feature -- Assertion type names

	ql_require_assertion: STRING = "require"
	ql_require_else_assertion: STRING = "require else"
	ql_ensure_assertion: STRING = "ensure"
	ql_ensure_then_assertion: STRING = "ensure then"
	ql_invariant_assertion: STRING = "invariant"

feature -- Path marker

	ql_target_path_opener: STRING_32 = ""
	ql_target_path_closer: STRING_32 = ""

	ql_group_path_opener: STRING_32 = ""
	ql_group_path_closer: STRING_32 = ""

	ql_class_path_opener: STRING_32 = "{"
	ql_class_path_closer: STRING_32 = "}"

	ql_feature_path_opener: STRING_32 = ""
	ql_feature_path_closer: STRING_32 = ""

	ql_generic_path_opener: STRING_32 = "["
	ql_generic_path_closer: STRING_32 = "]"

	ql_argument_path_opener: STRING_32 = "argument "
	ql_argument_path_closer: STRING_32 = ""

	ql_local_path_opener: STRING_32 = "local "
	ql_local_path_closer: STRING_32 = ""

	ql_assertion_path_opener: STRING_32 = "assertion "
	ql_assertion_path_closer: STRING_32 = ""

	ql_line_path_opener: STRING_32 = "line "
	ql_line_path_closer: STRING_32 = ""

	ql_quantity_path_opener: STRING_32 = "quantity "
	ql_quantity_path_closer: STRING_32 = ""

feature -- Feature caller types

	ql_normal_feature_caller: STRING = "normal caller"
	ql_assigner_feature_caller: STRING = "assign caller"
	ql_creator_feature_caller: STRING = "creator caller"
	ql_normal_feature_callee: STRING = "normal callee"
	ql_assigner_feature_callee: STRING = "assign callee"
	ql_creator_feature_callee: STRING = "creator callee"

feature -- Class relationship

	ql_class_ancestor_relation: STRING = "ancestor"
	ql_class_proper_ancestor_relation: STRING = "proper ancestor"
	ql_class_descendant_relation: STRING = "descendant"
	ql_class_proper_descendant_relation: STRING = "proper descendant"
	ql_class_parent_relation: STRING = "parent"
	ql_class_indirect_parent_relation: STRING = "indirect parent"
	ql_class_heir_relation: STRING = "heir"
	ql_class_indirect_heir_relation: STRING = "indirect heir"
	ql_class_client_relation: STRING = "client"
	ql_class_indirect_client_relation: STRING = "indirect client"
	ql_class_supplier_relation: STRING = "supplier"
	ql_class_indirect_supplier_relation: STRING = "indirect supplier";

feature -- AST node index

	none_id: INTEGER = 0
	typed_char: INTEGER = 1
	agent_routine_creation: INTEGER = 2
	tilda_routine_creation: INTEGER = 3
	inline_agent_creation: INTEGER = 4
	create_creation: INTEGER = 5
	bang_creation: INTEGER = 6
	create_creation_expr: INTEGER = 7
	bang_creation_expr: INTEGER = 8
	keyword: INTEGER = 9
	symbol: INTEGER = 10
	custom_attribute: INTEGER = 11
	id: INTEGER = 12
	integer: INTEGER = 13
	static_access: INTEGER = 14
	feature_clause: INTEGER = 15
	unique_as: INTEGER = 16
	tuple: INTEGER = 17
	real: INTEGER = 18
	bool: INTEGER = 19
	bit_const: INTEGER = 20
	array: INTEGER = 21
	char: INTEGER = 22
	string: INTEGER = 23
	verbatim_string: INTEGER = 24
	body: INTEGER = 25
	result_as: INTEGER = 26
	current_as: INTEGER = 27
	access_feat: INTEGER = 28
	access_inv: INTEGER = 29
	access_id: INTEGER = 30
	access_assert: INTEGER = 31
	precursor_as: INTEGER = 32
	nested_expr: INTEGER = 33
	nested: INTEGER = 34
	creation_expr: INTEGER = 35
	type_expr: INTEGER = 36
	routine: INTEGER = 37
	constant: INTEGER = 38
	eiffel_list: INTEGER = 39
	indexing_clause: INTEGER = 40
	operand: INTEGER = 41
	tagged: INTEGER = 42
	variant_as: INTEGER = 43
	un_strip: INTEGER = 44
	paran: INTEGER = 45
	expr_call: INTEGER = 46
	expr_address: INTEGER = 47
	address_result: INTEGER = 48
	address_current: INTEGER = 49
	address: INTEGER = 50
	routine_creation: INTEGER = 51
	unary: INTEGER = 52
	un_free: INTEGER = 53
	un_minus: INTEGER = 54
	un_not: INTEGER = 55
	un_old: INTEGER = 56
	un_plus: INTEGER = 57
	binary: INTEGER = 58
	bin_and_then: INTEGER = 59
	bin_free: INTEGER = 60
	bin_implies: INTEGER = 61
	bin_or: INTEGER = 62
	bin_or_else: INTEGER = 63
	bin_xor: INTEGER = 64
	bin_ge: INTEGER = 65
	bin_gt: INTEGER = 66
	bin_le: INTEGER = 67
	bin_lt: INTEGER = 68
	bin_div: INTEGER = 69
	bin_minus: INTEGER = 70
	bin_mod: INTEGER = 71
	bin_plus: INTEGER = 72
	bin_power: INTEGER = 73
	bin_slash: INTEGER = 74
	bin_star: INTEGER = 75
	bin_and: INTEGER = 76
	bin_eq: INTEGER = 77
	bin_ne: INTEGER = 78
	bracket: INTEGER = 79
	external_lang: INTEGER = 80
	feature_as: INTEGER = 81
	infix_prefix: INTEGER = 82
	feat_name_id: INTEGER = 83
	feature_name_alias: INTEGER = 84
	feature_list: INTEGER = 85
	all_as: INTEGER = 86
	assign_as: INTEGER = 87
	assigner_call: INTEGER = 88
	reverse: INTEGER = 89
	check_as: INTEGER = 90
	creation_as: INTEGER = 91
	debug_as: INTEGER = 92
	if_as: INTEGER = 93
	inspect_as: INTEGER = 94
	instr_call: INTEGER = 95
	loop_as: INTEGER = 96
	retry_as: INTEGER = 97
	external_as: INTEGER = 98
	deferred_as: INTEGER = 99
	do_as: INTEGER = 100
	once_as: INTEGER = 101
	type_dec: INTEGER = 102
	class_as: INTEGER = 103
	parent: INTEGER = 104
	like_id: INTEGER = 105
	like_cur: INTEGER = 106
	formal: INTEGER = 107
	formal_dec: INTEGER = 108
	class_type: INTEGER = 109
	named_tuple_type: INTEGER = 110
	none_type: INTEGER = 111
	bits: INTEGER = 112
	bits_symbol: INTEGER = 113
	rename_as: INTEGER = 114
	invariant_as: INTEGER = 115
	interval: INTEGER = 116
	index: INTEGER = 117
	export_item: INTEGER = 118
	elseif_as: INTEGER = 119
	create_as: INTEGER = 120
	client: INTEGER = 121
	case: INTEGER = 122
	ensure_as: INTEGER = 123
	ensure_then: INTEGER = 124
	require_as: INTEGER = 125
	require_else: INTEGER = 126
	convert_feat: INTEGER = 127
	void_as: INTEGER = 128
	type_list: INTEGER = 129
	type_dec_list: INTEGER = 130
	convert_feat_list: INTEGER = 131
	class_list: INTEGER = 132
	parent_list: INTEGER = 133
	local_dec_list: INTEGER = 134
	formal_argu_dec_list: INTEGER = 135
	debug_key_list: INTEGER = 136
	delayed_actual_list: INTEGER = 137
	parameter_list: INTEGER = 138
	rename_clause: INTEGER = 139
	export_clause: INTEGER = 140
	undefine_clause: INTEGER = 141
	redefine_clause: INTEGER = 142
	select_clause: INTEGER = 143
	formal_generic_list: INTEGER = 144
	constraining_type:  INTEGER = 145
	object_test: INTEGER = 146
	bin_tilde: INTEGER = 147
	bin_not_tilde: INTEGER = 148

feature -- AST node match

	ast_index_table: HASH_TABLE [ARRAY [INTEGER], STRING]
			-- Table for AST node indexing
			-- Key is name of an AST node type, value is index of that AST node type.
		once
			create Result.make (150)
			Result.force (<<none_id>>, "none_id")
			Result.force (<<typed_char>>, "typed_char")
			Result.force (<<agent_routine_creation>>, "agent_routine_creation")
			Result.force (<<tilda_routine_creation>>, "tilda_routine_creation")
			Result.force (<<inline_agent_creation>>, "inline_agent_creation")
			Result.force (<<create_creation>>, "create_creation")
			Result.force (<<bang_creation>>, "bang_creation")
			Result.force (<<create_creation_expr>>, "create_creation_expr")
			Result.force (<<bang_creation_expr>>, "bang_creation_expr")
			Result.force (<<keyword>>, "keyword")
			Result.force (<<symbol>>, "symbol")
			Result.force (<<custom_attribute>>, "custom_attribute")
			Result.force (<<id>>, "id")
			Result.force (<<integer>>, "integer")
			Result.force (<<static_access>>, "static_access")
			Result.force (<<feature_clause>>, "feature_clause")
			Result.force (<<unique_as>>, "unique")
			Result.force (<<tuple>>, "tuple")
			Result.force (<<real>>, "real")
			Result.force (<<bool>>, "bool")
			Result.force (<<bit_const>>, "bit_const")
			Result.force (<<array>>, "array")
			Result.force (<<char>>, "char")
			Result.force (<<string>>, "string")
			Result.force (<<verbatim_string>>, "verbatim_string")
			Result.force (<<body>>, "body")
			Result.force (<<result_as>>, "result")
			Result.force (<<current_as>>, "current")
			Result.force (<<access_feat>>, "access_feat")
			Result.force (<<access_inv>>, "access_inv")
			Result.force (<<access_id>>, "access_id")
			Result.force (<<access_assert>>, "access_assert")
			Result.force (<<precursor_as>>, "precursor")
			Result.force (<<nested_expr>>, "nested_expr")
			Result.force (<<nested>>, "nested")
			Result.force (<<creation_expr>>, "creation_expr")
			Result.force (<<type_expr>>, "type_expr")
			Result.force (<<routine>>, "routine")
			Result.force (<<constant>>, "constant")
			Result.force (<<eiffel_list>>, "eiffel_list")
			Result.force (<<indexing_clause>>, "indexing_clause")
			Result.force (<<operand>>, "operand")
			Result.force (<<tagged>>, "tagged")
			Result.force (<<variant_as>>, "variant")
			Result.force (<<un_strip>>, "un_strip")
			Result.force (<<paran>>, "paran")
			Result.force (<<expr_call>>, "expr_call")
			Result.force (<<expr_address>>, "expr_address")
			Result.force (<<address_result>>, "address_result")
			Result.force (<<address_current>>, "address_current")
			Result.force (<<address>>, "address")
			Result.force (<<routine_creation>>, "routine_creation")
			Result.force (<<unary>>, "unary")
			Result.force (<<un_free>>, "un_free")
			Result.force (<<un_minus>>, "un_minus")
			Result.force (<<un_not>>, "un_not")
			Result.force (<<un_old>>, "un_old")
			Result.force (<<un_plus>>, "un_plus")
			Result.force (<<binary>>, "binary")
			Result.force (<<bin_and_then>>, "bin_and_then")
			Result.force (<<bin_free>>, "bin_free")
			Result.force (<<bin_implies>>, "bin_implies")
			Result.force (<<bin_or>>, "bin_or")
			Result.force (<<bin_or_else>>, "bin_or_else")
			Result.force (<<bin_xor>>, "bin_xor")
			Result.force (<<bin_ge>>, "bin_ge")
			Result.force (<<bin_gt>>, "bin_gt")
			Result.force (<<bin_le>>, "bin_le")
			Result.force (<<bin_lt>>, "bin_lt")
			Result.force (<<bin_div>>, "bin_div")
			Result.force (<<bin_minus>>, "bin_minus")
			Result.force (<<bin_mod>>, "bin_mod")
			Result.force (<<bin_plus>>, "bin_plus")
			Result.force (<<bin_power>>, "bin_power")
			Result.force (<<bin_slash>>, "bin_slash")
			Result.force (<<bin_star>>, "bin_star")
			Result.force (<<bin_and>>, "bin_and")
			Result.force (<<bin_eq>>, "bin_eq")
			Result.force (<<bin_ne>>, "bin_ne")
			Result.force (<<bin_tilde>>, "bin_tilde")
			Result.force (<<bin_not_tilde>>, "bin_not_tilde")
			Result.force (<<bracket>>, "bracket")
			Result.force (<<object_test>>, "object_test")
			Result.force (<<external_lang>>, "external_lang")
			Result.force (<<feature_as>>, "feature")
			Result.force (<<infix_prefix>>, "infix_prefix")
			Result.force (<<feat_name_id>>, "feat_name_id")
			Result.force (<<feature_name_alias>>, "feature_name_alias")
			Result.force (<<feature_list>>, "feature_list")
			Result.force (<<all_as>>, "all")
			Result.force (<<assign_as>>, "assign")
			Result.force (<<assigner_call>>, "assigner_call")
			Result.force (<<reverse>>, "reverse")
			Result.force (<<check_as>>, "check")
			Result.force (<<creation_as>>, "creation")
			Result.force (<<debug_as>>, "debug")
			Result.force (<<if_as>>, "if")
			Result.force (<<inspect_as>>, "inspect")
			Result.force (<<instr_call>>, "instr_call")
			Result.force (<<loop_as>>, "loop")
			Result.force (<<retry_as>>, "retry")
			Result.force (<<external_as>>, "external")
			Result.force (<<deferred_as>>, "deferred")
			Result.force (<<do_as>>, "do")
			Result.force (<<once_as>>, "once")
			Result.force (<<type_dec>>, "type_dec")
			Result.force (<<class_as>>, "class")
			Result.force (<<parent>>, "parent")
			Result.force (<<like_id>>, "like_id")
			Result.force (<<like_cur>>, "like_cur")
			Result.force (<<formal>>, "formal")
			Result.force (<<formal_dec>>, "formal_dec")
			Result.force (<<class_type>>, "class_type")
			Result.force (<<named_tuple_type>>, "named_tuple_type")
			Result.force (<<none_type>>, "none_type")
			Result.force (<<bits>>, "bits")
			Result.force (<<bits_symbol>>, "bits_symbol")
			Result.force (<<rename_as>>, "rename")
			Result.force (<<invariant_as>>, "invariant")
			Result.force (<<interval>>, "interval")
			Result.force (<<index>>, "index")
			Result.force (<<export_item>>, "export_item")
			Result.force (<<elseif_as>>, "elseif")
			Result.force (<<create_as>>, "create")
			Result.force (<<client>>, "client")
			Result.force (<<case>>, "case")
			Result.force (<<ensure_as>>, "ensure")
			Result.force (<<ensure_then>>, "ensure_then")
			Result.force (<<require_as>>, "require")
			Result.force (<<require_else>>, "require_else")
			Result.force (<<convert_feat>>, "convert_feat")
			Result.force (<<void_as>>, "void")
			Result.force (<<type_list>>, "type_list")
			Result.force (<<type_dec_list>>, "type_dec_list")
			Result.force (<<convert_feat_list>>, "convert_feat_list")
			Result.force (<<class_list>>, "class_list")
			Result.force (<<parent_list>>, "parent_list")
			Result.force (<<local_dec_list>>, "local_dec_list")
			Result.force (<<formal_argu_dec_list>>, "formal_argu_dec_list")
			Result.force (<<debug_key_list>>, "debug_key_list")
			Result.force (<<delayed_actual_list>>, "delayed_actual_list")
			Result.force (<<parameter_list>>, "parameter_list")
			Result.force (<<rename_clause>>, "rename_clause")
			Result.force (<<export_clause>>, "export_clause")
			Result.force (<<undefine_clause>>, "undefine_clause")
			Result.force (<<redefine_clause>>, "redefine_clause")
			Result.force (<<select_clause>>, "select_clause")
			Result.force (<<formal_generic_list>>, "formal_generic_list")

			Result.force (<<assign_as, assigner_call, reverse, check_as, debug_as, if_as, inspect_as, instr_call, loop_as, retry_as>>, "instruction")
			Result.force (<<integer, unique_as, real>>, "number")
			Result.force (<<typed_char, integer, unique_as, bool, bit_const, char ,string, verbatim_string, constant, bits>>, "constant")
			Result.force (<<if_as, inspect_as>>, "conditional")
			Result.force (<<create_creation_expr, bang_creation_expr, nested_expr, creation_expr, type_expr, expr_call, expr_address, bool, char,
							result_as, void_as, string, verbatim_string, current_as, integer, real, bit_const, typed_char, agent_routine_creation,
							tilda_routine_creation, inline_agent_creation, static_access, tuple, array, expr_call, address_result, address_current,
							address, routine_creation>>, "expression")
		ensure
			result_attached: Result /= Void
		end

feature -- Access

	ql_no_tag: STRING_32 = "no tag";

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
