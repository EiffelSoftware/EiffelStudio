note
	description: "Editor tokens are created and put into last line."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_WRITER

inherit
	GRAPHICAL_FORMATTER
		redefine
			process_string_text, process_string_text_with_pebble,
			process_assertion_tag_text, process_indexing_tag_text,
			process_generic_text, process_character_text, process_local_text,
			process_number_text, process_reserved_word_text,
			process_feature_error, process_feature_dec_item, add_new_line, add_string, add
		end

	EV_SHARED_APPLICATION

	EB_EDITOR_TOKEN_IDS

create {NONE}

feature {NONE} -- Initialization

	make
		do
			create last_line.make_unix_style
		end

feature -- Access

	last_line: EIFFEL_EDITOR_LINE

feature -- New line

	new_line
			-- Create new `last_line'
		do
			create last_line.make_unix_style
		end

feature -- Token operator

	append_token (a_token: EDITOR_TOKEN)
			-- Append `a_token' at the end of current line.
		require
			a_token_not_void: a_token /= Void
		do
			last_line.append_token (a_token)
		end

	append_tokens (a_tokens: LIST [EDITOR_TOKEN])
			-- Append `a_tokens' at the end of current line.
		require
			a_tokens_not_void: a_tokens /= Void
			no_new_line: a_tokens.for_all (agent {EDITOR_TOKEN}.is_new_line)
		do
			from
				a_tokens.start
			until
				a_tokens.after
			loop
				append_token (a_tokens.item_for_iteration)
				a_tokens.forth
			end
		end

feature -- Text processing

	process_basic_text (t: READABLE_STRING_GENERAL)
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_TEXT
			l_pos, l_previous: INTEGER
			l_str: STRING_32
		do
			l_str := t.as_string_32
			l_pos := l_str.index_of (new_line_32, 1)
			if l_pos > 0 then
				from
					l_previous := 1
				until
					l_pos = 0
				loop
					add (l_str.substring (l_previous, l_pos -1))
					add_new_line
					l_previous := l_pos + 1
					l_pos := l_str.index_of (new_line_32, l_previous)
				end
				if l_previous < t.count then
					add (l_str.substring (l_previous, l_str.count))
				end
			else
				create tok.make (l_str.as_string_32)
				append_token (tok)
			end
		end

	process_string_text (t: READABLE_STRING_GENERAL; url: READABLE_STRING_GENERAL)
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_STRING
			l_pos, l_previous: INTEGER
			stone: URL_STONE
			l_t: STRING_32
		do
			l_t := t.as_string_32
			l_pos := l_t.index_of (new_line_32, 1)
			if l_pos > 0 then
				from
					l_previous := 1
				until
					l_pos = 0
				loop
					add_string (l_t.substring (l_previous, l_pos -1))
					add_new_line
					l_previous := l_pos + 1
					l_pos := l_t.index_of (new_line_32, l_previous)
				end
				if l_previous < l_t.count then
					add (l_t.substring (l_previous, l_t.count))
				end
			else
				create tok.make (t.as_string_32)
				if url /= Void then
					create stone.make (url.as_string_32)
					tok.set_pebble (stone)
				end
				append_token (tok)
			end
		end

	process_string_text_with_pebble (text: READABLE_STRING_GENERAL; a_pebble: detachable ANY)
			-- Process string text `text' associated with a pebble.
		local
			tok: EDITOR_TOKEN_STRING
			l_pos, l_previous: INTEGER
			l_t: STRING_32
		do
			l_t := text.as_string_32
			l_pos := l_t.index_of (new_line_32, 1)
			if l_pos > 0 then
				from
					l_previous := 1
				until
					l_pos = 0
				loop
					create tok.make (l_t.substring (l_previous, l_pos -1))
					if a_pebble /= Void then
						tok.set_is_link (True)
						tok.set_pebble (a_pebble)
					end
					append_token (tok)
					add_new_line
					l_previous := l_pos + 1
					l_pos := l_t.index_of (new_line_32, l_previous)
				end
				if l_previous < l_t.count then
					add (l_t.substring (l_previous, l_t.count))
				end
			else
				create tok.make (l_t)
				if a_pebble /= void then
					tok.set_is_link (True)
					tok.set_pebble (a_pebble)
				end
				append_token (tok)
			end
		end

	process_comment_text (t: READABLE_STRING_GENERAL; url: READABLE_STRING_GENERAL)
			-- Process comment text.
		local
			tok: EDITOR_TOKEN_COMMENT
			stone: URL_STONE
		do
			create tok.make (t.as_string_32)
			if url /= Void then
				create stone.make (url.as_string_32)
				tok.set_pebble (stone)
			end
			append_token (tok)
		end

	process_quoted_text (t: READABLE_STRING_GENERAL)
			-- Process the quoted `t' within a comment.
		local
			tok: EDITOR_TOKEN_QUOTED_FEATURE_IN_COMMENT
		do
			create tok.make (text_quoted (t).as_string_32)
			append_token (tok)
		end

	process_new_line
			-- Process new line text `t'.
		do
			new_line
		end

	process_indentation (a_indent_depth: INTEGER)
			-- Process indentation `t'.
		local
			tok: EDITOR_TOKEN_TABULATION
		do
			if a_indent_depth > 0 then
				create tok.make (a_indent_depth)
				append_token (tok)
			end
		end

	process_symbol_text (t: READABLE_STRING_GENERAL)
			-- Process symbol text.
		local
			tok: EDITOR_TOKEN_OPERATOR
		do
			create tok.make (t.as_string_32)
			append_token (tok)
		end

	process_keyword_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process keyword text.
		local
			tok: EDITOR_TOKEN_KEYWORD
			stone: FEATURE_STONE
		do
			create tok.make (text.as_string_32)
			if a_feature /= Void then
				create stone.make (a_feature)
				tok.set_pebble (stone)
			end
			append_token (tok)
		end

	process_cluster_name_text (text: READABLE_STRING_GENERAL; a_group: CONF_GROUP; a_quote: BOOLEAN)
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLUSTER
			stone: CLUSTER_STONE
			l_text: STRING_32
		do
			if a_quote then
				l_text := text_quoted (text).as_string_32
			else
				l_text := text.as_string_32
			end
			create tok.make (l_text)
			create stone.make (a_group)
			tok.set_pebble (stone)
			append_token (tok)
		end;

	process_class_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CLASSI_STONE
			e_class: CLASS_C
			class_i: CLASS_I
			l_text: STRING_32
		do
			if a_quote then
				l_text := text_quoted (text).as_string_32
			else
				l_text := text.as_string_32
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
			append_token (tok)
		end

	process_target_name_text (text: READABLE_STRING_GENERAL; a_target: CONF_TARGET)
			-- Process target name text `text'.
		local
			tok: EDITOR_TOKEN_TARGET
			l_stone: TARGET_STONE
		do
			create tok.make (text.as_string_32)
			create l_stone.make (a_target)
			tok.set_pebble (l_stone)
			append_token (tok)
		end

	process_feature_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
		do
			process_feature_text_internal (text, a_feature, a_quote)
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
		local
			tok: EDITOR_TOKEN_TEXT
			stone: BREAKABLE_STONE
		do
			create tok.make (a_index.out)
			create stone.make (a_feature, a_index)
			tok.set_pebble (stone)
			append_token (tok)
		end

	process_feature_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_C)
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_NAME_STONE
		do
			create tok.make (text.as_string_32)
			if a_class /= Void then
				create stone.make (text.as_string_32, a_class)
				tok.set_pebble (stone)
			end
			append_token (tok)
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- Process breakpoint.
		local
			stone: BREAKABLE_STONE
		do
			create stone.make (a_feature, a_index)
			last_line.breakpoint_token.set_pebble (stone)
		end

	process_padded
			-- Process padded item at start of non breakpoint line.
		do
			-- Do nothing... The text is now padded by default.
		end

	process_after_class (a_class: CLASS_C)
			-- Process after class text `t'.
		do
			process_comment_text (" -- class ", Void)
			add_class (a_class.lace_class)
			process_new_line
		end

	process_operator_text (t: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process operator text.
		do
			process_operator_text_internal (t, a_feature)
		end

	process_address_text (a_address, a_name: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process address text.
		local
			tok: EDITOR_TOKEN_OBJECT
			stone: OBJECT_STONE
			addr: DBG_ADDRESS
		do
			create tok.make (a_address.as_string_32)
			create addr.make_from_string (a_address)
			create stone.make (addr, a_name.as_string_32, a_class)
			tok.set_pebble (stone)
			append_token (tok)
		end

	process_error_text (t: READABLE_STRING_GENERAL; a_error: ERROR)
			-- Process error text.
		local
			tok: EDITOR_TOKEN_ERROR_CODE
			stone: ERROR_STONE
		do
			create tok.make (t.as_string_32)
			create stone.make (a_error)
			tok.set_pebble (stone)
			append_token (tok)
		end

	process_feature_error (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_line: INTEGER)
			-- Process error text.
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_ERROR_STONE
		do
			create tok.make (text.as_string_32)
			create stone.make (a_feature, a_line)
			tok.set_pebble (stone)
			append_token (tok)
		end

	process_cl_syntax (text: READABLE_STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- Process class syntax text.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CL_SYNTAX_STONE
		do
			create tok.make (text.as_string_32)
			create stone.make (a_syntax_message, a_class)
			tok.set_pebble (stone)
			append_token (tok)
		end

	process_assertion_tag_text (t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t.as_string_32)
			tok.set_indexing (False)
			append_token (tok)
		end

	process_indexing_tag_text (t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t.as_string_32)
			tok.set_indexing (True)
			append_token (tok)
		end

	process_generic_text (t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_GENERIC
		do
			create tok.make (t.as_string_32)
			append_token (tok)
		end

	process_character_text (t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_CHARACTER
		do
			create tok.make (t.as_string_32)
			append_token (tok)
		end

	process_local_text (a_ast: detachable AST_EIFFEL; t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_LOCAL
			st: ACCESS_ID_STONE
		do
			create tok.make (t.as_string_32)
			if a_ast /= Void then
				if attached {ACCESS_FEAT_AS} a_ast as af and then af.is_tuple_access then
						-- Skip tuple value, as not really local token.
				elseif attached Eiffel_system.System.current_class as cl then
					create st.make (cl, a_ast)
					tok.set_pebble (st)
				end
			end
			append_token (tok)
		end

	process_number_text (t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_NUMBER
		do
			create tok.make (t.as_string_32)
			append_token (tok)
		end

	process_reserved_word_text (t: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_RESERVED
		do
			create tok.make (t.as_string_32)
			append_token (tok)
		end

	process_filter_item (text: READABLE_STRING_GENERAL; a_before: BOOLEAN)
			-- Process information on filter `text'.
		do
		end

	process_feature_dec_item (text: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process feature dec information.
		local
			tok: EDITOR_TOKEN_FEATURE_START
		do
			if is_before then
				create tok.make (text.as_string_32)
				tok.set_text_color_feature
				append_token (tok)
			end
		end

	process_before_class (a_class: CLASS_C)
			-- Process before class `a_class'.
		do
		end

	process_ast (a_name: READABLE_STRING_GENERAL; a_ast: AST_EIFFEL; a_written_class: CLASS_C; a_appearance: TUPLE [a_font_id: INTEGER; a_text_color_id: INTEGER; a_background_color_id: INTEGER]; a_for_feature_invocation: BOOLEAN; a_cursor, a_x_cursor: EV_POINTER_STYLE)
			-- Process `a_ast' from `a_written_class'.
			-- `a_name' is displayed name for `a_ast'.
			-- `a_appearance' is new appearance (font, text color and background color) associated with `a_name', if Void, default values will be used.
			-- If `a_for_feature_invocation' is True, mark stone contained in `a_name' as for feature invocation.
			-- If `a_cursor' is not Void , it will be used as cursor for generated text.
			-- If `a_x_cursor' is not Void , it will be used as X cursor for generated text.
		require
			a_name_attached: a_name /= Void
		local
			l_ast_token: EDITOR_TOKEN_AST
			l_stone: AST_STONE
		do
			if a_appearance /= Void then
				create l_ast_token.make_with_appearance (a_name.to_string_32, a_appearance)
			else
				create l_ast_token.make (a_name.to_string_32)
			end
			if a_ast /= Void and then a_written_class /= Void then
				create l_stone.make (a_written_class, a_ast)
				l_stone.set_is_for_feature_invocation (a_for_feature_invocation)
				if a_cursor /= Void then
					l_stone.set_stone_cursor (a_cursor)
				end
				if a_x_cursor /= Void then
					l_stone.set_x_stone_cursor (a_x_cursor)
				end
				l_ast_token.set_pebble (l_stone)
			end
			append_token (l_ast_token)
		end

	process_warning (a_warning_message: READABLE_STRING_GENERAL; a_appearance: TUPLE [a_font_id: INTEGER; a_text_color_id: INTEGER; a_background_color_id: INTEGER])
			-- Process warning message `a_warning_message' with appearance `a_appearance'.
		require
			a_warning_message_attached: a_warning_message /= Void
		do
			process_ast (a_warning_message, Void, Void, a_appearance, False, Void, Void)
		end

	process_compiled_line (a_name: READABLE_STRING_GENERAL; a_line_number: INTEGER; a_class_c: CLASS_C; a_selected: BOOLEAN)
			-- Process `a_name' which represents a line of a class.
		require
			a_name_attached: a_name /= Void
			a_line_number_positive: a_line_number > 0
			a_class_c_attached: a_class_c /= Void
		local
			l_token: EDITOR_TOKEN_AST
		do
			create l_token.make_with_appearance (a_name.to_string_32, [editor_font_id, line_number_text_color_id, string_background_color_id])
			l_token.set_pebble (create {COMPILED_LINE_STONE}.make_with_line (a_class_c, a_line_number, a_selected))
			append_token (l_token)
		end

	process_uncompiled_line (a_name: READABLE_STRING_GENERAL; a_line_number: INTEGER; a_class_i: CLASS_I; a_selected: BOOLEAN)
			-- Process `a_name' which represents a line of a class.
		require
			a_name_attached: a_name /= Void
			a_line_number_positive: a_line_number > 0
			a_class_i_attached: a_class_i /= Void
		local
			l_token: EDITOR_TOKEN_AST
		do
			create l_token.make_with_appearance (a_name.to_string_32, [editor_font_id, line_number_text_color_id, string_background_color_id])
			l_token.set_pebble (create {UNCOMPILED_LINE_STONE}.make_with_line (a_class_i, a_line_number, a_selected))
			append_token (l_token)
		end

	add_new_line
			-- Add new line.
		do
			process_new_line
		end

	add (s: READABLE_STRING_GENERAL)
			-- Add basic string.
		do
			process_basic_text (s)
		end

	add_string (s: READABLE_STRING_GENERAL)
			-- Add string.
		do
			process_string_text (s, Void)
		end

	add_glyph (a_glyph: EV_PIXEL_BUFFER)
			-- <Precursor>
		local
			l_token: EDITOR_TOKEN_GLYPH
		do
			create l_token.make (a_glyph)
			append_token (l_token)
		end

	process_folder_text (a_folder_name: READABLE_STRING_GENERAL; a_path: READABLE_STRING_GENERAL; a_group: CONF_GROUP)
			-- Process folder text.
			-- `a_folder_name' is the name of the folder,
			-- `a_path' is the path in which `a_folder_name' exist, so for example,
			-- for path "/abc/def", "def" is the folder name, while "/abc/def" is the path.
			-- `a_group' is the group where this folder is located.
		require
			a_folder_name_attached: a_folder_name /= Void
			a_path_attached: a_path /= Void
			a_group_attached: a_group /= Void
		local
			l_token: EDITOR_TOKEN_AST
		do
			create l_token.make_with_appearance (a_folder_name.to_string_32, [editor_font_id, folder_text_color_id, folder_background_color_id])
				-- Use `as_string_8' until we finish adapting {CLUSTER_STONE}.
			l_token.set_pebble (create {CLUSTER_STONE}.make_subfolder (a_group, a_path, a_folder_name))
			append_token (l_token)
		end

feature {NONE} -- Initialisations and File status

	new_line_32: CHARACTER_32 = '%N'

	eol_reached: BOOLEAN;

	process_feature_text_internal (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
		local
			tok: EDITOR_TOKEN_FEATURE
			feature_start: EDITOR_TOKEN_FEATURE_START
			stone: FEATURE_STONE
			feature_start_found: BOOLEAN
			editor_tok: EDITOR_TOKEN
			l_text: STRING_32
		do
			if a_quote then
				l_text := text_quoted (text)
			else
				l_text := text.to_string_32
			end
			create stone.make (a_feature)
			from
				last_line.start
			until
				last_line.after or feature_start_found
			loop
				if attached {EDITOR_TOKEN_FEATURE_START} last_line.item as feat_st then
					feature_start := feat_st
					feature_start_found := feat_st.pebble = Void
				else
					feature_start_found := False
				end
				if not feature_start_found then
					last_line.forth
				end
			end
			if feature_start_found then
				editor_tok := last_line.item
				if attached editor_tok.previous as l_prev then
					l_prev.set_next_token (editor_tok.next)
				end
				if attached editor_tok.next as l_next then
					l_next.set_previous_token (editor_tok.previous)
				end
				create feature_start.make (l_text)
				feature_start.set_pebble (stone)
				feature_start.set_text_color_feature
				append_token (feature_start)
			else
				create tok.make (l_text)
				tok.set_pebble (stone)
				append_token (tok)
			end
		end

	process_operator_text_internal (t: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process operator text.
		local
			tok: EDITOR_TOKEN
			stone: FEATURE_STONE
			feature_start: EDITOR_TOKEN_FEATURE_START
			feature_start_found: BOOLEAN
			editor_tok: EDITOR_TOKEN
		do
			if a_feature /= Void then
				create stone.make (a_feature)
			end
			from
				last_line.start
			until
				last_line.after or feature_start_found
			loop
				if attached {EDITOR_TOKEN_FEATURE_START} last_line.item as l_feat_start then
					feature_start_found := l_feat_start.pebble = Void
				end
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
				create feature_start.make (t.as_string_32)
				feature_start.set_pebble (stone)
				if is_keyword (t) then
					feature_start.set_text_color_feature
				else
					feature_start.set_text_color_operator
				end
				append_token (feature_start)
			else
				if is_keyword (t) then
					create {EDITOR_TOKEN_KEYWORD} tok.make (t.as_string_32)
				else
					create {EDITOR_TOKEN_OPERATOR} tok.make (t.as_string_32)
				end
				tok.set_pebble (stone)
				append_token (tok)
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
