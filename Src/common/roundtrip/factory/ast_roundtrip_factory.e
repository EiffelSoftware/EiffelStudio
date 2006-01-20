indexing
	description: "Roundtrip AST factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_FACTORY

inherit
	AST_FACTORY
		redefine
			new_internal_match_list,
			clear_internal_match_list,
			new_keyword_as,
			new_symbol_as,
			new_current_as,
			new_deferred_as,
			new_boolean_as,
			new_result_as,
			new_retry_as,
			new_unique_as,
			new_void_as,
			new_filled_id_as,

			reverse_extend_separator,
			extend_pre_as,
			extend_post_as,
			reverse_extend_identifier,

			new_character_as, new_typed_char_as,
			set_buffer, append_text_to_buffer,
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
			new_real_value,
			new_tagged_as,
			new_break_as,
			new_break_as_with_data,
			new_filled_id_as_with_existing_stub
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
			-- Extend `internal_match_list' with `a_match'.
		require else
			internal_match_list: internal_match_list /= Void
			a_match_not_void: a_match /= Void
		do
			if internal_match_list.capacity = internal_match_list.count then
				internal_match_list.grow (internal_match_list.capacity + 5000)
			end
			internal_match_list.extend (a_match)
			a_match.set_index (internal_match_list.count)
		end

	extend_internal_match_list_with_stub (a_match: LEAF_AS; a_stub: LEAF_STUB_AS) is
			-- Extend `internal_match_list' with stub `a_stub',
			-- and set index in `a_match'.
		do
			if internal_match_list.capacity = internal_match_list.count then
				internal_match_list.grow (internal_match_list.capacity + 5000)
			end
			a_stub.set_index (internal_match_list.count + 1)
			internal_match_list.extend (a_stub)
			a_match.set_index (internal_match_list.count)
		end

	clear_internal_match_list is
			-- Set `internal_match_list' with Void to detach the reference to `match_list'.
		do
			internal_match_list := Void
		end

	replace_match_list_item (i: INTEGER; a_leaf: LEAF_AS) is
			-- Replace `i'-th item in `internal_match' by `a_leaf'.
		require else
			a_leaf_not_void: a_leaf /= Void
			index_valid: i >= 1 and i <= internal_match_list.count
		do
			internal_match_list.go_i_th (i)
			internal_match_list.replace (a_leaf)
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
			if is_signed and sign_symbol = '-' then
				l_buffer := buffer.twin
				buffer.precede ('-')
			else
				l_buffer := buffer
			end
			Result := new_real_as (a_type, buffer, a_psr.text, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			Result.set_position (a_psr.line, a_psr.column, a_psr.position, buffer.count)
		end

feature -- Roundtrip

	new_character_as (c: CHARACTER; l, co, p: INTEGER; a_text: STRING): CHAR_AS is
			-- New CHARACTER AST node
		require else
			a_text_not_void: a_text /= Void
		do
			create Result.initialize (c, l, co, p, a_text.count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_text.twin, l, co, p, a_text.count))
		end

	new_typed_char_as (t_as: TYPE_AS; c: CHARACTER; l, co, p, n: INTEGER; a_text: STRING): TYPED_CHAR_AS is
			-- New TYPED_CHAR AST node.
		require else
			a_text_not_void: a_text /= Void
		do
			create Result.initialize (t_as, c, l, co, p, n)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_text.twin, l, co, p, a_text.count))
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
				extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n: INTEGER; buf: STRING): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		do
			if s /= Void and marker /= Void then
				create Result.initialize (s, marker, is_indentable, l, c, p, n)
				extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): REAL_AS is
			-- New REAL AST node
		do
			if v /= Void then
				create Result.make (t, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				extend_internal_match_list_with_stub (Result, create {LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS is
		local
			l_count: INTEGER
			l, c, p: INTEGER
		do
			l := a_scn.line
			c := a_scn.column
			p := a_scn.position
			l_count := a_scn.text_count
			create Result.make (l_count)
			Result.set_position (l, c, p, l_count)
			extend_internal_match_list_with_stub (Result, create {LEAF_STUB_AS}.make (a_scn.text, l, c, p, l_count))
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): ID_AS is
			-- New empty ID AST node.
		do
			create Result.make (a_scn.text_count)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			Result.set_index (a_index)
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
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_void_as (a_scn: EIFFEL_SCANNER): VOID_AS is
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_unique_as (a_scn: EIFFEL_SCANNER): UNIQUE_AS is
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_retry_as (a_scn: EIFFEL_SCANNER): RETRY_AS is
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_result_as (a_scn: EIFFEL_SCANNER): RESULT_AS is
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER): BOOL_AS is
		do
			create Result.initialize (b, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_current_as (a_scn: EIFFEL_SCANNER): CURRENT_AS is
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER): DEFERRED_AS is
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
			create Result.make (a_code, a_scn)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_keyword_as_without_extending_list (a_code:INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node, but don't extend `internal_match_list'.
		do
			create Result.make (a_code, a_scn)
		end

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "creation'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_creation, a_scn)
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "end'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_end, a_scn)
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "frozen'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_frozen, a_scn)
		end

	new_infix_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "infix'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_infix, a_scn)
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "precursor'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_precursor, a_scn)
		end

	new_prefix_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node for keyword "prefix'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_prefix, a_scn)
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
			create Result.make_with_data ({EIFFEL_TOKENS}.te_once_string, a_text, l, c, p, n)
			extend_internal_match_list_with_stub (Result, create{LEAF_STUB_AS}.make (a_text.string, l, c, p, n))
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node		
		do
			create Result.make (a_code, a_scn)
			extend_internal_match_list_with_stub (Result, create{SYMBOL_STUB_AS}.make (a_code, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node	only for symbol "[" and "]"
		do
			Result := new_symbol_as (a_code, a_scn)
		end

	new_break_as (a_scn: EIFFEL_SCANNER) is
			-- NEw BREAK_AS node
		local
			b_as: BREAK_AS
		do
			create b_as.make (a_scn)
			extend_internal_match_list (b_as)
		end

	new_break_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New COMMENT_AS node
		local
			b_as: BREAK_AS
		do
			create b_as.make_with_data (a_text.string, l, c, p, n)
			extend_internal_match_list (b_as)
		end

feature
	new_tagged_as (t: ID_AS; e: EXPR_AS; s_as: SYMBOL_AS): TAGGED_AS is
			-- New TAGGED AST node
		do
			create Result.initialize (t, e, s_as)
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

end

