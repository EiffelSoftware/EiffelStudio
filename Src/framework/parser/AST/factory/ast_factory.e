note

	description: "AST node factories. Accepts UTF-8 encoding in STRING_8 instances."

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

	new_string (n: INTEGER): detachable STRING
			-- New STRING object of size `n'.
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		end

feature -- Roundtrip: Match list maintaining

	match_list: detachable LEAF_AS_LIST
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

	reverse_extend_separator (a_list: detachable EIFFEL_LIST [AST_EIFFEL]; l_as: detachable LEAF_AS)
			-- Add `l_as' into `a_list'.separator_list in reverse order.
		do
		end

	reverse_extend_identifier (a_list: detachable IDENTIFIER_LIST; l_as: detachable ID_AS)
			-- Add `l_as' into `a_list.id_list'.
		do
		end

	reverse_extend_identifier_separator (a_list: detachable IDENTIFIER_LIST; l_as: detachable LEAF_AS)
			-- Add `l_as' into `a_list.separator_list'.
		do
		end

feature -- Parser Access

	parser: detachable EIFFEL_SCANNER_SKELETON
			-- Parser used in conjonction with current factory.

	set_parser (v: like parser)
		do
			parser := v
		ensure
			parser_set: parser =v
		end

feature -- Typing

	keyword_id_type: TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: like {ERROR}.file_name]
			-- Type for `new_keyword_id_as'.
		do
			check False then end
		ensure
			is_called: False
		end

	symbol_id_type: TUPLE [symbol: detachable SYMBOL_AS; id: detachable ID_AS; line, column: INTEGER; filename: like {ERROR}.file_name]
			-- Type for `new_symbol_id_as'.
		do
			check False then end
		ensure
			is_called: False
		end

