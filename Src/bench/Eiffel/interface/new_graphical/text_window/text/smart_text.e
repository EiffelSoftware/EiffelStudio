indexing
	description: "[
			Editable eiffel code.
			Includes syntax completion and feature calls completion computation.
			Uses EB_CLICK_AND_COMPLETE_TOOL instance to search stones or types associated
			with text tokens.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	SMART_TEXT

inherit
	CLICKABLE_TEXT
		export
			{EB_SMART_EDITOR} on_text_edited
		redefine
			restore_tokens_properties,
			restore_tokens_properties_one_line,
			reset_text,
			new_line_from_lexer,
			after_reading_idle_action,
			stone_at,
			make
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize text.
		do
			{CLICKABLE_TEXT} Precursor
			create click_tool
		end

feature -- Access

	last_syntax_error: SYNTAX_ERROR is
			-- Syntax error found last time file was parsed.
		do
			if click_tool /= Void then
				Result := click_tool.last_syntax_error
			end
		end

feature -- Element Change

	clear_syntax_error is
			-- Set last_syntax_error to Void.
		do
			if click_tool /= Void then
				click_tool.clear_syntax_error
			end
		end

feature -- Status report

	exploring_current_class: BOOLEAN is
			-- Is the completion being used to choose a feature of the current class (i.e. will a dotted
			-- notation be needed in completion)?
		do
			Result := click_tool.exploring_current_class
		end

	current_class_is_clickable: BOOLEAN
			-- Is the current syntaxically correct to be clickable?

	click_tool_enabled: BOOLEAN
			-- Should `Current' use `click_tool'?

	click_and_complete_is_active: BOOLEAN is
			-- Can `click_tool' be used with currently opened class?
		do
			Result := current_class_is_clickable and then click_tool_enabled
		end

	click_tool_status: INTEGER
			-- `click_tool' status after initialization.

	no_error, syntax_error, class_name_changed: INTEGER is unique
			-- `click_tool_status' possible values.

feature -- Status setting

	enable_click_tool is
			-- let `Current' use `click_tool'.
		do
			click_tool_enabled := True
		end

	disable_click_tool is
			-- Prevent `Current' from using `click_tool'.
		do
			click_tool_enabled := False
		end

feature -- Basic Operations

	embed_in_block (keyword: STRING; pos_in_keyword: INTEGER) is
			-- Embed selection or current line in block formed by `keyword' and "end".
			-- Cursor is positioned to the `pos_in_keyword'-th caracter of `keyword'.
		require
			not_empty: not is_empty
			keyword_not_void: keyword /= Void
			pos_in_keyword_valid: pos_in_keyword > 0 and then pos_in_keyword <= keyword.count
		local
			cur: like cursor
			indent: STRING
			backward_steps: INTEGER
		do
			on_text_edited (True)

			ignore_cursor_moves := True

			if has_selection then
				if cursor < selection_cursor then
					cur := selection_cursor
					selection_cursor := cursor
					cursor := cur
				end
				if cursor.x_in_characters = 1 then
					cursor.go_left_char
				end
			else
				selection_cursor := clone (cursor)
				selection_cursor.go_start_line
				cursor.go_end_line
			end
			if cursor.y_in_lines = selection_cursor.y_in_lines then
				indent := cursor.line.indentation
			else
				indent := smallest_indentation (selection_start, selection_end)
			end
			if not cursor.is_equal (selection_cursor) then
				indent_selection
				history.bind_current_item_to_next
			end
			if has_selection then
				has_selection := False
				on_selection_finished
			end
			cursor.go_end_line
			cursor.go_right_char
			insert_eol
			history.bind_current_item_to_next
			history.record_move
			cursor.go_left_char

			insert_string (indent + "end")
			history.bind_current_item_to_next
			history.record_move
			cursor.make_from_character_pos (1, selection_cursor.y_in_lines, Current)
			insert_eol
			history.bind_current_item_to_next

			history.record_move
			cursor.go_left_char
				
			insert_string (indent + keyword)
			history.record_move
			from
				backward_steps := (keyword.count - pos_in_keyword).max(0)
			until
				backward_steps < 1
			loop
				cursor.go_left_char
				backward_steps := backward_steps - 1
			end

			ignore_cursor_moves := False
		end

	smallest_indentation (start_cursor, end_cursor: EDITOR_CURSOR): STRING is
			-- Smallest indentation in lines between `start_cursor' and
			-- `end_cursor' (lines containing cursors are included).
			-- Lines with no indentation or blank lines are not
			-- taken into account.
		require
			cursors_in_the_right_order: start_cursor < end_cursor
			cursors_on_different_lines: start_cursor.line /= end_cursor.line
		local
			ln, r_ln: EDITOR_LINE
			blnk: EDITOR_TOKEN_BLANK
			tok: EDITOR_TOKEN
			pos: INTEGER
		do
			from
				ln := start_cursor.line
				r_ln := ln
				from
					tok := ln.first_token
					blnk ?= tok
				until
					blnk = Void
				loop
					tok := tok.next
					blnk ?= tok
				end
				check 
					tok /= Void
				end
				pos := tok.position
			until
				ln = Void or else ln = end_cursor.line 
			loop
				tok := ln.first_token
				blnk ?= tok
				if blnk /= Void then
					from
					until
						blnk = Void
					loop
						tok := tok.next
						blnk ?= tok
					end
					check 
						tok /= Void
					end
					if pos = 0 or else (tok.position < pos and then tok /= ln.eol_token) then
						r_ln := ln
						pos := tok.position
					end
				end
				ln := ln .next
			end
			Result := r_ln.indentation
		end
						
