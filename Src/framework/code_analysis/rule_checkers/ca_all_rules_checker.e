note
	description: "[
		Checks a set of (standard) rules (see {CA_STANDARD_RULE}). The rules have to
		register their AST visitor agents here.
	]"
	author: "Stefan Zurfluh", "Eiffel Software"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ALL_RULES_CHECKER

inherit

	AST_ITERATOR
		export {NONE}
			process_none_id_as,
			process_typed_char_as,
			process_agent_routine_creation_as,
			process_inline_agent_creation_as,
			process_keyword_as,
			process_symbol_as,
			process_break_as,
			process_leaf_stub_as,
			process_symbol_stub_as,
			process_keyword_stub_as
		redefine
			process_access_feat_as,
			process_access_id_as,
			process_address_as,
			process_agent_routine_creation_as,
			process_array_as,
			process_assign_as,
			process_assigner_call_as,
			process_binary_as,
			process_bin_eq_as,
			process_bin_ge_as,
			process_bin_gt_as,
			process_bin_le_as,
			process_bin_lt_as,
			process_bin_ne_as,
			process_bin_not_tilde_as,
			process_bin_tilde_as,
			process_body_as,
			process_bracket_as,
			process_case_as,
			process_converted_expr_as,
			process_create_as,
			process_creation_as,
			process_do_as,
			process_eiffel_list,
			process_elseif_as,
			process_expr_call_as,
			process_feature_as,
			process_feature_clause_as,
			process_guard_as,
			process_id_as,
			process_if_as,
			process_if_expression_as,
			process_inline_agent_creation_as,
			process_inspect_as,
			process_instr_call_as,
			process_integer_as,
			process_invariant_as,
			process_loop_as,
			process_nested_expr_as,
			process_object_test_as,
			process_once_as,
			process_parameter_list_as,
			process_paran_as,
			process_precursor_as,
			process_predecessor_as,
			process_real_as,
			process_routine_as,
			process_static_access_as,
			process_unary_as,
			process_un_not_as
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create_action_lists
		end

	create_action_lists
			-- Creates all the lists of agents that will be called when visiting
			-- certain AST nodes.
		do
			create access_feat_pre_actions
			create access_feat_post_actions
			create access_id_pre_actions
			create access_id_post_actions
			create address_pre_actions
			create address_post_actions
			create agent_routine_pre_action
			create agent_routine_post_action
			create array_pre_actions
			create array_post_actions
			create assign_pre_actions
			create assign_post_actions
			create assigner_call_pre_actions
			create assigner_call_post_actions
			create binary_pre_actions
			create binary_post_actions
			create bin_eq_pre_actions
			create bin_eq_post_actions
			create bin_ge_pre_actions
			create bin_ge_post_actions
			create bin_gt_pre_actions
			create bin_gt_post_actions
			create bin_le_pre_actions
			create bin_le_post_actions
			create bin_lt_pre_actions
			create bin_lt_post_actions
			create bin_ne_pre_actions
			create bin_ne_post_actions
			create bin_not_tilde_pre_actions
			create bin_not_tilde_post_actions
			create bin_tilde_pre_actions
			create bin_tilde_post_actions
			create body_pre_actions
			create body_post_actions
			create bracket_pre_actions
			create bracket_post_actions
			create case_pre_actions
			create case_post_actions
			create class_pre_actions
			create class_post_actions
			create converted_expr_pre_actions
			create converted_expr_post_actions
			create create_pre_actions
			create create_post_actions
			create creation_pre_actions
			create creation_post_actions
			create do_pre_actions
			create do_post_actions
			create eiffel_list_pre_actions
			create eiffel_list_post_actions
			create elseif_pre_actions
			create elseif_post_actions
			create expression_call_pre_actions
			create expression_call_post_actions
			create feature_pre_actions
			create feature_post_actions
			create feature_clause_pre_actions
			create feature_clause_post_actions
			create guard_pre_actions
			create guard_post_actions
			create id_pre_actions
			create id_post_actions
			create if_pre_actions
			create if_post_actions
			create if_expression_pre_actions
			create if_expression_post_actions
			create inline_agent_creation_pre_actions
			create inline_agent_creation_post_actions
			create inspect_pre_actions
			create inspect_post_actions
			create instruction_call_pre_actions
			create instruction_call_post_actions
			create invariant_pre_actions
			create invariant_post_actions
			create loop_pre_actions
			create loop_post_actions
			create loop_iteration_pre_actions
			create loop_iteration_post_actions
			create loop_from_pre_actions
			create loop_from_post_actions
			create loop_invariant_pre_actions
			create loop_invariant_post_actions
			create loop_exit_pre_actions
			create loop_exit_post_actions
			create loop_body_pre_actions
			create loop_body_post_actions
			create loop_variant_pre_actions
			create loop_variant_post_actions
			create nested_expr_pre_actions
			create nested_expr_post_actions
			create object_test_pre_actions
			create object_test_post_actions
			create once_pre_actions
			create once_post_actions
			create parameter_list_pre_actions
			create parameter_list_post_actions
			create paran_pre_actions
			create paran_post_actions
			create precursor_pre_actions
			create precursor_post_actions
			create predecessor_pre_actions
			create predecessor_post_actions
			create routine_pre_actions
			create routine_post_actions
			create static_access_pre_actions
			create static_access_post_actions
			create unary_pre_actions
			create unary_post_actions
			create un_not_pre_actions
			create un_not_post_actions
			create integer_pre_actions
			create integer_post_actions
			create real_pre_actions
			create real_post_actions
		end

