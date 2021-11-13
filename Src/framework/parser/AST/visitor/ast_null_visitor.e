note
	description: "Class that parses an Eiffel class an does nothing."

class
	AST_NULL_VISITOR

inherit
	AST_VISITOR

feature -- Roundtrip

	process_none_id_as (l_as: NONE_ID_AS)
			-- Process `l_as'.
		do
			process_id_as (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS)
			-- Process `l_as'.
		do
			process_char_as (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
			-- Process `l_as'.
		do
			process_agent_routine_creation_as (l_as)
		end

feature -- Roundtrip: leaves

	process_keyword_as (l_as: KEYWORD_AS)
			-- Process `l_as'.
		do
		end

	process_symbol_as (l_as: SYMBOL_AS)
			-- Process `l_as'.
		do
		end

	process_break_as (l_as: BREAK_AS)
			-- Process `l_as'.
		do
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_keyword_stub_as (l_as: KEYWORD_STUB_AS)
			-- Process `l_as'.
		do
		end

feature -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
		do
		end

	process_id_as (l_as: ID_AS)
		do
		end

	process_integer_as (l_as: INTEGER_AS)
		do
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
		do
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
		end

	process_unique_as (l_as: UNIQUE_AS)
		do
		end

	process_tuple_as (l_as: TUPLE_AS)
		do
		end

	process_real_as (l_as: REAL_AS)
		do
		end

	process_bool_as (l_as: BOOL_AS)
		do
		end

	process_array_as (l_as: ARRAY_AS)
		do
		end

	process_char_as (l_as: CHAR_AS)
		do
		end

	process_string_as (l_as: STRING_AS)
		do
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
		do
		end

	process_body_as (l_as: BODY_AS)
		do
		end

	process_built_in_as (l_as: BUILT_IN_AS)
			-- Process `l_as'.
		do
		end

	process_result_as (l_as: RESULT_AS)
		do
		end

	process_current_as (l_as: CURRENT_AS)
		do
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		do
		end

	process_access_inv_as (l_as: ACCESS_INV_AS)
		do
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
		do
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS)
		do
		end

	process_precursor_as (l_as: PRECURSOR_AS)
		do
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS)
		do
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS)
		do
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS)
		do
		end

	process_routine_as (l_as: ROUTINE_AS)
		do
		end

	process_constant_as (l_as: CONSTANT_AS)
		do
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL])
		do
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
		end

	process_elseif_expression_as (l_as: ELSIF_EXPRESSION_AS)
		do
		end

	process_if_expression_as (l_as: IF_EXPRESSION_AS)
		do
		end

	process_operand_as (l_as: OPERAND_AS)
		do
		end

	process_tagged_as (l_as: TAGGED_AS)
		do
		end

	process_variant_as (l_as: VARIANT_AS)
		do
		end

	process_un_strip_as (l_as: UN_STRIP_AS)
		do
		end

	process_converted_expr_as (l_as: CONVERTED_EXPR_AS)
		do
		end

	process_paran_as (l_as: PARAN_AS)
		do
		end

	process_expr_call_as (l_as: EXPR_CALL_AS)
		do
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS)
		do
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS)
		do
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS)
		do
		end

	process_address_as (l_as: ADDRESS_AS)
		do
		end

	process_predecessor_as (a: PREDECESSOR_AS)
			-- <Precursor>
		do
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS)
		do
		end

	process_un_free_as (l_as: UN_FREE_AS)
		do
		end

	process_un_minus_as (l_as: UN_MINUS_AS)
		do
		end

	process_un_not_as (l_as: UN_NOT_AS)
		do
		end

	process_un_old_as (l_as: UN_OLD_AS)
		do
		end

	process_un_plus_as (l_as: UN_PLUS_AS)
		do
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
		do
		end

	process_bin_free_as (l_as: BIN_FREE_AS)
		do
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS)
		do
		end

	process_bin_or_as (l_as: BIN_OR_AS)
		do
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS)
		do
		end

	process_bin_xor_as (l_as: BIN_XOR_AS)
		do
		end

	process_bin_ge_as (l_as: BIN_GE_AS)
		do
		end

	process_bin_gt_as (l_as: BIN_GT_AS)
		do
		end

	process_bin_le_as (l_as: BIN_LE_AS)
		do
		end

	process_bin_lt_as (l_as: BIN_LT_AS)
		do
		end

	process_bin_div_as (l_as: BIN_DIV_AS)
		do
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS)
		do
		end

	process_bin_mod_as (l_as: BIN_MOD_AS)
		do
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS)
		do
		end

	process_bin_power_as (l_as: BIN_POWER_AS)
		do
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS)
		do
		end

	process_bin_star_as (l_as: BIN_STAR_AS)
		do
		end

	process_bin_and_as (l_as: BIN_AND_AS)
		do
		end

	process_bin_eq_as (l_as: BIN_EQ_AS)
		do
		end

	process_bin_ne_as (l_as: BIN_NE_AS)
		do
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS)
		do
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS)
		do
		end

	process_bracket_as (l_as: BRACKET_AS)
		do
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
		do
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS)
		do
		end

	process_feature_as (l_as: FEATURE_AS)
		do
		end

	process_feature_name (l_as: FEATURE_NAME)
		do
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		do
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS)
		do
		end

	process_all_as (l_as: ALL_AS)
		do
		end

	process_assign_as (l_as: ASSIGN_AS)
		do
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
		do
		end

	process_reverse_as (l_as: REVERSE_AS)
		do
		end

	process_check_as (l_as: CHECK_AS)
		do
		end

	process_creation_as (l_as: CREATION_AS)
		do
		end

	process_debug_as (l_as: DEBUG_AS)
		do
		end

	process_guard_as (l_as: GUARD_AS)
		do
		end

	process_if_as (l_as: IF_AS)
		do
		end

	process_inspect_as (l_as: INSPECT_AS)
		do
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		do
		end

	process_loop_as (l_as: LOOP_AS)
		do
		end

	process_iteration_as (l_as: ITERATION_AS)
		do
		end

	process_inspect_expression_as (a: INSPECT_EXPRESSION_AS)
		do
		end

	process_loop_expr_as (l_as: LOOP_EXPR_AS)
		do
		end

	process_retry_as (l_as: RETRY_AS)
		do
		end

	process_separate_instruction_as (a_as: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
		do
		end

	process_external_as (l_as: EXTERNAL_AS)
		do
		end

	process_deferred_as (l_as: DEFERRED_AS)
		do
		end

	process_attribute_as (l_as: ATTRIBUTE_AS)
		do
		end

	process_do_as (l_as: DO_AS)
		do
		end

	process_once_as (l_as: ONCE_AS)
		do
		end

	process_list_dec_as (l_as: LIST_DEC_AS)
		do
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		do
		end

	process_class_as (l_as: CLASS_AS)
		do
		end

	process_parent_as (l_as: PARENT_AS)
		do
		end

	process_like_id_as (l_as: LIKE_ID_AS)
		do
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
		end

	process_qualified_anchored_type_as (l_as: QUALIFIED_ANCHORED_TYPE_AS)
		do
		end

	process_feature_id_as (l_as: FEATURE_ID_AS)
		do
		end

	process_formal_as (l_as: FORMAL_AS)
		do
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
		do
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS)
		do
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		do
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
			-- Process `l_as'.
		do
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
		end

	process_rename_as (l_as: RENAME_AS)
		do
		end

	process_invariant_as (l_as: INVARIANT_AS)
		do
		end

	process_interval_as (l_as: INTERVAL_AS)
		do
		end

	process_index_as (l_as: INDEX_AS)
		do
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS)
		do
		end

	process_elseif_as (l_as: ELSIF_AS)
		do
		end

	process_create_as (l_as: CREATE_AS)
		do
		end

	process_client_as (l_as: CLIENT_AS)
		do
		end

	process_case_as (l_as: CASE_AS)
		do
		end

	process_case_expression_as (a: CASE_EXPRESSION_AS)
		do
		end

	process_ensure_as (l_as: ENSURE_AS)
		do
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
		do
		end

	process_require_as (l_as: REQUIRE_AS)
		do
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
		do
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS)
		do
		end

	process_void_as (l_as: VOID_AS)
		do
		end

	process_type_list_as (l_as: TYPE_LIST_AS)
			-- Process `l_as'.
		do
		end

	process_list_dec_list_as (l_as: LIST_DEC_LIST_AS)
			-- Process `l_as'.
		do
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS)
			-- Process `l_as'.
		do
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS)
			-- Process `l_as'.
		do
		end

	process_class_list_as (l_as: CLASS_LIST_AS)
			-- Process `l_as'.
		do
		end

	process_parent_list_as (l_as: PARENT_LIST_AS)
			-- Process `l_as'.
		do
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
			-- Process `l_as'.
		do
			l_as.locals.process (Current)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS)
			-- Process `l_as'.
		do
			l_as.arguments.process (Current)
		end

	process_key_list_as (l_as: KEY_LIST_AS)
			-- Process `l_as'.
		do
			l_as.keys.process (Current)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS)
			-- Process `l_as'.
		do
			l_as.operands.process (Current)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS)
			-- Process `l_as'.
		do
			l_as.parameters.process (Current)
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
			-- <Precursor>
		do
			a_as.expression.process (Current)
			a_as.name.process (Current)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

note
	ca_ignore: "CA033", "CA033: too large class"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