feature -- Search

	find_feature_named (a_name: STRING) is
			-- Look for a feature named `a_name' in the text.
			-- If `a_name' is found, `found_feature' is set to True
			-- and `cursor' is moved to `a_name' position.
		require
			text_loaded: reading_text_finished
		local
			tok: EDITOR_TOKEN
			ln: EDITOR_LINE
			low, low2: STRING
		do
			found_feature := False
			if has_selection then
				disable_selection
			end
			if click_and_complete_is_active and then click_tool.is_ready then
				low := clone (a_name)
				low.to_lower
				from
					ln := first_line
					tok := ln.first_token
				until
					tok = Void or found_feature
				loop
					if tok.is_feature_start then
						low2 := clone (tok.image)
						low2.to_lower
						found_feature := low2.is_equal (low)
						if found_feature then
							cursor.make_from_relative_pos (ln, tok, 1, Current)
						end
					end
					tok := tok.next
					if tok = Void and then ln.next /= Void then
						ln := ln.next
						tok := ln.first_token
					end
				end
			end
		end	

	found_feature: BOOLEAN	
			-- Was the last searched feature found?

	reset_text is
			-- Make the editor ready to load a new content
		do
			{CLICKABLE_TEXT} Precursor
			disable_click_tool
			click_tool.reset
		end

