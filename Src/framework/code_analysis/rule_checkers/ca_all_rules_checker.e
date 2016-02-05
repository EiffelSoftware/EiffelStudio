note
	description: "[
				   Checks a set of (standard) rules (see {CA_STANDARD_RULE}). The rules have to
				   register their AST visitor agents here.
		          ]"
	author: "Stefan Zurfluh"
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
			process_create_creation_as,
			process_bang_creation_as,
			process_create_creation_expr_as,
			process_bang_creation_expr_as,
			process_keyword_as,
			process_symbol_as,
			process_break_as,
			process_leaf_stub_as,
			process_symbol_stub_as,
			process_keyword_stub_as
		redefine
			process_access_id_as,
			process_assign_as,
			process_assigner_call_as,
			process_bang_creation_as,
			process_bin_eq_as,
			process_bin_ge_as,
			process_bin_gt_as,
			process_bin_le_as,
			process_bin_lt_as,
			process_bin_ne_as,
			process_body_as,
			process_case_as,
			process_converted_expr_as,
			process_create_as,
			process_create_creation_as,
			process_creation_as,
			process_do_as,
			process_eiffel_list,
			process_elseif_as,
			process_feature_as,
			process_feature_clause_as,
			process_id_as,
			process_if_as,
			process_inline_agent_creation_as,
			process_inspect_as,
			process_instr_call_as,
			process_loop_as,
			process_nested_as,
			process_object_test_as,
			process_once_as,
			process_paran_as,
			process_routine_as,
			process_unary_as,
			process_un_not_as,
			process_integer_as,
			process_real_as
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			last_run_successful := False

			create_action_lists
		end

	create_action_lists
			-- Creates all the lists of agents that will be called when visiting
			-- certain AST nodes.
		do
			create access_id_pre_actions
			create access_id_post_actions
			create assign_pre_actions
			create assign_post_actions
			create assigner_call_pre_actions
			create assigner_call_post_actions
			create bang_creation_pre_actions
			create bang_creation_post_actions
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
			create body_pre_actions
			create body_post_actions
			create case_pre_actions
			create case_post_actions
			create class_pre_actions
			create class_post_actions
			create converted_expr_pre_actions
			create converted_expr_post_actions
			create create_pre_actions
			create create_post_actions
			create create_creation_pre_actions
			create create_creation_post_actions
			create creation_pre_actions
			create creation_post_actions
			create do_pre_actions
			create do_post_actions
			create eiffel_list_pre_actions
			create eiffel_list_post_actions
			create elseif_pre_actions
			create elseif_post_actions
			create feature_pre_actions
			create feature_post_actions
			create feature_clause_pre_actions
			create feature_clause_post_actions
			create id_pre_actions
			create id_post_actions
			create if_pre_actions
			create if_post_actions
			create inspect_pre_actions
			create inspect_post_actions
			create instruction_call_pre_actions
			create instruction_call_post_actions
			create loop_pre_actions
			create loop_post_actions
			create nested_pre_actions
			create nested_post_actions
			create object_test_pre_actions
			create object_test_post_actions
			create once_pre_actions
			create once_post_actions
			create paran_pre_actions
			create paran_post_actions
			create routine_pre_actions
			create routine_post_actions
			create unary_pre_actions
			create unary_post_actions
			create un_not_pre_actions
			create un_not_post_actions
			create integer_pre_actions
			create integer_post_actions
			create real_pre_actions
			create real_post_actions
		end

