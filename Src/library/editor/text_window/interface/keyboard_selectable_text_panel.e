indexing
	description: "[
		Editable: no
		Scroll bars: yes
		Cursor: yes
		Keyboard: yes
		Mouse: no
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	KEYBOARD_SELECTABLE_TEXT_PANEL

inherit
	TEXT_PANEL
		redefine
			draw_line_to_buffered_line,
			update_lines,
			text_displayed,
			user_initialization,
			set_first_line_displayed,
			recycle,
			on_vertical_scroll,
			on_horizontal_scroll,
			reload,
			on_text_loaded
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
			blinking_timeout.set_interval (blink_interval)

			editor_drawing_area.key_press_actions.extend (agent on_key_down)
			create key_action_timer.make_with_interval (0)
			editor_drawing_area.key_release_actions.extend (agent on_key_up)

			editor_drawing_area.focus_in_actions.extend (agent gain_focus)
			editor_drawing_area.focus_out_actions.extend (agent lose_focus)

			editor_drawing_area.enable_sensitive
			let_blink := True

				-- Initialize stored values, since these values should never be smaller than 1.
			stored_cursor_line := 1
			stored_cursor_char := 1
			stored_first_line := 1
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
			cur: like cursor_type
		do
			create cur.make_from_integer (1, text_displayed)
			position_cursor (cur, x_pos, y_pos)
			Result := cursor_is_in_selection (cur)
		end

	cursor_is_in_selection (cur: like cursor_type): BOOLEAN is
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
				Result := cur_pos >= first_line_displayed and cur_pos <= (first_line_displayed + number_of_lines_displayed) + 1
			end
		end

	current_cursor_position: INTEGER is
			-- Character position of current cursor in text.
		local
			l_cursor: like cursor_type
		do
			l_cursor := text_displayed.cursor
			Result := l_cursor.token.position + l_cursor.token.get_substring_width (l_cursor.pos_in_token - 1)
		end

