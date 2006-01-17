indexing
	description: "Translators of STRUCTURED_TEXTs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRUCTURED_TEXT_TRANSLATOR

inherit
	TEXT_FORMATTER
		redefine
			process_text, process_string_text,
			process_assertion_tag_text, process_indexing_tag_text,
			process_generic_text, process_character_text, process_local_text,
			process_number_text, process_reserved_word_text,
			process_feature_error
		end

feature {NONE} -- Initialization

	make is
		do
			after := True
		end

feature -- Access

	last_line: EIFFEL_EDITOR_LINE

feature -- End of file

	after: BOOLEAN

feature -- Basic Operations

	start  is
		do
			current_text.start
			after := current_text.after
		end

	process_line is
		local
			text_item: TEXT_ITEM
		do
			from
				eol_reached := False
				create last_line.make_empty_line
			until
				eol_reached or else after
			loop
				text_item := current_text.item
				text_item.append_to (Current)
				current_text.forth
				after := current_text.after
			end
			last_line.update_token_information
		end

feature -- Text processing

	process_text (a_text: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		do
			Precursor {TEXT_FORMATTER} (a_text)
		end

	process_basic_text (t: BASIC_TEXT) is
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_TEXT
		do
			create tok.make (t.image )
			last_line.append_token (tok)
		end

	process_string_text (t: STRING_TEXT) is
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_STRING
			url: URL_STRING_TEXT
			stone: URL_STONE
		do
			create tok.make (t.image)
			url ?= t
			if url /= Void then
				create stone.make (url.link)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_comment_text (t: COMMENT_TEXT) is
			-- Process comment text. 
		local
			tok: EDITOR_TOKEN_COMMENT
			url: URL_STRING_TEXT
			stone: URL_STONE
		do
			create tok.make (t.image)
			url ?= t
			if url /= Void then
				create stone.make (url.link)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_quoted_text (t: QUOTED_TEXT) is
			-- Process the quoted `t' within a comment.
		local
			tok: EDITOR_TOKEN_COMMENT
		do			
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_new_line (t: NEW_LINE_ITEM) is
			-- Process new line text `t'.
		do
			eol_reached := True
		end

	process_indentation (t: INDENT_TEXT) is
			-- Process indentation `t'.
		local
			tok: EDITOR_TOKEN_TABULATION
		do
			create tok.make (t.indent_depth)
			last_line.append_token (tok)
		end

	process_symbol_text (t: SYMBOL_TEXT) is
			-- Process symbol text.
		local
			tok: EDITOR_TOKEN_OPERATOR
		do
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_keyword_text (t: KEYWORD_TEXT) is
			-- Process keyword text.
		local
			tok: EDITOR_TOKEN_KEYWORD
			ft: FEATURE_TEXT
			stone: FEATURE_STONE
		do
			create tok.make (t.image)
			ft ?= t
			if ft /= Void then
				create stone.make (ft.e_feature)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_cluster_name_text (t: CLUSTER_NAME_TEXT) is
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLUSTER
			stone: CLUSTER_STONE
		do
			create tok.make (t.image)
			create stone.make (t.cluster_i)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end;

	process_class_name_text (t: CLASS_NAME_TEXT) is
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CLASSI_STONE
			e_class: CLASS_C
			class_i: CLASS_I
		do
			create tok.make (t.image)
			class_i := t.class_i
			e_class := class_i.compiled_class
			if e_class /= Void then
				create {CLASSC_STONE} stone.make (e_class)
			else
				create {CLASSI_STONE} stone.make (class_i)
			end
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_text (t: FEATURE_TEXT) is
		local
			tok: EDITOR_TOKEN_FEATURE
			feature_start: EDITOR_TOKEN_FEATURE_START
			stone: FEATURE_STONE
			feature_start_found: BOOLEAN
			editor_tok: EDITOR_TOKEN
		do
			create stone.make (t.e_feature)
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
				create feature_start.make (t.image)
				feature_start.set_pebble (stone)
				feature_start.set_text_color_feature
				last_line.append_token (feature_start)
			else
				create tok.make (t.image)
				tok.set_pebble (stone)
				last_line.append_token (tok)
			end
		end

	process_breakpoint_index (t: BREAKPOINT_TEXT) is
		local
			tok: EDITOR_TOKEN_TEXT
			stone: BREAKABLE_STONE
		do
			create tok.make (t.image)
			create stone.make (t.e_feature, t.index)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_name_text (t: FEATURE_NAME_TEXT) is
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_NAME_STONE
		do
			create tok.make (t.image)
			create stone.make (t.image, t.e_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process breakpoint.
		local
			tok: EDITOR_TOKEN_BREAKPOINT
			stone: BREAKABLE_STONE
		do
			create tok.make
			create stone.make (a_bp.e_feature, a_bp.index)
			tok.set_pebble (stone)
			last_line.breakpoint_token.set_pebble (stone)
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
			-- Do nothing... The text is now padded by default.
		end

	process_after_class (t: AFTER_CLASS) is
			-- Process after class text `t'.
		local
			comment_item: COMMENT_TEXT
			class_item: CLASS_NAME_TEXT
		do
			create comment_item.make (" -- class ")
			process_comment_text (comment_item)
			create class_item.make (t.e_class.name_in_upper, t.e_class.lace_class)
			process_class_name_text (class_item)
			process_new_line (create {NEW_LINE_ITEM}.make)
		end

	process_operator_text (t: OPERATOR_TEXT) is
			-- Process operator text.
		local
			tok: EDITOR_TOKEN_OPERATOR
			stone: FEATURE_STONE
			feature_start: EDITOR_TOKEN_FEATURE_START
			feature_start_found: BOOLEAN
			editor_tok: EDITOR_TOKEN
		do
			create stone.make (t.e_feature)
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
				create feature_start.make (t.image)
				feature_start.set_pebble (stone)
				feature_start.set_text_color_operator
				last_line.append_token (feature_start)
			else
				create tok.make (t.image)
				tok.set_pebble (stone)
				last_line.append_token (tok)
			end
		end

	process_address_text (t: ADDRESS_TEXT) is
			-- Process address text.
		local
			tok: EDITOR_TOKEN_OBJECT
			stone: OBJECT_STONE
		do
			create tok.make (t.address)
			create stone.make (t.address, t.name, t.e_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)

--				-- Add the address to the kept objects.
--			kept_objects.extend (t.address)
		end

	process_error_text (t: ERROR_TEXT) is
			-- Process error text.
		local
			tok: EDITOR_TOKEN_ERROR_CODE
			stone: ERROR_STONE
		do
			create tok.make (t.error_text)
			create stone.make (t.error)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_error (t: FEATURE_ERROR_TEXT) is
			-- Process error text.
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_ERROR_STONE
		do
			create tok.make (t.image)
			create stone.make (t.e_feature, t.line)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_cl_syntax (t: CL_SYNTAX_ITEM) is
			-- Process class syntax text.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CL_SYNTAX_STONE
		do
			create tok.make (t.error_text)
			create stone.make (t.syntax_message, t.e_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_ace_syntax (t: ACE_SYNTAX_ITEM) is
			-- Process Ace syntax text.
		local
			tok: EDITOR_TOKEN_STRING
			stone: ACE_SYNTAX_STONE
		do
			create tok.make (t.error_text)
			create stone.make (t.syntax_error)
--			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_assertion_tag_text (t: ASSERTION_TAG_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t.image)
			tok.set_indexing (False)
			last_line.append_token (tok)
		end

	process_indexing_tag_text (t: INDEXING_TAG_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t.image)
			tok.set_indexing (True)
			last_line.append_token (tok)
		end

	process_generic_text (t: GENERIC_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_GENERIC
		do
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_character_text (t: CHARACTER_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_CHARACTER
		do
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_local_text (t: LOCAL_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_LOCAL
		do
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_number_text (t: NUMBER_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_NUMBER
		do
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_reserved_word_text (t: RESERVED_WORD_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_RESERVED
		do
			create tok.make (t.image)
			last_line.append_token (tok)
		end

	process_filter_item (text: FILTER_ITEM) is
			-- Process information on syntax `text'.
		local
			l_feature_dec_item: FEATURE_DEC_ITEM
			tok: EDITOR_TOKEN_FEATURE_START
		do
			l_feature_dec_item ?= text
			if l_feature_dec_item /= Void then
				if l_feature_dec_item.is_before then
					create tok.make (l_feature_dec_item.feature_name)
					tok.set_text_color_feature
					last_line.append_token (tok)
				end
			end
		end

	process_before_class (text: BEFORE_CLASS) is
			-- Process before class `t'.
		do
		end

feature -- Obsolete

	put_new_line is do end

	put_char (c: CHARACTER) is do end

	put_string (s: STRING) is
		local
			tok: EDITOR_TOKEN_TEXT
		do
			create tok.make (s)
			last_line.append_token (tok)
		end

feature -- Properties

	current_text: STRUCTURED_TEXT
			-- Current edited text. Void if no structured text is displayed.

feature {NONE} -- Initialisations and File status

	eol_reached: BOOLEAN;

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

end -- class STRUCTURED_TEXT_TRANSLATER