feature -- Pick and drop

	stone_at (cursr: like cursor): STONE is
			-- Stone corresponding to word at `cursor' position.
		do
			if not Workbench.is_compiling then
				if click_and_complete_is_active and then click_tool.is_ready then
					Result := click_tool.stone_at_position (cursr)
				else
					Result := Precursor {CLICKABLE_TEXT}(cursr)
				end
			end
		end

feature -- Completion-clickable initialization / update

	setup_click_tool (stone: STONE; file_std_is_win: BOOLEAN) is
			-- prepare `click_tool' before file is read.
		do
			if click_tool_enabled then
				click_tool.set_file_standard_is_windows (file_std_is_win)
				reinitialize_click_and_complete_tool (stone, False)
				if current_class_is_clickable then
					click_tool.build_features_arrays
					click_tool.reset_setup_lines_variables
				end
			else
				current_class_is_clickable := False
			end
		end

	reinitialize_click_and_complete_tool (stone: STONE; after_save: BOOLEAN) is
			-- check if it is possible to use `click_tool' with class corresponding to `stone'
			-- and set `current_class_is_clickable' accordingly.
			-- `after_save' must be True if current class text has just been saved
			-- and False otherwise.
			-- `stone' must correspond to the text to be loaded.
		require
			click_tool_enabled
		local
			classi_stone: CLASSI_STONE
		do
			current_class_is_clickable := False
			click_tool_status := no_error
			click_tool.reset
			classi_stone ?= stone
			if classi_stone /= Void and then classi_stone.is_valid then
				if classi_stone.class_name /= Void and then classi_stone.cluster /= Void and then classi_stone.cluster.cluster_name /= Void then
					click_tool.initialize (Current, classi_stone.class_name, classi_stone.cluster.cluster_name, after_save)
					current_class_is_clickable := click_tool.can_analyze_current_class
					if click_tool.last_syntax_error = Void then
						if current_class_is_clickable and then not classi_stone.class_name.is_equal (click_tool.current_class_as.class_name) then
							current_class_is_clickable := False
							click_tool_status := class_name_changed
						end
					else
						click_tool_status := syntax_error
					end
				end
			end
		end


	update_click_list (a_stone: STONE; after_save: BOOLEAN) is
			-- update the click tool
			-- `after_save' must be True if current class text has just been saved
			-- and False otherwise.
			-- `stone' must correspond to the text.
		require
			click_tool_enabled
		do
			reinitialize_click_and_complete_tool (a_stone, after_save)
			if click_and_complete_is_active then
				click_tool.update
			end
		end

	prepare_auto_complete (add_point: BOOLEAN) is
			-- Use `click_tool' to determine whether there is some
			-- name to be completed at `cursor' position and set
			-- `auto_complete_is_possible' accordingly.
			-- If it is, strings that can possibly be used for completion
			-- are available in `completion_possibilities'.
		require
			click_and_complete_is_active
		local
			i: INTEGER
		do
			history.record_move
			auto_complete_possible := False
			if add_point then
				insert_char ('.')
					-- will prevent `click_tool' from considering
					-- what precedes as the name to be completed.
			end
			click_tool.build_completion_list (cursor)
			if click_tool.completion_possibilities /= Void then
				if click_tool.insertion_count > 0 then
						-- there is a word before `cursor' that can be
						-- completed.
						-- Let's wipe it out and display proposals
					from
						i := 1
					until
						i > click_tool.insertion_count
					loop 
						i := i + 1
						back_delete_char
					end
					history.bind_current_item_to_next
				end
				auto_complete_possible := True
			elseif add_point then
					-- We should have added a point.
					-- Let's remove any clue in the undo redo stack.
				undo
				history.remove_last_redo							
			end
		end
		
	prepare_class_name_complete is
			-- Use `click_tool' to determine whether there is some
			-- name to be completed at `cursor' position.
			-- If it is, strings that can possibly be used for completion
			-- are available in `class_completion_possibilities'.
		local
			i: INTEGER
		do
			history.record_move
			auto_complete_possible := False
			click_tool.build_class_completion_list (cursor)
			if click_tool.class_completion_possibilities /= Void then
				if click_tool.insertion_count > 0 then
						-- there is a word before `cursor' that can be
						-- completed.
						-- Let's wipe it out and display proposals
					from
						i := 1
					until
						i > click_tool.insertion_count
					loop 
						i := i + 1
						back_delete_char
					end
					history.bind_current_item_to_next
				end
				auto_complete_possible := True
			end
		end

	auto_complete_possible: BOOLEAN
			-- Did `prepare_auto_complete' manage to find a list of completion proposals?

	completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Completions proposals found by `prepare_auto_complete'
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.completion_possibilities
			end
		end

class_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Completions proposals found by `prepare_auto_complete'
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.class_completion_possibilities
			end
		end

	feature_name_part_to_be_completed: STRING is
			-- Word, which is the beginning of feature names, which is being completed.
		do
			if click_tool /= Void and then auto_complete_possible then
				if click_tool.insertion.valid_index (2) and then not click_tool.insertion.item (2).is_empty then
					Result := click_tool.insertion.item (2)
				end
			end
		end

	complete_feature_call (completed: STRING; is_feature_signature: BOOLEAN) is
			-- Finish completion process be inserting the completed expression.
		require
			completion_proposals_found: auto_complete_possible
		local
			x: INTEGER
			y: INTEGER
		do
			if click_tool.insertion.valid_index (1) and then not click_tool.insertion.item (1).is_empty then
				if completed.item (1) = ' ' then
				back_delete_char
				history.bind_current_item_to_next
				else
					completed.remove (1)
				end
			end
			x := cursor.x_in_characters
			y := cursor.y_in_lines
			insert_string (completed)

			if is_feature_signature and then completed.last_index_of (')',completed.count) = completed.count then
				selection_cursor := clone (cursor)
				cursor.set_y_in_lines (y)
				cursor.set_x_in_characters (x)
			end
		end

