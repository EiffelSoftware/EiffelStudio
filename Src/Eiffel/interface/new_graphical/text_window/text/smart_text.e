note
	description: "[
			Editable eiffel code.
			Includes syntax completion and feature calls completion computation.
			Uses EB_CLICK_AND_COMPLETE_TOOL instance to search stones or types associated
			with text tokens.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SMART_TEXT

inherit
	CLICKABLE_TEXT
		export
			{EB_SMART_EDITOR} on_text_edited
		redefine
			insert_string, insert_char, delete_char, back_delete_char,
			restore_tokens_properties,
			restore_tokens_properties_one_line,
			reset_text,
			new_line_from_lexer,
			after_reading_idle_action,
			stone_at,
			make
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	EB_COMPLETION_POSSIBILITIES_PROVIDER
		redefine
			prepare_completion,
			completion_possible,
			reset
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature -- Initialization

	make
			-- Initialize text.
		do
			Precursor {CLICKABLE_TEXT}
			create click_tool
		end

feature -- Access

	last_syntax_error: SYNTAX_ERROR
			-- Syntax error found last time file was parsed.
		do
			if click_tool /= Void then
				Result := click_tool.last_syntax_error
			end
		end

	click_tool: EB_CLICK_AND_COMPLETE_TOOL
			-- Tool that finds types and stones from text tokens.

