indexing
	description: "[
			Clickable editor for Eiffel Code.
			All text areas in EiffelStudio but the main editor use direct instance of this class.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	CLICKABLE_TEXT

inherit
	STRUCTURED_TEXT_TRANSLATOR
		rename
			make as make_translator,
			last_line as last_processed_line,
			after as structured_text_after,
			start as structured_text_start,
			process_text as load_structured_text
		export
			{NONE} all
			{ANY} enable_has_breakable_slots, disable_has_breakable_slots,
				load_structured_text, has_breakable_slots,
				current_text, put_string, new_line,
				put_char
		redefine
			load_structured_text, last_processed_line
		end

	EDITABLE_TEXT
		redefine
			make, finish_reading_agent,
			reset_text, on_text_loaded,
			load_string
		end

	SHARED_WORKBENCH
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
		end

feature -- Access

	structured_text: STRUCTURED_TEXT is
			-- Structured text that corresponds to `Current'
		local
			ln: EDITOR_LINE
			tok: EDITOR_TOKEN
		do
			create Result.make
			if not is_empty then
				from
					ln := first_line
				until
					ln = Void
				loop
					from
						tok := ln.first_token
					until
						tok = Void
					loop
						Result.extend (tok.corresponding_text_item)
						tok := tok.next
					end
					ln := ln.next
				end
			end
		end

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
				elseif cursr.token /= Void then
					Result := cursr.token.pebble
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

feature -- Load Text handling

	reset_text is
			-- Actions to be performed before a new text is processed.
		do
			current_text := Void
			
				-- First abort our previous actions.
			{EDITABLE_TEXT} Precursor

				-- Reset the editor state.
			disable_has_breakable_slots
		end


feature -- Initialization

	load_string (a_string: STRING) is
			-- scan `a_string' and fill the object with resulting
			-- lines and tokens
		do
			load_type := from_string
			{EDITABLE_TEXT} Precursor (a_string)
		end



	load_structured_text (str_text: STRUCTURED_TEXT) is
			-- scan `a_string' and fill the object with resulting
			-- lines and tokens
		require else
			structured_text_not_void: str_text /= Void
			text_has_been_reinitialized: is_empty
		do
			load_type := from_text			
			current_text := str_text
			start_reading_text
		ensure then
			read_enough_lines: number_of_lines >= first_read_block_size or else reading_text_finished
		end

	select_line (l_num: INTEGER) is
			-- select the `l_num'-th line in text
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
			cursor_positioned: cursor.y_in_lines = l_num and cursor.x_in_characters = 1
			selection_cursor_positioned: selection_cursor.y_in_lines = l_num and selection_cursor.line.eol_token = selection_cursor.token
		end

feature {NONE} -- Load Text handling

	start_reading_text is
			-- Read the text named `a_name' and perform a lexical analysis
		do
				-- reset the displayed text & display the drawing area.
			from
				structured_text_start
			until
				number_of_lines > first_read_block_size
					or else structured_text_after
			loop
				process_line
				append_line (last_processed_line)
			end

			on_text_block_loaded (True)

			if not structured_text_after then
					-- the text has not been entirely loaded, so we will
					-- finish loading the text on idle actions.
				reading_text_finished := False
				current_cursor := current_text.cursor
			else
				reading_text_finished := True
				on_text_loaded
			end
			ev_application.idle_actions.extend (Finish_reading_agent)
		end

	finish_reading_text is
			-- Read the text named `a_name' and perform a lexical analysis
		local
			lines_read	: INTEGER
		do
			if not reading_text_finished then
				current_text.go_to (current_cursor)
				from
					lines_read := 1
				until
					lines_read > Lines_read_per_idle_action or else structured_text_after
				loop
					process_line
					append_line (last_processed_line)
						-- prepare next iteration
					lines_read := lines_read + 1
				end
				on_text_block_loaded (False)

				if structured_text_after then
						-- We have finished reading the text, so we remove
						-- ourself from the idle actions.
					reading_text_finished := True
					on_text_loaded
					after_reading_idle_action
				else
					current_cursor := current_text.cursor
				end
			else
				after_reading_idle_action
			end
		end

	Finish_reading_agent: PROCEDURE[like Current, TUPLE] is
			-- Agent for function `finish_reading_text'
		do
			if internal_Finish_reading_agent = Void then
				internal_Finish_reading_agent := ~finish_reading
			end
			Result := internal_Finish_reading_agent
		end

	finish_reading is
		do
			if load_type = from_text then
				finish_reading_text
			else
				finish_reading_string
			end

		end

	on_text_loaded is
			-- Initialize feature click tool after text loading.
		do
			{EDITABLE_TEXT} Precursor
			if feature_click_enabled and then load_type = from_string then
				feature_click_tool.set_content (Current)
				feature_click_tool.prepare_on_click_analysis
			end
		end



feature {NONE} -- Implementation

	use_feature_click_tool: BOOLEAN
			-- Does this text use a feature click tool ?

	current_cursor: CURSOR
			-- Cursor pointing position where to resume current structured loading.

	last_processed_line: EDITOR_LINE
			-- last line processed while reading a STRUCTURED_TEXT

feature {NONE} -- Private status

	load_type: INTEGER
			-- type of text source: file, string...

feature {NONE} -- Private Constants

	from_string: INTEGER is unique

	from_text: INTEGER is unique

end -- class CLICKABLE_TEXT