feature {CA_STANDARD_RULE} -- Adding agents

	add_access_id_pre_action (a_action: attached PROCEDURE [ACCESS_ID_AS])
		do
			access_id_pre_actions.extend (a_action)
		end

	add_access_id_post_action (a_action: attached PROCEDURE [ACCESS_ID_AS])
		do
			access_id_post_actions.extend (a_action)
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

	add_bang_creation_pre_action (a_action: attached PROCEDURE [BANG_CREATION_AS])
		do
			bang_creation_pre_actions.extend (a_action)
		end

	add_bang_creation_post_action (a_action: attached PROCEDURE [BANG_CREATION_AS])
		do
			bang_creation_post_actions.extend (a_action)
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

	add_body_pre_action (a_action: attached PROCEDURE [BODY_AS])		do
			body_pre_actions.extend (a_action)
		end

	add_body_post_action (a_action: attached PROCEDURE [BODY_AS])
		do
			body_post_actions.extend (a_action)
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

	add_create_creation_pre_action (a_action: attached PROCEDURE [CREATE_CREATION_AS])
		do
			create_creation_pre_actions.extend (a_action)
		end

	add_create_creation_post_action (a_action: attached PROCEDURE [CREATE_CREATION_AS])
		do
			create_creation_post_actions.extend (a_action)
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

	add_loop_pre_action (a_action: attached PROCEDURE [LOOP_AS])
		do
			loop_pre_actions.extend (a_action)
		end

	add_loop_post_action (a_action: attached PROCEDURE [LOOP_AS])
		do
			loop_post_actions.extend (a_action)
		end

	add_nested_pre_action (a_action: attached PROCEDURE [NESTED_AS])
		do
			nested_pre_actions.extend (a_action)
		end

	add_nested_post_action (a_action: attached PROCEDURE [NESTED_AS])
		do
			nested_post_actions.extend (a_action)
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

	add_paran_pre_action (a_action: attached PROCEDURE [PARAN_AS])
		do
			paran_pre_actions.extend (a_action)
		end

	add_paran_post_action (a_action: attached PROCEDURE [PARAN_AS])
		do
			paran_post_actions.extend (a_action)
		end

	add_routine_pre_action (a_action: attached PROCEDURE [ROUTINE_AS])
		do
			routine_pre_actions.extend (a_action)
		end

	add_routine_post_action (a_action: attached PROCEDURE [ROUTINE_AS])
		do
			routine_post_actions.extend (a_action)
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

	access_id_pre_actions, access_id_post_actions: ACTION_SEQUENCE [TUPLE [ACCESS_ID_AS]]

	assign_pre_actions, assign_post_actions: ACTION_SEQUENCE [TUPLE [ASSIGN_AS]]

	assigner_call_pre_actions, assigner_call_post_actions: ACTION_SEQUENCE [TUPLE [ASSIGNER_CALL_AS]]

	bang_creation_pre_actions, bang_creation_post_actions: ACTION_SEQUENCE [TUPLE [BANG_CREATION_AS]]

	bin_eq_pre_actions, bin_eq_post_actions: ACTION_SEQUENCE [TUPLE [BIN_EQ_AS]]

	bin_ge_pre_actions, bin_ge_post_actions: ACTION_SEQUENCE [TUPLE [BIN_GE_AS]]

	bin_gt_pre_actions, bin_gt_post_actions: ACTION_SEQUENCE [TUPLE [BIN_GT_AS]]

	bin_le_pre_actions, bin_le_post_actions: ACTION_SEQUENCE [TUPLE [BIN_LE_AS]]

	bin_lt_pre_actions, bin_lt_post_actions: ACTION_SEQUENCE [TUPLE [BIN_LT_AS]]

	bin_ne_pre_actions, bin_ne_post_actions: ACTION_SEQUENCE [TUPLE [BIN_NE_AS]]

	body_pre_actions, body_post_actions: ACTION_SEQUENCE [TUPLE [BODY_AS]]

	case_pre_actions, case_post_actions: ACTION_SEQUENCE [TUPLE [CASE_AS]]

	class_pre_actions, class_post_actions: ACTION_SEQUENCE [TUPLE [CLASS_AS]]

	converted_expr_pre_actions, converted_expr_post_actions: ACTION_SEQUENCE [TUPLE [CONVERTED_EXPR_AS]]

	create_pre_actions, create_post_actions: ACTION_SEQUENCE [TUPLE [CREATE_AS]]

	create_creation_pre_actions, create_creation_post_actions: ACTION_SEQUENCE [TUPLE [CREATE_CREATION_AS]]

	creation_pre_actions, creation_post_actions: ACTION_SEQUENCE [TUPLE [CREATION_AS]]

	do_pre_actions, do_post_actions: ACTION_SEQUENCE [TUPLE [DO_AS]]

	eiffel_list_pre_actions, eiffel_list_post_actions: ACTION_SEQUENCE [TUPLE [EIFFEL_LIST [AST_EIFFEL]]]

	elseif_pre_actions, elseif_post_actions: ACTION_SEQUENCE [TUPLE [ELSIF_AS]]

	feature_pre_actions, feature_post_actions: ACTION_SEQUENCE [TUPLE [FEATURE_AS]]

	feature_clause_pre_actions, feature_clause_post_actions: ACTION_SEQUENCE [TUPLE [FEATURE_CLAUSE_AS]]

	id_pre_actions, id_post_actions: ACTION_SEQUENCE [TUPLE [ID_AS]]

	if_pre_actions, if_post_actions: ACTION_SEQUENCE [TUPLE [IF_AS]]

	inspect_pre_actions, inspect_post_actions: ACTION_SEQUENCE [TUPLE [INSPECT_AS]]

	instruction_call_pre_actions, instruction_call_post_actions: ACTION_SEQUENCE [TUPLE [INSTR_CALL_AS]]

	loop_pre_actions, loop_post_actions: ACTION_SEQUENCE [TUPLE [LOOP_AS]]

	nested_pre_actions, nested_post_actions: ACTION_SEQUENCE [TUPLE [NESTED_AS]]

	object_test_pre_actions, object_test_post_actions: ACTION_SEQUENCE [TUPLE [OBJECT_TEST_AS]]

	once_pre_actions, once_post_actions: ACTION_SEQUENCE [TUPLE [ONCE_AS]]

	paran_pre_actions, paran_post_actions: ACTION_SEQUENCE [TUPLE [PARAN_AS]]

	routine_pre_actions, routine_post_actions: ACTION_SEQUENCE [TUPLE [ROUTINE_AS]]

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
			last_run_successful := False
			l_ast := a_class_to_check.ast
			class_pre_actions.call (l_ast)
			process_class_as (l_ast)
			class_post_actions.call (l_ast)
			last_run_successful := True
		end

