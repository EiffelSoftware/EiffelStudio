indexing
	description: "[
		Editable text with cursor and selection.
		Changes in text are stored in an UNDO_REDO_STACK and
		are undo- and redoable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITABLE_TEXT

inherit
	SELECTABLE_TEXT
		export
			{UNDO_REDO_STACK} on_text_back_to_its_last_saved_state
		redefine
			reset_text,
			make,
			on_text_loaded,
			cursor,
			set_changed
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- create an empty text
		do
			Precursor {SELECTABLE_TEXT}
			create history.make (Current)
			if Editor_preferences.use_tab_for_indentation then
				tabulation_symbol := "%T"
			else
				create tabulation_symbol.make (editor_preferences.tabulation_spaces)
				tabulation_symbol.fill_character (' ')
			end
		end

feature -- Access

	history: UNDO_REDO_STACK
			-- Set of undo and redoable commands on text

	cursor: EDITOR_CURSOR
			-- Current cursor.

	tabulation_symbol: STRING
			-- String representing a tab.
			-- Is '%T' or as many blank spaces as defined in
			-- the preferences

feature -- Status Report

	use_smart_indentation: BOOLEAN is
			-- Is smart_indentation enabled?
		do
			Result := editor_preferences.smart_identation
		end

	redo_is_possible: BOOLEAN is
			-- is there anything in the redo stack ?
		do
			Result := (not is_empty) and then history.redo_is_possible
		end

	undo_is_possible: BOOLEAN is
			-- is there anything in the undo stack ?
		do
			Result := (not is_empty) and then history.undo_is_possible
		end

feature -- Status setting

	set_changed (value: BOOLEAN; directly_edited: BOOLEAN) is
			-- Assign `value' to `changed'
		do
			if value then
				history.disable_mark
			else
				history.enable_mark
				history.set_mark
			end
			Precursor (value, directly_edited)
		end

