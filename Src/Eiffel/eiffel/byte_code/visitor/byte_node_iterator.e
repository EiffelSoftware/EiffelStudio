indexing
	description: "[
		Iterator for BYTE_NODE objects which process each node and for each
		performs an operation in preorder or postorder traversal.
		
		Note: that some nodes have a `parent' attribute. If this is the case, we do not process the
		attribute, since it must have been processed before.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_NODE_ITERATOR

inherit
	BYTE_NODE_VISITOR

feature -- Code iterator routine

	preorder_process (a_node: BYTE_NODE) is
			-- Perform an action on `a_node' before processing any child of `a_node'.
		require
			is_valid: is_valid
		do
		end

	postorder_process (a_node: BYTE_NODE) is
			-- Perform an action on `a_node' after processing any child of `a_node'.
		require
			is_valid: is_valid
		do
		end

feature {BYTE_NODE} -- Routine visitors

	process_std_byte_code (a_node: STD_BYTE_CODE) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.custom_attributes)
			safe_process (a_node.class_custom_attributes)
			safe_process (a_node.property_custom_attributes)
			safe_process (a_node.interface_custom_attributes)
			safe_process (a_node.precondition)
			if a_node.old_expressions /= Void then
				from
					a_node.old_expressions.start
				until
					a_node.old_expressions.after
				loop
					safe_process (a_node.old_expressions.item)
					a_node.old_expressions.forth
				end
			end
			safe_process (a_node.compound)
			safe_process (a_node.rescue_clause)
			safe_process (a_node.postcondition)
			postorder_process (a_node)
		end

