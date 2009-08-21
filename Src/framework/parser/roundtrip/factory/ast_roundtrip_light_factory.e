note
	description: "[
					AST factory that supports roundtrip facility
					This factory will setup all indexes used by roundtrip parser,
					but it doesn't generate `match_list'.

					Use `AST_ROUNDTRIP_FACTORY' if you want to generate `match_list' while parsing or
					you can use `EIFFEL_ROUNDTRIP_SCANNER' later to generate `match_list' separately.
				 ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_LIGHT_FACTORY

inherit
	AST_FACTORY
		redefine
			create_match_list,
			backup_match_list_count,
			resume_match_list_count,
			new_keyword_as,
			new_keyword_id_as,
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
			reverse_extend_identifier,
			reverse_extend_identifier_separator,

			new_character_as, new_typed_char_as,
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
			new_integer_octal_as,
			new_integer_binary_as,
			new_real_as,
			new_filled_bit_id_as,
			new_string_as,
			new_verbatim_string_as,
			new_bin_and_then_as,
			new_bin_or_else_as,
			new_integer_value,
			new_real_value,
			new_tagged_as,
			create_break_as,
			create_break_as_with_data,
			new_filled_id_as_with_existing_stub
		end

feature -- Match list maintain

	create_match_list (l_size: INTEGER)
			-- Create a new `match_list' with initial `l_size'.
		do
			match_list_count := 0
		ensure then
			match_list_count_set: match_list_count = 0
		end

	increase_match_list_count
			-- Increase count of `match_list' by one.
		do
			match_list_count := match_list_count + 1
		end

	set_match_list_count (a_new_count: INTEGER)
			-- Set `match_list_count' to `a_new_count'.
		require
			a_new_count_valid: a_new_count >= 0
		do
		ensure
			match_list_count_set: match_list_count = a_new_count
		end

	backup_match_list_count
			-- Backup value of `match_list_count' into `match_list_count_backup'.
		do
			 match_list_count_backup := match_list_count
		ensure then
			match_list_count_backup_set: match_list_count_backup = match_list_count
		end

	resume_match_list_count
			-- Resume the value of `match_list_count_backup' and set `match_list_count' with it.
		do
			match_list_count := match_list_count_backup
		ensure then
			match_list_count_resumed: match_list_count = match_list_count_backup
		end

feature -- List operation

	reverse_extend_separator (a_list: EIFFEL_LIST [AST_EIFFEL]; l_as: LEAF_AS)
			-- Add `l_as' into `a_list'.separator_list.
		do
			if a_list /= Void and l_as /= Void then
				a_list.reverse_extend_separator (l_as)
			end
		end

	reverse_extend_identifier (a_list: IDENTIFIER_LIST l_as: ID_AS)
			-- Add `l_as' into `a_list'.
		do
			if a_list /= Void and l_as /= Void then
				a_list.reverse_extend_identifier (l_as)
			end
		end

	reverse_extend_identifier_separator (a_list: IDENTIFIER_LIST; l_as: LEAF_AS)
			-- Add `l_as' into `a_list.separator_list'.
		do
			if a_list /= Void and l_as /= Void then
				a_list.reverse_extend_separator (l_as)
			end
		end

