﻿note

	description: "AST node factories. Accepts UTF-8 encoding in STRING_8 instances."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_FACTORY

inherit
	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Buffer operation

	set_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON)
			-- Clear `a_buf' and then set it with `a_scn'.text.
		require
			a_buf_not_void: a_buf /= Void
			a_scn_not_void: a_scn /= Void
		do
		end

	append_text_to_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON)
			-- Append `a_scn'.text to end of buffer `a_buf'.
		require
			a_buf_not_void: a_buf /= Void
			a_scn_not_void: a_scn /= Void
		do
		end

	append_character_to_buffer (a_buf: STRING; c: CHARACTER)
			-- Append `c' to end of buffer `a_buf'.
		require
			a_buf_not_void: a_buf /= Void
		do
		end

	append_two_characters_to_buffer (a_buf: STRING; a, b: CHARACTER)
			-- Append `a' and `b' to end of buffer `a_buf'.
		require
			a_buf_not_void: a_buf /= Void
		do
		end

	new_string (n: INTEGER): STRING
			-- New STRING object of size `n'.
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		end

feature -- Roundtrip: Match list maintaining

	match_list: LEAF_AS_LIST
			-- List of LEAF_AS nodes.

	match_list_count: INTEGER
			-- Number of elements in `internal_match_list'

	match_list_count_backup: INTEGER
			-- Backup value of `match_list_count' as it was when the last time `backup_match_list_count' is called.

	create_match_list (l_size: INTEGER)
			-- Create a new `match_list' with initial `l_size'.
		require
			l_size_positive: l_size > 0
		do
		end

	extend_match_list (a_match: LEAF_AS)
			-- Extend `internal_match_list' with `a_match'.
		do
		end

	extend_match_list_with_stub (a_stub: LEAF_STUB_AS)
			-- Extend `match_list' with stub `a_stub',
			-- and set index in `a_match'.
		do
		end

	backup_match_list_count
			-- Backup value of `match_list_count' into `match_list_count_backup'.
		do
		end

	resume_match_list_count
			-- Resume the value of `match_list_count_backup' and set `match_list_count' with it.
		do
		end

	enable_match_list_extension
			-- Enable extension of `match_list'.
		do
			is_match_list_extension_disabled := False
		ensure
			match_list_extension_enabled: is_match_list_extension_enabled
		end

	disable_match_list_extension
			-- Disable extension of `match_list'.
		do
			is_match_list_extension_disabled := True
		ensure
			match_list_extension_disabled: not is_match_list_extension_enabled
		end

	is_match_list_extension_enabled: BOOLEAN
			-- Is match list extension enabled?
		do
			Result := not is_match_list_extension_disabled
		end

	is_match_list_extension_disabled: BOOLEAN
			-- Is match list extension disabled?

feature -- Roundtrip

	reverse_extend_separator (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: LEAF_AS)
			-- Add `l_as' into `a_list'.separator_list in reverse order.
		do
		end

	reverse_extend_identifier (a_list: IDENTIFIER_LIST; l_as: ID_AS)
			-- Add `l_as' into `a_list.id_list'.
		do
		end

	reverse_extend_identifier_separator (a_list: IDENTIFIER_LIST; l_as: LEAF_AS)
			-- Add `l_as' into `a_list.separator_list'.
		do
		end

feature -- Parser Access

	parser: EIFFEL_SCANNER_SKELETON
			-- Parser used in conjonction with current factory.

	set_parser (v: like parser)
		do
			parser := v
		ensure
			parser_set: parser =v
		end

feature -- Typing

	keyword_id_type: TUPLE [keyword: KEYWORD_AS; id: ID_AS; line, column: INTEGER; filename: STRING]
			-- Type for `new_keyowrd_id_as'.
		do
		end

feature -- Access

	new_agent_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: KEYWORD_AS; d_as: SYMBOL_AS): AGENT_ROUTINE_CREATION_AS
			-- New AGENT_ROUTINE_CREATION AST node.
		do
			create Result.make (t, f, o, is_qualified, a_as, d_as)
		end

	new_inline_agent_creation_as (a_b: BODY_AS; a_o: DELAYED_ACTUAL_LIST_AS; a_as: KEYWORD_AS): INLINE_AGENT_CREATION_AS
			-- New INLINE_AGENT_CREATION AST node.
		do
			if a_b /= Void then
				create Result.make (a_b, a_o, a_as)
			end
		end

	new_create_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; k_as: KEYWORD_AS): CREATE_CREATION_AS
			-- New CREATE_CREATION AST node.
		do
			if tg /= Void then
				create Result.make (tp, tg, c, k_as)
			end
		end

	new_bang_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_AS
			-- New CREATE_CREATION AST node.
		do
			create Result.make (tp, tg, c, l_as, r_as)
		end

	new_create_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; k_as: KEYWORD_AS): CREATE_CREATION_EXPR_AS
			-- New creation expression AST node
		do
			if t /= Void then
				create Result.make (t, c, k_as)
			end
		end

	new_bang_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_EXPR_AS
			-- New creation expression AST node
		do
			if t /= Void then
				create Result.make (t, c, l_as, r_as)
			end
		end

	new_assigner_mark_as (k_as: KEYWORD_AS; i_as: ID_AS): PAIR [KEYWORD_AS, ID_AS]
			-- New pair of assigner_mark structure.
		do
			create Result.make (k_as, i_as)
		end

	new_filled_none_id_as (l, c, p, s: INTEGER): NONE_ID_AS
			-- New empty ID AST node.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			create Result.make
			Result.set_position (l, c, p, s)
		end

	new_constraint_triple (k_as: SYMBOL_AS; t_as: CONSTRAINT_LIST_AS; l_as: CREATION_CONSTRAIN_TRIPLE): CONSTRAINT_TRIPLE
			-- New constraint triple structure.
		do
			create Result.make (k_as, t_as, l_as)
		end

	new_constraining_type (a_type_as: TYPE_AS; a_renameing_clause_as: RENAME_CLAUSE_AS; a_comma_as: KEYWORD_AS): CONSTRAINING_TYPE_AS
			-- New constraining type structure.
		do
			if a_type_as /= Void then
				create Result.make (a_type_as, a_renameing_clause_as, a_comma_as)
			end
		end

	new_eiffel_list_constraining_type_as (n: INTEGER): CONSTRAINT_LIST_AS
			-- New empty list of `CONSTRAINING_TYPE_AS'
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_alias_triple (k_as: KEYWORD_AS; n_as: STRING_AS; c_as: KEYWORD_AS): ALIAS_TRIPLE
			-- New ALIAS_TRIPLE.
		do
			create Result.make (k_as, n_as, c_as)
		end

	new_agent_target_triple (l_as, r_as: SYMBOL_AS; o_as: OPERAND_AS): AGENT_TARGET_TRIPLE
			-- New AGENT_TARGET_TRIPLE.
		do
			create Result.make (l_as, r_as, o_as)
		end

	new_keyword_instruction_list_pair (k_as: KEYWORD_AS; i_as: EIFFEL_LIST [INSTRUCTION_AS]):PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
			-- New ALIST_TRIPLE.
		do
			create Result.make (k_as, i_as)
		end

	new_keyword_string_pair (k_as: KEYWORD_AS; s_as: STRING_AS):PAIR [KEYWORD_AS, STRING_AS]
			-- New ALIST_TRIPLE.
		do
			create Result.make (k_as, s_as)
		end

	new_invariant_pair (k_as: KEYWORD_AS; i_as: EIFFEL_LIST [TAGGED_AS]): PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
			-- New PAIR for a keyword and a tagged_as list.
		do
			create Result.make (k_as, i_as)
		end

	new_exit_condition_pair (u: KEYWORD_AS; e: EXPR_AS): PAIR [KEYWORD_AS, EXPR_AS]
			-- New PAIR for an exit condition of a loop
		do
			create Result.make (u, e)
		end

	new_typed_char_as (t_as: TYPE_AS; a_char: CHAR_AS): TYPED_CHAR_AS
			-- New TYPED_CHAR AST node.
		do
			if t_as /= Void and then a_char /= Void then
				create Result.initialize (t_as, a_char.value, a_char.line, a_char.column, a_char.position, a_char.location_count)
			end
		end

	new_line_pragma (a_scn: EIFFEL_SCANNER_SKELETON): BREAK_AS
			-- New line pragma
			--| Keep entire line, actual processing will be done later if we need it.
		do
			create Result.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