feature {BYTE_NODE} -- Visitors

	process_access_expr_b (a_node: ACCESS_EXPR_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_address_b (a_node: ADDRESS_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			postorder_process (a_node)
		end

	process_array_const_b (a_node: ARRAY_CONST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expressions)
			postorder_process (a_node)
		end

	process_assert_b (a_node: ASSERT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_assign_b (a_node: ASSIGN_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.source)
			safe_process (a_node.target)
			postorder_process (a_node)
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			postorder_process (a_node)
		end

	process_binary_b (a_node: BINARY_B) is
			-- Process `a_node'
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			preorder_process (a_node)
			safe_process (a_node.left)
			safe_process (a_node.access)
			safe_process (a_node.right)
			postorder_process (a_node)
		end

	process_bin_and_b (a_node: BIN_AND_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_and_then_b (a_node: B_AND_THEN_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_div_b (a_node: BIN_DIV_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_eq_b (a_node: BIN_EQ_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_free_b (a_node: BIN_FREE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_ge_b (a_node: BIN_GE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_gt_b (a_node: BIN_GT_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_le_b (a_node: BIN_LE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_lt_b (a_node: BIN_LT_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_mod_b (a_node: BIN_MOD_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_ne_b (a_node: BIN_NE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_or_b (a_node: BIN_OR_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_plus_b (a_node: BIN_PLUS_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_power_b (a_node: BIN_POWER_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_slash_b (a_node: BIN_SLASH_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_star_b (a_node: BIN_STAR_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_xor_b (a_node: BIN_XOR_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bit_const_b (a_node: BIT_CONST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_bool_const_b (a_node: BOOL_CONST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE]) is
			-- Process `a_node'.
		local
			l_area: SPECIAL [BYTE_NODE]
			i, nb: INTEGER
		do
			preorder_process (a_node)
			from
				l_area := a_node.area
				nb := a_node.count
			until
				i = nb
			loop
				safe_process (l_area.item (i))
				i := i + 1
			end
			postorder_process (a_node)
		end

	process_case_b (a_node: CASE_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.interval)
			safe_process (a_node.compound)
			postorder_process (a_node)
		end

	process_char_const_b (a_node: CHAR_CONST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_char_val_b (a_node: CHAR_VAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_check_b (a_node: CHECK_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.check_list)
			postorder_process (a_node)
		end

	process_constant_b (a_node: CONSTANT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.access)
			postorder_process (a_node)
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.call)
			postorder_process (a_node)
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			postorder_process (a_node)
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.creation_expr)
			if a_node.named_arguments /= Void then
				from
					a_node.named_arguments.start
				until
					a_node.named_arguments.after
				loop
					safe_process (a_node.named_arguments.item.name)
					safe_process (a_node.named_arguments.item.expression)
					a_node.named_arguments.forth
				end
			end
			postorder_process (a_node)
		end

	process_debug_b (a_node: DEBUG_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.compound)
			postorder_process (a_node)
		end

	process_elsif_b (a_node: ELSIF_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			safe_process (a_node.compound)
			postorder_process (a_node)
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_external_b (a_node: EXTERNAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.parameters)
			postorder_process (a_node)
		end

	process_feature_b (a_node: FEATURE_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.parameters)
			postorder_process (a_node)
		end

	process_agent_call_b (a_node: AGENT_CALL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.parameters)
			postorder_process (a_node)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			a_node.expr.process (Current)
			postorder_process (a_node)
		end

	process_hector_b (a_node: HECTOR_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			a_node.expr.process (Current)
			postorder_process (a_node)
		end

	process_if_b (a_node: IF_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.condition)
			safe_process (a_node.compound)
			safe_process (a_node.elsif_list)
			safe_process (a_node.else_part)
			postorder_process (a_node)
		end

	process_inspect_b (a_node: INSPECT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.switch)
			safe_process (a_node.case_list)
			safe_process (a_node.else_part)
			postorder_process (a_node)
		end

	process_instr_call_b (a_node: INSTR_CALL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			a_node.call.process (Current)
			postorder_process (a_node)
		end

	process_instr_list_b (a_node: INSTR_LIST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			a_node.compound.process (Current)
			postorder_process (a_node)
		end

	process_int64_val_b (a_node: INT64_VAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_int_val_b (a_node: INT_VAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_integer_constant (a_node: INTEGER_CONSTANT) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_inv_assert_b (a_node: INV_ASSERT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_invariant_b (a_node: INVARIANT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.byte_list)
			postorder_process (a_node)
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			postorder_process (a_node)
		end

	process_loop_b (a_node: LOOP_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.from_part)
			safe_process (a_node.variant_part)
			safe_process (a_node.invariant_part)
			safe_process (a_node.stop)
			safe_process (a_node.compound)
			postorder_process (a_node)
		end

	process_nat64_val_b (a_node: NAT64_VAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_nat_val_b (a_node: NAT_VAL_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_nested_b (a_node: NESTED_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.target)
			safe_process (a_node.message)
			postorder_process (a_node)
		end

	process_object_test_b (a_node: OBJECT_TEST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			a_node.target.process (Current)
			a_node.expression.process (Current)
			postorder_process (a_node)
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B) is
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_once_string_b (a_node: ONCE_STRING_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_operand_b (a_node: OPERAND_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			postorder_process (a_node)
		end

	process_parameter_b (a_node: PARAMETER_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.expression)
			postorder_process (a_node)
		end

	process_paran_b (a_node: PARAN_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_real_const_b (a_node: REAL_CONST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_require_b (a_node: REQUIRE_B) is
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			postorder_process (a_node)
		end

	process_retry_b (a_node: RETRY_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_reverse_b (a_node: REVERSE_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.source)
			safe_process (a_node.target)
			postorder_process (a_node)
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.arguments)
			safe_process (a_node.open_positions)
			postorder_process (a_node)
		end

	process_string_b (a_node: STRING_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_strip_b (a_node: STRIP_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
				-- `a_node.parent' is ignored since we must have
				-- already processed it before reaching `a_node'.
			safe_process (a_node.source)
			postorder_process (a_node)
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expressions)
			postorder_process (a_node)
		end

	process_type_expr_b (a_node: TYPE_EXPR_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B]) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.lower)
			safe_process (a_node.upper)
			postorder_process (a_node)
		end

	process_unary_b (a_node: UNARY_B) is
			-- Process `a_node'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			safe_process (a_node.access)
			postorder_process (a_node)
		end

	process_un_free_b (a_node: UN_FREE_B) is
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_un_minus_b (a_node: UN_MINUS_B) is
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_un_not_b (a_node: UN_NOT_B) is
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_un_old_b (a_node: UN_OLD_B) is
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_un_plus_b (a_node: UN_PLUS_B) is
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_variant_b (a_node: VARIANT_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			safe_process (a_node.expr)
			postorder_process (a_node)
		end

	process_void_b (a_node: VOID_B) is
			-- Process `a_node'.
		do
			preorder_process (a_node)
			postorder_process (a_node)
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
