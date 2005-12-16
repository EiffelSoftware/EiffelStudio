indexing
	description: "Roundtrip AST factory"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_FACTORY

inherit
	AST_FACTORY
		redefine
			new_internal_match_list,
			extend_internal_match_list,
			clear_internal_match_list,

			new_keyword_as,
			new_symbol_as,
			new_separator_as,
			new_new_line_as,
			new_comment_as,
			new_current_as,
			new_deferred_as,
			new_boolean_as,
			new_result_as,
			new_retry_as,
			new_unique_as,
			new_void_as,
			new_filled_id_as,
			new_class_header_mark_as,

			reverse_extend_separator,
			extend_pre_as,
			extend_post_as,
			reverse_extend_identifier,

			new_character_as, new_typed_char_as,
			set_buffer, append_text_to_buffer,
			new_separator_as_with_data,
			new_comment_as_with_data,
			new_new_line_as_with_data,
			new_once_string_keyword_as,
			new_square_symbol_as,
			new_creation_keyword_as,
			new_end_keyword_as,
			new_frozen_keyword_as,
			new_infix_keyword_as,
			new_precursor_keyword_as,
			new_prefix_keyword_as,
			new_integer_as,
			new_integer_hexa_as,
			new_real_as,
			new_filled_bit_id_as,
			new_string_as,
			new_verbatim_string_as,
			append_string_to_buffer,
			new_bin_and_then_as,
			new_bin_or_else_as,
			new_integer_value,
			new_real_value
		end

feature -- Buffer operation

	set_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON) is
		require else
			a_buf_not_void: a_buf /= Void
		do
			a_buf.clear_all
			a_buf.append (a_scn.text)
		ensure then
			a_buf_set: a_buf.is_equal (a_scn.text)
		end

	append_text_to_buffer (a_buf: STRING; a_scn: YY_SCANNER_SKELETON) is
			-- Append `a_scn'.text to end of buffer `a_buf'.
		require else
			a_buf_not_void: a_buf /= Void
		do
			a_scn.append_text_to_string (a_buf)
		end

	append_string_to_buffer (a_buf: STRING; a_str: STRING) is
			-- Append `a_str' to end of buffer `a_buf'.
		require else
			a_buf_not_void: a_buf /= Void
		do
			a_buf.append (a_str)
		end

feature -- Match list maintaining

	new_internal_match_list (l_size: INTEGER) is
			-- New match list
		do
			create internal_match_list.make (l_size)
		end

	extend_internal_match_list (a_match: LEAF_AS) is
			-- Extend `a_list' with `a_match'.
		require else
			internal_match_list: internal_match_list /= Void
			a_match_not_void: a_match /= Void
		do
			a_match.set_index (internal_match_list.count + 1)
			if internal_match_list.capacity = internal_match_list.count + 1 then
				internal_match_list.grow (internal_match_list.capacity + 5000)
			end
			internal_match_list.extend (a_match)
		end

	clear_internal_match_list is
			-- Set `internal_match_list' with Void to detach the reference to `match_list'.
		do
			internal_match_list := Void
		end

feature

	new_integer_value (a_psr: EIFFEL_PARSER_SKELETON; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): INTEGER_AS is
			--
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
--				a_psr.report_invalid_type_for_integer_error (a_type, buffer)
			end
				-- Remember original token
			token_value := buffer
				-- Remove underscores (if any) without breaking
				-- original token
			if token_value.has ('_') then
				token_value := token_value.twin
				token_value.prune_all ('_')
			end
			if token_value.is_number_sequence then
				Result := new_integer_as (a_type, sign_symbol = '-', token_value, buffer, s_as)
			elseif
				token_value.item (1) = '0' and then
				token_value.item (2).lower = 'x'
			then
				Result := new_integer_hexa_as (a_type, sign_symbol, token_value, buffer, s_as)
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
				Result := new_integer_as (a_type, False, "0", Void, s_as)
			end
			Result.set_position (a_psr.line, a_psr.column, a_psr.position, buffer.count)
		end

	new_real_value (a_psr: EIFFEL_PARSER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): REAL_AS is
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
--				a_psr.report_invalid_type_for_real_error (a_type, buffer)
			end
			if is_signed and sign_symbol = '-' then
				l_buffer := buffer.twin
				buffer.precede ('-')
			else
				l_buffer := buffer
			end
			Result := new_real_as (a_type, buffer, l_buffer, s_as)
			Result.set_position (a_psr.line, a_psr.column, a_psr.position, buffer.count)
		end

