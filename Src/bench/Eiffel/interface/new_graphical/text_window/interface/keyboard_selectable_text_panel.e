indexing
	description: "[
		Read-only text area with a cursor and selection.
		Cursor can be moved by using the keyboard.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	KEYBOARD_SELECTABLE_TEXT_PANEL

inherit

	TEXT_PANEL
		redefine
			display_line, text_displayed,
			build_editor_area, load_text,
			set_first_line_displayed,
			recycle
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	build_editor_area is
			-- Initialize variables and objects related to display.
		do

			Precursor {TEXT_PANEL}

			----------------------------
			-- Vision2 initialisation --
			----------------------------
			editor_area.key_press_actions.extend (~on_key_down)
			create key_action_timer.make_with_interval (0)

			editor_area.focus_in_actions.extend (~gain_focus)
			editor_area.focus_out_actions.extend (~lose_focus)

			editor_area.enable_sensitive
		end

feature -- Status report

	has_selection: BOOLEAN is
			-- Is there any selection in the text ?
		do
			Result := text_displayed.has_selection
		end

feature -- Basic Operation

	show_selection (always_scroll: BOOLEAN) is
			-- Center the display on the selected text.
			-- If `always_scroll', the beginning of the selection appear in the middle of the panel,
			-- else the selection appear in the middle of the panel only if it was not already displayed.
		require
			text_is_not_empty: number_of_lines > 0
			selection_exists: has_selection
		local
			select_line: INTEGER
			fld: INTEGER
			end_pos, start_pos: INTEGER
		do
				-- Compute the first line to be displayed 
 			select_line := text_displayed.selection_start.y_in_lines
			if not always_scroll then
				if select_line < first_line_displayed or else select_line >= first_line_displayed + number_of_lines_displayed then
						-- beginning of selection not displayed
					fld := select_line - number_of_lines_displayed + (number_of_lines_displayed // 2).min (2)
					set_first_line_displayed (fld.max (1). min (maximum_top_line_index), True)		
				end
			else
				fld := select_line - number_of_lines_displayed + (number_of_lines_displayed // 2).min (2)
				set_first_line_displayed (fld.max (1). min (maximum_top_line_index), True)
			end
			start_pos := x_position_of_cursor (text_displayed.selection_start)
			if text_displayed.selection_start.y_in_lines = text_displayed.selection_end.y_in_lines then
				end_pos := x_position_of_cursor (text_displayed.selection_end)
			else
				end_pos := start_pos
			end
			if  start_pos < offset then
					set_offset (start_pos)
			elseif end_pos >= (offset + editor_area.width - left_margin_width - 30) then
					if editor_width > editor_area.width then
						set_offset (end_pos - editor_area.width + left_margin_width + 30)
					end
			end
		end

	select_all is
			-- Select the entire text.
		require
			text_is_not_empty: number_of_lines > 0
		do
			text_displayed.select_all
			refresh
		end

	disable_selection, deselect_all is
			-- Forget selection if there is one.
		local
			sel_start, sel_end: INTEGER
		do
			if has_selection then
				sel_start := text_displayed.selection_start.y_in_lines
				sel_end := text_displayed.selection_end.y_in_lines
				text_displayed.disable_selection
				invalidate_block (sel_start, sel_end)
			end
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select characters between indexes `start_pos' and `end_pos'.
			-- Do not scroll to selected position.
		require
			text_loading_completed: text_is_fully_loaded
			right_order: start_pos <= end_pos
			text_is_not_empty: number_of_lines > 0
		local
			old_l_number: INTEGER
			old_sel_s: INTEGER
			had_selection: BOOLEAN
		do
			if text_displayed.has_selection then
				old_l_number := text_displayed.selection_end.y_in_lines
				old_sel_s := text_displayed.selection_start.y_in_lines
				had_selection := True
			else
				old_l_number := text_displayed.cursor.y_in_lines
				old_sel_s := old_l_number
			end
			text_displayed.select_region (start_pos, end_pos)
			if text_displayed.has_selection then
				if had_selection then
