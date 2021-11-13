note
	description: "AST node factories which does not generate any node."

class AST_NULL_FACTORY

inherit
	AST_FACTORY
		redefine
			new_access_assert_as, new_access_feat_as, new_access_id_as, new_access_inv_as,
			new_address_as, new_address_current_as, new_address_result_as, new_all_as, new_array_as,
			new_assign_as, new_attribute_as, new_bin_and_as, new_bin_and_then_as, new_bin_div_as,
			new_bin_eq_as, new_bin_free_as, new_bin_ge_as, new_bin_gt_as, new_bin_implies_as,
			new_bin_le_as, new_bin_lt_as, new_bin_minus_as, new_bin_mod_as, new_bin_ne_as,
			new_bin_not_tilde_as, new_bin_or_as, new_bin_or_else_as, new_bin_plus_as,
			new_bin_power_as, new_bin_slash_as, new_bin_star_as, new_bin_tilde_as,
			new_bin_xor_as, new_built_in_as,
			new_body_as, new_boolean_as, new_case_as, new_case_expression_as, new_character_as, new_check_as, new_class_as,
			new_class_type_as, new_client_as, new_constant_as, new_constraining_type, new_convert_feat_as, new_create_as,
			new_current_as, new_custom_attribute_as,
			new_debug_as, new_deferred_as, new_do_as, new_eiffel_list_atomic_as,
			new_eiffel_list_case_as, new_eiffel_list_case_expression_as, new_eiffel_list_constraining_type_as, new_eiffel_list_convert, new_eiffel_list_create_as,
			new_eiffel_list_elseif_as, new_eiffel_list_elseif_expression_as, new_eiffel_list_export_item_as, new_eiffel_list_expr_as,
			new_eiffel_list_feature_as, new_eiffel_list_feature_clause_as,
			new_eiffel_list_feature_name, new_eiffel_list_feature_name_id, new_eiffel_list_formal_dec_as,
			new_indexing_clause_as, new_eiffel_list_instruction_as, new_eiffel_list_interval_as,
			new_eiffel_list_list_dec_as, new_eiffel_list_named_expression_as,
			new_eiffel_list_operand_as, new_eiffel_list_parent_as, new_eiffel_list_rename_as,
			new_eiffel_list_string_as, new_eiffel_list_tagged_as, new_eiffel_list_type,
			new_eiffel_list_type_dec_as, new_elseif_as, new_ensure_as, new_ensure_then_as,
			new_exit_condition_pair, new_export_item_as, new_expr_address_as, new_expr_call_as, new_external_as,
			new_external_lang_as, new_feature_as, new_feature_clause_as, new_feature_list_as,
			new_feature_name_alias_as, new_feature_name_id_as, new_formal_as, new_formal_dec_as, new_filled_id_as,
			new_guard_as, new_identifier_list, new_if_as, new_if_expression_as, new_index_as,
			new_inline_agent_creation_as, new_inspect_as, new_inspect_expression_as,
			new_instr_call_as, new_integer_as, new_integer_hexa_as, new_integer_octal_as,
			new_integer_binary_as, new_interval_as, new_invariant_as, new_iteration_as,
			new_like_id_as, new_like_current_as, new_list_dec_as, new_location_as, new_loop_as, new_loop_expr_as,
			new_named_expression_as, new_nested_expr_as, new_none_type_as,
			new_object_test_as, new_old_syntax_object_test_as, new_once_as, new_operand_as,
			new_paran_as, new_parent_as, new_precursor_as,
			new_qualified_anchored_type, new_qualified_anchored_type_with_type,
			new_real_as, new_rename_as, new_require_as, new_require_else_as,
			new_result_as, new_retry_as, new_reverse_as, new_routine_as,
			new_separate_instruction_as, new_static_access_as, new_string_as, new_symbol_id_as, new_tagged_as,
			new_tuple_as, new_type_dec_as, new_type_expr_as, new_un_free_as, new_un_minus_as,
			new_un_not_as, new_un_old_as, new_un_plus_as, new_un_strip_as, new_unique_as,
			new_variant_as, new_verbatim_string_as, new_void_as, new_filled_none_id_as,
			new_assigner_call_as,
			new_creation_as,
			new_creation_expr_as,
			new_bracket_as,
			new_assigner_mark_as, new_typed_char_as,
			new_character_value_as, new_integer_value, new_real_value,
			set_buffer, append_text_to_buffer, append_character_to_buffer,
			append_two_characters_to_buffer, new_string,
			create_match_list,
			reverse_extend_separator, reverse_extend_identifier, reverse_extend_identifier_separator,
			new_agent_routine_creation_as,
			new_constraint_triple, new_alias_name, new_agent_target_triple,
			new_keyword_instruction_list_pair, new_keyword_string_pair, new_invariant_pair,
			new_keyword_as, new_keyword_id_as, new_creation_keyword_as, new_end_keyword_as, new_frozen_keyword_as,
			new_precursor_keyword_as, new_once_string_keyword_as,
			new_symbol_as, new_square_symbol_as,
			create_break_as, create_break_as_with_data,
			new_filled_id_as_with_existing_stub,
			new_feature_keyword_as, new_predecessor_as,
			new_class_list_as, new_local_dec_list_as, new_formal_argu_dec_list_as, new_key_list_as,
			new_delayed_actual_list_as, new_parameter_list_as,
			new_rename_clause_as, new_export_clause_as, new_undefine_clause_as, new_redefine_clause_as, new_select_clause_as,
			new_creation_constrain_triple, new_named_tuple_type_as, new_line_pragma
		end

