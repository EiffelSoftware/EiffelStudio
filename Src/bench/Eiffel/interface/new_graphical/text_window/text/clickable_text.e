indexing
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
			end_processing
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
			cursor
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

	make is
			-- Initialize the text.
		do
			Precursor {EDITABLE_TEXT}
			make_translator
			reading_text_finished := True
			eol_reached := false
			new_line
		end

feature -- Access

	first_line: EIFFEL_EDITOR_LINE

	cursor: EIFFEL_EDITOR_CURSOR

feature -- Feature click tool

	enable_feature_click is
			-- enable feature click tool		
		do
			use_feature_click_tool := True
		end

	disable_feature_click is
			-- disable feature click tool					
		do
			use_feature_click_tool := False
		end

	set_feature_for_click (feat: E_FEATURE) is
			-- initialize feature click tool with feature `feat'
		do
			if feature_click_tool= Void then
				create feature_click_tool
			end
			feature_click_tool.initialize (feat)
		end

	feature_click_enabled: BOOLEAN is
			-- do we use feature click tool?
		do
			Result := use_feature_click_tool and then feature_click_tool /= Void and then feature_click_tool.can_analyze_current_class
		end

	feature_click_tool: EB_CLICK_FEATURE_TOOL
			-- tool that makes feature basic text clickable

feature -- Pick and drop

	stone_at (cursr: like cursor): STONE is
		require
			cursor_exists: cursr /= Void
		do
			if not Workbench.is_compiling then
				if feature_click_enabled and then feature_click_tool.is_ready then
					Result := feature_click_tool.stone_at_position (cursr)
				elseif cursr.token /= Void and then cursr.token.pebble /= Void then
					Result ?= cursr.token.pebble.twin
				end
			end
		end

feature -- Compatibility

	set_position, go_to (a_position: INTEGER) is
			-- move the cursor to the `a_position'-th character in text.
		require
			position_valid: a_position > 0
			position_in_text: a_position <= text_length
		do
			forget_selection

				-- create the new cursor
			cursor.make_from_integer (a_position, Current)
			history.record_move
		end

feature {EB_CLICKABLE_EDITOR} -- Load Text handling

	start_processing (append: BOOLEAN) is
			-- Start processing text.
		do
			reading_text_finished := false
		end

	end_processing is
			-- End processing text.
		do
			if first_line = Void then
				last_processed_line.update_token_information
				if number_of_lines = 0 then
					append_line (last_processed_line)
					if cursor = Void then
						create cursor.make_from_integer (1, Current)
						set_selection_cursor (cursor)
					end
				end
			else
				end_processing_internal
			end
			if number_of_lines <= first_read_block_size then
				on_text_block_loaded (cursor = Void)
				line_read := 0
			end
		end

feature -- Load Text handling

	reset_text is
			-- Actions to be performed before a new text is processed.
		do
			Precursor {EDITABLE_TEXT}
			new_line
		end

feature -- Initialization

	load_string (a_string: STRING) is
			-- scan `a_string' and fill the object with resulting
			-- lines and tokens
		do
			load_type := from_string
			Precursor {EDITABLE_TEXT} (a_string)
		end

	select_line (l_num: INTEGER) is
			-- select the `l_num'-th line in text
			-- Cursor is positioned at end of selection.
			-- Selection cursor is positioned at beginning of selection.
		require
			l_num_large_enough: l_num > 0
			l_num_small_enough: l_num <= number_of_lines
		do
			cursor.make_from_character_pos (1, l_num, Current)
			selection_cursor.make_from_character_pos (1, l_num, Current)
			cursor.go_end_line
			enable_selection
		ensure
			has_selection
			cursor_positioned: cursor.y_in_lines = l_num and cursor.line.eol_token = cursor.token
			selection_cursor_positioned: selection_cursor.y_in_lines = l_num and selection_cursor.x_in_characters = 1
		end

feature -- Load Text handling

	process_new_line is
			-- When processing a new line, we see if we are going to process rest of lines on idle.
		do
			process_new_line_internal
		end

feature {NONE} -- Load Text handling

	process_new_line_internal is
			-- Process new line.
		do
			line_read := line_read + 1
			eol_reached := true
			last_processed_line.update_token_information
			if number_of_lines = 0 then
				append_line (last_processed_line)
			end
			if cursor = Void then
				create cursor.make_from_character_pos (1, number_of_lines, Current)
				if selection_cursor = Void then
					set_selection_cursor (cursor)
				end
			end
			if number_of_lines > first_read_block_size then
				on_text_block_loaded (True)
				line_read := 0
			else
				if line_read > Lines_read_per_idle_action then
					on_text_block_loaded (False)
					line_read := 0
				end
			end
			new_line
			append_line (last_processed_line)
			eol_reached := false
		end

	on_text_loaded is
			-- Initialize feature click tool after text loading.
		do
			Precursor {EDITABLE_TEXT}
			if feature_click_enabled and then load_type = from_string then
				feature_click_tool.set_content (Current)
				feature_click_tool.prepare_on_click_analysis
			end
		end

	abort_idle_processing is
			-- Stop text processing done during idle actions.
		do
			Precursor {EDITABLE_TEXT}
		end

	after_reading_idle_action is
			-- action performed on idle when text reading is finished.
		do
			Precursor {EDITABLE_TEXT}
		end

	new_line_from_lexer (line_image: STRING): like line is
			-- create a new like line from `line_image' using `lexer'.
		do
			if line_image.is_empty then
				create Result.make_empty_line
			else
				lexer.execute (line_image)
				create Result.make_from_lexer (lexer)
			end
		end

	end_processing_internal is
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

	editor_preferences: EB_EDITOR_DATA is
			-- Eiffel editor preferences
		once
			Result := preferences.editor_data
		end

	finish_reading_text_agent: PROCEDURE [like Current, TUPLE]
			-- Agent for function `finish_reading_text'

feature {NONE} -- Private status

	load_type: INTEGER
			-- type of text source: file, string...

	line_read: INTEGER
			-- Lines read during loading a block

feature {NONE} -- Private Constants

	from_string: INTEGER is unique

	from_text: INTEGER is unique;

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

end -- class CLICKABLE_TEXT