feature -- Access

	new_agent_routine_creation_as (t: detachable OPERAND_AS; f: detachable ID_AS; o: detachable DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: detachable KEYWORD_AS; d_as: detachable SYMBOL_AS): detachable AGENT_ROUTINE_CREATION_AS
			-- New AGENT_ROUTINE_CREATION AST node.
		do
			create Result.make (t, f, o, is_qualified, a_as, d_as)
		end

	new_inline_agent_creation_as (a_b: detachable BODY_AS; a_o: detachable DELAYED_ACTUAL_LIST_AS; a_as: detachable KEYWORD_AS): detachable INLINE_AGENT_CREATION_AS
			-- New INLINE_AGENT_CREATION AST node.
		do
			if a_b /= Void then
				create Result.make (a_b, a_o, a_as)
			end
		end

	new_creation_as (is_active: BOOLEAN; tp: detachable TYPE_AS; tg: detachable ACCESS_AS; c: detachable ACCESS_INV_AS; k_as: detachable KEYWORD_AS): detachable CREATION_AS
			-- New CREATION AST node.
		do
			if tg /= Void then
				create Result.make (is_active, tp, tg, c, k_as)
			end
		end

	new_creation_expr_as (is_active: BOOLEAN; t: detachable TYPE_AS; c: detachable ACCESS_INV_AS; k_as: detachable KEYWORD_AS): detachable CREATION_EXPR_AS
			-- New creation expression AST node
		do
			if t /= Void then
				create Result.make (is_active, t, c, k_as)
			end
		end

	new_assigner_mark_as (k_as: detachable KEYWORD_AS; i_as: detachable ID_AS): detachable PAIR [KEYWORD_AS, ID_AS]
			-- New pair of assigner_mark structure.
		do
			if k_as /= Void and i_as /= Void then
				create Result.make (k_as, i_as)
			end
		end

	new_filled_none_id_as (l, c, p, s, cc, cp, cs: INTEGER): detachable NONE_ID_AS
			-- New empty ID AST node.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cs_non_negative: cs >= 0
		do
			create Result.make
			Result.set_position (l, c, p, s, cc, cp, cs)
		end

	new_constraint_triple (k_as: detachable SYMBOL_AS; t_as: detachable CONSTRAINT_LIST_AS; l_as: detachable CREATION_CONSTRAIN_TRIPLE): detachable CONSTRAINT_TRIPLE
			-- New constraint triple structure.
		do
			create Result.make (k_as, t_as, l_as)
		end

	new_constraining_type (a_type_as: detachable TYPE_AS; a_renameing_clause_as: detachable RENAME_CLAUSE_AS; a_comma_as: detachable KEYWORD_AS): detachable CONSTRAINING_TYPE_AS
			-- New constraining type structure.
		do
			if a_type_as /= Void then
				create Result.make (a_type_as, a_renameing_clause_as, a_comma_as)
			end
		end

	new_eiffel_list_constraining_type_as (n: INTEGER): detachable CONSTRAINT_LIST_AS
			-- New empty list of `CONSTRAINING_TYPE_AS'
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_alias_list (n: INTEGER): CONSTRUCT_LIST [ALIAS_NAME_INFO]
			-- New empty list of ALIAS_TRIPLE
		require
			n_non_negative: n >= 0
		do
			create Result.make (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_alias_name_info (k_as: detachable KEYWORD_AS; n_as: detachable STRING_AS): detachable ALIAS_NAME_INFO
			-- New ALIAS_TRIPLE.
		require
			attached n_as implies not n_as.value_32.is_empty
		do
			if n_as /= Void then
				create Result.make (k_as, n_as)
			end
		end

	new_agent_target_triple (l_as, r_as: detachable SYMBOL_AS; o_as: detachable OPERAND_AS): detachable AGENT_TARGET_TRIPLE
			-- New ALIAS_NAME_INFO.
		do
			create Result.make (l_as, r_as, o_as)
		end

	new_keyword_instruction_list_pair (k_as: detachable KEYWORD_AS; i_as: detachable EIFFEL_LIST [INSTRUCTION_AS]): detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
			-- New ALIST_TRIPLE.
		do
			if k_as /= Void and i_as /= Void then
				create Result.make (k_as, i_as)
			end
		end

	new_keyword_string_pair (k_as: detachable KEYWORD_AS; s_as: detachable STRING_AS): detachable PAIR [KEYWORD_AS, STRING_AS]
			-- New keyword string pair.
		do
			if k_as /= Void and s_as /= Void then
				create Result.make (k_as, s_as)
			end
		end

	new_invariant_pair (k_as: detachable KEYWORD_AS; i_as: detachable EIFFEL_LIST [TAGGED_AS]): detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]
			-- New PAIR for a keyword and a tagged_as list.
		do
			if k_as /= Void then
				create Result.make (k_as, i_as)
			end
		end

	new_exit_condition_pair (u: detachable KEYWORD_AS; e: detachable EXPR_AS): detachable PAIR [KEYWORD_AS, EXPR_AS]
			-- New PAIR for an exit condition of a loop
		do
			if u /= Void and e /= Void then
				create Result.make (u, e)
			end
		end

	new_typed_char_as (t_as: detachable TYPE_AS; a_char: detachable CHAR_AS): detachable TYPED_CHAR_AS
			-- New TYPED_CHAR AST node.
		do
			if t_as /= Void and then a_char /= Void then
				create Result.initialize (t_as, a_char.value, a_char.line, a_char.column, a_char.position, a_char.location_count,
					a_char.character_column, a_char.character_position, a_char.character_count)
			end
		end

	new_line_pragma (a_scn: EIFFEL_SCANNER_SKELETON): detachable BREAK_AS
			-- New line pragma
			--| Keep entire line, actual processing will be done later if we need it.
		do
			create Result.make (a_scn.utf8_text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

feature -- Access for Errors

	new_vtgc1_error (a_line: INTEGER; a_column: INTEGER; a_filename: like {ERROR}.file_name; a_type: TYPE_AS): ERROR
			-- New vtgc1 error.
		require
			a_type_attached: attached a_type
		do
			create {SYNTAX_ERROR} Result.make (a_line, a_column, a_filename, "Error VTGC1: Anchored types are not allowed in a constraint:%N  %"" + a_type.dump + "%"")
		end

	new_vvok1_error (a_line: INTEGER; a_column: INTEGER; a_filename: like {ERROR}.file_name; a_once_as: FEATURE_AS): ERROR
			-- New VVOK1 error.
		require
			a_once_as_not_void: a_once_as /= Void
		local
			l_identifier: detachable STRING
		do
			if attached match_list as l_match_list then
				l_identifier := a_once_as.text (l_match_list)
			end
			if l_identifier = Void then
				l_identifier := "Unknown identifier"
			end
			create {SYNTAX_ERROR} Result.make (a_line, a_column, a_filename, "Error VVOK1: Conflict in once's keys of routine %"" + l_identifier + "%"")
		end

	new_vvok2_error (a_line: INTEGER; a_column: INTEGER; a_filename: like {ERROR}.file_name; a_once_as: FEATURE_AS): ERROR
			-- New VVOK2 error.
		require
			a_once_as_not_void: a_once_as /= Void
		local
			l_identifier: detachable STRING
		do
			if attached match_list as l_match_list then
				l_identifier := a_once_as.text (l_match_list)
			end
			if l_identifier = Void then
				l_identifier := "Unknown identifier"
			end
			create {SYNTAX_ERROR} Result.make (a_line, a_column, a_filename,
				"Error VVOK2: Unsupported once key in routine %""+ l_identifier +"%"%N(only %"PROCESS%", %"THREAD%", %"OBJECT%" are supported for now).")
		end


feature -- Value AST creation

	new_character_value_as (a_psr: EIFFEL_SCANNER_SKELETON; buffer: STRING; roundtrip_buffer: STRING): detachable CHAR_AS
			-- New character value for a numerical character representation (i.e. '%/001/').
		require
			buffer_not_void: buffer /= Void
			buffer_not_empty: not buffer.is_empty
			a_text_not_void: roundtrip_buffer /= Void
			a_psr_not_void: a_psr /= Void
		local
			l_integer: detachable INTEGER_AS
			u: UTF_CONVERTER
		do
				-- Would be nice to not have to create a INTEGER_AS to get the character value.
			l_integer := new_temporary_integer_value (a_psr, '+', buffer)
			if l_integer /= Void then
				if l_integer.natural_64_value <= {NATURAL_32}.Max_value then
					Result := new_character_as (l_integer.natural_32_value.to_character_32, a_psr.line, a_psr.column, a_psr.position, roundtrip_buffer.count,
					a_psr.character_column, a_psr.character_position, u.utf_8_to_string_32_count (roundtrip_buffer.area, 0, roundtrip_buffer.count - 1),
					roundtrip_buffer)
				else
					a_psr.report_character_code_too_large_error (buffer)
							-- Dummy code (for error recovery) follows:
					Result := new_character_as ('a', 0, 0, 0, 0, 0, 0, 0, roundtrip_buffer)
				end
			else
					-- Dummy code since integer value could not be computed.
				Result := new_character_as ('a', 0, 0, 0, 0, 0, 0, 0, roundtrip_buffer)
			end
		end

	new_temporary_integer_value (a_psr: EIFFEL_SCANNER_SKELETON; sign_symbol: CHARACTER; buffer: READABLE_STRING_8): detachable INTEGER_AS
				-- Useful to create a INTEGER_AS anhd get the associated numeric value.
		do
			backup_match_list_count
			disable_match_list_extension
			Result := new_integer_value (a_psr, sign_symbol, Void, buffer, Void)
			enable_match_list_extension
			resume_match_list_count
		end

	new_integer_value (a_psr: EIFFEL_SCANNER_SKELETON; sign_symbol: CHARACTER; a_type: detachable TYPE_AS; buffer: READABLE_STRING_8; s_as: detachable SYMBOL_AS): detachable INTEGER_AS
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
					Result := new_integer_as (a_type, sign_symbol = '-', token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count,
						a_psr.character_column, a_psr.character_position, a_psr.unicode_text_count)
				elseif token_value.count >= 3 and then token_value.item (1) = '0' then
					if token_value.item (2).lower = 'x' then
						Result := new_integer_hexa_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count,
							a_psr.character_column, a_psr.character_position, a_psr.unicode_text_count)
					elseif token_value.item (2).lower = 'c' then
						Result := new_integer_octal_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count,
							a_psr.character_column, a_psr.character_position, a_psr.unicode_text_count)
					elseif token_value.item (2).lower = 'b' then
						Result := new_integer_binary_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count,
							a_psr.character_column, a_psr.character_position, a_psr.unicode_text_count)
					end
				end
				if Result = Void or else not Result.is_initialized then
					if sign_symbol = '-' then
							-- Add `-' for a better reporting.
						a_psr.report_integer_too_small_error (a_type, "-" + buffer)
					else
						a_psr.report_integer_too_large_error (a_type, buffer)
					end
						-- Dummy code (for error recovery) follows:
					Result := new_integer_as (a_type, False, "0", Void, s_as, 0, 0, 0, 0, 0, 0, 0)
				end
			end
		end

	new_real_value (a_psr: EIFFEL_SCANNER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: detachable TYPE_AS; buffer: READABLE_STRING_8; s_as: detachable SYMBOL_AS): detachable REAL_AS
			-- New real value.
		require
			buffer_not_void: buffer /= Void
			a_psr_not_void: a_psr /= Void
		local
			l_buffer: READABLE_STRING_8
		do
			validate_integer_real_type (a_psr, a_type, buffer, False)
			if is_valid_integer_real then
				if is_signed and sign_symbol = '-' then
					l_buffer := "-" + buffer
				else
					l_buffer := buffer
				end
				Result := new_real_as (a_type, l_buffer, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count,
					a_psr.character_column, a_psr.character_position, a_psr.unicode_text_count)
			end
		end

feature {NONE} -- Validation

	validate_integer_real_type (a_psr: EIFFEL_SCANNER_SKELETON; a_type: detachable TYPE_AS; buffer: READABLE_STRING_8; for_integer: BOOLEAN)
			-- New integer value.
		require
			buffer_not_void: buffer /= Void
			a_psr_not_void: a_psr /= Void
		do
				-- We cannot validate the name easily, so we assume it is correct.
			is_valid_integer_real := True
		end

	is_valid_integer_real: BOOLEAN
			-- Was last call to `validate_integer_real_type' successful?

feature -- Validation

	validate_non_conforming_inheritance_type (a_psr: EIFFEL_PARSER_SKELETON; a_type: detachable TYPE_AS)
			-- Validate `a_type' for non-conforming inheritance.
		require
			a_psr_not_void: a_psr /= Void
		do
			-- We can assume that it is valid
		end