feature -- Syntax completion

	complete_syntax (keyword: STRING; keyword_already_present, newline: BOOLEAN) is
			-- Complete syntax after `keyword' according to what is specified in
			-- the preferences. If `keyword_already_present', completion will use
			-- preferences for keyword that were not typed immediatly before 
			-- completion was triggered. If `newline', the preference for Return will
			-- be used, the one for Space otherwise.
			-- If feature modified `Current', then `syntax_completed' is set to True.
		require
			keyword_is_not_void: keyword /= Void
		local
			insert: STRING
			kw: STRING
			index: INTEGER
		do
			syntax_completed := False
			kw := clone (keyword)
			kw.to_lower
			index := Editor_preferences.completed_keywords.index_of (kw, 1)

			if index /= 0 and then Editor_preferences.syntax_complete_enabled and then Editor_preferences.complete_keywords.item (index) then
				if keyword_already_present then
					if newline then
						insert := Editor_preferences.insert_after_keyword.item (index).item (2)
					else
						insert := Editor_preferences.insert_after_keyword.item (index).item (1)
					end
				else
					if newline then
						insert := Editor_preferences.insert_after_keyword.item (index).item (4)
					else
						insert := Editor_preferences.insert_after_keyword.item (index).item (3)
					end
				end
				syntax_completed := True
			else
				if not newline then
					syntax_completed := True
					insert := " $cursor$"
				end
			end
			if syntax_completed then
				if newline then
					remove_white_spaces
				end
				insert_customized_expression (insert)
			end
		end

	syntax_completed: BOOLEAN
			-- Did latest call to `complete_syntax' modified `Current'?

	insert_customized_expression (expr: STRING) is
			-- Analyze syntax completion string preferences `expr', which may include "%N", "%T","%B",
			-- "$cursor$" and "$indent$" special character sequences.
			-- Insert the resulting expression defined by user in preferences at `cursor' position.
		local
			to_be_inserted: STRING
			indent: STRING
			char_nb, line_nb, char_offset, i: INTEGER
			et, bt: like begin_line_tokens
			ln: EDITOR_LINE
		do
			if expr /= Void and then not expr.is_empty then
				if has_selection and then not cursor.is_equal (selection_cursor) then
					delete_selection
				end
				has_selection := False 
				if Editor_preferences.smart_identation then
					indent := cursor.line.indentation
				else
					indent := ""
				end
				to_be_inserted := clone (expr)
				to_be_inserted.replace_substring_all ("$indent$", indent)
				from
					i := to_be_inserted.index_of ('%%', 1)
				until
					i < 1
				loop
					inspect
						to_be_inserted @ (i + 1)
					when '%%' then
						to_be_inserted.remove (i)
						i := i + 1
					when 'N' then
						to_be_inserted.remove (i)
						to_be_inserted.put ('%N', i)
						i := i + 1
					when 'T' then
						to_be_inserted.remove (i)
						to_be_inserted.remove (i)
						to_be_inserted.insert (tabulation_symbol, i)
						i := i + tabulation_symbol.count
					else
						i := i + 1
					end
					i := to_be_inserted.index_of ('%%', i)
				end

				char_nb := cursor.x_in_characters - 1
				ln := cursor.line
				record_modified_line (ln)
				bt := begin_line_tokens
				et := end_line_tokens
				if char_nb > 0 then
					to_be_inserted.prepend (ln.image.substring (1, char_nb))
					
					from
						i := 1
					until
						i > char_nb
					loop 
						i := i + 1
						back_delete_char
					end
					history.bind_current_item_to_next
				end

				from
					i := to_be_inserted.substring_index ("%%B", 1)
				until
					i = 0
				loop
					to_be_inserted.remove (i + 1)
					to_be_inserted.remove (i)
					if i > 1 and then to_be_inserted.item (i - 1) /= '%N' then
						to_be_inserted.remove (i - 1)
					end
					i := to_be_inserted.substring_index ("%%B", 1)
				end
				char_offset := to_be_inserted.substring_index("$cursor$", 1)
				to_be_inserted.replace_substring_all ("$cursor$", "")
				line_nb := cursor.y_in_lines
				char_nb := cursor.x_in_characters
				insert_string (to_be_inserted)
				cursor.make_from_character_pos (char_nb, line_nb, Current)
				from
					i := 1
				until
					i >= char_offset
				loop
					cursor.go_right_char
					i := i + 1
				end
				begin_line_tokens := bt
				end_line_tokens := et
				restore_tokens_properties_one_line (ln)
				history.record_move
			end
		end
			
