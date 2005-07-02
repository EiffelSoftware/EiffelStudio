indexing
	description: "AST node factories which does not generate any node."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class AST_NULL_FACTORY

inherit
	AST_FACTORY
		redefine
			new_access_assert_as, new_access_feat_as, new_access_id_as, new_access_inv_as,
			new_address_as, new_address_current_as, new_address_result_as, new_all_as,
			new_array_as, new_assign_as, new_bin_and_as, new_bin_and_then_as, new_bin_div_as,
			new_bin_eq_as, new_bin_free_as, new_bin_ge_as, new_bin_gt_as, new_bin_implies_as,
			new_bin_le_as, new_bin_lt_as, new_bin_minus_as, new_bin_mod_as, new_bin_ne_as,
			new_bin_or_as, new_bin_or_else_as, new_bin_plus_as, new_bin_power_as, new_bin_slash_as,
			new_bin_star_as, new_bin_xor_as, new_bit_const_as, new_bits_as, new_bits_symbol_as,
			new_body_as, new_boolean_as, new_case_as, new_character_as, new_check_as, new_class_as,
			new_class_type_as, new_client_as, new_constant_as, new_convert_feat_as, new_create_as,
			new_creation_as, new_creation_expr_as, new_current_as, new_custom_attribute_as,
			new_debug_as, new_deferred_as, new_do_as, new_eiffel_list_atomic_as,
			new_eiffel_list_case_as, new_eiffel_list_convert, new_eiffel_list_create_as,
			new_eiffel_list_elseif_as, new_eiffel_list_export_item_as, new_eiffel_list_expr_as,
			new_eiffel_list_feature_as, new_eiffel_list_feature_clause_as,
			new_eiffel_list_feature_name, new_eiffel_list_formal_dec_as, new_eiffel_list_id_as,
			new_indexing_clause_as, new_eiffel_list_instruction_as, new_eiffel_list_interval_as,
			new_eiffel_list_operand_as, new_eiffel_list_parent_as, new_eiffel_list_rename_as,
			new_eiffel_list_string_as, new_eiffel_list_tagged_as, new_eiffel_list_type,
			new_eiffel_list_type_dec_as, new_elseif_as, new_ensure_as, new_ensure_then_as,
			new_export_item_as, new_expr_address_as, new_expr_call_as, new_external_as,
			new_external_lang_as, new_feature_as, new_feature_clause_as, new_feature_list_as,
			new_feature_name_alias_as, new_feature_name_id_as, new_formal_as, new_formal_dec_as, new_filled_id_as,
			new_identifier_list, new_if_as, new_index_as, new_infix_as, new_inspect_as,
			new_instr_call_as, new_integer_as, new_integer_hexa_as, new_interval_as, new_invariant_as,
			new_like_id_as, new_like_current_as, new_location_as, new_loop_as, new_nested_as,
			new_nested_expr_as, new_none_type_as, new_once_as, new_operand_as, new_paran_as, new_parent_as,
			new_precursor_as, new_prefix_as, new_real_as, new_rename_as, new_require_as, new_require_else_as,
			new_result_as, new_retry_as, new_reverse_as, new_routine_as, new_routine_creation_as,
			new_old_routine_creation_as, new_static_access_as, new_string_as, new_tagged_as,
			new_tuple_as, new_type_dec_as, new_type_expr_as, new_un_free_as, new_un_minus_as,
			new_un_not_as, new_un_old_as, new_un_plus_as, new_un_strip_as, new_unique_as,
			new_variant_as, new_verbatim_string_as, new_void_as
		end

