note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_VISITOR

inherit

	BYTE_NODE_VISITOR

	SHARED_SERVER
		export {NONE} all end

	INTERNAL_COMPILER_STRING_EXPORTER
		export {NONE} all end

feature {BYTE_NODE} -- Visitors

	process_access_expr_b (a_node: ACCESS_EXPR_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_address_b (a_node: ADDRESS_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_argument_b (a_node: ARGUMENT_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_array_const_b (a_node: ARRAY_CONST_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expressions)
		end

	process_assert_b (a_node: ASSERT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_assign_b (a_node: ASSIGN_B)
			-- Process `a_node'.
		do
			safe_process (a_node.target)
			safe_process (a_node.source)
		end

	process_attribute_b (a_node: ATTRIBUTE_B)
			-- <Precursor>
		do
			-- No Subnode
		end

	process_bin_and_b (a_node: BIN_AND_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_and_then_b (a_node: B_AND_THEN_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_div_b (a_node: BIN_DIV_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_eq_b (a_node: BIN_EQ_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_free_b (a_node: BIN_FREE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_ge_b (a_node: BIN_GE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_gt_b (a_node: BIN_GT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_le_b (a_node: BIN_LE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_lt_b (a_node: BIN_LT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_mod_b (a_node: BIN_MOD_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_ne_b (a_node: BIN_NE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_or_b (a_node: BIN_OR_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_plus_b (a_node: BIN_PLUS_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_power_b (a_node: BIN_POWER_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_slash_b (a_node: BIN_SLASH_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_star_b (a_node: BIN_STAR_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_xor_b (a_node: BIN_XOR_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bool_const_b (a_node: BOOL_CONST_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE])
			-- Process `a_node'.
		local
			i: INTEGER
			c: INTEGER
		do
			from
				i := 1
				c := a_node.count
			until
				i > c
			loop
				safe_process (a_node.i_th (i))
				i := i + 1
			end
		end

	process_case_b (a_node: CASE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.compound)
			safe_process (a_node.interval)
		end

	process_case_expression_b (b: CASE_EXPRESSION_B)
			-- <Precursor>
		do
			safe_process (b.interval)
			safe_process (b.content)
		end

	process_char_const_b (a_node: CHAR_CONST_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_char_val_b (a_node: CHAR_VAL_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_check_b (a_node: CHECK_B)
			-- Process `a_node'.
		do
			safe_process (a_node.check_list)
		end

	process_constant_b (a_node: CONSTANT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- Process `a_node'.
		do
			safe_process (a_node.call)
		end

	process_current_b (a_node: CURRENT_B)
			-- Process `a_node'.
		do
			-- No subnode
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B)
			-- Process `a_node'.
		do
			check no_cil: false end
		end

	process_debug_b (a_node: DEBUG_B)
			-- Process `a_node'.
		do
			safe_process (a_node.compound)
		end

	process_elsif_b (a_node: ELSIF_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_elsif_expression_b (a_node: ELSIF_EXPRESSION_B)
			-- Process `a_node'.
		do
			safe_process (a_node.condition)
			safe_process (a_node.expression)
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_external_b (a_node: EXTERNAL_B)
			-- Process `a_node'.
		do
			safe_process (a_node.parameters)
		end

	process_feature_b (a_node: FEATURE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.parameters)
		end

	process_agent_call_b (a_node: AGENT_CALL_B)
		do
			safe_process (a_node.parameters)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_guard_b (a_node: GUARD_B)
			-- Process `a_node'.
		do
			safe_process (a_node.check_list)
			safe_process (a_node.compound)
		end

	process_hector_b (a_node: HECTOR_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
			safe_process (a_node.expr)
		end

	process_if_b (a_node: IF_B)
			-- Process `a_node'.
		do
			safe_process (a_node.condition)
			safe_process (a_node.compound)
			safe_process (a_node.elsif_list)
			safe_process (a_node.else_part)
		end

	process_if_expression_b (a_node: IF_EXPRESSION_B)
			-- Process `a_node'.
		do
			safe_process (a_node.condition)
			safe_process (a_node.then_expression)
			safe_process (a_node.elsif_list)
			safe_process (a_node.else_expression)
		end

	process_inspect_b (a_node: INSPECT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.switch)
			safe_process (a_node.case_list)
			safe_process (a_node.else_part)
		end

	process_inspect_expression_b (b: INSPECT_EXPRESSION_B)
			-- <Precursor>
		do
			safe_process (b.switch)
			safe_process (b.case_list)
			safe_process (b.else_part)
		end

	process_instr_call_b (a_node: INSTR_CALL_B)
			-- Process `a_node'.
		do
			safe_process (a_node.call)
		end

	process_instr_list_b (a_node: INSTR_LIST_B)
			-- Process `a_node'.
		do
			safe_process (a_node.compound)
		end

	process_int64_val_b (a_node: INT64_VAL_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_int_val_b (a_node: INT_VAL_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_integer_constant (a_node: INTEGER_CONSTANT)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_inv_assert_b (a_node: INV_ASSERT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_invariant_b (a_node: INVARIANT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.byte_list)
		end

	process_local_b (a_node: LOCAL_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_loop_b (a_node: LOOP_B)
			-- Process `a_node'.
		do
			safe_process (a_node.from_part)
			safe_process (a_node.stop)
			safe_process (a_node.invariant_part)
			safe_process (a_node.variant_part)
			safe_process (a_node.compound)
		end

	process_loop_expr_b (a_node: LOOP_EXPR_B)
			-- Process `a_node'.
		do
			a_node.iteration_code.process (Current)
			safe_process (a_node.invariant_code)
			safe_process (a_node.variant_code)
			a_node.iteration_exit_condition_code.process (Current)
			safe_process (a_node.exit_condition_code)
			a_node.expression_code.process (Current)
			a_node.advance_code.process (Current)
		end

	process_nat64_val_b (a_node: NAT64_VAL_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_nat_val_b (a_node: NAT_VAL_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_nested_b (a_node: NESTED_B)
			-- Process `a_node'.
		do
			safe_process (a_node.target)
			safe_process (a_node.message)
		end

	process_once_string_b (a_node: ONCE_STRING_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_operand_b (a_node: OPERAND_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_parameter_b (a_node: PARAMETER_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expression)
		end

	process_paran_b (a_node: PARAN_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_real_const_b (a_node: REAL_CONST_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_require_b (a_node: REQUIRE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_result_b (a_node: RESULT_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_retry_b (a_node: RETRY_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_reverse_b (a_node: REVERSE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.target)
			safe_process (a_node.source)
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B)
			-- Process `a_node'.
		do
			safe_process (a_node.arguments)
		end


	process_separate_b (a_node: SEPARATE_INSTRUCTION_B)
			-- Process `a_node'.
		do
			check not_implemented: False end
		end

	process_null_conversion_b (a_node: NULL_CONVERSION_B)
			-- Process `a_node'.
		do
			check not_implemented: False end
		end

	process_string_b (a_node: STRING_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_strip_b (a_node: STRIP_B)
			-- Process `a_node'.
		do
			-- No Subnode
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B)
			-- Process `a_node'.
		do
			safe_process (a_node.source)
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expressions)
		end

	process_type_expr_b (a_node: TYPE_EXPR_B)
			-- Process `a_node'.
		do
			-- No subnode
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B])
			-- Process `a_node'.
		do
			safe_process (a_node.lower)
			safe_process (a_node.upper)
		end

	process_un_free_b (a_node: UN_FREE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
			safe_process (a_node.expr)
		end

	process_un_minus_b (a_node: UN_MINUS_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
			safe_process (a_node.expr)
		end

	process_un_not_b (a_node: UN_NOT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
			safe_process (a_node.expr)
		end

	process_un_old_b (a_node: UN_OLD_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
			safe_process (a_node.expr)
		end

	process_un_plus_b (a_node: UN_PLUS_B)
			-- Process `a_node'.
		do
			safe_process (a_node.access)
			safe_process (a_node.expr)
		end

	process_variant_b (a_node: VARIANT_B)
			-- Process `a_node'.
		do
			safe_process (a_node.expr)
		end

	process_void_b (a_node: VOID_B)
			-- Process `a_node'.
		do
			-- No subnode
		end

	process_object_test_b (a_node: OBJECT_TEST_B)
			-- Process `a_node'.
		do
			safe_process (a_node.target)
			safe_process (a_node.expression)
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B)
			-- Process `a_node'.
		do
			-- No subnode
		end

	process_bin_tilde_b (a_node: BIN_TILDE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_bin_not_tilde_b (a_node: BIN_NOT_TILDE_B)
			-- Process `a_node'.
		do
			safe_process (a_node.left)
			safe_process (a_node.right)
		end

	process_std_byte_code (a_node: STD_BYTE_CODE)
			-- Process `a_node'.
		do
			safe_process (a_node.compound)
		end

	process_hidden_b (a_node: HIDDEN_B)
			-- Process `a_node'
		do
			-- Empty implementation to make current compile during EVE merge. 24.8.2010 Jasonw
		end

	process_hidden_if_b	(a_node: HIDDEN_IF_B)
			-- Process `a_node'.
		do
			process_if_b (a_node)
		end

	process_do_rescue_b (a_node: DO_RESCUE_B)
			-- Process `a_node'
		do
			-- Empty implementation to make current compile during EVE merge. 12.11.2010 Julian
		end

	process_try_b (a_node: TRY_B)
			-- Process `a_node'
		do
			-- Empty implementation to make current compile during EVE merge. 12.11.2010 Julian
		end

end
