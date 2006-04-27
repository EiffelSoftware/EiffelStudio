indexing
	description: "Editor tokens are created and put into last line."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_WRITER

inherit
	TEXT_FORMATTER
		redefine
			process_string_text,
			process_assertion_tag_text, process_indexing_tag_text,
			process_generic_text, process_character_text, process_local_text,
			process_number_text, process_reserved_word_text,
			process_feature_error, process_feature_dec_item, add_new_line, add_string, add
		end

	EV_SHARED_APPLICATION

create {NONE}

feature {NONE} -- Initialization

	make is
		do
			create last_line.make_empty_line
		end

feature -- Access

	count : INTEGER

	last_line: EIFFEL_EDITOR_LINE

feature -- New line

	new_line is
			-- Create new `last_line'
		do
			create last_line.make_empty_line
		end

feature -- Text processing

	process_basic_text (t: STRING) is
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_TEXT
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_string_text (t: STRING; url: STRING) is
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_STRING
			stone: URL_STONE
		do
			create tok.make (t)
			if url /= Void then
				create stone.make (url)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_comment_text (t: STRING; url: STRING) is
			-- Process comment text.
		local
			tok: EDITOR_TOKEN_COMMENT
			stone: URL_STONE
		do
			create tok.make (t)
			if url /= Void then
				create stone.make (url)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_quoted_text (t: STRING) is
			-- Process the quoted `t' within a comment.
		local
			tok: EDITOR_TOKEN_COMMENT
		do
			create tok.make (text_quoted (t))
			last_line.append_token (tok)
		end

	process_new_line is
			-- Process new line text `t'.
		do
			new_line
		end

	process_indentation (a_indent_depth: INTEGER) is
			-- Process indentation `t'.
		local
			tok: EDITOR_TOKEN_TABULATION
		do
			if a_indent_depth > 0 then
				create tok.make (a_indent_depth)
				last_line.append_token (tok)
			end
		end

	process_symbol_text (t: STRING) is
			-- Process symbol text.
		local
			tok: EDITOR_TOKEN_OPERATOR
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_keyword_text (text: STRING; a_feature: E_FEATURE) is
			-- Process keyword text.
		local
			tok: EDITOR_TOKEN_KEYWORD
			stone: FEATURE_STONE
		do
			create tok.make (text)
			if a_feature /= Void then
				create stone.make (a_feature)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_cluster_name_text (text: STRING; a_cluster: CLUSTER_I; a_quote: BOOLEAN) is
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLUSTER
			stone: CLUSTER_STONE
			l_text: STRING
		do
			if a_quote then
				l_text := text_quoted (text)
			else
				l_text := text
			end
			create tok.make (l_text)
			create stone.make (a_cluster)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end;

	process_class_name_text (text: STRING; a_class: CLASS_I; a_quote: BOOLEAN) is
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CLASSI_STONE
			e_class: CLASS_C
			class_i: CLASS_I
			l_text: STRING
		do
			if a_quote then
				l_text := text_quoted (text)
			else
				l_text := text
			end
			create tok.make (l_text)
			if a_class /= Void then
				class_i := a_class
				e_class := a_class.compiled_class
				if e_class /= Void then
					create {CLASSC_STONE} stone.make (e_class)
				else
					create {CLASSI_STONE} stone.make (class_i)
				end
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_feature_text (text: STRING; a_feature: E_FEATURE; a_quote: BOOLEAN) is
		do
			process_feature_text_internal (text, a_feature, a_quote)
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN) is
		local
			tok: EDITOR_TOKEN_TEXT
			stone: BREAKABLE_STONE
		do
			create tok.make (a_index.out)
			create stone.make (a_feature, a_index)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_name_text (text: STRING; a_class: CLASS_C) is
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_NAME_STONE
		do
			create tok.make (text)
			create stone.make (text, a_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER) is
			-- Process breakpoint.
		local
			stone: BREAKABLE_STONE
		do
			create stone.make (a_feature, a_index)
			last_line.breakpoint_token.set_pebble (stone)
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
			-- Do nothing... The text is now padded by default.
		end

	process_after_class (a_class: CLASS_C) is
			-- Process after class text `t'.
		do
			process_comment_text (" -- class ", Void)
			process_class_name_text (a_class.name_in_upper, a_class.lace_class , false)
			process_new_line
		end

	process_operator_text (t: STRING; a_feature: E_FEATURE) is
			-- Process operator text.
		do
			process_operator_text_internal (t, a_feature)
		end

	process_address_text (a_address, a_name: STRING; a_class: CLASS_C) is
			-- Process address text.
		local
			tok: EDITOR_TOKEN_OBJECT
			stone: OBJECT_STONE
		do
			create tok.make (a_address)
			create stone.make (a_address, a_name, a_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_error_text (t: STRING; a_error: ERROR) is
			-- Process error text.
		local
			tok: EDITOR_TOKEN_ERROR_CODE
			stone: ERROR_STONE
		do
			create tok.make (t)
			create stone.make (a_error)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_error (text: STRING; a_feature: E_FEATURE; a_line: INTEGER) is
			-- Process error text.
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_ERROR_STONE
		do
			create tok.make (text)
			create stone.make (a_feature, a_line)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_cl_syntax (text: STRING; a_syntax_message: SYNTAX_MESSAGE; a_class: CLASS_C) is
			-- Process class syntax text.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CL_SYNTAX_STONE
		do
			create tok.make (text)
			create stone.make (a_syntax_message, a_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_ace_syntax (text: STRING; a_error: SYNTAX_ERROR) is
			-- Process Ace syntax text.
		local
			tok: EDITOR_TOKEN_STRING
			stone: ACE_SYNTAX_STONE
		do
			create tok.make (text)
			create stone.make (a_error)
			last_line.append_token (tok)
		end

	process_assertion_tag_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t)
			tok.set_indexing (False)
			last_line.append_token (tok)
		end

	process_indexing_tag_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t)
			tok.set_indexing (True)
			last_line.append_token (tok)
		end

	process_generic_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_GENERIC
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_character_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_CHARACTER
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_local_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_LOCAL
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_number_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_NUMBER
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_reserved_word_text (t: STRING) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_RESERVED
		do
			create tok.make (t)
			last_line.append_token (tok)
		end

	process_filter_item (text: STRING; a_before: BOOLEAN) is
			-- Process information on filter `text'.
		do
		end

	process_feature_dec_item (text: STRING; is_before: BOOLEAN) is
			-- Process feature dec information.
		local
			tok: EDITOR_TOKEN_FEATURE_START
		do
			if is_before then
				create tok.make (text)
				tok.set_text_color_feature
				last_line.append_token (tok)
			end
		end

	process_before_class (a_class: CLASS_C) is
			-- Process before class `a_class'.
		do
		end

	add_new_line is
			-- Add new line.
		do
			process_new_line
		end

	add (s: STRING) is
			-- Add basic string.
		do
			process_basic_text (s)
		end

	add_string (s: STRING) is
			-- Add string.
		do
			process_string_text (s, Void)
		end

feature {NONE} -- Initialisations and File status

	eol_reached: BOOLEAN;

	process_feature_text_internal (text: STRING; a_feature: E_FEATURE; a_quote: BOOLEAN) is
		local
			tok: EDITOR_TOKEN_FEATURE
			feature_start: EDITOR_TOKEN_FEATURE_START
			stone: FEATURE_STONE
			feature_start_found: BOOLEAN
			editor_tok: EDITOR_TOKEN
			l_text: STRING
		do
			if a_quote then
				l_text := text_quoted (text)
			else
				l_text := text
			end
			create stone.make (a_feature)
			from
				last_line.start
			until
				last_line.after or feature_start_found
			loop
				feature_start ?= last_line.item
				feature_start_found := (feature_start /= Void and then feature_start.pebble = Void)
				if not feature_start_found then
					last_line.forth
				end
			end
			if feature_start_found then
				editor_tok := last_line.item
				if editor_tok.previous /= Void then
					editor_tok.previous.set_next_token (editor_tok.next)
				end
				if editor_tok.next /= Void then
					editor_tok.next.set_previous_token (editor_tok.previous)
				end
				create feature_start.make (l_text)
				feature_start.set_pebble (stone)
				feature_start.set_text_color_feature
				last_line.append_token (feature_start)
			else
				create tok.make (l_text)
				tok.set_pebble (stone)
				last_line.append_token (tok)
			end
		end

	process_operator_text_internal (t: STRING; a_feature: E_FEATURE) is
			-- Process operator text.
		local
			tok: EDITOR_TOKEN
			stone: FEATURE_STONE
			feature_start: EDITOR_TOKEN_FEATURE_START
			feature_start_found: BOOLEAN
			editor_tok: EDITOR_TOKEN
		do
			create stone.make (a_feature)
			from
				last_line.start
			until
				last_line.after or feature_start_found
			loop
				feature_start ?= last_line.item
				feature_start_found := (feature_start /= Void and then feature_start.pebble = Void)
				if not feature_start_found then
					last_line.forth
				end
			end
			if feature_start_found then
				editor_tok := last_line.item
				if editor_tok.previous /= Void then
					editor_tok.previous.set_next_token (editor_tok.next)
				end
				if editor_tok.next /= Void then
					editor_tok.next.set_previous_token (editor_tok.previous)
				end
				create feature_start.make (t)
				feature_start.set_pebble (stone)
				if is_keyword (t) then
					feature_start.set_text_color_feature
				else
					feature_start.set_text_color_operator
				end
				last_line.append_token (feature_start)
			else
				if is_keyword (t) then
					create {EDITOR_TOKEN_KEYWORD}tok.make (t)
				else
					create {EDITOR_TOKEN_OPERATOR}tok.make (t)
				end
				tok.set_pebble (stone)
				last_line.append_token (tok)
			end
		end

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
end -- class EDITOR_TOKEN_WRITER