feature -- Access

	new_access_assert_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_ASSERT_AS is
			-- New ACCESS_ASSERT AST node
		do
		end

	new_access_feat_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_FEAT_AS is
			-- New ACCESS_FEAT AST node
		do
		end

	new_access_id_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_ID_AS is
			-- New ACCESS_ID AST node
		do
		end

	new_access_inv_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_INV_AS is
			-- New ACCESS_INV AST node
		do
		end

	new_address_as (f: FEATURE_NAME): ADDRESS_AS is
			-- New ADDRESS AST node
		do
		end

	new_address_current_as (other: CURRENT_AS): ADDRESS_CURRENT_AS is
			-- New ADDRESS_CURRENT AST node
		do
		end

	new_address_result_as (other: RESULT_AS): ADDRESS_RESULT_AS is
			-- New ADDRESS_RESULT AST node
		do
		end

	new_all_as: ALL_AS is
			-- New ALL AST node
		do
		end

	new_array_as (exp: EIFFEL_LIST [EXPR_AS]): ARRAY_AS is
			-- New Manifest ARRAY AST node
		do
		end

	new_assign_as (t: ACCESS_AS; s: EXPR_AS): ASSIGN_AS is
			-- New ASSIGN AST node
		do
		end

	new_bin_and_as (l, r: EXPR_AS): BIN_AND_AS is
			-- New binary and AST node
		do
		end

	new_bin_and_then_as (l, r: EXPR_AS): BIN_AND_THEN_AS is
			-- New binary and then AST node
		do
		end

	new_bin_div_as (l, r: EXPR_AS): BIN_DIV_AS is
			-- New binary // AST node
		do
		end

	new_bin_eq_as (l, r: EXPR_AS): BIN_EQ_AS is
			-- New binary = AST node
		do
		end

	new_bin_free_as (l: EXPR_AS; op: ID_AS; r: EXPR_AS): BIN_FREE_AS is
			-- New BIN_FREE AST node
		do
		end

	new_bin_ge_as (l, r: EXPR_AS): BIN_GE_AS is
			-- New binary >= AST node
		do
		end

	new_bin_gt_as (l, r: EXPR_AS): BIN_GT_AS is
			-- New binary > AST node
		do
		end

	new_bin_implies_as (l, r: EXPR_AS): BIN_IMPLIES_AS is
			-- New binary implies AST node
		do
		end

	new_bin_le_as (l, r: EXPR_AS): BIN_LE_AS is
			-- New binary <= AST node
		do
		end

	new_bin_lt_as (l, r: EXPR_AS): BIN_LT_AS is
			-- New binary < AST node
		do
		end

	new_bin_minus_as (l, r: EXPR_AS): BIN_MINUS_AS is
			-- New binary - AST node
		do
		end

	new_bin_mod_as (l, r: EXPR_AS): BIN_MOD_AS is
			-- New binary \\ AST node
		do
		end

	new_bin_ne_as (l, r: EXPR_AS): BIN_NE_AS is
			-- New binary /= AST node
		do
		end

	new_bin_or_as (l, r: EXPR_AS): BIN_OR_AS is
			-- New binary or AST node
		do
		end

	new_bin_or_else_as (l, r: EXPR_AS): BIN_OR_ELSE_AS is
			-- New binary or else AST node
		do
		end

	new_bin_plus_as (l, r: EXPR_AS): BIN_PLUS_AS is
			-- New binary + AST node
		do
		end

	new_bin_power_as (l, r: EXPR_AS): BIN_POWER_AS is
			-- New binary ^ AST node
		do
		end

	new_bin_slash_as (l, r: EXPR_AS): BIN_SLASH_AS is
			-- New binary / AST node
		do
		end

	new_bin_star_as (l, r: EXPR_AS): BIN_STAR_AS is
			-- New binary * AST node
		do
		end

	new_bin_xor_as (l, r: EXPR_AS): BIN_XOR_AS is
			-- New binary xor AST node
		do
		end

	new_bit_const_as (b: ID_AS): BIT_CONST_AS is
			-- New BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'
		do
		end

	new_bits_as (v: INTEGER_AS): BITS_AS is
			-- New BITS AST node
		do
		end

	new_bits_symbol_as (s: ID_AS): BITS_SYMBOL_AS is
			-- New BITS_SYMBOL AST node
		do
		end

	new_body_as (a: EIFFEL_LIST [TYPE_DEC_AS]; t: TYPE_AS; r: ID_AS; c: CONTENT_AS): BODY_AS is
			-- New BODY AST node
		do
		end

	new_boolean_as (b: BOOLEAN; l, c, p, s: INTEGER): BOOL_AS is
			-- New BOOLEAN AST node
		do
		end

	new_case_as (i: EIFFEL_LIST [INTERVAL_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]): CASE_AS is
			-- New WHEN AST node
		do
		end

	new_character_as (c: CHARACTER; l, co, p: INTEGER): CHAR_AS is
			-- New CHARACTER AST node
		do
		end

	new_check_as (c: EIFFEL_LIST [TAGGED_AS]; e: LOCATION_AS): CHECK_AS is
			-- New CHECK AST node
		do
		end

	new_class_as (n: ID_AS; ext_name: STRING;
			is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			p: EIFFEL_LIST [PARENT_AS];
			c: EIFFEL_LIST [CREATE_AS];
			co: EIFFEL_LIST [CONVERT_FEAT_AS];
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			he: BOOLEAN; ed: LOCATION_AS): CLASS_AS
		is
			-- New CLASS AST node
		do
		end

	new_class_type_as (n: ID_AS; g: TYPE_LIST_AS; is_exp, is_sep: BOOLEAN): CLASS_TYPE_AS is
			-- New CLASS_TYPE AST node
		do
		end

	new_client_as (c: EIFFEL_LIST [ID_AS]): CLIENT_AS is
			-- New CLIENT AST node
		do
		end
		
	new_constant_as (a: ATOMIC_AS): CONSTANT_AS is
			-- New CONSTANT_AS node
		do
		end

	new_convert_feat_as (cr: BOOLEAN; fn: FEATURE_NAME; t: TYPE_LIST_AS): CONVERT_FEAT_AS is
			-- New convert feature entry AST node.
		do
		end

	new_create_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_NAME]): CREATE_AS is
			-- New creation clause AST node
		do
		end

	new_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS): CREATION_AS is
			-- New creation instruction AST node
		do
		end

	new_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS): CREATION_EXPR_AS is
			-- New creation expression AST node
		do
		end

	new_current_as (l, c, p, s: INTEGER): CURRENT_AS is
			-- New CURRENT AST node
		do
		end

	new_custom_attribute_as (c: CREATION_EXPR_AS; t: TUPLE_AS): CUSTOM_ATTRIBUTE_AS is
			-- Create a new UNIQUE AST node.
		do
		end

	new_debug_as (k: EIFFEL_LIST [STRING_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; e: LOCATION_AS): DEBUG_AS is
			-- New DEBUG AST node
		do
		end

	new_deferred_as (l, c, p, s: INTEGER): DEFERRED_AS is
			-- New DEFERRED AST node
		do
		end

	new_do_as (c: EIFFEL_LIST [INSTRUCTION_AS]): DO_AS is
			-- New DO AST node
		do
		end

	new_eiffel_list_atomic_as (n: INTEGER): EIFFEL_LIST [ATOMIC_AS] is
			-- New empty list of ATOMIC_AS
		do
		end

	new_eiffel_list_case_as (n: INTEGER): EIFFEL_LIST [CASE_AS] is
			-- New empty list of CASE_AS
		do
		end

	new_eiffel_list_convert (n: INTEGER): EIFFEL_LIST [CONVERT_FEAT_AS] is
			-- New empty list of CONVERT_FEAT_AS
		do
		end

	new_eiffel_list_create_as (n: INTEGER): EIFFEL_LIST [CREATE_AS] is
			-- New empty list of CREATE_AS
		do
		end

	new_eiffel_list_elseif_as (n: INTEGER): EIFFEL_LIST [ELSIF_AS] is
			-- New empty list of ELSIF_AS
		do
		end

	new_eiffel_list_export_item_as (n: INTEGER): EIFFEL_LIST [EXPORT_ITEM_AS] is
			-- New empty list of EXPORT_ITEM_AS
		do
		end

	new_eiffel_list_expr_as (n: INTEGER): EIFFEL_LIST [EXPR_AS] is
			-- New empty list of EXPR_AS
		do
		end

	new_eiffel_list_feature_as (n: INTEGER): EIFFEL_LIST [FEATURE_AS] is
			-- New empty list of FEATURE_AS
		do
		end

	new_eiffel_list_feature_clause_as (n: INTEGER): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
			-- New empty list of FEATURE_CLAUSE_AS
		do
		end

	new_eiffel_list_feature_name (n: INTEGER): EIFFEL_LIST [FEATURE_NAME] is
			-- New empty list of FEATURE_NAME
		do
		end

	new_eiffel_list_formal_dec_as (n: INTEGER): EIFFEL_LIST [FORMAL_DEC_AS] is
			-- New empty list of FORMAL_DEC_AS
		do
		end

	new_eiffel_list_id_as (n: INTEGER): EIFFEL_LIST [ID_AS] is
			-- New empty list of ID_AS
		do
		end

	new_indexing_clause_as (n: INTEGER): INDEXING_CLAUSE_AS is
			-- New empty list of INDEX_AS
		do
		end

	new_eiffel_list_instruction_as (n: INTEGER): EIFFEL_LIST [INSTRUCTION_AS] is
			-- New empty list of INSTRUCTION_AS
		do
		end

	new_eiffel_list_interval_as (n: INTEGER): EIFFEL_LIST [INTERVAL_AS] is
			-- New empty list of INTERVAL_AS
		do
		end

	new_eiffel_list_operand_as (n: INTEGER): EIFFEL_LIST [OPERAND_AS] is
			-- New empty list of OPERAND_AS
		do
		end

	new_eiffel_list_parent_as (n: INTEGER): EIFFEL_LIST [PARENT_AS] is
			-- New empty list of PARENT_AS
		do
		end

	new_eiffel_list_rename_as (n: INTEGER): EIFFEL_LIST [RENAME_AS] is
			-- New empty list of RENAME_AS
		do
		end

	new_eiffel_list_string_as (n: INTEGER): EIFFEL_LIST [STRING_AS] is
			-- New empty list of STRING_AS
		do
		end

	new_eiffel_list_tagged_as (n: INTEGER): EIFFEL_LIST [TAGGED_AS] is
			-- New empty list of TAGGED_AS
		do
		end

	new_eiffel_list_type (n: INTEGER): TYPE_LIST_AS is
			-- New empty list of TYPE
		do
		end

	new_eiffel_list_type_dec_as (n: INTEGER): EIFFEL_LIST [TYPE_DEC_AS] is
			-- New empty list of TYPE_DEC_AS
		do
		end

	new_elseif_as (e: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS]): ELSIF_AS is
			-- New ELSIF AST node
		do
		end

	new_ensure_as (a: EIFFEL_LIST [TAGGED_AS]): ENSURE_AS is
			-- New ENSURE AST node
		do
		end

	new_ensure_then_as (a: EIFFEL_LIST [TAGGED_AS]): ENSURE_THEN_AS is
			-- New ENSURE THEN AST node
		do
		end

	new_export_item_as (c: CLIENT_AS; f: FEATURE_SET_AS): EXPORT_ITEM_AS is
			-- New EXPORT_ITEM AST node
		do
		end

	new_expr_address_as (e: EXPR_AS): EXPR_ADDRESS_AS is
			-- New EXPR_ADDRESS AST node
		do
		end

	new_expr_call_as (c: CALL_AS): EXPR_CALL_AS is
			-- New EXPR_CALL AST node
		do
		end

	new_external_as (l: EXTERNAL_LANG_AS; a: STRING_AS): EXTERNAL_AS is
			-- New EXTERNAL AST node
		do
		end

	new_external_lang_as (l: STRING_AS): EXTERNAL_LANG_AS is
			-- New EXTERNAL_LANGUAGE AST node
		do
		end

	new_feature_as (f: EIFFEL_LIST [FEATURE_NAME]; b: BODY_AS; i: INDEXING_CLAUSE_AS; next_pos: INTEGER): FEATURE_AS is
			-- New FEATURE AST node
		do
		end

	new_feature_clause_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_AS]; l: LOCATION_AS): FEATURE_CLAUSE_AS is
			-- New FEATURE_CLAUSE AST node
		do
		end

	new_feature_list_as (f: EIFFEL_LIST [FEATURE_NAME]): FEATURE_LIST_AS is
			-- New FEATURE_LIST AST node
		do
		end

	new_feature_name_alias_as (feature_name: ID_AS; alias_name: STRING_AS; is_frozen: BOOLEAN; has_convert_mark: BOOLEAN): FEATURE_NAME_ALIAS_AS is
			-- New FEATURE_NAME_ALIAS AST node
		do
		end

	new_feature_name_id_as (f: ID_AS; b: BOOLEAN): FEAT_NAME_ID_AS is
			-- New FEAT_NAME_ID AST node
		do
		end

	new_formal_as (n: ID_AS; is_ref, is_exp: BOOLEAN): FORMAL_AS is
			-- New FORMAL AST node
		do
		end

	new_formal_dec_as (f: FORMAL_AS; c: TYPE_AS; cf: EIFFEL_LIST [FEATURE_NAME]): FORMAL_DEC_AS is
			-- New FORMAL_DECLARATION AST node
		do
		end

	new_filled_id_as (l, c, p, s: INTEGER): ID_AS is
			-- New empty ID AST node.
		do
		end

	new_identifier_list (c: INTEGER): CONSTRUCT_LIST [INTEGER] is
			-- New ARRAYED_LIST [INTEGER]
		do
		end
		
	new_if_as (cnd: EXPR_AS; cmp: EIFFEL_LIST [INSTRUCTION_AS];
			ei: EIFFEL_LIST [ELSIF_AS]; e: EIFFEL_LIST [INSTRUCTION_AS];
			end_location: LOCATION_AS): IF_AS
		is
			-- New IF AST node
		do
		end

	new_index_as (t: ID_AS; i: EIFFEL_LIST [ATOMIC_AS]): INDEX_AS is
			-- Create a new INDEX AST node.
		do
		end

	new_infix_as (op: STRING_AS; b: BOOLEAN; l: LOCATION_AS): INFIX_PREFIX_AS is
			-- New INFIX AST node
		do
		end

	new_inspect_as (s: EXPR_AS; c: EIFFEL_LIST [CASE_AS];
			e: EIFFEL_LIST [INSTRUCTION_AS]; end_location: LOCATION_AS): INSPECT_AS
		is
			-- New INSPECT AST node
		do
		end

	new_instr_call_as (c: CALL_AS): INSTR_CALL_AS is
			-- New INSTR_CALL AST node
		do
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING): INTEGER_AS is
			-- New INTEGER_AS node
		do
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING): INTEGER_AS is
			-- New INTEGER_AS node
		do
		end

	new_interval_as (l, u: ATOMIC_AS): INTERVAL_AS is
			-- New INTERVAL AST node
		do
		end

	new_invariant_as (a: EIFFEL_LIST [TAGGED_AS]; once_manifest_string_count: INTEGER): INVARIANT_AS is
			-- New INVARIANT AST node
		do
		end

	new_like_id_as (a: ID_AS): LIKE_ID_AS is
			-- New LIKE_ID AST node
		do
		end

	new_like_current_as (other: CURRENT_AS): LIKE_CUR_AS is
			-- New LIKE_CURRENT AST node
		do
		end

	new_location_as (l, c, p, s: INTEGER): LOCATION_AS is
			-- New LOCATION_AS
		do
		end

	new_loop_as (f: EIFFEL_LIST [INSTRUCTION_AS]; i: EIFFEL_LIST [TAGGED_AS];
			v: VARIANT_AS; s: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS];
			e: LOCATION_AS): LOOP_AS
		is
			-- New LOOP AST node
		do
		end

	new_nested_as (t: ACCESS_AS; m: CALL_AS): NESTED_AS is
			-- New NESTED CALL AST node
		do
		end

	new_nested_expr_as (t: EXPR_AS; m: CALL_AS): NESTED_EXPR_AS is
			-- New NESTED_EXPR CALL AST node
		do
		end

	new_none_type_as: NONE_TYPE_AS is
			-- New type AST node for "NONE"
		do
		end

	new_once_as (c: EIFFEL_LIST [INSTRUCTION_AS]): ONCE_AS is
			-- New ONCE AST node
		do
		end

	new_operand_as (c: TYPE_AS; t: ACCESS_AS; e: EXPR_AS): OPERAND_AS is
			-- New OPERAND AST node
		do
		end

	new_paran_as (e: EXPR_AS): PARAN_AS is
			-- New PARAN AST node
		do
		end

	new_parent_as (t: CLASS_TYPE_AS; rn: EIFFEL_LIST [RENAME_AS];
			e: EIFFEL_LIST [EXPORT_ITEM_AS]; u: EIFFEL_LIST [FEATURE_NAME];
			rd: EIFFEL_LIST [FEATURE_NAME]; s: EIFFEL_LIST [FEATURE_NAME]; ed: LOCATION_AS): PARENT_AS
		is
			-- New PARENT AST node
		do
		end

	new_precursor_as (pk: LOCATION_AS; n: CLASS_TYPE_AS; p: EIFFEL_LIST [EXPR_AS]): PRECURSOR_AS is
			-- New PRECURSOR AST node
		do
		end

	new_prefix_as (op: STRING_AS; b: BOOLEAN; l: LOCATION_AS): INFIX_PREFIX_AS is
			-- New PREFIX AST node
		do
		end

	new_real_as (t: TYPE_AS; v: STRING): REAL_AS is
			-- New REAL AST node
		do
		end

	new_rename_as (o, n: FEATURE_NAME): RENAME_AS is
			-- New RENAME_PAIR AST node
		do
		end

	new_require_as (a: EIFFEL_LIST [TAGGED_AS]): REQUIRE_AS is
			-- New REQUIRE AST node
		do
		end

	new_require_else_as (a: EIFFEL_LIST [TAGGED_AS]): REQUIRE_ELSE_AS is
			-- New REQUIRE ELSE AST node
		do
		end

	new_result_as (l, c, p, s: INTEGER): RESULT_AS is
			-- New RESULT AST node
		do
		end

	new_retry_as (l, c, p, s: INTEGER): RETRY_AS is
			-- New RETRY AST node
		do
		end

	new_reverse_as (t: ACCESS_AS; s: EXPR_AS): REVERSE_AS is
			-- New assignment attempt AST node
		do
		end

	new_routine_as (o: STRING_AS; pr: REQUIRE_AS;
			l: EIFFEL_LIST [TYPE_DEC_AS]; b: ROUT_BODY_AS; po: ENSURE_AS;
			r: EIFFEL_LIST [INSTRUCTION_AS]; end_loc: LOCATION_AS;
			oms_count: INTEGER): ROUTINE_AS
		is
			-- New ROUTINE AST node
		do
		end

	new_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS]; is_qualified: BOOLEAN): ROUTINE_CREATION_AS is
			-- New ROUTINE_CREATION AST node
		do
		end

	new_old_routine_creation_as (
			l: AST_EIFFEL; t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS];
			is_qualified: BOOLEAN): PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		is
			-- New ROUTINE_CREATION AST node for obsolete use of `~'.
		do
		end

	new_static_access_as (c: TYPE_AS; f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): STATIC_ACCESS_AS is
			-- New STATIC_ACCESS AST node
		do
		end

	new_string_as (s: STRING; l, c, p, n: INTEGER): STRING_AS is
			-- New STRING AST node
		do
		end

	new_tagged_as (t: ID_AS; e: EXPR_AS): TAGGED_AS is
			-- New TAGGED AST node
		do
		end

	new_tuple_as (exp: EIFFEL_LIST [EXPR_AS]): TUPLE_AS is
			-- New Manifest TUPLE AST node
		do
		end

	new_type_dec_as (i: CONSTRUCT_LIST [INTEGER]; t: TYPE_AS): TYPE_DEC_AS is
			-- New TYPE_DEC AST node
		do
		end
		
	new_type_expr_as (t: TYPE_AS): TYPE_EXPR_AS is
			-- New TYPE_EXPR AST node
		do
		end

	new_un_free_as (op: ID_AS; e: EXPR_AS): UN_FREE_AS is
			-- New UN_FREE AST node
		do
		end

	new_un_minus_as (e: EXPR_AS): UN_MINUS_AS is
			-- New unary - AST node
		do
		end

	new_un_not_as (e: EXPR_AS): UN_NOT_AS is
			-- New unary not AST node
		do
		end

	new_un_old_as (e: EXPR_AS): UN_OLD_AS is
			-- New unary old AST node
		do
		end

	new_un_plus_as (e: EXPR_AS): UN_PLUS_AS is
			-- New unary + AST node
		do
		end

	new_un_strip_as (i: CONSTRUCT_LIST [INTEGER]): UN_STRIP_AS is
			-- New UN_STRIP AST node
		do
		end

	new_unique_as (l, c, p, s: INTEGER): UNIQUE_AS is
			-- New UNIQUE AST node
		do
		end

	new_variant_as (t: ID_AS; e: EXPR_AS): VARIANT_AS is
			-- New VARIANT AST node
		do
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n: INTEGER): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		do
		end

	new_void_as (l, c, p, s: INTEGER): VOID_AS is
			-- New VOID AST node
		do
		end

end -- class AST_FACTORY


--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
