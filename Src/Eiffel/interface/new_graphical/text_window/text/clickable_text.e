note
	description: "[
			Clickable editor for Eiffel Code.
			All text areas in EiffelStudio but the main editor use direct instance of this class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	CLICKABLE_TEXT

inherit
	EDITOR_TOKEN_WRITER
		rename
			make as make_translator,
			last_line as last_processed_line
		undefine
			ev_application
		redefine
			last_processed_line,
			process_new_line,
			start_processing,
			end_processing,
			append_token,
			format_eis_entry,
			search_eis_entry_in_note_clause,
			add_eis_source
		end

	EDITABLE_TEXT
		redefine
			make,
			reset_text,
			on_text_loaded,
			load_string,
			editor_preferences,
			abort_idle_processing,
			after_reading_idle_action,
			new_line_from_lexer,
			first_line,
			cursor,
			lexer
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the text.
		do
			Precursor {EDITABLE_TEXT}
			make_translator
			reading_text_finished := True
			eol_reached := False
			new_line
		end

feature -- Access

	first_line: detachable EIFFEL_EDITOR_LINE

	cursor: EIFFEL_EDITOR_CURSOR

feature -- Feature click tool

	enable_feature_click
			-- enable feature click tool		
		do
			use_feature_click_tool := True
		end

	disable_feature_click
			-- disable feature click tool					
		do
			use_feature_click_tool := False
		end

	set_feature_for_click (feat: E_FEATURE)
			-- initialize feature click tool with feature `feat'
		do
			if feature_click_tool = Void then
				create feature_click_tool
			end
			if feat /= Void then
				feature_click_tool.initialize (feat)
			end
		end

	feature_click_enabled: BOOLEAN
			-- do we use feature click tool?
		do
			Result := use_feature_click_tool and then feature_click_tool /= Void and then feature_click_tool.can_analyze_current_class
		end

	feature_click_tool: detachable EB_CLICK_FEATURE_TOOL
			-- tool that makes feature basic text clickable

feature -- Pick and drop

	stone_at (cursr: like cursor): STONE
		require
			cursor_exists: cursr /= Void
		do
			if not Workbench.is_compiling then
				if feature_click_enabled and then feature_click_tool.is_ready then
					Result := feature_click_tool.stone_at_position (cursr)
				end
				if Result = Void and then cursr.token /= Void and then cursr.token.pebble /= Void then
					Result ?= cursr.token.pebble.twin
				end
			end
		end

feature -- Compatibility

	set_position, go_to (a_position: INTEGER)
			-- move the cursor to the `a_position'-th character in text.
		require
			position_valid: a_position > 0
			position_in_text: a_position <= text_length
		do
			forget_selection

				-- create the new cursor
			cursor.set_from_integer (a_position, Current)
			history.record_move
		end

feature {EB_CLICKABLE_EDITOR} -- Load Text handling

	start_processing (append: BOOLEAN)
			-- Start processing text.
		do
			reading_text_finished := False
			if not append then
				block_counter := 0
				no_processed_line := True
			end
			if attached current_string as l_t then
				l_t.wipe_out
			else
				create current_string.make_empty
			end
		end

	end_processing
			-- End processing text.
		local
			l_line: like first_line
			l_token: detachable EDITOR_TOKEN
		do
			if first_line = Void then
				last_processed_line.update_token_information
				if number_of_lines = 0 then
					append_line (last_processed_line)
					if cursor = Void then
						l_line := first_line
						check l_line /= Void end -- Just appended one.
						l_token := l_line.first_token
						check l_token /= Void end -- The first token not void.
						create cursor.make_from_relative_pos (l_line, l_token, 1, Current)
						create cursor.make_from_integer (1, Current)
						set_selection_cursor (cursor)
					end
				end
			else
				end_processing_internal
			end
			if number_of_lines <= first_read_block_size then
				on_text_block_loaded (cursor = Void)
				reading_text_finished := True
				on_text_loaded
				after_reading_idle_action
				line_read := 0
			end
			no_processed_line := False
		end

feature -- Load Text handling

	reset_text
			-- Actions to be performed before a new text is processed.
		do
			Precursor {EDITABLE_TEXT}
			new_line
		end

