indexing
	description: "AST node factories which does not generate any node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			new_bin_not_tilde_as, new_bin_or_as, new_bin_or_else_as, new_bin_plus_as,
			new_bin_power_as, new_bin_slash_as, new_bin_star_as, new_bin_tilde_as,
			new_bin_xor_as, new_bit_const_as, new_bits_as, new_bits_symbol_as, new_built_in_as,
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
			new_nested_expr_as, new_none_type_as, new_object_test_as, new_once_as, new_operand_as, new_paran_as, new_parent_as,
			new_precursor_as, new_prefix_as, new_real_as, new_rename_as, new_require_as, new_require_else_as,
			new_result_as, new_retry_as, new_reverse_as, new_routine_as, new_routine_creation_as,
			new_old_routine_creation_as, new_static_access_as, new_string_as, new_tagged_as,
			new_tuple_as, new_type_dec_as, new_type_expr_as, new_un_free_as, new_un_minus_as,
			new_un_not_as, new_un_old_as, new_un_plus_as, new_un_strip_as, new_unique_as,
			new_variant_as, new_verbatim_string_as, new_void_as, new_filled_none_id_as,
			new_assigner_call_as,
			new_create_creation_as, new_bang_creation_as,
			new_create_creation_expr_as,new_bang_creation_expr_as,
			new_bracket_as,
			new_assigner_mark_as, new_typed_char_as,
			new_character_value, new_integer_value, new_real_value,
			set_buffer, append_text_to_buffer, append_string_to_buffer,
			create_match_list,
			reverse_extend_separator, reverse_extend_identifier, reverse_extend_identifier_separator,
			new_agent_routine_creation_as,
			new_constraint_triple, new_alias_triple, new_agent_target_triple,
			new_keyword_instruction_list_pair, new_keyword_string_pair, new_invariant_pair,
			new_keyword_as, new_creation_keyword_as, new_end_keyword_as, new_frozen_keyword_as,
			new_infix_keyword_as, new_precursor_keyword_as, new_prefix_keyword_as, new_once_string_keyword_as,
			new_symbol_as, new_square_symbol_as,
			create_break_as, create_break_as_with_data,
			new_filled_id_as_with_existing_stub,
			new_feature_keyword_as,
			new_class_list_as, new_local_dec_list_as, new_formal_argu_dec_list_as, new_debug_key_list_as,
			new_delayed_actual_list_as, new_parameter_list_as,
			new_rename_clause_as, new_export_clause_as, new_undefine_clause_as, new_redefine_clause_as, new_select_clause_as,
			new_creation_constrain_triple, new_named_tuple_type_as, new_line_pragma
		end

feature -- Buffer operation

	set_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON) is
			-- Clear `a_buf' and then set it with `a_scn'.text.
		do
		end

	append_text_to_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON) is
			-- Append `a_scn'.text to end of buffer `a_buf'.
		do
		end

	append_string_to_buffer (a_buf: STRING; a_str: STRING) is
			-- Append `a_str' to end of buffer `a_buf'.
		do
		end

feature -- Roundtrip: Match list maintaining

	create_match_list (l_size: INTEGER) is
			-- New match list
		do
		end

feature -- Roundtrip

	reverse_extend_separator (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: LEAF_AS) is
			-- Add `l_as' into `a_list'.separator_list in reverse order.
		do
		end

	reverse_extend_identifier (a_list: IDENTIFIER_LIST; l_as: ID_AS) is
			-- Add `l_as' into `a_list'.
		do
		end

	reverse_extend_identifier_separator (a_list: IDENTIFIER_LIST; l_as: LEAF_AS) is
			-- Add `l_as' into `a_list.separator_list'.
		do
		end