feature -- Buffer operation

	set_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON)
			-- Clear `a_buf' and then set it with `a_scn'.text.
		do
		end

	append_text_to_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON)
			-- Append `a_scn'.text to end of buffer `a_buf'.
		do
		end

	append_character_to_buffer (a_buf: STRING; c: CHARACTER)
			-- Append `c' to end of buffer `a_buf'.
		do
		end

	append_two_characters_to_buffer (a_buf: STRING; a, b: CHARACTER)
			-- Append `a' and `b' to end of buffer `a_buf'.
		do
		end

	new_string (a_count: INTEGER): detachable STRING
		do
		end

feature -- Roundtrip: Match list maintaining

	create_match_list (l_size: INTEGER)
			-- New match list
		do
		end

feature -- Roundtrip

	reverse_extend_separator (a_list: detachable EIFFEL_LIST [AST_EIFFEL]; l_as: detachable LEAF_AS)
			-- Add `l_as' into `a_list'.separator_list in reverse order.
		do
		end

	reverse_extend_identifier (a_list: detachable IDENTIFIER_LIST; l_as: detachable ID_AS)
			-- Add `l_as' into `a_list'.
		do
		end

	reverse_extend_identifier_separator (a_list: detachable IDENTIFIER_LIST; l_as: detachable LEAF_AS)
			-- Add `l_as' into `a_list.separator_list'.
		do
		end

feature -- Roundtrip: New AST node

	new_agent_routine_creation_as (t: detachable OPERAND_AS; f: detachable ID_AS; o: detachable DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: detachable KEYWORD_AS; d_as: detachable SYMBOL_AS): detachable AGENT_ROUTINE_CREATION_AS
			-- New AGENT_ROUTINE_CREATION AST node.
		do
		end

	new_inline_agent_creation_as (a_b: detachable BODY_AS; a_o: detachable DELAYED_ACTUAL_LIST_AS; a_as: detachable KEYWORD_AS): detachable INLINE_AGENT_CREATION_AS
			-- New INLINE_AGENT_CREATION AST node.
		do
		end

	new_creation_as (is_active: BOOLEAN; tp: detachable TYPE_AS; tg: detachable ACCESS_AS; c: detachable ACCESS_INV_AS; k_as: detachable KEYWORD_AS): detachable CREATION_AS
			-- New CREATION AST node.
		do
		end

	new_creation_expr_as (is_active: BOOLEAN; t: detachable TYPE_AS; c: detachable ACCESS_INV_AS; k_as: detachable KEYWORD_AS): detachable CREATION_EXPR_AS
			-- New creation expression AST node
		do
		end

	new_assigner_mark_as (k_as: detachable KEYWORD_AS; i_as: detachable ID_AS): detachable PAIR [KEYWORD_AS, ID_AS]
			-- New pair of assigner_mark structure.
		do
		end

	new_filled_none_id_as (l, c, p, s, cc, cp, cs: INTEGER): detachable NONE_ID_AS
			-- New empty ID AST node.
		do
		end

	new_constraint_triple (k_as: detachable SYMBOL_AS; t_as: detachable CONSTRAINT_LIST_AS; l_as: detachable CREATION_CONSTRAIN_TRIPLE): detachable CONSTRAINT_TRIPLE
			-- New constraint triple structure.
		do
		end

	new_constraining_type (a_type_as: detachable TYPE_AS; a_renameing_clause_as: detachable RENAME_CLAUSE_AS; a_comma_as: detachable KEYWORD_AS): detachable CONSTRAINING_TYPE_AS
			-- New constraining type structure.
		do
		end

	new_eiffel_list_constraining_type_as (n: INTEGER): detachable CONSTRAINT_LIST_AS
			-- <Precursor>
		do
		end

	new_alias_name (a: detachable KEYWORD_AS; s: detachable STRING_AS; k: like {OPERATOR_KIND}.kind_anchor): detachable FEATURE_ALIAS_NAME
			-- <Precursor>
		do
		end

	new_agent_target_triple (l_as, r_as: detachable SYMBOL_AS; o_as: detachable OPERAND_AS): detachable AGENT_TARGET_TRIPLE
			-- New ALIST_TRIPLE.
		do
		end

	new_keyword_instruction_list_pair (k_as: detachable KEYWORD_AS; i_as: detachable EIFFEL_LIST [INSTRUCTION_AS]): detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
			-- New ALIST_TRIPLE.
		do
		end

	new_keyword_string_pair (k_as: detachable KEYWORD_AS; s_as: detachable STRING_AS): detachable PAIR [KEYWORD_AS, STRING_AS]
			-- New ALIST_TRIPLE.
		do
		end

	new_invariant_pair (k_as: detachable KEYWORD_AS; i_as: detachable EIFFEL_LIST [TAGGED_AS]): detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
			-- New PAIR for a keyword and a tagged_as list.
		do
		end

	new_exit_condition_pair (u: detachable KEYWORD_AS; e: detachable EXPR_AS): detachable PAIR [KEYWORD_AS, EXPR_AS]
			-- <Precursor>
		do
		end

feature -- Roundtrip: constants

	new_character_value_as (a_psr: EIFFEL_SCANNER_SKELETON; buffer: STRING; roundtrip_buffer: STRING): detachable CHAR_AS
		do
		end

	new_integer_value (a_psr: EIFFEL_SCANNER_SKELETON; sign_symbol: CHARACTER; a_type: detachable TYPE_AS; buffer: READABLE_STRING_8; s_as: detachable SYMBOL_AS): detachable INTEGER_AS
		do
		end

	new_real_value (a_psr: EIFFEL_SCANNER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: detachable TYPE_AS; buffer: STRING; s_as: detachable SYMBOL_AS): detachable REAL_AS
		do
		end