feature -- Roundtrip: leaf_as

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_keyword_id_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable like keyword_id_type
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

	new_feature_keyword_as (l, c, p, s, cc, cp, cs:INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "feature".
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cs_non_negative: cs >= 0
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (l, c, p, s, cc, cp, cs)
		end

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "creation'
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_creation, a_scn)
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "end'
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_end, a_scn)
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "frozen'
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_frozen, a_scn)
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable KEYWORD_AS
			-- New KEYWORD AST node for keyword "precursor'.
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_precursor, a_scn)
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n, cc, cp, cn: INTEGER): detachable KEYWORD_AS
			-- New KEYWORD AST node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable SYMBOL_AS
			-- New symbol AST node for all Eiffel symbols except ";", "[" and "]"
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make (a_code, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_symbol_id_as (c: INTEGER; s: EIFFEL_SCANNER_SKELETON): detachable like symbol_id_type
			-- New tuple with a symbol and an id for the current token (free operator).
		require
			attached s
			valid_code:
				c = {EIFFEL_TOKENS}.te_at or
				c = {EIFFEL_TOKENS}.te_block_close or
				c = {EIFFEL_TOKENS}.te_block_open or
				c = {EIFFEL_TOKENS}.te_exists or
				c = {EIFFEL_TOKENS}.te_forall or
				c = {EIFFEL_TOKENS}.te_repeat_open or
				c = {EIFFEL_TOKENS}.te_repeat_close
		do
			Result := [new_symbol_as (c, s), new_filled_id_as (s), s.line, s.column, s.filename]
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): detachable SYMBOL_AS
			-- New symbol AST node only for symbol "[" and "]"
		require
			a_scn_not_void: a_scn /= Void
			a_code_is_squre: a_code = {EIFFEL_TOKENS}.te_lsqure or a_code = {EIFFEL_TOKENS}.te_rsqure
		do
			Result := new_symbol_as (a_code, a_scn)
		end

	create_break_as (a_scn: EIFFEL_SCANNER_SKELETON)
			-- NEw BREAK_AS node
		do
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n, cc, cp, cn: INTEGER)
			-- New COMMENT_AS node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
			a_text_not_void: a_text /= Void
		do
		end

