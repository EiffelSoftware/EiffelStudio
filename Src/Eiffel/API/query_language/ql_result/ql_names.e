indexing
	description: "Name constants used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_NAMES

feature -- Scope item

	ql_target: STRING is "target"
	ql_group: STRING is "group"
	ql_class: STRING is "class"
	ql_feature: STRING is "feature"
	ql_invariant: STRING is "invariant"
	ql_quantity: STRING is "quantity"
	ql_line: STRING is "line"
	ql_local: STRING is "local"
	ql_assertion: STRING is "assertion"
	ql_argument: STRING is "argument"
	ql_generic: STRING is "generic"

feature -- Units

	ql_target_unit: STRING is "target"
	ql_group_unit: STRING is "group"
	ql_class_unit: STRING is "class"
	ql_feature_unit: STRING is "feature"
	ql_compilation_unit: STRING is "compilation"
	ql_local_unit: STRING is "local"
	ql_argument_unit: STRING is "argument"
	ql_ratio_unit: STRING is "ratio"
	ql_line_unit: STRING is "line"
	ql_assertion_unit: STRING is "assertion"
	ql_no_unit: STRING is "no unit"
	ql_generic_unit: STRING is "generic"

feature -- Titles

	ql_name: STRING is "name"
	ql_path: STRING is "path"