feature -- Cursor Management

	check_cursor_position is
			-- Check if cursor position is displayed and scroll if necessary.
		require
			text_not_empty: not text_displayed.is_empty
		do
			check_position (text_displayed.cursor)
		end

	position_cursor (a_cursor: like cursor_type; x_pos, y_pos: INTEGER) is
			-- Position `a_cursor' as close as possible from coordinates (x_pos, y_pos).
		local
			l_number		: INTEGER
			current_width	: INTEGER
			nol				: INTEGER
			pointed_line	: like line_type
			pointed_token	: EDITOR_TOKEN
			tw				: INTEGER
			l_x_pos			: INTEGER
		do
			l_x_pos := x_pos
			if l_x_pos < 0 then
				l_x_pos := 0
			end

			if y_pos >= 0 then
					-- Compute the line number pointed by the mouse cursor
					-- and adjust it if its over the number of lines in the text.
				l_number := (y_pos + (first_line_displayed * line_height)) // line_height
				nol := text_displayed.number_of_lines

				if l_number > nol then
					l_number := nol
				end
				current_width := l_x_pos
				pointed_line := text_displayed.line (l_number)
				if pointed_line /= Void then
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
					check pointed_line.is_valid end
					if pointed_token /= Void then
						debug ("editor")
							print (pointed_token.out + "%N")
						end
						a_cursor.make_from_relative_pos (pointed_line, pointed_token, pointed_token.retrieve_position_by_width (current_width), text_displayed)
					else
						debug
							print ("pointed token is VOID!%N")
						end
						a_cursor.make_from_relative_pos (pointed_line, pointed_line.eol_token, 1, text_displayed)
					end
				end
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
			end_pos, start_pos, nol: INTEGER
		do
				-- Compute the first line to be displayed
 			select_line := text_displayed.selection_start.y_in_lines
 			nol := number_of_lines_displayed
			if not always_scroll then
				if select_line < first_line_displayed or else select_line >= first_line_displayed + nol then
						-- beginning of selection not displayed
					fld := (select_line - (nol // 2)).max (1)
					set_first_line_displayed (fld.min (maximum_top_line_index), True)
				end
			else
				fld := (select_line - (nol // 2)).max (1)
				set_first_line_displayed (fld.min (maximum_top_line_index), True)
			end
			start_pos := x_position_of_cursor (text_displayed.selection_start)
			if text_displayed.selection_start.y_in_lines = text_displayed.selection_end.y_in_lines then
				end_pos := x_position_of_cursor (text_displayed.selection_end)
			else
				end_pos := start_pos
			end
			if  start_pos < offset then
				set_offset (start_pos)
			elseif end_pos >= (offset + viewable_width - left_margin_width - 30) then
				if editor_width > viewable_width then
					set_offset (end_pos - viewable_width + left_margin_width + 30)
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
				invalidate_block (sel_start, sel_end, True)
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
				invalidate_block (sel_start, sel_end, True)
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
					invalidate_block (old_sel_s.min (text_displayed.selection_start.y_in_lines), old_l_number.max (text_displayed.selection_end.y_in_lines), True)
				else
					invalidate_line (old_l_number, False)
					invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines, True)
				end
			elseif had_selection then
				invalidate_block (old_sel_s, old_l_number, False)
				invalidate_line (text_displayed.cursor.y_in_lines, True)
			else
				invalidate_line (text_displayed.cursor.y_in_lines, False)
				invalidate_line (old_l_number, True)
			end
 		end

	select_lines (a_start, a_end: INTEGER) is
			-- Select lines between `a_start' and `a_end'.  Do not scroll to new cursor position.
			-- Selection will be from first character of `a_start' line and last character of `a_end' line.
		require
			start_valid: a_start > 0 and a_start <= number_of_lines
			end_valid: a_end > 0 and a_end <= number_of_lines
			range_valid: a_start <= a_end
		local
			l_first_line, l_last_line: like line_type
			l_first_char,
			l_last_char: INTEGER
		do
			l_first_line := text_displayed.line (a_start)
			l_last_line := text_displayed.line (a_end)
			l_first_char := text_displayed.line_pos_in_chars (l_first_line)
			l_last_char := text_displayed.line_pos_in_chars (l_last_line) + l_last_line.wide_image.count
			select_region (l_first_char, l_last_char)
		end

	copy_selection is
			-- Copy current selection to clipboard.
		require
			text_is_not_empty: number_of_lines /= 0
		local
			copied_text: STRING_32
		do
			if has_selection then
				if not text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
					copied_text := text_displayed.selected_wide_string
					if not copied_text.is_empty then
						clipboard.set_text (copied_text)
					end
				end
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
				buffered_line.clear_rectangle (0, (number_of_lines_displayed) * line_height, buffered_line.width, y_offset)
			end
			Precursor (fld, refresh_if_necessary)
		end

	redraw_current_line is
			-- Redraw the line where the cursor is
		do
			invalidate_cursor_rect (False)
		end

