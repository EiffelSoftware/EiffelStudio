note
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

	make
			-- create an empty text
		do
			Precursor {SELECTABLE_TEXT}
			if Editor_preferences.use_tab_for_indentation then
				tabulation_symbol := "%T"
			else
				create tabulation_symbol.make (editor_preferences.tabulation_spaces)
				tabulation_symbol.fill_character (' ')
			end
			create symboled_lines.make (10)
			create unsymboled_lines.make (10)
		end

feature -- Access

	history: UNDO_REDO_STACK
			-- Set of undo and redoable commands on text
			--| This should be attached type. Due to the old design non-void safty,
			--| we have to mark it detachable to please `create history.make (Current)'
			--| in `make' routine. See invariant.
		local
			h: like internal_history
		do
			h := internal_history
			if h = Void then
				create h.make (Current)
				internal_history := h
			end
			Result := h
		end

	cursor: detachable EDITOR_CURSOR
			-- Current cursor.

	tabulation_symbol: STRING
			-- String representing a tab.
			-- Is '%T' or as many blank spaces as defined in
			-- the preferences


feature {NONE} -- Access: internal

	internal_history: detachable like history
			-- Value for `history' to simulate once per object.

feature -- Cursor creation

	new_cursor_from_character_pos (ch_num, y: INTEGER): attached like cursor
			-- Correct way to create a cursor for Current text since `cursor'
			-- could be covariantly redefined.
		require
			ch_num_valid: ch_num >= 1
			y_valid: y >= 1
		do
			create Result.make_from_character_pos (ch_num, y, Current)
		ensure
			new_cursor_attached: Result /= Void
		end

feature -- Status Report

	use_smart_indentation: BOOLEAN
			-- Is smart_indentation enabled?
		do
			Result := editor_preferences.smart_indentation
		end

	redo_is_possible: BOOLEAN
			-- is there anything in the redo stack ?
		do
			Result := (not is_empty) and then history.redo_is_possible
		end

	undo_is_possible: BOOLEAN
			-- is there anything in the undo stack ?
		do
			Result := (not is_empty) and then history.undo_is_possible
		end

	is_commented_selection: BOOLEAN
			-- Is selection fully commented using "--" ?
		require
			not_empty: not is_empty
		local
			ln: like first_line
			end_loop, cursor_start: BOOLEAN
			start_pos, end_pos, start_line, end_line: INTEGER
			start_selection, end_selection: like attached_cursor
		do
			ignore_cursor_moves := True

			if has_selection then
				start_selection := selection_start.twin
				end_selection := selection_end.twin
			else
				start_selection := attached_cursor.twin
				end_selection := attached_cursor.twin
			end
			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			start_line := start_selection.y_in_lines
			end_line := end_selection.y_in_lines
			cursor_start := (cursor = start_selection)

			Result := True
			from
				ln := start_selection.line
			until
				ln = Void or else ln.index > end_line or else not Result
			loop
				from
					ln.start
					end_loop := False
				until
					ln.after or end_loop or not Result
				loop
					if ln.item.is_text then
							-- Check if we are strictly between `start_selection' and `end_selection'
							-- and we are at the end selection, that the selection does not end at the first
							-- character in the line. Fixes bug#16033.
						if
							attached {EDITOR_TOKEN_COMMENT} ln.item as l_comment_token
							or else (attached {EDITOR_TOKEN_OPERATOR} ln.item as l_op1 and then
									l_op1.wide_image.is_case_insensitive_equal_general ("-") and then
									attached {EDITOR_TOKEN_OPERATOR} ln.item.next as l_op2  and then
									l_op2.wide_image.is_case_insensitive_equal_general ("-")
							)
						then
							if
								ln /= end_selection.line
								or else (end_selection.token /= ln.first_token
										or else end_selection.pos_in_token /= 1
										or else start_selection.is_equal (end_selection)
										)
							then
								-- Is a comment
							else
								Result := False -- Is not a comment
							end
						else
							Result := False
						end
						end_loop := True
					end
					ln.forth
				end
				ln := ln.next
			end
			ignore_cursor_moves := False
		end