feature -- Roundtrip

	new_character_as (c: CHARACTER; l, co, p: INTEGER; a_text: STRING): CHAR_AS is
			-- New CHARACTER AST node
		require else
			a_text_not_void: a_text /= Void
		do
			create Result.initialize (c, l, co, p, 1)
			Result.set_text (a_text.string)
			extend_internal_match_list (Result)
		end

	new_typed_char_as (t_as: TYPE_AS; c: CHARACTER; l, co, p, n: INTEGER; a_text: STRING): TYPED_CHAR_AS is
			-- New TYPED_CHAR AST node.
		require else
			a_text_not_void: a_text /= Void
		do
			create Result.initialize (t_as, c, l, co, p, n)
			Result.set_text (a_text.string)
			extend_internal_match_list (Result)
		end

feature -- Roundtrip

	reverse_extend_separator (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: AST_EIFFEL) is
			-- Add `l_as' into `a_list'.separator_list.
		require else
			a_list_not_void: a_list /= Void
		do
			a_list.reverse_extend_separator (l_as)
		end

	reverse_extend_identifier (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: ID_AS) is
			-- Add `l_as' into `a_list'.
		require else
			a_list_not_void: a_list /= Void
		do
			a_list.reverse_extend (l_as)
		end

	extend_pre_as (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: AST_EIFFEL) is
			-- Extend `l_as' into `a_list'.pre_as_list.
		require else
			a_list_not_void: a_list /= Void
		do
			a_list.extend_pre_as_list (l_as)
		end

	extend_post_as (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: AST_EIFFEL) is
			-- Extend `l_as' into `a_list'.post_as_list.
		require else
			a_list_not_void: a_list /= Void
		do
			a_list.extend_post_as_list (l_as)
		end

feature -- Roundtrip

	new_class_header_mark_as (f_as, e_as, d_as, s_as, ex_as: KEYWORD_AS): CLASS_HEADER_MARK_AS is
			-- New CLASS_HEADER_MARK AST node.
		do
			create Result.make (f_as, e_as, d_as, s_as, ex_as)
		end