feature {NONE}-- click information update

	restore_tokens_properties (begin_line, end_line: EDITOR_LINE) is
			-- Restore some token properties (position, beginning of a feature)
			-- using lists crated by `record...modified_line' procedures.
		local
			tok: EDITOR_TOKEN
			tfs: EDITOR_TOKEN_FEATURE_START
			stop: BOOLEAN
			tc: EDITOR_TOKEN_COMMENT
		do
			from
				tok := begin_line.first_token
				begin_line_tokens.start
			until
				begin_line_tokens.after or else tok = Void or else stop
			loop
				if begin_line_tokens.item.image.is_equal (tok.image) then
					tc ?= tok
						-- skip token if commented
					if tc = Void then
						if begin_line_tokens.item.is_feature_start then
							tfs ?= clone (begin_line_tokens.item)
							tfs.set_next_token (Void)
							tok.previous.set_next_token (tfs)
							tfs.set_previous_token (tok.previous)
							if tok.next /= Void then
								tfs.set_next_token (tok.next)
								tok.next.set_previous_token (tfs)
							end
							tok := tfs
						end
						tok.set_pos_in_text (begin_line_tokens.item.pos_in_text)
					end
					tok := tok.next
					begin_line_tokens.forth
				else
					stop := True
				end
			end
			from
				stop := False
				tok := end_line.eol_token
				end_line_tokens.start
			until
				end_line_tokens.after or else tok = Void or else stop
			loop
				if end_line_tokens.item.image.is_equal (tok.image) then
					tc ?= tok
						-- skip token if commented
					if tc = Void then 
						if end_line_tokens.item.is_feature_start then
							tfs ?= clone (end_line_tokens.item)
							tfs.set_next_token (Void)
							tok.previous.set_next_token (tfs)
							tfs.set_previous_token (tok.previous)
							if tok.next /= Void then
								tfs.set_next_token (tok.next)
								tok.next.set_previous_token (tfs)
							end
							tok := tfs
						end
						tok.set_pos_in_text (end_line_tokens.item.pos_in_text)
					end
					tok := tok.previous
					end_line_tokens.forth
				else
					stop := True
				end
			end
		end

	restore_tokens_properties_one_line (begin_line: EDITOR_LINE) is
			-- Restore some token properties (position, beginning of a feature)
			-- using lists crated by `record...modified_line' procedures.
		do
			restore_tokens_properties (begin_line, begin_line)
		end

feature {NONE} -- Implementation

	after_reading_idle_action is
			-- Prepare click tool when idle.
		do
			if click_and_complete_is_active and then not click_tool.is_ready then
				click_tool.prepare_on_click_analysis
			else
				{CLICKABLE_TEXT} Precursor
			end
		end

	new_line_from_lexer (line_image: STRING): EDITOR_LINE is
			-- Create new EDITOR_LINE with `lexer'.
			-- let `click_tool' add hidden information on tokens.
		do
			Result := {CLICKABLE_TEXT} Precursor (line_image)
			if current_class_is_clickable then
				click_tool.setup_line (Result)
			end
		end

	click_tool: EB_CLICK_AND_COMPLETE_TOOL
			-- Tool that finds types and stones from text tokens.

end -- class SMART_TEXT
