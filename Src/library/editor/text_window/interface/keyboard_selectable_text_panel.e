indexing
	description: "[
		Editable: no
		Scroll bars: yes
		Cursor: yes
		Keyboard: yes
		Mouse: no
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	KEYBOARD_SELECTABLE_TEXT_PANEL

inherit
	TEXT_PANEL
		redefine
			display_line, 
			text_displayed,
			user_initialization, 
			load_text,
			set_first_line_displayed,
			recycle,
			on_vertical_scroll
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine 
			copy, 
			is_equal, 
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Initialize variables and objects related to display.
		do

			Precursor {TEXT_PANEL}
	
			create blinking_timeout
			editor_area.key_press_actions.extend (agent on_key_down)
			create key_action_timer.make_with_interval (0)
			editor_area.key_release_actions.extend (agent on_key_up)

			editor_area.focus_in_actions.extend (agent gain_focus)
			editor_area.focus_out_actions.extend (agent lose_focus)

			editor_area.enable_sensitive
		end

feature -- Access

	text_displayed: SELECTABLE_TEXT
			-- text displayed in the panel.

feature -- Query

	has_selection: BOOLEAN is
			-- Is there any selection in the text ?
		do
			Result := text_displayed.has_selection
		end

	position_is_in_selection (x_pos, y_pos: INTEGER; include_selection_end: BOOLEAN): BOOLEAN is
			-- Is point with coordinates `x_pos', `y_pos' in the selection?
		local
			cur: TEXT_CURSOR
		do
			create cur.make_from_integer (1, text_displayed)
			position_cursor (cur, x_pos, y_pos)
			Result := cursor_is_in_selection (cur)