feature -- Basic Operations

	undo is
			-- undo last command
		do
			ignore_cursor_moves := True
			on_text_edited (True)
			if has_selection then
				disable_selection
			end
			history.undo
			ignore_cursor_moves := False
		end

	redo is
			-- redo last command
		do
			ignore_cursor_moves := True
			on_text_edited (True)
			if has_selection then
				disable_selection
			end
			history.redo
			ignore_cursor_moves := False
		end

	delete_selection is
			-- delete selected text.
		local
			begin_sel, end_sel: like cursor
			removed: STRING
			line_number: INTEGER
			char_num: INTEGER
		do
			if has_selection then
				ignore_cursor_moves := True
				if not cursor.is_equal (selection_cursor) then
					begin_sel := selection_start
					end_sel := selection_end
					line_number := begin_sel.y_in_lines
					char_num := begin_sel.x_in_characters
					removed := string_selected (begin_sel, end_sel)
					remove_selection (begin_sel, end_sel)
					cursor.make_from_character_pos (char_num, line_number, Current)
					history.record_delete_selection (removed)
					set_selection_cursor (cursor)

				end
				disable_selection
				ignore_cursor_moves := False
			end
		end

	replace_selection (a_word: STRING) is
			-- replace the selected text with `a_word'
		require
			selection_present: has_selection
			selection_not_empty: selection_cursor /= cursor
		local
			begin_sel, end_sel: like cursor
			removed: STRING
			line_number: INTEGER
			char_num: INTEGER
		do
			ignore_cursor_moves := True
			begin_sel := selection_start
			end_sel := selection_end
			line_number := begin_sel.y_in_lines
			char_num := begin_sel.x_in_characters
			removed := string_selected (begin_sel, end_sel)
			remove_selection (begin_sel, end_sel)
			cursor.make_from_character_pos (char_num, line_number, Current)
			history.record_replace_selection (removed, a_word)
			insert_string_at_cursor_pos (a_word)
			disable_selection
			ignore_cursor_moves := False
		end

	set_selection_case (lower: BOOLEAN) is
			-- Change selected text to lower case if `lower',
			-- else to upper case.
		local
			txt: STRING
			l1, l2, x1, x2: INTEGER
		do
			ignore_cursor_moves := True
			if not selection_is_empty then
				l1 := selection_cursor.y_in_lines
				l2 := cursor.y_in_lines
				x1 := selection_cursor.x_in_characters
				x2 := cursor.x_in_characters
				txt := selected_string
				if lower then
					txt.to_lower
				else
					txt.to_upper
				end
				replace_selection (txt)
				selection_cursor.make_from_character_pos (x1, l1, Current)
				cursor.make_from_character_pos (x2, l2, Current)
				enable_selection
			end
			ignore_cursor_moves := False
		end

	comment_selection is
			-- Comment all lines included in the selection with the string `--'.
		do
			ignore_cursor_moves := True
			if not has_selection then
				set_selection_cursor (cursor)
			end
			history.record_symbol (selection_start, selection_end, "--")
			symbol_selection(selection_start, selection_end, "--")
			ignore_cursor_moves := False
		end

	uncomment_selection is
			-- Uncomment all lines included in the selection with the string `--'.
		local
			ln: EDITOR_LINE
			end_loop, cursor_start: BOOLEAN
			l_comment_token: EDITOR_TOKEN_COMMENT
			start_pos, end_pos, start_line, end_line: INTEGER
			start_selection, end_selection: like cursor
			l_offset: INTEGER
		do
			ignore_cursor_moves := True

			if has_selection then
				start_selection := selection_start.twin
				end_selection := selection_end.twin
			else
				start_selection := cursor.twin
				end_selection := cursor.twin
			end
			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			start_line := start_selection.y_in_lines
			end_line := end_selection.y_in_lines
			cursor_start := (cursor = start_selection)

			from
				ln := start_selection.line
			until
				ln = Void or else ln = end_selection.line.next
			loop
				from
					ln.start
					end_loop := false
				until
					ln.after or end_loop
				loop
					if ln.item.is_text then
						l_comment_token ?= ln.item
						if l_comment_token /= Void then
							create cursor.make_from_relative_pos (ln, l_comment_token, 1, Current)
							delete_n_chars_at_cursor_pos (2)
							history.record_uncomment ("--")
							if ln = start_selection.line then
								l_offset := start_pos - cursor.x_in_characters
								if l_offset > 0 and l_offset <= 2 then
									start_pos := (start_pos - l_offset).max (1)
								elseif l_offset > 2 then
									start_pos := (start_pos - 2).max (1)
								end
							end
							if ln = end_selection.line then
								l_offset := end_pos - cursor.x_in_characters
								if l_offset > 0 and l_offset <= 2 then
									end_pos := (end_pos - l_offset).max (1)
								elseif l_offset > 2 then
									end_pos := (end_pos - 2).max (1)
								end
							end
						end
						end_loop := true
					end
					ln.forth
				end
				ln := ln.next
			end
			if cursor_start then
				create cursor.make_from_character_pos (start_pos, start_line, Current)
				set_selection_cursor (create {EDITOR_CURSOR}.make_from_character_pos (end_pos, end_line, Current))
			else
				create cursor.make_from_character_pos (end_pos, end_line, Current)
				set_selection_cursor (create {EDITOR_CURSOR}.make_from_character_pos (start_pos, start_line, Current))
			end
			if has_selection then
				enable_selection
			end
			ignore_cursor_moves := False
		end

	indent_selection is
			-- Tabify all lines included in the selection.
		do
			ignore_cursor_moves := True
			if not has_selection then
				set_selection_cursor (cursor)
			end
			history.record_symbol (selection_start, selection_end, tabulation_symbol)
			symbol_selection(selection_start, selection_end, tabulation_symbol)
			ignore_cursor_moves := False
		end

	unindent_selection is
			-- Tabify all lines included in the selection.
		do
			ignore_cursor_moves := True
			if not has_selection then
				set_selection_cursor (cursor)
			end
			unsymbol_selection(selection_start, selection_end, tabulation_symbol)
			if unsymboled_lines.count > 0 then
					-- something was done
				history.record_unsymbol (unsymboled_lines, tabulation_symbol)
			end
			ignore_cursor_moves := False
		end

	remove_trailing_blanks is
			-- Remove trailing blanks, this will be recorded in history stack, but invisible to user.
			-- Blanks before the cursor are not removed.
		local
			l_token, cursor_token: EDITOR_TOKEN
			end_loop: BOOLEAN
			l_cursor: like cursor
		do
			l_cursor := cursor
			cursor_token := l_cursor.token.previous
			from
				start
			until
				after
			loop
				from
					l_token := current_line.eol_token.previous
					end_loop := false
				until
					l_token = Void or end_loop
				loop
					if l_token.is_blank then
						if cursor_token = l_token then
							end_loop := true
						else
							if l_token.previous /= Void then
								l_token.previous.set_next_token (l_token.next)
							end
							l_token.next.set_previous_token (l_token.previous)
							create cursor.make_from_relative_pos (current_line, l_token.next, 1, Current)
							history.record_remove_trailing_blank (l_token.image)
						end
					else
						end_loop := true
					end
					if not end_loop then
						l_token := l_token.previous
					end
				end
				current_line.update_token_information
				forth
			end
			cursor := l_cursor
		end

	remove_trailing_fake_blanks is
			-- Remove trailing fake (inserted automatically) blanks,
			-- this will be recorded in history stack, but invisible to user.
		local
			l_token, cursor_token: EDITOR_TOKEN
			end_loop: BOOLEAN
			l_cursor: like cursor
		do
			l_cursor := cursor
			cursor_token := l_cursor.token.previous
			from
				start
			until
				after
			loop
				from
					l_token := current_line.eol_token.previous
					end_loop := false
				until
					l_token = Void or end_loop
				loop
					if l_token.is_blank then
						if l_token.is_fake then
							if l_token.previous /= Void then
								l_token.previous.set_next_token (l_token.next)
							end
							l_token.next.set_previous_token (l_token.previous)
							create cursor.make_from_relative_pos (current_line, l_token.next, 1, Current)
							history.record_remove_trailing_blank (l_token.image)
						else
							end_loop := true
						end
					else
						end_loop := true
					end
					if not end_loop then
						l_token := l_token.previous
					end
				end
				current_line.update_token_information
				forth
			end
			cursor := l_cursor
		end


	insert_char (c: CHARACTER) is
			-- Insert `c' at the cursor position.
			-- Delete selection if any.
		require
			text_not_empty: not is_empty
		do
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			end
			ignore_cursor_moves := True
			history.record_insert (c)
			insert_char_at_cursor_pos (c)
			ignore_cursor_moves := False
			if has_selection then
				disable_selection
			end
		end

	insert_string (txt: STRING) is
			-- Insert `txt' at cursor position.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		do
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			end
			ignore_cursor_moves := True
			history.record_paste (txt)
			insert_string_at_cursor_pos (txt)
			ignore_cursor_moves := False
			if has_selection then
				disable_selection
			end
		end

	insert_eol is
			-- Insert new line at cursor position.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		local
			indent: STRING
		do
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			end
			ignore_cursor_moves := True
			if use_smart_indentation then
				indent := cursor.line.indentation
				if cursor.x_in_characters <= indent.count then
					indent.keep_head (cursor.x_in_characters - 1)
				end
				history.record_insert_eol (indent)
			else
				history.record_insert_eol ("")
			end
			insert_eol_at_cursor_pos
			mark_fake_trailing_blank (cursor.line, 1)
			ignore_cursor_moves := False
			history.record_move
			if has_selection then
				disable_selection
			end
		end

	insert_string_as_selectable (txt: STRING) is
			-- Insert `txt' at cursor position as a selectable token			
		require
			text_not_empty: not is_empty
		do
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			end
			ignore_cursor_moves := True
			history.record_paste (txt)
			insert_string_as_selectable_at_cursor_pos (txt)
			ignore_cursor_moves := False
			if has_selection then
				disable_selection
			end
		end

	replace_char (c: CHARACTER) is
			-- Replace character at cursor position by `c'.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		do
			ignore_cursor_moves := True
			if selection_is_empty then
				history.record_replace (cursor.item, c)
				replace_char_at_cursor_pos (c)
			else
				delete_selection
				ignore_cursor_moves := True
				history.bind_current_item_to_next
				history.record_replace ('%N', c)
						--| This is a trick to consider
						--| the insertion as a replace.
				insert_char_at_cursor_pos (c)
			end
			ignore_cursor_moves := False
			if has_selection then
				disable_selection
			end
		end

	delete_char is
			-- Delete character at cursor position.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		do
			ignore_cursor_moves := True
			if selection_is_empty then
				history.record_delete (cursor.item)
				delete_char_at_cursor_pos
			else
				delete_selection
				ignore_cursor_moves := True
			end
			ignore_cursor_moves := False
			if has_selection then
				disable_selection
			end
		end

	back_delete_char is
			-- Delete character before cursor position.
			-- Delete selection, if any.
		do
			if not selection_is_empty then
					delete_selection
			elseif	(cursor.line.previous /= Void)
					or else
				(cursor.token /= cursor.line.first_token)
					or else
				(cursor.pos_in_token > 1)
			then
				ignore_cursor_moves := True
				cursor.go_left_char
				if	use_smart_indentation
						and then
					cursor.token = cursor.line.eol_token
						and then
					first_non_blank_token (cursor.line) = cursor.token
				then
					cursor.go_start_line
					remove_white_spaces
					history.record_move
				end
				history.record_back_delete (cursor.item)
				delete_char_at_cursor_pos
				ignore_cursor_moves := False
			end
			if has_selection then
				disable_selection
			end
		end

	delete_word (back: BOOLEAN) is
			-- Delete word before cursor position if `back',
			-- or else at cursor position.
			-- Delete selection, if any.
		do
			ignore_cursor_moves := True
			if selection_is_empty then
				set_selection_cursor (cursor)
				if back then
					selection_cursor.go_left_word
				else
					cursor.go_right_word
				end
				enable_selection
			end
			delete_selection
			ignore_cursor_moves := False
		end

	move_selection_to_pos (i:INTEGER) is
			--
		require
			selection_exists: has_selection
		local
			offset: INTEGER
			local_clipboard: STRING
		do
			local_clipboard := selected_string
			offset := selection_end.pos_in_text
			if has_selection and then not cursor.is_equal (selection_cursor) then
				delete_selection
				history.bind_current_item_to_next
			end
			if i >= offset then
				cursor.make_from_integer (i - local_clipboard.count, Current)
			else
				cursor.make_from_integer (i, Current)
			end
			insert_string (local_clipboard)
		end

	copy_selection_to_pos (i:INTEGER) is
			--
		require
			selection_exists: has_selection
		local
			local_clipboard: STRING
		do
			local_clipboard := selected_string
			disable_selection
			cursor.make_from_integer (i, Current)
			insert_string (local_clipboard)
		end

feature {EB_SEARCH_PERFORMER} -- for search only

	replace_for_replace_all (start_pos, end_pos: INTEGER; a_word: STRING) is
			-- replace the selected text with `a_word'
		require
			right_order: start_pos < end_pos
			word_is_not_void: a_word /= Void
		local
			removed: STRING
			line_number: INTEGER
			char_num: INTEGER
		do
			ignore_cursor_moves := True
			selection_cursor.make_from_integer (start_pos, Current)
			cursor.make_from_integer (end_pos, Current)
			enable_selection
			line_number := selection_cursor.y_in_lines
			char_num := selection_cursor.x_in_characters
			removed := string_selected (selection_cursor, cursor)
			remove_selection (selection_cursor, cursor)
			cursor.make_from_character_pos (char_num, line_number, Current)
			history.record_replace_all (removed, a_word)
			insert_string_at_cursor_pos (a_word)
			disable_selection
			ignore_cursor_moves := False
		end