-- possible improvement
					invalidate_block (old_sel_s.min (text_displayed.selection_start.y_in_lines), old_l_number.max (text_displayed.selection_end.y_in_lines))
				else
					invalidate_line (old_l_number, False)
					invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
				end
			elseif had_selection then
				invalidate_block (old_sel_s, old_l_number)
				invalidate_line (text_displayed.cursor.y_in_lines, True)
			else
				invalidate_line (text_displayed.cursor.y_in_lines, False)
				invalidate_line (old_l_number, True)
			end
 		end

feature {NONE} -- Process Vision2 events

	on_key_down (ev_key: EV_KEY) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if ev_key /= Void and then not ignore_keyboard_input and then not alt_key then
					-- Handle state key.			
				if key_pressed /= Void and then ev_key.code = key_pressed.code then
					continue_key_action := true
				else
					key_pressed := ev_key
					key_action_timer.actions.wipe_out
					key_action_timer.set_interval (40)
					continue_key_action := true
					if ctrled_key then
						key_action_timer.actions.extend (~repeat_ctrled_key (ev_key))
					else
						key_action_timer.actions.extend (~repeat_extended_key (ev_key))
					end
				end
			end
		end


	gain_focus is
			-- Update the panel as it has just gained the focus.
		do
				-- Redraw the line where the cursor is (we will add the cursor)
			show_cursor := True
			invalidate_cursor_rect (True)
		end
	
	lose_focus is
			-- Update the panel as it has just lost the focus.
		do
				-- Redraw the line where the cursor is (we will erase the cursor)
			show_cursor := False
			invalidate_cursor_rect (True)
		end