feature {CA_RULE} -- State

	is_assign: BOOLEAN
			-- Is target of an assignment or a creation instruction being processed?

	is_assigner_call: BOOLEAN
			-- Is current call an assigner call?

feature {CA_STANDARD_RULE} -- Adding agents

	add_access_feat_pre_action (a_action: attached PROCEDURE [ACCESS_FEAT_AS])
		do
			access_feat_pre_actions.extend (a_action)
		end

	add_access_feat_post_action (a_action: attached PROCEDURE [ACCESS_FEAT_AS])
		do
			access_feat_post_actions.extend (a_action)
		end

	add_access_id_pre_action (a_action: attached PROCEDURE [ACCESS_ID_AS])
		do
			access_id_pre_actions.extend (a_action)
		end

	add_access_id_post_action (a_action: attached PROCEDURE [ACCESS_ID_AS])
		do
			access_id_post_actions.extend (a_action)
		end

	add_address_pre_action (a: PROCEDURE [ADDRESS_AS])
		do
			address_pre_actions.extend (a)
		end

	add_address_post_action (a: PROCEDURE [ADDRESS_AS])
		do
			address_post_actions.extend (a)
		end

	add_array_pre_action (a: PROCEDURE [ARRAY_AS])
		do
			array_pre_actions.extend (a)
		end

	add_array_post_action (a: PROCEDURE [ARRAY_AS])
		do
			array_post_actions.extend (a)
		end

	add_assign_pre_action (a_action: attached PROCEDURE [ASSIGN_AS])
		do
			assign_pre_actions.extend (a_action)
		end

	add_assign_post_action (a_action: attached PROCEDURE [ASSIGN_AS])
		do
			assign_post_actions.extend (a_action)
		end

	add_assigner_call_pre_action (a_action: attached PROCEDURE [ASSIGNER_CALL_AS])
		do
			assigner_call_pre_actions.extend (a_action)
		end

	add_assigner_call_post_action (a_action: attached PROCEDURE [ASSIGNER_CALL_AS])
		do
			assigner_call_post_actions.extend (a_action)
		end

	add_binary_pre_action (a_action: attached PROCEDURE [BINARY_AS])
		do
			binary_pre_actions.extend (a_action)
		end

	add_binary_post_action (a_action: attached PROCEDURE [BINARY_AS])
		do
			binary_post_actions.extend (a_action)
		end

	add_bin_eq_pre_action (a_action: attached PROCEDURE [BIN_EQ_AS])
		do
			bin_eq_pre_actions.extend (a_action)
		end

	add_bin_eq_post_action (a_action: attached PROCEDURE [BIN_EQ_AS])
		do
			bin_eq_post_actions.extend (a_action)
		end

	add_bin_ge_pre_action (a_action: attached PROCEDURE [BIN_GE_AS])
		do
			bin_ge_pre_actions.extend (a_action)
		end

	add_bin_ge_post_action (a_action: attached PROCEDURE [BIN_GE_AS])
		do
			bin_ge_post_actions.extend (a_action)
		end

	add_bin_gt_pre_action (a_action: attached PROCEDURE [BIN_GT_AS])
		do
			bin_gt_pre_actions.extend (a_action)
		end

	add_bin_gt_post_action (a_action: attached PROCEDURE [BIN_GT_AS])
		do
			bin_gt_post_actions.extend (a_action)
		end

	add_bin_le_pre_action (a_action: attached PROCEDURE [BIN_LE_AS])
		do
			bin_le_pre_actions.extend (a_action)
		end

	add_bin_le_post_action (a_action: attached PROCEDURE [BIN_LE_AS])
		do
			bin_le_post_actions.extend (a_action)
		end

	add_bin_lt_pre_action (a_action: attached PROCEDURE [BIN_LT_AS])
		do
			bin_lt_pre_actions.extend (a_action)
		end

	add_bin_lt_post_action (a_action: attached PROCEDURE [BIN_LT_AS])
		do
			bin_lt_post_actions.extend (a_action)
		end

	add_bin_ne_pre_action (a_action: attached PROCEDURE [BIN_NE_AS])
		do
			bin_ne_pre_actions.extend (a_action)
		end

	add_bin_ne_post_action (a_action: attached PROCEDURE [BIN_NE_AS])
		do
			bin_ne_post_actions.extend (a_action)
		end

	add_bin_not_tilde_pre_action (a: PROCEDURE [BIN_NOT_TILDE_AS])
		do
			bin_not_tilde_pre_actions.extend (a)
		end

	add_bin_not_tilde_post_action (a: PROCEDURE [BIN_NOT_TILDE_AS])
		do
			bin_not_tilde_post_actions.extend (a)
		end

	add_bin_tilde_pre_action (a: PROCEDURE [BIN_TILDE_AS])
		do
			bin_tilde_pre_actions.extend (a)
		end

	add_bin_tilde_post_action (a: PROCEDURE [BIN_TILDE_AS])
		do
			bin_tilde_post_actions.extend (a)
		end

	add_body_pre_action (a_action: attached PROCEDURE [BODY_AS])
		do
			body_pre_actions.extend (a_action)
		end

	add_body_post_action (a_action: attached PROCEDURE [BODY_AS])
		do
			body_post_actions.extend (a_action)
		end

	add_bracket_pre_action (a_action: attached PROCEDURE [BRACKET_AS])
		do
			bracket_pre_actions.extend (a_action)
		end

	add_bracket_post_action (a_action: attached PROCEDURE [BRACKET_AS])
		do
			bracket_post_actions.extend (a_action)
		end

	add_case_pre_action (a_action: attached PROCEDURE [CASE_AS])
		do
			case_pre_actions.extend (a_action)
		end

	add_case_post_action (a_action: attached PROCEDURE [CASE_AS])
		do
			case_post_actions.extend (a_action)
		end

	add_class_pre_action (a_action: attached PROCEDURE [CLASS_AS])
		do
			class_pre_actions.extend (a_action)
		end

	add_class_post_action (a_action: attached PROCEDURE [CLASS_AS])
		do
			class_post_actions.extend (a_action)
		end

	add_converted_expr_pre_action (a_action: attached PROCEDURE [CONVERTED_EXPR_AS])
		do
			converted_expr_pre_actions.extend (a_action)
		end

	add_converted_expr_post_action (a_action: attached PROCEDURE [CONVERTED_EXPR_AS])
		do
			converted_expr_post_actions.extend (a_action)
		end

	add_create_pre_action (a_action: attached PROCEDURE [CREATE_AS])
		do
			create_pre_actions.extend (a_action)
		end

	add_create_post_action (a_action: attached PROCEDURE [CREATE_AS])
		do
			create_post_actions.extend (a_action)
		end

	add_creation_pre_action (a_action: attached PROCEDURE [CREATION_AS])
		do
			creation_pre_actions.extend (a_action)
		end

	add_creation_post_action (a_action: attached PROCEDURE [CREATION_AS])
		do
			creation_post_actions.extend (a_action)
		end

	add_do_pre_action (a_action: attached PROCEDURE [DO_AS])
		do
			do_pre_actions.extend (a_action)
		end

	add_do_post_action (a_action: attached PROCEDURE [DO_AS])
		do
			do_post_actions.extend (a_action)
		end

	add_eiffel_list_pre_action (a_action: attached PROCEDURE [EIFFEL_LIST [AST_EIFFEL]])
		do
			eiffel_list_pre_actions.extend (a_action)
		end

	add_eiffel_list_post_action (a_action: attached PROCEDURE [EIFFEL_LIST [AST_EIFFEL]])
		do
			eiffel_list_post_actions.extend (a_action)
		end

	add_elseif_pre_action (a_action: attached PROCEDURE [ELSIF_AS])
		do
			elseif_pre_actions.extend (a_action)
		end

	add_elseif_post_action (a_action: attached PROCEDURE [ELSIF_AS])
		do
			elseif_post_actions.extend (a_action)
		end

	add_expression_call_pre_action (a: attached PROCEDURE [EXPR_CALL_AS])
		do
			expression_call_pre_actions.extend (a)
		end

	add_expression_call_post_action (a: attached PROCEDURE [EXPR_CALL_AS])
		do
			expression_call_post_actions.extend (a)
		end

	add_feature_pre_action (a_action: attached PROCEDURE [FEATURE_AS])
		do
			feature_pre_actions.extend (a_action)
		end

	add_feature_post_action (a_action: attached PROCEDURE [FEATURE_AS])
		do
			feature_post_actions.extend (a_action)
		end

	add_feature_clause_pre_action (a_action: attached PROCEDURE [FEATURE_CLAUSE_AS])
		do
			feature_clause_pre_actions.extend (a_action)
		end

	add_feature_clause_post_action (a_action: attached PROCEDURE [FEATURE_CLAUSE_AS])
		do
			feature_clause_post_actions.extend (a_action)
		end

	add_guard_pre_action (a: PROCEDURE [GUARD_AS])
		do
			guard_pre_actions.extend (a)
		end

	add_guard_post_action (a: PROCEDURE [GUARD_AS])
		do
			guard_post_actions.extend (a)
		end

	add_id_pre_action (a_action: attached PROCEDURE [ID_AS])
		do
			id_pre_actions.extend (a_action)
		end

	add_id_post_action (a_action: attached PROCEDURE [ID_AS])
		do
			id_post_actions.extend (a_action)
		end

	add_if_pre_action (a_action: attached PROCEDURE [IF_AS])
		do
			if_pre_actions.extend (a_action)
		end

	add_if_post_action (a_action: attached PROCEDURE [IF_AS])
		do
			if_post_actions.extend (a_action)
		end

	add_if_expression_pre_action (a: attached PROCEDURE [IF_EXPRESSION_AS])
		do
			if_expression_pre_actions.extend (a)
		end

	add_if_expression_post_action (a: attached PROCEDURE [IF_EXPRESSION_AS])
		do
			if_expression_post_actions.extend (a)
		end

	add_inline_agent_creation_pre_action (a_action: PROCEDURE [INLINE_AGENT_CREATION_AS])
		do
			inline_agent_creation_pre_actions.extend (a_action)
		end

	add_inline_agent_creation_post_action (a_action: PROCEDURE [INLINE_AGENT_CREATION_AS])
		do
			inline_agent_creation_post_actions.extend (a_action)
		end

	add_inspect_pre_action (a_action: attached PROCEDURE [INSPECT_AS])
		do
			inspect_pre_actions.extend (a_action)
		end

	add_inspect_post_action (a_action: attached PROCEDURE [INSPECT_AS])
		do
			inspect_post_actions.extend (a_action)
		end

	add_instruction_call_pre_action (a_action: attached PROCEDURE [INSTR_CALL_AS])
		do
			instruction_call_pre_actions.extend (a_action)
		end

	add_instruction_call_post_action (a_action: attached PROCEDURE [INSTR_CALL_AS])
		do
			instruction_call_post_actions.extend (a_action)
		end

	add_invariant_pre_action (a: PROCEDURE [INVARIANT_AS])
		do
			invariant_pre_actions.extend (a)
		end

	add_invariant_post_action (a: PROCEDURE [INVARIANT_AS])
		do
			invariant_post_actions.extend (a)
		end

	add_loop_pre_action (a: PROCEDURE [LOOP_AS])
		do
			loop_pre_actions.extend (a)
		end

	add_loop_post_action (a: PROCEDURE [LOOP_AS])
		do
			loop_post_actions.extend (a)
		end

	add_loop_iteration_pre_action (a: PROCEDURE [ITERATION_AS, LOOP_AS])
		do
			loop_iteration_pre_actions.extend (a)
		end

	add_loop_iteration_post_action (a: PROCEDURE [ITERATION_AS, LOOP_AS])
		do
			loop_iteration_post_actions.extend (a)
		end

	add_loop_from_pre_action (a: PROCEDURE [EIFFEL_LIST [INSTRUCTION_AS], LOOP_AS])
		do
			loop_from_pre_actions.extend (a)
		end

	add_loop_from_post_action (a: PROCEDURE [EIFFEL_LIST [INSTRUCTION_AS], LOOP_AS])
		do
			loop_from_post_actions.extend (a)
		end

	add_loop_invariant_pre_action (a: PROCEDURE [EIFFEL_LIST [TAGGED_AS], LOOP_AS])
		do
			loop_invariant_pre_actions.extend (a)
		end

	add_loop_invariant_post_action (a: PROCEDURE [EIFFEL_LIST [TAGGED_AS], LOOP_AS])
		do
			loop_invariant_post_actions.extend (a)
		end

	add_loop_exit_pre_action (a: PROCEDURE [EXPR_AS, LOOP_AS])
		do
			loop_exit_pre_actions.extend (a)
		end

	add_loop_exit_post_action (a: PROCEDURE [EXPR_AS, LOOP_AS])
		do
			loop_exit_post_actions.extend (a)
		end

	add_loop_body_pre_action (a: PROCEDURE [EIFFEL_LIST [INSTRUCTION_AS], LOOP_AS])
		do
			loop_body_pre_actions.extend (a)
		end

	add_loop_body_post_action (a: PROCEDURE [EIFFEL_LIST [INSTRUCTION_AS], LOOP_AS])
		do
			loop_body_post_actions.extend (a)
		end

	add_loop_variant_pre_action (a: PROCEDURE [VARIANT_AS, LOOP_AS])
		do
			loop_variant_pre_actions.extend (a)
		end

	add_loop_variant_post_action (a: PROCEDURE [VARIANT_AS, LOOP_AS])
		do
			loop_variant_post_actions.extend (a)
		end

	add_nested_expr_pre_action (a: PROCEDURE [NESTED_EXPR_AS])
		do
			nested_expr_pre_actions.extend (a)
		end

	add_nested_expr_post_action (a: PROCEDURE [NESTED_EXPR_AS])
		do
			nested_expr_post_actions.extend (a)
		end

	add_object_test_pre_action (a_action: attached PROCEDURE [OBJECT_TEST_AS])
		do
			object_test_pre_actions.extend (a_action)
		end

	add_object_test_post_action (a_action: attached PROCEDURE [OBJECT_TEST_AS])
		do
			object_test_post_actions.extend (a_action)
		end

	add_once_pre_action (a_action: attached PROCEDURE [ONCE_AS])
		do
			once_pre_actions.extend (a_action)
		end

	add_once_post_action (a_action: attached PROCEDURE [ONCE_AS])
		do
			once_post_actions.extend (a_action)
		end

	add_parameter_list_pre_action (a_action: attached PROCEDURE [PARAMETER_LIST_AS])
		do
			parameter_list_pre_actions.extend (a_action)
		end

	add_parameter_list_post_action (a_action: attached PROCEDURE [PARAMETER_LIST_AS])
		do
			parameter_list_post_actions.extend (a_action)
		end

	add_paran_pre_action (a_action: attached PROCEDURE [PARAN_AS])
		do
			paran_pre_actions.extend (a_action)
		end

	add_paran_post_action (a_action: attached PROCEDURE [PARAN_AS])
		do
			paran_post_actions.extend (a_action)
		end

	add_precursor_pre_action (a: PROCEDURE [PRECURSOR_AS])
		do
			precursor_pre_actions.extend (a)
		end

	add_precursor_post_action (a: PROCEDURE [PRECURSOR_AS])
		do
			precursor_post_actions.extend (a)
		end

	add_predecessor_pre_action (a: PROCEDURE [PREDECESSOR_AS])
		do
			predecessor_pre_actions.extend (a)
		end

	add_predecessor_post_action (a: PROCEDURE [PREDECESSOR_AS])
		do
			predecessor_post_actions.extend (a)
		end

	add_routine_agent_pre_action (a_action:  PROCEDURE [AGENT_ROUTINE_CREATION_AS])
		do
			agent_routine_pre_action.extend (a_action)
		end

	add_routine_agent_post_action (a_action:  PROCEDURE [AGENT_ROUTINE_CREATION_AS])
		do
			agent_routine_post_action.extend (a_action)
		end

	add_routine_pre_action (a_action: attached PROCEDURE [ROUTINE_AS])
		do
			routine_pre_actions.extend (a_action)
		end

	add_routine_post_action (a_action: attached PROCEDURE [ROUTINE_AS])
		do
			routine_post_actions.extend (a_action)
		end

	add_static_access_pre_action (a: PROCEDURE [STATIC_ACCESS_AS])
		do
			static_access_pre_actions.extend (a)
		end

	add_static_access_post_action (a: PROCEDURE [STATIC_ACCESS_AS])
		do
			static_access_post_actions.extend (a)
		end

	add_unary_pre_action (a_action: attached PROCEDURE [UNARY_AS])
		do
			unary_pre_actions.extend (a_action)
		end

	add_unary_post_action (a_action: attached PROCEDURE [UNARY_AS])
		do
			unary_post_actions.extend (a_action)
		end

	add_un_not_pre_action (a_action: attached PROCEDURE [UN_NOT_AS])
		do
			un_not_pre_actions.extend (a_action)
		end

	add_un_not_post_action (a_action: attached PROCEDURE [UN_NOT_AS])
		do
			un_not_post_actions.extend (a_action)
		end

	add_integer_pre_action (a_action: attached PROCEDURE [INTEGER_AS])
		do
			integer_pre_actions.extend (a_action)
		end

	add_integer_post_action (a_action: attached PROCEDURE [INTEGER_AS])
		do
			integer_post_actions.extend (a_action)
		end

	add_real_pre_action (a_action: attached PROCEDURE [REAL_AS])
		do
			real_pre_actions.extend (a_action)
		end

	add_real_post_action (a_action: attached PROCEDURE [REAL_AS])
		do
			real_post_actions.extend (a_action)
		end

