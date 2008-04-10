indexing
	description: "Visitor for BYTE_NODE objects which does nothing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_NODE_NULL_VISITOR

inherit
	BYTE_NODE_VISITOR

feature {BYTE_NODE} -- Routine visitors

	process_std_byte_code (a_node: STD_BYTE_CODE) is
			-- Process `a_node'.
		do
		end

feature {BYTE_NODE} -- Visitors

	process_access_expr_b (a_node: ACCESS_EXPR_B) is
			-- Process `a_node'.
		do
		end

	process_address_b (a_node: ADDRESS_B) is
			-- Process `a_node'.
		do
		end

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		do
		end

	process_array_const_b (a_node: ARRAY_CONST_B) is
			-- Process `a_node'.
		do
		end

	process_assert_b (a_node: ASSERT_B) is
			-- Process `a_node'.
		do
		end

	process_assign_b (a_node: ASSIGN_B) is
			-- Process `a_node'.
		do
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_and_b (a_node: BIN_AND_B) is
			-- Process `a_node'.
		do
		end

	process_bin_and_then_b (a_node: B_AND_THEN_B) is
			-- Process `a_node'.
		do
		end

	process_bin_div_b (a_node: BIN_DIV_B) is
			-- Process `a_node'.
		do
		end

	process_bin_eq_b (a_node: BIN_EQ_B) is
			-- Process `a_node'.
		do
		end

	process_bin_free_b (a_node: BIN_FREE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_ge_b (a_node: BIN_GE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_gt_b (a_node: BIN_GT_B) is
			-- Process `a_node'.
		do
		end

	process_bin_implies_b (a_node: B_IMPLIES_B) is
			-- Process `a_node'.
		do
		end

	process_bin_le_b (a_node: BIN_LE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_lt_b (a_node: BIN_LT_B) is
			-- Process `a_node'.
		do
		end

	process_bin_minus_b (a_node: BIN_MINUS_B) is
			-- Process `a_node'.
		do
		end

	process_bin_mod_b (a_node: BIN_MOD_B) is
			-- Process `a_node'.
		do
		end

	process_bin_ne_b (a_node: BIN_NE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_not_tilde_b (a_node: BIN_NOT_TILDE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_or_b (a_node: BIN_OR_B) is
			-- Process `a_node'.
		do
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_plus_b (a_node: BIN_PLUS_B) is
			-- Process `a_node'.
		do
		end

	process_bin_power_b (a_node: BIN_POWER_B) is
			-- Process `a_node'.
		do
		end

	process_bin_slash_b (a_node: BIN_SLASH_B) is
			-- Process `a_node'.
		do
		end

	process_bin_star_b (a_node: BIN_STAR_B) is
			-- Process `a_node'.
		do
		end

	process_bin_tilde_b (a_node: BIN_TILDE_B) is
			-- Process `a_node'.
		do
		end

	process_bin_xor_b (a_node: BIN_XOR_B) is
			-- Process `a_node'.
		do
		end

	process_bit_const_b (a_node: BIT_CONST_B) is
			-- Process `a_node'.
		do
		end

	process_bool_const_b (a_node: BOOL_CONST_B) is
			-- Process `a_node'.
		do
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE]) is
			-- Process `a_node'.
		do
		end

	process_case_b (a_node: CASE_B) is
			-- Process `a_node'.
		do
		end

	process_char_const_b (a_node: CHAR_CONST_B) is
			-- Process `a_node'.
		do
		end

	process_char_val_b (a_node: CHAR_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_check_b (a_node: CHECK_B) is
			-- Process `a_node'.
		do
		end

	process_constant_b (a_node: CONSTANT_B) is
			-- Process `a_node'.
		do
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B) is
			-- Process `a_node'.
		do
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		do
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B) is
			-- Process `a_node'.
		do
		end

	process_debug_b (a_node: DEBUG_B) is
			-- Process `a_node'.
		do
		end

	process_elsif_b (a_node: ELSIF_B) is
			-- Process `a_node'.
		do
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B) is
			-- Process `a_node'.
		do
		end

	process_external_b (a_node: EXTERNAL_B) is
			-- Process `a_node'.
		do
		end

	process_feature_b (a_node: FEATURE_B) is
			-- Process `a_node'.
		do
		end

	process_agent_call_b (a_node: AGENT_CALL_B) is
			-- Process `a_node'.
		do
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B) is
			-- Process `a_node'.
		do
		end

	process_hector_b (a_node: HECTOR_B) is
			-- Process `a_node'.
		do
		end

	process_if_b (a_node: IF_B) is
			-- Process `a_node'.
		do
		end

	process_inspect_b (a_node: INSPECT_B) is
			-- Process `a_node'.
		do
		end

	process_instr_call_b (a_node: INSTR_CALL_B) is
			-- Process `a_node'.
		do
		end

	process_instr_list_b (a_node: INSTR_LIST_B) is
			-- Process `a_node'.
		do
		end

	process_int64_val_b (a_node: INT64_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_int_val_b (a_node: INT_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_integer_constant (a_node: INTEGER_CONSTANT) is
			-- Process `a_node'.
		do
		end

	process_inv_assert_b (a_node: INV_ASSERT_B) is
			-- Process `a_node'.
		do
		end

	process_invariant_b (a_node: INVARIANT_B) is
			-- Process `a_node'.
		do
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
		end

	process_loop_b (a_node: LOOP_B) is
			-- Process `a_node'.
		do
		end

	process_nat64_val_b (a_node: NAT64_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_nat_val_b (a_node: NAT_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_nested_b (a_node: NESTED_B) is
			-- Process `a_node'.
		do
		end

	process_object_test_b (a_node: OBJECT_TEST_B) is
			-- Process `a_node'.
		do
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B) is
			-- Process `a_node'.
		do
		end

	process_once_string_b (a_node: ONCE_STRING_B) is
			-- Process `a_node'.
		do
		end

	process_operand_b (a_node: OPERAND_B) is
			-- Process `a_node'.
		do
		end

	process_parameter_b (a_node: PARAMETER_B) is
			-- Process `a_node'.
		do
		end

	process_paran_b (a_node: PARAN_B) is
			-- Process `a_node'.
		do
		end

	process_real_const_b (a_node: REAL_CONST_B) is
			-- Process `a_node'.
		do
		end

	process_require_b (a_node: REQUIRE_B) is
		do
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
		end

	process_retry_b (a_node: RETRY_B) is
			-- Process `a_node'.
		do
		end

	process_reverse_b (a_node: REVERSE_B) is
			-- Process `a_node'.
		do
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B) is
			-- Process `a_node'.
		do
		end

	process_string_b (a_node: STRING_B) is
			-- Process `a_node'.
		do
		end

	process_strip_b (a_node: STRIP_B) is
			-- Process `a_node'.
		do
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B) is
			-- Process `a_node'.
		do
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B) is
			-- Process `a_node'.
		do
		end

	process_type_expr_b (a_node: TYPE_EXPR_B) is
			-- Process `a_node'.
		do
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B]) is
			-- Process `a_node'.
		do
		end

	process_un_free_b (a_node: UN_FREE_B) is
			-- Process `a_node'.
		do
		end

	process_un_minus_b (a_node: UN_MINUS_B) is
			-- Process `a_node'.
		do
		end

	process_un_not_b (a_node: UN_NOT_B) is
			-- Process `a_node'.
		do
		end

	process_un_old_b (a_node: UN_OLD_B) is
			-- Process `a_node'.
		do
		end

	process_un_plus_b (a_node: UN_PLUS_B) is
			-- Process `a_node'.
		do
		end

	process_variant_b (a_node: VARIANT_B) is
			-- Process `a_node'.
		do
		end

	process_void_b (a_node: VOID_B) is
			-- Process `a_node'.
		do
		end

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