--			if include_selection_end then
--				Result := Result or else cur.is_equal (text_displayed.selection_end)
--			end
		end

	cursor_is_in_selection (cur: TEXT_CURSOR): BOOLEAN is
			-- Is `cursor' in the selection?
		require
			cursor_is_not_void: cur /= Void
		do
			Result := has_selection and then (cur >= text_displayed.selection_start and then cur < text_displayed.selection_end)
		end

	cursor_is_visible: BOOLEAN is
			-- Check if the cursor is visible in the editor.		
		local
			cur_pos: INTEGER
		do
			if text_displayed.cursor /= Void then
				cur_pos := text_displayed.cursor.y_in_lines
				Result := cur_pos >= first_line_displayed and cur_pos <= (first_line_displayed + number_of_lines_displayed)
			end
		end

feature -- Cursor Management

	check_cursor_position is
			-- Check if cursor position is displayed and scroll if necessary.
		require
			text_not_empty: not text_displayed.is_empty
		do
			check_position (text_displayed.cursor)
		end
		
	position_cursor (a_cursor: TEXT_CURSOR; x_pos, y_pos: INTEGER) is
			-- Position `cursor' as close as possible from coordinates (x_pos, y_pos).
		require
			valid_y: y_pos > 0
			valid_x: x_pos > 0
		local
			l_number		: INTEGER
			current_width	: INTEGER
			nol				: INTEGER
			pointed_line	: EDITOR_LINE
			pointed_token	: EDITOR_TOKEN
			tw				: INTEGER
		do
				-- Compute the line number pointed by the mouse cursor
				-- and adjust it if its over the number of lines in the text.
			l_number := (y_pos // line_height) + first_line_displayed
			nol := text_displayed.number_of_lines
			
			if
				l_number > nol
			then
				l_number := nol
			end
			current_width := x_pos
			pointed_line := text_displayed.line (l_number)
			pointed_token := pointed_line.first_token
			from
				tw := pointed_token.width
			until
				pointed_token = Void or else tw > current_width
			loop
				current_width := current_width - tw
				pointed_token := pointed_token.next
				if pointed_token /= Void then
					tw := pointed_token.width
				end
			end
			if pointed_token /= Void then
				a_cursor.make_from_relative_pos (pointed_line, pointed_token, pointed_token.retrieve_position_by_width (current_width), text_displayed)
			else
				a_cursor.make_from_relative_pos (pointed_line, pointed_line.eol_token, 1, text_displayed)
			end
		end

feature -- Text Selection

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

	dim_selection is
			-- Dim selection to indicate panel has lost focus.
		local
			sel_start, sel_end: INTEGER
		do
			if has_selection then
				sel_start := text_displayed.selection_start.y_in_lines
				sel_end := text_displayed.selection_end.y_in_lines				
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
			character_to_select: start_pos /= end_pos
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

feature -- Status Setting

	

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

feature -- Observation

	add_selection_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for selection changes.
		do
			text_displayed.add_selection_observer (txt_observer)
		end
	
	add_cursor_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for cursor position changes.
		do
			text_displayed.add_cursor_observer (txt_observer)
		end
	
	remove_observer (txt_observer: TEXT_OBSERVER) is
			-- Remove observer of `text_displayed'.
		do
			text_displayed.remove_observer (txt_observer)
		end

feature {NONE} -- Process Vision2 events

	on_key_down (ev_key: EV_KEY) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if ev_key /= Void and then not ignore_keyboard_input and then not alt_key then
					-- Handle state key.	
				blink_on := False
				blinking_timeout.actions.block
				if key_pressed /= Void and then ev_key.code = key_pressed.code then
					continue_key_action := true
				else
					key_pressed := ev_key
					key_action_timer.actions.wipe_out
					key_action_timer.set_interval (40)
					continue_key_action := true
					if ctrled_key then
						key_action_timer.actions.extend (agent repeat_ctrled_key (ev_key))
					else
						key_action_timer.actions.extend (agent repeat_extended_key (ev_key))
					end
				end
			end
		end

	on_key_up (ev_key: EV_KEY) is
			-- Process Wm_keyup message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do			
			blink_delay_timeout.set_interval (1000)
		end

	gain_focus is
			-- Update the panel as it has just gained the focus.
		local
			sel_start,
			sel_end: INTEGER
		do
				-- Redraw the line where the cursor is (we will add the cursor)
			show_cursor := True
			invalidate_cursor_rect (True)
			if has_selection then
				sel_start := text_displayed.selection_start.y_in_lines
				sel_end := text_displayed.selection_end.y_in_lines
				invalidate_block (sel_start, sel_end)
				update_buffered_screen (sel_start * line_height, sel_end * line_height)
			end
		end

	key_not_handled_action is
			-- Apply default key processing.
		do
		end

	lose_focus is
			-- Update the panel as it has just lost the focus.
		local
			sel_start, sel_end: INTEGER
		do
				-- Redraw the line where the cursor is (we will erase the cursor)
			show_cursor := False
			invalidate_cursor_rect (True)
			if blinking_timeout /= Void then
				blinking_timeout.set_interval (0)
			end
			
			if has_selection then
				sel_start := text_displayed.selection_start.y_in_lines
				sel_end := text_displayed.selection_end.y_in_lines
				invalidate_block (sel_start, sel_end)
				update_buffered_screen (sel_start * line_height, sel_end * line_height)
			end
		end

feature {NONE} -- Handle keystrokes

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
			l_cursor: TEXT_CURSOR
			other_keys: BOOLEAN
		do
			l_cursor := text_displayed.cursor
			inspect
				ev_key.code

			when Key_left then
					-- Left arrow action
				basic_cursor_move (agent l_cursor.go_left_word)

			when Key_right then
					-- Right arrow action
				basic_cursor_move (agent l_cursor.go_right_word)

			when Key_up then
					-- Up arrow action
				basic_cursor_move (agent l_cursor.go_up_line)

			when Key_down then
					-- Down arrow action
				basic_cursor_move (agent l_cursor.go_down_line)
				
			when Key_home then
				set_first_line_displayed (1, True)
				basic_cursor_move (agent l_cursor.set_y_in_lines (1))
				basic_cursor_move (agent l_cursor.go_start_line)

			when Key_end then
				set_first_line_displayed (maximum_top_line_index, True)
				basic_cursor_move (agent l_cursor.set_y_in_lines (number_of_lines))
				basic_cursor_move (agent l_cursor.go_end_line)

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
			l_cursor: TEXT_CURSOR
		do
			l_cursor := text_displayed.cursor
			inspect
				ev_key.code

			when Key_left then
					-- Left arrow action
				basic_cursor_move (agent l_cursor.go_left_char)
	
			when Key_right then
					-- Right arrow action
				basic_cursor_move (agent l_cursor.go_right_char)

			when Key_up then
					-- Up arrow action
				basic_cursor_move (agent l_cursor.go_up_line)

			when Key_down then
					-- Down arrow action
				basic_cursor_move (agent l_cursor.go_down_line)

			when Key_home then
					-- Home key action
				basic_cursor_move (agent l_cursor.go_start_line)

			when Key_end then
					-- End key action
				if shifted_key and then l_cursor.line.first_token = l_cursor.token and then l_cursor.pos_in_token = 1 then
					basic_cursor_move (agent l_cursor.go_end_line)
					basic_cursor_move (agent l_cursor.go_right_char)
				else
					basic_cursor_move (agent l_cursor.go_end_line)
				end

			when Key_page_up then
				if l_cursor.y_in_lines >= first_line_displayed and l_cursor.y_in_lines <= first_line_displayed + number_of_lines_displayed then
					set_first_line_displayed ((first_line_displayed - number_of_lines_displayed).max (1), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines ((l_cursor.y_in_lines - number_of_lines_displayed).max (1)))
				else
					set_first_line_displayed ((first_line_displayed - number_of_lines_displayed).max (1), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines ((first_line_displayed + number_of_lines_displayed - 1).min (number_of_lines)))
				end

			when Key_page_down then
				if l_cursor.y_in_lines >= first_line_displayed and l_cursor.y_in_lines <= first_line_displayed + number_of_lines_displayed then
					set_first_line_displayed ((first_line_displayed + number_of_lines_displayed).min (maximum_top_line_index), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines ((l_cursor.y_in_lines + number_of_lines_displayed).min (number_of_lines)))
				else
					set_first_line_displayed ((first_line_displayed + number_of_lines_displayed - 1).min (maximum_top_line_index), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines (first_line_displayed))
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

feature {NONE} -- Cursor Management

	cursor_width: INTEGER is 2
			-- Default width of cursor.

	show_cursor: BOOLEAN
			-- Show cursor in editor?

	blink_interval: INTEGER is 500
			-- Interval in milliseconds between cursor blinks

	blinking_timeout: EV_TIMEOUT
			-- Timeout for control cursor blinking	

	blink_on: BOOLEAN
			-- Flag indicating current status of cursor blink.

	blink_delay_timeout: EV_TIMEOUT is
			-- Timeout for causing a delay before re-blinking cursor after a keyup event.  Without this the
			-- cursor will blink as you move it during repeating movement operations (up, donw, left, right).
		once
			if internal_blinking_timeout = Void then
				create internal_blinking_timeout
				internal_blinking_timeout.actions.extend (agent resume_cursor_blinking)
			end
			Result := internal_blinking_timeout
		end
		
	internal_blinking_timeout: EV_TIMEOUT
			-- Internal blinking timeout
		
	resume_cursor_blinking is
			-- Resume blinking timeout to allow cursor to blink again
		do
			blinking_timeout.actions.resume
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
			l_cursor: TEXT_CURSOR
		do
			l_cursor := text_displayed.cursor
			if shifted_key then
					-- We want to create or modify a selection.
				if not text_displayed.has_selection then
						-- No selection? We have to start one.
					text_displayed.set_selection_cursor (text_displayed.cursor.twin)
					text_displayed.enable_selection
				end
				old_line := l_cursor.y_in_lines
				action.call (Void)
				if text_displayed.selection_cursor.is_equal (text_displayed.cursor) then
						-- If nothing is selected, we forget the selection.
					text_displayed.disable_selection
				end
				new_line := l_cursor.y_in_lines
				if old_line /= new_line then
						-- redraw all lines between old and new cursor position (new position excluded)
					 	-- cursor position will be redrawn in handle_extended_key 
					invalidate_block (old_line.min (new_line + 1), old_line.max (new_line - 1))
				end
			elseif text_displayed.has_selection then
					-- There was a selection, but we destroy it.
				old_line := l_cursor.y_in_lines
				action.call (Void)
				text_displayed.disable_selection
				invalidate_line (old_line, False)
				invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
			else
					-- There is no selection. Normal move.
				old_line := l_cursor.y_in_lines
				action.call (Void)
				new_line := l_cursor.y_in_lines
				if old_line /= new_line then
						-- redraw old cursor position 
						-- new cursor position will be redrawn in handle_extended_key 
					invalidate_line (old_line, True)
				end
			end
		end

	invalidate_cursor_rect (flush_screen: BOOLEAN) is
			-- Set the line where the cursor is situated to be redrawn
			-- Redraw immediately if `flush' is set.
		do
			if text_displayed.cursor /= Void then
				invalidate_line (text_displayed.cursor.y_in_lines, flush_screen)
			elseif flush_screen then
				editor_area.flush
			end
		end

	draw_cursor (media: EV_DRAWABLE; y: INTEGER) is
			-- Draw the cursor block defined by the rectangle associated with the current cursor at `y' and on `media'.
		require
			cursor_has_token: text_displayed.cursor.token /= Void
		local
			start_cursor,
			width_cursor: INTEGER
			l_cursor: TEXT_CURSOR
		do
			l_cursor := text_displayed.cursor
			
				-- Compute the start pixel of the cursor.
 			start_cursor := l_cursor.token.position + l_cursor.token.get_substring_width (l_cursor.pos_in_token - 1)

 					-- Compute the width of the current character (used to display plain cursor)
--			width_cursor := cursor.token.get_substring_width (cursor.pos_in_token) - cursor.token.get_substring_width (cursor.pos_in_token - 1)
--			width_cursor := width_cursor.max (cursor_width)

						-- Draw the cursor
			internal_draw_cursor (buffered_screen, start_cursor, y, cursor_width, line_height, show_cursor)				 					
			blinking_timeout.actions.wipe_out
			if editor_preferences.blinking_cursor and has_focus then				
					-- Set up a timeout to be called to make the cursor blink
				if blinking_timeout.interval = 0 then
					blinking_timeout.set_interval (blink_interval)										
				end																																												
				blinking_timeout.actions.extend (agent internal_draw_cursor (media, start_cursor, y, cursor_width, line_height, show_cursor))				
			end
 		end

	internal_draw_cursor (media: EV_DRAWABLE; x, y, width_cursor, ln_height: INTEGER; do_show: BOOLEAN) is
			-- Internal cursor drawing.  Draws cursor on `media' at position `x' and `y'.
		do		
			media.set_xor_mode
			if not do_show then	
				media.set_foreground_color (editor_preferences.plain_gray)
			elseif editor_preferences.blinking_cursor and has_focus then
				if blink_on then
					media.set_foreground_color (editor_preferences.plain_black)
				else
					media.set_foreground_color (editor_preferences.plain_white)
				end
			else
				media.set_foreground_color (editor_preferences.plain_white)
			end
			media.fill_rectangle (x, y, width_cursor, ln_height)
			if not updating_screen then				
				blink_on := not blink_on
				invalidate_cursor_rect (True)
			end
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
			Result := ((token.position + token.get_substring_width (a_cursor.pos_in_token - 1))).max (1) - 1
		ensure
			positive_position: Result >= 0
		end

feature -- Text Loading

	load_text (s: STRING) is
			-- Display `s' in the Editor
		do
--			editor_area.disable_sensitive
			Precursor (s)
--			editor_area.enable_sensitive
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

	ignore_keyboard_input: BOOLEAN is
			-- Ignore keyboard events?
		do
			Result := text_displayed.is_empty or else editor_area.pebble /= Void
		end		
		
	check_position (a_cursor: TEXT_CURSOR) is
			-- Check if the current line is displayed and scroll the editor if necessary.
		require
			cursor_not_void: a_cursor /= Void
		local
			cur_pos: INTEGER
		do
				-- Scroll vertically if cursor is line above or below those visible in the editor
			cur_pos := a_cursor.y_in_lines
			if cur_pos < first_line_displayed then
				set_first_line_displayed (cur_pos, False) 
			elseif cur_pos >= (first_line_displayed + number_of_lines_displayed) then
				set_first_line_displayed (cur_pos - number_of_lines_displayed + 1, False)
			end
			
				-- Scroll horizontally if cursor is outside the left or right side of the visible editor area
			cur_pos := x_position_of_cursor (a_cursor)
			if cur_pos < offset then
				set_offset (cur_pos.max (0))
			elseif cur_pos >= (offset + editor_area.width - left_margin_width - 10) then
				if editor_width > editor_area.width then
					set_offset (cur_pos - editor_area.width + left_margin_width + 30)
				end
			end
		end

	display_line (xline: INTEGER; a_line: EDITOR_LINE) is
 			-- Display `a_line' on the buffered screen.
		local
 			curr_y 					: INTEGER
 			cursor_line				: BOOLEAN -- Is the cursor present in the current line?
 			curr_token				: EDITOR_TOKEN
 			width_cursor			: INTEGER
 			start_cursor			: INTEGER
 			selected_line			: BOOLEAN -- Is the entire line selected?
 			not_selected_line		: BOOLEAN -- Is the entire line NOT selected?
 			token_selection			: INTEGER
 			token_selection_start	: INTEGER
 			token_selection_end		: INTEGER
 			local_selection_start 	: TEXT_CURSOR -- cache of the value of selection_start
 			local_selection_end		: TEXT_CURSOR -- cache of the value of selection_end
			l_cursor				: TEXT_CURSOR
			selection_present		: BOOLEAN
 		do
			l_cursor := text_displayed.cursor
 			curr_y := (xline - first_line_displayed) * line_height
			if l_cursor /= Void then
	 			cursor_line := (xline = l_cursor.y_in_lines)
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
						-- Do not display the margin tokens
				from
					a_line.start
					curr_token := a_line.item
				until
					not curr_token.is_margin_token
				loop				
					a_line.forth
					curr_token := a_line.item
				end
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
-- 					elseif not_selected_line then
-- 						token_selection := Token_not_selected
 
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
 
 						-- No token in the line are selected
 					elseif not_selected_line then
 						token_selection := Token_not_selected
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
					cursor_line and then (l_cursor.token = curr_token)
				then
 						-- Compute the start pixel of the cursor.
 					start_cursor := curr_token.position +
							curr_token.get_substring_width (l_cursor.pos_in_token - 1)

 						-- Compute the width of the current character (used to display plain cursor)
 					width_cursor := curr_token.get_substring_width (l_cursor.pos_in_token) -
								curr_token.get_substring_width (l_cursor.pos_in_token - 1)
 					width_cursor := width_cursor.max (cursor_width)

 						-- Draw the cursor
					draw_cursor (buffered_screen, curr_y)
				end
 
 					-- Prepare next iteration
 				a_line.forth
 				curr_token := a_line.item
 			end
		
 			if curr_token.position < editor_width then

					-- Display the end token
	 			curr_token := a_line.eol_token
	 			if
					selection_present 
				and then
					 (local_selection_start.y_in_lines /= local_selection_end.y_in_lines) 
				and then 
	 			   (selected_line or else (xline = local_selection_start.y_in_lines)) 
	 			and then
	 			   has_focus
				then 
	 				a_line.eol_token.display_end_token_selected (curr_y, buffered_screen,
						buffered_screen.width, Current)
	 			else
	 				a_line.eol_token.display_end_token_normal (curr_y, buffered_screen,
						buffered_screen.width, Current)
	 			end
 			end
 
 				-- Display the cursor (if its on the current end of line).
 			if cursor_line and then (l_cursor.token = curr_token) then				
				draw_cursor (buffered_screen, curr_y)
			end
 		end

feature {NONE} -- Scrol bars management

	on_vertical_scroll (vscroll_pos: INTEGER) is
 			-- Process vertical scroll event. `vertical_scrollbar.value' has changed.
 		do 	 		
 			Precursor {TEXT_PANEL} (vscroll_pos)
 			
 				-- If the cursor is blinking here we must wipe out the previous action because they draw onto the wrong line
 			if blinking_timeout /= Void and then text_displayed.cursor /= Void then
				blinking_timeout.actions.wipe_out
				draw_cursor (buffered_screen, (text_displayed.cursor.y_in_lines - first_line_displayed) * line_height)
 			end				
 		end

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