feature -- Reinitialization

	reset_text is
			-- put Current back in its original state
		do
			Precursor {SELECTABLE_TEXT}
			history.initialize
		end

	on_text_loaded is
			-- reinitialize text after loading.
		do
				-- Initialize undo-redo history
			history.reset
			history.set_mark

			Precursor {SELECTABLE_TEXT}
		end

feature {UNDO_CMD} -- Operations on selected text

	symbol_selection (start_selection: like cursor; end_selection: like cursor; symbol: STRING) is
			-- Prepend all lines included in the selection with the string `symbol'.
			-- Even if `start_selection' does not begin the line, the entire line
			-- is prepended with `symbol'. Same for the last line of the selection.
			-- Warning: Changes are not recorded in the undo stack.
		require
			valid_selection: start_selection /= Void and end_selection /= Void
			right_order: start_selection <= end_selection
			valid_symbol: symbol /= Void and then not symbol.is_empty
		local
			line_image	: STRING		-- String representation of the current line
			ln			: like current_line	-- Current line
			start_pos	: INTEGER
			end_pos		: INTEGER
			y_line		: INTEGER
			l_cursor	: INTEGER
			l_line_modified: BOOLEAN	-- The line cursor at is modified.
		do
			on_text_edited (True)
			l_cursor := cursor.x_in_characters
			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			from
				ln := start_selection.line
				y_line := start_selection.y_in_lines
			until
				ln = end_selection.line or ln.index = end_selection.y_in_lines
			loop
				record_modified_line (ln)

					-- Retrieve the string representation of the line
				line_image := ln.image

					-- Add the commentary symbol in front of the line
				line_image.prepend (symbol)
				if ln = cursor.line then
					l_line_modified := true
				end

					-- Rebuild line from the lexer.
				lexer.set_in_verbatim_string (False)
				if line_image.is_empty then
					ln.make_empty_line
				else
					lexer.execute (line_image)
					ln.rebuild_from_lexer (lexer, False)
				end

				if ln = start_selection.line then
						-- shift the selection cursor
					if start_pos = 1 then
						start_selection.set_x_in_characters(1)
					else
						start_selection.set_x_in_characters(start_pos + symbol.count)
					end
				end

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties_one_line (ln)
				on_line_modified (y_line)

					-- Prepare next iteration
				y_line := y_line + 1
				ln := ln.next
			end

				-- handle the last line differently because if the cursor is on the
				-- first character, we do not want to add the symbol, unless
				-- there is no selection
			if 	end_selection.token /= ln.first_token
					or else
				end_selection.pos_in_token /= 1
					or else
				start_selection.is_equal (end_selection)
			then
				record_modified_line (ln)

					-- Retrieve the string representation of the line
				line_image := ln.image

					-- Add the commentary symbol in front of the line
				line_image.prepend(symbol)
				if ln = cursor.line then
					l_line_modified := true
				end

					-- Rebuild line from the lexer.
				lexer.set_in_verbatim_string (False)
				if line_image.is_empty then
					ln.make_empty_line
				else
					lexer.execute (line_image)
					ln.rebuild_from_lexer (lexer, False)
				end

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties_one_line (ln)

					-- shift the selection cursors

					-- in case there is just one line
				if ln = start_selection.line then
						-- shift the selection cursor
					if start_pos = 1 then
						start_selection.set_x_in_characters(1)
					else
						start_selection.set_x_in_characters(start_pos + symbol.count)
					end
				end
				end_selection.set_x_in_characters(end_pos + symbol.count)
			end
			if l_line_modified and l_cursor > 1 then
				cursor.set_x_in_characters (l_cursor + symbol.count)
			end
		end

	unsymbol_selection (start_selection: like cursor; end_selection: like cursor; symbol: STRING) is
			-- Prepend all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is prepended with `symbol'. Same for the last line of the selection.
			-- A line is uncommented only if it begins with `symbol'.
			-- Warning: Changes are not recorded in the undo stack.
		require
			valid_selection: start_selection /= Void and end_selection /= Void
			right_order: start_selection <= end_selection
			valid_symbol: symbol /= Void and then not symbol.is_empty
		local
			line_image	: STRING		-- String representation of the current line
			ln		: like current_line	-- Current line
			symbol_length	: INTEGER		-- number of characters in `symbol'
			start_pos	: INTEGER
			end_pos		: INTEGER
			l_cursor: INTEGER
			l_line_modified: BOOLEAN	-- The line cursor at is modified.
		do
			on_text_edited (True)
			l_cursor := cursor.x_in_characters

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			symbol_length := symbol.count
			create unsymboled_lines.make
			from
				ln := start_selection.line
			until
				ln = end_selection.line or ln.index = end_selection.y_in_lines
			loop
					-- Retrieve the string representation of the line
				line_image := ln.image

					-- Remove the commentary symbol in front of the line (if any)
				if (line_image.count >= symbol_length) and then (line_image.substring(1, symbol_length).is_equal(symbol)) then
					if ln = cursor.line then
						l_line_modified := true
					end
					record_modified_line (ln)

					line_image := line_image.substring(symbol_length + 1, line_image.count)
					unsymboled_lines.extend(ln.index)
						-- Rebuild line from the lexer.
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if line_image.is_empty then
						ln.make_empty_line
					else
						lexer.execute (line_image)
						ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
					end

						-- reset pos_in_file values of tokens if possible
					restore_tokens_properties_one_line (ln)

						-- shift the selection cursor
					if ln = start_selection.line then
						start_selection.set_x_in_characters((start_pos - symbol_length).max (1))
					end
				end

					-- Prepare next iteration
				ln := ln.next
			end

				-- handle the last line differently because if the cursor is on the
				-- first character, we do not want to remove the symbol, unless
				-- there is no selection
			if 	end_selection.token /= ln.first_token
					or else
				end_selection.pos_in_token /= 1
					or else
				start_selection.is_equal (end_selection)
			then
					-- Retrieve the string representation of the line
				line_image := ln.image

					-- Remove the commentary symbol in front of the line (if any)
				if (line_image.count >= symbol_length) and then (line_image.substring(1, symbol_length).is_equal(symbol)) then
					record_modified_line (ln)
					if ln = cursor.line then
						l_line_modified := true
					end
					line_image := line_image.substring(symbol_length + 1, line_image.count)
					unsymboled_lines.extend (ln.index)
						-- Rebuild line from the lexer.	
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if line_image.is_empty then
						ln.make_empty_line
					else
						lexer.execute (line_image)
						ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
					end

						-- reset pos_in_file values of tokens if possible
					restore_tokens_properties_one_line (ln)

						-- shift the selection cursor

						-- in case there is just_one_line
					if ln = start_selection.line then
						start_selection.set_x_in_characters((start_pos - symbol_length).max (1))
					end
					end_selection.set_x_in_characters((end_pos - symbol_length).max (1))
				end
			end
			if l_line_modified then
				cursor.set_x_in_characters ((l_cursor - symbol_length).max (1))
			end
		end

	remove_selection (start_selection: like cursor; end_selection: like cursor) is
			-- Delete text between `start_selection' until `end_selection'.
			-- `end_selection' is not included.
			-- Warning: Changes are not recorded in the undo stack.
		require
				right_order: start_selection < end_selection
		local
			s: STRING
			ln: like current_line
			t : EDITOR_TOKEN
			line_number: INTEGER
			x: INTEGER
		do
			is_removing_block := True
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

				-- Retrieving line before `start_selection'.
			ln := start_selection.line
			t := start_selection.token
			x := start_selection.x_in_characters

			on_line_modified (ln.index)
			record_first_modified_line (ln, t)

			if t /= ln.eol_token then
				from
					s := t.image.substring (1, start_selection.pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
			else
				s := ln.image
			end
				-- Retrieving line after `end_selection'.
			ln := end_selection.line
			t := end_selection.token

			on_line_modified (ln.index)
			record_last_modified_line (ln, t)

			if t /= ln.eol_token then
				from
					s.append (t.image.substring (end_selection.pos_in_token, t.image.count))
					t := t.next
				until
					t = ln.eol_token
				loop
					s.append (t.image)
					t := t.next
				end
			end
				-- Removing unwanted lines.
			ln := start_selection.line
			if ln /= end_selection.line then
				from
					line_number := ln.index + 1
				until
					ln.next = end_selection.line
				loop
					ln.next.delete
					on_line_removed (line_number)
					line_number := line_number + 1

				end
				ln.next.delete
				on_line_removed (line_number)
			end
				-- Rebuild line with previously collected parts.				
			lexer.set_in_verbatim_string (ln.part_of_verbatim_string)

			if s.is_empty then
				ln.make_empty_line
			else
				lexer.execute (s)
				ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
			end

			cursor.make_from_character_pos (x, ln.index, Current)

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)
			on_block_removed
			is_removing_block := False
		end

feature {UNDO_CMD} -- Basic Text changes

	insert_char_at_cursor_pos (c: CHARACTER) is
			-- Insert `c' in text, at cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			t_before, t_after: EDITOR_TOKEN
			s: STRING
			char_pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)
			if c = '%N' then
				insert_eol_at_cursor_pos
			else
				lexer.set_tab_size (editor_preferences.tabulation_spaces)

				cursor.update_current_char
				char_pos := cursor.x_in_characters
				ln := cursor.line
				tok := cursor.token
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)

					--| Add `c' in token image.
				if tok = ln.eol_token then
					s := c.out
				else
					s := tok.image.twin
					s.insert_string (c.out, cursor.pos_in_token)
				end
					--| As a simple insertion can change the whole line,
					--| We are obliged to retrieve previous and following
					--| tokens.
				from
					t_before := tok.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				if tok.next /= Void then
					from
						t_after := tok.next
					until
						t_after = ln.eol_token
					loop
						s.append (t_after.image)
						t_after := t_after.next
					end
				end
					--| New line parsing.
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make_empty_line
				else
					lexer.execute (s)
					ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
				end

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)

					--| Cursor update.
				cursor.update_current_char
				cursor.set_x_in_characters (char_pos)
				on_line_modified (cursor.y_in_lines)
				cursor.go_right_char

			end
		end

	insert_string_at_cursor_pos (s: STRING) is
			-- Insert `s' in text, at cursor position.
			-- Leave cursor pointing at the first non inserted character.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
			s_valid: s /= Void and then not s.is_empty
		local
			first_image, last_image, aux: STRING
			t: EDITOR_TOKEN
			cline, new_line: like line
			i,j : INTEGER
			end_pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			cursor.update_current_char

			ln := cursor.line
			tok := cursor.token

			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)

			aux := s.twin
			aux.prune_all ('%R')
			if tok = ln.eol_token then
				first_image := ln.image
				last_image := ""
			else
					--| Building `first_image', i.e. line part before Current.
				first_image := tok.image.substring (1, cursor.pos_in_token - 1)
				from
					t := tok.previous
				until
					t = Void
				loop
					first_image.prepend (t.image)
					t := t.previous
				end

					--| Building `last_image', i.e. line part after Current.
				last_image := tok.image.substring (cursor.pos_in_token, tok.length)
				from
					t := tok.next
				until
					t = ln.eol_token
				loop
					last_image.append (t.image)
					t := t.next
				end
			end
			i := aux.index_of ('%N', 1)
			if i = 0 then
						-- No eol insertion.
					end_pos := cursor.x_in_characters + aux.count
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if (first_image + aux + last_image).is_empty then
						ln.make_empty_line
					else
						lexer.execute (first_image + aux + last_image)
						ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
					end
					on_line_modified (cursor.y_in_lines)

					-- reset pos_in_file values of tokens if possible
					restore_tokens_properties (ln, ln)
			else
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if (first_image + aux.substring (1, i - 1)).is_empty then
					ln.make_empty_line
				else
					lexer.execute (first_image + aux.substring (1, i - 1))
					ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
				end
				on_line_modified (cursor.y_in_lines)

				from
					cline := ln
					if i = aux.count then
						j := 0
					else
						j := aux.index_of ('%N', i + 1)
					end
				until
					j = 0
				loop
					if (aux.substring (i + 1, j - 1)).is_empty then
						create new_line.make_empty_line
					else
						lexer.execute (aux.substring (i + 1, j - 1))
						create new_line.make_from_lexer (lexer)
					end
					cline.add_right (new_line)
					on_line_inserted (new_line.index)
					cline := new_line
					i := j
					if j = aux.count then
						j := 0
					else
						j := aux.index_of ('%N', i+1)
					end
				end
				if (aux.substring (i + 1, aux.count) + last_image).is_empty then
					create new_line.make_empty_line
				else
					lexer.execute (aux.substring (i + 1, aux.count) + last_image)
					create new_line.make_from_lexer (lexer)
				end
				cline.add_right (new_line)
				on_line_modified (new_line.index)
				end_pos := aux.count - i + 1

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (cursor.line, new_line)

				cursor.set_line (cline.next)
			end
			cursor.set_x_in_characters (end_pos)
		end

	insert_string_as_selectable_at_cursor_pos (s: STRING) is
			-- Insert `s' in text, at cursor position as a selectable token.
			-- Leave cursor pointing at the first non inserted character.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
			s_valid: s /= Void and then not s.is_empty
			s_single_line: s.index_of ('%N', 1) = 0
		local
			first_image, last_image, aux: STRING
			t: EDITOR_TOKEN
			end_pos: INTEGER
			ln: like line
			tokens_group: EDITOR_TOKEN_GROUP
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			cursor.update_current_char

			ln := cursor.line
			tok := cursor.token

			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)

			aux := s.twin
			aux.prune_all ('%R')
			if tok = ln.eol_token then
				first_image := ln.image
				last_image := ""
			else
					--| Building `first_image', i.e. line part before Current.
				first_image := tok.image.substring (1, cursor.pos_in_token - 1)
				from
					t := tok.previous
				until
					t = Void
				loop
					first_image.prepend (t.image)
					t := t.previous
				end

					--| Building `last_image', i.e. line part after Current.
				last_image := tok.image.substring (cursor.pos_in_token, tok.length)
				from
					t := tok.next
				until
					t = ln.eol_token
				loop
					last_image.append (t.image)
					t := t.next
				end
			end
				-- No eol insertion.
			end_pos := cursor.x_in_characters + aux.count
			if not ln.part_of_verbatim_string then
				if first_image.is_empty then
					ln.make_empty_line
				else
					lexer.execute (first_image)
					ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
				end

				lexer.execute (aux)
				create tokens_group.make_from_lexer (lexer)
				ln.insert_token (tokens_group, ln.count - 1)

				on_line_modified (cursor.y_in_lines)

				-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)
			end
			cursor.set_x_in_characters (end_pos)
		end

	delete_char_at_cursor_pos is
			-- Delete character at cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			t_before, t_after: EDITOR_TOKEN
			s: STRING
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			cursor.update_current_char
			char_pos := cursor.x_in_characters

			ln := cursor.line
			tok := cursor.token

			record_first_modified_line (ln, tok)

			if tok = ln.eol_token then
				if ln.next /= Void then
						-- Must join next line and previous line together
					record_last_modified_line (ln.next, ln.next.first_token)

					s := ln.image + ln.next.image
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if s.is_empty then
						ln.make_empty_line
					else
						lexer.execute (s)
						ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
					end
					on_line_modified (cursor.y_in_lines)
					ln.next.delete
					on_line_removed (cursor.y_in_lines + 1)
				else
					record_last_modified_line (ln, tok)
					on_line_modified (cursor.y_in_lines)
				end
			else
				record_last_modified_line (ln, tok)

				s := tok.image.twin
				s.remove (cursor.pos_in_token)
				from
					t_before := tok.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				check
					not_on_eol: tok.next /= Void
				end
				from
					t_after := tok.next
				until
					t_after = ln.eol_token
				loop
					s.append (t_after.image)
					t_after := t_after.next
				end
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make_empty_line
				else
					lexer.execute (s)
					ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
				end
				on_line_modified (cursor.y_in_lines)
			end
				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)
			cursor.set_x_in_characters (char_pos)

		end

	delete_n_chars_at_cursor_pos (n: INTEGER) is
			-- Delete `n' characters from cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
			n_big_enough: n > 0
		local
			s: STRING
			cline: like line
			t: EDITOR_TOKEN
			pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			cursor.update_current_char
			char_pos := cursor.x_in_characters
			ln := cursor.line
			tok := cursor.token

			record_first_modified_line (ln, tok)

				--| Retrieving line before Current.

			t := tok
			if t /= ln.eol_token then
				from
					s := t.image.substring (1, cursor.pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
			else
				s := ln.image
			end
				--| Computing last position (given by `cline', `t', `pos').
				--| Erase lines as they are completely scanned
				--| (except first and last line, of course).
			cline := ln
			t := tok
			if tok.length >= cursor.pos_in_token + n then
					--| All the characters to erase are in the same token.
				pos := cursor.pos_in_token + n
			else
				from
					pos := n - tok.length + cursor.pos_in_token
					t := tok.next
					if t = Void and then cline.next /= Void then
							--| No next token? go to next line, if possible.
						cline := cline.next
						t := cline.first_token
					end
				until
					t = Void or else pos <= t.length
				loop
					pos := pos - t.length
					t := t.next
					if t = Void and then cline.next /= Void then
							--| No next token? go to next line, if possible.
						cline := cline.next
						if cline.previous /= ln then
								--| Delete unwanted line.
							cline.previous.delete
							on_line_removed (cursor.y_in_lines + 1)
						end
						t := cline.first_token
					end
				end
			end

			record_last_modified_line (cline, t)

				--| Retrieving line after last position (given by `cline', `t', `pos').
			if t /= Void and then t /= cline.eol_token then
				from
					s.append (t.image.substring (pos, t.image.count))
					t := t.next
				until
					t = cline.eol_token
				loop
					s.append (t.image)
					t := t.next
				end
			end
				-- Removing last line, if different from first.
			if cline /= ln then
				cline.delete
				on_line_removed (cursor.y_in_lines + 1)
			end
				-- Rebuild line with previously collected parts.
			lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
			if s.is_empty then
				ln.make_empty_line
			else
				lexer.execute (s)
				ln.rebuild_from_lexer (lexer, ln.part_of_verbatim_string)
			end
			on_line_modified(cursor.y_in_lines)

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)
			cursor.set_x_in_characters (char_pos)
			--cursor.update_current_char
		end

	replace_char_at_cursor_pos (c: CHARACTER) is
			-- Replace character at cursor position by `c'.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			s: STRING
			t_before, t_after: EDITOR_TOKEN
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)
			cursor.update_current_char

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			ln := cursor.line
			tok := cursor.token

			if c = '%N' then
				insert_eol_at_cursor_pos
			elseif tok = ln.eol_token then
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)
				s := ln.image + c.out
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make_empty_line
				else
					lexer.execute (s)
					ln.make_from_lexer (lexer)
				end
				on_line_modified (cursor.y_in_lines)
					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)

				cursor.set_current_char (ln.eol_token, ln.eol_token.length)
		else
			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)
			char_pos := cursor.x_in_characters

			s := tok.image.twin
			s.put (c, cursor.pos_in_token)
			from
				t_before := tok.previous
			until
				t_before = Void
			loop
				s.prepend (t_before.image)
				t_before := t_before.previous
			end
			check
				not_on_eol: tok.next /= Void
			end
			from
				t_after := tok.next
			until
				t_after = ln.eol_token
			loop
				s.append (t_after.image)
				t_after := t_after.next
			end
			lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
			if s.is_empty then
				ln.make_empty_line
			else
				lexer.execute (s)
				ln.make_from_lexer (lexer)
			end
			on_line_modified (cursor.y_in_lines)

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)

			cursor.set_x_in_characters (char_pos)
			--cursor.update_current_char
			cursor.go_right_char

		end
	end

	insert_eol_at_cursor_pos is
			-- Insert new line in text, at cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			aux, s: STRING
			i_t: EDITOR_TOKEN
			new_line : like line
			new_pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			cursor.update_current_char
			ln := cursor.line
			tok := cursor.token

			if ln.part_of_verbatim_string then
				lexer.set_in_verbatim_string (True)
			end

			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)

			if tok = ln.eol_token then
				if use_smart_indentation then
					aux := ln.indentation
					if cursor.x_in_characters <= aux.count then
						aux.keep_head (cursor.x_in_characters - 1)
					end
					new_pos := aux.count + 1

					if aux.is_empty then
						create new_line.make_empty_line
					else
						lexer.execute (aux)
						create new_line.make_from_lexer (lexer)
					end
					new_line.set_auto_indented (True)
				else
					create new_line.make_empty_line
					new_pos := 1
				end
				ln.add_right (new_line)
				on_line_inserted (cursor.y_in_lines + 1)
			else
				aux := tok.image
				s := aux.substring (cursor.pos_in_token, aux.count)
				from
					i_t := tok.next
				until
					i_t = ln.eol_token
				loop
					s.append (i_t.image)
					i_t := i_t.next
				end
				check
					s_non_empty: not (s.is_empty)
				end
				if use_smart_indentation then
					aux := ln.indentation
					if cursor.x_in_characters <= aux.count then
						aux.keep_head (cursor.x_in_characters - 1)
					end
					new_pos := aux.count + 1
					s.prepend (aux)
				else
					new_pos := 1
				end
				delete_after_cursor
				if s.is_empty then
					create new_line.make_empty_line
				else
					lexer.execute (s)
					create new_line.make_from_lexer (lexer)
				end
				ln.add_right (new_line)
				on_line_inserted (cursor.y_in_lines + 1)
			end

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, new_line)
			cursor.set_line_to_next
			cursor.set_x_in_characters (new_pos)
		end

	delete_after_cursor is
			-- Erase from cursor (included) to end of line.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			t: EDITOR_TOKEN
			s: STRING
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)
			cursor.update_current_char
			char_pos := cursor.x_in_characters

			ln := cursor.line
			tok := cursor.token

			if tok /= ln.eol_token then
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)

				s := tok.image.substring (1, cursor.pos_in_token - 1)
				from
					t := tok.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
				lexer.set_tab_size (editor_preferences.tabulation_spaces)
				if s.is_empty then
					ln.make_empty_line
				else
					lexer.execute (s)
					ln.rebuild_from_lexer (lexer, lexer.in_verbatim_string)
				end
				on_line_modified (cursor.y_in_lines)

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)
			end
			--cursor.update_current_char
			cursor.set_x_in_characters (char_pos)
		end

feature {NONE} -- Implementation

	mark_fake_trailing_blank (a_line: EDITOR_LINE; a_number: INTEGER) is
			-- Mark all trailing blanks as fake ones among `a_number' lines
			-- starts from `a_line'.
		require
			a_line_attached: a_line /= Void
			a_number_not_negative: a_number >= 0
		local
			l_line: EDITOR_LINE
			i: INTEGER
			l_token: EDITOR_TOKEN
			end_loop: BOOLEAN
		do
			from
				l_line := a_line
				i := 0
			until
				i >= a_number or l_line = Void
			loop
				from
					l_token := l_line.eol_token.previous
					end_loop := false
				until
					l_token = Void or end_loop
				loop
					if l_token.is_blank then
						l_token.set_is_fake (true)
					else
						end_loop := true
					end
					if not end_loop then
						l_token := l_token.previous
					end
				end
				l_line := l_line.next
				i := i + 1
			end
		end

	remove_white_spaces is
			-- Remove all consecutive blank spaces on current line
			-- starting from `cursor' position.
			-- Undo command will be bound to next inserted
		require
			cursor_not_void: cursor /= Void
			text_not_empty: not is_empty
			no_selection: not has_selection
		do
			from
				set_selection_cursor (cursor)
