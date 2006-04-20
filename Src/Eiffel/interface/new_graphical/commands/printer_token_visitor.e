indexing
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

	text: STRING is
			-- Text genrated.
		deferred
		ensure
			text_not_void: Result /= Void
		end

feature {NONE} -- Visit

	process_editor_token_line_number (a_tok: EDITOR_TOKEN_LINE_NUMBER) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_space (a_tok: EDITOR_TOKEN_SPACE) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_tabulation (a_tok: EDITOR_TOKEN_TABULATION) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_text (a_tok: EDITOR_TOKEN_TEXT) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_comment (a_tok: EDITOR_TOKEN_COMMENT) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_operator (a_tok: EDITOR_TOKEN_OPERATOR) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_keyword (a_tok: EDITOR_TOKEN_KEYWORD) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_character (a_tok: EDITOR_TOKEN_CHARACTER) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_number (a_tok: EDITOR_TOKEN_NUMBER) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_string (a_tok: EDITOR_TOKEN_STRING) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_eol (a_tok: EDITOR_TOKEN_EOL) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_group (a_tok: EDITOR_TOKEN_GROUP) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_symbol (a_tok: EDITOR_TOKEN_SYMBOL) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_breakpoint (a_tok: EDITOR_TOKEN_BREAKPOINT) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_class (a_tok: EDITOR_TOKEN_CLASS) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_cluster (a_tok: EDITOR_TOKEN_CLUSTER) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_error_code (a_tok: EDITOR_TOKEN_ERROR_CODE) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_feature (a_tok: EDITOR_TOKEN_FEATURE) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_feature_start (a_tok: EDITOR_TOKEN_FEATURE_START) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_object (a_tok: EDITOR_TOKEN_OBJECT) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_generic (a_tok: EDITOR_TOKEN_GENERIC) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_local (a_tok: EDITOR_TOKEN_LOCAL) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_reserved (a_tok: EDITOR_TOKEN_RESERVED) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
		end

	process_editor_token_tag (a_tok: EDITOR_TOKEN_TAG) is
		do
			init_tables_with_token (a_tok)
			build_token_text (a_tok)
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

	init_tables_with_token (a_tok: EDITOR_TOKEN) is
			-- Initialize tables with `a_tok'.
			-- `current_color_number' and `current_font_number' will be set.
		local
			l_color: EV_COLOR
			l_font: EV_FONT
		do
			if not a_tok.image.is_empty then
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

	ise_info_lines: ARRAYED_LIST [EDITOR_LINE] is
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

	build_token_text (a_tok: EDITOR_TOKEN) is
			-- Build token text for `a_tok'
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	ise_info: STRING is
		"{
			-- Generated by ISE Eiffel --
			-- For more details: http://www.eiffel.com --
}";

invariant
	print_color_table_not_void: print_color_table /= Void
	print_font_table_not_void: print_font_table /= Void
indexing
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