feature -- Roundtrip: New node

	new_typed_char_as (t_as: detachable TYPE_AS; a_char: detachable CHAR_AS): detachable TYPED_CHAR_AS
			-- New TYPED_CHAR AST node.
		do
		end

	new_line_pragma (a_scn: EIFFEL_SCANNER_SKELETON): detachable BREAK_AS
			-- New line pragma
		do
		end

feature -- Roundtrip: leaf_as

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node
		do
		end

	new_keyword_id_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable like keyword_id_type
		do
		end

	new_semicolon_symbol_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable SYMBOL_AS
			-- New symbol AST node for ";"
		do
		end

	new_feature_keyword_as (l, c, p, s, cc, cp, cs:INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "feature".
		do
		end

	new_keyword_as_without_extending_list (a_code:INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node, but don't extend `internal_match_list'.
		do
		end

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "creation'
		do
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "end'
		do
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "frozen'
		do
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "precursor'
		do
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n, cc, cp, cn: INTEGER): detachable KEYWORD_AS
			-- New KEYWORD AST node
		do
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable SYMBOL_AS
			-- New KEYWORD AST node	all Eiffel symbols except "[" and "]"
		do
		end

	new_symbol_id_as (c: INTEGER; s: EIFFEL_SCANNER_SKELETON): detachable like symbol_id_type
		do
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable SYMBOL_AS
			-- New KEYWORD AST node	only for symbol "[" and "]"
		do
		end

	create_break_as (a_scn: EIFFEL_SCANNER_SKELETON)
			-- NEw BREAK_AS node
		do
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n, cc, cp, cn: INTEGER)
			-- New COMMENT_AS node
		do
		end