feature -- Leaf nodes

	new_character_as (c: CHARACTER_32; l, co, p, n: INTEGER; a_text: STRING): CHAR_AS
			-- New CHARACTER AST node
		do
			create Result.initialize (c, l, co, p, n)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_typed_char_as (t_as: TYPE_AS; a_char: CHAR_AS): TYPED_CHAR_AS
			-- New TYPED_CHAR AST node.
		do
			if t_as /= Void and a_char /= Void then
				create Result.initialize (t_as, a_char.value, a_char.line, a_char.column, a_char.position, a_char.location_count)
				Result.set_index (a_char.index)
			end
		end

	new_string_as (s: STRING; l, c, p, n: INTEGER; buf: STRING): STRING_AS
			-- New STRING AST node
		do
			if s /= Void then
				create Result.initialize (s, l, c, p, n)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n, cc: INTEGER; buf: STRING): VERBATIM_STRING_AS
			-- New VERBATIM_STRING AST node
		do
			if s /= Void and marker /= Void then
				create Result.initialize (s, marker, is_indentable, l, c, p, n, cc)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_integer_octal_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_octal_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_integer_binary_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_binary_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): REAL_AS
			-- New REAL AST node
		do
			if v /= Void then
				create Result.make (t, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS
		do
			Result := Precursor (a_scn)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): ID_AS
			-- New empty ID AST node.
		local
			l_cnt: INTEGER
			l_str: STRING
		do
			l_cnt := a_scn.text_count
			create l_str.make (l_cnt)
			a_scn.append_text_to_string (l_str)
			create Result.initialize (l_str)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
			Result.set_index (a_index)
		end

	new_filled_bit_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS
			-- New empty ID AST node.
		do
			Result := Precursor (a_scn)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_void_as (a_scn: EIFFEL_SCANNER_SKELETON): VOID_AS
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_unique_as (a_scn: EIFFEL_SCANNER_SKELETON): UNIQUE_AS
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_retry_as (a_scn: EIFFEL_SCANNER_SKELETON): RETRY_AS
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_result_as (a_scn: EIFFEL_SCANNER_SKELETON): RESULT_AS
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER_SKELETON): BOOL_AS
		do
			create Result.initialize (b, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_current_as (a_scn: EIFFEL_SCANNER_SKELETON): CURRENT_AS
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER_SKELETON): DEFERRED_AS
		do
			create Result.make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node
		do
			create Result.make (a_code, a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_keyword_id_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): like keyword_id_type
			-- New KEYWORD AST node
		local
			l_id_as: ID_AS
			l_keyword_as: KEYWORD_AS
			l_cnt: INTEGER_32
			l_str: STRING_8
		do
				-- Create the ID_AS first.
			l_cnt := a_scn.text_count
			l_str := reusable_string_buffer
			l_str.wipe_out
			a_scn.append_text_to_string (l_str)
			create l_id_as.initialize (l_str)
			l_id_as.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)

				-- Create the KEYWORD_AS
			create l_keyword_as.make (a_code, a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)

				-- Since the keyword is sharing the same piece of text as the ID_AS, we share the index.
			increase_match_list_count
			l_id_as.set_index (match_list_count)
			l_keyword_as.set_index (match_list_count)

			Result := [l_keyword_as, l_id_as, a_scn.line, a_scn.column, a_scn.filename]
		end

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "creation'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_creation, a_scn)
		end

	new_end_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "end'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_end, a_scn)
		end

	new_frozen_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "frozen'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_frozen, a_scn)
		end

	new_infix_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "infix'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_infix, a_scn)
		end

	new_precursor_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "precursor'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_precursor, a_scn)
		end

	new_prefix_keyword_as (a_scn: EIFFEL_SCANNER_SKELETON): KEYWORD_AS
			-- New KEYWORD AST node for keyword "prefix'
		do
			Result := new_keyword_as ({EIFFEL_TOKENS}.te_prefix, a_scn)
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS
			-- New KEYWORD AST node
		do
			create Result.make ({EIFFEL_TOKENS}.te_once_string, a_text, l, c, p, n)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): SYMBOL_AS
			-- New KEYWORD AST node		
		do
			create Result.make (a_code, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			increase_match_list_count
			Result.set_index (match_list_count)
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER_SKELETON): SYMBOL_AS
			-- New KEYWORD AST node	only for symbol "[" and "]"
		do
			Result := new_symbol_as (a_code, a_scn)
			Result.set_index (match_list_count)
		end

	create_break_as (a_scn: EIFFEL_SCANNER_SKELETON)
			-- NEw BREAK_AS node
		do
			increase_match_list_count
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n: INTEGER)
			-- New COMMENT_AS node
		do
			increase_match_list_count
		end

feature -- Access

	new_integer_value (a_psr: EIFFEL_SCANNER_SKELETON; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): INTEGER_AS
		local
			token_value: STRING
		do
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
			elseif token_value.count >= 3 and then token_value.item (1) = '0' then
				if token_value.item (2).lower = 'x' then
					Result := new_integer_hexa_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
				elseif token_value.item (2).lower = 'c' then
					Result := new_integer_octal_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
				elseif token_value.item (2).lower = 'b' then
					Result := new_integer_binary_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
				end
			end
		end

	new_real_value (a_psr: EIFFEL_SCANNER_SKELETON; is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): REAL_AS
		local
			l_buffer: STRING
		do
			if is_signed and sign_symbol = '-' then
				l_buffer := buffer.twin
				buffer.precede ('-')
			else
				l_buffer := buffer
			end
			Result := new_real_as (a_type, buffer, a_psr.text, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
		end

	new_bin_and_then_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_AND_THEN_AS
			-- New binary and then AST node
		do
			if l /= Void and r /= Void then
				create Result.make (l, r, k_as, s_as)
			end
		end

	new_bin_or_else_as (l, r: EXPR_AS; k_as, s_as: KEYWORD_AS): BIN_OR_ELSE_AS
			-- New binary or else AST node
		do
			if l /= Void and r /= Void then
				create Result.make (l, r, k_as, s_as)
			end
		end

	new_tagged_as (t: ID_AS; e: EXPR_AS; s_as: SYMBOL_AS): TAGGED_AS
			-- New TAGGED AST node
		do
			create Result.initialize (t, e, s_as)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
