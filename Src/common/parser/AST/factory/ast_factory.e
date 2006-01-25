indexing

	description: "AST node factories"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_FACTORY

feature -- Buffer operation

	set_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON) is
			-- Clear `a_buf' and then set it with `a_scn'.text.
		require
			a_scn_not_void: a_scn /= Void
		do
		end

	append_text_to_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON) is
			-- Append `a_scn'.text to end of buffer `a_buf'.
		require
			a_scn_not_void: a_scn /= Void
		do
		end

	append_string_to_buffer (a_buf: STRING; a_str: STRING) is
			-- Append `a_str' to end of buffer `a_buf'.
		require
			a_str_not_void: a_str /= Void
		do
		end

feature -- Roundtrip: Match list maintaining

	match_list: LEAF_AS_LIST
			-- List of LEAF_AS nodes.

	match_list_count: INTEGER
			-- Number of elements in `internal_match_list'

	create_match_list (l_size: INTEGER) is
			-- Create a new `match_list' with initial `l_size'.
		require
			l_size_positive: l_size > 0
		do
		end

	extend_match_list (a_match: LEAF_AS) is
			-- Extend `internal_match_list' with `a_match'.
		do
		end

	extend_match_list_with_stub (a_stub: LEAF_STUB_AS) is
			-- Extend `match_list' with stub `a_stub',
			-- and set index in `a_match'.
		do
		end

feature -- Roundtrip

	reverse_extend_separator (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: AST_EIFFEL) is
			-- Add `l_as' into `a_list'.separator_list in reverse order.
		do
		end

	reverse_extend_identifier (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: ID_AS) is
			-- Add `l_as' into `a_list'.
		do
		end

	extend_pre_as (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: AST_EIFFEL) is
			-- Extend `l_as' into `a_list'.pre_as_list.
		do
		end

	extend_post_as (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: AST_EIFFEL) is
			-- Extend `l_as' into `a_list'.post_as_list.
		do
		end

feature -- Access

	new_agent_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS]; is_qualified: BOOLEAN; a_as: KEYWORD_AS; d_as: SYMBOL_AS): AGENT_ROUTINE_CREATION_AS is
			-- New AGENT_ROUTINE_CREATION AST node.
		do
			create Result.make (t, f, o, is_qualified, a_as, d_as)
		end

	new_tilda_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS]; is_qualified: BOOLEAN; a_as: SYMBOL_AS): TILDA_ROUTINE_CREATION_AS is
			-- New AGENT_ROUTINE_CREATION AST node.
		do
			create Result.make (t, f, o, is_qualified, a_as)
		end

	new_create_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; k_as: KEYWORD_AS): CREATE_CREATION_AS is
			-- New CREATE_CREATION AST node.
		do
			create Result.make (tp, tg, c, k_as)
		end

	new_bang_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_AS is
			-- New CREATE_CREATION AST node.
		do
			create Result.make (tp, tg, c, l_as, r_as)
		end

	new_create_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; k_as: KEYWORD_AS): CREATE_CREATION_EXPR_AS is
			-- New creation expression AST node
		do
			if t /= Void then
				create Result.make (t, c, k_as)
			end
		end

	new_bang_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_EXPR_AS is
			-- New creation expression AST node
		do
			if t /= Void then
				create Result.make (t, c, l_as, r_as)
			end
		end

	new_assigner_mark_as (k_as: KEYWORD_AS; i_as: ID_AS): PAIR [KEYWORD_AS, ID_AS] is
			-- New pair of assigner_mark structure.
		do
			create Result.make (k_as, i_as)
		end

	new_filled_none_id_as (l, c, p, s: INTEGER): NONE_ID_AS is
			-- New empty ID AST node.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			create Result.make (s)
			Result.set_position (l, c, p, s)
		end

	new_constraint_triple (k_as: SYMBOL_AS; t_as: TYPE_AS; a_list: EIFFEL_LIST [FEATURE_NAME]): CONSTRAINT_TRIPLE is
			-- New constraint triple structure.
		do
			create Result.make (k_as, t_as, a_list)
		end

	new_alias_triple (k_as: KEYWORD_AS; n_as: STRING_AS; c_as: KEYWORD_AS): ALIAS_TRIPLE is
			-- New ALIST_TRIPLE.
		do
			create Result.make (k_as, n_as, c_as)
		end

	new_agent_target_triple (l_as, r_as: SYMBOL_AS; o_as: OPERAND_AS): AGENT_TARGET_TRIPLE is
			-- New ALIST_TRIPLE.
		do
			create Result.make (l_as, r_as, o_as)
		end

	new_keyword_instruction_list_pair (k_as: KEYWORD_AS; i_as: EIFFEL_LIST [INSTRUCTION_AS]):PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]] is
			-- New ALIST_TRIPLE.
		do
			create Result.make (k_as, i_as)
		end

	new_keyword_string_pair (k_as: KEYWORD_AS; s_as: STRING_AS):PAIR [KEYWORD_AS, STRING_AS] is
			-- New ALIST_TRIPLE.
		do
			create Result.make (k_as, s_as)
		end

	new_invariant_pair (k_as: KEYWORD_AS; i_as: EIFFEL_LIST [TAGGED_AS]): PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]] is
			-- New PAIR for a keyword and a tagged_as list.
		do
			create Result.make (k_as, i_as)
		end

	new_typed_char_as (t_as: TYPE_AS; c: CHARACTER; l, co, p, n: INTEGER; a_text: STRING): TYPED_CHAR_AS is
			-- New TYPED_CHAR AST node.
		do
			create Result.initialize (t_as, c, l, co, p, n)
		end

