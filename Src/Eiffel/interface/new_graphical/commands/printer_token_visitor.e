note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PRINTER_TOKEN_VISITOR

inherit
	EIFFEL_TOKEN_VISITOR

	EB_EDITOR_TOKEN_IDS

	EV_FONT_CONSTANTS

feature -- Access

	text: STRING
			-- Text genrated.
		deferred
		ensure
			text_not_void: Result /= Void
		end

feature {NONE} -- Visit

	process_editor_token_line_number (a_tok: EDITOR_TOKEN_LINE_NUMBER)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_space (a_tok: EDITOR_TOKEN_SPACE)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_tabulation (a_tok: EDITOR_TOKEN_TABULATION)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_text (a_tok: EDITOR_TOKEN_TEXT)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_comment (a_tok: EDITOR_TOKEN_COMMENT)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_operator (a_tok: EDITOR_TOKEN_OPERATOR)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_keyword (a_tok: EDITOR_TOKEN_KEYWORD)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_character (a_tok: EDITOR_TOKEN_CHARACTER)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_number (a_tok: EDITOR_TOKEN_NUMBER)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_string (a_tok: EDITOR_TOKEN_STRING)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_eol (a_tok: EDITOR_TOKEN_EOL)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_group (a_tok: EDITOR_TOKEN_GROUP)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_symbol (a_tok: EDITOR_TOKEN_SYMBOL)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_breakpoint (a_tok: EDITOR_TOKEN_BREAKPOINT)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_class (a_tok: EDITOR_TOKEN_CLASS)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_cluster (a_tok: EDITOR_TOKEN_CLUSTER)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_error_code (a_tok: EDITOR_TOKEN_ERROR_CODE)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_feature (a_tok: EDITOR_TOKEN_FEATURE)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_feature_start (a_tok: EDITOR_TOKEN_FEATURE_START)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_object (a_tok: EDITOR_TOKEN_OBJECT)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_generic (a_tok: EDITOR_TOKEN_GENERIC)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_local (a_tok: EDITOR_TOKEN_LOCAL)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_reserved (a_tok: EDITOR_TOKEN_RESERVED)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_tag (a_tok: EDITOR_TOKEN_TAG)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_target (a_tok: EDITOR_TOKEN_TARGET)
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_glyph (a_tok: EDITOR_TOKEN_GLYPH)
		do

		end

feature {NONE} -- Implementation

	print_color_table: ARRAYED_LIST [EV_COLOR]
			-- Colors that have been found in tokens.
			-- Number coresponding to the table.

	print_font_table: ARRAYED_LIST [EV_FONT]
			-- Fonts that have been found in tokens.
			-- Number coresponding to the table.

	current_color_number: INTEGER
			-- Current color number, after `init_tables_with_token'

	current_font_number: INTEGER
			-- Current font number, after `init_tables_with_token'

	init_tables_with_token (a_tok: EDITOR_TOKEN)
			-- Initialize tables with `a_tok'.
			-- `current_color_number' and `current_font_number' will be set.
		local
			l_color: EV_COLOR
			l_font: EV_FONT
		do
			if not a_tok.wide_image.is_empty then
				l_color := a_tok.text_color
				l_font := a_tok.font

				if print_color_table.has (l_color) then
					current_color_number := print_color_table.index_of (l_color, 1) - 1
				else
					current_color_number := print_color_table.count
					print_color_table.extend (l_color)
				end

				if print_font_table.has (l_font) then
					current_font_number := print_font_table.index_of (l_font, 1) - 1
				else
					current_font_number := print_font_table.count
					print_font_table.extend (l_font)
				end
			end
		end

	ise_info_lines: ARRAYED_LIST [EDITOR_LINE]
			-- Editor lines of ise infomation.
		local
			l_scanner: EDITOR_BASIC_SCANNER
			l_line: EDITOR_LINE
		once
			create l_scanner.make
			l_scanner.execute (ise_info)
			create l_line.make_from_lexer (l_scanner)
			create Result.make (2)
			Result.extend (l_line)
		end

	build_token_text (a_tok: EDITOR_TOKEN)
			-- Build token text for `a_tok'
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	ise_info: STRING =
		"{
			-- Generated by ISE Eiffel --
			-- For more details: http://www.eiffel.com --
}";

invariant
	print_color_table_not_void: print_color_table /= Void
	print_font_table_not_void: print_font_table /= Void
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end