feature -- Edit linking mode

	enable_linked_editing (a_editor: EDITABLE_TEXT_PANEL; a_pos_in_text: INTEGER; a_regions: LIST [TUPLE [start_pos,end_pos: INTEGER]]; a_token_texts: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Activate linked edit at position `a_pos_in_text' if set, otherwise at cursor.
			-- And if `a_regions' is not empty, limit the impact token in those regions.
		require
			a_regions /= Void and then not a_regions.is_empty
		local
			lst: like linked_editing
		do
			disable_linked_editing
			lst := linked_editing
			if lst = Void then
				create lst.make (Current)
				linked_editing := lst
			end
			lst.prepare (a_editor, a_pos_in_text, a_regions, a_token_texts)
		end

	disable_linked_editing
			-- Disable any active linked editing session.
		do
			if attached linked_editing as m then
				m.clean
				linked_editing := Void
			end
		end

	linked_editing: detachable ES_CODE_EDITOR_LINKED_EDITING_MANAGER
			-- Active linked tokens editing sessions.

feature -- Element Change

	clear_syntax_error
			-- Set last_syntax_error to Void.
		do
			if click_tool /= Void then
				click_tool.clear_syntax_error
			end
		end

feature -- Status report

	exploring_current_class: BOOLEAN
			-- Is the completion being used to choose a feature of the current class (i.e. will a dotted
			-- notation be needed in completion)?
		do
			Result := click_tool.exploring_current_class
		end

	current_class_is_clickable: BOOLEAN
			-- Is the current syntaxically correct to be clickable?

	click_tool_enabled: BOOLEAN
			-- Should `Current' use `click_tool'?

	click_and_complete_is_active: BOOLEAN
			-- Can `click_tool' be used with currently opened class?
		do
			Result := current_class_is_clickable and then click_tool_enabled
		end

	click_tool_status: INTEGER
			-- `click_tool' status after initialization.

	no_error: INTEGER = 1
	syntax_error: INTEGER = 2
	class_name_changed: INTEGER = 3
			-- `click_tool_status' possible values.

	current_feature_containing : TUPLE [feat_as:FEATURE_AS; name: FEATURE_NAME]
			-- Feature containg current cursor.
			-- Void if not exists.
		do
			if cursor /= Void then
				Result := click_tool.feature_containing_cursor (cursor)
			end
		ensure
			valid_result: Result /= Void implies (Result.feat_as /= Void and Result.name /= Void)
		end

	syntax_is_correct: BOOLEAN
			-- When text was parsed, was a syntax error found?
		do
			Result := click_tool_status /= syntax_error
		end

feature -- Status setting

	enable_click_tool
			-- let `Current' use `click_tool'.
		do
			click_tool_enabled := True
		end

	disable_click_tool
			-- Prevent `Current' from using `click_tool'.
		do
			click_tool_enabled := False
		end

feature -- Basic Operations

	embed_in_block (keyword: STRING_32; pos_in_keyword: INTEGER)
			-- Embed selection or current line in block formed by `keyword' and "end".
			-- Cursor is positioned to the `pos_in_keyword'-th caracter of `keyword'.
		require
			not_empty: not is_empty
			keyword_not_void: keyword /= Void
			pos_in_keyword_valid: pos_in_keyword > 0 and then pos_in_keyword <= keyword.count
		local
			cur: like cursor
			indent: STRING_32
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
				selection_cursor := cursor.twin
				selection_cursor.go_start_line
				cursor.go_end_line
			end
			if cursor.y_in_lines = selection_cursor.y_in_lines then
				indent := cursor.line.wide_indentation
			else
				indent := smallest_indentation (selection_start, selection_end)
			end
			if not cursor.is_equal (selection_cursor) then
				indent_selection
				history.bind_current_item_to_next
			end
			if has_selection then
				internal_has_selection := False
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
			cursor.set_from_character_pos (1, selection_cursor.y_in_lines, Current)
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

	smallest_indentation (start_cursor, end_cursor: EDITOR_CURSOR): STRING_32
			-- Smallest indentation in lines between `start_cursor' and
			-- `end_cursor' (lines containing cursors are included).
			-- Lines with no indentation or blank lines are not
			-- taken into account.
		require
			cursors_in_the_right_order: start_cursor < end_cursor
			cursors_on_different_lines: start_cursor.line /= end_cursor.line
		local
			ln, r_ln: like line
			blnk: EDITOR_TOKEN_BLANK
			tok: EDITOR_TOKEN
			pos: INTEGER
		do
			from
				ln ?= start_cursor.line
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
			Result := r_ln.wide_indentation
		end

feature -- Search

	find_feature_named (a_name: STRING_32)
			-- Look for a feature named `a_name' in the text.
			-- If `a_name' is found, `found_feature' is set to True
			-- and `cursor' is moved to `a_name' position.
		require
			text_loaded: reading_text_finished
		local
			tok: detachable EDITOR_TOKEN
			l_line: like line
			low2: STRING_32
		do
			found_feature := False
			if has_selection then
				disable_selection
			end
			if click_tool_enabled then
				from
					l_line := first_line
					if l_line /= Void then
						tok := l_line.first_token
					else
							-- This should not happen but we have proof that it happens:
							-- See bug#18792, bug#18501 and bug#17626.
						check False end
					end
				until
					tok = Void or found_feature
				loop
					if tok.is_feature_start then
						if attached {FEATURE_STONE} tok.pebble as l_feature_stone then
							low2 := l_feature_stone.e_feature.name_32
						else
							low2 := tok.wide_image
						end
						found_feature := a_name.is_case_insensitive_equal (low2)
						if found_feature then
							cursor.set_from_relative_pos (l_line, tok, 1, Current)
						end
					end
					tok := tok.next
					if tok = Void and then attached l_line.next as l_next_line then
						l_line := l_next_line
						tok := l_line.first_token
					end
				end
			end
		end

	found_feature: BOOLEAN
			-- Was the last searched feature found?

	reset_text
			-- Make the editor ready to load a new content
		do
			Precursor {CLICKABLE_TEXT}
			disable_click_tool
			click_tool.reset
			disable_linked_editing
		end

feature -- History operation

	history_item_bind
			-- Bind current item in history stack to next.
		do
			history.bind_current_item_to_next
		end

	history_item_unbind
			-- Bind current item in history stack to next.
		do
			history.unbind_current_item_to_next
		end

feature -- Pick and drop

	stone_at (cursr: like cursor): detachable STONE
			-- Stone corresponding to word at `cursor' position.
		do
			if not Workbench.is_compiling then
				-- CHECK: almost same code as Precursor!!
				if click_and_complete_is_active and then click_tool.is_ready then
					Result := click_tool.stone_at_position (cursr)
					if
						Result = Void and then
					 	attached cursr.token as tok and then
					 	attached {like stone_at} tok.pebble as l_pebble_stone
					 then
						Result := l_pebble_stone.twin
					end
				else
					Result := Precursor {CLICKABLE_TEXT}(cursr)
				end
			end
		end

feature -- Completion-clickable initialization / update

	setup_click_tool (stone: STONE)
			-- prepare `click_tool' before file is read.
		do
			if click_tool_enabled then
				reinitialize_click_and_complete_tool (stone, False)
				if current_class_is_clickable then
					click_tool.build_features_arrays
					click_tool.reset_setup_lines_variables
				end
			else
				current_class_is_clickable := False
			end
		end

	reinitialize_click_and_complete_tool (stone: STONE; after_save: BOOLEAN)
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
				if
					classi_stone.class_name /= Void and then
					attached classi_stone.class_i as l_class_i and then
					not l_class_i.is_external_class and then
					attached classi_stone.group as l_group and then
					l_group.is_valid
				then
					click_tool.initialize (Current, l_class_i, l_group, after_save)
					current_class_is_clickable := click_tool.can_analyze_current_class
					if click_tool.last_syntax_error = Void then
						if
							current_class_is_clickable and then
							attached click_tool.current_class_as as l_curr_class_as
						then
							if l_class_i.config_class.name /~ l_curr_class_as.class_name.name then
--							if not l_class_i.config_class.name ~ (l_curr_class_as.class_name.name) then								
								current_class_is_clickable := False
								click_tool_status := class_name_changed
							end
						end
					else
						click_tool_status := syntax_error
					end
				end
			end
		end

	update_click_list (a_stone: STONE; after_save: BOOLEAN)
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

	prepare_feature_auto_complete (add_point: BOOLEAN)
			-- Use `click_tool' to determine whether there is some
			-- name to be completed at `cursor' position and set
			-- `auto_complete_is_possible' accordingly.
			-- If it is, strings that can possibly be used for completion
			-- are available in `feature_completion_possibilities'.
		require
			click_and_complete_is_active
		do
			history.record_move
			auto_complete_possible := False
			if add_point then
				insert_char ('.')
					-- will prevent `click_tool' from considering
					-- what precedes as the name to be completed.
			end

			click_tool.build_feature_completion_list (cursor)
			if
				attached click_tool.feature_completion_possibilities as l_completion_possibilities and then
				not l_completion_possibilities.is_empty
			then
				auto_complete_possible := True
			elseif add_point then
					-- We should have added a point.
					-- Let's remove any clue in the undo redo stack.
				undo
				history.remove_last_redo
			end
		end

	prepare_class_name_complete
			-- Determine whether there is some
			-- name to be completed at cursor position and set
			-- `auto_complete_is_possible' accordingly.
			-- If it is, strings that can possibly be used for completion
			-- are available in `class_completion_possibilities'.
		do
			history.record_move
			auto_complete_possible := False
			click_tool.build_class_completion_list (cursor)
			if click_tool.class_completion_possibilities /= Void then
				auto_complete_possible := True
			end
		end

	prepare_alias_name_complete
			-- Determine whether there is some
			-- name to be completed at cursor position and set
			-- `auto_complete_is_possible' accordingly.
			-- If it is, strings that can possibly be used for completion
			-- are available in `alias_completion_possibilities'.
		do
			history.record_move
			auto_complete_possible := False
			click_tool.build_alias_name_completion_list (cursor)
			auto_complete_possible := True
		end

	auto_complete_possible: BOOLEAN
			-- Did `prepare_feature_auto_complete' manage to find a list of completion proposals?

	feature_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- Completions proposals found by `prepare_feature_auto_complete'
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.feature_completion_possibilities
			end
		end

	class_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- Completions proposals found by `prepare_class_name_complete'
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.class_completion_possibilities
			end
		end

	alias_name_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- Completions proposals found by `prepare_alias_name_complete'
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.alias_name_completion_possibilities
			end
		end

	feature_name_part_to_be_completed: STRING
			-- Word, which is the beginning of feature names, which is being completed.
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.insertion.item
			end
		end

	feature_name_part_to_be_completed_remainder: INTEGER
			-- Number of characters past the cursor on the token currenly being completed.
		do
			if click_tool /= Void and then auto_complete_possible then
				Result := click_tool.insertion_remainder
			end
		end

	complete_feature_call (completed: STRING_32; is_feature_signature: BOOLEAN; appended_character: CHARACTER_32; remainder: INTEGER; a_select: BOOLEAN)
 			-- Finish completion process by inserting the completed expression.
		require
			completion_proposals_found: auto_complete_possible
		local
			x,
			y,
			i: INTEGER
			l_completed: STRING_32
		do
			l_completed := completed.twin
			if click_tool.insertion.item /= Void and then not click_tool.insertion.item.is_empty then --  valid_index (1) and then not click_tool.insertion.item (1).is_empty then
				if l_completed.item (1) = ' ' then
					back_delete_char
					history.bind_current_item_to_next
				end
			end
			x := cursor.x_in_characters
			y := cursor.y_in_lines
			if remainder > 0 then
				from
					i := 0
				until
					i = remainder
				loop
					delete_char
					i := i + 1
				end
			end
			l_completed.replace_substring_all (";", ",")
			l_completed.replace_substring_all ("#", "# ")
			insert_string (l_completed)

			if appended_character /= '%U' then
				insert_char (appended_character)
			end

			if a_select and then is_feature_signature and then l_completed.last_index_of (')',completed.count) = l_completed.count then
				selection_cursor := cursor.twin

				cursor.set_y_in_lines (y)
				cursor.set_x_in_characters (x)
				enable_selection
			end
		end

feature -- Syntax completion

	complete_syntax (keyword: STRING; keyword_already_present, newline: BOOLEAN)
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
		do
			syntax_completed := False
			kw := keyword.as_lower

			if
				editor_preferences.syntax_complete_enabled and then
				editor_preferences.is_keyword_auto_complete (kw) and then
				attached editor_preferences.keyword_inserts (kw) as l_inserts
			then

				if keyword_already_present then
					if newline then
						insert := l_inserts.custom_return
					else
						insert := l_inserts.custom_space
					end
				else
					if newline then
						insert := l_inserts.custom_return_later
					else
						insert := l_inserts.custom_space_later
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

	insert_customized_expression (expr: STRING_32)
			-- Analyze syntax completion string preferences `expr', which may include "%N", "%T","%B",
			-- "$cursor$" and "$indent$" special character sequences.
			-- Insert the resulting expression defined by user in preferences at `cursor' position.
		local
			to_be_inserted: STRING_32
			indent: STRING_32
			char_nb, line_nb, char_offset, i, start_sub: INTEGER
			et, bt: like begin_line_tokens
			ln: like line
		do
			if expr /= Void and then not expr.is_empty then
				if has_selection and then not cursor.is_equal (selection_cursor) then
					delete_selection
				end
				if editor_preferences.smart_indentation then
					indent := cursor.line.wide_indentation
				else
					indent := ""
				end
				to_be_inserted := expr.twin
				to_be_inserted.replace_substring_all ("$indent$", indent)
				from
					i := to_be_inserted.index_of ('%%', 1)
				until
					i < 1
				loop
					inspect
						to_be_inserted [i + 1]
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
						to_be_inserted.insert_string (tabulation_symbol, i)
						i := i + tabulation_symbol.count
					else
						i := i + 1
					end
					i := to_be_inserted.index_of ('%%', i)
				end

				char_nb := cursor.x_in_characters - 1
				ln ?= cursor.line
				record_modified_line (ln)
				bt := begin_line_tokens
				et := end_line_tokens
				if char_nb > 0 then
					to_be_inserted.prepend (ln.wide_image.substring (1, char_nb))

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
				start_sub := (char_nb + 1).max (1)
				from
					i := to_be_inserted.substring_index ("%%B", start_sub)
				until
					i = 0
				loop
					to_be_inserted.remove (i + 1)
					to_be_inserted.remove (i)
					if i > 1 and then to_be_inserted.item (i - 1) /= '%N' then
						to_be_inserted.remove (i - 1)
					end
					i := to_be_inserted.substring_index ("%%B", start_sub)
				end
				char_offset := to_be_inserted.substring_index("$cursor$", 1)
				if char_offset = 0 then
					char_offset := to_be_inserted.count + 1
				else
					to_be_inserted.replace_substring_all ("$cursor$", "")
				end
				line_nb := cursor.y_in_lines
				char_nb := cursor.x_in_characters
				insert_string (to_be_inserted)
				cursor.set_from_character_pos (char_nb, line_nb, Current)
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
				if line_nb < number_of_lines then
					mark_fake_trailing_blank (line (line_nb + 1), to_be_inserted.occurrences ('%N'))
				end
			end
		end

	insert_string (txt: READABLE_STRING_GENERAL)
			-- <Precursor>.
		local
			l_diff: INTEGER
		do
			if
				attached linked_editing as lnk
			then
				if is_word (txt) then
					l_diff := txt.count
					if not selection_is_empty then
						l_diff := l_diff - (selected_wide_string.count)
					end
					Precursor (txt)
					lnk.on_editor_insertion (cursor, l_diff)
				else
					disable_linked_editing
					Precursor (txt)
				end
			else
				Precursor (txt)
			end
		end

	insert_char (c: CHARACTER_32)
			-- <Precursor>.
		local
			l_diff: INTEGER
		do
			if
				attached linked_editing as lnk
			then
				inspect c
				when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
					l_diff := +1
					if not selection_is_empty then
						l_diff := l_diff - (selected_wide_string.count)
					end
					Precursor (c)
					lnk.on_editor_insertion (cursor, l_diff)
				else
					disable_linked_editing
					Precursor (c)
				end
			else
				Precursor (c)
			end
		end

	delete_char
			-- <Precursor>.
		local
			l_diff: INTEGER
		do
			if
				attached linked_editing as lnk
			then
				if selection_is_empty then
					l_diff := -1
				else
					l_diff := l_diff - (selected_wide_string.count)
				end
				Precursor
				lnk.on_editor_deletion (cursor, l_diff)
			else
				Precursor
			end
		end

	back_delete_char
			-- <Precursor>.
		local
			l_diff: INTEGER
		do
			if
				attached linked_editing as lnk
			then
				if selection_is_empty then
					l_diff := -1
				else
					l_diff := l_diff - (selected_wide_string.count)
				end
				Precursor
				lnk.on_editor_deletion (cursor, l_diff)
			else
				Precursor
			end
		end

feature {NONE} -- Helpers

	is_word (a_text: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_text' composed of word character?
		local
			i,n: INTEGER
		do
			from
				Result := True
				i := 1
				n := a_text.count
			until
				i > n or False
			loop
				inspect a_text[i]
				when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
				else
					Result := False
				end
				i := i + 1
			end
		end

feature {NONE} -- Possiblilities provider

	insertion: STRING_32
			-- Strings to be partially completed : the first one is the dot or tilda if there is one
			-- the second one is the feature name to be completed
		do
			Result := click_tool.insertion.item
		end

	insertion_remainder: INTEGER
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		do
			Result := click_tool.insertion_remainder
		end

	prepare_completion
			-- Prepare completion
		do
			Precursor
			click_tool.reset_completion_lists
			if provide_features then
				if click_and_complete_is_active then
					prepare_feature_auto_complete (False)
				end
			elseif provide_classes then
				prepare_class_name_complete
			elseif provide_alias_name then
				prepare_alias_name_complete
			end
		end

	reset
			-- Reset completion
		do
			if click_tool /= Void then
				click_tool.reset_completion_lists
			end
		end

	completion_possible: BOOLEAN
			-- Is completion possible?
		do
			Result := auto_complete_possible and then Precursor
		end

	cursor_token: EDITOR_TOKEN
			-- Token at cursor position
		do
			if cursor /= Void then
				Result := cursor.token
			end
		end

	current_pos_in_token: INTEGER
		do
			if cursor /= Void then
				Result := cursor.pos_in_token
			end
		end

feature {NONE} -- click information update

	restore_tokens_properties (begin_line, end_line: like line)
			-- Restore some token properties (position, beginning of a feature)
			-- using lists created by `record...modified_line' procedures.
		local
			tok: EDITOR_TOKEN
			tfs: EDITOR_TOKEN_FEATURE_START
			l_begin_line_token, l_end_line_token: EDITOR_TOKEN
			stop: BOOLEAN
		do
			from
				tok := begin_line.first_token
				begin_line_tokens.start
			until
				begin_line_tokens.after or else tok = Void or else stop
			loop
				l_begin_line_token := begin_line_tokens.item
				if l_begin_line_token.wide_image.is_equal (tok.wide_image) then
					tok.set_is_fake (l_begin_line_token.is_fake)
						-- skip token if commented
					if not attached {EDITOR_TOKEN_COMMENT} tok then
						if
							l_begin_line_token.is_feature_start and then
							attached {EDITOR_TOKEN_FEATURE_START} l_begin_line_token as l_feat_tok
						then
							tfs := l_feat_tok.twin

							tfs.set_next_token (Void)
							tok.previous.set_next_token (tfs)
							tfs.set_previous_token (tok.previous)
							tfs.update_position
							if attached tok.next as l_next_tok then
								tfs.set_next_token (l_next_tok)
								l_next_tok.set_previous_token (tfs)
							end
							tok := tfs
						end
						tok.set_pos_in_text (l_begin_line_token.pos_in_text)
					end
					tok := tok.next
					begin_line_tokens.forth
				else
					if l_begin_line_token.is_blank and then tok.is_blank then
						tok.set_is_fake (l_begin_line_token.is_fake)
					end
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
				l_end_line_token := end_line_tokens.item
				if l_end_line_token.wide_image.is_equal (tok.wide_image) then
					tok.set_is_fake (l_end_line_token.is_fake)
						-- skip token if commented
					if not attached {EDITOR_TOKEN_COMMENT} tok then
						if
							l_end_line_token.is_feature_start and then
							attached {EDITOR_TOKEN_FEATURE_START} l_end_line_token as l_feat_tok
						then
							tfs := l_feat_tok.twin
							tfs.set_next_token (Void)
							tok.previous.set_next_token (tfs)
							tfs.set_previous_token (tok.previous)
							tfs.update_position
							if attached tok.next as l_next_tok then
								tfs.set_next_token (l_next_tok)
								l_next_tok.set_previous_token (tfs)
							end
							tok := tfs
						end
						tok.set_pos_in_text (l_end_line_token.pos_in_text)
					end
					tok := tok.previous
					end_line_tokens.forth
				else
					if l_end_line_token.is_blank and then tok.is_blank then
						tok.set_is_fake (l_end_line_token.is_fake)
					end
					stop := True
				end
			end
		end

	restore_tokens_properties_one_line (begin_line: like line)
			-- Restore some token properties (position, beginning of a feature)
			-- using lists crated by `record...modified_line' procedures.
		do
			restore_tokens_properties (begin_line, begin_line)
		end

feature {NONE} -- Implementation

	after_reading_idle_action
			-- Prepare click tool when idle.
		do
			if click_and_complete_is_active and then not click_tool.is_ready then
				click_tool.prepare_on_click_analysis
			else
				Precursor {CLICKABLE_TEXT}
			end
		end

	new_line_from_lexer (line_image: STRING; a_windows_style: BOOLEAN): like line
			-- <precursor>
		do
			Result ?= Precursor {CLICKABLE_TEXT} (line_image, a_windows_style)
			if current_class_is_clickable then
				click_tool.setup_line (Result)
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class SMART_TEXT