feature {NONE} -- Handle keystokes

	repeat_ctrled_key (ev_key: EV_KEY) is
			-- Call `handle_extended_ctrled_key' if `continue_key_action' is True
			-- else reset timer associated with key press handling.
		do
			if not continue_key_action then
				key_pressed := Void
				key_action_timer.set_interval (0)
			else
				continue_key_action := False
				handle_extended_ctrled_key (ev_key)
			end
		end

	repeat_extended_key (ev_key: EV_KEY) is
			-- Call `handle_extended_key' if `continue_key_action' is True
			-- else reset timer associated with key press handling.
		do
			if not continue_key_action then
				key_pressed := Void
				key_action_timer.set_interval (0)
			else
				continue_key_action := False
				handle_extended_key (ev_key)
			end
		end

	key_action_timer: EV_TIMEOUT
			-- Timer between executions of action associated with pressed key.

	key_pressed: EV_KEY
			-- Key currently pressed.

	continue_key_action: BOOLEAN
			-- Continue the action associated with the key `key_pressed' ?

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			cursor: TEXT_CURSOR
			other_keys: BOOLEAN
		do
			cursor := text_displayed.cursor
			inspect
				ev_key.code

			when Key_left then
					-- Left arrow action
				basic_cursor_move (cursor~go_left_word)

			when Key_right then
					-- Right arrow action
				basic_cursor_move (cursor~go_right_word)

			when Key_up then
					-- Up arrow action
				basic_cursor_move (cursor~go_up_line)

			when Key_down then
					-- Down arrow action
				basic_cursor_move (cursor~go_down_line)
				
			when Key_home then
				set_first_line_displayed (1, True)
				basic_cursor_move (cursor~set_y_in_lines (1))
				basic_cursor_move (cursor~go_start_line)

			when Key_end then
				set_first_line_displayed (maximum_top_line_index, True)
				basic_cursor_move (cursor~set_y_in_lines (number_of_lines))
				basic_cursor_move (cursor~go_end_line)

			else
					-- Key not handled

				other_keys := True
			end

			if not other_keys then
				check_cursor_position
				invalidate_cursor_rect (True)
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			other_keys: BOOLEAN
			cursor: TEXT_CURSOR
		do
			cursor := text_displayed.cursor
			inspect
				ev_key.code

			when Key_left then
					-- Left arrow action
				basic_cursor_move (cursor~go_left_char)
	
			when Key_right then
					-- Right arrow action
				basic_cursor_move (cursor~go_right_char)

			when Key_up then
					-- Up arrow action
				basic_cursor_move (cursor~go_up_line)

			when Key_down then
					-- Down arrow action
				basic_cursor_move (cursor~go_down_line)

			when Key_home then
					-- Home key action
				basic_cursor_move (cursor~go_start_line)

			when Key_end then
					-- End key action
				if shifted_key and then cursor.line.first_token = cursor.token and then cursor.pos_in_token = 1 then
					basic_cursor_move (cursor~go_end_line)
					basic_cursor_move (cursor~go_right_char)
				else
					basic_cursor_move (cursor~go_end_line)
				end

			when Key_page_up then
				if cursor.y_in_lines >= first_line_displayed and cursor.y_in_lines <= first_line_displayed + number_of_lines_displayed then
					set_first_line_displayed ((first_line_displayed - number_of_lines_displayed).max (1), True)
					basic_cursor_move (cursor~set_y_in_lines ((cursor.y_in_lines - number_of_lines_displayed).max (1)))
				else
					set_first_line_displayed ((first_line_displayed - number_of_lines_displayed).max (1), True)
					basic_cursor_move (cursor~set_y_in_lines ((first_line_displayed + number_of_lines_displayed - 1).min (number_of_lines)))
				end

			when Key_page_down then
				if cursor.y_in_lines >= first_line_displayed and cursor.y_in_lines <= first_line_displayed + number_of_lines_displayed then
					set_first_line_displayed ((first_line_displayed + number_of_lines_displayed).min (maximum_top_line_index), True)
					basic_cursor_move (cursor~set_y_in_lines ((cursor.y_in_lines + number_of_lines_displayed).min (number_of_lines)))
				else
					set_first_line_displayed ((first_line_displayed + number_of_lines_displayed - 1).min (maximum_top_line_index), True)
					basic_cursor_move (cursor~set_y_in_lines (first_line_displayed))
				end
			else
					-- Key not handled
				other_keys := True
				key_not_handled_action
			end

			if not other_keys then
				check_cursor_position
				invalidate_cursor_rect (True)
			end
		end

feature {NONE} -- Implementation

	check_position (a_cursor: TEXT_CURSOR) is
			-- Check if the current line is displayed and scroll the editor if necessary.
		require
			cursor_not_void: a_cursor /= Void
		local
			cur_pos: INTEGER
		do
			cur_pos := a_cursor.y_in_lines
			if  cur_pos < first_line_displayed then
				set_first_line_displayed (cur_pos, False) 
			elseif cur_pos >= (first_line_displayed + number_of_lines_displayed) then
				set_first_line_displayed (cur_pos - number_of_lines_displayed + 1, False)
			end
			cur_pos := x_position_of_cursor (a_cursor)
			if  cur_pos < offset then
				set_offset (cur_pos.max (0))
			elseif cur_pos >= (offset + editor_area.width - left_margin_width - 30) then
				if editor_width > editor_area.width then
					set_offset (cur_pos - editor_area.width + left_margin_width + 30)
				end
			end
		end

	check_cursor_position is
			-- Check if cursor position is displayed and scroll if necessary.
		require
			text_not_empty: not text_displayed.is_empty
		do
			check_position (text_displayed.cursor)
		end

	basic_cursor_move (action: PROCEDURE[TEXT_CURSOR,TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char
		require
			text_is_not_empty: not text_displayed.is_empty
		local
			old_line: INTEGER
			new_line: INTEGER
			cursor: TEXT_CURSOR
		do
			cursor := text_displayed.cursor
			if shifted_key then
					-- We want to create or modify a selection.
				if not text_displayed.has_selection then
						-- No selection? We have to start one.
					text_displayed.set_selection_cursor(clone (cursor))
					text_displayed.enable_selection
				end
				old_line := cursor.y_in_lines
				action.call ([])
				if text_displayed.selection_cursor.is_equal (cursor) then
						-- If nothing is selected, we forget the selection.
					text_displayed.disable_selection
				end
				new_line := cursor.y_in_lines
				if old_line /= new_line then
						-- redraw all lines between old and new cursor position (new position excluded)
					 	-- cursor position will be redrawn in handle_extended_key 
					invalidate_block (old_line.min (new_line + 1), old_line.max (new_line - 1))
				end
			elseif text_displayed.has_selection then
					-- There was a selection, but we destroy it.
				old_line := cursor.y_in_lines
				action.call ([])
				text_displayed.disable_selection
				invalidate_line (old_line, False)
				invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
			else
					-- There is no selection. Normal move.
				old_line := cursor.y_in_lines
				action.call ([])
				new_line := cursor.y_in_lines
				if old_line /= new_line then
						-- redraw old cursor position 
						-- new cursor position will be redrawn in handle_extended_key 
					invalidate_line (old_line, True)
				end
			end
		end

	key_not_handled_action is
			-- Apply default key processing.
		do
		end

	display_line (xline: INTEGER; a_line: EDITOR_LINE) is
 			-- Display `a_line' on the buffered screen.
		local
 			curr_y 			: INTEGER
 			cursor_line		: BOOLEAN -- Is the cursor present in the current line?
 			curr_token		: EDITOR_TOKEN
 			width_cursor		: INTEGER
 			start_cursor		: INTEGER
 			selected_line		: BOOLEAN -- Is the entire line selected?
 			not_selected_line	: BOOLEAN -- Is the entire line NOT selected?
 			token_selection		: INTEGER
 			token_selection_start	: INTEGER
 			token_selection_end	: INTEGER
 			local_selection_start 	: TEXT_CURSOR -- cache of the value of selection_start
 			local_selection_end	: TEXT_CURSOR -- cache of the value of selection_end
			cursor			: TEXT_CURSOR
			selection_present	: BOOLEAN
 		do
			cursor := text_displayed.cursor
 			curr_y := (xline - first_line_displayed) * line_height
			if cursor /= Void then
	 			cursor_line := (xline = cursor.y_in_lines)
			else
				cursor_line := False
			end
 			selection_present := text_displayed.has_selection
 			if selection_present then
 					-- Compute optimisations
 				local_selection_start := text_displayed.selection_start
 				local_selection_end := text_displayed.selection_end
 
 				if (xline > local_selection_start.y_in_lines) and (xline < local_selection_end.y_in_lines) then
 					selected_line := True
 				end
 				if (xline < local_selection_start.y_in_lines) or (xline > local_selection_end.y_in_lines) then
 					not_selected_line := True
 				end
 			end
			
 			from
					-- Display the first token in the margin
				a_line.start
				if Display_margin then
					a_line.item.display (curr_y, left_margin_buffered_screen, Current) 
				end
				a_line.forth
				curr_token := a_line.item
 			until
 				a_line.after or else curr_token = a_line.eol_token or else curr_token.position > editor_width 
 			loop
 				if selection_present then
 					-- The text contains a selection, we may have to display this token
 					-- in its selected state.
 
 						-- Initialise the token state.
 					token_selection := Token_not_selected
 
 						-- Entire line selected
 					if selected_line then
 						token_selection := Token_selected
 
 						-- No token in the line are selected
 					elseif not_selected_line then
 						token_selection := Token_not_selected
 
 						-- Some tokens in the line are selected, and the selection starts and ends on the same line
 					elseif (xline = local_selection_start.y_in_lines) and then (xline = local_selection_end.y_in_lines) then
 						if (curr_token.position > local_selection_start.token.position) and then (curr_token.position < local_selection_end.token.position) then
 							token_selection := Token_selected
 						elseif (curr_token.position < local_selection_start.token.position) or else (curr_token.position > local_selection_end.token.position) then
 							token_selection := Token_not_selected
 						else
 							token_selection_start := 1
 							token_selection_end := curr_token.length + 1
 							if (curr_token.position = local_selection_start.token.position) then
 								token_selection := Token_half_selected
 								token_selection_start := local_selection_start.pos_in_token
 							end
 							if (curr_token.position = local_selection_end.token.position) then
 								token_selection := Token_half_selected
 								token_selection_end := local_selection_end.pos_in_token
 							end
 						end
 
 						-- Some tokens in the line are selected (first selected line)
 					elseif (xline = local_selection_start.y_in_lines) then
 						if (curr_token.position > local_selection_start.token.position) then
 							token_selection := Token_selected
 						elseif (curr_token.position = local_selection_start.token.position) then
 							token_selection := Token_half_selected
 							token_selection_start := local_selection_start.pos_in_token
 							token_selection_end := curr_token.length + 1
 						end
 
 						-- Some tokens in the line are selected (last selected line)
 					elseif (xline = local_selection_end.y_in_lines) then
 						if (curr_token.position < local_selection_end.token.position) then
 							token_selection := Token_selected
 						elseif (curr_token.position = local_selection_end.token.position) then
 							token_selection := Token_half_selected
 							token_selection_start := 1
 							token_selection_end := local_selection_end.pos_in_token
 						end
 
 					end
 				end
 
 				inspect token_selection
 				when Token_not_selected then
 						-- Normally Display the token.
 					curr_token.display (curr_y, buffered_screen, Current)
 				when Token_selected then
 					curr_token.display_selected (curr_y, buffered_screen, Current)
 				when Token_half_selected then
 					curr_token.display_half_selected (curr_y, token_selection_start, token_selection_end, buffered_screen, Current)
 				else
 					-- Unexpected value, do nothing
 				end
 
					-- Display the cursor (if needed).
 				if
					cursor_line and then (cursor.token = curr_token)
				then
 						-- Compute the start pixel of the cursor.
 					start_cursor := curr_token.position +
							curr_token.get_substring_width (cursor.pos_in_token - 1)

 						-- Compute the width of the current character (used to display plain cursor)
 					width_cursor := curr_token.get_substring_width (cursor.pos_in_token) -
								curr_token.get_substring_width (cursor.pos_in_token - 1)
 					width_cursor := width_cursor.max (cursor_width)

 						-- Draw the cursor
 					draw_cursor (buffered_screen, start_cursor, curr_y , width_cursor, line_height, show_cursor)
				end
 
 					-- Prepare next iteration
 				a_line.forth
 				curr_token := a_line.item
 			end
 
 			if curr_token.position < editor_width then

					-- Display the end token
	 			curr_token := a_line.eol_token
	 			if
					selection_present and then
					 (local_selection_start.y_in_lines /= local_selection_end.y_in_lines) and then 
	 			   (selected_line or else (xline = local_selection_start.y_in_lines))
				then 
	 				a_line.eol_token.display_end_token_selected (curr_y, buffered_screen,
						buffered_screen.width, Current)
	 			else
	 				a_line.eol_token.display_end_token_normal (curr_y, buffered_screen,
						buffered_screen.width, Current)
	 			end
 			end
 
 				-- Display the cursor (if its on the current end of line).
 			if
				--is_editable and then 
				cursor_line and then (cursor.token = curr_token)
			then
					-- Compute the start pixel of the cursor.
 				start_cursor := curr_token.position +
						curr_token.get_substring_width (cursor.pos_in_token - 1)
				width_cursor := font_width
 					-- Draw the cursor
				draw_cursor (buffered_screen, start_cursor, curr_y, width_cursor, line_height, show_cursor)
			end
 		end

	invalidate_cursor_rect (flush_screen: BOOLEAN) is
			-- Set the line where the cursor is situated to be redrawn
			-- Redraw immediately if `flush' is set.
		do
			if text_displayed.cursor /= Void then
				invalidate_line (text_displayed.cursor.y_in_lines, flush_screen)
			end
			if flush_screen then
				editor_area.flush
			end
		end

	draw_cursor (media: EV_DRAWABLE; x, y, width_cursor, ln_height: INTEGER; in_black: BOOLEAN) is
			-- Draw the cursor bloc defined by the rectangle
			-- (`x1',`y1')- (`x1' + `width_cursor',`y1' + `ln_height') on `media'.
			-- The cursor is black if `in_black', gray otherwise.
		do
				media.set_xor_mode
				if in_black then
					media.set_foreground_color (plain_white)
				else
					media.set_foreground_color (plain_gray)
				end
				media.fill_rectangle (x, y, width_cursor, ln_height)
				media.set_copy_mode			
		end

	x_position_of_cursor (a_cursor: TEXT_CURSOR): INTEGER is
			-- Horizontal position in pixels of `a_cursor' in the panel.
		require
			cursor_is_not_void: a_cursor /= Void
		local
			token: EDITOR_TOKEN
		do
			token := a_cursor.token
			Result := ((token.position + token.get_substring_width (a_cursor.pos_in_token - 1)) - left_margin_width).max (1) - 1
		ensure
			positive_position: Result >= 0
		end

	load_text (s: STRING) is
			-- Display `s' in the Editor
		do
			editor_area.disable_sensitive

			Precursor (s)

			editor_area.enable_sensitive
		end

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
			-- Assign `fld' to `first_line_displayed'.
		local
			diff, y_offset: INTEGER
		do
			diff := fld - first_line_displayed
			if (not has_selection) and then diff > 0 and then diff < number_of_lines_displayed and then text_displayed.current_line_number = first_line_displayed + number_of_lines_displayed then
				y_offset := diff * line_height
					-- we wipe out the partially displayed line at the bottom of the panel if the cursor is there.
					-- it ensures that the cursor display will not be messed up by scrolling.
				buffered_screen.clear_rectangle (0, (number_of_lines_displayed) * line_height, buffered_screen.width, y_offset)
			end
			Precursor (fld, refresh_if_necessary)
		end

feature {NONE} -- Implementation

	shifted_key: BOOLEAN is
			-- Is any of the shift key pushed?
		do
			Result := ev_application.shift_pressed
		end

	ctrled_key: BOOLEAN is
		-- Is any of the ctrl key pushed?
		do
			Result := ev_application.ctrl_pressed
		end

	alt_key: BOOLEAN is
		-- Is any of the alt key pushed?
		do
			Result := ev_application.alt_pressed
		end

	plain_white: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		end

	plain_gray: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (64, 64, 64)
		end

	font_width: INTEGER is
		once
			Result := font.width
		end

	ignore_keyboard_input: BOOLEAN is
			-- Ignore keyboard events?
		do
			Result := text_displayed.is_empty or else editor_area.pebble /= Void
		end
		

feature {NONE} -- Implementation

	cursor_width: INTEGER is 2
			-- Default width of cursor.

	show_cursor: BOOLEAN
			-- show cursor in editor ?

	text_displayed: SELECTABLE_TEXT
			-- text displayed in the panel.

feature {NONE} -- Memory Management

	recycle is
			-- Destroy `Current'.
		do
			Precursor {TEXT_PANEL}

			if key_action_timer /= Void and then not key_action_timer.is_destroyed then
				key_action_timer.destroy
			end
			key_action_timer := Void
		end


feature {NONE} -- Private Constants

	Token_not_selected	: INTEGER is 0
	Token_selected		: INTEGER is 1
	Token_half_selected	: INTEGER is 4

end -- class KEYBOARD_SENSITIVE_TEXT_PANEL
