indexing
	description: "Class that parses an Eiffel class an does nothing"

class
	AST_NULL_VISITOR

inherit
	AST_VISITOR

feature -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS) is
		do
		end

	process_id_as (l_as: ID_AS) is
		do
		end

	process_integer_as (l_as: INTEGER_AS) is
		do
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		do
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		do
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
		end

	process_tuple_as (l_as: TUPLE_AS) is
		do
		end

	process_real_as (l_as: REAL_AS) is
		do
		end

	process_bool_as (l_as: BOOL_AS) is
		do
		end

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
		end

	process_array_as (l_as: ARRAY_AS) is
		do
		end

	process_char_as (l_as: CHAR_AS) is
		do
		end

	process_string_as (l_as: STRING_AS) is
		do
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
		end

	process_body_as (l_as: BODY_AS) is
		do
		end

	process_result_as (l_as: RESULT_AS) is
		do
		end

	process_current_as (l_as: CURRENT_AS) is
		do
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
		do
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
		do
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
		do
		end

	process_precursor_as (l_as: PRECURSOR_AS) is
		do
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		do
		end

	process_nested_as (l_as: NESTED_AS) is
		do
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		do
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
		do
		end

	process_routine_as (l_as: ROUTINE_AS) is
		do
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		do
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
		end

	process_operand_as (l_as: OPERAND_AS) is
		do
		end

	process_tagged_as (l_as: TAGGED_AS) is
		do
		end

	process_variant_as (l_as: VARIANT_AS) is
		do
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
		do
		end

	process_paran_as (l_as: PARAN_AS) is
		do
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		do
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		do
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		do
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		do
		end

	process_address_as (l_as: ADDRESS_AS) is
		do
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		do
		end

	process_un_free_as (l_as: UN_FREE_AS) is
		do
		end

	process_un_minus_as (l_as: UN_MINUS_AS) is
		do
		end

	process_un_not_as (l_as: UN_NOT_AS) is
		do
		end

	process_un_old_as (l_as: UN_OLD_AS) is
		do
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS) is
		do
		end

	process_bin_free_as (l_as: BIN_FREE_AS) is
		do
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS) is
		do
		end

	process_bin_or_as (l_as: BIN_OR_AS) is
		do
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS) is
		do
		end

	process_bin_xor_as (l_as: BIN_XOR_AS) is
		do
		end

	process_bin_ge_as (l_as: BIN_GE_AS) is
		do
		end

	process_bin_gt_as (l_as: BIN_GT_AS) is
		do
		end

	process_bin_le_as (l_as: BIN_LE_AS) is
		do
		end

	process_bin_lt_as (l_as: BIN_LT_AS) is
		do
		end

	process_bin_div_as (l_as: BIN_DIV_AS) is
		do
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS) is
		do
		end

	process_bin_mod_as (l_as: BIN_MOD_AS) is
		do
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS) is
		do
		end

	process_bin_power_as (l_as: BIN_POWER_AS) is
		do
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS) is
		do
		end

	process_bin_star_as (l_as: BIN_STAR_AS) is
		do
		end

	process_bin_and_as (l_as: BIN_AND_AS) is
		do
		end

	process_bin_eq_as (l_as: BIN_EQ_AS) is
		do
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
		do
		end

	process_bracket_as (l_as: BRACKET_AS) is
		do
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
		end

	process_feature_as (l_as: FEATURE_AS) is
		do
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		do
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
		end

	process_all_as (l_as: ALL_AS) is
		do
		end

	process_assign_as (l_as: ASSIGN_AS) is
		do
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		do
		end

	process_reverse_as (l_as: REVERSE_AS) is
		do
		end

	process_check_as (l_as: CHECK_AS) is
		do
		end

	process_creation_as (l_as: CREATION_AS) is
		do
		end

	process_debug_as (l_as: DEBUG_AS) is
		do
		end

	process_if_as (l_as: IF_AS) is
		do
		end

	process_inspect_as (l_as: INSPECT_AS) is
		do
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		do
		end

	process_loop_as (l_as: LOOP_AS) is
		do
		end

	process_retry_as (l_as: RETRY_AS) is
		do
		end

	process_external_as (l_as: EXTERNAL_AS) is
		do
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
		end

	process_do_as (l_as: DO_AS) is
		do
		end

	process_once_as (l_as: ONCE_AS) is
		do
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		do
		end

	process_class_as (l_as: CLASS_AS) is
		do
		end

	process_parent_as (l_as: PARENT_AS) is
		do
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		do
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
		end

	process_bits_as (l_as: BITS_AS) is
		do
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
		end

	process_rename_as (l_as: RENAME_AS) is
		do
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
		end

	process_index_as (l_as: INDEX_AS) is
		do
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
		end

	process_elseif_as (l_as: ELSIF_AS) is
		do
		end

	process_create_as (l_as: CREATE_AS) is
		do
		end

	process_client_as (l_as: CLIENT_AS) is
		do
		end

	process_case_as (l_as: CASE_AS) is
		do
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
		end
		
	process_use_list_as (l_as: USE_LIST_AS) is
		do
		end
		
	process_void_as (l_as: VOID_AS) is
		do
		end

end -- class AST_NULL_VISITOR