feature -- Criterion names

	ql_cri_true: STRING is "true"
	ql_cri_false: STRING is "false"
	ql_cri_and: STRING is "and"
	ql_cri_or: STRING is "or"
	ql_cri_not: STRING is "not"
	ql_cri_eq: STRING is "eq"
	ql_cri_ne: STRING is "ne"
	ql_cri_num: STRING is "num"
	ql_cri_is_compiled: STRING is "is_compiled"
	ql_cri_name_is: STRING is "name_is"

	ql_cri_is_assembly: STRING is "is_assembly"
	ql_cri_is_library: STRING is "is_library"
	ql_cri_is_cluster: STRING is "is_cluster"
	ql_cri_is_override: STRING is "is_override"
	ql_cri_is_valid: STRING is "is_valid"
	ql_cri_is_used_in_library: STRING is "is_used_in_library"
	ql_cri_is_class_set: STRING is "is_class_set"

	ql_cri_has_invariant: STRING is "has_immediate_invariant"
	ql_cri_ancestor_is: STRING is "ancestor_is"
	ql_cri_proper_ancestor_is: STRING is "proper_ancestor_is"
	ql_cri_parent_is: STRING is "parent_is"
	ql_cri_indirect_parent_is: STRING is "indirect_parent_is"
	ql_cri_descendant_is: STRING is "descendant_is"
	ql_cri_proper_descendant_is: STRING is "proper_descendant_is"
	ql_cri_heir_is: STRING is "heir_is"
	ql_cri_indirect_heir_is: STRING is "indirect_heir_is"
	ql_cri_client_is: STRING is "client_is"
	ql_cri_supplier_is: STRING is "supplier_is"
	ql_cri_is_deferred: STRING is "is_deferred"
	ql_cri_is_expanded: STRING is "is_expanded"
	ql_cri_is_external: STRING is "is_external"
	ql_cri_is_frozen: STRING is "is_frozen"
	ql_cri_is_generic: STRING is "is_generic"
	ql_cri_is_obsolete: STRING is "is_obsolete"
	ql_cri_is_precompiled: STRING is "is_precompiled"
	ql_cri_has_top_indexing: STRING is "has_top_indexing"
	ql_cri_has_bottom_indexing: STRING is "has_bottom_indexing"
	ql_cri_has_indexing: STRING is "has_indexing"
	ql_cri_is_enum: STRING is "is_enum"
	ql_cri_is_effective: STRING is "is_effective"
	ql_cri_path_in: STRING is "path_in"
	ql_cri_path_is: STRING is "path_is"
	ql_cri_text_contain: STRING is "text_is"
	ql_cri_top_indexing_has_tag: STRING is "top_indexing_has_tag"
	ql_cri_bottom_indexing_has_tag: STRING is "bottom_indexing_has_tag"
	ql_cri_indexing_has_tag: STRING is "indexing_has_tag"
	ql_cri_top_indexing_contain: STRING is "top_indexing_contain"
	ql_cri_bottom_indexing_contain: STRING is "bottom_indexing_contain"
	ql_cri_indexing_contain: STRING is "indexing_contain"
	ql_cri_is_always_compiled: STRING is "is_always_compiled"
	ql_cri_is_partial: STRING is "is_partial"
	ql_cri_is_read_only: STRING is "is_read_only"
	ql_cri_is_overridden: STRING is "is_overridden"
	ql_cri_is_overrider: STRING is "is_overrider"
	ql_cri_is_visible: STRING is "is_visible"
	ql_cri_is_from_any: STRING is "is_from_any"

	ql_cri_has_argument: STRING is "has_argument"
	ql_cri_has_assertion: STRING is "has_assertion"
	ql_cri_has_assigner: STRING is "has_assigner"
	ql_cri_has_comment: STRING is "has_comment"
	ql_cri_has_local: STRING is "has_local"
	ql_cri_has_postcondition: STRING is "has_postcondition"
	ql_cri_has_precondition: STRING is "has_precondition"
	ql_cri_has_rescue: STRING is "has_rescue"
	ql_cri_is_attribute: STRING is "is_attribute"
	ql_cri_is_caller: STRING is "is_caller_of"
	ql_cri_is_constant: STRING is "is_constant"
	ql_cri_is_function: STRING is "is_function"
	ql_cri_is_immediate: STRING is "is_immediate"
	ql_cri_is_implementor: STRING is "is_implementor_of"
	ql_cri_is_infix: STRING is "is_infix"
	ql_cri_is_once: STRING is "is_once"
	ql_cri_is_origin: STRING is "is_origin"
	ql_cri_is_prefix: STRING is "is_prefix"
	ql_cri_is_procedure: STRING is "is_procedure"
	ql_cri_is_unique: STRING is "is_unique"
	ql_cri_is_feature: STRING is "is_feature"
	ql_cri_is_invariant: STRING is "is_invariant"
	ql_cri_is_creator: STRING is "is_creator"
	ql_cri_is_exported: STRING is "is_exported"
	ql_cri_is_hidden: STRING is "is_hidden"
	ql_cri_implementors_of: STRING is "is_implementors_of"
	ql_cri_is_exported_to: STRING is "is_exported_to"
	ql_cri_callee_is: STRING is "callee_is"
	ql_cri_caller_is: STRING is "caller_is"
	ql_cri_assignee_is: STRING is "assignee_is"
	ql_cri_assigner_is: STRING is "assigner_is"
	ql_cri_createe_is: STRING is "createe_is"
	ql_cri_creator_is: STRING is "creator_is"
	ql_cri_is_invariant_feature: STRING is "is_invariant_feature"
	ql_cri_is_query: STRING is "is_query"
	ql_cri_is_command: STRING is "is_command"
	ql_cri_return_type_is: STRING is "return_type_is"

	ql_cri_has_constraint: STRING is "has_constraint"
	ql_cri_has_creation_constraint: STRING is "has_creation_constraint"
	ql_cri_is_reference: STRING is "is_reference"
	ql_cri_is_self_initializing: STRING is "is_self_initializing"

	ql_cri_is_used: STRING is "is_used"

	ql_cri_has_expression: STRING is "has_expression"
	ql_cri_has_tag: STRING is "has_tag"
	ql_cri_is_require: STRING is "is_require"
	ql_cri_is_require_else: STRING is "is_require_else"
	ql_cri_is_ensure: STRING is "is_ensure"
	ql_cri_is_ensure_then: STRING is "is_ensure_then"
	ql_cri_is_precondition: STRING is "is_precondition"
	ql_cri_is_postcondition: STRING is "is_postcondition"

	ql_cri_is_blank: STRING is "is_blank"
	ql_cri_is_comment: STRING is "is_comment"
	ql_cri_contain_ast: STRING is "contain_ast"

	ql_cri_value_of_metric_is: STRING is "value_of_metric_is"
	ql_cri_is_implementation_comment: STRING is "is_implementation_comment"

	ql_cri_is_satisfied_by: STRING is "is_satisfied_by"

feature -- Metric names

	ql_metric_target: STRING is "Number of targets"
	ql_metric_group: STRING is "Number of groups"
	ql_metric_class: STRING is "Number of classes"
	ql_metric_feature: STRING is "Number of features"
	ql_metric_local: STRING is "Number of locals"
	ql_metric_argument: STRING is "Number of arguments"
	ql_metric_line: STRING is "Number of lines"
	ql_metric_compilation: STRING is "Number of compilation"
	ql_metric_assertion: STRING is "Number of assertions"
	ql_metric_sum: STRING is "Sum"
	ql_metric_average: STRING is "Average"
	ql_metric_count: STRING is "Number of items"
	ql_metric_generic: STRING is "Number of generics"