feature -- Access

	new_access_assert_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS): detachable ACCESS_ASSERT_AS
			-- New ACCESS_ASSERT AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_feat_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS): detachable ACCESS_FEAT_AS
			-- New ACCESS_FEAT AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_id_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS): detachable ACCESS_ID_AS
			-- New ACCESS_ID AST node
		do
			if f /= Void then
				create Result.initialize (f, p)
			end
		end

	new_access_inv_as (f: detachable ID_AS; p: detachable PARAMETER_LIST_AS; k_as: detachable SYMBOL_AS): detachable ACCESS_INV_AS
			-- New ACCESS_INV AST node
		do
			if f /= Void then
				create Result.make (f, p, k_as)
			end
		end

	new_address_as (f: detachable FEATURE_NAME; a_as: detachable SYMBOL_AS): detachable ADDRESS_AS
			-- New ADDRESS AST node
		do
			if f /= Void then
				create Result.initialize (f, a_as)
			end
		end

	new_address_current_as (other: detachable CURRENT_AS; a_as: detachable SYMBOL_AS): detachable ADDRESS_CURRENT_AS
			-- New ADDRESS_CURRENT AST node
		do
			if other /= Void then
				create Result.initialize (other, a_as)
			end
		end

	new_address_result_as (other: detachable RESULT_AS; a_as: detachable SYMBOL_AS): detachable ADDRESS_RESULT_AS
			-- New ADDRESS_RESULT AST node
		do
			if other /= Void then
				create Result.initialize (other, a_as)
			end
		end

	new_all_as (a_as: detachable KEYWORD_AS): detachable ALL_AS
			-- New ALL AST node
		do
			create Result.initialize (a_as)
		end

	new_array_as (exp: detachable EIFFEL_LIST [EXPR_AS]; l_as, r_as: detachable SYMBOL_AS): detachable ARRAY_AS
			-- New Manifest ARRAY AST node
		do
			if exp /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_assign_as (t: detachable ACCESS_AS; s: detachable EXPR_AS; a_as: detachable SYMBOL_AS): detachable ASSIGN_AS
			-- New ASSIGN AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_assigner_call_as (t: detachable EXPR_AS; s: detachable EXPR_AS; a_as: detachable SYMBOL_AS): detachable ASSIGNER_CALL_AS
			-- New ASSIGNER CALL AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_attribute_as (c: detachable EIFFEL_LIST [INSTRUCTION_AS]; k_as: detachable KEYWORD_AS): detachable ATTRIBUTE_AS
			-- New ATTRIBUTE AST node
		do
			create Result.make (c, k_as)
		end

	new_bin_and_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_AND_AS
			-- New binary and AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_and_then_as (l, r: detachable EXPR_AS; k_as, s_as: detachable KEYWORD_AS): detachable BIN_AND_THEN_AS
			-- New binary and then AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, Void)
			end
		end

	new_bin_div_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_DIV_AS
			-- New binary // AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_eq_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_EQ_AS
			-- New binary = AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_free_as (l: detachable EXPR_AS; op: detachable ID_AS; r: detachable EXPR_AS): detachable BIN_FREE_AS
			-- New BIN_FREE AST node
		do
			if l /= Void and r /= Void and op /= Void then
				create Result.initialize (l, op, r)
			end
		end

	new_bin_ge_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_GE_AS
			-- New binary >= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_gt_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_GT_AS
			-- New binary > AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_implies_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_IMPLIES_AS
			-- New binary implies AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_le_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_LE_AS
			-- New binary <= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_lt_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_LT_AS
			-- New binary < AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_minus_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_MINUS_AS
			-- New binary - AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_mod_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_MOD_AS
			-- New binary \\ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_ne_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_NE_AS
			-- New binary /= AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_not_tilde_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_NOT_TILDE_AS
			-- New binary /~ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_or_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_OR_AS
			-- New binary or AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_or_else_as (l, r: detachable EXPR_AS; k_as, s_as: detachable KEYWORD_AS): detachable BIN_OR_ELSE_AS
			-- New binary or else AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, Void)
			end
		end

	new_bin_plus_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_PLUS_AS
			-- New binary + AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_power_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_POWER_AS
			-- New binary ^ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_slash_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_SLASH_AS
			-- New binary / AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_star_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_STAR_AS
			-- New binary * AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_tilde_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_TILDE_AS
			-- New binary ~ AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bin_xor_as (l, r: detachable EXPR_AS; o: detachable LEAF_AS): detachable BIN_XOR_AS
			-- New binary xor AST node
		do
			if l /= Void and r /= Void then
				create Result.initialize (l, r, o)
			end
		end

	new_bracket_as (t: detachable EXPR_AS; o: detachable EIFFEL_LIST [EXPR_AS]; l_as, r_as: detachable SYMBOL_AS): detachable BRACKET_AS
			-- New BRACKET AST node
		do
			if t /= Void and (o /= Void and then not o.is_empty)  then
				create Result.make (t, o, l_as, r_as)
			end
		end

	new_body_as (a: detachable FORMAL_ARGU_DEC_LIST_AS; t: detachable TYPE_AS; r: detachable ID_AS; c: detachable CONTENT_AS; c_as: detachable SYMBOL_AS; k_as: detachable LEAF_AS; a_as: detachable KEYWORD_AS; i_as: detachable INDEXING_CLAUSE_AS): detachable BODY_AS
			-- New BODY AST node
		do
			create Result.initialize (a, t, r, c, c_as, k_as, a_as, i_as)
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER_SKELETON): detachable BOOL_AS
			-- New BOOLEAN AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.initialize (b, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_built_in_as (l: detachable EXTERNAL_LANG_AS; a: detachable STRING_AS; e_as, a_as: detachable KEYWORD_AS): detachable BUILT_IN_AS
			-- New BUILT_IN AST node
		do
			if l /= Void then
				create Result.initialize (l, a, e_as, a_as)
			end
		end

	new_case_as (i: detachable EIFFEL_LIST [INTERVAL_AS]; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; w_as, t_as: detachable KEYWORD_AS): detachable CASE_AS
			-- New WHEN AST node
		do
			if i /= Void then
				create Result.make (i, c, w_as, t_as)
			end
		end

	new_case_expression_as (i: detachable EIFFEL_LIST [INTERVAL_AS]; e: detachable EXPR_AS; w, t: detachable KEYWORD_AS): detachable CASE_EXPRESSION_AS
			-- New WHEN expression AST node.
		do
			if attached i and then attached e then
				create Result.make (i, e, w, t)
			end
		end

	new_character_as (c: CHARACTER_32; l, co, p, n, cc, cp, cn: INTEGER; a_text: STRING): detachable CHAR_AS
			-- New CHARACTER AST node
		require
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
		do
			create Result.initialize (c, l, co, p, n, cc, cp, cn)
		end

	new_check_as (c: detachable EIFFEL_LIST [TAGGED_AS]; c_as, e: detachable KEYWORD_AS): detachable CHECK_AS
			-- New CHECK AST node
		do
			if e /= Void then
				create Result.initialize (c, c_as, e)
			end
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
			-- New CLASS AST node.
		do
			if n /= Void and s /= Void and (co = Void or else not co.is_empty) and ed /= Void then
				create Result.initialize (n, ext_name, is_d, is_e, is_fc, is_ex, is_par, is_o, top_ind,
				bottom_ind, g, cp, ncp, c, co, f, inv, s, o, ed)
			end
		end

	new_class_type_as (n: detachable ID_AS; g: detachable TYPE_LIST_AS): detachable CLASS_TYPE_AS
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

	set_expanded_class_type (a_type: detachable TYPE_AS; is_expanded: BOOLEAN; s_as: detachable KEYWORD_AS)
			-- Set expanded status of `a_type' if it is an instance of CLASS_TYPE_AS.
		do
			if
				is_expanded and then
				attached {CLASS_TYPE_AS} a_type as l_class_type
			then
				l_class_type.set_is_expanded (True, s_as)
			end
		end

	new_named_tuple_type_as (n: detachable ID_AS; p: detachable FORMAL_ARGU_DEC_LIST_AS): detachable NAMED_TUPLE_TYPE_AS
			-- New TUPLE_TYPE AST node
		do
			if n /= Void and (p /= Void and then p.arguments /= Void) then
				create Result.initialize (n, p)
			end
		end

	new_client_as (c: detachable CLASS_LIST_AS): detachable CLIENT_AS
			-- New CLIENT AST node
		do
			if c /= Void and then not c.is_empty then
				create Result.initialize (c)
			end
		end

	new_constant_as (a: detachable ATOMIC_AS): detachable CONSTANT_AS
			-- New CONSTANT_AS node
		do
			if a /= Void then
				create Result.initialize (a)
			end
		end

	new_convert_feat_as (cr: BOOLEAN; fn: detachable FEATURE_NAME; t: detachable TYPE_LIST_AS; l_as, r_as, c_as, lc_as, rc_as: detachable SYMBOL_AS): detachable CONVERT_FEAT_AS
			-- New convert feature entry AST node.
		do
			if fn /= Void and (t /= Void and then not t.is_empty) then
				create Result.initialize (cr, fn, t, l_as, r_as, c_as, lc_as, rc_as)
			end
		end

	new_create_as (c: detachable CLIENT_AS; f: detachable EIFFEL_LIST [FEATURE_NAME]; c_as: detachable KEYWORD_AS): detachable CREATE_AS
			-- New creation clause AST node
		do
			create Result.initialize (c, f, c_as)
		end

	new_current_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable CURRENT_AS
			-- New CURRENT AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_custom_attribute_as (c: detachable CREATION_EXPR_AS; t: detachable TUPLE_AS; k_as: detachable KEYWORD_AS): detachable CUSTOM_ATTRIBUTE_AS
			-- Create a new UNIQUE AST node.
		do
			if c /= Void then
				create Result.initialize (c, t, k_as)
			end
		end

	new_debug_as (k: detachable KEY_LIST_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: detachable KEYWORD_AS): detachable DEBUG_AS
			-- New DEBUG AST node
		do
			if e /= Void then
				create Result.initialize (k, c, d_as, e)
			end
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable DEFERRED_AS
			-- New DEFERRED AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_do_as (c: detachable EIFFEL_LIST [INSTRUCTION_AS]; k_as: detachable KEYWORD_AS): detachable DO_AS
			-- New DO AST node
		do
			create Result.make (c, k_as)
		end

	new_eiffel_list_atomic_as (n: INTEGER): detachable EIFFEL_LIST [ATOMIC_AS]
			-- New empty list of ATOMIC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_case_as (n: INTEGER): detachable EIFFEL_LIST [CASE_AS]
			-- New empty list of CASE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies (Result.capacity = n and Result.all_default)
		end

	new_eiffel_list_case_expression_as (n: INTEGER): detachable EIFFEL_LIST [CASE_EXPRESSION_AS]
			-- New empty list of `{CASE_EXPRESSION_AS}`.
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: attached Result implies (Result.capacity = n and Result.all_default)
		end

	new_eiffel_list_convert (n: INTEGER): detachable CONVERT_FEAT_LIST_AS
			-- New empty list of CONVERT_FEAT_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_create_as (n: INTEGER): detachable EIFFEL_LIST [CREATE_AS]
			-- New empty list of CREATE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_elseif_as (n: INTEGER): detachable EIFFEL_LIST [ELSIF_AS]
			-- New empty list of ELSIF_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_elseif_expression_as (n: INTEGER): detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]
			-- New empty list of {ELSIF_EXPRESSION_AS} with capacity `n'.
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_export_item_as (n: INTEGER): detachable EIFFEL_LIST [EXPORT_ITEM_AS]
			-- New empty list of EXPORT_ITEM_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_expr_as (n: INTEGER): detachable EIFFEL_LIST [EXPR_AS]
			-- New empty list of PARAMETER_LIST_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_parameter_list_as (l: detachable EIFFEL_LIST [EXPR_AS]; lp_as, rp_as: detachable SYMBOL_AS): detachable PARAMETER_LIST_AS
			-- New empty list of EXPR_AS
		do
			if l /= Void then
				create Result.initialize (l, lp_as, rp_as)
			end
		end

	new_eiffel_list_feature_as (n: INTEGER): detachable EIFFEL_LIST [FEATURE_AS]
			-- New empty list of FEATURE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_clause_as (n: INTEGER): detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- New empty list of FEATURE_CLAUSE_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_name (n: INTEGER): detachable EIFFEL_LIST [FEATURE_NAME]
			-- New empty list of FEATURE_NAME
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_feature_name_id (n: INTEGER): detachable EIFFEL_LIST [FEAT_NAME_ID_AS]
			-- New empty list of `{FEATURE_NAME_ID_AS}`.
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_formal_dec_as (n: INTEGER): detachable FORMAL_GENERIC_LIST_AS
			-- New empty list of FORMAL_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_id_as (n: INTEGER): detachable EIFFEL_LIST [ID_AS]
			-- New empty list of ID_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_indexing_clause_as (n: INTEGER): detachable INDEXING_CLAUSE_AS
			-- New empty list of INDEX_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_instruction_as (n: INTEGER): detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- New empty list of INSTRUCTION_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_interval_as (n: INTEGER): detachable EIFFEL_LIST [INTERVAL_AS]
			-- New empty list of INTERVAL_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_named_expression_as (n: INTEGER): detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]
			-- New empty list of `{NAMED_EXPRESSION_AS}'.
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_operand_as (n: INTEGER): detachable EIFFEL_LIST [OPERAND_AS]
			-- New empty list of OPERAND_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_parent_as (n: INTEGER): detachable PARENT_LIST_AS
			-- New empty list of PARENT_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_rename_as (n: INTEGER): detachable EIFFEL_LIST [RENAME_AS]
			-- New empty list of RENAME_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_string_as (n: INTEGER): detachable EIFFEL_LIST [STRING_AS]
			-- New empty list of STRING_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_tagged_as (n: INTEGER): detachable EIFFEL_LIST [TAGGED_AS]
			-- New empty list of TAGGED_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_type (n: INTEGER): detachable TYPE_LIST_AS
			-- New empty list of TYPE
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_list_dec_as (n: INTEGER): detachable LIST_DEC_LIST_AS
			-- New empty list of LIST_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_eiffel_list_type_dec_as (n: INTEGER): detachable TYPE_DEC_LIST_AS
			-- New empty list of TYPE_DEC_AS
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_elseif_as (e: detachable EXPR_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; l_as, t_as: detachable KEYWORD_AS): detachable ELSIF_AS
			-- New ELSIF AST node
		do
			if e /= Void then
				create Result.initialize (e, c, l_as, t_as)
			end
		end

	new_elseif_expression_as (c: detachable EXPR_AS; e: detachable EXPR_AS; l_as, t_as: detachable KEYWORD_AS): detachable ELSIF_EXPRESSION_AS
			-- New ELSIF_EXPRESSION AST node with condition `c', value `e', "elseif" keyword `l_as' and "then" keyword `t_as'.
		do
			if attached c and attached e then
				create Result.initialize (c, e, l_as, t_as)
			end
		end

	new_ensure_as (a: detachable EIFFEL_LIST [TAGGED_AS]; c: BOOLEAN; k_as: detachable KEYWORD_AS): detachable ENSURE_AS
			-- New ENSURE AST node
		do
			create Result.make (a, c, k_as)
		end

	new_ensure_then_as (a: detachable EIFFEL_LIST [TAGGED_AS]; c: BOOLEAN; k_as, l_as: detachable KEYWORD_AS): detachable ENSURE_THEN_AS
			-- New ENSURE THEN AST node
		do
			create Result.make (a, c, k_as, l_as)
		end

	new_export_item_as (c: detachable CLIENT_AS; f: detachable FEATURE_SET_AS): detachable EXPORT_ITEM_AS
			-- New EXPORT_ITEM AST node
		do
			if c /= Void then
				create Result.initialize (c, f)
			end
		end

	new_expr_address_as (e: detachable EXPR_AS; a_as, l_as, r_as: detachable SYMBOL_AS): detachable EXPR_ADDRESS_AS
			-- New EXPR_ADDRESS AST node
		do
			if e /= Void then
				create Result.initialize (e, a_as, l_as, r_as)
			end
		end

	new_expr_call_as (c: detachable CALL_AS): detachable EXPR_CALL_AS
			-- New EXPR_CALL AST node
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_external_as (l: detachable EXTERNAL_LANG_AS; a: detachable STRING_AS; e_as, a_as: detachable KEYWORD_AS): detachable EXTERNAL_AS
			-- New EXTERNAL AST node
		do
			if l /= Void then
				create Result.initialize (l, a, e_as, a_as)
			end
		end

	new_external_lang_as (l: detachable STRING_AS): detachable EXTERNAL_LANG_AS
			-- New EXTERNAL_LANGUAGE AST node
		do
			if l /= Void then
				create Result.initialize (l)
			end
		end

	new_feature_as (f: detachable EIFFEL_LIST [FEATURE_NAME]; b: detachable BODY_AS; i: detachable INDEXING_CLAUSE_AS; next_pos: INTEGER): detachable FEATURE_AS
			-- New FEATURE AST node
		do
			if
				(f /= Void and then not f.is_empty) and b /= Void
			then
				create Result.initialize (f, b, i, 0, next_pos)
			end
		end

	new_feature_clause_as (c: detachable CLIENT_AS; f: detachable EIFFEL_LIST [FEATURE_AS]; l: detachable KEYWORD_AS; ep: INTEGER): detachable FEATURE_CLAUSE_AS
			-- New FEATURE_CLAUSE AST node
		do
			if f /= Void and l /= Void then
				create Result.initialize (c, f, l, ep)
			end
		end

	new_feature_list_as (f: detachable EIFFEL_LIST [FEATURE_NAME]): detachable FEATURE_LIST_AS
			-- New FEATURE_LIST AST node
		do
			if f /= Void then
				create Result.initialize (f)
			end
		end

	new_feature_name_alias_as (feature_name: detachable ID_AS; a_alias_list: detachable LIST [ALIAS_NAME_INFO]; c_as: detachable KEYWORD_AS): detachable FEATURE_NAME_ALIAS_AS
			-- New FEATURE_NAME_ALIAS AST node
		require
			alias_list_not_empty: attached a_alias_list implies not a_alias_list.is_empty
			has_alias_name:
				attached a_alias_list implies
				across a_alias_list as a all not a.item.alias_name.value_32.is_empty end
			no_alias_duplicates:
				attached a_alias_list implies
				across a_alias_list as x all across a_alias_list as y all
					x.item.alias_name.value_32.same_string (y.item.alias_name.value_32) implies x.target_index = y.target_index
				end end
		do
			if feature_name /= Void and then a_alias_list /= Void and then not a_alias_list.is_empty then
				create Result.initialize_with_list (feature_name, a_alias_list, c_as)
			end
		end

	new_feature_name_id_as (f: detachable ID_AS): detachable FEAT_NAME_ID_AS
			-- New FEAT_NAME_ID AST node
		do
			if f /= Void then
				create Result.initialize (f)
			end
		end

	new_formal_as (n: detachable ID_AS; is_ref, is_exp, is_frozen: BOOLEAN; r_as: detachable KEYWORD_AS): detachable FORMAL_AS
			-- New FORMAL AST node
		do
			if n /= Void then
				create Result.initialize (n, is_ref, is_exp, is_frozen, r_as)
			end
		end

	new_formal_dec_as (f: detachable FORMAL_AS; c: detachable CONSTRAINT_LIST_AS; cf: detachable EIFFEL_LIST [FEAT_NAME_ID_AS]; c_as: detachable SYMBOL_AS; ck_as, ek_as: detachable KEYWORD_AS): detachable FORMAL_DEC_AS
			-- New FORMAL_DECLARATION AST node
		do
			if f /= Void then
				create Result.initialize (f, c, cf, c_as, ck_as, ek_as)
			end
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable ID_AS
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
			a_scn.append_utf8_text_to_string (l_str)
			create Result.initialize (l_str)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): detachable ID_AS
			-- New empty ID AST node.
		require
			a_scn_not_void: a_scn /= Void
		do
			Result := new_filled_id_as (a_scn)
		end

	new_guard_as (c: detachable KEYWORD_AS; a: detachable EIFFEL_LIST [TAGGED_AS]; t: detachable KEYWORD_AS;
	              l: detachable EIFFEL_LIST [INSTRUCTION_AS]; e: detachable KEYWORD_AS): detachable GUARD_AS
			-- New CHECK with body AST node
		do
			create Result.initialize (c, a, t, l, e)
		end

	new_identifier_list (n: INTEGER): detachable IDENTIFIER_LIST
			-- New ARRAYED_LIST [INTEGER]
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		end

	new_if_as (cnd: detachable EXPR_AS; cmp: detachable EIFFEL_LIST [INSTRUCTION_AS];
			ei: detachable EIFFEL_LIST [ELSIF_AS]; e: detachable EIFFEL_LIST [INSTRUCTION_AS];
			end_location, i_as, t_as, e_as: detachable KEYWORD_AS): detachable IF_AS

			-- New IF AST node
		do
			if cnd /= Void and end_location /= Void then
				create Result.initialize (cnd, cmp, ei, e, end_location, i_as, t_as, e_as)
			end
		end

	new_if_expression_as (c: detachable EXPR_AS; t: detachable EXPR_AS;
			ei: detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]; e: detachable EXPR_AS;
			end_location, i_as, t_as, e_as: detachable KEYWORD_AS): detachable IF_EXPRESSION_AS
			-- New IF_EXPRESSION AST node with condition `c', Then_part `t', Elseif_part ei, Else_part `e',
			-- "end" keyword `end_location', "if", "then" and "else" keywords `i_as', `t_as', `e_as'.
		do
			if attached c and then attached t and then attached e and then attached end_location then
				create Result.initialize (c, t, ei, e, end_location, i_as, t_as, e_as)
			end
		end

	new_index_as (t: detachable ID_AS; i: detachable EIFFEL_LIST [ATOMIC_AS]; c_as: detachable SYMBOL_AS): detachable INDEX_AS
			-- Create a new INDEX AST node.
		do
			if i /= Void then
				create Result.initialize (t, i, c_as)
			end
		end

	new_inspect_as (s: detachable EXPR_AS; c: detachable EIFFEL_LIST [CASE_AS];
			e: detachable EIFFEL_LIST [INSTRUCTION_AS]; end_location, i_as, e_as: detachable  KEYWORD_AS): detachable INSPECT_AS

			-- New INSPECT AST node
		do
			if s /= Void and end_location /= Void then
				create Result.make (s, c, e, end_location, i_as, e_as)
			end
		end

	new_inspect_expression_as (s: detachable EXPR_AS; c: detachable EIFFEL_LIST [CASE_EXPRESSION_AS];
			e: detachable EXPR_AS; end_location, i_as, e_as: detachable  KEYWORD_AS): detachable INSPECT_EXPRESSION_AS
			-- New INSPECT expression AST node
		do
			if attached s and attached end_location then
				create Result.make (s, c, e, end_location, i_as, e_as)
			end
		end

	new_instr_call_as (c: detachable CALL_AS): detachable INSTR_CALL_AS
			-- New INSTR_CALL AST node
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_integer_as (t: detachable TYPE_AS; s: BOOLEAN; v: detachable STRING; buf: detachable READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_integer_hexa_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_integer_octal_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_octal_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_integer_binary_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_binary_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_interval_as (l, u: detachable ATOMIC_AS; d_as: detachable SYMBOL_AS): detachable INTERVAL_AS
			-- New INTERVAL AST node
		do
			if l /= Void then
				create Result.initialize (l, u, d_as)
			end
		end

	new_invariant_as (a: detachable EIFFEL_LIST [TAGGED_AS]; once_manifest_string_count: INTEGER; i_as: detachable KEYWORD_AS; object_test_locals: detachable ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]): detachable INVARIANT_AS
			-- New INVARIANT AST node
		require
			valid_once_manifest_string_count: once_manifest_string_count >= 0
		do
			create Result.initialize (a, once_manifest_string_count, i_as, object_test_locals)
		end

	new_iteration_as (a: detachable KEYWORD_AS; e: detachable EXPR_AS; b: detachable KEYWORD_AS; i: detachable ID_AS; is_restricted: BOOLEAN): detachable ITERATION_AS
			-- New ITERATION AST node for an iteration part of a loop in the form
			-- 	across expr as x -- when `not is_resticted`
			-- 	across expr is x -- when `is_resticted`
		do
			if e /= Void and i /= Void then
				create Result.make_keyword (a, e, b, i, is_restricted)
			end
		end

	new_symbolic_iteration_as (i: detachable ID_AS; a: detachable SYMBOL_AS; e: detachable EXPR_AS; b: detachable SYMBOL_AS): detachable ITERATION_AS
			-- New ITERATION AST node for an iteration part of a loop in the form
			-- "`i` ∈ `e` |"
		do
			if attached i and attached e then
				create Result.make_symbolic (i, a, e, b)
			end
		end

	new_like_id_as (a: detachable ID_AS; l_as: detachable KEYWORD_AS): detachable LIKE_ID_AS
			-- New LIKE_ID AST node
		do
			if a /= Void then
				create Result.initialize (a, l_as)
			end
		end

	new_like_current_as (other: detachable CURRENT_AS; l_as: detachable KEYWORD_AS): detachable LIKE_CUR_AS
			-- New LIKE_CURRENT AST node
		do
			if other /= Void then
				create Result.make (other, l_as)
			end
		end

	new_location_as (l, c, p, s, cc, cp, cs: INTEGER): detachable LOCATION_AS
			-- New LOCATION_AS
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			s_non_negative: s >= 0
		do
			create Result.make (l, c, p, s, cc, cp, cs)
		end

	new_loop_as (t: detachable ITERATION_AS; f: detachable EIFFEL_LIST [INSTRUCTION_AS]; i: detachable EIFFEL_LIST [TAGGED_AS];
			v: detachable VARIANT_AS; s: detachable EXPR_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS];
			e, f_as, i_as, u_as, l_as: detachable KEYWORD_AS; r, bc: detachable SYMBOL_AS): detachable LOOP_AS
			-- New LOOP AST node
		do
			if (t /= Void or s /= Void) and (attached e or attached bc) then
				create Result.initialize (t, f, i, v, s, c, e, f_as, i_as, u_as, l_as, r, bc)
			end
		end

	new_loop_expr_as (f: detachable ITERATION_AS; w: detachable KEYWORD_AS; i: detachable EIFFEL_LIST [TAGGED_AS];
			u: detachable KEYWORD_AS; c: detachable EXPR_AS; q: detachable KEYWORD_AS; s: detachable SYMBOL_AS; a: BOOLEAN; e: detachable EXPR_AS; v: detachable VARIANT_AS; k: detachable KEYWORD_AS): detachable LOOP_EXPR_AS
			-- New LOOP expression AST node
		do
			if f /= Void and then e /= Void then
				create Result.initialize (f, w, i, u, c, q, s, a, e, v, k)
			end
		end

	new_named_expression_as (e: detachable EXPR_AS; a: detachable KEYWORD_AS; n: detachable ID_AS): detachable NAMED_EXPRESSION_AS
			-- New `{NAMED_EXPRESSION_AS}' node.
		do
			if attached e and then attached n then
				create Result.make (e, a, n)
			end
		end

	new_nested_expr_as (t: detachable EXPR_AS; m: detachable ACCESS_FEAT_AS; d_as: detachable SYMBOL_AS): detachable NESTED_EXPR_AS
			-- New NESTED_EXPR CALL AST node
		do
			if t /= Void and m /= Void then
				create Result.initialize (t, m, d_as)
			end
		end

	new_none_type_as (c: detachable ID_AS): detachable NONE_TYPE_AS
			-- New type AST node for "NONE"
		do
			if c /= Void then
				create Result.initialize (c)
			end
		end

	new_object_test_as (l_attached: detachable KEYWORD_AS; type: detachable TYPE_AS; expression: detachable EXPR_AS; l_as: detachable KEYWORD_AS; name: detachable ID_AS): detachable OBJECT_TEST_AS
			-- New OBJECT_TEST_AS node
		do
			if expression /= Void then
				create Result.make (l_attached, type, expression, l_as, name)
			end
		end

	new_old_syntax_object_test_as (start: detachable SYMBOL_AS; name: detachable ID_AS; type: detachable TYPE_AS; expression: detachable EXPR_AS): detachable OBJECT_TEST_AS
			-- New OBJECT_TEST_AS node
		do
			if name /= Void and type /= Void and expression /= Void then
				create Result.make_curly (start, name, type, expression)
			end
		end

	new_once_as (o: detachable KEYWORD_AS; k: detachable KEY_LIST_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]): detachable ONCE_AS
			-- New ONCE AST node
		do
			create Result.make (o, k, c)
		end

	new_operand_as (c: detachable TYPE_AS; e: detachable EXPR_AS): detachable OPERAND_AS
			-- New OPERAND AST node
		do
			create Result.initialize (c, e)
		end

	new_paran_as (e: detachable EXPR_AS; l_as, r_as: detachable SYMBOL_AS): detachable PARAN_AS
			-- New PARAN AST node
		do
			if e /= Void then
				create Result.initialize (e, l_as, r_as)
			end
		end

	new_parent_as (t: detachable CLASS_TYPE_AS; rn: detachable RENAME_CLAUSE_AS;
			e: detachable EXPORT_CLAUSE_AS; u: detachable UNDEFINE_CLAUSE_AS;
			rd: detachable REDEFINE_CLAUSE_AS; s: detachable SELECT_CLAUSE_AS; ed: detachable KEYWORD_AS): detachable PARENT_AS

			-- New PARENT AST node
		do
			if t /= Void then
				create Result.initialize (t, rn, e, u, rd, s, ed)
			end
		end

	new_precursor_as (pk: detachable KEYWORD_AS; n: detachable CLASS_TYPE_AS; p: detachable PARAMETER_LIST_AS): detachable PRECURSOR_AS
			-- New PRECURSOR AST node
		do
			if pk /= Void and (n /= Void implies n.generics = Void) then
				create Result.initialize (pk, n, p)
			end
		end

	new_qualified_anchored_type (t: detachable TYPE_AS; d: detachable SYMBOL_AS; f: detachable ID_AS): detachable QUALIFIED_ANCHORED_TYPE_AS
			-- New QUALIFIED_ANCHORED_TYPE AST node for an anchored type of the form "t.f" where "t" is known to be an anchored type.
		require
			attached t implies (attached {LIKE_CUR_AS} t or attached {LIKE_ID_AS} t)
		do
			if attached t and attached f then
				create Result.make_anchored (t, d, f)
			end
		end

	new_qualified_anchored_type_with_type (l: detachable KEYWORD_AS; t: detachable TYPE_AS; d: detachable SYMBOL_AS; f: detachable ID_AS): detachable QUALIFIED_ANCHORED_TYPE_AS
			-- New QUALIFIED_ANCHORED_TYPE AST node for an anchored type of the form "like {t}.f".
		do
			if attached t and attached f then
				create Result.make_explicit (l, t, d, f)
			end
		end

	new_real_as (t: detachable TYPE_AS; v: detachable READABLE_STRING_8; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable REAL_AS
			-- New REAL AST node
		do
			if v /= Void then
				create Result.make (t, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_rename_as (o, n: detachable FEATURE_NAME; k_as: detachable KEYWORD_AS): detachable RENAME_AS
			-- New RENAME_PAIR AST node
		do
			if o /= Void and n /= Void then
				create Result.initialize (o, n, k_as)
			end
		end

	new_require_as (a: detachable EIFFEL_LIST [TAGGED_AS]; k_as: detachable KEYWORD_AS): detachable REQUIRE_AS
			-- New REQUIRE AST node
		do
			create Result.make (a, k_as)
		end

	new_require_else_as (a: detachable EIFFEL_LIST [TAGGED_AS]; k_as, l_as: detachable KEYWORD_AS): detachable REQUIRE_ELSE_AS
			-- New REQUIRE ELSE AST node
		do
			create Result.make (a, k_as, l_as)
		end

	new_result_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable RESULT_AS
			-- New RESULT AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_retry_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable RETRY_AS
			-- New RETRY AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_reverse_as (t: detachable ACCESS_AS; s: detachable EXPR_AS; a_as: detachable SYMBOL_AS): detachable REVERSE_AS
			-- New assignment attempt AST node
		do
			if t /= Void and s /= Void then
				create Result.initialize (t, s, a_as)
			end
		end

	new_routine_as (o: detachable STRING_AS; pr: detachable REQUIRE_AS;
			l: detachable LOCAL_DEC_LIST_AS; b: detachable ROUT_BODY_AS; po: detachable ENSURE_AS;
			r: detachable EIFFEL_LIST [INSTRUCTION_AS]; end_loc: detachable KEYWORD_AS;
			oms_count, a_pos: INTEGER; k_as, r_as: detachable KEYWORD_AS;
			object_test_locals: detachable ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]];
			n, a, u: BOOLEAN): detachable ROUTINE_AS
			-- New ROUTINE AST node.
		require
			valid_oms_count: oms_count >= 0
			a_pos_positive: a_pos > 0
		do
			if b /= Void and end_loc /= Void then
				create Result.initialize (o, pr, l, b, po, r, end_loc, oms_count, a_pos, k_as, r_as, object_test_locals, n, a, u)
			end
		end

	new_separate_instruction_as (s: detachable KEYWORD_AS; a: detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]; d: detachable KEYWORD_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; e: detachable KEYWORD_AS): detachable SEPARATE_INSTRUCTION_AS
			-- New `{SEPARATE_INSTRUCTION_AS}' node.
		do
			if attached a and then attached e then
				create Result.make (s, a, d, c, e)
			end
		end

	new_static_access_as (c: detachable TYPE_AS; f: detachable ID_AS; p: detachable PARAMETER_LIST_AS; f_as: detachable KEYWORD_AS; d_as: detachable SYMBOL_AS): detachable STATIC_ACCESS_AS
			-- New STATIC_ACCESS AST node
		do
			if c /= Void and f /= Void then
				create Result.initialize (c, f, p, f_as, d_as)
			end
		end

	new_string_as (s: detachable STRING; l, c, p, n, cc, cp, cn: INTEGER; buf: STRING): detachable STRING_AS
			-- New STRING AST node
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			if s /= Void then
				create Result.initialize (s, l, c, p, n, cc, cp, cn)
			end
		end

	new_tagged_as (t: detachable ID_AS; e: detachable EXPR_AS; c: detachable KEYWORD_AS; s_as: detachable SYMBOL_AS): detachable TAGGED_AS
			-- New TAGGED AST node
		do
			if attached c then
				create Result.make_class (t, c, s_as)
			elseif t /= Void or e /= Void then
				create Result.initialize (t, e, s_as)
			end
		end

	new_tuple_as (exp: detachable EIFFEL_LIST [EXPR_AS]; l_as: detachable SYMBOL_AS; r_as: detachable SYMBOL_AS): detachable TUPLE_AS
			-- New Manifest TUPLE AST node
		do
			if exp /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_list_dec_as (i: detachable IDENTIFIER_LIST): detachable LIST_DEC_AS
			-- New TYPE_DEC AST node
		do
			if attached i then
				create Result.initialize (i)
			end
		end

	new_type_dec_as (i: detachable IDENTIFIER_LIST; t: detachable TYPE_AS; c_as: detachable SYMBOL_AS): detachable TYPE_DEC_AS
			-- New TYPE_DEC AST node
		do
			if i /= Void and t /= Void then
				create Result.initialize (i, t, c_as)
			end
		end

	new_type_expr_as (t: detachable TYPE_AS): detachable TYPE_EXPR_AS
			-- New TYPE_EXPR AST node
		do
			if t /= Void then
				create Result.initialize (t)
			end
		end

	new_un_free_as (op: detachable ID_AS; e: detachable EXPR_AS): detachable UN_FREE_AS
			-- New UN_FREE AST node
		do
			if op /= Void and e /= Void then
				create Result.initialize (op, e)
			end
		end

	new_un_minus_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_MINUS_AS
			-- New unary - AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_not_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_NOT_AS
			-- New unary not AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_old_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_OLD_AS
			-- New unary old AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_plus_as (e: detachable EXPR_AS; o: detachable LEAF_AS): detachable UN_PLUS_AS
			-- New unary + AST node
		do
			if e /= Void then
				create Result.initialize (e, o)
			end
		end

	new_un_strip_as (i: detachable IDENTIFIER_LIST; o: detachable KEYWORD_AS; lp_as, rp_as: detachable SYMBOL_AS): detachable UN_STRIP_AS
			-- New UN_STRIP AST node
		do
			if i /= Void then
				create Result.initialize (i, o, lp_as, rp_as)
			end
		end

	new_unique_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable UNIQUE_AS
			-- New UNIQUE AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_variant_as (t: detachable ID_AS; e: detachable EXPR_AS; k_as: detachable KEYWORD_AS; s_as: detachable SYMBOL_AS): detachable VARIANT_AS
			-- New VARIANT AST node
		do
			create Result.make (t, e, k_as, s_as)
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n, cc, cp, cn, common_columns: INTEGER; buf: STRING): detachable VERBATIM_STRING_AS
			-- New VERBATIM_STRING AST node
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
		do
			create Result.initialize (s, marker, is_indentable, l, c, p, n, cc, cp, cn, common_columns)
		end

	new_void_as (a_scn: EIFFEL_SCANNER_SKELETON): detachable VOID_AS
			-- New VOID AST node
		require
			a_scn_not_void: a_scn /= Void
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count,
				a_scn.character_column, a_scn.character_position, a_scn.unicode_text_count)
		end

	new_class_list_as (n: INTEGER): detachable CLASS_LIST_AS
			-- New empty list of CLASS_LIST AST node
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled (n)
		ensure
			list_full: Result /= Void implies Result.capacity = n and Result.all_default
		end

	new_local_dec_list_as (l: detachable EIFFEL_LIST [LIST_DEC_AS]; k_as: detachable KEYWORD_AS): detachable LOCAL_DEC_LIST_AS
			-- New LOCAL_DEC_LIST AST node
		do
			if l /= Void then
				create Result.make (l, k_as)
			end
		end

	new_formal_argu_dec_list_as (l: detachable EIFFEL_LIST [TYPE_DEC_AS]; l_as, r_as: detachable SYMBOL_AS): detachable FORMAL_ARGU_DEC_LIST_AS
			-- New FORMAL_ARGU_DEC_LIST AST node
		do
			if l /= Void then
				create Result.make (l, l_as, r_as)
			end
		end

	new_key_list_as (l: detachable EIFFEL_LIST [STRING_AS]; l_as, r_as: detachable SYMBOL_AS): detachable KEY_LIST_AS
			-- New KEY_LIST AST node
		do
			if l /= Void then
				create Result.make (l, l_as, r_as)
			end
		end

	new_delayed_actual_list_as (l: detachable EIFFEL_LIST [OPERAND_AS]; l_as, r_as: detachable SYMBOL_AS): detachable DELAYED_ACTUAL_LIST_AS
			-- New DELAYED_ACTUAL_LIST AST node
		do
			if l /= Void then
				create Result.make (l, l_as, r_as)
			end
		end

	new_rename_clause_as (l: detachable EIFFEL_LIST [RENAME_AS]; k_as: detachable KEYWORD_AS): detachable RENAME_CLAUSE_AS
			-- New RENAME_CLAUSE AST node
		do
			if l /= Void then
				create Result.make (l, k_as)
			end
		end

	new_export_clause_as (l: detachable EIFFEL_LIST [EXPORT_ITEM_AS]; k_as: detachable KEYWORD_AS): detachable EXPORT_CLAUSE_AS
			-- New EXPORT_CLAUSE AST node
		do
			if l /= Void and then not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_undefine_clause_as (l: detachable EIFFEL_LIST [FEATURE_NAME]; k_as: detachable KEYWORD_AS): detachable UNDEFINE_CLAUSE_AS
			-- New UNDEFINE_CLAUSE AST node
		do
			if l /= Void and then not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_redefine_clause_as (l: detachable EIFFEL_LIST [FEATURE_NAME]; k_as: detachable KEYWORD_AS): detachable REDEFINE_CLAUSE_AS
			-- New REDEFINE_CLAUSE AST node
		do
			if l /= Void and then not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_select_clause_as (l: detachable EIFFEL_LIST [FEATURE_NAME]; k_as: detachable KEYWORD_AS): detachable SELECT_CLAUSE_AS
			-- New SELECT_CLAUSE AST node
		do
			if l /= Void and then not l.is_empty then
				create Result.make (l, k_as)
			end
		end

	new_creation_constrain_triple (fl: detachable EIFFEL_LIST [FEAT_NAME_ID_AS]; c_as, e_as: detachable KEYWORD_AS): detachable CREATION_CONSTRAIN_TRIPLE
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
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: very long class"
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