feature {NONE} -- Agent lists

	access_feat_pre_actions, access_feat_post_actions: ACTION_SEQUENCE [TUPLE [ACCESS_FEAT_AS]]

	access_id_pre_actions, access_id_post_actions: ACTION_SEQUENCE [TUPLE [ACCESS_ID_AS]]

	address_pre_actions, address_post_actions: ACTION_SEQUENCE [TUPLE [ADDRESS_AS]]

	agent_routine_pre_action, agent_routine_post_action: ACTION_SEQUENCE [TUPLE [AGENT_ROUTINE_CREATION_AS]]

	array_pre_actions, array_post_actions: ACTION_SEQUENCE [TUPLE [ARRAY_AS]]

	assign_pre_actions, assign_post_actions: ACTION_SEQUENCE [TUPLE [ASSIGN_AS]]

	assigner_call_pre_actions, assigner_call_post_actions: ACTION_SEQUENCE [TUPLE [ASSIGNER_CALL_AS]]

	binary_pre_actions, binary_post_actions: ACTION_SEQUENCE [TUPLE [BINARY_AS]]

	bin_eq_pre_actions, bin_eq_post_actions: ACTION_SEQUENCE [TUPLE [BIN_EQ_AS]]

	bin_ge_pre_actions, bin_ge_post_actions: ACTION_SEQUENCE [TUPLE [BIN_GE_AS]]

	bin_gt_pre_actions, bin_gt_post_actions: ACTION_SEQUENCE [TUPLE [BIN_GT_AS]]

	bin_le_pre_actions, bin_le_post_actions: ACTION_SEQUENCE [TUPLE [BIN_LE_AS]]

	bin_lt_pre_actions, bin_lt_post_actions: ACTION_SEQUENCE [TUPLE [BIN_LT_AS]]

	bin_ne_pre_actions, bin_ne_post_actions: ACTION_SEQUENCE [TUPLE [BIN_NE_AS]]

	bin_not_tilde_pre_actions, bin_not_tilde_post_actions: ACTION_SEQUENCE [TUPLE [BIN_NOT_TILDE_AS]]

	bin_tilde_pre_actions, bin_tilde_post_actions: ACTION_SEQUENCE [TUPLE [BIN_TILDE_AS]]

	body_pre_actions, body_post_actions: ACTION_SEQUENCE [TUPLE [BODY_AS]]

	bracket_pre_actions, bracket_post_actions: ACTION_SEQUENCE [TUPLE [BRACKET_AS]]

	case_pre_actions, case_post_actions: ACTION_SEQUENCE [TUPLE [CASE_AS]]

	class_pre_actions, class_post_actions: ACTION_SEQUENCE [TUPLE [CLASS_AS]]

	converted_expr_pre_actions, converted_expr_post_actions: ACTION_SEQUENCE [TUPLE [CONVERTED_EXPR_AS]]

	create_pre_actions, create_post_actions: ACTION_SEQUENCE [TUPLE [CREATE_AS]]

	creation_pre_actions, creation_post_actions: ACTION_SEQUENCE [TUPLE [CREATION_AS]]

	do_pre_actions, do_post_actions: ACTION_SEQUENCE [TUPLE [DO_AS]]

	eiffel_list_pre_actions, eiffel_list_post_actions: ACTION_SEQUENCE [TUPLE [EIFFEL_LIST [AST_EIFFEL]]]

	elseif_pre_actions, elseif_post_actions: ACTION_SEQUENCE [TUPLE [ELSIF_AS]]

	expression_call_pre_actions, expression_call_post_actions: ACTION_SEQUENCE [EXPR_CALL_AS]

	feature_pre_actions, feature_post_actions: ACTION_SEQUENCE [TUPLE [FEATURE_AS]]

	feature_clause_pre_actions, feature_clause_post_actions: ACTION_SEQUENCE [TUPLE [FEATURE_CLAUSE_AS]]

	guard_pre_actions, guard_post_actions: ACTION_SEQUENCE [TUPLE [GUARD_AS]]

	id_pre_actions, id_post_actions: ACTION_SEQUENCE [TUPLE [ID_AS]]

	if_pre_actions, if_post_actions: ACTION_SEQUENCE [TUPLE [IF_AS]]

	if_expression_pre_actions, if_expression_post_actions: ACTION_SEQUENCE [TUPLE [IF_EXPRESSION_AS]]

	inline_agent_creation_pre_actions, inline_agent_creation_post_actions: ACTION_SEQUENCE [TUPLE [INLINE_AGENT_CREATION_AS]]

	inspect_pre_actions, inspect_post_actions: ACTION_SEQUENCE [TUPLE [INSPECT_AS]]

	instruction_call_pre_actions, instruction_call_post_actions: ACTION_SEQUENCE [TUPLE [INSTR_CALL_AS]]

	invariant_pre_actions, invariant_post_actions: ACTION_SEQUENCE [INVARIANT_AS]

	loop_pre_actions, loop_post_actions: ACTION_SEQUENCE [TUPLE [LOOP_AS]]

	loop_iteration_pre_actions, loop_iteration_post_actions: ACTION_SEQUENCE [TUPLE [ITERATION_AS, LOOP_AS]]

	loop_from_pre_actions, loop_from_post_actions: ACTION_SEQUENCE [TUPLE [EIFFEL_LIST [INSTRUCTION_AS], LOOP_AS]]

	loop_invariant_pre_actions, loop_invariant_post_actions: ACTION_SEQUENCE [TUPLE [EIFFEL_LIST [TAGGED_AS], LOOP_AS]]

	loop_exit_pre_actions, loop_exit_post_actions: ACTION_SEQUENCE [TUPLE [EXPR_AS, LOOP_AS]]

	loop_body_pre_actions, loop_body_post_actions: ACTION_SEQUENCE [TUPLE [EIFFEL_LIST [INSTRUCTION_AS], LOOP_AS]]

	loop_variant_pre_actions, loop_variant_post_actions: ACTION_SEQUENCE [TUPLE [VARIANT_AS, LOOP_AS]]

	nested_expr_pre_actions, nested_expr_post_actions: ACTION_SEQUENCE [NESTED_EXPR_AS]

	object_test_pre_actions, object_test_post_actions: ACTION_SEQUENCE [TUPLE [OBJECT_TEST_AS]]

	once_pre_actions, once_post_actions: ACTION_SEQUENCE [TUPLE [ONCE_AS]]

	paran_pre_actions, paran_post_actions: ACTION_SEQUENCE [TUPLE [PARAN_AS]]

	parameter_list_pre_actions, parameter_list_post_actions: ACTION_SEQUENCE [TUPLE [PARAMETER_LIST_AS]]

	precursor_pre_actions, precursor_post_actions: ACTION_SEQUENCE [TUPLE [PRECURSOR_AS]]

	predecessor_pre_actions, predecessor_post_actions: ACTION_SEQUENCE [TUPLE [PREDECESSOR_AS]]

	routine_pre_actions, routine_post_actions: ACTION_SEQUENCE [TUPLE [ROUTINE_AS]]

	static_access_pre_actions, static_access_post_actions: ACTION_SEQUENCE [TUPLE [STATIC_ACCESS_AS]]

	unary_pre_actions, unary_post_actions: ACTION_SEQUENCE [TUPLE [UNARY_AS]]

	un_not_pre_actions, un_not_post_actions: ACTION_SEQUENCE [TUPLE [UN_NOT_AS]]

	integer_pre_actions, integer_post_actions: ACTION_SEQUENCE [TUPLE [INTEGER_AS]]

	real_pre_actions, real_post_actions: ACTION_SEQUENCE [TUPLE [REAL_AS]]