--				selection_cursor := cursor.twin
--				has_selection := True
			until
				not is_blank (cursor.item)
			loop
				cursor.go_right_char
			end
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			else
--				has_selection := False
			end
		end

	is_blank (ch: CHARACTER): BOOLEAN is
			-- Is `ch' a blank space ?
		do
			Result  := ch = ' ' or ch = '%T'
		end

	begin_line_tokens: LINKED_LIST[EDITOR_TOKEN]

	end_line_tokens: LINKED_LIST[EDITOR_TOKEN]

	record_first_modified_line (ln: like line; modified_token: EDITOR_TOKEN) is
			-- store token reference before new line with new tokens is created
			-- this information will be used by `restore_tokens_properties' to restore
			-- some token properties (position, beginning of a feature)
		local
			tok: EDITOR_TOKEN
		do
			create begin_line_tokens.make
			from
				tok := ln.first_token
			until
				tok = modified_token or else tok = Void
			loop
				begin_line_tokens.extend (tok)
				tok := tok.next
			end
			if tok /= Void then
				begin_line_tokens.extend (tok)
			end
		end

	record_last_modified_line (ln: like line; modified_token: EDITOR_TOKEN) is
			-- store token reference before new line with new tokens is created
			-- this information will be used by `restore_tokens_properties' to restore
			-- some token properties (position, beginning of a feature)
		require
			token_in_line: ln.has_token (modified_token)
		local
			tok: EDITOR_TOKEN
		do
			create end_line_tokens.make
			from
				tok := ln.eol_token
			until
				tok = modified_token or else tok = Void
			loop
				end_line_tokens.extend (tok)
				tok := tok.previous
			end
			if tok /= Void then
				end_line_tokens.extend (tok)
			end
		end

	record_modified_line (ln: like line) is
			-- store token reference before new line with new tokens is created
			-- this information will be used by `restore_tokens_properties' to restore
			-- some token properties (position, beginning of a feature)
		local
			tok: EDITOR_TOKEN
		do
			create begin_line_tokens.make
			create end_line_tokens.make
			from
				tok := ln.first_token
			until
				tok = ln.eol_token
			loop
				begin_line_tokens.extend (tok)
				end_line_tokens.put_front(tok)
				tok := tok.next
			end
			end_line_tokens.put_front(tok)
		end

	restore_tokens_properties (begin_line, end_line: like line) is
			-- restore some token properties (position, beginning of a feature)
			-- using lists crated by `record...' procedures above
		require
			begin_line_not_void: begin_line /= Void
			end_line_not_void: end_line /= Void
			begin_line_tokens_not_void: begin_line_tokens /= Void
			end_line_tokens_not_void: end_line_tokens /= Void
		do
		end

	restore_tokens_properties_one_line (begin_line: like line) is
		require
			begin_line_not_void: begin_line /= Void
			begin_line_tokens_not_void: begin_line_tokens /= Void
			end_line_tokens_not_void: end_line_tokens /= Void
		do
		end

	unsymboled_lines: LINKED_LIST[INTEGER]
			-- numbers of lines which have been modified by latest
			-- call to `unsymbol_selection'.
			-- Used by undo commands for unindent and uncomment.

feature {TEXT_CURSOR}

	ignore_cursor_moves: BOOLEAN
			-- flag to tell whether calls to `on_cursor_move' by `cursor'
			-- should reset `history' state.

	on_cursor_move (cur: EDITOR_CURSOR) is
			-- action performed on cursor moves.
		do
			if cur = cursor then
				if not ignore_cursor_moves then
					history.record_move
				end
					-- Notify observers.
				on_cursor_moved
			end
		end

invariant
	changed = undo_is_possible

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EDITABLE_TEXT