feature -- Number AST creation

	new_integer_value (a_psr: EIFFEL_PARSER_SKELETON; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): INTEGER_AS is
			-- New integer value.
		require
			buffer_not_void: buffer /= Void
			valid_sign: ("%U+-").has (sign_symbol)
			a_psr_not_void: a_psr /= Void
		local
			l_type: TYPE_A
			token_value: STRING
		do
			if a_type /= Void then
				l_type := a_type.actual_type
			end
			if l_type /= Void then
				if not l_type.is_integer and not l_type.is_natural then
					a_psr.report_invalid_type_for_integer_error (a_type, buffer)
				end
			elseif a_type /= Void then
					-- A type was specified but did not result in a valid type
				a_psr.report_invalid_type_for_integer_error (a_type, buffer)
			end
				-- Remember original token
			token_value := buffer.twin
				-- Remove underscores (if any) without breaking
				-- original token
			if token_value.has ('_') then
				token_value := token_value.twin
				token_value.prune_all ('_')
			end
			if token_value.is_number_sequence then
				Result := new_integer_as (a_type, sign_symbol = '-', token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			elseif
				token_value.item (1) = '0' and then
				token_value.item (2).lower = 'x'
			then
				Result := new_integer_hexa_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			end
			if Result = Void or else not Result.is_initialized then
				if sign_symbol = '-' then
						-- Add `-' for a better reporting.
					buffer.precede ('-')
					a_psr.report_integer_too_small_error (buffer)
				else
					a_psr.report_integer_too_large_error (buffer)
				end
					-- Dummy code (for error recovery) follows:
				Result := new_integer_as (a_type, False, "0", Void, s_as, 0, 0, 0, 0)
			end
			Result.set_position (a_psr.line, a_psr.column, a_psr.position, buffer.count)
		end

	new_real_value (a_psr: EIFFEL_PARSER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): REAL_AS is
			-- New real value.
		require
			buffer_not_void: buffer /= Void
			a_psr_not_void: a_psr /= Void
		local
			l_type: TYPE_A
			l_buffer: STRING
		do
			if a_type /= Void then
				l_type := a_type.actual_type
			end
			if l_type /= Void then
				if not l_type.is_real_32 and not l_type.is_real_64 then
					a_psr.report_invalid_type_for_real_error (a_type, buffer)
				end
			elseif a_type /= Void then
					-- A type was specified but did not result in a valid type
				a_psr.report_invalid_type_for_real_error (a_type, buffer)
			end
			if is_signed and sign_symbol = '-' then
				l_buffer := buffer.twin
				buffer.precede ('-')
			else
				l_buffer := buffer
			end
			Result := new_real_as (a_type, buffer, l_buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			Result.set_position (a_psr.line, a_psr.column, a_psr.position, buffer.count)
		end

feature -- Roundtrip: leaf_as

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node
		require
			a_scn_not_void: a_scn /= Void
		do
		end

	new_feature_keyword_as (l, c, p, s:INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "feature".
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (l, c, p, s)
		end

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "creation'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "end'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "frozen'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_infix_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "infix'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "precursor'.
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_prefix_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "prefix'.
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS is
			-- New KEYWORD AST node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New symbol AST node for all Eiffel symbols except ";", "[" and "]"
		require
			a_scn_not_void: a_scn /= Void
		do
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New symbol AST node only for symbol "[" and "]"
		require
			a_scn_not_void: a_scn /= Void
			a_code_is_squre: a_code = {EIFFEL_TOKENS}.te_lsqure or a_code = {EIFFEL_TOKENS}.te_rsqure
		do
			create Result.make_with_data (a_code, a_scn.line, a_scn.column, a_scn.position, 1)
		end

	create_break_as (a_scn: EIFFEL_SCANNER) is
			-- NEw BREAK_AS node
		do
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New COMMENT_AS node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
		end


feature -- Access

	new_access_assert_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_ASSERT_AS is
			-- New ACCESS_ASSERT AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_feat_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_FEAT_AS is
			-- New ACCESS_FEAT AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_id_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_ID_AS is
			-- New ACCESS_ID AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_inv_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]; k_as: SYMBOL_AS): ACCESS_INV_AS is
			-- New ACCESS_INV AST node
		do
			if f /= Void then
				create Result.make (f, p, k_as)
			end
		end

	new_address_as (f: FEATURE_NAME; a_as: SYMBOL_AS): ADDRESS_AS is
			-- New ADDRESS AST node
		do
			if f /= Void then
				create Result.initialize (f, a_as)
			end
		end

	new_address_current_as (other: CURRENT_AS; a_as: SYMBOL_AS): ADDRESS_CURRENT_AS is
			-- New ADDRESS_CURRENT AST node
		do
			if other /= Void then
				create Result.initialize (other, a_as)
			end
		end

	new_address_result_as (other: RESULT_AS; a_as: SYMBOL_AS): ADDRESS_RESULT_AS is
			-- New ADDRESS_RESULT AST node
		do
			if other /= Void then
				create Result.initialize (other, a_as)
			end
		end

	new_all_as (a_as: KEYWORD_AS): ALL_AS is
			-- New ALL AST node
		do
			create Result.initialize (a_as)
		end

	new_array_as (exp: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): ARRAY_AS is
			-- New Manifest ARRAY AST node
		do
			if exp /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_assign_as (t: ACCESS_AS; s: EXPR_AS; a_as: SYMBOL_AS): ASSIGN_AS is
			-- New ASSIGN AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_assigner_call_as (t: EXPR_AS; s: EXPR_AS; a_as: SYMBOL_AS): ASSIGNER_CALL_AS is
			-- New ASSIGNER CALL AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_bin_and_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_AND_AS is
			-- New binary and AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_and_then_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_AND_THEN_AS is
			-- New binary and then AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, Void)
			end
		end

	new_bin_div_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_DIV_AS is
			-- New binary // AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_eq_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_EQ_AS is
			-- New binary = AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_free_as (l: EXPR_AS; op: ID_AS; r: EXPR_AS): BIN_FREE_AS is
			-- New BIN_FREE AST node
		do
			if l /= Void and r /= Void and op /= Void then
				create Result.initialize (l, op, r)
			end
		end

	new_bin_ge_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_GE_AS is
			-- New binary >= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_gt_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_GT_AS is
			-- New binary > AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_implies_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_IMPLIES_AS is
			-- New binary implies AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_le_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_LE_AS is
			-- New binary <= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_lt_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_LT_AS is
			-- New binary < AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_minus_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_MINUS_AS is
			-- New binary - AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_mod_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_MOD_AS is
			-- New binary \\ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_ne_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_NE_AS is
			-- New binary /= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_or_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_OR_AS is
			-- New binary or AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_or_else_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_OR_ELSE_AS is
			-- New binary or else AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, Void)
			end
		end

	new_bin_plus_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_PLUS_AS is
			-- New binary + AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_power_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_POWER_AS is
			-- New binary ^ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_slash_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_SLASH_AS is
			-- New binary / AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_star_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_STAR_AS is
			-- New binary * AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_xor_as (l, r: EXPR_AS; o: AST_EIFFEL): BIN_XOR_AS is
			-- New binary xor AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bit_const_as (b: ID_AS): BIT_CONST_AS is
			-- New BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'
		do
			if b /= Void then
				create Result.initialize (b)
			end
		end

	new_bits_as (v: INTEGER_AS; b_as: KEYWORD_AS): BITS_AS is
			-- New BITS AST node
		do
			if v /= Void then
				create Result.initialize (v, b_as)
			end
		end

	new_bits_symbol_as (s: ID_AS; b_as: KEYWORD_AS): BITS_SYMBOL_AS is
			-- New BITS_SYMBOL AST node
		do
			if s /= Void then
				create Result.initialize (s, b_as)
			end
		end

	new_bracket_as (t: EXPR_AS; o: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): BRACKET_AS is
			-- New BRACKET AST node
		require
			t_not_void: t /= Void
			o_not_void: o /= Void
		do
			create Result.make (t, o, l_as, r_as)
		end

	new_body_as (a: EIFFEL_LIST [TYPE_DEC_AS]; t: TYPE_AS; r: ID_AS; c: CONTENT_AS; c_as: SYMBOL_AS; k_as, a_as: KEYWORD_AS; i_as: INDEXING_CLAUSE_AS): BODY_AS is
			-- New BODY AST node
		do
			create Result.initialize (a, t, r, c, c_as, k_as, a_as, i_as)
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER): BOOL_AS is
			-- New BOOLEAN AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.initialize (b, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_case_as (i: EIFFEL_LIST [INTERVAL_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; w_as, t_as: KEYWORD_AS): CASE_AS is
			-- New WHEN AST node
		do
			if i /= Void then
				create Result.initialize (i, c, w_as, t_as)
			end
		end

	new_character_as (c: CHARACTER; l, co, p: INTEGER; a_text: STRING): CHAR_AS is
			-- New CHARACTER AST node
		require
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
		do
			create Result.initialize (c, l, co, p, 1)
		end

	new_check_as (c: EIFFEL_LIST [TAGGED_AS]; c_as, e: KEYWORD_AS): CHECK_AS is
			-- New CHECK AST node
		do
			if e /= Void then
				create Result.initialize (c, c_as, e)
			end
		end

	new_class_as (n: ID_AS; ext_name: STRING_AS;
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
			he: BOOLEAN; ed: KEYWORD_AS): CLASS_AS
		is
			-- New CLASS AST node
		do
			if n /= Void and s /= Void and (co = Void or else not co.is_empty) and ed /= Void then
				create Result.initialize (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, top_ind,
				bottom_ind, g, p, c, co, f, inv, s, o, he, ed)
			end
		end

	new_class_type_as (n: ID_AS; g: TYPE_LIST_AS; is_exp, is_sep: BOOLEAN; e_as, s_as: KEYWORD_AS): CLASS_TYPE_AS is
			-- New CLASS_TYPE AST node
		do
			if n /= Void then
				create Result.initialize (n, g, is_exp, is_sep, e_as, s_as)
			end
		end

	new_client_as (c: EIFFEL_LIST [ID_AS]): CLIENT_AS is
			-- New CLIENT AST node
		do
			if c /= Void and not c.is_empty then
				create Result.initialize (c)
			end
		end

	new_constant_as (a: ATOMIC_AS): CONSTANT_AS is
			-- New CONSTANT_AS node
		do
			if a /= Void then
				create Result.initialize (a)
			end
		end

	new_convert_feat_as (cr: BOOLEAN; fn: FEATURE_NAME; t: TYPE_LIST_AS; l_as, r_as, c_as: SYMBOL_AS): CONVERT_FEAT_AS is
			-- New convert feature entry AST node.
		do
			if fn /= Void and (t /= Void and then not t.is_empty) then
				create Result.initialize (cr, fn, t, l_as, r_as, c_as)
			end
		end

	new_create_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_NAME]; c_as: KEYWORD_AS): CREATE_AS is
			-- New creation clause AST node
		do
			create Result.initialize (c, f, c_as)
		end

	new_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS): CREATION_AS is
			-- New creation instruction AST node
		do
			check
				should_not_arrive_here: False
			end
		end

	new_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS): CREATION_EXPR_AS is
			-- New creation expression AST node
		do
			check
				should_not_arrive_here: False
			end
		end

	new_current_as (a_scn: EIFFEL_SCANNER): CURRENT_AS is
			-- New CURRENT AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_custom_attribute_as (c: CREATION_EXPR_AS; t: TUPLE_AS; k_as: KEYWORD_AS): CUSTOM_ATTRIBUTE_AS is
			-- Create a new UNIQUE AST node.
		do
			if c /= Void then
				create Result.initialize (c, t, k_as)
			end
		end

	new_debug_as (k: EIFFEL_LIST [STRING_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: KEYWORD_AS): DEBUG_AS is
			-- New DEBUG AST node
		do
			if e /= Void then
				create Result.initialize (k, c, d_as, e)
			end
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER): DEFERRED_AS is
			-- New DEFERRED AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_do_as (c: EIFFEL_LIST [INSTRUCTION_AS]; k_as: KEYWORD_AS): DO_AS is
			-- New DO AST node
		do
			create Result.make (c, k_as)
		end

	new_eiffel_list_atomic_as (n: INTEGER): EIFFEL_LIST [ATOMIC_AS] is
			-- New empty list of ATOMIC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_case_as (n: INTEGER): EIFFEL_LIST [CASE_AS] is
			-- New empty list of CASE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_convert (n: INTEGER): EIFFEL_LIST [CONVERT_FEAT_AS] is
			-- New empty list of CONVERT_FEAT_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_create_as (n: INTEGER): EIFFEL_LIST [CREATE_AS] is
			-- New empty list of CREATE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_elseif_as (n: INTEGER): EIFFEL_LIST [ELSIF_AS] is
			-- New empty list of ELSIF_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_export_item_as (n: INTEGER): EIFFEL_LIST [EXPORT_ITEM_AS] is
			-- New empty list of EXPORT_ITEM_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_expr_as (n: INTEGER): EIFFEL_LIST [EXPR_AS] is
			-- New empty list of EXPR_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_as (n: INTEGER): EIFFEL_LIST [FEATURE_AS] is
			-- New empty list of FEATURE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_clause_as (n: INTEGER): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
			-- New empty list of FEATURE_CLAUSE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_name (n: INTEGER): EIFFEL_LIST [FEATURE_NAME] is
			-- New empty list of FEATURE_NAME
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_formal_dec_as (n: INTEGER): EIFFEL_LIST [FORMAL_DEC_AS] is
			-- New empty list of FORMAL_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_id_as (n: INTEGER): EIFFEL_LIST [ID_AS] is
			-- New empty list of ID_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_indexing_clause_as (n: INTEGER): INDEXING_CLAUSE_AS is
			-- New empty list of INDEX_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_instruction_as (n: INTEGER): EIFFEL_LIST [INSTRUCTION_AS] is
			-- New empty list of INSTRUCTION_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_interval_as (n: INTEGER): EIFFEL_LIST [INTERVAL_AS] is
			-- New empty list of INTERVAL_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_operand_as (n: INTEGER): EIFFEL_LIST [OPERAND_AS] is
			-- New empty list of OPERAND_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_parent_as (n: INTEGER): EIFFEL_LIST [PARENT_AS] is
			-- New empty list of PARENT_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_rename_as (n: INTEGER): EIFFEL_LIST [RENAME_AS] is
			-- New empty list of RENAME_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_string_as (n: INTEGER): EIFFEL_LIST [STRING_AS] is
			-- New empty list of STRING_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_tagged_as (n: INTEGER): EIFFEL_LIST [TAGGED_AS] is
			-- New empty list of TAGGED_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_type (n: INTEGER): TYPE_LIST_AS is
			-- New empty list of TYPE
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_type_dec_as (n: INTEGER): EIFFEL_LIST [TYPE_DEC_AS] is
			-- New empty list of TYPE_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_elseif_as (e: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; l_as, t_as: KEYWORD_AS): ELSIF_AS is
			-- New ELSIF AST node
		do
			if e /= Void then
				create Result.initialize (e, c, l_as, t_as)
			end
		end

	new_ensure_as (a: EIFFEL_LIST [TAGGED_AS]; k_as: KEYWORD_AS): ENSURE_AS is
			-- New ENSURE AST node
		do
			create Result.make (a, k_as)
		end

	new_ensure_then_as (a: EIFFEL_LIST [TAGGED_AS]; k_as, l_as: KEYWORD_AS): ENSURE_THEN_AS is
			-- New ENSURE THEN AST node
		do
			create Result.make (a, k_as, l_as)
		end

	new_export_item_as (c: CLIENT_AS; f: FEATURE_SET_AS): EXPORT_ITEM_AS is
			-- New EXPORT_ITEM AST node
		do
			if c /= Void and f /= Void then
				create Result.initialize (c, f)
			end
		end

	new_expr_address_as (e: EXPR_AS; a_as, l_as, r_as: SYMBOL_AS): EXPR_ADDRESS_AS is
			-- New EXPR_ADDRESS AST node
		do
			if e /= Void then
				create Result.initialize (e, a_as, l_as, r_as)
			end
		end

	new_expr_call_as (c: CALL_AS): EXPR_CALL_AS is
			-- New EXPR_CALL AST node
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_external_as (l: EXTERNAL_LANG_AS; a: STRING_AS; e_as, a_as: KEYWORD_AS): EXTERNAL_AS is
			-- New EXTERNAL AST node
		do
			if l /= Void then
				create Result.initialize (l, a, e_as, a_as)
			end
		end

	new_external_lang_as (l: STRING_AS): EXTERNAL_LANG_AS is
			-- New EXTERNAL_LANGUAGE AST node
		do
			if l /= Void then
				create Result.initialize (l)
			end
		end

	new_feature_as (f: EIFFEL_LIST [FEATURE_NAME]; b: BODY_AS; i: INDEXING_CLAUSE_AS; next_pos: INTEGER): FEATURE_AS is
			-- New FEATURE AST node
		do
			if
				(f /= Void and then not f.is_empty) and b /= Void
			then
				create Result.initialize (f, b, i, 0, next_pos)
			end
		end

	new_feature_clause_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_AS]; l: KEYWORD_AS; ep: INTEGER): FEATURE_CLAUSE_AS is
			-- New FEATURE_CLAUSE AST node
		do
			if f /= Void and l /= Void then
				create Result.initialize (c, f, l, ep)
			end
		end

	new_feature_list_as (f: EIFFEL_LIST [FEATURE_NAME]): FEATURE_LIST_AS is
			-- New FEATURE_LIST AST node
		do
			if f /= Void then
				create Result.initialize (f)
			end
		end

	new_feature_name_alias_as (feature_name: ID_AS; alias_name: STRING_AS; has_convert_mark: BOOLEAN; a_as, c_as: KEYWORD_AS): FEATURE_NAME_ALIAS_AS is
			-- New FEATURE_NAME_ALIAS AST node
		do
			if feature_name /= Void and then alias_name /= Void then
				create Result.initialize (feature_name, alias_name, has_convert_mark, a_as, c_as)
			end
		end

	new_feature_name_id_as (f: ID_AS): FEAT_NAME_ID_AS is
			-- New FEAT_NAME_ID AST node
		do
			if f /= Void then
				create Result.initialize (f)
			end
		end

	new_formal_as (n: ID_AS; is_ref, is_exp: BOOLEAN; r_as: KEYWORD_AS): FORMAL_AS is
			-- New FORMAL AST node
		do
			if n /= Void then
				create Result.initialize (n, is_ref, is_exp, r_as)
			end
		end

	new_formal_dec_as (f: FORMAL_AS; c: TYPE_AS; cf: EIFFEL_LIST [FEATURE_NAME]; c_as: SYMBOL_AS): FORMAL_DEC_AS is
			-- New FORMAL_DECLARATION AST node
		do
			if f /= Void then
				create Result.initialize (f, c, cf, c_as)
			end
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS is
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		local
			l_count: INTEGER
		do
			l_count := a_scn.text_count
			create Result.make (l_count)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_count)
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): ID_AS is
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_filled_id_as (a_scn)
		end

	new_filled_bit_id_as (a_scn: EIFFEL_SCANNER): ID_AS is
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		local
			l_cnt: INTEGER
		do
			l_cnt := a_scn.text_count - 1
			create Result.make (l_cnt)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
			a_scn.append_text_substring_to_string (1, l_cnt, Result)
		end

	new_identifier_list (n: INTEGER): IDENTIFIER_LIST is
			-- New ARRAYED_LIST [INTEGER]
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		end

	new_if_as (cnd: EXPR_AS; cmp: EIFFEL_LIST [INSTRUCTION_AS];
			ei: EIFFEL_LIST [ELSIF_AS]; e: EIFFEL_LIST [INSTRUCTION_AS];
			end_location, i_as, t_as, e_as: KEYWORD_AS): IF_AS
		is
			-- New IF AST node
		do
			if cnd /= Void and end_location /= Void then
				create Result.initialize (cnd, cmp, ei, e, end_location, i_as, t_as, e_as)
			end
		end

	new_index_as (t: ID_AS; i: EIFFEL_LIST [ATOMIC_AS]; c_as: SYMBOL_AS): INDEX_AS is
			-- Create a new INDEX AST node.
		do
			if i /= Void then
				create Result.initialize (t, i, c_as)
			end
		end

	new_infix_as (op: STRING_AS; l: KEYWORD_AS): INFIX_PREFIX_AS is
			-- New INFIX AST node
		do
			if op /= Void then
				create Result.initialize (op, True, l)
			end
		end

	new_inspect_as (s: EXPR_AS; c: EIFFEL_LIST [CASE_AS];
			e: EIFFEL_LIST [INSTRUCTION_AS]; end_location, i_as, e_as: KEYWORD_AS): INSPECT_AS
		is
			-- New INSPECT AST node
		do
			if s /= Void and end_location /= Void then
				create Result.initialize (s, c, e, end_location, i_as, e_as)
			end
		end

	new_instr_call_as (c: CALL_AS): INSTR_CALL_AS is
			-- New INSTR_CALL AST node
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_interval_as (l, u: ATOMIC_AS; d_as: SYMBOL_AS): INTERVAL_AS is
			-- New INTERVAL AST node
		do
			if l /= Void then
				create Result.initialize (l, u, d_as)
			end
		end

	new_invariant_as (a: EIFFEL_LIST [TAGGED_AS]; once_manifest_string_count: INTEGER; i_as: KEYWORD_AS): INVARIANT_AS is
			-- New INVARIANT AST node
		require
			valid_once_manifest_string_count: once_manifest_string_count >= 0
		do
			create Result.initialize (a, once_manifest_string_count, i_as)
		end

	new_like_id_as (a: ID_AS; l_as: KEYWORD_AS): LIKE_ID_AS is
			-- New LIKE_ID AST node
		do
			if a /= Void then
				create Result.initialize (a, l_as)
			end
		end

	new_like_current_as (other: CURRENT_AS; l_as: KEYWORD_AS): LIKE_CUR_AS is
			-- New LIKE_CURRENT AST node
		do
			create Result.make (other, l_as)
		end

	new_location_as (l, c, p, s: INTEGER): LOCATION_AS is
			-- New LOCATION_AS
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			create Result.make (l, c, p, s)
		end

	new_loop_as (f: EIFFEL_LIST [INSTRUCTION_AS]; i: EIFFEL_LIST [TAGGED_AS];
			v: VARIANT_AS; s: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS];
			e, f_as, i_as, u_as, l_as: KEYWORD_AS): LOOP_AS
		is
			-- New LOOP AST node
		do
			if s /= Void and e /= Void then
				create Result.initialize (f, i, v, s, c, e, f_as, i_as, u_as, l_as)
			end
		end

	new_nested_as (t: ACCESS_AS; m: CALL_AS; d_as: SYMBOL_AS): NESTED_AS is
			-- New NESTED CALL AST node
		do
			if t /= Void and m /= Void then
				create Result.initialize (t, m, d_as)
			end
		end

	new_nested_expr_as (t: EXPR_AS; m: CALL_AS; d_as, l_as, r_as: SYMBOL_AS): NESTED_EXPR_AS is
			-- New NESTED_EXPR CALL AST node
		do
			if t /= Void and m /= Void then
				create Result.initialize (t, m, d_as, l_as, r_as)
			end
		end

	new_none_type_as (c: ID_AS): NONE_TYPE_AS is
			-- New type AST node for "NONE"
		do
			create Result.initialize (c)
		end

	new_once_as (c: EIFFEL_LIST [INSTRUCTION_AS]; k_as: KEYWORD_AS): ONCE_AS is
			-- New ONCE AST node
		do
			create Result.make (c, k_as)
		end

	new_operand_as (c: TYPE_AS; t: ACCESS_AS; e: EXPR_AS): OPERAND_AS is
			-- New OPERAND AST node
		do
			create Result.initialize (c, t, e)
		end

	new_paran_as (e: EXPR_AS; l_as, r_as: SYMBOL_AS): PARAN_AS is
			-- New PARAN AST node
		do
			if e /= Void then
				create Result.initialize (e, l_as, r_as)
			end
		end

	new_parent_as (t: CLASS_TYPE_AS; rn: EIFFEL_LIST [RENAME_AS];
			e: EIFFEL_LIST [EXPORT_ITEM_AS]; u: EIFFEL_LIST [FEATURE_NAME];
			rd: EIFFEL_LIST [FEATURE_NAME]; s: EIFFEL_LIST [FEATURE_NAME]; ed: KEYWORD_AS): PARENT_AS
		is
			-- New PARENT AST node
		do
			if t /= Void then
				create Result.initialize (t, rn, e, u, rd, s, ed)
			end
		end

	new_precursor_as (pk: KEYWORD_AS; n: CLASS_TYPE_AS; p: EIFFEL_LIST [EXPR_AS]): PRECURSOR_AS is
			-- New PRECURSOR AST node
		do
			if pk /= Void and (n /= Void implies n.generics = Void) then
				create Result.initialize (pk, n, p)
			end
		end

	new_prefix_as (op: STRING_AS; l: KEYWORD_AS): INFIX_PREFIX_AS is
			-- New PREFIX AST node
		do
			if op /= Void then
				create Result.initialize (op, False, l)
			end
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): REAL_AS is
			-- New REAL AST node
		do
			if v /= Void then
				create Result.make (t, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_rename_as (o, n: FEATURE_NAME; k_as: KEYWORD_AS): RENAME_AS is
			-- New RENAME_PAIR AST node
		do
			if o /= Void and n /= Void then
				create Result.initialize (o, n, k_as)
			end
		end

	new_require_as (a: EIFFEL_LIST [TAGGED_AS]; k_as: KEYWORD_AS): REQUIRE_AS is
			-- New REQUIRE AST node
		do
			create Result.make (a, k_as)
		end

	new_require_else_as (a: EIFFEL_LIST [TAGGED_AS]; k_as, l_as: KEYWORD_AS): REQUIRE_ELSE_AS is
			-- New REQUIRE ELSE AST node
		do
			create Result.make (a, k_as, l_as)
		end

	new_result_as (a_scn: EIFFEL_SCANNER): RESULT_AS is
			-- New RESULT AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_retry_as (a_scn: EIFFEL_SCANNER): RETRY_AS is
			-- New RETRY AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_reverse_as (t: ACCESS_AS; s: EXPR_AS; a_as: SYMBOL_AS): REVERSE_AS is
			-- New assignment attempt AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_routine_as (o: STRING_AS; pr: REQUIRE_AS;
			l: EIFFEL_LIST [TYPE_DEC_AS]; b: ROUT_BODY_AS; po: ENSURE_AS;
			r: EIFFEL_LIST [INSTRUCTION_AS]; end_loc: KEYWORD_AS;
			oms_count, a_pos: INTEGER; k_as, r_as: KEYWORD_AS): ROUTINE_AS
		is
			-- New ROUTINE AST node
		require
			valid_oms_count: oms_count >= 0
			a_pos_positive: a_pos > 0
		do
			if b /= Void and end_loc /= Void then
				create Result.initialize (o, pr, l, b, po, r, end_loc, oms_count, a_pos, k_as, r_as)
			end
		end

	new_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS]; is_qualified: BOOLEAN): ROUTINE_CREATION_AS is
			-- New ROUTINE_CREATION AST node
		do
--			if f /= Void then
--				create Result.initialize (t, f, o, is_qualified)
--			end
		end

	new_old_routine_creation_as (
			l: AST_EIFFEL; t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS];
			is_qualified: BOOLEAN; a_as: SYMBOL_AS): PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		is
			-- New ROUTINE_CREATION AST node for obsolete use of `~'.
		local
			l_routine: TILDA_ROUTINE_CREATION_AS
		do
			if l /= Void and f /= Void then
				create l_routine.make (t, f, o, is_qualified, a_as)
				create Result.make (l_routine, l.start_location)
			end
		end

	new_static_access_as (c: TYPE_AS; f: ID_AS; p: EIFFEL_LIST [EXPR_AS]; f_as: KEYWORD_AS; d_as: SYMBOL_AS): STATIC_ACCESS_AS is
			-- New STATIC_ACCESS AST node
		do
			create Result.initialize (c, f, p, f_as, d_as)
		end

	new_string_as (s: STRING; l, c, p, n: INTEGER; buf: STRING): STRING_AS is
			-- New STRING AST node
		require
			s_not_void: s /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			if s /= Void then
				create Result.initialize (s, l, c, p, n)
			end
		end

	new_tagged_as (t: ID_AS; e: EXPR_AS; s_as: SYMBOL_AS): TAGGED_AS is
			-- New TAGGED AST node
		do
			create Result.initialize (t, e, s_as)
		end

	new_tuple_as (exp: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): TUPLE_AS is
			-- New Manifest TUPLE AST node
		do
			if exp /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_type_dec_as (i: CONSTRUCT_LIST [INTEGER]; t: TYPE_AS; c_as: SYMBOL_AS): TYPE_DEC_AS is
			-- New TYPE_DEC AST node
		do
			if i /= Void and t /= Void then
				create Result.initialize (i, t, c_as)
			end
		end

	new_type_expr_as (t: TYPE_AS): TYPE_EXPR_AS is
			-- New TYPE_EXPR AST node
		do
			if t /= Void then
				create Result.initialize (t)
			end
		end

	new_un_free_as (op: ID_AS; e: EXPR_AS): UN_FREE_AS is
			-- New UN_FREE AST node
		do
			if op /= Void and e /= Void then
				create Result.initialize (op, e)
			end
		end

	new_un_minus_as (e: EXPR_AS; o: AST_EIFFEL): UN_MINUS_AS is
			-- New unary - AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_not_as (e: EXPR_AS; o: AST_EIFFEL): UN_NOT_AS is
			-- New unary not AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_old_as (e: EXPR_AS; o: AST_EIFFEL): UN_OLD_AS is
			-- New unary old AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_plus_as (e: EXPR_AS; o: AST_EIFFEL): UN_PLUS_AS is
			-- New unary + AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_strip_as (i: CONSTRUCT_LIST [INTEGER]; o: KEYWORD_AS): UN_STRIP_AS is
			-- New UN_STRIP AST node
		do
			if i /= Void then
				create Result.initialize (i, o)
			end
		end

	new_unique_as (a_scn: EIFFEL_SCANNER): UNIQUE_AS is
			-- New UNIQUE AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_variant_as (t: ID_AS; e: EXPR_AS; k_as: KEYWORD_AS; s_as: SYMBOL_AS): VARIANT_AS is
			-- New VARIANT AST node
		do
			if e /= Void then
				create Result.make (t, e, k_as, s_as)
			end
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n: INTEGER; buf: STRING): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			if s /= Void and marker /= Void then
				create Result.initialize (s, marker, is_indentable, l, c, p, n)
			end
		end

	new_void_as (a_scn: EIFFEL_SCANNER): VOID_AS is
			-- New VOID AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