feature -- Observation

	add_selection_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for selection changes.
		do
			if text_displayed /= Void and then not text_displayed.is_notifying then
				text_displayed.add_selection_observer (txt_observer)
			end
		end

	add_cursor_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for cursor position changes.
		do
			if text_displayed /= Void then
				text_displayed.add_cursor_observer (txt_observer)
			end
		end

	remove_observer (txt_observer: TEXT_OBSERVER) is
			-- Remove observer of `text_displayed'.
		do
			if text_displayed /= Void then
				text_displayed.remove_observer (txt_observer)
			end
		end

	on_text_loaded is
			-- Finish the panel setup as the entire text has been loaded.
		local
			l_cursor: like cursor_type
		do
			Precursor {TEXT_PANEL}
			if restore_cursor then
				l_cursor := text_displayed.cursor
				if number_of_lines >= stored_cursor_line then
					text_displayed.cursor.set_y_in_lines (stored_cursor_line)
					set_first_line_displayed (stored_first_line, True)
						-- We add 1 to represent the last position of a line.
						-- The position of 1 means the position before the first character of a line.
					if text_displayed.line (stored_cursor_line).wide_image.count + 1 >= stored_cursor_char then
						text_displayed.cursor.set_x_in_characters (stored_cursor_char)
					end
					invalidate_cursor_rect (True)
				end
				restore_cursor := False
			end
		end

	reload is
			-- Reload the opened file from disk.
		do
			restore_cursor := True
			if text_is_fully_loaded and text_displayed.cursor /= Void then
				disable_selection
				stored_cursor_line := text_displayed.cursor.y_in_lines
				stored_cursor_char := text_displayed.cursor.x_in_characters
			end
			stored_first_line := first_line_displayed
			Precursor {TEXT_PANEL}
		end

feature {NONE} -- Process Vision2 events

	on_key_down (ev_key: EV_KEY) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if ev_key /= Void and then not ignore_keyboard_input then
					-- Handle state key.

				reset_blinking

				if key_pressed /= Void and then ev_key.code = key_pressed.code then
					continue_key_action := true
				else
					key_pressed := ev_key
					key_action_timer.actions.wipe_out
					key_action_timer.set_interval (40)
					continue_key_action := True
					if ctrled_key and then not alt_key then
						key_action_timer.actions.extend (agent repeat_ctrled_key (ev_key))
					elseif not (not ctrled_key and not shifted_key and alt_key) then
							-- Ignore the case only Alt is pressed.
						key_action_timer.actions.extend (agent repeat_extended_key (ev_key))
					end
				end
			end
		end

	on_key_up (ev_key: EV_KEY) is
			-- Process Wm_keyup message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			blink_on := False
		end

	gain_focus is
			-- Update the panel as it has just gained the focus.
		local
			sel_start,
			sel_end: INTEGER
		do
				-- Redraw the line where the cursor is (we will add the cursor)
			show_cursor := True
			resume_cursor_blinking
			if has_selection then
				sel_start := text_displayed.selection_start.y_in_lines
				sel_end := text_displayed.selection_end.y_in_lines
					-- Do not flush screen, other events might invalidate first.
					-- Otherwise, the selection might flash when gaining focus.
				invalidate_block (sel_start, sel_end, false)
			end
		end

	key_not_handled_action is
			-- Apply default key processing.
		do
		end

	lose_focus is
			-- Update the panel as it has just lost the focus.
		do
				-- Redraw the line where the cursor is (we will erase the cursor)
			show_cursor := False
			if not editor_drawing_area.is_destroyed then
				invalidate_selection_rect (False)
					-- No need to suspend the blinking of the cursor here since the drawing
					-- routine `draw_cursor' takes into consideration that when you do not have
					-- the focus we draw a fix grey cursor.
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
			l_cursor: like cursor_type
			other_keys,
			scroll_to_cursor: BOOLEAN
		do
			l_cursor := text_displayed.cursor
			scroll_to_cursor := True
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

			when Key_c then
					-- Ctrl-C (copy)
				copy_selection
				scroll_to_cursor := False

			when Key_a then
					-- Ctrl-A (select all)
				select_all
				scroll_to_cursor := False

			else
					-- Key not handled

				other_keys := True
			end

			if not other_keys and then scroll_to_cursor then
				check_cursor_position
				invalidate_cursor_rect (True)
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			other_keys: BOOLEAN
			l_cursor: like cursor_type
			l_cursor_twin: like cursor_type
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
				if editor_preferences.smart_home then
					if text_displayed.has_selection then
						l_cursor_twin := l_cursor.twin
						l_cursor_twin.go_smart_home
						if text_displayed.selection_start <= l_cursor_twin then
							basic_cursor_move (agent l_cursor.go_start_line)
						else
							basic_cursor_move (agent l_cursor.go_smart_home)
						end
					else
						basic_cursor_move (agent l_cursor.go_smart_home)
					end
				else
					basic_cursor_move (agent l_cursor.go_start_line)
				end

			when Key_end then
					-- End key action
				basic_cursor_move (agent l_cursor.go_end_line)

			when Key_page_up then
					-- Page up
				if l_cursor.y_in_lines >= first_line_displayed and l_cursor.y_in_lines <= first_line_displayed + number_of_lines_displayed then
					set_first_line_displayed ((first_line_displayed - number_of_lines_displayed + common_line_count).max (1), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines ((l_cursor.y_in_lines - number_of_lines_displayed + common_line_count).max (1)))
				else
					set_first_line_displayed ((first_line_displayed - number_of_lines_displayed + common_line_count).max (1), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines ((first_line_displayed + number_of_lines_displayed + common_line_count - 1).min (number_of_lines)))
				end

			when Key_page_down then
					-- Page down
				if l_cursor.y_in_lines >= first_line_displayed and l_cursor.y_in_lines <= first_line_displayed + number_of_lines_displayed then
					set_first_line_displayed ((first_line_displayed + number_of_lines_displayed - common_line_count).min (maximum_top_line_index), True)
					basic_cursor_move (agent l_cursor.set_y_in_lines ((l_cursor.y_in_lines + number_of_lines_displayed - common_line_count).min (number_of_lines)))
				else
					set_first_line_displayed ((first_line_displayed + number_of_lines_displayed - common_line_count - 1).min (maximum_top_line_index), True)
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