feature -- Assertion type names

	ql_require_assertion: STRING is "require"
	ql_require_else_assertion: STRING is "require else"
	ql_ensure_assertion: STRING is "ensure"
	ql_ensure_then_assertion: STRING is "ensure then"
	ql_invariant_assertion: STRING is "invariant"

feature -- Path marker

	ql_target_path_opener: STRING is ""
	ql_target_path_closer: STRING is ""

	ql_group_path_opener: STRING is ""
	ql_group_path_closer: STRING is ""

	ql_class_path_opener: STRING is "{"
	ql_class_path_closer: STRING is "}"

	ql_feature_path_opener: STRING is ""
	ql_feature_path_closer: STRING is ""

	ql_generic_path_opener: STRING is "["
	ql_generic_path_closer: STRING is "]"

	ql_argument_path_opener: STRING is "argument "
	ql_argument_path_closer: STRING is ""

	ql_local_path_opener: STRING is "local "
	ql_local_path_closer: STRING is ""

	ql_assertion_path_opener: STRING is "assertion "
	ql_assertion_path_closer: STRING is ""

	ql_line_path_opener: STRING is "line "
	ql_line_path_closer: STRING is ""

	ql_quantity_path_opener: STRING is "quantity "
	ql_quantity_path_closer: STRING is ""

feature -- Feature caller types

	ql_normal_feature_caller: STRING is "normal caller"
	ql_assigner_feature_caller: STRING is "assign caller"
	ql_creator_feature_caller: STRING is "creator caller"
	ql_normal_feature_callee: STRING is "normal callee"
	ql_assigner_feature_callee: STRING is "assign callee"
	ql_creator_feature_callee: STRING is "creator callee"

feature -- Class relationship

	ql_class_ancestor_relation: STRING is "ancestor"
	ql_class_proper_ancestor_relation: STRING is "proper ancestor"
	ql_class_descendant_relation: STRING is "descendant"
	ql_class_proper_descendant_relation: STRING is "proper descendant"
	ql_class_parent_relation: STRING is "parent"
	ql_class_indirect_parent_relation: STRING is "indirect parent"
	ql_class_heir_relation: STRING is "heir"
	ql_class_indirect_heir_relation: STRING is "indirect heir"
	ql_class_client_relation: STRING is "client"
	ql_class_indirect_client_relation: STRING is "indirect client"
	ql_class_supplier_relation: STRING is "supplier"
	ql_class_indirect_supplier_relation: STRING is "indirect supplier";