feature -- Access for Errors

	new_vtgc1_error (a_line: INTEGER; a_column: INTEGER; a_filename: STRING; a_type: TYPE_AS): ERROR
			-- New vtgc1 error.
		require
			a_type_attached: attached a_type
		do
			Result := create {SYNTAX_ERROR}.make (a_line, a_column, a_filename, "Error VTGC1: Anchored types are not allowed in a constraint:%N  %"" + a_type.dump + "%"")
		end

	new_vvok1_error (a_line: INTEGER; a_column: INTEGER; a_filename: STRING; a_once_as: FEATURE_AS): ERROR
			-- New VVOK1 error.
		require
			a_once_as_not_void: a_once_as /= Void
		local
			l_identifier: STRING
		do
			l_identifier := a_once_as.text (match_list)
			check l_identifier_not_void: l_identifier /= Void end
			Result := create {SYNTAX_ERROR}.make (a_line, a_column, a_filename, "Error VVOK1: Conflict in once's keys of routine %"" + l_identifier + "%"")
		end

	new_vvok2_error (a_line: INTEGER; a_column: INTEGER; a_filename: STRING; a_once_as: FEATURE_AS): ERROR
			-- New VVOK2 error.
		require
			a_once_as_not_void: a_once_as /= Void
		local
			l_identifier: STRING
		do
			l_identifier := a_once_as.text (match_list)
			check l_identifier_not_void: l_identifier /= Void end
			Result := create {SYNTAX_ERROR}.make (a_line, a_column, a_filename, "Error VVOK2: Unsupported once key in routine %""+ l_identifier +"%"%N(only %"PROCESS%", %"THREAD%", %"OBJECT%" are supported for now).")
		end


