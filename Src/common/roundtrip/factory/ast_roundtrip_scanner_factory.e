indexing
	description: "[
					Roundtrip factory used to generate `match_list'.
					Use it with `EIFFEL_ROUNDTRIP_SCANNER' to generate `match_list' only.

					Do not use it to do paring.
				 ]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_SCANNER_FACTORY

inherit
	AST_ROUNDTRIP_LIGHT_FACTORY
		redefine
			create_match_list,
			extend_match_list,
			extend_match_list_with_stub,
			new_character_as,
			new_typed_char_as,
			new_string_as,
			new_verbatim_string_as,
			new_integer_as,
			new_integer_hexa_as,
			new_real_as,
			new_filled_id_as,
			new_filled_bit_id_as,
			new_void_as,
			new_unique_as,
			new_retry_as,
			new_result_as,
			new_boolean_as,
			new_current_as,
			new_deferred_as,
			new_keyword_as,
			new_once_string_keyword_as,
			new_symbol_as,
			new_square_symbol_as,
			create_break_as,
			create_break_as_with_data
		end

feature -- Match list maintainning

	create_match_list (l_size: INTEGER) is
			-- Create a new `match_list' with initial `l_size'.
		do
			create match_list.make (l_size)
			match_list_count := 0
		ensure then
			match_list_not_void: match_list /= Void
		end

	extend_match_list (a_match: LEAF_AS) is
			-- Extend `match_list' with `a_match'.
		require else
			match_list: match_list /= Void
			a_match_not_void: a_match /= Void
		do
			match_list_count := match_list_count + 1
			a_match.set_index (match_list_count)
			match_list.extend (a_match)
		end

	extend_match_list_with_stub (a_stub: LEAF_STUB_AS) is
			-- Extend `internal_match_list' with stub `a_stub',
			-- and set index in `a_match'.
		do
			match_list_count := match_list_count + 1
			a_stub.set_index (match_list_count)
			match_list.extend (a_stub)
		end

feature -- Roundtrip

	new_character_as (c: CHARACTER; l, co, p: INTEGER; a_text: STRING): CHAR_AS is
			-- New CHARACTER AST node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_text.twin, l, co, p, a_text.count))
		end

	new_typed_char_as (t_as: TYPE_AS; c: CHARACTER; l, co, p, n: INTEGER; a_text: STRING): TYPED_CHAR_AS is
			-- New TYPED_CHAR AST node.
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_text.twin, l, co, p, a_text.count))
		end

feature -- Access

	new_string_as (s: STRING; l, c, p, n: INTEGER; buf: STRING): STRING_AS is
			-- New STRING AST node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
		end

	new_verbatim_string_as (s, marker: STRING; is_indentable: BOOLEAN; l, c, p, n: INTEGER; buf: STRING): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_AS is
			-- New INTEGER_AS node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
		end

	new_real_as (t: TYPE_AS; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): REAL_AS is
			-- New REAL AST node
		do
			extend_match_list_with_stub (create {LEAF_STUB_AS}.make (buf.string, l, c, p, n))
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS is
		do
			extend_match_list_with_stub (create {LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_filled_bit_id_as (a_scn: EIFFEL_SCANNER): ID_AS is
			-- New empty ID AST node.
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_void_as (a_scn: EIFFEL_SCANNER): VOID_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_unique_as (a_scn: EIFFEL_SCANNER): UNIQUE_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_retry_as (a_scn: EIFFEL_SCANNER): RETRY_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_result_as (a_scn: EIFFEL_SCANNER): RESULT_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_boolean_as (b: BOOLEAN; a_scn: EIFFEL_SCANNER): BOOL_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_current_as (a_scn: EIFFEL_SCANNER): CURRENT_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_deferred_as (a_scn: EIFFEL_SCANNER): DEFERRED_AS is
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_keyword_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_once_string_keyword_as (a_text: STRING; l, c, p, n: INTEGER): KEYWORD_AS is
			-- New KEYWORD AST node
		do
			extend_match_list_with_stub (create{LEAF_STUB_AS}.make (a_text.string, l, c, p, n))
		end

	new_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node		
		do
			extend_match_list_with_stub (create{SYMBOL_STUB_AS}.make (a_code, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count))
		end

	new_square_symbol_as (a_code: INTEGER; a_scn: EIFFEL_SCANNER): SYMBOL_AS is
			-- New KEYWORD AST node	only for symbol "[" and "]"
		do
			Result := new_symbol_as (a_code, a_scn)
		end

	create_break_as (a_scn: EIFFEL_SCANNER) is
			-- NEw BREAK_AS node
		local
			b_as: BREAK_AS
		do
			create b_as.make (a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			extend_match_list (b_as)
		end

	create_break_as_with_data (a_text: STRING; l, c, p, n: INTEGER) is
			-- New COMMENT_AS node
		local
			b_as: BREAK_AS
		do
			create b_as.make (a_text.string, l, c, p, n)
			extend_match_list (b_as)
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