feature -- Roundtrip: New AST node

	new_agent_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: KEYWORD_AS; d_as: SYMBOL_AS): AGENT_ROUTINE_CREATION_AS is
			-- New AGENT_ROUTINE_CREATION AST node.
		do
		end

	new_create_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; k_as: KEYWORD_AS): CREATE_CREATION_AS is
			-- New CREATE_CREATION AST node.
		do
		end

	new_bang_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_AS is
			-- New CREATE_CREATION AST node.
		do
		end

	new_create_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; k_as: KEYWORD_AS): CREATE_CREATION_EXPR_AS is
			-- New creation expression AST node
		do
		end

	new_bang_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_EXPR_AS is
			-- New creation expression AST node
		do
		end

	new_assigner_mark_as (k_as: KEYWORD_AS; i_as: ID_AS): PAIR [KEYWORD_AS, ID_AS] is
			-- New pair of assigner_mark structure.
		do
		end

	new_filled_none_id_as (l, c, p, s: INTEGER): NONE_ID_AS is
			-- New empty ID AST node.
		do
		end

	new_constraint_triple (k_as: SYMBOL_AS; t_as: CONSTRAINT_LIST_AS; l_as: CREATION_CONSTRAIN_TRIPLE): CONSTRAINT_TRIPLE is
			-- New constraint triple structure.
		do
		end

	new_alias_triple (k_as: KEYWORD_AS; n_as: STRING_AS; c_as: KEYWORD_AS): ALIAS_TRIPLE is
			-- New ALIST_TRIPLE.
		do
		end

	new_agent_target_triple (l_as, r_as: SYMBOL_AS; o_as: OPERAND_AS): AGENT_TARGET_TRIPLE is
			-- New ALIST_TRIPLE.
		do
		end

	new_keyword_instruction_list_pair (k_as: KEYWORD_AS; i_as: EIFFEL_LIST [INSTRUCTION_AS]):PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]] is
			-- New ALIST_TRIPLE.
		do
		end

	new_keyword_string_pair (k_as: KEYWORD_AS; s_as: STRING_AS):PAIR [KEYWORD_AS, STRING_AS] is
			-- New ALIST_TRIPLE.
		do
		end

	new_invariant_pair (k_as: KEYWORD_AS; i_as: EIFFEL_LIST [TAGGED_AS]): PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]] is
			-- New PAIR for a keyword and a tagged_as list.
		do
		end

feature -- Roundtrip

	new_character_value (a_psr: EIFFEL_PARSER_SKELETON; a_type: TYPE_AS; buffer, a_text: STRING): CHAR_AS is
		do
		end

	new_integer_value (a_psr: EIFFEL_PARSER_SKELETON; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): INTEGER_AS is
		do
		end

	new_real_value (a_psr: EIFFEL_PARSER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): REAL_AS is
		do
		end

feature -- Roundtrip: New node

	new_typed_char_as (t_as: TYPE_AS; c: CHARACTER_32; l, co, p, n: INTEGER; a_text: STRING): TYPED_CHAR_AS is
			-- New TYPED_CHAR AST node.
		do
		end

	new_bracket_as (t: EXPR_AS; o: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): BRACKET_AS is
			-- New BRACKET AST node
		do
		end