feature -- Access

	new_access_assert_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS): detachable ACCESS_ASSERT_AS
			-- New ACCESS_ASSERT AST node
		do
		end

	new_access_feat_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS): detachable ACCESS_FEAT_AS
			-- New ACCESS_FEAT AST node
		do
		end

	new_access_id_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS): detachable ACCESS_ID_AS
			-- New ACCESS_ID AST node
		do
		end

	new_access_inv_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS; k_as: detachable SYMBOL_AS): detachable ACCESS_INV_AS
			-- New ACCESS_INV AST node
		do
		end

	new_address_as (f: detachable FEATURE_NAME; a_as: detachable SYMBOL_AS): detachable ADDRESS_AS
			-- New ADDRESS AST node
		do
		end

	new_address_current_as (other: detachable CURRENT_AS; a_as: detachable SYMBOL_AS): detachable ADDRESS_CURRENT_AS
			-- New ADDRESS_CURRENT AST node
		do
		end

	new_address_result_as (other: detachable RESULT_AS; a_as: detachable SYMBOL_AS): detachable ADDRESS_RESULT_AS
			-- New ADDRESS_RESULT AST node
		do
		end

	new_all_as (a_as: detachable KEYWORD_AS): detachable ALL_AS
			-- New ALL AST node
		do
		end

	new_array_as (exp: detachable EIFFEL_LIST [EXPR_AS]; l_as, r_as: detachable SYMBOL_AS): detachable ARRAY_AS
			-- New Manifest ARRAY AST node
		do
		end

	new_assign_as (t: detachable ACCESS_AS; s: detachable EXPR_AS; a_as: detachable SYMBOL_AS): detachable ASSIGN_AS
			-- New ASSIGN AST node
		do
		end

	new_assigner_call_as (t: detachable EXPR_AS; s: detachable EXPR_AS; a_as: detachable SYMBOL_AS): detachable ASSIGNER_CALL_AS
			-- New ASSIGNER CALL AST node
		do
		end

	new_attribute_as (c: detachable EIFFEL_LIST [INSTRUCTION_AS]; k_as: detachable KEYWORD_AS): detachable ATTRIBUTE_AS
			-- New ATTRIBUTE AST node
		do
		end

	new_bin_and_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_AND_AS
			-- New binary and AST node
		do
		end

	new_bin_and_then_as (l, r: detachable EXPR_AS; k_as, s_as: detachable KEYWORD_AS): detachable BIN_AND_THEN_AS
			-- New binary and then AST node
		do
		end

	new_bin_div_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_DIV_AS
			-- New binary // AST node
		do
		end

	new_bin_eq_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_EQ_AS
			-- New binary = AST node
		do
		end

	new_bin_free_as (l: detachable EXPR_AS; op: detachable ID_AS; r: detachable EXPR_AS): detachable BIN_FREE_AS
			-- New BIN_FREE AST node
		do
		end

	new_bin_ge_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_GE_AS
			-- New binary >= AST node
		do
		end

	new_bin_gt_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_GT_AS
			-- New binary > AST node
		do
		end

	new_bin_implies_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_IMPLIES_AS
			-- New binary implies AST node
		do
		end

	new_bin_le_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_LE_AS
			-- New binary <= AST node
		do
		end

	new_bin_lt_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_LT_AS
			-- New binary < AST node
		do
		end

	new_bin_minus_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_MINUS_AS
			-- New binary - AST node
		do
		end

	new_bin_mod_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_MOD_AS
			-- New binary \\ AST node
		do
		end

	new_bin_ne_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_NE_AS
			-- New binary /= AST node
		do
		end

	new_bin_not_tilde_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_NOT_TILDE_AS
			-- New binary /~ AST node
		do
		end

	new_bin_or_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_OR_AS
			-- New binary or AST node
		do
		end

	new_bin_or_else_as (l, r: detachable EXPR_AS; k_as, s_as: detachable KEYWORD_AS): detachable BIN_OR_ELSE_AS
			-- New binary or else AST node
		do
		end

	new_bin_plus_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_PLUS_AS
			-- New binary + AST node
		do
		end

	new_bin_power_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_POWER_AS
			-- New binary ^ AST node
		do
		end

	new_bin_slash_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_SLASH_AS
			-- New binary / AST node
		do
		end

	new_bin_star_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_STAR_AS
			-- New binary * AST node
		do
		end

	new_bin_tilde_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_TILDE_AS
			-- New binary ~ AST node
		do
		end

	new_bin_xor_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_XOR_AS
			-- New binary xor AST node
		do
		end

	new_bracket_as (t: detachable EXPR_AS; o: detachable EIFFEL_LIST [EXPR_AS]; l_as, r_as: detachable SYMBOL_AS): detachable BRACKET_AS
			-- New BRACKET AST node
		do
		end

	new_body_as (a: detachable FORMAL_ARGU_DEC_LIST_AS; t: detachable TYPE_AS; r: detachable ID_AS; c: detachable CONTENT_AS; c_as: detachable SYMBOL_AS; k_as: detachable LEAF_AS; a_as: detachable KEYWORD_AS; i_as: detachable INDEXING_CLAUSE_AS): detachable BODY_AS
			-- New BODY AST node
		do
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER_SKELETON): detachable BOOL_AS
			-- New BOOLEAN AST node
		do
		end

	new_built_in_as (l: detachable EXTERNAL_LANG_AS; a: detachable STRING_AS; e_as, a_as: detachable KEYWORD_AS): detachable BUILT_IN_AS
			-- New BUILT_IN AST node
		do
		end

	new_case_as (i: detachable EIFFEL_LIST [INTERVAL_AS]; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; w_as, t_as: detachable KEYWORD_AS): detachable CASE_AS
			-- New WHEN AST node
		do
		end

	new_case_expression_as (i: detachable EIFFEL_LIST [INTERVAL_AS]; e: detachable EXPR_AS; w, t: detachable KEYWORD_AS): detachable CASE_EXPRESSION_AS
			-- <Precursor>
		do
		end

	new_character_as (c: CHARACTER_32; l, co, p, n, cc, cp, cs: INTEGER; a_text: STRING): detachable CHAR_AS
			-- New CHARACTER AST node
		do
		end

	new_check_as (c: detachable EIFFEL_LIST [TAGGED_AS]; c_as, e: detachable KEYWORD_AS): detachable CHECK_AS
			-- New CHECK AST node
		do
		end

	new_class_as (n: detachable ID_AS; ext_name: detachable STRING_AS;
			is_d, is_e, is_fc, is_ex, is_par, is_o: BOOLEAN;
			top_ind, bottom_ind: detachable INDEXING_CLAUSE_AS;
			g: detachable EIFFEL_LIST [FORMAL_DEC_AS];
			cp: detachable PARENT_LIST_AS;
			ncp: detachable PARENT_LIST_AS
			c: detachable EIFFEL_LIST [CREATE_AS];
			co: detachable CONVERT_FEAT_LIST_AS;
			f: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: detachable INVARIANT_AS;
			s: detachable SUPPLIERS_AS;
			o: detachable STRING_AS;
			ed: detachable KEYWORD_AS): detachable CLASS_AS
			-- <Precursor>
		do
		end

	new_class_type_as (n: detachable ID_AS; g: detachable TYPE_LIST_AS): detachable CLASS_TYPE_AS
			-- New CLASS_TYPE AST node
		do
		end

	new_named_tuple_type_as (n: detachable ID_AS; p: detachable FORMAL_ARGU_DEC_LIST_AS): detachable NAMED_TUPLE_TYPE_AS
			-- New TUPLE_TYPE AST node
		do
		end

	new_client_as (c: detachable CLASS_LIST_AS): detachable CLIENT_AS
			-- New CLIENT AST node
		do
		end

	new_constant_as (a: detachable ATOMIC_AS): detachable CONSTANT_AS
			-- New CONSTANT_AS node
		do
		end

	new_convert_feat_as (cr: BOOLEAN; fn: detachable FEATURE_NAME; t: detachable TYPE_LIST_AS; l_as, r_as, c_as, lc_as, rc_as: detachable SYMBOL_AS): detachable CONVERT_FEAT_AS
			-- New convert feature entry AST node.
		do
		end

	new_create_as (c: detachable CLIENT_AS; f: detachable EIFFEL_LIST [FEATURE_NAME]; c_as: detachable KEYWORD_AS): detachable CREATE_AS
			-- New creation clause AST node
		do
		end

	new_current_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable CURRENT_AS
			-- New CURRENT AST node
		do
		end

	new_custom_attribute_as (c: detachable CREATION_EXPR_AS; t: detachable TUPLE_AS; k_as: detachable KEYWORD_AS): detachable CUSTOM_ATTRIBUTE_AS
			-- Create a new UNIQUE AST node.
		do
		end

	new_debug_as (k: detachable KEY_LIST_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: detachable KEYWORD_AS): detachable DEBUG_AS
			-- New DEBUG AST node
		do
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable DEFERRED_AS
			-- New DEFERRED AST node
		do
		end

	new_do_as (c: detachable EIFFEL_LIST [INSTRUCTION_AS]; k_as: detachable KEYWORD_AS): detachable DO_AS
			-- New DO AST node
		do
		end

	new_eiffel_list_atomic_as (a: detachable ATOMIC_AS; n: INTEGER): detachable EIFFEL_LIST [ATOMIC_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_case_as (a: CASE_AS; n: INTEGER): detachable EIFFEL_LIST [CASE_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_case_expression_as (a: CASE_EXPRESSION_AS; n: INTEGER): detachable EIFFEL_LIST [CASE_EXPRESSION_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_convert (a: CONVERT_FEAT_AS; n: INTEGER): detachable CONVERT_FEAT_LIST_AS
			-- <Precursor>
		do
		end

	new_eiffel_list_create_as (a: CREATE_AS; n: INTEGER): detachable EIFFEL_LIST [CREATE_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_elseif_as (a: ELSIF_AS; n: INTEGER): detachable EIFFEL_LIST [ELSIF_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_elseif_expression_as (a: ELSIF_EXPRESSION_AS; n: INTEGER): detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_export_item_as (a: EXPORT_ITEM_AS; n: INTEGER): detachable EIFFEL_LIST [EXPORT_ITEM_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_expr_as (a: detachable EXPR_AS; n: INTEGER): detachable EIFFEL_LIST [EXPR_AS]
			-- <Precursor>
		do
		end

	new_parameter_list_as (l: detachable EIFFEL_LIST [EXPR_AS]; lp_as, rp_as: detachable SYMBOL_AS): detachable PARAMETER_LIST_AS
			-- New empty list of PARAMETER_LIST_AS
		do
		end

	new_eiffel_list_feature_as (a: detachable FEATURE_AS; n: INTEGER): detachable EIFFEL_LIST [FEATURE_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_feature_clause_as (a: FEATURE_CLAUSE_AS; n: INTEGER): detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_feature_name (a: FEATURE_NAME; n: INTEGER): detachable EIFFEL_LIST [FEATURE_NAME]
			-- <Precursor>
		do
		end

	new_eiffel_list_feature_name_id (a: FEATURE_NAME; n: INTEGER): detachable EIFFEL_LIST [FEATURE_NAME]
			-- <Precursor>
		do
		end

	new_eiffel_list_formal_dec_as (a: detachable FORMAL_DEC_AS; n: INTEGER): detachable FORMAL_GENERIC_LIST_AS
			-- <Precursor>
		do
		end

	new_indexing_clause_as (v: detachable INDEX_AS; n: INTEGER): detachable INDEXING_CLAUSE_AS
			-- <Precursor>
		do
		end

	new_eiffel_list_instruction_as (a: detachable INSTRUCTION_AS; n: INTEGER): detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_interval_as (a: INTERVAL_AS; n: INTEGER): detachable EIFFEL_LIST [INTERVAL_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_named_expression_as (a: NAMED_EXPRESSION_AS; n: INTEGER): detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_operand_as (a: OPERAND_AS; n: INTEGER): detachable EIFFEL_LIST [OPERAND_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_parent_as (a: detachable PARENT_AS; n: INTEGER): detachable PARENT_LIST_AS
			-- <Precursor>
		do
		end

	new_eiffel_list_rename_as (a: RENAME_AS; n: INTEGER): detachable EIFFEL_LIST [RENAME_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_string_as (a: STRING_AS; n: INTEGER): detachable EIFFEL_LIST [STRING_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_tagged_as (n: INTEGER): detachable EIFFEL_LIST [TAGGED_AS]
			-- <Precursor>
		do
		end

	new_eiffel_list_type (a: detachable TYPE_AS; n: INTEGER): detachable TYPE_LIST_AS
			-- <Precursor>
		do
		end

	new_eiffel_list_list_dec_as (a: LIST_DEC_AS; n: INTEGER): detachable LIST_DEC_LIST_AS
			-- <Precursor>
		do
		end

	new_eiffel_list_type_dec_as (a: detachable TYPE_DEC_AS; n: INTEGER): detachable TYPE_DEC_LIST_AS
			-- <Precursor>
		do
		end

	new_elseif_as (e: detachable EXPR_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; l_as, t_as: detachable KEYWORD_AS): detachable ELSIF_AS
			-- New ELSIF AST node
		do
		end

	new_ensure_as (a: detachable EIFFEL_LIST [TAGGED_AS]; c: BOOLEAN; k_as: detachable KEYWORD_AS): detachable ENSURE_AS
			-- New ENSURE AST node
		do
		end

	new_ensure_then_as (a: detachable EIFFEL_LIST [TAGGED_AS]; c: BOOLEAN; k_as, l_as: detachable KEYWORD_AS): detachable ENSURE_THEN_AS
			-- New ENSURE THEN AST node
		do
		end

	new_export_item_as (c: detachable CLIENT_AS; f: detachable FEATURE_SET_AS): detachable EXPORT_ITEM_AS
			-- New EXPORT_ITEM AST node
		do
		end

	new_expr_address_as (e: detachable EXPR_AS; a_as, l_as, r_as: detachable SYMBOL_AS): detachable EXPR_ADDRESS_AS
			-- New EXPR_ADDRESS AST node
		do
		end

	new_expr_call_as (c: detachable CALL_AS): detachable EXPR_CALL_AS
			-- New EXPR_CALL AST node
		do
		end

	new_external_as (l: detachable EXTERNAL_LANG_AS; a: detachable STRING_AS; e_as, a_as: detachable KEYWORD_AS): detachable EXTERNAL_AS
			-- New EXTERNAL AST node
		do
		end

	new_external_lang_as (l: detachable STRING_AS): detachable EXTERNAL_LANG_AS
			-- New EXTERNAL_LANGUAGE AST node
		do
		end

	new_feature_as (f: detachable EIFFEL_LIST [FEATURE_NAME]; b: detachable BODY_AS; i: detachable INDEXING_CLAUSE_AS; next_pos: INTEGER): detachable FEATURE_AS
			-- New FEATURE AST node
		do
		end

	new_feature_clause_as (c: detachable CLIENT_AS; f: detachable EIFFEL_LIST [FEATURE_AS]; l: detachable KEYWORD_AS; ep: INTEGER): detachable FEATURE_CLAUSE_AS
			-- New FEATURE_CLAUSE AST node
		do
		end

	new_feature_list_as (f: detachable EIFFEL_LIST [FEATURE_NAME]): detachable FEATURE_LIST_AS
			-- New FEATURE_LIST AST node
		do
		end

	new_feature_name_alias_as (feature_name: detachable ID_AS; a_alias_list: detachable LIST [FEATURE_ALIAS_NAME]; c_as: detachable KEYWORD_AS): detachable FEATURE_NAME_ALIAS_AS
			-- New FEATURE_NAME_ALIAS AST node
		do
		end

	new_feature_name_id_as (f: detachable ID_AS): detachable FEATURE_NAME
			-- New FEAT_NAME_ID AST node
		do
		end

	new_formal_as (n: detachable ID_AS; is_ref, is_exp, is_frozen: BOOLEAN; r_as: detachable KEYWORD_AS): detachable FORMAL_AS
			-- New FORMAL AST node
		do
		end

	new_formal_dec_as (f: detachable FORMAL_AS; c: detachable CONSTRAINT_LIST_AS; cf: detachable EIFFEL_LIST [FEATURE_NAME]; c_as: detachable SYMBOL_AS; ck_as, ek_as: detachable KEYWORD_AS): detachable FORMAL_DEC_AS
			-- New FORMAL_DECLARATION AST node
		do
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable ID_AS
			-- New empty ID AST node.
		do
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): detachable ID_AS
			-- New empty ID AST node.
		do
		end

	new_guard_as (c: detachable KEYWORD_AS; a: detachable EIFFEL_LIST [TAGGED_AS]; t: detachable KEYWORD_AS;
	              l: detachable EIFFEL_LIST [INSTRUCTION_AS]; e: detachable KEYWORD_AS): detachable GUARD_AS
			-- <Precursor>
		do
		end

	new_identifier_list (a: like {ID_AS}.name_id; n: INTEGER): detachable IDENTIFIER_LIST
			-- <Precursor>
		do
		end

	new_if_as (cnd: detachable EXPR_AS; cmp: detachable EIFFEL_LIST [INSTRUCTION_AS];
			ei: detachable EIFFEL_LIST [ELSIF_AS]; e: detachable EIFFEL_LIST [INSTRUCTION_AS];
			end_location, i_as, t_as, e_as: detachable KEYWORD_AS): detachable IF_AS
			-- New IF AST node
		do
		end

	new_if_expression_as (c: detachable EXPR_AS; t: detachable EXPR_AS;
			ei: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]; e: detachable EXPR_AS;
			end_location, i_as, t_as, e_as: detachable KEYWORD_AS): detachable IF_EXPRESSION_AS
			-- <Precursor>
		do
		end

	new_index_as (t: detachable ID_AS; i: detachable EIFFEL_LIST [ATOMIC_AS]; c_as: detachable SYMBOL_AS): detachable INDEX_AS
			-- Create a new INDEX AST node.
		do
		end

	new_inspect_as (s: detachable EXPR_AS; c: detachable EIFFEL_LIST [CASE_AS];
			e: detachable EIFFEL_LIST [INSTRUCTION_AS]; end_location, i_as, e_as: detachable  KEYWORD_AS): detachable INSPECT_AS
			-- New INSPECT AST node
		do
		end

	new_inspect_expression_as (s: detachable EXPR_AS; c: detachable EIFFEL_LIST [CASE_EXPRESSION_AS];
			e: detachable EXPR_AS; end_location, i_as, e_as: detachable  KEYWORD_AS): detachable INSPECT_EXPRESSION_AS
			-- <Precursor>
		do
		end

	new_instr_call_as (c: detachable CALL_AS): detachable INSTR_CALL_AS
			-- New INSTR_CALL AST node
		do
		end

	new_integer_as (t: detachable TYPE_AS; s: BOOLEAN; v: detachable STRING; buf: detachable READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
		end

	new_integer_hexa_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
		end

	new_integer_octal_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
		end

	new_integer_binary_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
		end

	new_interval_as (l, u: detachable ATOMIC_AS; d_as: detachable SYMBOL_AS): detachable INTERVAL_AS
			-- New INTERVAL AST node
		do
		end

	new_invariant_as (a: detachable EIFFEL_LIST [TAGGED_AS]; once_manifest_string_count: INTEGER; i_as: detachable KEYWORD_AS; object_test_locals: detachable ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]): detachable INVARIANT_AS
			-- New INVARIANT AST node
		do
		end

	new_iteration_as (a: detachable KEYWORD_AS; e: detachable EXPR_AS; b: detachable KEYWORD_AS; i: detachable ID_AS; is_restricted: BOOLEAN): detachable ITERATION_AS
			-- <Precursor>
		do
		end

	new_like_id_as (a: detachable ID_AS; l_as: detachable KEYWORD_AS): detachable LIKE_ID_AS
			-- New LIKE_ID AST node
		do
		end

	new_like_current_as (other: detachable CURRENT_AS; l_as: detachable KEYWORD_AS): detachable LIKE_CUR_AS
			-- New LIKE_CURRENT AST node
		do
		end

	new_location_as (l, c, p, s, cc, cp, cs: INTEGER): detachable LOCATION_AS
			-- New LOCATION_AS
		do
		end

	new_loop_as (t: detachable ITERATION_AS; f: detachable EIFFEL_LIST [INSTRUCTION_AS]; i: detachable EIFFEL_LIST [TAGGED_AS];
			v: detachable VARIANT_AS; s: detachable EXPR_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS];
			e, f_as, i_as, u_as, l_as: detachable KEYWORD_AS; r, bc: detachable SYMBOL_AS): detachable LOOP_AS
			-- <Precursor>
		do
		end

	new_loop_expr_as (f: detachable ITERATION_AS; w: detachable KEYWORD_AS; i: detachable EIFFEL_LIST [TAGGED_AS];
			u: detachable KEYWORD_AS; c: detachable EXPR_AS; q: detachable KEYWORD_AS; s: detachable SYMBOL_AS; a: BOOLEAN; e: detachable EXPR_AS; v: detachable VARIANT_AS; k: detachable KEYWORD_AS): detachable LOOP_EXPR_AS
			-- New LOOP expression AST node
		do
		end

	new_named_expression_as (e: detachable EXPR_AS; a: detachable KEYWORD_AS; n: detachable ID_AS): detachable NAMED_EXPRESSION_AS
			-- <Precursor>
		do
		end

	new_nested_expr_as (t: detachable EXPR_AS; m: detachable ACCESS_FEAT_AS; d_as: detachable SYMBOL_AS): detachable NESTED_EXPR_AS
			-- New NESTED_EXPR CALL AST node
		do
		end

	new_none_type_as (c: detachable ID_AS): detachable NONE_TYPE_AS
			-- New type AST node for "NONE"
		do
		end

	new_object_test_as (l_attached: detachable KEYWORD_AS; type: detachable TYPE_AS; expression: detachable EXPR_AS; l_as: detachable KEYWORD_AS; name: detachable ID_AS): detachable OBJECT_TEST_AS
			-- New OBJECT_TEST_AS node
		do
		end

	new_old_syntax_object_test_as (start: detachable SYMBOL_AS; name: detachable ID_AS; type: detachable TYPE_AS; expression: detachable EXPR_AS): detachable OBJECT_TEST_AS
			-- New OBJECT_TEST_AS node
		do
		end

	new_once_as (o: detachable KEYWORD_AS; k: detachable KEY_LIST_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]): detachable ONCE_AS
			-- New ONCE AST node
		do
		end

	new_operand_as (c: detachable TYPE_AS; e: detachable EXPR_AS): detachable OPERAND_AS
			-- New OPERAND AST node
		do
		end

	new_paran_as (e: detachable EXPR_AS; l_as, r_as: detachable SYMBOL_AS): detachable PARAN_AS
			-- New PARAN AST node
		do
		end

	new_parent_as (t: detachable CLASS_TYPE_AS; rn: detachable RENAME_CLAUSE_AS;
			e: detachable EXPORT_CLAUSE_AS; u: detachable UNDEFINE_CLAUSE_AS;
			rd: detachable REDEFINE_CLAUSE_AS; s: detachable SELECT_CLAUSE_AS; ed: detachable KEYWORD_AS): detachable PARENT_AS
			-- New PARENT AST node
		do
		end

	new_precursor_as (pk: detachable KEYWORD_AS; n: detachable CLASS_TYPE_AS; p: detachable PARAMETER_LIST_AS): detachable PRECURSOR_AS
			-- New PRECURSOR AST node
		do
		end

	new_qualified_anchored_type (t: detachable TYPE_AS; d: detachable SYMBOL_AS; f: detachable ID_AS): detachable QUALIFIED_ANCHORED_TYPE_AS
			-- <Precursor>
		do
		end

	new_qualified_anchored_type_with_type (l: detachable KEYWORD_AS; t: detachable TYPE_AS; d: detachable SYMBOL_AS; f: detachable ID_AS): detachable QUALIFIED_ANCHORED_TYPE_AS
			-- <Precursor>
		do
		end

	new_predecessor_as (n: detachable ID_AS; s: detachable SYMBOL_AS): detachable PREDECESSOR_AS
			-- <Precursor>
		do
		end

	new_real_as (t: detachable TYPE_AS; v: detachable READABLE_STRING_8; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable REAL_AS
			-- New REAL AST node
		do
		end

	new_rename_as (o, n: detachable FEATURE_NAME; k_as: detachable KEYWORD_AS): detachable RENAME_AS
			-- New RENAME_PAIR AST node
		do
		end

	new_require_as (a: detachable EIFFEL_LIST [TAGGED_AS]; k_as: detachable KEYWORD_AS): detachable REQUIRE_AS
			-- New REQUIRE AST node
		do
		end

	new_require_else_as (a: detachable EIFFEL_LIST [TAGGED_AS]; k_as, l_as: detachable KEYWORD_AS): detachable REQUIRE_ELSE_AS
			-- New REQUIRE ELSE AST node
		do
		end

	new_result_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable RESULT_AS
			-- New RESULT AST node
		do
		end

	new_retry_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable RETRY_AS
			-- New RETRY AST node
		do
		end

	new_reverse_as (t: detachable ACCESS_AS; s: detachable EXPR_AS; a_as: detachable SYMBOL_AS): detachable REVERSE_AS
			-- New assignment attempt AST node
		do
		end

	new_routine_as (o: detachable STRING_AS; pr: detachable REQUIRE_AS;
			l: detachable LOCAL_DEC_LIST_AS; b: detachable ROUT_BODY_AS; po: detachable ENSURE_AS;
			r: detachable EIFFEL_LIST [INSTRUCTION_AS]; end_loc: detachable KEYWORD_AS;
			oms_count, a_pos: INTEGER; k_as, r_as: detachable KEYWORD_AS;
			object_test_locals: detachable ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]];
			n, a, u: BOOLEAN): detachable ROUTINE_AS
			-- <Precursor>
		do
		end

	new_separate_instruction_as (s: detachable KEYWORD_AS; a: detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]; d: detachable KEYWORD_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; e: detachable KEYWORD_AS): detachable SEPARATE_INSTRUCTION_AS
			-- <Precursor>
		do
		end

	new_static_access_as (c: detachable TYPE_AS; f: detachable ID_AS; p: detachable PARAMETER_LIST_AS; f_as: detachable KEYWORD_AS; d_as: detachable SYMBOL_AS): detachable STATIC_ACCESS_AS
			-- New STATIC_ACCESS AST node
		do
		end

	new_string_as (s: detachable STRING; l, c, p, n, cc, cp, cn: INTEGER; buf: STRING): detachable STRING_AS
			-- New STRING AST node
		do
		end

	new_tagged_as (t: detachable ID_AS; e: detachable EXPR_AS; c: detachable KEYWORD_AS; s_as: detachable SYMBOL_AS): detachable TAGGED_AS
			-- New TAGGED AST node
		do
		end

	new_tuple_as (exp: detachable EIFFEL_LIST [EXPR_AS]; l_as: detachable SYMBOL_AS; r_as: detachable SYMBOL_AS): detachable TUPLE_AS
			-- New Manifest TUPLE AST node
		do
		end

	new_list_dec_as (i: detachable IDENTIFIER_LIST): detachable LIST_DEC_AS
			-- New LIST_DEC AST node
		do
		end

	new_type_dec_as (i: detachable IDENTIFIER_LIST; t: detachable TYPE_AS; c_as: detachable SYMBOL_AS): detachable TYPE_DEC_AS
			-- New TYPE_DEC AST node
		do
		end

	new_type_expr_as (t: detachable TYPE_AS): detachable TYPE_EXPR_AS
			-- New TYPE_EXPR AST node
		do
		end

	new_un_free_as (op: detachable ID_AS; e: detachable EXPR_AS): detachable UN_FREE_AS
			-- New UN_FREE AST node
		do
		end

	new_un_minus_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_MINUS_AS
			-- New unary - AST node
		do
		end

	new_un_not_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_NOT_AS
			-- New unary not AST node
		do
		end

	new_un_old_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_OLD_AS
			-- New unary old AST node
		do
		end

	new_un_plus_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_PLUS_AS
			-- New unary + AST node
		do
		end

	new_un_strip_as (i: detachable IDENTIFIER_LIST; o: detachable KEYWORD_AS; lp_as, rp_as: detachable SYMBOL_AS): detachable UN_STRIP_AS
			-- New UN_STRIP AST node
		do
		end

	new_unique_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable UNIQUE_AS
			-- New UNIQUE AST node
		do
		end

	new_variant_as (t: detachable ID_AS; e: detachable EXPR_AS; k_as: detachable KEYWORD_AS; s_as: detachable SYMBOL_AS): detachable VARIANT_AS
			-- New VARIANT AST node
		do
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n, cc, cp, cn, common_columns: INTEGER; buf: STRING): detachable VERBATIM_STRING_AS
			-- New VERBATIM_STRING AST node
		do
		end

	new_void_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable VOID_AS
			-- New VOID AST node
		do
		end

	new_class_list_as (a: ID_AS; n: INTEGER): detachable CLASS_LIST_AS
			-- <Precursor>
		do
		end

	new_local_dec_list_as (l: detachable EIFFEL_LIST [LIST_DEC_AS]; k_as: detachable KEYWORD_AS): detachable LOCAL_DEC_LIST_AS
			-- New LOCAL_DEC_LIST AST node
		do
		end

	new_formal_argu_dec_list_as (l: detachable EIFFEL_LIST [TYPE_DEC_AS]; l_as, r_as: detachable SYMBOL_AS): detachable FORMAL_ARGU_DEC_LIST_AS
			-- New FORMAL_ARGU_DEC_LIST AST node
		do
		end

	new_key_list_as (l: detachable EIFFEL_LIST [STRING_AS]; l_as, r_as: detachable SYMBOL_AS): detachable KEY_LIST_AS
			-- New KEY_LIST AST node
		do
		end

	new_delayed_actual_list_as (l: detachable EIFFEL_LIST [OPERAND_AS]; l_as, r_as: detachable SYMBOL_AS): detachable DELAYED_ACTUAL_LIST_AS
			-- New DELAYED_ACTUAL_LIST AST node
		do
		end

	new_rename_clause_as (l: detachable EIFFEL_LIST [RENAME_AS]; k_as: detachable KEYWORD_AS): detachable RENAME_CLAUSE_AS
			-- New RENAME_CLAUSE AST node
		do
		end

	new_export_clause_as (l: detachable EIFFEL_LIST [EXPORT_ITEM_AS]; k_as: detachable KEYWORD_AS): detachable EXPORT_CLAUSE_AS
			-- New EXPORT_CLAUSE AST node
		do
		end

	new_undefine_clause_as (l: detachable EIFFEL_LIST [FEATURE_NAME]; k_as: detachable KEYWORD_AS): detachable UNDEFINE_CLAUSE_AS
			-- New UNDEFINE_CLAUSE AST node
		do
		end

	new_redefine_clause_as (l: detachable EIFFEL_LIST [FEATURE_NAME]; k_as: detachable KEYWORD_AS): detachable REDEFINE_CLAUSE_AS
			-- New REDEFINE_CLAUSE AST node
		do
		end

	new_select_clause_as (l: detachable EIFFEL_LIST [FEATURE_NAME]; k_as: detachable KEYWORD_AS): detachable SELECT_CLAUSE_AS
			-- New SELECT_CLAUSE AST node
		do
		end

	new_creation_constrain_triple (fl: detachable EIFFEL_LIST [FEATURE_NAME]; c_as, e_as: detachable KEYWORD_AS): detachable CREATION_CONSTRAIN_TRIPLE
			-- New CREATION_CONSTRAIN_TRIPLE object
		do
		end

note
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: very long class"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