feature -- Status setting

	set_changed (value: BOOLEAN; directly_edited: BOOLEAN)
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

	undo
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

	redo
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

	delete_selection
			-- delete selected text.
		local
			begin_sel, end_sel: like cursor
			removed: STRING_32
			line_number: INTEGER
			char_num: INTEGER
		do
			if has_selection then
				ignore_cursor_moves := True
				if not attached_cursor.is_equal (attached_selection_cursor) then
					begin_sel := selection_start
					end_sel := selection_end
					line_number := begin_sel.y_in_lines
					char_num := begin_sel.x_in_characters
					removed := string_selected (begin_sel, end_sel)
					remove_selection (begin_sel, end_sel)
					attached_cursor.set_from_character_pos (char_num, line_number, Current)
					history.record_delete_selection (removed)
					set_selection_cursor (attached_cursor)
				end
				disable_selection
				ignore_cursor_moves := False
			end
		end

	replace_selection (a_word: READABLE_STRING_GENERAL)
			-- replace the selected text with `a_word'
		require
			selection_present: has_selection
			selection_not_empty: selection_cursor /= cursor
		local
			begin_sel, end_sel: like cursor
			removed: STRING_32
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
			attached_cursor.set_from_character_pos (char_num, line_number, Current)
			history.record_replace_selection (removed, a_word)
			if not a_word.is_empty then
				insert_string_at_cursor_pos (a_word)
			end
			disable_selection
			ignore_cursor_moves := False
		end

	set_selection_case (lower: BOOLEAN)
			-- Change selected text to lower case if `lower',
			-- else to upper case.
		local
			txt: STRING_32
			l1, l2, x1, x2: INTEGER
		do
			ignore_cursor_moves := True
			if not selection_is_empty then
				l1 := attached_selection_cursor.y_in_lines
				l2 := attached_cursor.y_in_lines
				x1 := attached_selection_cursor.x_in_characters
				x2 := attached_cursor.x_in_characters
				txt := selected_wide_string
				if lower then
					txt.to_lower
				else
					txt.to_upper
				end
				replace_selection (txt)
				attached_selection_cursor.set_from_character_pos (x1, l1, Current)
				attached_cursor.set_from_character_pos (x2, l2, Current)
				enable_selection
			end
			ignore_cursor_moves := False
		end

	toggle_comment_selection
			-- Comment or uncomment all lines included in the selection with the string `--'.
		require
			not_empty: not is_empty
		do
			if is_commented_selection then
				uncomment_selection
			else
				comment_selection
			end
		end

	comment_selection
			-- Comment all lines included in the selection with the string `--'.
		require
			not_empty: not is_empty
		do
			ignore_cursor_moves := True
			if not has_selection then
				set_selection_cursor (cursor)
			end
			symbol_selection(selection_start, selection_end, "--")
			if symboled_lines.count > 0 then
					-- Some was done.
				history.record_symbol (symboled_lines, "--")
			end
			ignore_cursor_moves := False
		end

	uncomment_selection
			-- Uncomment all lines included in the selection with the string `--'.
		require
			not_empty: not is_empty
		local
			ln: like first_line
			end_loop, cursor_start: BOOLEAN
			start_pos, end_pos, start_line, end_line: INTEGER
			start_selection, end_selection: like attached_cursor
			l_offset: INTEGER
			l_history: like history
		do
			ignore_cursor_moves := True

			if has_selection then
				start_selection := selection_start.twin
				end_selection := selection_end.twin
			else
				start_selection := attached_cursor.twin
				end_selection := attached_cursor.twin
			end
			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			start_line := start_selection.y_in_lines
			end_line := end_selection.y_in_lines
			cursor_start := (cursor = start_selection)

			from
				ln := start_selection.line
				l_history := history
			until
				ln = Void or else ln.index > end_line
			loop
				from
					ln.start
					end_loop := False
				until
					ln.after or end_loop
				loop
					if ln.item.is_text then
							-- Allow uncommenting if we are strictly between `start_selection' and `end_selection'
							-- and we are at the end selection, that the selection does not end at the first
							-- character in the line. Fixes bug#16033.
						if
								-- token comment "--"  or two successive operator tokens "-"
							attached {EDITOR_TOKEN_COMMENT} ln.item as l_comment_token
							or else (attached {EDITOR_TOKEN_OPERATOR} ln.item as l_op1 and then
								l_op1.wide_image.is_case_insensitive_equal_general ("-") and then
								attached {EDITOR_TOKEN_OPERATOR} ln.item.next as l_op2 and then
								l_op2.wide_image.is_case_insensitive_equal_general ("-")
							)
						then
							if
								ln /= end_selection.line
								or else (end_selection.token /= ln.first_token
									or else end_selection.pos_in_token /= 1
									or else start_selection.is_equal (end_selection)
								)
							then
								if attached {EDITOR_TOKEN_COMMENT} ln.item as l_comment_token then
									create cursor.make_from_relative_pos (ln, l_comment_token, 1, Current)
								elseif attached {EDITOR_TOKEN_OPERATOR} ln.item as l_op1 then
									create cursor.make_from_relative_pos (ln, l_op1, 1, Current)
								else
									check is_comment_or_minus_operator: False end
									cursor := Void
								end
								if cursor /= Void then
									delete_n_chars_at_cursor_pos (2)
									l_history.record_uncomment ("--")
									if ln = start_selection.line then
										l_offset := start_pos - attached_cursor.x_in_characters
										if l_offset > 0 and l_offset <= 2 then
											start_pos := (start_pos - l_offset).max (1)
										elseif l_offset > 2 then
											start_pos := (start_pos - 2).max (1)
										end
									end
									if ln = end_selection.line then
										l_offset := end_pos - attached_cursor.x_in_characters
										if l_offset > 0 and l_offset <= 2 then
											end_pos := (end_pos - l_offset).max (1)
										elseif l_offset > 2 then
											end_pos := (end_pos - 2).max (1)
										end
									end
								end
							end
						end
						end_loop := True
					end
					ln.forth
				end
				ln := ln.next
			end
			if cursor_start then
				create cursor.make_from_character_pos (start_pos, start_line, Current)
				set_selection_cursor (create {like cursor}.make_from_character_pos (end_pos, end_line, Current))
			else
				create cursor.make_from_character_pos (end_pos, end_line, Current)
				set_selection_cursor (create {like cursor}.make_from_character_pos (start_pos, start_line, Current))
			end
			if has_selection then
				enable_selection
			end
			ignore_cursor_moves := False
		end

	indent_selection
			-- Tabify all lines included in the selection.
		require
			not_empty: not is_empty
		do
			ignore_cursor_moves := True
			if not has_selection then
				set_selection_cursor (cursor)
			end
			symbol_selection(selection_start, selection_end, tabulation_symbol)
			if symboled_lines.count > 0 then
					-- something was done
				history.record_symbol (symboled_lines, tabulation_symbol)
			end
			ignore_cursor_moves := False
		end

	unindent_selection
			-- Tabify all lines included in the selection.
		require
			not_empty: not is_empty
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

	remove_trailing_blanks
			-- Remove trailing blanks, this will be recorded in history stack, but invisible to user.
			-- Blanks before the cursor are not removed.
		require
			not_empty: not is_empty
		local
			l_token, cursor_token, l_end_token, l_next_token: detachable EDITOR_TOKEN
			end_loop: BOOLEAN
			l_cursor: like attached_cursor
			l_current_line: like current_line
			l_next_line: like current_line
		do
			l_cursor := attached_cursor
			cursor_token := l_cursor.token.previous
			from
				start
			until
				after
			loop
				l_current_line := current_line
				check l_current_line /= Void end -- Implied by not `after'
				l_next_line := l_current_line.next
						-- If current line is not verbatim string or
						-- the next line is not verbatim string, namely current line
						-- is the last line of verbatim string, we do not remove trailing blanks.
				if not l_current_line.part_of_verbatim_string or else
						(l_next_line /= Void and then not l_next_line.part_of_verbatim_string) then
					from
						l_end_token := l_current_line.eol_token
						check l_end_token /= Void end -- Not void before the end token.
						l_token := l_end_token.previous
						end_loop := false
					until
						l_token = Void or end_loop
					loop
						if l_token.is_blank then
							if cursor_token = l_token then
								end_loop := true
							else
								l_next_token := l_token.next
								check l_next_token /= Void end -- Not possible, otherwise a bug.
								if attached l_token.previous as l_previous then
									l_previous.set_next_token (l_next_token)
								end
								l_next_token.set_previous_token (l_token.previous)
								create cursor.make_from_relative_pos (l_current_line, l_next_token, 1, Current)
								history.record_remove_trailing_blank (l_token.wide_image)
							end
						else
							end_loop := true
						end
						if not end_loop then
							l_token := l_token.previous
						end
					end
				end
				l_current_line.update_token_information
				forth
			end
			cursor := l_cursor
		end

	remove_trailing_fake_blanks
			-- Remove trailing fake (inserted automatically) blanks,
			-- this will be recorded in history stack, but invisible to user.
		require
			not_empty: not is_empty
		local
			l_token, cursor_token, l_end_token, l_next_token: detachable EDITOR_TOKEN
			end_loop: BOOLEAN
			l_cursor: like attached_cursor
			l_next_line: like current_line
			l_cur_line: like current_line
		do
			l_cursor := attached_cursor
			cursor_token := l_cursor.token.previous
			from
				start
			until
				after
			loop
				l_cur_line := current_line
				check l_cur_line /= Void end
				l_next_line := l_cur_line.next
						-- If current line is not verbatim string or
						-- the next line is not verbatim string, namely current line
						-- is the last line of verbatim string, we do not remove trailing blanks.
				if not l_cur_line.part_of_verbatim_string or else
						(l_next_line /= Void and then not l_next_line.part_of_verbatim_string) then
					from
						l_end_token := l_cur_line.eol_token
						check l_end_token /= Void end -- End token not void, otherwise a bug.
						l_token := l_end_token.previous
						end_loop := false
					until
						l_token = Void or end_loop
					loop
						if l_token.is_blank then
							if l_token.is_fake then
								l_next_token := l_token.next
								check l_next_token /= Void end -- Token before end not void.
								if attached l_token.previous as l_previous then
									l_previous.set_next_token (l_next_token)
								end
								l_next_token.set_previous_token (l_token.previous)
								create cursor.make_from_relative_pos (l_cur_line, l_next_token, 1, Current)
								history.record_remove_trailing_blank (l_token.wide_image)
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
				end
				l_cur_line.update_token_information
				forth
			end
			cursor := l_cursor
		end

	insert_char (c: CHARACTER_32)
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

	insert_string (txt: READABLE_STRING_GENERAL)
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
			if not txt.is_empty then
				insert_string_at_cursor_pos (txt)
			end
			ignore_cursor_moves := False
			if has_selection then
				disable_selection
			end
		end

	insert_eol
			-- Insert new line at cursor position.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		local
			indent: STRING_32
		do
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			end
			ignore_cursor_moves := True
			if use_smart_indentation then
				indent := attached_cursor.line.wide_indentation
				if attached_cursor.x_in_characters <= indent.count then
					indent.keep_head (attached_cursor.x_in_characters - 1)
				end
				history.record_insert_eol (indent)
			else
				history.record_insert_eol ("")
			end
			insert_eol_at_cursor_pos
			mark_fake_trailing_blank (attached_cursor.line, 1)
			ignore_cursor_moves := False
			history.record_move
			if has_selection then
				disable_selection
			end
		end

	insert_string_as_selectable (txt: READABLE_STRING_GENERAL)
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

	replace_char (c: CHARACTER_32)
			-- Replace character at cursor position by `c'.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		do
			ignore_cursor_moves := True
			if selection_is_empty then
				history.record_replace (attached_cursor.wide_item, c)
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

	replace_char_including_new_line (c: CHARACTER_32)
			-- Replace character at cursor position by `c',
			-- including new line.
		require
			text_not_empty: not is_empty
		do
			insert_string (create {STRING_32}.make_filled (c, 1))
			history.bind_current_item_to_next
			delete_char
		end

	delete_char
			-- Delete character at cursor position.
			-- Delete selection, if any.
		require
			text_not_empty: not is_empty
		do
			ignore_cursor_moves := True
			if selection_is_empty then
				history.record_delete (attached_cursor.wide_item)
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

	back_delete_char
			-- Delete character before cursor position.
			-- Delete selection, if any.
		require
			not_empty: not is_empty
		local
			l_cursor: like attached_cursor
		do
			l_cursor := attached_cursor
			if not selection_is_empty then
					delete_selection
			elseif (l_cursor.line.previous /= Void)
					or else
				(l_cursor.token /= l_cursor.line.first_token)
					or else
				(l_cursor.pos_in_token > 1)
			then
				ignore_cursor_moves := True
				l_cursor.go_left_char
				if	use_smart_indentation
						and then
					l_cursor.token = l_cursor.line.eol_token
						and then
					first_non_blank_token (l_cursor.line) = l_cursor.token
				then
					l_cursor.go_start_line
					remove_white_spaces
					history.record_move
				end
				history.record_back_delete (l_cursor.wide_item)
				delete_char_at_cursor_pos
				ignore_cursor_moves := False
			end
			if has_selection then
				disable_selection
			end
		end

	delete_word (back: BOOLEAN)
			-- Delete word before cursor position if `back',
			-- or else at cursor position.
			-- Delete selection, if any.
		do
			ignore_cursor_moves := True
			if selection_is_empty then
				set_selection_cursor (cursor)
				if back then
					attached_selection_cursor.go_left_word
				else
					attached_cursor.go_right_word
				end
				enable_selection
			end
			delete_selection
			ignore_cursor_moves := False
		end

	move_selection_to_pos (i:INTEGER)
			--
		require
			not_empty: not is_empty
			selection_exists: has_selection
		local
			offset: INTEGER
			local_clipboard: STRING_32
		do
			local_clipboard := selected_wide_string
			offset := selection_end.pos_in_text
			if has_selection and then not attached_cursor.is_equal (attached_selection_cursor) then
				delete_selection
				history.bind_current_item_to_next
			end
			if i >= offset then
				attached_cursor.set_from_integer (i - local_clipboard.count, Current)
			else
				attached_cursor.set_from_integer (i, Current)
			end
			insert_string (local_clipboard)
		end

	copy_selection_to_pos (i:INTEGER)
			--
		require
			not_empty: not is_empty
			selection_exists: has_selection
		local
			local_clipboard: STRING_32
		do
			local_clipboard := selected_wide_string
			disable_selection
			attached_cursor.set_from_integer (i, Current)
			insert_string (local_clipboard)
		end

	paste_with_indentation (a_text: READABLE_STRING_GENERAL)
			-- Paste clipboard at cursor position with proper indentation
			-- according to the context text and the content of the clipboard.
			--
			-- Behavior:
			-- If there are tabs before editor cursor and leading tabs in the pasting text:
			-- Adjust the number of leading tabs for each line in the pasting text
			-- by the result of the number of existing tabs before the editor cursor
			-- substracting the number of leading tabs in the pasting text.
			--
			-- Example:
			-- text in clipboard: "%T%Tfoo%N%T%T%Tgoo"
			-- Line of the cursor before pasting: "%T%T%T|"	-- Note: `|' is the cursor
			-- Pasting result: "%T%T%Tfoo%N%T%T%T%Tgoo|"
		note
			EIS: "name=Paste with Indentation", "src=$(ISE_WIKI)/Paste_with_Indentation"
		require
			text_not_empty: not is_empty
		local
			l_cursor_text, l_inserted_text: STRING_32
			l_cur_pos, l_second_line_pos: INTEGER
			l_tab_symbol_count: INTEGER
			l_leading_tabs, l_cursor_tabs: INTEGER
			l_tab_symbol: like tabulation_symbol
			i, l_indent_count: INTEGER
			l_percent_r_number: INTEGER
			l_has_non_tab_symbol: BOOLEAN
			l_same_as_selection: BOOLEAN
		do
			if not a_text.is_empty and then attached cursor as l_cursor then
				l_inserted_text := a_text.as_string_32

				l_tab_symbol := tabulation_symbol
				l_tab_symbol_count := l_tab_symbol.count

					-- Getting test of the line where the cursor is.
				if has_selection then
						-- Take the start position of a selection if any
					l_cursor_text := selection_start.line.wide_image_from_start_to_cursor (selection_start)
					l_cur_pos := selection_start.pos_in_text
					if not is_empty then
						l_same_as_selection := l_inserted_text.same_string (selected_wide_string)
					end
				else
					l_cursor_text := l_cursor.line.wide_image_from_start_to_cursor (l_cursor)
					l_cur_pos := l_cursor.pos_in_text
				end
					-- Number of leading tabulation symbols before the cursor position (or before the selected text).
				l_cursor_tabs := number_of_leading_tab_symbols (l_cursor_text, l_tab_symbol)
					-- Number of leading tabulation symbols in text being pasted.
				l_leading_tabs := number_of_leading_tab_symbols (l_inserted_text, l_tab_symbol)
					-- Has non-tab symbols before the cursor position?
				l_has_non_tab_symbol := l_cursor_tabs /= (l_cursor_text.count // l_tab_symbol_count)

					-- The text before the cursor does not have anything more than tabs,
					-- and there is leading tab before the cursor, and pasting text is not the same as selection if any.
				if not l_has_non_tab_symbol and then l_cursor_tabs > 0 and then not l_same_as_selection then
						-- Remove all leading tabs before the first line of inserted text.
					l_inserted_text := l_inserted_text.substring (l_inserted_text.count.min (l_leading_tabs * l_tab_symbol_count + 1), l_inserted_text.count)
				end

				insert_string (l_inserted_text)

				l_second_line_pos := l_inserted_text.index_of ('%N', 1)
					-- If there are no new lines in the pasted text, there is nothing to do,
					-- otherwise, we need to adapt the pasted text to either indent or unindent the text depending on
					-- whether the pasted text or text before the cursor has some leading tabs or not.
				if
					l_second_line_pos /= 0 and then
					l_second_line_pos + 1 < l_inserted_text.count and then
					not l_cursor_text.is_empty and then -- There is something before the cursor
					l_leading_tabs > 0 and then	-- There is leading tab in the pasting text
					not l_has_non_tab_symbol and then -- The text before the cursor does not have anything more than tabs
					l_cursor_tabs > 0 and then	-- There is leading tab before the cursor
					not l_same_as_selection
				then
						-- Since text read from clipboard might not contain '%R', `insert_string' puts '%R' on Windows
						-- So we need to count it when `is_windows_eol_style' is True.
						-- `l_second_line_pos - 1' is not a valid index implies that there is no %R before the first %N.
					if
						is_windows_eol_style and then
						(not l_inserted_text.valid_index (l_second_line_pos - 1) or else
						l_inserted_text.item (l_second_line_pos - 1) /= '%R')
					then
						l_percent_r_number := l_inserted_text.occurrences ('%N')
					end
						-- Indent/Unindent inserted lines except for the first line.
					select_region (l_cur_pos + l_second_line_pos + 1, l_cur_pos + l_inserted_text.count + l_percent_r_number)

					l_indent_count := (l_leading_tabs - l_cursor_tabs).abs
					from
						i := 1
					until
						i > l_indent_count
					loop
						if l_leading_tabs < l_cursor_tabs then
							history.bind_current_item_to_next
							indent_selection
						else
							history.bind_current_item_to_next
							unindent_selection
						end
						i := i + 1
					end

					disable_selection
				end
			end
		end