feature -- Value AST creation

	new_character_value_as (a_psr: EIFFEL_SCANNER_SKELETON; buffer: STRING; roundtrip_buffer: STRING): CHAR_AS
			-- New character value for a numerical character representation (i.e. '%/001/').
		require
			buffer_not_void: buffer /= Void
			buffer_not_empty: not buffer.is_empty
			a_text_not_void: roundtrip_buffer /= Void
			a_psr_not_void: a_psr /= Void
		local
			l_integer: INTEGER_AS
		do
				-- Would be nice to not have to create a INTEGER_AS to get the character value.
			backup_match_list_count
			disable_match_list_extension
			l_integer := new_integer_value (a_psr, '+', Void, buffer, Void)
			enable_match_list_extension
			resume_match_list_count
			if l_integer /= Void then
				if l_integer.natural_64_value <= {NATURAL_32}.Max_value then
					Result := new_character_as (l_integer.natural_32_value.to_character_32, a_psr.line, a_psr.column, a_psr.position, roundtrip_buffer.count, roundtrip_buffer)
				else
					a_psr.report_character_code_too_large_error (buffer)
							-- Dummy code (for error recovery) follows:
					Result := new_character_as ('a', 0, 0, 0, 0, roundtrip_buffer)
				end
			else
					-- Dummy code since integer value could not be computed.
				Result := new_character_as ('a', 0, 0, 0, 0, roundtrip_buffer)
			end
		end

	new_integer_value (a_psr: EIFFEL_SCANNER_SKELETON; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): INTEGER_AS
			-- New integer value.
		require
			buffer_not_void: buffer /= Void
			valid_sign: sign_symbol = '%U' or sign_symbol = '-' or sign_symbol = '+'
			a_psr_not_void: a_psr /= Void
		local
			token_value: STRING
		do
			validate_integer_real_type (a_psr, a_type, buffer, True)
			if is_valid_integer_real then
					-- Remember original token
				token_value := buffer.string
					-- Remove underscores (if any) without breaking
					-- original token
				if token_value.has ('_') then
					token_value.prune_all ('_')
				end
				if token_value.is_number_sequence then
					Result := new_integer_as (a_type, sign_symbol = '-', token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
				elseif token_value.count >= 3 and then token_value.item (1) = '0' then
					if token_value.item (2).lower = 'x' then
						Result := new_integer_hexa_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
					elseif token_value.item (2).lower = 'c' then
						Result := new_integer_octal_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
					elseif token_value.item (2).lower = 'b' then
						Result := new_integer_binary_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
					end
				end
				if Result = Void or else not Result.is_initialized then
					if sign_symbol = '-' then
							-- Add `-' for a better reporting.
						buffer.precede ('-')
						a_psr.report_integer_too_small_error (a_type, buffer)
					else
						a_psr.report_integer_too_large_error (a_type, buffer)
					end
						-- Dummy code (for error recovery) follows:
					Result := new_integer_as (a_type, False, "0", Void, s_as, 0, 0, 0, 0)
				end
			end
		end

	new_real_value (a_psr: EIFFEL_SCANNER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): REAL_AS
			-- New real value.
		require
			buffer_not_void: buffer /= Void
			a_psr_not_void: a_psr /= Void
		local
			l_buffer: STRING
		do
			validate_integer_real_type (a_psr, a_type, buffer, False)
			if is_valid_integer_real then
				if is_signed and sign_symbol = '-' then
					l_buffer := buffer.string
					buffer.precede ('-')
				else
					l_buffer := buffer
				end
				Result := new_real_as (a_type, buffer, l_buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			end
		end

feature {NONE} -- Validation

	validate_integer_real_type (a_psr: EIFFEL_SCANNER_SKELETON; a_type: TYPE_AS; buffer: STRING; for_integer: BOOLEAN)
			-- New integer value.
		require
			buffer_not_void: buffer /= Void
			a_psr_not_void: a_psr /= Void
		do
				-- We cannot validate the name easily, so we assume it is correct.
			if for_integer then
			else
			end
			is_valid_integer_real := True
		end

	is_valid_integer_real: BOOLEAN
			-- Was last call to `validate_integer_real_type' successful?

feature -- Validation

	validate_non_conforming_inheritance_type (a_psr: EIFFEL_PARSER_SKELETON; a_type: TYPE_AS)
			-- Validate `a_type' for non-conforming inheritance.
		require
			a_psr_not_void: a_psr /= Void
		do
			-- We can assume that it is valid
		end

feature -- Roundtrip: leaf_as

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node
		require
			a_scn_not_void: a_scn /= Void
		do
		end

	new_keyword_id_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): like keyword_id_type
			-- New KEYWORD AST node
		require
			a_scn_not_void: a_scn /= Void
			valid_code:
				a_code = {EIFFEL_TOKENS}.te_across or
				a_code = {EIFFEL_TOKENS}.te_assign or
				a_code = {EIFFEL_TOKENS}.te_attached or
				a_code = {EIFFEL_TOKENS}.te_attribute or
				a_code = {EIFFEL_TOKENS}.te_detachable or
				a_code = {EIFFEL_TOKENS}.te_indexing or
				a_code = {EIFFEL_TOKENS}.te_is or
				a_code = {EIFFEL_TOKENS}.te_note or
				a_code = {EIFFEL_TOKENS}.te_some
		do
			Result := [new_keyword_as (a_code, a_scn), new_filled_id_as (a_scn), a_scn.line, a_scn.column, a_scn.filename]
		end

	new_feature_keyword_as (l, c, p, s:INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
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

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "creation'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "end'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "frozen'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_infix_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "infix'
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "precursor'.
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_prefix_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "prefix'.
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS
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

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): SYMBOL_AS
			-- New symbol AST node for all Eiffel symbols except ";", "[" and "]"
		require
			a_scn_not_void: a_scn /= Void
		do
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): SYMBOL_AS
			-- New symbol AST node only for symbol "[" and "]"
		require
			a_scn_not_void: a_scn /= Void
			a_code_is_squre: a_code = {EIFFEL_TOKENS}.te_lsqure or a_code = {EIFFEL_TOKENS}.te_rsqure
		do
			create Result.make (a_code, a_scn.line, a_scn.column, a_scn.position, 1)
		end

	create_break_as (a_scn: EIFFEL_SCANNER_SKELETON)
			-- NEw BREAK_AS node
		do
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n: INTEGER)
			-- New COMMENT_AS node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			a_text_not_void: a_text /= Void
		do
		end

feature -- Access

	new_access_assert_as (f: ID_AS; p: PARAMETER_LIST_AS): ACCESS_ASSERT_AS
			-- New ACCESS_ASSERT AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_feat_as (f: ID_AS; p: PARAMETER_LIST_AS): ACCESS_FEAT_AS
			-- New ACCESS_FEAT AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_id_as (f: ID_AS; p: PARAMETER_LIST_AS): ACCESS_ID_AS
			-- New ACCESS_ID AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_inv_as (f: ID_AS; p: PARAMETER_LIST_AS; k_as: SYMBOL_AS): ACCESS_INV_AS
			-- New ACCESS_INV AST node
		do
			if f /= Void then
				create Result.make (f, p, k_as)
			end
		end

	new_address_as (f: FEATURE_NAME; a_as: SYMBOL_AS): ADDRESS_AS
			-- New ADDRESS AST node
		do
			if f /= Void then
				create Result.initialize (f, a_as)
			end
		end

	new_address_current_as (other: CURRENT_AS; a_as: SYMBOL_AS): ADDRESS_CURRENT_AS
			-- New ADDRESS_CURRENT AST node
		do
			if other /= Void then
				create Result.initialize (other, a_as)
			end
		end

	new_address_result_as (other: RESULT_AS; a_as: SYMBOL_AS): ADDRESS_RESULT_AS
			-- New ADDRESS_RESULT AST node
		do
			if other /= Void then
				create Result.initialize (other, a_as)
			end
		end

	new_all_as (a_as: KEYWORD_AS): ALL_AS
			-- New ALL AST node
		do
			create Result.initialize (a_as)
		end

	new_array_as (exp: EIFFEL_LIST [EXPR_AS]; l_as: SYMBOL_AS; r_as: detachable SYMBOL_AS): ARRAY_AS
			-- New Manifest ARRAY AST node
		do
			if exp /= Void and l_as /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_assign_as (t: ACCESS_AS; s: EXPR_AS; a_as: SYMBOL_AS): ASSIGN_AS
			-- New ASSIGN AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_assigner_call_as (t: EXPR_AS; s: EXPR_AS; a_as: SYMBOL_AS): ASSIGNER_CALL_AS
			-- New ASSIGNER CALL AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_attribute_as (c: EIFFEL_LIST [INSTRUCTION_AS]; k_as: KEYWORD_AS): ATTRIBUTE_AS
			-- New ATTRIBUTE AST node
		do
			create Result.make (c, k_as)
		end

	new_bin_and_as (l, r: EXPR_AS; o: LEAF_AS): BIN_AND_AS
			-- New binary and AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_and_then_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_AND_THEN_AS
			-- New binary and then AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, Void)
			end
		end

	new_bin_div_as (l, r: EXPR_AS; o: LEAF_AS): BIN_DIV_AS
			-- New binary // AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_eq_as (l, r: EXPR_AS; o: LEAF_AS): BIN_EQ_AS
			-- New binary = AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_free_as (l: EXPR_AS; op: ID_AS; r: EXPR_AS): BIN_FREE_AS
			-- New BIN_FREE AST node
		do
			if l /= Void and r /= Void and op /= Void then
				create Result.initialize (l, op, r)
			end
		end

	new_bin_ge_as (l, r: EXPR_AS; o: LEAF_AS): BIN_GE_AS
			-- New binary >= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_gt_as (l, r: EXPR_AS; o: LEAF_AS): BIN_GT_AS
			-- New binary > AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_implies_as (l, r: EXPR_AS; o: LEAF_AS): BIN_IMPLIES_AS
			-- New binary implies AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_le_as (l, r: EXPR_AS; o: LEAF_AS): BIN_LE_AS
			-- New binary <= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_lt_as (l, r: EXPR_AS; o: LEAF_AS): BIN_LT_AS
			-- New binary < AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_minus_as (l, r: EXPR_AS; o: LEAF_AS): BIN_MINUS_AS
			-- New binary - AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_mod_as (l, r: EXPR_AS; o: LEAF_AS): BIN_MOD_AS
			-- New binary \\ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_ne_as (l, r: EXPR_AS; o: LEAF_AS): BIN_NE_AS
			-- New binary /= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_not_tilde_as (l, r: EXPR_AS; o: LEAF_AS): BIN_NOT_TILDE_AS
			-- New binary /~ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_or_as (l, r: EXPR_AS; o: LEAF_AS): BIN_OR_AS
			-- New binary or AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_or_else_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_OR_ELSE_AS
			-- New binary or else AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, Void)
			end
		end

	new_bin_plus_as (l, r: EXPR_AS; o: LEAF_AS): BIN_PLUS_AS
			-- New binary + AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_power_as (l, r: EXPR_AS; o: LEAF_AS): BIN_POWER_AS
			-- New binary ^ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_slash_as (l, r: EXPR_AS; o: LEAF_AS): BIN_SLASH_AS
			-- New binary / AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_star_as (l, r: EXPR_AS; o: LEAF_AS): BIN_STAR_AS
			-- New binary * AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_tilde_as (l, r: EXPR_AS; o: LEAF_AS): BIN_TILDE_AS
			-- New binary ~ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_xor_as (l, r: EXPR_AS; o: LEAF_AS): BIN_XOR_AS
			-- New binary xor AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bit_const_as (b: ID_AS): BIT_CONST_AS
			-- New BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'
		do
			if b /= Void then
				create Result.initialize (b)
			end
		end

	new_bits_as (v: INTEGER_AS; b_as: KEYWORD_AS): BITS_AS
			-- New BITS AST node
		do
			if v /= Void then
				create Result.initialize (v, b_as)
			end
		end

	new_bits_symbol_as (s: ID_AS; b_as: KEYWORD_AS): BITS_SYMBOL_AS
			-- New BITS_SYMBOL AST node
		do
			if s /= Void then
				create Result.initialize (s, b_as)
			end
		end

	new_bracket_as (t: EXPR_AS; o: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): BRACKET_AS
			-- New BRACKET AST node
		do
			if t /= Void and (o /= Void and then not o.is_empty)  then
				create Result.make (t, o, l_as, r_as)
			end
		end

	new_body_as (a: FORMAL_ARGU_DEC_LIST_AS; t: TYPE_AS; r: ID_AS; c: CONTENT_AS; c_as: SYMBOL_AS; k_as: LEAF_AS; a_as: KEYWORD_AS; i_as: INDEXING_CLAUSE_AS): BODY_AS
			-- New BODY AST node
		do
			create Result.initialize (a, t, r, c, c_as, k_as, a_as, i_as)
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER_SKELETON): BOOL_AS
			-- New BOOLEAN AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.initialize (b, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_built_in_as (l: EXTERNAL_LANG_AS; a: STRING_AS; e_as, a_as: KEYWORD_AS): BUILT_IN_AS
			-- New BUILT_IN AST node
		do
			if l /= Void then
				create Result.initialize (l, a, e_as, a_as)
			end
		end

	new_case_as (i: EIFFEL_LIST [INTERVAL_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; w_as, t_as: KEYWORD_AS): CASE_AS
			-- New WHEN AST node
		do
			if i /= Void then
				create Result.initialize (i, c, w_as, t_as)
			end
		end

	new_character_as (c: CHARACTER_32; l, co, p, n: INTEGER; a_text: STRING): CHAR_AS
			-- New CHARACTER AST node
		require
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			create Result.initialize (c, l, co, p, n)
		end

	new_check_as (c: EIFFEL_LIST [TAGGED_AS]; c_as, e: KEYWORD_AS): CHECK_AS
			-- New CHECK AST node
		do
			if e /= Void then
				create Result.initialize (c, c_as, e)
			end
		end

	new_class_as (n: ID_AS; ext_name: STRING_AS;
			is_d, is_e, is_s, is_fc, is_ex, is_par: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			cp: PARENT_LIST_AS;
			ncp: PARENT_LIST_AS
			c: EIFFEL_LIST [CREATE_AS];
			co: CONVERT_FEAT_LIST_AS;
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			ed: KEYWORD_AS): CLASS_AS

			-- New CLASS AST node
		do
			if n /= Void and s /= Void and (co = Void or else not co.is_empty) and ed /= Void then
				create Result.initialize (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, is_par, top_ind,
				bottom_ind, g, cp, ncp, c, co, f, inv, s, o, ed)
			end
		end

	new_class_type_as (n: ID_AS; g: TYPE_LIST_AS): CLASS_TYPE_AS
			-- New CLASS_TYPE AST node
		do
			if n /= Void then
				if g /= Void then
					create {GENERIC_CLASS_TYPE_AS} Result.initialize (n, g)
				else
					create Result.initialize (n)
				end
			end
		end

	set_expanded_class_type (a_type: TYPE_AS; is_expanded: BOOLEAN; s_as: KEYWORD_AS)
			-- Set expanded status of `a_type' if it is an instance of CLASS_TYPE_AS.
		local
			l_class_type: CLASS_TYPE_AS
		do
			if is_expanded then
				l_class_type ?= a_type
				if l_class_type /= Void then
					l_class_type.set_is_expanded (True, s_as)
				end
			end
		end

	new_named_tuple_type_as (n: ID_AS; p: FORMAL_ARGU_DEC_LIST_AS): NAMED_TUPLE_TYPE_AS
			-- New TUPLE_TYPE AST node
		do
			if n /= Void and (p /= Void and then p.arguments /= Void) then
				create Result.initialize (n, p)
			end
		end

	new_client_as (c: CLASS_LIST_AS): CLIENT_AS
			-- New CLIENT AST node
		do
			if c /= Void and then not c.is_empty then
				create Result.initialize (c)
			end
		end

	new_constant_as (a: ATOMIC_AS): CONSTANT_AS
			-- New CONSTANT_AS node
		do
			if a /= Void then
				create Result.initialize (a)
			end
		end

	new_convert_feat_as (cr: BOOLEAN; fn: FEATURE_NAME; t: TYPE_LIST_AS; l_as, r_as, c_as, lc_as, rc_as: SYMBOL_AS): CONVERT_FEAT_AS
			-- New convert feature entry AST node.
		do
			if fn /= Void and (t /= Void and then not t.is_empty) then
				create Result.initialize (cr, fn, t, l_as, r_as, c_as, lc_as, rc_as)
			end
		end

	new_create_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_NAME]; c_as: KEYWORD_AS): CREATE_AS
			-- New creation clause AST node
		do
			create Result.initialize (c, f, c_as)
		end

	new_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS): CREATION_AS
			-- New creation instruction AST node
		do
			check
				should_not_arrive_here: False
			end
		end

	new_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS): CREATION_EXPR_AS
			-- New creation expression AST node
		do
			check
				should_not_arrive_here: False
			end
		end

	new_current_as (a_scn: EIFFEL_SCANNER_SKELETON): CURRENT_AS
			-- New CURRENT AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_custom_attribute_as (c: CREATION_EXPR_AS; t: TUPLE_AS; k_as: KEYWORD_AS): CUSTOM_ATTRIBUTE_AS
			-- Create a new UNIQUE AST node.
		do
			if c /= Void then
				create Result.initialize (c, t, k_as)
			end
		end

	new_debug_as (k: KEY_LIST_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: KEYWORD_AS): DEBUG_AS
			-- New DEBUG AST node
		do
			if e /= Void then
				create Result.initialize (k, c, d_as, e)
			end
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER_SKELETON): DEFERRED_AS
			-- New DEFERRED AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_do_as (c: EIFFEL_LIST [INSTRUCTION_AS]; k_as: KEYWORD_AS): DO_AS
			-- New DO AST node
		do
			create Result.make (c, k_as)
		end

	new_eiffel_list_atomic_as (n: INTEGER): EIFFEL_LIST [ATOMIC_AS]
			-- New empty list of ATOMIC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_case_as (n: INTEGER): EIFFEL_LIST [CASE_AS]
			-- New empty list of CASE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_convert (n: INTEGER): CONVERT_FEAT_LIST_AS
			-- New empty list of CONVERT_FEAT_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_create_as (n: INTEGER): EIFFEL_LIST [CREATE_AS]
			-- New empty list of CREATE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_elseif_as (n: INTEGER): EIFFEL_LIST [ELSIF_AS]
			-- New empty list of ELSIF_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_export_item_as (n: INTEGER): EIFFEL_LIST [EXPORT_ITEM_AS]
			-- New empty list of EXPORT_ITEM_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_expr_as (n: INTEGER): EIFFEL_LIST [EXPR_AS]
			-- New empty list of PARAMETER_LIST_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_parameter_list_as (l: EIFFEL_LIST [EXPR_AS]; lp_as, rp_as: SYMBOL_AS): PARAMETER_LIST_AS
			-- New empty list of EXPR_AS
		do
			create Result.initialize (l, lp_as, rp_as)
		end

	new_eiffel_list_feature_as (n: INTEGER): EIFFEL_LIST [FEATURE_AS]
			-- New empty list of FEATURE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_clause_as (n: INTEGER): EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- New empty list of FEATURE_CLAUSE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_name (n: INTEGER): EIFFEL_LIST [FEATURE_NAME]
			-- New empty list of FEATURE_NAME
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_formal_dec_as (n: INTEGER): FORMAL_GENERIC_LIST_AS
			-- New empty list of FORMAL_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_id_as (n: INTEGER): EIFFEL_LIST [ID_AS]
			-- New empty list of ID_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_indexing_clause_as (n: INTEGER): INDEXING_CLAUSE_AS
			-- New empty list of INDEX_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_instruction_as (n: INTEGER): EIFFEL_LIST [INSTRUCTION_AS]
			-- New empty list of INSTRUCTION_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_interval_as (n: INTEGER): EIFFEL_LIST [INTERVAL_AS]
			-- New empty list of INTERVAL_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_operand_as (n: INTEGER): EIFFEL_LIST [OPERAND_AS]
			-- New empty list of OPERAND_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_parent_as (n: INTEGER): PARENT_LIST_AS
			-- New empty list of PARENT_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_rename_as (n: INTEGER): EIFFEL_LIST [RENAME_AS]
			-- New empty list of RENAME_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_string_as (n: INTEGER): EIFFEL_LIST [STRING_AS]
			-- New empty list of STRING_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_tagged_as (n: INTEGER): EIFFEL_LIST [TAGGED_AS]
			-- New empty list of TAGGED_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_type (n: INTEGER): TYPE_LIST_AS
			-- New empty list of TYPE
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_type_dec_as (n: INTEGER): TYPE_DEC_LIST_AS
			-- New empty list of TYPE_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_elseif_as (e: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; l_as, t_as: KEYWORD_AS): ELSIF_AS
			-- New ELSIF AST node
		do
			if e /= Void then
				create Result.initialize (e, c, l_as, t_as)
			end
		end

	new_ensure_as (a: EIFFEL_LIST [TAGGED_AS]; k_as: KEYWORD_AS): ENSURE_AS
			-- New ENSURE AST node
		do
			create Result.make (a, k_as)
		end

	new_ensure_then_as (a: EIFFEL_LIST [TAGGED_AS]; k_as, l_as: KEYWORD_AS): ENSURE_THEN_AS
			-- New ENSURE THEN AST node
		do
			create Result.make (a, k_as, l_as)
		end

	new_export_item_as (c: CLIENT_AS; f: FEATURE_SET_AS): EXPORT_ITEM_AS
			-- New EXPORT_ITEM AST node
		do
			if c /= Void then
				create Result.initialize (c, f)
			end
		end

	new_expr_address_as (e: EXPR_AS; a_as, l_as, r_as: SYMBOL_AS): EXPR_ADDRESS_AS
			-- New EXPR_ADDRESS AST node
		do
			if e /= Void then
				create Result.initialize (e, a_as, l_as, r_as)
			end
		end

	new_expr_call_as (c: CALL_AS): EXPR_CALL_AS
			-- New EXPR_CALL AST node
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_external_as (l: EXTERNAL_LANG_AS; a: STRING_AS; e_as, a_as: KEYWORD_AS): EXTERNAL_AS
			-- New EXTERNAL AST node
		do
			if l /= Void then
				create Result.initialize (l, a, e_as, a_as)
			end
		end

	new_external_lang_as (l: STRING_AS): EXTERNAL_LANG_AS
			-- New EXTERNAL_LANGUAGE AST node
		do
			if l /= Void then
				create Result.initialize (l)
			end
		end

	new_feature_as (f: EIFFEL_LIST [FEATURE_NAME]; b: BODY_AS; i: INDEXING_CLAUSE_AS; next_pos: INTEGER): FEATURE_AS
			-- New FEATURE AST node
		do
			if
				(f /= Void and then not f.is_empty) and b /= Void
			then
				create Result.initialize (f, b, i, 0, next_pos)
			end
		end

	new_feature_clause_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_AS]; l: KEYWORD_AS; ep: INTEGER): FEATURE_CLAUSE_AS
			-- New FEATURE_CLAUSE AST node
		do
			if f /= Void and l /= Void then
				create Result.initialize (c, f, l, ep)
			end
		end

	new_feature_list_as (f: EIFFEL_LIST [FEATURE_NAME]): FEATURE_LIST_AS
			-- New FEATURE_LIST AST node
		do
			if f /= Void then
				create Result.initialize (f)
			end
		end

	new_feature_name_alias_as (feature_name: ID_AS; alias_name: STRING_AS; has_convert_mark: BOOLEAN; a_as, c_as: KEYWORD_AS): FEATURE_NAME_ALIAS_AS
			-- New FEATURE_NAME_ALIAS AST node
		do
			if feature_name /= Void and then alias_name /= Void then
				create Result.initialize (feature_name, alias_name, has_convert_mark, a_as, c_as)
			end
		end

	new_feature_name_id_as (f: ID_AS): FEAT_NAME_ID_AS
			-- New FEAT_NAME_ID AST node
		do
			if f /= Void then
				create Result.initialize (f)
			end
		end

	new_formal_as (n: ID_AS; is_ref, is_exp: BOOLEAN; r_as: KEYWORD_AS): FORMAL_AS
			-- New FORMAL AST node
		do
			if n /= Void then
				create Result.initialize (n, is_ref, is_exp, r_as)
			end
		end

	new_formal_dec_as (f: FORMAL_AS; c: CONSTRAINT_LIST_AS; cf: EIFFEL_LIST [FEATURE_NAME]; c_as: SYMBOL_AS; ck_as, ek_as: KEYWORD_AS): FORMAL_DEC_AS
			-- New FORMAL_DECLARATION AST node
		do
			if f /= Void then
				create Result.initialize (f, c, cf, c_as, ck_as, ek_as)
			end
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		local
			l_cnt: INTEGER
			l_str: STRING
		do
			l_cnt := a_scn.text_count
			l_str := reusable_string_buffer
			l_str.wipe_out
			a_scn.append_text_to_string (l_str)
			create Result.initialize (l_str)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): ID_AS
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_filled_id_as (a_scn)
		end

	new_filled_bit_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		local
			l_cnt: INTEGER
			l_str: STRING
		do
			l_cnt := a_scn.text_count - 1
			create l_str.make (l_cnt)
			a_scn.append_text_substring_to_string (1, l_cnt, l_str)
			create Result.initialize (l_str)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
		end

	new_guard_as (c: KEYWORD_AS; a: EIFFEL_LIST [TAGGED_AS]; t: KEYWORD_AS;
	              l: EIFFEL_LIST [INSTRUCTION_AS]; e: KEYWORD_AS): GUARD_AS
			-- New CHECK with body AST node
		do
			create Result.initialize (c, a, t, l, e)
		end

	new_identifier_list (n: INTEGER): IDENTIFIER_LIST
			-- New ARRAYED_LIST [INTEGER]
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		end

	new_if_as (cnd: EXPR_AS; cmp: EIFFEL_LIST [INSTRUCTION_AS];
			ei: EIFFEL_LIST [ELSIF_AS]; e: EIFFEL_LIST [INSTRUCTION_AS];
			end_location, i_as, t_as, e_as: KEYWORD_AS): IF_AS

			-- New IF AST node
		do
			if cnd /= Void and end_location /= Void then
				create Result.initialize (cnd, cmp, ei, e, end_location, i_as, t_as, e_as)
			end
		end

	new_index_as (t: ID_AS; i: EIFFEL_LIST [ATOMIC_AS]; c_as: SYMBOL_AS): INDEX_AS
			-- Create a new INDEX AST node.
		do
			if i /= Void then
				create Result.initialize (t, i, c_as)
			end
		end

	new_infix_as (op: STRING_AS; l: KEYWORD_AS): INFIX_PREFIX_AS
			-- New INFIX AST node
		do
			if op /= Void then
				create Result.initialize (op, True, l)
			end
		end

	new_inspect_as (s: EXPR_AS; c: EIFFEL_LIST [CASE_AS];
			e: EIFFEL_LIST [INSTRUCTION_AS]; end_location, i_as, e_as: KEYWORD_AS): INSPECT_AS

			-- New INSPECT AST node
		do
			if s /= Void and end_location /= Void then
				create Result.initialize (s, c, e, end_location, i_as, e_as)
			end
		end

	new_instr_call_as (c: CALL_AS): INSTR_CALL_AS
			-- New INSTR_CALL AST node
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_octal_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_octal_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_binary_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_binary_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_interval_as (l, u: ATOMIC_AS; d_as: SYMBOL_AS): INTERVAL_AS
			-- New INTERVAL AST node
		do
			if l /= Void then
				create Result.initialize (l, u, d_as)
			end
		end

	new_invariant_as (a: EIFFEL_LIST [TAGGED_AS]; once_manifest_string_count: INTEGER; i_as: KEYWORD_AS; object_test_locals: ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]): INVARIANT_AS
			-- New INVARIANT AST node
		require
			valid_once_manifest_string_count: once_manifest_string_count >= 0
		do
			create Result.initialize (a, once_manifest_string_count, i_as, object_test_locals)
		end

	new_iteration_as (a: KEYWORD_AS; e: EXPR_AS; b: KEYWORD_AS; i: ID_AS): ITERATION_AS
			-- New ITERATION AST node
		do
			if e /= Void and i /= Void then
				create Result.initialize (a, e, b, i)
			end
		end

	new_like_id_as (a: ID_AS; l_as: KEYWORD_AS): LIKE_ID_AS
			-- New LIKE_ID AST node
		do
			if a /= Void then
				create Result.initialize (a, l_as)
			end
		end

	new_like_current_as (other: CURRENT_AS; l_as: KEYWORD_AS): LIKE_CUR_AS
			-- New LIKE_CURRENT AST node
		do
			if other /= Void then
				create Result.make (other, l_as)
			end
		end

	new_location_as (l, c, p, s: INTEGER): LOCATION_AS
			-- New LOCATION_AS
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			create Result.make (l, c, p, s)
		end

	new_loop_as (t: detachable ITERATION_AS; f: detachable EIFFEL_LIST [INSTRUCTION_AS]; i: detachable EIFFEL_LIST [TAGGED_AS];
			v: detachable VARIANT_AS; s: detachable EXPR_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS];
			e, f_as, i_as, u_as, l_as: KEYWORD_AS): LOOP_AS
			-- New LOOP AST node
		do
			if (t /= Void or s /= Void) and e /= Void then
				create Result.initialize (t, f, i, v, s, c, e, f_as, i_as, u_as, l_as)
			end
		end

	new_loop_expr_as (f: ITERATION_AS; w: KEYWORD_AS; i: EIFFEL_LIST [TAGGED_AS];
			u: KEYWORD_AS; c: EXPR_AS; q: KEYWORD_AS; a: BOOLEAN; e: EXPR_AS; v: VARIANT_AS; k: KEYWORD_AS): LOOP_EXPR_AS
			-- New LOOP expression AST node
		do
			if f /= Void and then e /= Void then
				create Result.initialize (f, w, i, u, c, q, a, e, v, k)
			end
		end

	new_nested_as (t: ACCESS_AS; m: CALL_AS; d_as: SYMBOL_AS): NESTED_AS
			-- New NESTED CALL AST node
		do
			if t /= Void and m /= Void then
				create Result.initialize (t, m, d_as)
			end
		end

	new_nested_expr_as (t: EXPR_AS; m: CALL_AS; d_as, l_as, r_as: SYMBOL_AS): NESTED_EXPR_AS
			-- New NESTED_EXPR CALL AST node
		do
			if t /= Void and m /= Void then
				create Result.initialize (t, m, d_as, l_as, r_as)
			end
		end

	new_none_type_as (c: ID_AS): NONE_TYPE_AS
			-- New type AST node for "NONE"
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_object_test_as (l_attached: KEYWORD_AS; type: TYPE_AS; expression: EXPR_AS; l_as: KEYWORD_AS; name: ID_AS): OBJECT_TEST_AS
			-- New OBJECT_TEST_AS node
		do
			if expression /= Void then
				create Result.make (l_attached, type, expression, l_as, name)
			end
		end

	new_old_syntax_object_test_as (start: SYMBOL_AS; name: ID_AS; type: TYPE_AS; expression: EXPR_AS): OBJECT_TEST_AS
			-- New OBJECT_TEST_AS node
		do
			if name /= Void and type /= Void and expression /= Void then
				create Result.make_curly (start, name, type, expression)
			end
		end

	new_once_as (o: KEYWORD_AS; k: KEY_LIST_AS; c: EIFFEL_LIST [INSTRUCTION_AS]): ONCE_AS
			-- New ONCE AST node
		do
			create Result.make (o, k, c)
		end

	new_operand_as (c: TYPE_AS; t: ACCESS_AS; e: EXPR_AS): OPERAND_AS
			-- New OPERAND AST node
		do
			create Result.initialize (c, t, e)
		end

	new_paran_as (e: EXPR_AS; l_as, r_as: SYMBOL_AS): PARAN_AS
			-- New PARAN AST node
		do
			if e /= Void then
				create Result.initialize (e, l_as, r_as)
			end
		end

	new_parent_as (t: CLASS_TYPE_AS; rn: RENAME_CLAUSE_AS;
			e: EXPORT_CLAUSE_AS; u: UNDEFINE_CLAUSE_AS;
			rd: REDEFINE_CLAUSE_AS; s: SELECT_CLAUSE_AS; ed: KEYWORD_AS): PARENT_AS

			-- New PARENT AST node
		do
			if t /= Void then
				create Result.initialize (t, rn, e, u, rd, s, ed)
			end
		end

	new_precursor_as (pk: KEYWORD_AS; n: CLASS_TYPE_AS; p: PARAMETER_LIST_AS): PRECURSOR_AS
			-- New PRECURSOR AST node
		do
			if pk /= Void and (n /= Void implies n.generics = Void) then
				create Result.initialize (pk, n, p)
			end
		end

	new_prefix_as (op: STRING_AS; l: KEYWORD_AS): INFIX_PREFIX_AS
			-- New PREFIX AST node
		do
			if op /= Void then
				create Result.initialize (op, False, l)
			end
		end

	new_qualified_anchored_type (t: TYPE_AS; d: SYMBOL_AS; f: ID_AS): QUALIFIED_ANCHORED_TYPE_AS
			-- New QUALIFIED_ANCHORED_TYPE AST node for an anchored type of the form "t.f" where "t" is known to be an anchored type.
		require
			attached t implies (attached {LIKE_CUR_AS} t or attached {LIKE_ID_AS} t)
		do
			if attached t and attached f then
				create Result.make_anchored (t, d, f)
			end
		end

	new_qualified_anchored_type_with_type (l: KEYWORD_AS; t: TYPE_AS; d: SYMBOL_AS; f: ID_AS): QUALIFIED_ANCHORED_TYPE_AS
			-- New QUALIFIED_ANCHORED_TYPE AST node for an anchored type of the form "like {t}.f".
		do
			if attached t and attached f then
				create Result.make_explicit (l, t, d, f)
			end
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): REAL_AS
			-- New REAL AST node
		do
			if v /= Void then
				create Result.make (t, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_rename_as (o, n: FEATURE_NAME; k_as: KEYWORD_AS): RENAME_AS
			-- New RENAME_PAIR AST node
		do
			if o /= Void and n /= Void then
				create Result.initialize (o, n, k_as)
			end
		end

	new_require_as (a: EIFFEL_LIST [TAGGED_AS]; k_as: KEYWORD_AS): REQUIRE_AS
			-- New REQUIRE AST node
		do
			create Result.make (a, k_as)
		end

	new_require_else_as (a: EIFFEL_LIST [TAGGED_AS]; k_as, l_as: KEYWORD_AS): REQUIRE_ELSE_AS
			-- New REQUIRE ELSE AST node
		do
			create Result.make (a, k_as, l_as)
		end

	new_result_as (a_scn: EIFFEL_SCANNER_SKELETON): RESULT_AS
			-- New RESULT AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_retry_as (a_scn: EIFFEL_SCANNER_SKELETON): RETRY_AS
			-- New RETRY AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_reverse_as (t: ACCESS_AS; s: EXPR_AS; a_as: SYMBOL_AS): REVERSE_AS
			-- New assignment attempt AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_routine_as (o: STRING_AS; pr: REQUIRE_AS;
			l: LOCAL_DEC_LIST_AS; b: ROUT_BODY_AS; po: ENSURE_AS;
			r: EIFFEL_LIST [INSTRUCTION_AS]; end_loc: KEYWORD_AS;
			oms_count, a_pos: INTEGER; k_as, r_as: KEYWORD_AS;
			object_test_locals: ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]): ROUTINE_AS

			-- New ROUTINE AST node
		require
			valid_oms_count: oms_count >= 0
			a_pos_positive: a_pos > 0
		do
			if b /= Void and end_loc /= Void then
				create Result.initialize (o, pr, l, b, po, r, end_loc, oms_count, a_pos, k_as, r_as, object_test_locals)
			end
		end

	new_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN): ROUTINE_CREATION_AS
			-- New ROUTINE_CREATION AST node
		do
		end

	new_static_access_as (c: TYPE_AS; f: ID_AS; p: PARAMETER_LIST_AS; f_as: KEYWORD_AS; d_as: SYMBOL_AS): STATIC_ACCESS_AS
			-- New STATIC_ACCESS AST node
		do
			if c /= Void and f /= Void then
				create Result.initialize (c, f, p, f_as, d_as)
			end
		end

	new_string_as (s: STRING; l, c, p, n: INTEGER; buf: STRING): STRING_AS
			-- New STRING AST node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			if s /= Void then
				create Result.initialize (s, l, c, p, n)
			end
		end

	new_tagged_as (t: ID_AS; e: EXPR_AS; s_as: SYMBOL_AS): TAGGED_AS
			-- New TAGGED AST node
		do
			create Result.initialize (t, e, s_as)
		end

	new_tuple_as (exp: EIFFEL_LIST [EXPR_AS]; l_as: SYMBOL_AS; r_as: detachable SYMBOL_AS): TUPLE_AS
			-- New Manifest TUPLE AST node
		do
			if exp /= Void and l_as /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_type_dec_as (i: IDENTIFIER_LIST; t: TYPE_AS; c_as: SYMBOL_AS): TYPE_DEC_AS
			-- New TYPE_DEC AST node
		do
			if i /= Void and t /= Void then
				create Result.initialize (i, t, c_as)
			end
		end

	new_type_expr_as (t: TYPE_AS): TYPE_EXPR_AS
			-- New TYPE_EXPR AST node
		do
			if t /= Void then
				create Result.initialize (t)
			end
		end

	new_un_free_as (op: ID_AS; e: EXPR_AS): UN_FREE_AS
			-- New UN_FREE AST node
		do
			if op /= Void and e /= Void then
				create Result.initialize (op, e)
			end
		end

	new_un_minus_as (e: EXPR_AS; o: LEAF_AS): UN_MINUS_AS
			-- New unary - AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_not_as (e: EXPR_AS; o: LEAF_AS): UN_NOT_AS
			-- New unary not AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_old_as (e: EXPR_AS; o: LEAF_AS): UN_OLD_AS
			-- New unary old AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_plus_as (e: EXPR_AS; o: LEAF_AS): UN_PLUS_AS
			-- New unary + AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_strip_as (i: IDENTIFIER_LIST; o: KEYWORD_AS; lp_as, rp_as: SYMBOL_AS): UN_STRIP_AS
			-- New UN_STRIP AST node
		do
			if i /= Void then
				create Result.initialize (i, o, lp_as, rp_as)
			end
		end

	new_unique_as (a_scn: EIFFEL_SCANNER_SKELETON): UNIQUE_AS
			-- New UNIQUE AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_variant_as (t: ID_AS; e: EXPR_AS; k_as: KEYWORD_AS; s_as: SYMBOL_AS): VARIANT_AS
			-- New VARIANT AST node
		do
			if e /= Void then
				create Result.make (t, e, k_as, s_as)
			end
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n, cc: INTEGER; buf: STRING): VERBATIM_STRING_AS
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
				create Result.initialize (s, marker, is_indentable, l, c, p, n, cc)
			end
		end

	new_void_as (a_scn: EIFFEL_SCANNER_SKELETON): VOID_AS
			-- New VOID AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	new_class_list_as (n: INTEGER): CLASS_LIST_AS
			-- New empty list of CLASS_LIST AST node
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_local_dec_list_as (l: EIFFEL_LIST [TYPE_DEC_AS]; k_as: KEYWORD_AS): LOCAL_DEC_LIST_AS
			-- New LOCAL_DEC_LIST AST node
		do
			if l /= Void then
				create Result.make (l, k_as)
			end
		end

	new_formal_argu_dec_list_as (l: EIFFEL_LIST [TYPE_DEC_AS]; l_as, r_as: SYMBOL_AS): FORMAL_ARGU_DEC_LIST_AS
			-- New FORMAL_ARGU_DEC_LIST AST node
		do
			create Result.make (l, l_as, r_as)
		end

	new_key_list_as (l: EIFFEL_LIST [STRING_AS]; l_as, r_as: SYMBOL_AS): KEY_LIST_AS
			-- New KEY_LIST AST node
		do
			create Result.make (l, l_as, r_as)
		end

	new_delayed_actual_list_as (l: EIFFEL_LIST [OPERAND_AS]; l_as, r_as: SYMBOL_AS): DELAYED_ACTUAL_LIST_AS
			-- New DELAYED_ACTUAL_LIST AST node
		do
			create Result.make (l, l_as, r_as)
		end

	new_rename_clause_as (l: EIFFEL_LIST [RENAME_AS]; k_as: KEYWORD_AS): RENAME_CLAUSE_AS
			-- New RENAME_CLAUSE AST node
		do
			if l = Void or else not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_export_clause_as (l: EIFFEL_LIST [EXPORT_ITEM_AS]; k_as: KEYWORD_AS): EXPORT_CLAUSE_AS
			-- New EXPORT_CLAUSE AST node
		do
			if l = Void or else not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_undefine_clause_as (l: EIFFEL_LIST [FEATURE_NAME]; k_as: KEYWORD_AS): UNDEFINE_CLAUSE_AS
			-- New UNDEFINE_CLAUSE AST node
		do
			if l = Void or else not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_redefine_clause_as (l: EIFFEL_LIST [FEATURE_NAME]; k_as: KEYWORD_AS): REDEFINE_CLAUSE_AS
			-- New REDEFINE_CLAUSE AST node
		do
			if l = Void or else not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_select_clause_as (l: EIFFEL_LIST [FEATURE_NAME]; k_as: KEYWORD_AS): SELECT_CLAUSE_AS
			-- New SELECT_CLAUSE AST node
		do
			if l = Void or else not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_creation_constrain_triple (fl: EIFFEL_LIST [FEATURE_NAME]; c_as, e_as: KEYWORD_AS): CREATION_CONSTRAIN_TRIPLE
			-- New CREATION_CONSTRAIN_TRIPLE object
		do
			create Result.make (fl, c_as, e_as)
		end

feature {NONE} -- Implementation

	reusable_string_buffer: STRING
			-- Reusable string buffer to avoid creation of unnecessary string objects
		once
			create Result.make (30)
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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

end -- class AST_FACTORY