feature -- Initialization

	load_string (a_string: STRING)
			-- scan `a_string' and fill the object with resulting
			-- lines and tokens
		do
			load_type := from_string
			Precursor {EDITABLE_TEXT} (a_string)
		end

	select_line (l_num: INTEGER)
			-- select the `l_num'-th line in text
			-- Cursor is positioned at end of selection.
			-- Selection cursor is positioned at beginning of selection.
		require
			l_num_large_enough: l_num > 0
			l_num_small_enough: l_num <= number_of_lines
		do
			cursor.set_from_character_pos (1, l_num, Current)
			selection_cursor.set_from_character_pos (1, l_num, Current)
			cursor.go_end_line
			enable_selection
		ensure
			cursor_positioned: cursor.y_in_lines = l_num and cursor.line.eol_token = cursor.token
			selection_cursor_positioned: selection_cursor.y_in_lines = l_num and selection_cursor.x_in_characters = 1
		end

	select_token (l_line: INTEGER; l_col: INTEGER)
			-- Selects a single token on line `a_line' at character position `l_col'
		require
			l_line_large_enough: l_line > 0
			l_line_small_enough: l_line <= number_of_lines
			l_col_large_enough: l_col > 0
		local
			l_token: EDITOR_TOKEN
		do
			cursor.set_from_character_pos (l_col, l_line, Current)
			l_token := cursor.token
			if l_token /= cursor.line.eol_token then
				selection_cursor.set_from_character_pos (l_col, l_line, Current)
				cursor.set_current_char (l_token.next, 1)
				enable_selection
			end
		ensure
			cursor_positioned: cursor.y_in_lines = l_line
			selection_cursor_positioned: not cursor.token.is_new_line implies selection_cursor.y_in_lines = l_line
		end

feature -- Load Text handling

	process_new_line
			-- When processing a new line, we see if we are going to process rest of lines on idle.
		do
			process_new_line_internal
		end

feature {NONE} -- Load Text handling

	process_new_line_internal
			-- Process new line.
		local
			l_line: like first_line
			l_token: detachable EDITOR_TOKEN
		do
			line_read := line_read + 1
			eol_reached := True
			last_processed_line.update_token_information
			if no_processed_line or number_of_lines = 0 then
					-- Delete the initial blank line.
				if number_of_lines = 1 then
					line (1).delete
				end
				append_line (last_processed_line)
				no_processed_line := False
			end
			if cursor = Void then
				l_line := first_line
				check l_line /= Void end -- Just appended one.
				l_token := l_line.first_token
				check l_token /= Void end -- The first token not void.
				create cursor.make_from_relative_pos (l_line, l_token, 1, Current)
				if selection_cursor = Void then
					set_selection_cursor (cursor)
				end
			end
			if block_counter = 0 then
				if line_read > first_read_block_size then
					on_text_block_loaded (True)
					block_counter := block_counter + 1
					line_read := 0
				end
			elseif line_read > Lines_read_per_idle_action then
				on_text_block_loaded (False)
				line_read := 0
				block_counter := block_counter + 1
			end
				-- Save the text for later use.
			if attached text_loaded as l_t and then attached last_processed_line as l_l then
				l_t.append_string (encoding_converter.utf32_to_utf8 (l_l.wide_image))
				l_t.append_string ("%N")
			end

			new_line
			append_line (last_processed_line)
			eol_reached := False
		end

	on_text_loaded
			-- Initialize feature click tool after text loading.
		do
			Precursor {EDITABLE_TEXT}
			if feature_click_enabled and then load_type = from_string then
				feature_click_tool.set_content (Current)
				feature_click_tool.prepare_on_click_analysis
			end
		end

	abort_idle_processing
			-- Stop text processing done during idle actions.
		do
			Precursor {EDITABLE_TEXT}
		end

	after_reading_idle_action
			-- action performed on idle when text reading is finished.
		do
			Precursor {EDITABLE_TEXT}
		end

	new_line_from_lexer (line_image: STRING; a_windows_style: BOOLEAN): like line
			-- <precursor>
		do
			if line_image.is_empty then
				create Result.make (a_windows_style)
			else
				lexer.execute (line_image)
				create Result.make_from_lexer (lexer)
			end
		end

	end_processing_internal
			-- For running on idle
		local
			l_create_cursor: BOOLEAN
		do
			last_processed_line.update_token_information
			if last_processed_line /= last_line then
				append_line (last_processed_line)
			end
			l_create_cursor := cursor = Void and then number_of_lines <= first_read_block_size
			on_text_block_loaded (l_create_cursor)
			reading_text_finished := True
			on_text_loaded
			after_reading_idle_action
		end