feature -- for search only

	replace_for_replace_all (start_pos, end_pos: INTEGER; a_word: READABLE_STRING_GENERAL)
			-- replace the selected text with `a_word'
		require
			not_empty: not is_empty
			right_order: start_pos < end_pos
			word_is_not_void: a_word /= Void
		local
			removed: STRING_32
			line_number: INTEGER
			char_num: INTEGER
			l_sel: like attached_selection_cursor
		do
			ignore_cursor_moves := True
			l_sel := attached_selection_cursor
			l_sel.set_from_integer (start_pos, Current)
			attached_cursor.set_from_integer (end_pos, Current)
			enable_selection
			line_number := l_sel.y_in_lines
			char_num := l_sel.x_in_characters
			removed := string_selected (l_sel, cursor)
			remove_selection (l_sel, cursor)
			attached_cursor.set_from_character_pos (char_num, line_number, Current)
			history.record_replace_all (removed, a_word)
			if not a_word.is_empty then
				insert_string_at_cursor_pos (a_word)
			end
			disable_selection
			ignore_cursor_moves := False
		end

feature -- Reinitialization

	reset_text
			-- put Current back in its original state
		do
			Precursor {SELECTABLE_TEXT}
			history.initialize
		end

	on_text_loaded
			-- reinitialize text after loading.
		do
				-- Initialize undo-redo history
			history.reset
			history.set_mark

			Precursor {SELECTABLE_TEXT}
		end

feature {UNDO_CMD} -- Operations on selected text

	symbol_selection (start_selection: like cursor; end_selection: like cursor; symbol: READABLE_STRING_GENERAL)
			-- Prepend all lines included in the selection with the string `symbol'.
			-- Even if `start_selection' does not begin the line, the entire line
			-- is prepended with `symbol'. Same for the last line of the selection.
			-- Warning: Changes are not recorded in the undo stack.
		require
			not_empty: not is_empty
			valid_selection: start_selection /= Void and end_selection /= Void
			right_order: start_selection <= end_selection
			valid_symbol: symbol /= Void and then not symbol.is_empty
		local
			line_image	: STRING_32		-- String representation of the current line
			ln			: like current_line	-- Current line
			start_pos	: INTEGER
			end_pos		: INTEGER
			y_line		: INTEGER
			l_cursor	: INTEGER
			l_line_modified: BOOLEAN	-- The line cursor at is modified.
		do
			on_text_edited (True)
			l_cursor := attached_cursor.x_in_characters
			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			create symboled_lines.make (10)
			from
				ln := start_selection.line
				y_line := start_selection.y_in_lines
				check ln /= Void end -- not void before line is found.
			until
				ln = end_selection.line or ln.index = end_selection.y_in_lines
			loop
					-- Retrieve the string representation of the line
				line_image := ln.wide_image

					-- Nothing is added in front of an empty line.
				if not line_image.is_empty then
					record_modified_line (ln)
					symboled_lines.extend(ln.index)

						-- Add the commentary symbol in front of the line
					line_image.prepend_string_general (symbol)
					if ln = attached_cursor.line then
						l_line_modified := true
					end

						-- Rebuild line from the lexer.
					lexer.set_in_verbatim_string (False)
					if line_image.is_empty then
						ln.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (line_image)
						ln.rebuild_from_lexer_and_style (lexer, False, is_windows_eol_style)
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
				end

					-- Prepare next iteration
				y_line := y_line + 1
				ln := ln.next
				check ln /= Void end -- Must find the last line.
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
					-- Retrieve the string representation of the line
				line_image := ln.wide_image
					-- Nothing is added in front of an empty line.
				if not line_image.is_empty then
					record_modified_line (ln)
					symboled_lines.extend(ln.index)

						-- Add the commentary symbol in front of the line
					line_image.prepend_string_general (symbol)
					if ln = attached_cursor.line then
						l_line_modified := true
					end

						-- Rebuild line from the lexer.
					lexer.set_in_verbatim_string (False)
					if line_image.is_empty then
						ln.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (line_image)
						ln.rebuild_from_lexer_and_style (lexer, False, is_windows_eol_style)
					end

						-- reset pos_in_file values of tokens if possible
					restore_tokens_properties_one_line (ln)
				end

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
				attached_cursor.set_x_in_characters (l_cursor + symbol.count)
			end
		ensure
			symboled_lines_set: symboled_lines /= Void
		end

	unsymbol_selection (start_selection: like cursor; end_selection: like cursor; symbol: READABLE_STRING_GENERAL)
			-- Prepend all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is prepended with `symbol'. Same for the last line of the selection.
			-- A line is uncommented only if it begins with `symbol'.
			-- Warning: Changes are not recorded in the undo stack.
		require
			not_empty: not is_empty
			valid_selection: start_selection /= Void and end_selection /= Void
			right_order: start_selection <= end_selection
			valid_symbol: symbol /= Void and then not symbol.is_empty
		local
			line_image	: STRING_32		-- String representation of the current line
			ln		: like current_line	-- Current line
			symbol_length	: INTEGER		-- number of characters in `symbol'
			start_pos	: INTEGER
			end_pos		: INTEGER
			l_cursor: INTEGER
			l_line_modified: BOOLEAN	-- The line cursor at is modified.
		do
			on_text_edited (True)
			l_cursor := attached_cursor.x_in_characters

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			start_pos := start_selection.x_in_characters
			end_pos := end_selection.x_in_characters
			symbol_length := symbol.count
			create unsymboled_lines.make (10)
			from
				ln := start_selection.line
				check ln /= Void end -- Not possible before the last line selected.
			until
				ln = end_selection.line or ln.index = end_selection.y_in_lines
			loop
					-- Retrieve the string representation of the line
				line_image := ln.wide_image

					-- Remove the commentary symbol in front of the line (if any)
				if (line_image.count >= symbol_length) and then (line_image.substring (1, symbol_length).same_string_general (symbol)) then
					if ln = attached_cursor.line then
						l_line_modified := true
					end
					record_modified_line (ln)

					line_image := line_image.substring(symbol_length + 1, line_image.count)
					unsymboled_lines.extend(ln.index)
						-- Rebuild line from the lexer.
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if line_image.is_empty then
						ln.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (line_image)
						ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
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
				check ln /= Void end -- Not possible before the last line selected.
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
				line_image := ln.wide_image

					-- Remove the commentary symbol in front of the line (if any)
				if (line_image.count >= symbol_length) and then (line_image.substring (1, symbol_length).same_string_general (symbol)) then
					record_modified_line (ln)
					if ln = attached_cursor.line then
						l_line_modified := true
					end
					line_image := line_image.substring(symbol_length + 1, line_image.count)
					unsymboled_lines.extend (ln.index)
						-- Rebuild line from the lexer.	
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if line_image.is_empty then
						ln.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (line_image)
						ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
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
				attached_cursor.set_x_in_characters ((l_cursor - symbol_length).max (1))
			end
		end

	remove_selection (start_selection: like cursor; end_selection: like cursor)
			-- Delete text between `start_selection' until `end_selection'.
			-- `end_selection' is not included.
			-- Warning: Changes are not recorded in the undo stack.
		require
			cursors_attached: start_selection /= Void and then end_selection /= Void
			right_order: start_selection < end_selection
		local
			s: STRING_32
			ln: like current_line
			t : detachable EDITOR_TOKEN
			line_number: INTEGER
			x: INTEGER
			l_index: INTEGER
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
					s := t.wide_image.substring (1, start_selection.pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.wide_image)
					t := t.previous
				end
			else
				s := ln.wide_image
			end
				-- Retrieving line after `end_selection'.
			ln := end_selection.line
			t := end_selection.token

			on_line_modified (ln.index)
			record_last_modified_line (ln, t)

			if t /= ln.eol_token then
				from
					s.append (t.wide_image.substring (end_selection.pos_in_token, t.wide_image.count))
					t := t.next
				until
					t = ln.eol_token
				loop
					check t /= Void end -- Not possible before `eol_token'
					s.append (t.wide_image)
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
					if attached ln.next as l_next then
						l_next.delete
					else
						check False end -- Not possible
					end
					on_line_removed (line_number)
					line_number := line_number + 1
				end
				if attached ln.next as l_next then
					l_next.delete
				else
					check False end -- Not possible
				end
				on_line_removed (line_number)
			end
				-- Rebuild line with previously collected parts.				
			lexer.set_in_verbatim_string (ln.part_of_verbatim_string)

			if s.is_empty then
				ln.make (is_windows_eol_style)
			else
				execute_lexer_with_wide_string (s)
				ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
			end
			l_index := ln.index
			go_i_th (l_index)
			attached_cursor.set_from_character_pos (x, l_index, Current)

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)
			on_block_removed
			is_removing_block := False
		end

feature {UNDO_CMD} -- Basic Text changes

	insert_char_at_cursor_pos (c: CHARACTER_32)
			-- Insert `c' in text, at cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			t_before, t_after: detachable EDITOR_TOKEN
			s: STRING_32
			char_pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)
			if c = '%N' then
				insert_eol_at_cursor_pos
			else
				lexer.set_tab_size (editor_preferences.tabulation_spaces)

				attached_cursor.update_current_char
				char_pos := attached_cursor.x_in_characters
				ln := attached_cursor.line
				tok := attached_cursor.token
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)

					--| Add `c' in token image.
				if tok = ln.eol_token then
					create s.make_filled (c, 1)
				else
					s := tok.wide_image.twin
					s.insert_string (create {STRING_32}.make_filled (c, 1), attached_cursor.pos_in_token)
				end
					--| As a simple insertion can change the whole line,
					--| We are obliged to retrieve previous and following
					--| tokens.
				from
					t_before := tok.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.wide_image)
					t_before := t_before.previous
				end
				if tok.next /= Void then
					from
						t_after := tok.next
					until
						t_after = ln.eol_token
					loop
						check t_after /= Void end -- Not void before the end token.
						s.append (t_after.wide_image)
						t_after := t_after.next
					end
				end
					--| New line parsing.
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (s)
					ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
				end

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)

					--| Cursor update.
				attached_cursor.update_current_char
				attached_cursor.set_x_in_characters (char_pos)
				on_line_modified (attached_cursor.y_in_lines)
				attached_cursor.go_right_char

			end
		end

	insert_string_at_cursor_pos (s: READABLE_STRING_GENERAL)
			-- Insert `s' in text, at cursor position.
			-- Leave cursor pointing at the first non inserted character.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
			s_valid: s /= Void and then not s.is_empty
		local
			first_image, last_image, aux: STRING_32
			t: detachable EDITOR_TOKEN
			cline, new_line: like line
			i,j : INTEGER
			end_pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			attached_cursor.update_current_char

			ln := attached_cursor.line
			tok := attached_cursor.token

			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)

			aux := s.as_string_32.twin
			aux.prune_all ('%R')
			if tok = ln.eol_token then
				first_image := ln.wide_image
				last_image := ""
			else
					--| Building `first_image', i.e. line part before Current.
				first_image := tok.wide_image.substring (1, attached_cursor.pos_in_token - 1)
				from
					t := tok.previous
				until
					t = Void
				loop
					first_image.prepend (t.wide_image)
					t := t.previous
				end

					--| Building `last_image', i.e. line part after Current.
				last_image := tok.wide_image.substring (attached_cursor.pos_in_token, tok.length)
				from
					t := tok.next
				until
					t = ln.eol_token
				loop
					check t /= Void end -- Not possible before the end token.
					last_image.append (t.wide_image)
					t := t.next
				end
			end
			i := aux.index_of ('%N', 1)
			if i = 0 then
						-- No eol insertion.
					end_pos := attached_cursor.x_in_characters + aux.count
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if (first_image + aux + last_image).is_empty then
						ln.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (first_image + aux + last_image)
						ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
					end
					on_line_modified (attached_cursor.y_in_lines)

					-- reset pos_in_file values of tokens if possible
					restore_tokens_properties (ln, ln)
			else
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if (first_image + aux.substring (1, i - 1)).is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (first_image + aux.substring (1, i - 1))
					ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
				end
				on_line_modified (attached_cursor.y_in_lines)

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
						create new_line.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (aux.substring (i + 1, j - 1))
						create new_line.make_from_lexer_and_style (lexer, is_windows_eol_style)
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
					create new_line.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (aux.substring (i + 1, aux.count) + last_image)
					create new_line.make_from_lexer_and_style(lexer, is_windows_eol_style)
				end
				cline.add_right (new_line)
					-- A new line has been inserted.
				on_line_inserted (new_line.index)
				end_pos := aux.count - i + 1

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (attached_cursor.line, new_line)

				if attached cline.next as l_next and then l_next.is_valid then
					attached_cursor.set_line (l_next)
				else
					check False end
				end
			end
			attached_cursor.set_x_in_characters (end_pos)
		end

	insert_string_as_selectable_at_cursor_pos (s: READABLE_STRING_GENERAL)
			-- Insert `s' in text, at cursor position as a selectable token.
			-- Leave cursor pointing at the first non inserted character.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
			s_valid: s /= Void and then not s.is_empty
			s_single_line: s.as_string_32.index_of ('%N', 1) = 0
		local
			first_image, last_image, aux: STRING_32
			t: detachable EDITOR_TOKEN
			end_pos: INTEGER
			ln: like line
			tokens_group: EDITOR_TOKEN_GROUP
			tok: EDITOR_TOKEN
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			attached_cursor.update_current_char

			ln := attached_cursor.line
			tok := attached_cursor.token

			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)

			aux := s.as_string_32.twin
			aux.prune_all ('%R')
			if tok = ln.eol_token then
				first_image := ln.wide_image
				last_image := ""
			else
					--| Building `first_image', i.e. line part before Current.
				first_image := tok.wide_image.substring (1, attached_cursor.pos_in_token - 1)
				from
					t := tok.previous
				until
					t = Void
				loop
					first_image.prepend (t.wide_image)
					t := t.previous
				end

					--| Building `last_image', i.e. line part after Current.
				last_image := tok.wide_image.substring (attached_cursor.pos_in_token, tok.length)
				from
					t := tok.next
				until
					t = ln.eol_token
				loop
					check t /= Void end -- Not possible before the end token.
					last_image.append (t.wide_image)
					t := t.next
				end
			end
				-- No eol insertion.
			end_pos := attached_cursor.x_in_characters + aux.count
			if not ln.part_of_verbatim_string then
				if first_image.is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (first_image)
					ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
				end

				execute_lexer_with_wide_string (aux)
				create tokens_group.make_from_lexer (lexer)
				ln.insert_token (tokens_group, ln.count - 1)

				on_line_modified (attached_cursor.y_in_lines)

				-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)
			end
			attached_cursor.set_x_in_characters (end_pos)
		end

	delete_char_at_cursor_pos
			-- Delete character at cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			t_before, t_after, l_first: detachable EDITOR_TOKEN
			s: STRING_32
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			attached_cursor.update_current_char
			char_pos := attached_cursor.x_in_characters

			ln := attached_cursor.line
			tok := attached_cursor.token

			record_first_modified_line (ln, tok)

			if tok = ln.eol_token then
				if attached ln.next as l_next then
					l_first := l_next.first_token
					check l_first /= Void end -- First token not void.
						-- Must join next line and previous line together
					record_last_modified_line (l_next, l_first)

					s := ln.wide_image
					s.append (l_next.wide_image)
					lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
					if s.is_empty then
						ln.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (s)
						ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
					end
					on_line_modified (attached_cursor.y_in_lines)
					if attached ln.next as l_new_next then
						l_new_next.delete
					else
						check False end -- The line to join must exist.
					end
					on_line_removed (attached_cursor.y_in_lines + 1)
				else
					record_last_modified_line (ln, tok)
					on_line_modified (attached_cursor.y_in_lines)
				end
			else
				record_last_modified_line (ln, tok)

				s := tok.wide_image.twin
				s.remove (attached_cursor.pos_in_token)
				from
					t_before := tok.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.wide_image)
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
					check t_after /= Void end -- Not possible befor end token.
					s.append (t_after.wide_image)
					t_after := t_after.next
				end
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (s)
					ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
				end
				on_line_modified (attached_cursor.y_in_lines)
			end
				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)
			attached_cursor.set_x_in_characters (char_pos)

		end

	delete_n_chars_at_cursor_pos (n: INTEGER)
			-- Delete `n' characters from cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
			n_big_enough: n > 0
		local
			s: STRING_32
			cline: like line
			t: detachable EDITOR_TOKEN
			pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			attached_cursor.update_current_char
			char_pos := attached_cursor.x_in_characters
			ln := attached_cursor.line
			tok := attached_cursor.token

			record_first_modified_line (ln, tok)

				--| Retrieving line before Current.

			t := tok
			if t /= ln.eol_token then
				from
					s := t.wide_image.substring (1, attached_cursor.pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.wide_image)
					t := t.previous
				end
			else
				s := ln.wide_image
			end
				--| Computing last position (given by `cline', `t', `pos').
				--| Erase lines as they are completely scanned
				--| (except first and last line, of course).
			cline := ln
			t := tok
			if tok.length >= attached_cursor.pos_in_token + n then
					--| All the characters to erase are in the same token.
				pos := attached_cursor.pos_in_token + n
			else
				from
					pos := n - tok.length + attached_cursor.pos_in_token
					t := tok.next
					if t = Void and then attached cline.next as l_next then
							--| No next token? go to next line, if possible.
						cline := l_next
						t := cline.first_token
					end
				until
					t = Void or else pos <= t.length
				loop
					pos := pos - t.length
					t := t.next
					if t = Void and then attached cline.next as l_next_1 then
							--| No next token? go to next line, if possible.
						cline := l_next_1
						if attached cline.previous as l_previous and then l_previous /= ln then
								--| Delete unwanted line.
							l_previous.delete
							on_line_removed (attached_cursor.y_in_lines + 1)
						end
						t := cline.first_token
					end
				end
			end
			if t = Void then
				t := cline.first_token
			end
			check t /= Void end -- First token not void.
			record_last_modified_line (cline, t)

				--| Retrieving line after last position (given by `cline', `t', `pos').
			if t /= Void and then t /= cline.eol_token then
				from
					s.append (t.wide_image.substring (pos, t.wide_image.count))
					t := t.next
				until
					t = cline.eol_token
				loop
					check t /= Void end -- Not possible before the end token.
					s.append (t.wide_image)
					t := t.next
				end
			end
				-- Removing last line, if different from first.
			if cline /= ln then
				cline.delete
				on_line_removed (attached_cursor.y_in_lines + 1)
			end
				-- Rebuild line with previously collected parts.
			lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
			if s.is_empty then
				ln.make (is_windows_eol_style)
			else
				execute_lexer_with_wide_string (s)
				ln.rebuild_from_lexer_and_style (lexer, ln.part_of_verbatim_string, is_windows_eol_style)
			end
			on_line_modified(attached_cursor.y_in_lines)

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, ln)
			attached_cursor.set_x_in_characters (char_pos)
			attached_cursor.update_current_char
		end

	replace_char_at_cursor_pos (c: CHARACTER_32)
			-- Replace character at cursor position by `c'.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			s: STRING_32
			t_before, t_after, l_end_token: detachable EDITOR_TOKEN
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)
			attached_cursor.update_current_char

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			ln := attached_cursor.line
			tok := attached_cursor.token

			if c = '%N' then
				insert_eol_at_cursor_pos
			elseif tok = ln.eol_token then
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)
				s := ln.wide_image
				s.extend (c)
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (s)
					ln.make_from_lexer_and_style (lexer, is_windows_eol_style)
				end
				on_line_modified (attached_cursor.y_in_lines)
					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)

				l_end_token := ln.eol_token
				check l_end_token /= Void end
				attached_cursor.set_current_char (l_end_token, l_end_token.length)
			else
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)
				char_pos := attached_cursor.x_in_characters

				s := tok.wide_image.twin
				s.put (c, attached_cursor.pos_in_token)
				from
					t_before := tok.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.wide_image)
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
					check t_after /= Void end -- Not possible before the end token.
					s.append (t_after.wide_image)
					t_after := t_after.next
				end
				lexer.set_in_verbatim_string (ln.part_of_verbatim_string)
				if s.is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (s)
					ln.make_from_lexer_and_style (lexer, is_windows_eol_style)
				end
				on_line_modified (attached_cursor.y_in_lines)

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)

				attached_cursor.set_x_in_characters (char_pos)
				attached_cursor.update_current_char
				attached_cursor.go_right_char

			end
	end

	insert_eol_at_cursor_pos
			-- Insert new line in text, at cursor position.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			aux, s: STRING_32
			i_t: detachable EDITOR_TOKEN
			new_line : like line
			new_pos: INTEGER
			ln: like line
			tok: EDITOR_TOKEN
			l_cursor: like attached_cursor
		do
			on_text_edited (True)

			lexer.set_tab_size (editor_preferences.tabulation_spaces)

			l_cursor := attached_cursor
			l_cursor.update_current_char
			ln := l_cursor.line
			tok := l_cursor.token

			if ln.part_of_verbatim_string then
				lexer.set_in_verbatim_string (True)
			end

			record_first_modified_line (ln, tok)
			record_last_modified_line (ln, tok)

			if tok = ln.eol_token then
				if use_smart_indentation then
					aux := ln.wide_indentation
					if l_cursor.x_in_characters <= aux.count then
						aux.keep_head (l_cursor.x_in_characters - 1)
					end
					new_pos := aux.count + 1

					if aux.is_empty then
						create new_line.make (is_windows_eol_style)
					else
						execute_lexer_with_wide_string (aux)
						create new_line.make_from_lexer_and_style (lexer, is_windows_eol_style)
					end
					new_line.set_auto_indented (True)
				else
					create new_line.make (is_windows_eol_style)
					new_pos := 1
				end
				ln.add_right (new_line)
				on_line_inserted (l_cursor.y_in_lines + 1)
			else
				aux := tok.wide_image
				s := aux.substring (l_cursor.pos_in_token, aux.count)
				from
					i_t := tok.next
				until
					i_t = ln.eol_token
				loop
					check i_t /= Void end -- Not possible before `eol_token'
					s.append (i_t.wide_image)
					i_t := i_t.next
				end
				check
					s_non_empty: not (s.is_empty)
				end
				if use_smart_indentation then
					aux := ln.wide_indentation
					if l_cursor.x_in_characters <= aux.count then
						aux.keep_head (l_cursor.x_in_characters - 1)
					end
					new_pos := aux.count + 1
					s.prepend (aux)
				else
					new_pos := 1
				end
				delete_after_cursor
				if s.is_empty then
					create new_line.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (s)
					create new_line.make_from_lexer_and_style (lexer, is_windows_eol_style)
				end
				ln.add_right (new_line)
				on_line_inserted (l_cursor.y_in_lines + 1)
			end

				-- reset pos_in_file values of tokens if possible
			restore_tokens_properties (ln, new_line)
			l_cursor.set_line_to_next
			l_cursor.set_x_in_characters (new_pos)
		end

	delete_after_cursor
			-- Erase from cursor (included) to end of line.
			-- Warning: Changes are not recorded in the undo stack.
		require
			text_is_not_empty: not is_empty
		local
			t: detachable EDITOR_TOKEN
			s: STRING_32
			ln: like line
			tok: EDITOR_TOKEN
			char_pos: INTEGER
		do
			on_text_edited (True)
			attached_cursor.update_current_char
			char_pos := attached_cursor.x_in_characters

			ln := attached_cursor.line
			tok := attached_cursor.token

			if tok /= ln.eol_token then
				record_first_modified_line (ln, tok)
				record_last_modified_line (ln, tok)

				s := tok.wide_image.substring (1, attached_cursor.pos_in_token - 1)
				from
					t := tok.previous
				until
					t = Void
				loop
					s.prepend (t.wide_image)
					t := t.previous
				end
				lexer.set_tab_size (editor_preferences.tabulation_spaces)
				if s.is_empty then
					ln.make (is_windows_eol_style)
				else
					execute_lexer_with_wide_string (s)
					ln.rebuild_from_lexer_and_style (lexer, lexer.in_verbatim_string, is_windows_eol_style)
				end
				on_line_modified (attached_cursor.y_in_lines)

					-- reset pos_in_file values of tokens if possible
				restore_tokens_properties (ln, ln)
			end
			attached_cursor.update_current_char
			attached_cursor.set_x_in_characters (char_pos)
		end