feature {NONE} -- Processing

	process_access_id_as (a_id: ACCESS_ID_AS)
		do
			access_id_pre_actions.call ([a_id])
			Precursor (a_id)
			access_id_post_actions.call ([a_id])
		end

	process_assign_as (a_assign: ASSIGN_AS)
		do
			assign_pre_actions.call ([a_assign])
			Precursor (a_assign)
			assign_post_actions.call ([a_assign])
		end

	process_assigner_call_as (a_assigner_call: ASSIGNER_CALL_AS)
		do
			assigner_call_pre_actions.call ([a_assigner_call])
			Precursor (a_assigner_call)
			assigner_call_post_actions.call ([a_assigner_call])
		end

	process_bang_creation_as (a_bang_creation: BANG_CREATION_AS)
		do
			bang_creation_pre_actions.call ([a_bang_creation])
			Precursor (a_bang_creation)
			bang_creation_post_actions.call ([a_bang_creation])
		end

	process_bin_eq_as (a_bin_eq: BIN_EQ_AS)
		do
			bin_eq_pre_actions.call ([a_bin_eq])
			Precursor (a_bin_eq)
			bin_eq_post_actions.call ([a_bin_eq])
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

	process_bin_ne_as (a_bin_ne: BIN_NE_AS)
		do
			bin_ne_pre_actions.call ([a_bin_ne])
			Precursor (a_bin_ne)
			bin_ne_post_actions.call ([a_bin_ne])
		end

	process_body_as (a_body: BODY_AS)
		do
			body_pre_actions.call ([a_body])
			Precursor (a_body)
			body_post_actions.call ([a_body])
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

	process_create_creation_as (a_create_creation: CREATE_CREATION_AS)
		do
			create_creation_pre_actions.call ([a_create_creation])
			Precursor (a_create_creation)
			create_creation_post_actions.call ([a_create_creation])
		end

	process_creation_as (a_creation: CREATION_AS)
		do
			creation_pre_actions.call ([a_creation])
			Precursor (a_creation)
			creation_post_actions.call ([a_creation])
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

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
		do
			-- TODO: 2014-09-22 Processing of inline agent body fails due to feature pre and post processing not being
			-- called. We simply ignore bodies of inline agents for now and do not process them.
			--safe_process (l_as.body)
			safe_process (l_as.operands)
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

	process_loop_as (a_loop: LOOP_AS)
		do
			loop_pre_actions.call ([a_loop])
			Precursor (a_loop)
			loop_post_actions.call ([a_loop])
		end

	process_nested_as (a_nested: NESTED_AS)
		do
			nested_pre_actions.call ([a_nested])
			Precursor (a_nested)
			nested_post_actions.call ([a_nested])
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

	process_paran_as (a_paran: PARAN_AS)
		do
			paran_pre_actions.call ([a_paran])
			Precursor (a_paran)
			paran_post_actions.call ([a_paran])
		end

	process_routine_as (a_routine: ROUTINE_AS)
		do
			routine_pre_actions.call ([a_routine])
			Precursor (a_routine)
			routine_post_actions.call ([a_routine])
		end

	process_un_not_as (a_un_not: UN_NOT_AS)
		do
			un_not_pre_actions.call ([a_un_not])
			Precursor (a_un_not)
			un_not_post_actions.call ([a_un_not])
		end

	process_unary_as (a_unary: UNARY_AS)
		do
			unary_pre_actions.call ([a_unary])
			Precursor (a_unary)
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

feature -- Results

	last_run_successful: BOOLEAN

feature {NONE} -- Implementation

	frozen rota: detachable ROTA_S
			-- Access to rota service
		local
			l_service_consumer: SERVICE_CONSUMER [ROTA_S]
		do
			create l_service_consumer
			if attached l_service_consumer.service as l_service and then l_service.is_interface_usable then
				Result := l_service
			end
		end
end