feature -- AST node index

	none_id: INTEGER is 0
	typed_char: INTEGER is 1
	agent_routine_creation: INTEGER is 2
	tilda_routine_creation: INTEGER is 3
	inline_agent_creation: INTEGER is 4
	create_creation: INTEGER is 5
	bang_creation: INTEGER is 6
	create_creation_expr: INTEGER is 7
	bang_creation_expr: INTEGER is 8
	keyword: INTEGER is 9
	symbol: INTEGER is 10
	custom_attribute: INTEGER is 11
	id: INTEGER is 12
	integer: INTEGER is 13
	static_access: INTEGER is 14
	feature_clause: INTEGER is 15
	unique_as: INTEGER is 16
	tuple: INTEGER is 17
	real: INTEGER is 18
	bool: INTEGER is 19
	bit_const: INTEGER is 20
	array: INTEGER is 21
	char: INTEGER is 22
	string: INTEGER is 23
	verbatim_string: INTEGER is 24
	body: INTEGER is 25
	result_as: INTEGER is 26
	current_as: INTEGER is 27
	access_feat: INTEGER is 28
	access_inv: INTEGER is 29
	access_id: INTEGER is 30
	access_assert: INTEGER is 31
	precursor_as: INTEGER is 32
	nested_expr: INTEGER is 33
	nested: INTEGER is 34
	creation_expr: INTEGER is 35
	type_expr: INTEGER is 36
	routine: INTEGER is 37
	constant: INTEGER is 38
	eiffel_list: INTEGER is 39
	indexing_clause: INTEGER is 40
	operand: INTEGER is 41
	tagged: INTEGER is 42
	variant_as: INTEGER is 43
	un_strip: INTEGER is 44
	paran: INTEGER is 45
	expr_call: INTEGER is 46
	expr_address: INTEGER is 47
	address_result: INTEGER is 48
	address_current: INTEGER is 49
	address: INTEGER is 50
	routine_creation: INTEGER is 51
	unary: INTEGER is 52
	un_free: INTEGER is 53
	un_minus: INTEGER is 54
	un_not: INTEGER is 55
	un_old: INTEGER is 56
	un_plus: INTEGER is 57
	binary: INTEGER is 58
	bin_and_then: INTEGER is 59
	bin_free: INTEGER is 60
	bin_implies: INTEGER is 61
	bin_or: INTEGER is 62
	bin_or_else: INTEGER is 63
	bin_xor: INTEGER is 64
	bin_ge: INTEGER is 65
	bin_gt: INTEGER is 66
	bin_le: INTEGER is 67
	bin_lt: INTEGER is 68
	bin_div: INTEGER is 69
	bin_minus: INTEGER is 70
	bin_mod: INTEGER is 71
	bin_plus: INTEGER is 72
	bin_power: INTEGER is 73
	bin_slash: INTEGER is 74
	bin_star: INTEGER is 75
	bin_and: INTEGER is 76
	bin_eq: INTEGER is 77
	bin_ne: INTEGER is 78
	bracket: INTEGER is 79
	external_lang: INTEGER is 80
	feature_as: INTEGER is 81
	infix_prefix: INTEGER is 82
	feat_name_id: INTEGER is 83
	feature_name_alias: INTEGER is 84
	feature_list: INTEGER is 85
	all_as: INTEGER is 86
	assign_as: INTEGER is 87
	assigner_call: INTEGER is 88
	reverse: INTEGER is 89
	check_as: INTEGER is 90
	creation_as: INTEGER is 91
	debug_as: INTEGER is 92
	if_as: INTEGER is 93
	inspect_as: INTEGER is 94
	instr_call: INTEGER is 95
	loop_as: INTEGER is 96
	retry_as: INTEGER is 97
	external_as: INTEGER is 98
	deferred_as: INTEGER is 99
	do_as: INTEGER is 100
	once_as: INTEGER is 101
	type_dec: INTEGER is 102
	class_as: INTEGER is 103
	parent: INTEGER is 104
	like_id: INTEGER is 105
	like_cur: INTEGER is 106
	formal: INTEGER is 107
	formal_dec: INTEGER is 108
	class_type: INTEGER is 109
	named_tuple_type: INTEGER is 110
	none_type: INTEGER is 111
	bits: INTEGER is 112
	bits_symbol: INTEGER is 113
	rename_as: INTEGER is 114
	invariant_as: INTEGER is 115
	interval: INTEGER is 116
	index: INTEGER is 117
	export_item: INTEGER is 118
	elseif_as: INTEGER is 119
	create_as: INTEGER is 120
	client: INTEGER is 121
	case: INTEGER is 122
	ensure_as: INTEGER is 123
	ensure_then: INTEGER is 124
	require_as: INTEGER is 125
	require_else: INTEGER is 126
	convert_feat: INTEGER is 127
	void_as: INTEGER is 128
	type_list: INTEGER is 129
	type_dec_list: INTEGER is 130
	convert_feat_list: INTEGER is 131
	class_list: INTEGER is 132
	parent_list: INTEGER is 133
	local_dec_list: INTEGER is 134
	formal_argu_dec_list: INTEGER is 135
	debug_key_list: INTEGER is 136
	delayed_actual_list: INTEGER is 137
	parameter_list: INTEGER is 138
	rename_clause: INTEGER is 139
	export_clause: INTEGER is 140
	undefine_clause: INTEGER is 141
	redefine_clause: INTEGER is 142
	select_clause: INTEGER is 143
	formal_generic_list: INTEGER is 144
	constraining_type:  INTEGER is 145
	object_test: INTEGER is 146
	bin_tilde: INTEGER is 147
	bin_not_tilde: INTEGER is 148

feature -- AST node match

	ast_index_table: HASH_TABLE [ARRAY [INTEGER], STRING] is
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

	ql_no_tag: STRING is "no tag";

indexing
        copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