feature {NONE} -- Implementation

	mark_fake_trailing_blank (a_line: EDITOR_LINE; a_number: INTEGER)
			-- Mark all trailing blanks as fake ones among `a_number' lines
			-- starts from `a_line'.
		require
			a_line_attached: a_line /= Void
			a_number_not_negative: a_number >= 0
		local
			l_line: detachable EDITOR_LINE
			i: INTEGER
			l_token, l_before_eol_token: detachable EDITOR_TOKEN
			end_loop: BOOLEAN
		do
			from
				l_line := a_line
				i := 0
			until
				i >= a_number or l_line = Void
			loop
				from
					l_before_eol_token := l_line.eol_token
					check l_before_eol_token /= Void end -- End token not void.
					l_token := l_before_eol_token.previous
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

	remove_white_spaces
			-- Remove all consecutive blank spaces on current line
			-- starting from `cursor' position.
			-- Undo command will be bound to next inserted
		require
			cursor_not_void: cursor /= Void
			text_not_empty: not is_empty
			no_selection: not has_selection
		do
			from
				set_selection_cursor (attached_cursor)
--				selection_cursor := attached_cursor.twin
--				has_selection := True
			until
				not is_blank (attached_cursor.wide_item)
			loop
				attached_cursor.go_right_char
			end
			if not selection_is_empty then
				delete_selection
				history.bind_current_item_to_next
			else
--				has_selection := False
			end
		end

	is_blank (ch: CHARACTER_32): BOOLEAN
			-- Is `ch' a blank space ?
		do
			Result  := ch = ' ' or ch = '%T'
		end

	begin_line_tokens: detachable LINKED_LIST [EDITOR_TOKEN] note option: stable attribute end

	end_line_tokens: detachable LINKED_LIST [EDITOR_TOKEN] note option: stable attribute end

	record_first_modified_line (ln: like line; modified_token: EDITOR_TOKEN)
			-- store token reference before new line with new tokens is created
			-- this information will be used by `restore_tokens_properties' to restore
			-- some token properties (position, beginning of a feature)
		require
			ln_not_void: ln /= Void
			modified_token_not_void: modified_token /= Void
		local
			tok: detachable EDITOR_TOKEN
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

	record_last_modified_line (ln: like line; modified_token: EDITOR_TOKEN)
			-- store token reference before new line with new tokens is created
			-- this information will be used by `restore_tokens_properties' to restore
			-- some token properties (position, beginning of a feature)
		require
			ln_not_void: ln /= Void
			token_in_line: ln.has_token (modified_token)
		local
			tok: detachable EDITOR_TOKEN
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

	record_modified_line (ln: like line)
			-- store token reference before new line with new tokens is created
			-- this information will be used by `restore_tokens_properties' to restore
			-- some token properties (position, beginning of a feature)
		require
			ln_not_void: ln /= Void
		local
			tok: detachable EDITOR_TOKEN
		do
			create begin_line_tokens.make
			create end_line_tokens.make
			from
				tok := ln.first_token
			until
				tok = ln.eol_token
			loop
				check tok /= Void end -- Not possible before `end_token'
				begin_line_tokens.extend (tok)
				end_line_tokens.put_front(tok)
				tok := tok.next
			end
			check tok /= Void end -- Not possible for `end_token'
			end_line_tokens.put_front (tok)
		end

	restore_tokens_properties (begin_line, end_line: like line)
			-- restore some token properties (position, beginning of a feature)
			-- using lists crated by `record...' procedures above
		require
			begin_line_not_void: begin_line /= Void
			end_line_not_void: end_line /= Void
			begin_line_tokens_not_void: begin_line_tokens /= Void
			end_line_tokens_not_void: end_line_tokens /= Void
		do
		end

	restore_tokens_properties_one_line (begin_line: like line)
		require
			begin_line_not_void: begin_line /= Void
			begin_line_tokens_not_void: begin_line_tokens /= Void
			end_line_tokens_not_void: end_line_tokens /= Void
		do
		end

	unsymboled_lines: ARRAYED_LIST [INTEGER]
			-- numbers of lines which have been modified by latest
			-- call to `unsymbol_selection'.
			-- Used by undo commands for unindent and uncomment.

	symboled_lines: ARRAYED_LIST [INTEGER]
			-- numbers of lines which have been modified by latest
			-- call to `symbol_selection'.
			-- Used by undo commands for indent and comment.

	number_of_leading_tab_symbols (a_text: STRING_GENERAL; a_tab_symbol: STRING_GENERAL): INTEGER
			-- Number of leading tab symbols
			-- Note that a tab symbol can be more than one character.
		require
			a_tab_symbol_not_empty: not a_tab_symbol.is_empty
		local
			l_text_count, l_tab_symbol_count: INTEGER
			l_stop: BOOLEAN
			i: INTEGER
		do
			l_text_count := a_text.count
			l_tab_symbol_count := a_tab_symbol.count
			from
				i := 1
			until
				i > l_text_count or l_stop
			loop
				if a_text.substring_index_in_bounds (a_tab_symbol, i, l_text_count.min (i + l_tab_symbol_count - 1)) /= i then
					l_stop := True
					i := i - l_tab_symbol_count
				end
				i := i + l_tab_symbol_count
			end
			Result := (i - 1) // l_tab_symbol_count
		end

feature {TEXT_CURSOR}

	ignore_cursor_moves: BOOLEAN
			-- flag to tell whether calls to `on_cursor_move' by `cursor'
			-- should reset `history' state.

	on_cursor_move (cur: EDITOR_CURSOR)
			-- action performed on cursor moves.
		require
			has_cursor: has_cursor
		do
			if cur = attached_cursor then
				if not ignore_cursor_moves then
					history.record_move
				end
					-- Notify observers.
				on_cursor_moved
			end
		end

invariant
-- Commented because while doing a modification it does not hold.
--	undo_enabled: changed = undo_is_possible
	history_attached: attached history

	tabulation_symbol_valid: tabulation_symbol.count > 0

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EDITABLE_TEXT