feature {CA_RULE_CHECKING_TASK} -- Execution Commands

	run_on_class (a_class_to_check: CLASS_C)
			-- Check all rules that have added their agents.
		local
			l_ast: CLASS_AS
		do
			l_ast := a_class_to_check.ast
			class_pre_actions.call (l_ast)
			process_class_as (l_ast)
			class_post_actions.call (l_ast)
		end

feature {NONE} -- Processing

	process_access_feat_as (a_id: ACCESS_FEAT_AS)
		local
			old_is_assigner_call: BOOLEAN
		do
			access_feat_pre_actions.call ([a_id])
			old_is_assigner_call := is_assigner_call
			is_assigner_call := False
			Precursor (a_id)
			is_assigner_call := old_is_assigner_call
			access_feat_post_actions.call ([a_id])
		end

	process_access_id_as (a_id: ACCESS_ID_AS)
		do
			access_id_pre_actions.call ([a_id])
			Precursor (a_id)
			access_id_post_actions.call ([a_id])
		end

	process_address_as (a: ADDRESS_AS)
		do
			address_pre_actions.call (a)
			Precursor (a)
			address_post_actions.call (a)
		end

	process_agent_routine_creation_as (a: AGENT_ROUTINE_CREATION_AS)
		do
			agent_routine_pre_action.call (a)
			Precursor (a)
			agent_routine_post_action.call (a)
		end

	process_array_as (a: ARRAY_AS)
			-- <Precursor>
		do
			array_pre_actions.call (a)
			Precursor (a)
			array_post_actions.call (a)
		end

	process_assign_as (a: ASSIGN_AS)
			-- <Precursor>
		do
			assign_pre_actions.call (a)
			is_assign := True
			a.target.process (Current)
			is_assign := False
			a.source.process (Current)
			assign_post_actions.call (a)
		end

	process_assigner_call_as (a: ASSIGNER_CALL_AS)
		do
			assigner_call_pre_actions.call (a)
			a.source.process (Current)
			is_assigner_call := True
			a.target.process (Current)
			is_assigner_call := False
			assigner_call_post_actions.call (a)
		end

	process_binary_as (a: BINARY_AS)
		local
			old_is_assigner_call: BOOLEAN
		do
			binary_pre_actions.call ([a])
			old_is_assigner_call := is_assigner_call
			is_assigner_call := False
			Precursor (a)
			is_assigner_call := old_is_assigner_call
			binary_post_actions.call ([a])
		end

	process_bin_eq_as (a: BIN_EQ_AS)
		do
			bin_eq_pre_actions.call (a)
			a.left.process (Current)
			a.right.process (Current)
			bin_eq_post_actions.call (a)
		end

	process_bin_ge_as (a_bin_ge: BIN_GE_AS)
		do
			bin_ge_pre_actions.call ([a_bin_ge])
			Precursor (a_bin_ge)
			bin_ge_post_actions.call ([a_bin_ge])
		end

	process_bin_gt_as (a_bin_gt: BIN_GT_AS)
		do
			bin_gt_pre_actions.call ([a_bin_gt])
			Precursor (a_bin_gt)
			bin_gt_post_actions.call ([a_bin_gt])
		end

	process_bin_le_as (a_bin_le: BIN_LE_AS)
		do
			bin_le_pre_actions.call ([a_bin_le])
			Precursor (a_bin_le)
			bin_le_post_actions.call ([a_bin_le])
		end

	process_bin_lt_as (a_bin_lt: BIN_LT_AS)
		do
			bin_lt_pre_actions.call ([a_bin_lt])
			Precursor (a_bin_lt)
			bin_lt_post_actions.call ([a_bin_lt])
		end

	process_bin_ne_as (a: BIN_NE_AS)
		do
			bin_ne_pre_actions.call (a)
			a.left.process (Current)
			a.right.process (Current)
			bin_ne_post_actions.call (a)
		end

	process_bin_not_tilde_as (a: BIN_NOT_TILDE_AS)
			-- <Precursor>
		do
			bin_not_tilde_pre_actions.call (a)
			a.left.process (Current)
			a.right.process (Current)
			bin_not_tilde_post_actions.call (a)
		end

	process_bin_tilde_as (a: BIN_TILDE_AS)
			-- <Precursor>
		do
			bin_tilde_pre_actions.call (a)
			a.left.process (Current)
			a.right.process (Current)
			bin_tilde_post_actions.call (a)
		end

	process_body_as (a_body: BODY_AS)
		do
			body_pre_actions.call ([a_body])
			Precursor (a_body)
			body_post_actions.call ([a_body])
		end

	process_bracket_as (a: BRACKET_AS)
		local
			old_is_assigner_call: BOOLEAN
		do
			bracket_pre_actions.call ([a])
			old_is_assigner_call := is_assigner_call
			is_assigner_call := False
			Precursor (a)
			is_assigner_call := old_is_assigner_call
			bracket_post_actions.call ([a])
		end

	process_case_as (a_case: CASE_AS)
		do
			case_pre_actions.call ([a_case])
			Precursor (a_case)
			case_post_actions.call ([a_case])
		end

	process_converted_expr_as (a_conv: CONVERTED_EXPR_AS)
		do
			converted_expr_pre_actions.call ([a_conv])
			Precursor (a_conv)
			converted_expr_post_actions.call ([a_conv])
		end

	process_create_as (a_create: CREATE_AS)
		do
			create_pre_actions.call ([a_create])
			Precursor (a_create)
			create_post_actions.call ([a_create])
		end

	process_creation_as (a: CREATION_AS)
		do
			creation_pre_actions.call (a)
			is_assign := True
			a.target.process (Current)
			is_assign := False
			safe_process (a.type)
			safe_process (a.call)
			creation_post_actions.call (a)
		end

	process_do_as (a_do: DO_AS)
		do
			do_pre_actions.call ([a_do])
			Precursor (a_do)
			do_post_actions.call ([a_do])
		end

	process_eiffel_list (a_list: EIFFEL_LIST [AST_EIFFEL])
		do
			eiffel_list_pre_actions.call ([a_list])
			Precursor (a_list)
			eiffel_list_post_actions.call ([a_list])
		end

	process_elseif_as (a_elseif: ELSIF_AS)
		do
			elseif_pre_actions.call ([a_elseif])
			Precursor (a_elseif)
			elseif_post_actions.call ([a_elseif])
		end

	process_expr_call_as (a: EXPR_CALL_AS)
			-- <Precursor>
		do
			expression_call_pre_actions.call (a)
			Precursor (a)
			expression_call_post_actions.call (a)
		end

	process_feature_as (a_feature: FEATURE_AS)
		do
			feature_pre_actions.call ([a_feature])
			Precursor (a_feature)
			feature_post_actions.call ([a_feature])
		end

	process_feature_clause_as (a_clause: FEATURE_CLAUSE_AS)
		do
			feature_clause_pre_actions.call ([a_clause])
			Precursor (a_clause)
			feature_clause_post_actions.call ([a_clause])
		end

	process_guard_as (a: GUARD_AS)
		do
			guard_pre_actions.call (a)
			Precursor (a)
			guard_post_actions.call (a)
		end

	process_id_as (a_id: ID_AS)
		do
			id_pre_actions.call ([a_id])
			Precursor (a_id)
			id_post_actions.call ([a_id])
		end

	process_if_as (a_if: IF_AS)
		do
			if_pre_actions.call ([a_if])
			Precursor (a_if)
			if_post_actions.call ([a_if])
		end

	process_if_expression_as (a: IF_EXPRESSION_AS)
		do
			if_expression_pre_actions.call (a)
			Precursor (a)
			if_expression_post_actions.call (a)
		end

	process_inline_agent_creation_as (a: INLINE_AGENT_CREATION_AS)
		do
			inline_agent_creation_pre_actions.call (a)
			Precursor (a)
			inline_agent_creation_post_actions.call (a)
		end

	process_inspect_as (a_inspect: INSPECT_AS)
		do
			inspect_pre_actions.call ([a_inspect])
			Precursor (a_inspect)
			inspect_post_actions.call ([a_inspect])
		end

	process_instr_call_as (a_call: INSTR_CALL_AS)
		do
			instruction_call_pre_actions.call ([a_call])
			Precursor (a_call)
			instruction_call_post_actions.call ([a_call])
		end

	process_invariant_as (a: INVARIANT_AS)
		do
			invariant_pre_actions.call (a)
			Precursor (a)
			invariant_post_actions.call (a)
		end

	process_loop_as (a: LOOP_AS)
			-- <Precursor>
		do
			loop_pre_actions.call (a)
			if attached a.iteration as p then
				loop_iteration_pre_actions.call (p, a)
				p.process (Current)
				loop_iteration_post_actions.call (p, a)
			end
			if attached a.from_part as p then
				loop_from_pre_actions.call (p, a)
				p.process (Current)
				loop_from_post_actions.call (p, a)
			end
			if attached a.invariant_part as p then
				loop_invariant_pre_actions.call (p, a)
				p.process (Current)
				loop_invariant_post_actions.call (p, a)
			end
			if attached a.stop as p then
				loop_exit_pre_actions.call (p, a)
				p.process (Current)
				loop_exit_post_actions.call (p, a)
			end
			if attached a.compound as p then
				loop_body_pre_actions.call (p, a)
				p.process (Current)
				loop_body_post_actions.call (p, a)
			end
			if attached a.variant_part as p then
				loop_variant_pre_actions.call (p, a)
				p.process (Current)
				loop_variant_post_actions.call (p, a)
			end
			loop_post_actions.call (a)
		end

	process_nested_expr_as (a: NESTED_EXPR_AS)
		local
			old_is_assigner_call: BOOLEAN
		do
			nested_expr_pre_actions.call (a)
			old_is_assigner_call := is_assigner_call
			is_assigner_call := False
			a.target.process (Current)
			is_assigner_call := old_is_assigner_call
			a.message.process (Current)
			nested_expr_post_actions.call (a)
		end

	process_object_test_as (a_ot: OBJECT_TEST_AS)
		do
			object_test_pre_actions.call ([a_ot])
			Precursor (a_ot)
			object_test_post_actions.call ([a_ot])
		end

	process_once_as (a_once: ONCE_AS)
		do
			once_pre_actions.call ([a_once])
			Precursor (a_once)
			once_post_actions.call ([a_once])
		end

	process_parameter_list_as (a: PARAMETER_LIST_AS)
		do
			parameter_list_pre_actions.call ([a])
			Precursor (a)
			parameter_list_post_actions.call ([a])
		end

	process_paran_as (a_paran: PARAN_AS)
		do
			paran_pre_actions.call ([a_paran])
			Precursor (a_paran)
			paran_post_actions.call ([a_paran])
		end

	process_precursor_as (a: PRECURSOR_AS)
		do
			precursor_pre_actions.call (a)
			Precursor (a)
			precursor_post_actions.call (a)
		end

	process_predecessor_as (a: PREDECESSOR_AS)
		do
			predecessor_pre_actions.call (a)
			Precursor (a)
			predecessor_post_actions.call (a)
		end

	process_routine_as (a_routine: ROUTINE_AS)
		do
			routine_pre_actions.call ([a_routine])
			Precursor (a_routine)
			routine_post_actions.call ([a_routine])
		end

	process_static_access_as (a: STATIC_ACCESS_AS)
		do
			static_access_pre_actions.call (a)
			Precursor (a)
			static_access_post_actions.call (a)
		end

	process_un_not_as (a_un_not: UN_NOT_AS)
		do
			un_not_pre_actions.call ([a_un_not])
			Precursor (a_un_not)
			un_not_post_actions.call ([a_un_not])
		end

	process_unary_as (a_unary: UNARY_AS)
		local
			old_is_assigner_call: BOOLEAN
		do
			unary_pre_actions.call ([a_unary])
			old_is_assigner_call := is_assigner_call
			is_assigner_call := False
			Precursor (a_unary)
			is_assigner_call := old_is_assigner_call
			unary_post_actions.call ([a_unary])
		end

	process_integer_as (a_integer: INTEGER_AS)
		do
			integer_pre_actions.call ([a_integer])
			Precursor (a_integer)
			integer_post_actions.call ([a_integer])
		end

	process_real_as (a_real: REAL_AS)
		do
			real_pre_actions.call ([a_real])
			Precursor (a_real)
			real_post_actions.call ([a_real])
		end

note
	ca_ignore: "CA033", "CA033: very long class"
	copyright:	"Copyright (c) 2014-2020, Eiffel Software"
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