feature {NONE} -- Implementation

	use_feature_click_tool: BOOLEAN
			-- Does this text use a feature click tool ?

	current_cursor: CURSOR
			-- Cursor pointing position where to resume current structured loading.

	last_processed_line: like line
			-- last line processed while reading a TEXT_FORMATTER

	editor_preferences: EB_EDITOR_DATA
			-- Eiffel editor preferences
		once
			Result := preferences.editor_data
		end

	finish_reading_text_agent: PROCEDURE [like Current, TUPLE]
			-- Agent for function `finish_reading_text'

	add_eis_source (s: READABLE_STRING_GENERAL)
			-- Add EIS source
		local
			l_context: ES_EIS_ENTRY_HELP_CONTEXT
			l_pos: INTEGER
		do
			if attached last_eis_entry_and_source_as as l_tuple then
				create l_context.make (l_tuple.entry, False)
				l_pos := s.substring_index ({ES_EIS_TOKENS}.value_assignment, 1)
				if l_pos > 0 then
					process_string_text (s.substring (1, l_pos), Void)
					process_string_text_with_pebble (s.substring (l_pos + 1, s.count - 1), create {EIS_LINK_STONE}.make (l_context))
					process_string_text ("%"", Void)
				else
					process_string_text_with_pebble (s, create {EIS_LINK_STONE}.make (l_context))
				end
			end
		end

	format_eis_entry (a_as: AST_EIFFEL): BOOLEAN
			-- Should eis entry be formatted?
		do
			Result := attached last_eis_entry_and_source_as as l_tuple and then l_tuple.source = a_as
		end

	search_eis_entry_in_note_clause (a_index: detachable INDEX_AS; a_class: detachable CLASS_I; a_feat: detachable FEATURE_I)
			-- Search EIS entry in the context.
		do
			if attached a_index as l_index then
				last_eis_entry_and_source_as := found_eis_entry (l_index, a_class, a_feat)
			else
				last_eis_entry_and_source_as := Void
			end
		end

	found_eis_entry (a_index: INDEX_AS; a_class: detachable CLASS_I; a_feature: detachable FEATURE_I): detachable TUPLE [entry: EIS_ENTRY; source: AST_EIFFEL]
			-- Found EIS entry and the source AS.
		require
			a_index_not_void: a_index /= Void
		local
			l_eis_extractor: ES_EIS_CLASS_EXTRACTOR
		do
			if attached a_class as l_class then
				create l_eis_extractor.make_no_extract (l_class, True)
				if attached a_feature as l_f then
					Result := l_eis_extractor.source_ast_from_note_clause_ast (a_index, l_f.feature_name_id)
				else
					Result := l_eis_extractor.source_ast_from_note_clause_ast (a_index, 0)
				end
			end
		end

	last_eis_entry_and_source_as: detachable TUPLE [entry: EIS_ENTRY; source: AST_EIFFEL];
			-- Last found EIS entry and the source AS.

feature -- Debugger tooltip

	append_token (a_token: EDITOR_TOKEN)
			-- <Precursor>
		do
			Precursor (a_token)
				-- Add mapping between token and expression meta
			a_token.set_data (meta_data)
		end

feature {EB_EDITOR} -- Multi editor support

	set_lexer (a_lexer: like lexer)
			-- Set lexer.
		do
			internal_lexer := a_lexer
		ensure
			internal_lexer_set: internal_lexer = a_lexer
		end

	lexer: EDITOR_SCANNER
			-- Lexer
		do
			if internal_lexer /= Void then
				Result := internal_lexer
			else
				Result := current_class.scanner
			end
		end

	internal_lexer: like lexer
			-- Internal lexer

feature {NONE} -- Private status

	load_type: INTEGER
			-- type of text source: file, string...

	line_read: INTEGER
			-- Lines read during loading a block

	block_counter: INTEGER
			-- Blocks loaded.

	no_processed_line: BOOLEAN
			-- has processed line of text after calling `start_processing'?

feature {NONE} -- Private Constants

	from_string: INTEGER = 1

	from_text: INTEGER = 2;

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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

end -- class CLICKABLE_TEXT