feature -- Roundtrip: leaf_as

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
		end

	new_semicolon_symbol_as (a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New symbol AST node for ";"
		do
		end

	new_feature_keyword_as (l, c, p, s:INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "feature".
		do
		end

	new_keyword_as_without_extending_list (a_code:INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node, but don't extend `internal_match_list'.
		do
		end

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "creation'
		do
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "end'
		do
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "frozen'
		do
		end

	new_infix_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "infix'
		do
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "precursor'
		do
		end

	new_prefix_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "prefix'
		do
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node	all Eiffel symbols except "[" and "]"
		do
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node	only for symbol "[" and "]"
		do
		end

	new_separator_as (a_scn: EIFFEL_SCANNER) is
			-- New KEYWORD AST node		
		do
		end

	new_separator_as_with_data (a_text: STRING; l, c, p, s: INTEGER) is
			-- New  KEYWORD AST node
		do
		end

	new_new_line_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New KEYWORD AST node		
		do
		end

	new_new_line_as (a_scn: EIFFEL_SCANNER) is
			-- New KEYWORD AST node		
		do
		end

	new_comment_as (a_scn: EIFFEL_SCANNER) is
			-- New COMMENT_AS node
		do
		end

	new_comment_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New COMMENT_AS node
		do
		end

	create_break_as (a_scn: EIFFEL_SCANNER) is
			-- NEw BREAK_AS node
		do
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New COMMENT_AS node
		do
		end

feature -- Access

	new_assigner_call_as (t: EXPR_AS; s: EXPR_AS; a_as: SYMBOL_AS): ASSIGNER_CALL_AS is
			-- New ASSIGNER CALL AST node
		do
		end

	new_access_assert_as (f: ID_AS; p: PARAMETER_LIST_AS): ACCESS_ASSERT_AS is
			-- New ACCESS_ASSERT AST node
		do
		end

	new_access_feat_as (f: ID_AS; p: PARAMETER_LIST_AS): ACCESS_FEAT_AS is
			-- New ACCESS_FEAT AST node
		do
		end

	new_access_id_as (f: ID_AS; p: PARAMETER_LIST_AS): ACCESS_ID_AS is
			-- New ACCESS_ID AST node
		do
		end

	new_access_inv_as (f: ID_AS; p: PARAMETER_LIST_AS; k_as: SYMBOL_AS): ACCESS_INV_AS is
			-- New ACCESS_INV AST node
		do
		end

	new_address_as (f: FEATURE_NAME; a_as: SYMBOL_AS): ADDRESS_AS is
			-- New ADDRESS AST node
		do
		end

	new_address_current_as (other: CURRENT_AS; a_as: SYMBOL_AS): ADDRESS_CURRENT_AS is
			-- New ADDRESS_CURRENT AST node
		do
		end

	new_address_result_as (other: RESULT_AS; a_as: SYMBOL_AS): ADDRESS_RESULT_AS is
			-- New ADDRESS_RESULT AST node
		do
		end

	new_all_as (a_as: KEYWORD_AS): ALL_AS is
			-- New ALL AST node
		do
		end

	new_array_as (exp: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): ARRAY_AS is
			-- New Manifest ARRAY AST node
		do
		end

	new_assign_as (t: ACCESS_AS; s: EXPR_AS; a_as: SYMBOL_AS): ASSIGN_AS is
			-- New ASSIGN AST node
		do
		end

	new_bin_and_as (l, r: EXPR_AS; o: LEAF_AS): BIN_AND_AS is
			-- New binary and AST node
		do
		end

	new_bin_and_then_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_AND_THEN_AS is
			-- New binary and then AST node
		do
		end

	new_bin_div_as (l, r: EXPR_AS; o: LEAF_AS): BIN_DIV_AS is
			-- New binary // AST node
		do
		end

	new_bin_eq_as (l, r: EXPR_AS; o: LEAF_AS): BIN_EQ_AS is
			-- New binary = AST node
		do
		end

	new_bin_free_as (l: EXPR_AS; op: ID_AS; r: EXPR_AS): BIN_FREE_AS is
			-- New BIN_FREE AST node
		do
		end

	new_bin_ge_as (l, r: EXPR_AS; o: LEAF_AS): BIN_GE_AS is
			-- New binary >= AST node
		do
		end

	new_bin_gt_as (l, r: EXPR_AS; o: LEAF_AS): BIN_GT_AS is
			-- New binary > AST node
		do
		end

	new_bin_implies_as (l, r: EXPR_AS; o: LEAF_AS): BIN_IMPLIES_AS is
			-- New binary implies AST node
		do
		end

	new_bin_le_as (l, r: EXPR_AS; o: LEAF_AS): BIN_LE_AS is
			-- New binary <= AST node
		do
		end

	new_bin_lt_as (l, r: EXPR_AS; o: LEAF_AS): BIN_LT_AS is
			-- New binary < AST node
		do
		end

	new_bin_minus_as (l, r: EXPR_AS; o: LEAF_AS): BIN_MINUS_AS is
			-- New binary - AST node
		do
		end

	new_bin_mod_as (l, r: EXPR_AS; o: LEAF_AS): BIN_MOD_AS is
			-- New binary \\ AST node
		do
		end

	new_bin_ne_as (l, r: EXPR_AS; o: LEAF_AS): BIN_NE_AS is
			-- New binary /= AST node
		do
		end

	new_bin_not_tilde_as (l, r: EXPR_AS; o: LEAF_AS): BIN_NOT_TILDE_AS is
			-- New binary /~ AST node
		do
		end

	new_bin_or_as (l, r: EXPR_AS; o: LEAF_AS): BIN_OR_AS is
			-- New binary or AST node
		do
		end

	new_bin_or_else_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_OR_ELSE_AS is
			-- New binary or else AST node
		do
		end

	new_bin_plus_as (l, r: EXPR_AS; o: LEAF_AS): BIN_PLUS_AS is
			-- New binary + AST node
		do
		end

	new_bin_power_as (l, r: EXPR_AS; o: LEAF_AS): BIN_POWER_AS is
			-- New binary ^ AST node
		do
		end

	new_bin_slash_as (l, r: EXPR_AS; o: LEAF_AS): BIN_SLASH_AS is
			-- New binary / AST node
		do
		end

	new_bin_star_as (l, r: EXPR_AS; o: LEAF_AS): BIN_STAR_AS is
			-- New binary * AST node
		do
		end

	new_bin_tilde_as (l, r: EXPR_AS; o: LEAF_AS): BIN_TILDE_AS is
			-- New binary ~ AST node
		do
		end

	new_bin_xor_as (l, r: EXPR_AS; o: LEAF_AS): BIN_XOR_AS is
			-- New binary xor AST node
		do
		end

	new_bit_const_as (b: ID_AS): BIT_CONST_AS is
			-- New BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'
		do
		end

	new_bits_as (v: INTEGER_AS; b_as: KEYWORD_AS): BITS_AS is
			-- New BITS AST node
		do
		end

	new_bits_symbol_as (s: ID_AS; b_as: KEYWORD_AS): BITS_SYMBOL_AS is
			-- New BITS_SYMBOL AST node
		do
		end

	new_body_as (a: FORMAL_ARGU_DEC_LIST_AS; t: TYPE_AS; r: ID_AS; c: CONTENT_AS; c_as: SYMBOL_AS; k_as: LEAF_AS; a_as: KEYWORD_AS; i_as: INDEXING_CLAUSE_AS): BODY_AS is
			-- New BODY AST node
		do
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER): BOOL_AS is
			-- New BOOLEAN AST node
		do
		end

	new_built_in_as (l: EXTERNAL_LANG_AS; a: STRING_AS; e_as, a_as: KEYWORD_AS): BUILT_IN_AS is
			-- New BUILT_IN AST node
		do
		end

	new_case_as (i: EIFFEL_LIST [INTERVAL_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; w_as, t_as: KEYWORD_AS): CASE_AS is
			-- New WHEN AST node
		do
		end

	new_character_as (c: CHARACTER_32; l, co, p, n: INTEGER; a_text: STRING): CHAR_AS is
			-- New CHARACTER AST node
		do
		end

	new_check_as (c: EIFFEL_LIST [TAGGED_AS]; c_as, e: KEYWORD_AS): CHECK_AS is
			-- New CHECK AST node
		do
		end

	new_class_as (n: ID_AS; ext_name: STRING_AS;
			is_d, is_e, is_s, is_fc, is_ex, is_par: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			cp: PARENT_LIST_AS;
			ncp: PARENT_LIST_AS;
			c: EIFFEL_LIST [CREATE_AS];
			co: CONVERT_FEAT_LIST_AS;
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			ed: KEYWORD_AS): CLASS_AS
		is
			-- New CLASS AST node
		do
		end

	new_class_type_as (n: ID_AS; g: TYPE_LIST_AS): CLASS_TYPE_AS is
			-- New CLASS_TYPE AST node
		do
		end

	new_named_tuple_type_as (n: ID_AS; g: FORMAL_ARGU_DEC_LIST_AS): NAMED_TUPLE_TYPE_AS is
			-- New TUPLE_TYPE AST node
		do
		end

	new_client_as (c: CLASS_LIST_AS): CLIENT_AS is
			-- New CLIENT AST node
		do
		end

	new_constant_as (a: ATOMIC_AS): CONSTANT_AS is
			-- New CONSTANT_AS node
		do
		end

	new_convert_feat_as (cr: BOOLEAN; fn: FEATURE_NAME; t: TYPE_LIST_AS ; l_as, r_as, c_as, lc_as, rc_as: SYMBOL_AS): CONVERT_FEAT_AS is
			-- New convert feature entry AST node.
		do
		end

	new_create_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_NAME]; c_as: KEYWORD_AS): CREATE_AS is
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

	new_current_as (a_scn: EIFFEL_SCANNER): CURRENT_AS is
			-- New CURRENT AST node
		do
		end

	new_custom_attribute_as (c: CREATION_EXPR_AS; t: TUPLE_AS; k_as: KEYWORD_AS): CUSTOM_ATTRIBUTE_AS is
			-- Create a new UNIQUE AST node.
		do
		end

	new_debug_as (k: DEBUG_KEY_LIST_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: KEYWORD_AS): DEBUG_AS is
			-- New DEBUG AST node
		do
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER): DEFERRED_AS is
			-- New DEFERRED AST node
		do
		end

	new_do_as (c: EIFFEL_LIST [INSTRUCTION_AS]; k_as: KEYWORD_AS): DO_AS is
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

	new_eiffel_list_convert (n: INTEGER): CONVERT_FEAT_LIST_AS is
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

	new_parameter_list_as (l: EIFFEL_LIST [EXPR_AS]; lp_as, rp_as: SYMBOL_AS): PARAMETER_LIST_AS is
			-- New empty list of PARAMETER_LIST_AS
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

	new_eiffel_list_formal_dec_as (n: INTEGER): FORMAL_GENERIC_LIST_AS is
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

	new_eiffel_list_parent_as (n: INTEGER): PARENT_LIST_AS is
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

	new_eiffel_list_type_dec_as (n: INTEGER): TYPE_DEC_LIST_AS is
			-- New empty list of TYPE_DEC_AS
		do
		end

	new_elseif_as (e: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; l_as, t_as: KEYWORD_AS): ELSIF_AS is
			-- New ELSIF AST node
		do
		end

	new_ensure_as (a: EIFFEL_LIST [TAGGED_AS]; k_as: KEYWORD_AS): ENSURE_AS is
			-- New ENSURE AST node
		do
		end

	new_ensure_then_as (a: EIFFEL_LIST [TAGGED_AS]; k_as, l_as: KEYWORD_AS): ENSURE_THEN_AS is
			-- New ENSURE THEN AST node
		do
		end

	new_export_item_as (c: CLIENT_AS; f: FEATURE_SET_AS): EXPORT_ITEM_AS is
			-- New EXPORT_ITEM AST node
		do
		end

	new_expr_address_as (e: EXPR_AS; a_as, l_as, r_as: SYMBOL_AS): EXPR_ADDRESS_AS is
			-- New EXPR_ADDRESS AST node
		do
		end

	new_expr_call_as (c: CALL_AS): EXPR_CALL_AS is
			-- New EXPR_CALL AST node
		do
		end

	new_external_as (l: EXTERNAL_LANG_AS; a: STRING_AS; e_as, a_as: KEYWORD_AS): EXTERNAL_AS is
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

	new_feature_clause_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_AS]; l: KEYWORD_AS; ep: INTEGER): FEATURE_CLAUSE_AS is
			-- New FEATURE_CLAUSE AST node
		do
		end

	new_feature_list_as (f: EIFFEL_LIST [FEATURE_NAME]): FEATURE_LIST_AS is
			-- New FEATURE_LIST AST node
		do
		end

	new_feature_name_alias_as (feature_name: ID_AS; alias_name: STRING_AS; has_convert_mark: BOOLEAN; a_as, c_as: KEYWORD_AS): FEATURE_NAME_ALIAS_AS is
			-- New FEATURE_NAME_ALIAS AST node
		do
		end

	new_feature_name_id_as (f: ID_AS): FEAT_NAME_ID_AS is
			-- New FEAT_NAME_ID AST node
		do
		end

	new_formal_as (n: ID_AS; is_ref, is_exp: BOOLEAN; r_as: KEYWORD_AS): FORMAL_AS is
			-- New FORMAL AST node
		do
		end

	new_formal_dec_as (f: FORMAL_AS; c: CONSTRAINT_LIST_AS; cf: EIFFEL_LIST [FEATURE_NAME]; c_as: SYMBOL_AS; ck_as, ek_as: KEYWORD_AS): FORMAL_DEC_AS is
			-- New FORMAL_DECLARATION AST node
		do
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS is
			-- New empty ID AST node.
		do
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): ID_AS is
			-- New empty ID AST node.
		do
		end

	new_identifier_list (c: INTEGER): IDENTIFIER_LIST is
			-- New ARRAYED_LIST [INTEGER]
		do
		end

	new_if_as (cnd: EXPR_AS; cmp: EIFFEL_LIST [INSTRUCTION_AS];
			ei: EIFFEL_LIST [ELSIF_AS]; e: EIFFEL_LIST [INSTRUCTION_AS];
			end_location, i_as, t_as, e_as: KEYWORD_AS): IF_AS
		is
			-- New IF AST node
		do
		end

	new_index_as (t: ID_AS; i: EIFFEL_LIST [ATOMIC_AS]; c_as: SYMBOL_AS): INDEX_AS is
			-- Create a new INDEX AST node.
		do
		end

	new_infix_as (op: STRING_AS; l: KEYWORD_AS): INFIX_PREFIX_AS is
			-- New INFIX AST node
		do
		end

	new_inspect_as (s: EXPR_AS; c: EIFFEL_LIST [CASE_AS];
			e: EIFFEL_LIST [INSTRUCTION_AS]; end_location, i_as, e_as: KEYWORD_AS): INSPECT_AS
		is
			-- New INSPECT AST node
		do
		end

	new_instr_call_as (c: CALL_AS): INSTR_CALL_AS is
			-- New INSTR_CALL AST node
		do
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
		end

	new_interval_as (l, u: ATOMIC_AS; d_as: SYMBOL_AS): INTERVAL_AS is
			-- New INTERVAL AST node
		do
		end

	new_invariant_as (a: EIFFEL_LIST [TAGGED_AS]; once_manifest_string_count: INTEGER; i_as: KEYWORD_AS; object_test_locals: ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]): INVARIANT_AS is
			-- New INVARIANT AST node
		do
		end

	new_like_id_as (a: ID_AS; l_as: KEYWORD_AS): LIKE_ID_AS is
			-- New LIKE_ID AST node
		do
		end

	new_like_current_as (other: CURRENT_AS; l_as: KEYWORD_AS): LIKE_CUR_AS is
			-- New LIKE_CURRENT AST node
		do
		end

	new_location_as (l, c, p, s: INTEGER): LOCATION_AS is
			-- New LOCATION_AS
		do
		end

	new_loop_as (f: EIFFEL_LIST [INSTRUCTION_AS]; i: EIFFEL_LIST [TAGGED_AS];
			v: VARIANT_AS; s: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS];
			e, f_as, i_as, u_as, l_as: KEYWORD_AS): LOOP_AS
		is
			-- New LOOP AST node
		do
		end

	new_nested_as (t: ACCESS_AS; m: CALL_AS; d_as: SYMBOL_AS): NESTED_AS is
			-- New NESTED CALL AST node
		do
		end

	new_nested_expr_as (t: EXPR_AS; m: CALL_AS; d_as, l_as, r_as: SYMBOL_AS): NESTED_EXPR_AS is
			-- New NESTED_EXPR CALL AST node
		do
		end

	new_none_type_as (c: ID_AS): NONE_TYPE_AS is
			-- New type AST node for "NONE"
		do
		end

	new_object_test_as (start: SYMBOL_AS; name: ID_AS; type: TYPE_AS; expression: EXPR_AS): OBJECT_TEST_AS is
			-- New OBJECT_TEST_AS node
		do
		end

	new_once_as (c: EIFFEL_LIST [INSTRUCTION_AS]; k_as: KEYWORD_AS): ONCE_AS is
			-- New ONCE AST node
		do
		end

	new_operand_as (c: TYPE_AS; t: ACCESS_AS; e: EXPR_AS): OPERAND_AS is
			-- New OPERAND AST node
		do
		end

	new_paran_as (e: EXPR_AS; l_as, r_as: SYMBOL_AS): PARAN_AS is
			-- New PARAN AST node
		do
		end

	new_parent_as (t: CLASS_TYPE_AS; rn: RENAME_CLAUSE_AS;
			e: EXPORT_CLAUSE_AS; u: UNDEFINE_CLAUSE_AS;
			rd: REDEFINE_CLAUSE_AS; s: SELECT_CLAUSE_AS; ed: KEYWORD_AS): PARENT_AS
		is
			-- New PARENT AST node
		do
		end

	new_precursor_as (pk: KEYWORD_AS; n: CLASS_TYPE_AS; p: PARAMETER_LIST_AS): PRECURSOR_AS is
			-- New PRECURSOR AST node
		do
		end

	new_prefix_as (op: STRING_AS; l: KEYWORD_AS): INFIX_PREFIX_AS is
			-- New PREFIX AST node
		do
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): REAL_AS is
			-- New REAL AST node
		do
		end

	new_rename_as (o, n: FEATURE_NAME; k_as: KEYWORD_AS): RENAME_AS is
			-- New RENAME_PAIR AST node
		do
		end

	new_require_as (a: EIFFEL_LIST [TAGGED_AS]; k_as: KEYWORD_AS): REQUIRE_AS is
			-- New REQUIRE AST node
		do
		end

	new_require_else_as (a: EIFFEL_LIST [TAGGED_AS]; k_as, l_as: KEYWORD_AS): REQUIRE_ELSE_AS is
			-- New REQUIRE ELSE AST node
		do
		end

	new_result_as (a_scn: EIFFEL_SCANNER): RESULT_AS is
			-- New RESULT AST node
		do
		end

	new_retry_as (a_scn: EIFFEL_SCANNER): RETRY_AS is
			-- New RETRY AST node
		do
		end

	new_reverse_as (t: ACCESS_AS; s: EXPR_AS; a_as: SYMBOL_AS): REVERSE_AS is
			-- New assignment attempt AST node
		do
		end

	new_routine_as (o: STRING_AS; pr: REQUIRE_AS;
			l: LOCAL_DEC_LIST_AS; b: ROUT_BODY_AS; po: ENSURE_AS;
			r: EIFFEL_LIST [INSTRUCTION_AS]; end_loc: KEYWORD_AS;
			oms_count, a_pos: INTEGER; k_as, r_as: KEYWORD_AS;
			object_test_locals: ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]): ROUTINE_AS
		is
			-- New ROUTINE AST node
		do
		end

	new_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN): ROUTINE_CREATION_AS is
			-- New ROUTINE_CREATION AST node
		do
		end

	new_old_routine_creation_as (
			l: AST_EIFFEL; t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS;
			is_qualified: BOOLEAN; a_as: SYMBOL_AS): PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		is
			-- New ROUTINE_CREATION AST node for obsolete use of `~'.
		do
		end

	new_static_access_as (c: TYPE_AS; f: ID_AS; p: PARAMETER_LIST_AS; f_as: KEYWORD_AS; d_as: SYMBOL_AS): STATIC_ACCESS_AS is
			-- New STATIC_ACCESS AST node
		do
		end

	new_string_as (s: STRING; l, c, p, n: INTEGER; buf: STRING): STRING_AS is
			-- New STRING AST node
		do
		end

	new_tagged_as (t: ID_AS; e: EXPR_AS; s_as: SYMBOL_AS): TAGGED_AS is
			-- New TAGGED AST node
		do
		end

	new_tuple_as (exp: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): TUPLE_AS is
			-- New Manifest TUPLE AST node
		do
		end

	new_type_dec_as (i: IDENTIFIER_LIST; t: TYPE_AS; c_as: SYMBOL_AS): TYPE_DEC_AS is
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

	new_un_minus_as (e: EXPR_AS; o: LEAF_AS): UN_MINUS_AS is
			-- New unary - AST node
		do
		end

	new_un_not_as (e: EXPR_AS; o: LEAF_AS): UN_NOT_AS is
			-- New unary not AST node
		do
		end

	new_un_old_as (e: EXPR_AS; o: LEAF_AS): UN_OLD_AS is
			-- New unary old AST node
		do
		end

	new_un_plus_as (e: EXPR_AS; o: LEAF_AS): UN_PLUS_AS is
			-- New unary + AST node
		do
		end

	new_un_strip_as (i: IDENTIFIER_LIST; o: KEYWORD_AS; lp_as, rp_as: SYMBOL_AS): UN_STRIP_AS is
			-- New UN_STRIP AST node
		do
		end

	new_unique_as (a_scn: EIFFEL_SCANNER): UNIQUE_AS is
			-- New UNIQUE AST node
		do
		end

	new_variant_as (t: ID_AS; e: EXPR_AS; k_as: KEYWORD_AS; s_as: SYMBOL_AS): VARIANT_AS is
			-- New VARIANT AST node
		do
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n: INTEGER; buf: STRING): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		do
		end

	new_void_as (a_scn: EIFFEL_SCANNER): VOID_AS is
			-- New VOID AST node
		do
		end

	new_class_list_as (n: INTEGER): CLASS_LIST_AS is
			-- New empty list of CLASS_LIST AST node
		do
		end

	new_local_dec_list_as (l: EIFFEL_LIST [TYPE_DEC_AS]; k_as: KEYWORD_AS): LOCAL_DEC_LIST_AS is
			-- New LOCAL_DEC_LIST AST node
		do
		end

	new_formal_argu_dec_list_as (l: EIFFEL_LIST [TYPE_DEC_AS]; l_as, r_as: SYMBOL_AS): FORMAL_ARGU_DEC_LIST_AS is
			-- New FORMAL_ARGU_DEC_LIST AST node
		do
		end

	new_debug_key_list_as (l: EIFFEL_LIST [STRING_AS]; l_as, r_as: SYMBOL_AS): DEBUG_KEY_LIST_AS is
			-- New DEBUG_KEY_LIST AST node
		do
		end

	new_delayed_actual_list_as (l: EIFFEL_LIST [OPERAND_AS]; l_as, r_as: SYMBOL_AS): DELAYED_ACTUAL_LIST_AS is
			-- New DELAYED_ACTUAL_LIST AST node
		do
		end

	new_rename_clause_as (l: EIFFEL_LIST [RENAME_AS]; k_as: KEYWORD_AS): RENAME_CLAUSE_AS is
			-- New RENAME_CLAUSE AST node
		do
		end

	new_export_clause_as (l: EIFFEL_LIST [EXPORT_ITEM_AS]; k_as: KEYWORD_AS): EXPORT_CLAUSE_AS is
			-- New EXPORT_CLAUSE AST node
		do
		end

	new_undefine_clause_as (l: EIFFEL_LIST [FEATURE_NAME]; k_as: KEYWORD_AS): UNDEFINE_CLAUSE_AS is
			-- New UNDEFINE_CLAUSE AST node
		do
		end

	new_redefine_clause_as (l: EIFFEL_LIST [FEATURE_NAME]; k_as: KEYWORD_AS): REDEFINE_CLAUSE_AS is
			-- New REDEFINE_CLAUSE AST node
		do
		end

	new_select_clause_as (l: EIFFEL_LIST [FEATURE_NAME]; k_as: KEYWORD_AS): SELECT_CLAUSE_AS is
			-- New SELECT_CLAUSE AST node
		do
		end

	new_creation_constrain_triple (fl: EIFFEL_LIST [FEATURE_NAME]; c_as, e_as: KEYWORD_AS): CREATION_CONSTRAIN_TRIPLE is
			-- New CREATION_CONSTRAIN_TRIPLE object
		do
		end

	new_line_pragma (a_scn: EIFFEL_SCANNER): BREAK_AS is
			-- New line pragma
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

end -- class AST_FACTORY