feature -- Access

	new_bin_and_then_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_AND_THEN_AS is
			-- New binary and then AST node
		do
			if l /= Void and r /= Void then
				create Result.make (l, r, k_as, s_as)
			end
		end

	new_bin_or_else_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_OR_ELSE_AS is
			-- New binary or else AST node
		do
			if l /= Void and r /= Void then
				create Result.make (l, r, k_as, s_as)
			end
		end

	new_string_as (s: STRING; l, c, p, n: INTEGER; buf: STRING): STRING_AS is
			-- New STRING AST node
		do
			if s /= Void then
				create Result.initialize (s, l, c, p, n)
				Result.set_text (buf.string)
				extend_internal_match_list (Result)
			end
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n: INTEGER; buf: STRING): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		do
			if s /= Void and marker /= Void then
				create Result.initialize (s, marker, is_indentable, l, c, p, n)
				Result.set_text (buf.string)
				extend_internal_match_list (Result)
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS): INTEGER_AS is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_text (buf.string)
				Result.set_sign_symbol (s_as)
				extend_internal_match_list (Result)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS): INTEGER_AS is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_text (buf.string)
				Result.set_sign_symbol (s_as)
				extend_internal_match_list (Result)
			end
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS): REAL_AS is
			-- New REAL AST node
		do
			if v /= Void then
				create Result.make (t, v)
				Result.set_text (buf.string)
				Result.set_sign_symbol (s_as)
				extend_internal_match_list (Result)
			end
		end

	new_filled_id_as (l, c, p, s: INTEGER): ID_AS is
		do

			create Result.make (s)
			Result.set_position (l, c, p, s)
			Result.set_text (Result)
			extend_internal_match_list (Result)
		end

	new_filled_bit_id_as (a_scn: EIFFEL_SCANNER): ID_AS is
			-- New empty ID AST node.
		local
			l_cnt: INTEGER
		do
			l_cnt := a_scn.text_count - 1
			create Result.make (l_cnt)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
			a_scn.append_text_substring_to_string (1, l_cnt, Result)
			Result.set_text (a_scn.text)
			extend_internal_match_list (Result)
		end

	new_void_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): VOID_AS is
		do
			create Result.make_with_location (l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_unique_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): UNIQUE_AS is
		do
			create Result.make_with_location (l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_retry_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): RETRY_AS is
		do
			create Result.make_with_location (l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_result_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): RESULT_AS is
		do
			create Result.make_with_location (l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_boolean_as (b: BOOLEAN; l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): BOOL_AS is
		do
			create Result.initialize (b, l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_current_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): CURRENT_AS is
		do
			create Result.make_with_location (l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_deferred_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): DEFERRED_AS is
		do
			create Result.make_with_location (l, c, p, s)
			Result.set_shared_text (a_scn)
			extend_internal_match_list (Result)
		end

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
			create Result.make (a_code, a_scn)
			extend_internal_match_list (Result)
		end

	new_creation_keyword_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "creation'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_creation, a_scn)
		end

	new_end_keyword_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "end'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_end, a_scn)
		end

	new_frozen_keyword_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "frozen'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_frozen, a_scn)
		end

	new_infix_keyword_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "infix'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_infix, a_scn)
		end

	new_precursor_keyword_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "precursor'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_precursor, a_scn)
		end

	new_prefix_keyword_as (l, c, p, s: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "prefix'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_prefix, a_scn)
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
			create Result.make_with_data ({EIFFEL_TOKENS}.te_once_string, a_text, l, c, p, n)
			extend_internal_match_list (Result)
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node		
		do
			create Result.make (a_code, a_scn)
			extend_internal_match_list (Result)
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node	only for symbol "[" and "]"
		do
			Result := new_symbol_as (a_code, a_scn)
		end

	new_separator_as (a_scn: EIFFEL_SCANNER) is
			-- New KEYWORD AST node		
		local
			s_as: SEPARATOR_AS
		do
			create s_as.make (a_scn)
			extend_internal_match_list (s_as)
		end

	new_separator_as_with_data (a_text: STRING; l, c, p, s: INTEGER) is
			-- New  KEYWORD AST node
		local
			s_as: SEPARATOR_AS
		do
			create s_as.make_with_data (a_text, l, c, p, s)
			extend_internal_match_list (s_as)
		end


	new_new_line_as (a_scn: EIFFEL_SCANNER) is
			-- New KEYWORD AST node		
		local
			n_as: NEW_LINE_AS
		do
			create n_as.make (a_scn)
			extend_internal_match_list (n_as)
		end

	new_new_line_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New KEYWORD AST node		
		local
			n_as: NEW_LINE_AS
		do
			create n_as.make_with_data (a_text.string, l, c, p, n)
			extend_internal_match_list (n_as)
		end


	new_comment_as (a_scn: EIFFEL_SCANNER) is
			-- New COMMENT_AS node
		local
			c_as: COMMENT_AS
		do
			create c_as.make (a_scn)
			extend_internal_match_list (c_as)
		end

	new_comment_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New COMMENT_AS node
		local
			c_as: COMMENT_AS
		do
			create c_as.make_with_data (a_text.string, l, c, p, n)
			extend_internal_match_list (c_as)
		end

end