feature {NONE} -- Blink Cursor Management

	blink_on: BOOLEAN
			-- Flag indicating current status of cursor blink.
			-- `True' indicates the cursor should be draw as a solid state

	let_blink: BOOLEAN
			-- Should cursor be allowed to blink?

	blink_interval: INTEGER is 500
			-- Interval in milliseconds between cursor blinks

	blinking_timeout: EV_TIMEOUT
			-- Timeout for control cursor blinking	

	internal_blink_delay_timeout: EV_TIMEOUT
			-- Cached version of `blinking_timeout' do not use directly

	blink_delay_timeout: EV_TIMEOUT is
			-- Timeout for controlling blinking cursor resuce (when `reset_blinking' is called)
		do
			Result := internal_blink_delay_timeout
			if Result = Void then
				create Result.make_with_interval (400)
				Result.actions.extend (agent on_blink_delay_timer)
				Result.actions.resume
				internal_blink_delay_timeout := Result
			end
		ensure
			result_not_void: Result /= Void
		end

	on_blink_delay_timer is
			-- Called when `blink_deplay_timeout' times out.
		do
			let_blink := True
		end

	reset_blinking is
			-- Resets cursor blinking delay timer `blink_deplay_timeout' to temporarly stop blinking.
		local
			i: INTEGER
		do
				-- Resets timer
			let_blink := False
			i := blink_delay_timeout.interval
			blink_delay_timeout.set_interval (i)
		end

	suspend_cursor_blinking is
			-- Suspends cursor blinking until `resume_cursor_blinking' is called.
		do
			if not blink_suspended then
				let_blink := False
				blink_on := True
				blinking_timeout.actions.call (Void)
				blinking_timeout.actions.block
				blink_suspended := True
			end
		ensure
			blink_suspended: blink_suspended
		end

	blink_suspended: BOOLEAN
			-- Has blinking been suspended?

	resume_cursor_blinking is
			-- Resumes cursor blinking from a call to `suspend_cursor_blinking'
		do
			if blink_suspended then
				let_blink := True
				blink_on := True
				blinking_timeout.actions.resume
				blinking_timeout.actions.call (Void)
				blink_suspended := False
			else
				reset_blinking
				let_blink := True
			end
			if blinking_timeout /= Void and then text_displayed.cursor /= Void then
				draw_cursor (buffered_line, current_cursor_position, (text_displayed.cursor.y_in_lines - first_line_displayed) * line_height, cursor_width)
			end
		ensure
			not_blink_suspended: not blink_suspended
		end

	basic_cursor_move (action: PROCEDURE[like cursor_type, TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char
		require
			text_is_not_empty: not text_displayed.is_empty
		local
			old_line: INTEGER
			new_line: INTEGER
			l_cursor: like cursor_type
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
					invalidate_block (old_line.min (new_line + 1), old_line.max (new_line - 1), True)
				end
			elseif has_selection then
					-- There was a selection, but we destroy it.
				old_line := l_cursor.y_in_lines
				action.call (Void)
				invalidate_line (old_line, False)
				disable_selection
			else
					-- There is no selection. Normal move.
				old_line := l_cursor.y_in_lines
				action.call (Void)
				new_line := l_cursor.y_in_lines
				if old_line /= new_line then
						-- redraw old cursor position
						-- new cursor position will be redrawn in handle_extended_key
					disable_selection
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
			end
		end

	invalidate_selection_rect (flush_screen: BOOLEAN) is
			-- Set lines of the selection be redrawn.
			-- Redraw immediately if `flush_screen' is set.
		local
			line_start, line_end: INTEGER
		do
			if not is_empty then
				line_start := text_displayed.selection_start.y_in_lines
				line_end := text_displayed.selection_end.y_in_lines
				invalidate_block (line_start, line_end, flush_screen)
			end
		end

	draw_cursor (media: EV_DRAWABLE; x, y, width: INTEGER) is
			-- Draw the cursor block defined by the rectangle associated with the current cursor at `y' and on `media'.
		require
			x_pos_valid: x >= 0
			width_valid: width > 0
			cursor_has_token: text_displayed.cursor.token /= Void
		do
				-- Draw the cursor
			blinking_timeout.actions.wipe_out
			if editor_preferences.blinking_cursor and has_focus then
					-- Set up a timeout to be called to make the cursor blink
				blinking_timeout.actions.extend (agent internal_draw_cursor (media, x, y, width, line_height, show_cursor))
			end
			internal_draw_cursor (media, x, y, width, line_height, show_cursor)
 		end

	internal_draw_cursor (media: EV_DRAWABLE; x, y, width_cursor, ln_height: INTEGER; do_show: BOOLEAN) is
			-- Internal cursor drawing.  Draws cursor on `media' at position `x' and `y'.
		require
			x_pos_valid: x >= 0
			width_valid: width_cursor > 0
		do
			if not updating_line then
				blink_on := not blink_on
				invalidate_cursor_rect (False)
			end
			media.set_xor_mode
			if not do_show then
					-- Non focus cusor color
				media.set_foreground_color (editor_preferences.dark_gray)
			elseif editor_preferences.blinking_cursor and has_focus then
				if let_blink and then blink_on then
						-- Blink has been on, draw invert color twice back to what it was.
					media.set_foreground_color (editor_preferences.plain_white)
					media.fill_rectangle (x, y, width_cursor, ln_height)
				else
						-- Blink has been off, draw invert color.
					media.set_foreground_color (editor_preferences.plain_white)
				end
			else
				media.set_foreground_color (editor_preferences.plain_white)
			end
			media.fill_rectangle (x, y, width_cursor, ln_height)
			media.set_copy_mode
		end

	x_position_of_cursor (a_cursor: like cursor_type): INTEGER is
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

	restore_cursor: BOOLEAN
			-- Should attempt to restore old cursor position after loading?

	stored_cursor_line: INTEGER
			-- Line of old cursor position

	stored_cursor_char: INTEGER
			-- Character position of old cursor

	stored_first_line: INTEGER
			-- Stored `first_line_displayed'

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
			Result := text_displayed.is_empty or else ev_application.transport_in_progress
		end

	check_position (a_cursor: like cursor_type) is
			-- Check if the current line is displayed and scroll the editor if necessary.
		require
			cursor_not_void: a_cursor /= Void
		local
			cur_pos: INTEGER
			l_int: INTEGER
			l_fld: INTEGER
		do
			cur_pos := a_cursor.y_in_lines
			if cur_pos < first_line_displayed then
				set_first_line_displayed (cur_pos, False)
			elseif cur_pos >= (first_line_displayed + number_of_lines_displayed) then
				l_fld := cur_pos - number_of_lines_displayed + 1
				if l_fld <= text_displayed.number_of_lines.max (1) and vertical_scrollbar.value_range.has (l_fld) then
					set_first_line_displayed (l_fld, False)
				end
			end
			cur_pos := x_position_of_cursor (a_cursor)
			l_int := offset + editor_viewport.width - 30
			if cur_pos < offset then
				set_offset (cur_pos.max (0))
			elseif cur_pos >= (l_int) then
				if editor_width > editor_viewport.width then
					set_offset (cur_pos - editor_viewport.width + 30)
				end
			end
		end

	draw_line_to_buffered_line (xline: INTEGER; a_line: like line_type) is
 			-- Draw onto the buffered line the tokens in `a_line'.
		local
 			cursor_line				: BOOLEAN -- Is the cursor present in the current line?
 			curr_token				: EDITOR_TOKEN
 			width_cursor			: INTEGER
 			start_cursor			: INTEGER
 			selected_line			: BOOLEAN -- Is the entire line selected?
 			not_selected_line		: BOOLEAN -- Is the entire line NOT selected?
 			token_selection			: INTEGER
 			token_selection_start	: INTEGER
 			token_selection_end		: INTEGER
 			local_selection_start 	: like cursor_type -- cache of the value of selection_start
 			local_selection_end		: like cursor_type -- cache of the value of selection_end
			l_cursor				: like cursor_type
			selection_present		: BOOLEAN
			token_start_pos,
			token_end_position		: INTEGER
			l_text: 				like text_displayed
			l_buffered_line: 		like buffered_line
 		do

	 			-- Cache values into locals
 			l_text := text_displayed
			l_cursor := l_text.cursor
			l_buffered_line :=  buffered_line
			selection_present := l_text.has_selection
 			local_selection_start := l_text.selection_start
 			local_selection_end := l_text.selection_end

			if l_cursor /= Void then
	 			cursor_line := (xline = l_cursor.y_in_lines)
			else
				cursor_line := False
			end

 			if selection_present then
 					-- Compute optimisations
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
 				a_line.after or else curr_token = a_line.eol_token --or else curr_token.position > editor_width
 			loop
 				token_start_pos := curr_token.position
				token_end_position := token_start_pos + curr_token.width

	 				if selection_present then
	 					-- The text contains a selection, we may have to display this token
	 					-- in its selected state.

	 						-- Initialise the token state.
	 					token_selection := Token_not_selected

	 						-- Entire line selected
	 					if selected_line then
	 						token_selection := Token_selected

	 					token_start_pos := curr_token.position

	 						-- Some tokens in the line are selected, and the selection starts and ends on the same line
	 					elseif (xline = local_selection_start.y_in_lines) and then (xline = local_selection_end.y_in_lines) then
	 						if (token_start_pos > local_selection_start.token.position) and then (token_start_pos < local_selection_end.token.position) then
	 							token_selection := Token_selected
	 						elseif (token_start_pos < local_selection_start.token.position) or else (token_start_pos > local_selection_end.token.position) then
	 							token_selection := Token_not_selected
	 						else
	 							token_selection_start := 1
	 							token_selection_end := curr_token.length + 1
	 							if (token_start_pos = local_selection_start.token.position) then
	 								token_selection := Token_half_selected
	 								token_selection_start := local_selection_start.pos_in_token
	 							end
	 							if (token_start_pos = local_selection_end.token.position) then
	 								token_selection := Token_half_selected
	 								token_selection_end := local_selection_end.pos_in_token
	 							end
	 						end

	 						-- Some tokens in the line are selected (first selected line)
	 					elseif (xline = local_selection_start.y_in_lines) then
	 						if (token_start_pos > local_selection_start.token.position) then
	 							token_selection := Token_selected
	 						elseif (token_start_pos = local_selection_start.token.position) then
	 							token_selection := Token_half_selected
	 							token_selection_start := local_selection_start.pos_in_token
	 							token_selection_end := curr_token.length + 1
	 						end

	 						-- Some tokens in the line are selected (last selected line)
	 					elseif (xline = local_selection_end.y_in_lines) then
	 						if (token_start_pos < local_selection_end.token.position) then
	 							token_selection := Token_selected
	 						elseif (token_start_pos = local_selection_end.token.position) then
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
	 					curr_token.display (0, l_buffered_line, Current)
	 				when Token_selected then
		 				curr_token.display_selected (0, l_buffered_line, Current)
	 				when Token_half_selected then
		 				curr_token.display_half_selected (0, token_selection_start, token_selection_end, l_buffered_line, Current)
	 				else
	 					-- Unexpected value, do nothing
	 				end

						-- Display the cursor (if needed).
	 				if cursor_line and then (l_cursor.token = curr_token) then
	 						-- Compute the start pixel of the cursor.
	 					start_cursor := token_start_pos + curr_token.get_substring_width (l_cursor.pos_in_token - 1)

	 						-- Compute the width of the current character (used to display plain cursor)
	 					width_cursor := curr_token.get_substring_width (l_cursor.pos_in_token) -
									curr_token.get_substring_width (l_cursor.pos_in_token - 1)
	 					width_cursor := width_cursor.max (cursor_width)

	 						-- Draw the cursor
						draw_cursor (l_buffered_line, current_cursor_position, 0, cursor_width)
					end

	 					-- Prepare next iteration
	 				a_line.forth
	 				curr_token := a_line.item
 				end

	 			if token_start_pos < editor_width then

						-- Display the end token
		 			curr_token := a_line.eol_token
		 			if
						selection_present
					and then
						 (local_selection_start.y_in_lines /= local_selection_end.y_in_lines)
					and then
		 			   (selected_line or else (xline = local_selection_start.y_in_lines))
					then
		 				a_line.eol_token.display_end_token_selected (0, l_buffered_line,
							buffered_line.width, Current)
		 			else
		 				a_line.eol_token.display_end_token_normal (0, l_buffered_line,
							buffered_line.width, Current)
		 			end
	 			end

	 				-- Display the cursor (if its on the current end of line).
	 			if cursor_line and then (l_cursor.token = curr_token) then
					draw_cursor (buffered_line, current_cursor_position, 0, cursor_width)
				end

 		end

	update_lines (first, last, x_offset, a_width: INTEGER; buffered: BOOLEAN) is
			-- Draw the lines `first' to `last' between `x_offset' and `a_width'.
		local
 			curr_line,
 			y_offset,
 			l_line_height,
 			l_line_width,
 			l_start_clear,
 			l_x_offset,
 			l_margin_width: INTEGER
 			l_text: like text_displayed
 			l_buffered,
 			l_has_data,
 			use_buffered: BOOLEAN
 			l_editor_viewport_y_offset: INTEGER
 			l_offset: INTEGER
 			l_viewable_width: INTEGER
		do
			updating_line := True
			l_text := text_displayed
			l_line_height := line_height
			l_x_offset := x_offset
			l_margin_width := left_margin_width
			l_editor_viewport_y_offset := editor_viewport.y_offset
			l_offset := offset
			l_viewable_width := viewable_width
			use_buffered := editor_preferences.use_buffered_line

			if buffered then
				buffered_line.set_background_color (editor_preferences.normal_background_color)
			end

			if not l_text.is_empty then

				from
	 				curr_line := first
	 				l_text.go_i_th (first)
	 			until
	 				curr_line > last or else l_text.after
	 			loop
	 				y_offset := l_editor_viewport_y_offset + ((curr_line - first_line_displayed) * l_line_height)
					l_x_offset := x_offset
					l_has_data := line_has_cursor_or_selection (curr_line)
					l_line_width := l_text.current_line.width

					if (l_line_width + l_margin_width) > l_x_offset or l_buffered or l_has_data then
							-- Only iterate the line if at least some or part of it is in view AND needs redrawing.
							-- Lines with cursor or selection in them ALWAYS need redrawing.
						if use_buffered or l_has_data then
		 					draw_line_to_buffered_line (curr_line, l_text.current_line)
							draw_buffered_line_to_screen (l_x_offset - l_margin_width, buffered_line.width + left_margin_width, l_x_offset, y_offset)
						else
							draw_line_to_screen ((l_x_offset - l_margin_width).max (0), l_x_offset + a_width, y_offset, l_text.current_line)
						end
						l_x_offset := l_x_offset + l_viewable_width
					end

					if l_x_offset >= (l_line_width + l_margin_width) and not l_has_data then
							-- Some (or all) of the line ends in the viewable area.  So we must clear from the end of
							-- the line to the edge of the viewport in the background color.
						if view_invisible_symbols then
							l_start_clear := font.string_width (once "¶")
						else
							l_start_clear := 0
						end

						if (l_line_width + l_margin_width) <= l_offset then
								-- There is no part of the line visible so draw all blank
							l_start_clear := l_start_clear + l_offset
						else
								-- Some of the line is visible so only draw blank from the end of the visible area to the edge of the viewable area
							l_start_clear := l_start_clear + l_line_width + l_margin_width
						end

						if l_line_width < x_offset or (l_start_clear >= x_offset and l_start_clear <= (x_offset + a_width)) then
							debug ("editor")
								draw_flash (l_start_clear, y_offset, x_offset + a_width - l_start_clear, l_line_height, False)
							end
							editor_drawing_area.set_background_color (editor_preferences.normal_background_color)
							editor_drawing_area.clear_rectangle (l_start_clear, y_offset, (x_offset + a_width - l_start_clear).max (0), l_line_height)
						end
					end
			 		curr_line := curr_line + 1
					y_offset := y_offset + l_line_height
			 		l_text.forth

		 		end
		 	end

 			updating_line := False
		end

	line_has_cursor_or_selection (a_line: INTEGER): BOOLEAN is
			-- Does `a_line' have either the cursor or some part of the text selected?
		local
			l_cursor: like cursor_type
			l_text: like text_displayed
		do
			l_text := text_displayed
			l_cursor := l_text.cursor
			if l_cursor /= Void then
	 			Result := (a_line = l_cursor.y_in_lines)
			end

			if not Result then
	 			if l_text.has_selection then
	 				if (a_line >= l_text.selection_start.y_in_lines) and (a_line <= l_text.selection_end.y_in_lines) then
	 					Result := True
	 				end
	 			end
	 		end
		end

feature -- Clipboard

	clipboard: EV_CLIPBOARD
			-- Clipboard.

feature {NONE} -- Scroll bars management

	on_vertical_scroll (vscroll_pos: INTEGER) is
 			-- Process vertical scroll event. `vertical_scrollbar.value' has changed.
 		do
 			Precursor {TEXT_PANEL} (vscroll_pos)

 				-- If the cursor is blinking here we must wipe out the previous action because they draw onto the wrong line
 			if blinking_timeout /= Void and then text_displayed.cursor /= Void then
				reset_blinking
				let_blink := False
				draw_cursor (buffered_line, current_cursor_position, (text_displayed.cursor.y_in_lines - first_line_displayed) * line_height, cursor_width)
				let_blink := True
 			end
 		end

	on_horizontal_scroll (scroll_pos: INTEGER) is
 			-- Process horizontal scroll event. `horizontal_scrollbar.value' has changed.
 		do
 			Precursor {TEXT_PANEL} (scroll_pos)

 				-- If the cursor is blinking here we must wipe out the previous action because they draw onto the wrong line
 			if blinking_timeout /= Void and then text_displayed.cursor /= Void then
				reset_blinking
				let_blink := False
				draw_cursor (buffered_line, current_cursor_position, (text_displayed.cursor.y_in_lines - first_line_displayed) * line_height, cursor_width)
				let_blink := True
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
			if blinking_timeout /= Void and then not blinking_timeout.is_destroyed then
				blinking_timeout.destroy
			end
			if internal_blink_delay_timeout /= Void and then not internal_blink_delay_timeout.is_destroyed then
				internal_blink_delay_timeout.destroy
			end
			key_action_timer := Void
			blinking_timeout := Void
			internal_blink_delay_timeout := Void
		end

feature {NONE} -- Private Constants

	Token_not_selected	: INTEGER is 0
	Token_selected		: INTEGER is 1
	Token_half_selected	: INTEGER is 4;

invariant
	stored_cursor_line_not_negative: stored_cursor_line >= 0
	stored_cursor_char_not_negative: stored_cursor_char >= 0
	stored_first_line_not_negative: stored_first_line >= 0

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




end -- class KEYBOARD_SENSITIVE_TEXT_PANEL
