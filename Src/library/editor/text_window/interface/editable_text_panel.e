indexing
	description: "[
		Editable: yes
		Scroll bars: yes
		Cursor: yes
		Keyboard: yes
		Mouse: yes
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITABLE_TEXT_PANEL

inherit
	SELECTABLE_TEXT_PANEL
		redefine
			text_displayed,
			user_initialization, 
			handle_extended_key,
			handle_extended_ctrled_key,
			reset, clear_window,
			on_line_removed, 
			on_line_inserted, 
			on_line_modified,
			on_block_removed,
			on_text_loaded,
			lose_focus,
			show_vertical_scrollbar,
			maximum_top_line_index,
			process_left_click,
			on_mouse_button_up,
			on_mouse_move,
			ignore_keyboard_input,
			set_first_line_displayed,
			scroll_only,
			set_offset,
			on_key_down,
			on_key_up,
			draw_cursor,
			internal_draw_cursor
		end
	
feature {NONE} -- Initialization

	user_initialization is
			-- Initialize variables and objects related to display.
		do
				-- Set default mode
			overwrite_mode := False
			enable_editable			
			
			Precursor {SELECTABLE_TEXT_PANEL}
			editor_drawing_area.key_press_string_actions.extend (agent on_char)
			basic_pointer := editor_drawing_area.pointer_style
		end

feature -- Access

	not_editable_warning_message: STRING
			-- Warning message indicating text is not editable.
			-- If Void, default message will be used.
		
	blinking_cursor: BOOLEAN is
	        -- Is blinking cursor on?
	  	do
	  	  	Result := editor_preferences.blinking_cursor 
	  	end		

	copy_cut_cursor: TEXT_CURSOR

feature -- Content change

	clear_window is
			-- Wipe out the text area.
		do
			disable_editable
			Precursor {SELECTABLE_TEXT_PANEL}
		end
		
	display_message (message: STRING) is
			-- Display `message' in the editor.
		do
			load_text (message)
			disable_editable
		end

feature -- Text status report

	undo_is_possible: BOOLEAN is
			-- Is there any operation to undo?
		do
			Result := text_displayed.undo_is_possible
		end

	redo_is_possible: BOOLEAN is
			-- Is there any operation to redo?
		do
			Result := text_displayed.redo_is_possible
		end

	is_read_only: BOOLEAN
			-- Is text read-only?

	is_editable: BOOLEAN is
			-- Is the text editable?
		do
			Result := not is_read_only and then allow_edition and then not text_displayed.text_being_processed
		end

feature -- Status setting

	set_read_only (a_flag: BOOLEAN) is
			-- Set `is_read_only' to `a_flag'.
		do
			is_read_only := a_flag	
			allow_edition := not a_flag
		end		

	enable_editable is
			-- Allow text edition.
		do
			if not is_read_only then
				allow_edition := True	
			end			
		end

	disable_editable is
			-- Forbid text edition.
		do
			allow_edition := False
		end

	set_changed (val: BOOLEAN) is
			-- Assign `val' to `changed'.
		require
			text_exists: not is_empty
		do
			text_displayed.set_changed (val, True)
		end	

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
		do
			if prev_x_cur /= 0 or else prev_y_cur /= 0 then
				if position_is_displayed (prev_x_cur, prev_y_cur) and then prev_y_cur < first_line_displayed + number_of_lines_displayed then
					wipe_copy_cut_cursor_out
				end
			end
			Precursor (fld, refresh_if_necessary)
		end

feature -- Element Change

	set_not_editable_warning_message (message: STRING) is
			-- Assign `message' to `not_editable_warning_message'
		do
			not_editable_warning_message := message
		end

feature -- File access status report

	open_backup: BOOLEAN
			-- If a backup file is present, should it be opened or not?

	load_file_error: BOOLEAN
			-- Did an error occur during last file loading?

feature -- Indirect observer / manager pattern.

	add_edition_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for global content changes.
		do
			if text_displayed /= Void then
				text_displayed.add_edition_observer (txt_observer)
			end
		end

	add_history_observer (history_observer: UNDO_REDO_OBSERVER) is
			-- Add observer of `history'.
		do
			text_displayed.history.add_observer (history_observer)
		end

	remove_history_observer (history_observer: UNDO_REDO_OBSERVER) is
			-- Remove observer of `history'.
		do
			text_displayed.history.remove_observer (history_observer)
		end

feature -- Private Status

	allow_edition: BOOLEAN
			-- Can we edit the text if it is not the backup?

	overwrite_mode: BOOLEAN
			-- Do inserted characters overwrite existing ones?

feature 

	text_displayed: EDITABLE_TEXT
			-- Text displayed in the editor.

feature -- Process Vision2 events

 	on_char (character_string: STRING) is
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER
   		do
			if not ignore_keyboard_input then
				if not character_string.is_empty then
		   			c := character_string @ 1
					if not ((ctrled_key xor alt_key) or else unwanted_characters.item (c.code)) then
							-- Ignoring ctrled keys and other special keys (Esc, Tab, Enter, Backspace)
						handle_character (c)
					end
				end
			end
 		end

feature {NONE} -- Handle keystokes

 	handle_character (c: CHARACTER) is
 			-- Process push on a character key corresponding to `c'.
		local
			had_selection: BOOLEAN
 		do
			if is_editable then
				check_position (text_displayed.cursor)
				had_selection := text_displayed.has_selection
				if overwrite_mode then
					text_displayed.replace_char (c)
				else
					text_displayed.insert_char (c)
				end
				if had_selection then
					refresh_now
				else
					invalidate_cursor_rect (True)
				end
			else
				display_not_editable_warning_message
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			l_num: INTEGER
			scroll_to_cursor: BOOLEAN
		do
			scroll_to_cursor := True
			inspect
				ev_key.code
			when Key_x then
					-- Ctrl-X (cut)
				run_if_editable (agent cut_selection)
			when Key_c then
					-- Ctrl-C (copy)
				copy_selection
				scroll_to_cursor := False
			when Key_v then
					-- Ctrl-V (paste)
				run_if_editable (agent paste)				
			when Key_a then
					-- Ctrl-A (select all)
				select_all
				scroll_to_cursor := False		
			when key_y then
					-- Ctrl-Y (Redo)
				if text_displayed.redo_is_possible then
					redo	
				end				
			when key_z then
					-- Ctrl-L (Undo)
				if text_displayed.undo_is_possible then					
					undo	
				end
			when Key_insert then
					-- Ctrl-Insert = Ctrl-C
				copy_selection
			when Key_delete then
					-- Ctrl-Delete = Ctrl-X or delete word
				if is_editable then
					if has_selection then
						cut_selection						
					else
					l_num := number_of_lines
					text_displayed.delete_word (False)
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position	
					end
				else
					display_not_editable_warning_message
				end
			when Key_back_space then
					-- Ctrl-Backspace
				if is_editable then
					l_num := number_of_lines
					text_displayed.delete_word (True)
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position
				else
					display_not_editable_warning_message
				end
			else
				Precursor (ev_key)
				scroll_to_cursor := False
			end
			if not meta_key_codes.has (ev_key.code) and then scroll_to_cursor then
				check_cursor_position
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			l_num: INTEGER
		do
			inspect
				ev_key.code

			when Key_delete then
				if is_editable then
					if Shifted_key then
						cut_selection
					else
							-- Delete key action
						l_num := number_of_lines
						text_displayed.delete_char
						if l_num /= number_of_lines then
							refresh_now
						else
							invalidate_cursor_rect (True)
						end
						check_cursor_position
					end
				else
					display_not_editable_warning_message
				end

			when Key_back_space then
					-- Backspace key action
				if is_editable then
					l_num := number_of_lines
					text_displayed.back_delete_char
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position
				else
					display_not_editable_warning_message
				end

			when Key_enter then
					-- Return/Enter key action
				if is_editable then
					text_displayed.insert_eol
					refresh_now
					check_cursor_position
				else
					display_not_editable_warning_message
				end

			when Key_insert then
				if Shifted_key and then is_editable then
					paste
				else
					if is_editable then
							-- Insert key action
						overwrite_mode := not overwrite_mode
						invalidate_cursor_rect (True)
					else
						display_not_editable_warning_message
					end
				end

			when Key_tab then
				if is_editable then
						-- Tab key action
					if shifted_key then
							-- Shift + Tab = Unindent selection
						unindent_selection
					elseif has_selection and then text_displayed.selected_string.has ('%N') then
							-- Tab = indent selection
						indent_selection
					else
							-- normal behavior --> we insert a %T character
						handle_character ('%T')
					end
				else
					display_not_editable_warning_message
				end
			else
				Precursor (ev_key)
			end
		end

feature {EDITOR_CURSOR} -- Handle text modifications

	on_line_modified (line_number: INTEGER) is
			-- Update `Current' when line number `line_number' has been modified.
		local
			wdth: INTEGER 
		do
			wdth := text_displayed.line (line_number).width + left_margin_width + 50
			if editor_width < wdth then
				set_editor_width (wdth)
			end
		end

	on_line_removed (line_number: INTEGER) is
			-- Update `Current' when line number `line_number' has been removed.
		do
			if not text_displayed.is_removing_block then
				set_first_line_displayed (first_line_displayed.min (maximum_top_line_index), True)
				update_vertical_scrollbar
			end
		end
		
	on_block_removed is
			-- Update current when a block of text has been removed
		do
			set_first_line_displayed (first_line_displayed.min (maximum_top_line_index), True)
			update_vertical_scrollbar
		end
		
	on_line_inserted (line_number: INTEGER) is
			-- Update `Current' when line number `line_number' has been inserted.
		local
			wdth: INTEGER 
		do
			wdth := text_displayed.line (line_number).width + left_margin_width + 50
			if editor_width < wdth then
				set_editor_width (wdth)
			end
			update_vertical_scrollbar
		end

feature -- Text selection access

	string_selection: STRING is
			-- Current selection string
		require
			has_selection: has_selection
		do
			if has_selection then
				if not text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
					Result := text_displayed.selected_string
				end
			end
		end

feature -- Text status report

	cursor_x_position: INTEGER is
			-- Current column number.
		require
			not_empty: not is_empty
		do
			Result := text_displayed.cursor.x_in_characters
		end

	cursor_visible_x_position: INTEGER is
			-- Current visible character position in line.
		require
			not_empty: not is_empty
		do
			Result := text_displayed.cursor.x_in_visible_characters
		end

	cursor_y_position: INTEGER is
			-- Current line number (in the whole text).
		require
			not_empty: not is_empty
		do
			Result := text_displayed.cursor.y_in_lines
		end

	 draw_cursor (media: EV_DRAWABLE; x, y, width: INTEGER) is
			-- Draw the cursor block defined by the rectangle associated with the current cursor at `y' and on `media'.		
		local
			width_cursor: INTEGER
			l_cursor: TEXT_CURSOR
		do
			l_cursor := text_displayed.cursor
			
				-- Compute the width of the current character (used to display plain cursor)
			width_cursor := l_cursor.token.get_substring_width (l_cursor.pos_in_token) - l_cursor.token.get_substring_width (l_cursor.pos_in_token - 1)
			width_cursor := width_cursor.max (cursor_width)
					
						-- Draw the cursor
			if overwrite_mode then
				Precursor (buffered_line, x, y, width_cursor)
    		else
    			Precursor (buffered_line, x, y, width)
			end			
 		end

	draw_copy_cut_cursor (media: EV_DRAWABLE; x, y, width: INTEGER) is
			-- Draw the copy cut cursor block defined by the rectangle associated with the copy_cut_cursor at `y' and on `media'.		
		require
			copy_cut_cursor_not_void: copy_cut_cursor /= Void
		local
			width_cursor: INTEGER
			y_pos: INTEGER
		do			
				-- Compute the width of the current character (used to display plain cursor)
			width_cursor := copy_cut_cursor.token.get_substring_width (copy_cut_cursor.pos_in_token) - copy_cut_cursor.token.get_substring_width (copy_cut_cursor.pos_in_token - 1)
			width_cursor := width_cursor.max (cursor_width)
			y_pos := y + editor_viewport.y_offset
			media.set_xor_mode
			media.set_foreground_color (editor_preferences.plain_white)			
			media.fill_rectangle (x, y_pos, width, line_height)
			media.set_copy_mode
 		end

	internal_draw_cursor (media: EV_DRAWABLE; x, y, width_cursor, ln_height: INTEGER; do_show: BOOLEAN) is
			-- Internal cursor drawing.  Draws cursor on `media' at position `x' and `y'.
		do		
			if not mouse_copy_cut then
				Precursor (media, x, y, width_cursor, ln_height, do_show)
			else
				media.set_xor_mode
				media.set_foreground_color (editor_preferences.plain_white)
				media.fill_rectangle (x, y, width_cursor, ln_height)			
				media.set_copy_mode	
			end					
		end

feature -- Edition Operations on text

	cut_selection is
			-- Copy current selection to clipboard and remove it.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			if has_selection then
				if not text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
					copy_selection
					text_displayed.delete_selection
					refresh_now
				end
			end
		end

	paste is
			-- Paste clipboard at cursor position.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		local
			a_text: STRING
		do
			a_text := clipboard.text
			if not a_text.is_empty then
				text_displayed.insert_string (clipboard.text)
				refresh_now
			end
		end

	set_selection_case (lower: BOOLEAN) is
		do
			if not text_displayed.is_empty then
				text_displayed.set_selection_case (lower)
				refresh_now
			end
		end

	undo is
			-- Undo last command.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
			undo_possible: text_displayed.undo_is_possible
		do
			text_displayed.undo
			check_cursor_position
			refresh_now
		end
	
	redo is
			-- Redo last command.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
			redo_possible: text_displayed.redo_is_possible
		do
			text_displayed.redo
			check_cursor_position
			refresh_now
		end

	indent_selection is
			-- Indent selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.indent_selection
			refresh_now
		end

	unindent_selection is
			-- Unindent selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.unindent_selection
			refresh_now
		end

	run_if_editable (command: PROCEDURE[like Current, TUPLE]) is
			-- Apply `command' if the current text is editable.
			-- Otherwise, display a message which warns the user
			-- that the text cannot be modified.
		do
			if is_editable then
				command.apply
			else
				display_not_editable_warning_message
			end
		end

	replace_selection (word: STRING) is
			-- Replace currently selected text with `word'.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.replace_selection (word)
			refresh
		end

	display_not_editable_warning_message is
				-- display warning message : text is not editable...
		local
			wm: STRING
		do
			wm := "Current text is not editable"
			if text_displayed /= Void then				
				if is_read_only then
					if not_editable_warning_message /= Void and not not_editable_warning_message.is_empty then
						wm := not_editable_warning_message
					end	
					show_warning_message (wm)
				else
					show_warning_message (wm)
				end
			end
		end

feature {NONE} -- Mouse copy cut

	process_left_click (x_pos, y_pos: INTEGER; a_screen_x, a_screen_y: INTEGER) is
		do
			if is_editable and then has_selection and then position_is_in_selection (x_pos, y_pos, False) and then click_count = 0 then
				if not editor_drawing_area.has_capture then
					editor_drawing_area.enable_capture
				end			
				former_y := y_pos
				former_mouse_y := a_screen_y
				mouse_copy_cut := True
				mouse_left_button_down := True
				if ctrled_key then
					editor_drawing_area.set_pointer_style (Cursors.Cur_copy_selection)
				else
					editor_drawing_area.set_pointer_style (Cursors.Cur_cut_selection)
				end
			else
				mouse_copy_cut := False
				Precursor (x_pos, y_pos, a_screen_x, a_screen_y)
			end
		end

	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER) is
		local
			cur: TEXT_CURSOR
			perform_changes: BOOLEAN
			x_cur, y_cur, l_y_pos: INTEGER
		do
			if mouse_copy_cut then
				if button = 1 then
					mouse_copy_cut := False
					editor_drawing_area.set_pointer_style (basic_pointer)				
					x_cur := (x_pos - left_margin_width) .max (1)
					l_y_pos := y_pos - editor_viewport.y_offset
					perform_changes :=  is_in_editor_panel (a_screen_x, a_screen_y) and then not position_is_in_selection (x_cur, l_y_pos, True)
					if perform_changes then
						create cur.make_from_integer (1, text_displayed)
						position_cursor (cur, x_cur, l_y_pos)
						if ctrled_key then
							text_displayed.copy_selection_to_pos (cur.pos_in_text)
						else
							text_displayed.move_selection_to_pos (cur.pos_in_text)
						end
						refresh_now
					else
						disable_selection
						y_cur := text_displayed.current_line_number
						position_cursor (text_displayed.cursor, x_cur, l_y_pos)
						invalidate_line (y_cur, True)
					end
				elseif button = 3 then
					cancel_mouse_copy_cut
				end			
			end
			if button = 1 then
				forget_mouse_moves := False
			end
			Precursor (x_cur, l_y_pos, button, unused1,unused2,unused3, a_screen_x, a_screen_y)
			if blink_suspended and button /= 3 then
				resume_cursor_blinking
			end
		end

	on_mouse_move (abs_x_pos, abs_y_pos: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER) is
		local
			x_cur, y_cur: INTEGER
			tok: EDITOR_TOKEN					
		do
			if mouse_left_button_down and then mouse_copy_cut then
					-- Position the temporary copy/cut cursor at the best location based on mouse co-ordinates
				wipe_copy_cut_cursor_out
				x_cur := abs_x_pos + offset - left_margin_width
				y_cur := (a_screen_y - editor_y).min (viewable_height).max (1)
				create copy_cut_cursor.make_from_integer (1, text_displayed)
				position_cursor (copy_cut_cursor, x_cur, y_cur)
				Precursor (abs_x_pos, abs_y_pos, unused1,unused2,unused3, a_screen_x, a_screen_y)
				if not cursor_is_in_selection (copy_cut_cursor) then						
					tok := copy_cut_cursor.token
					if prev_x_cur > 0 and prev_x_cur > x_cur then
						x_cur := tok.position + tok.get_substring_width (copy_cut_cursor.pos_in_token)
					else
						x_cur := tok.position + tok.get_substring_width (copy_cut_cursor.pos_in_token - 1)
					end					
					y_cur := copy_cut_cursor.y_in_lines
					if prev_x_cur /= x_cur or else prev_y_cur /= y_cur then
						if prev_x_cur /= 0 or else prev_y_cur /= 0 then
							prev_x_cur := 0
							prev_y_cur := 0
						end
						if position_is_displayed (x_cur + left_margin_width, y_cur) then
							prev_x_cur := x_cur
							prev_y_cur := y_cur
							draw_copy_cut_cursor (editor_drawing_area, x_cur - offset + left_margin_width, (y_cur - first_line_displayed) * line_height, cursor_width)
						end
					end
				elseif prev_x_cur /= 0 or else prev_y_cur /= 0 then
					prev_x_cur := 0
					prev_y_cur := 0
				end
			elseif not forget_mouse_moves then
				Precursor (abs_x_pos, abs_y_pos, unused1,unused2,unused3, a_screen_x, a_screen_y)
			end
		end
	
	cancel_mouse_copy_cut is
			-- stop mouse copy/cut.
		do
			mouse_copy_cut := False
			editor_drawing_area.set_pointer_style (basic_pointer)
			forget_mouse_moves := True
			if autoscroll.interval /= 0 then
				autoscroll.set_interval (0)
			end
			check_cursor_position
			wipe_copy_cut_cursor_out
		end

	lose_focus is
			-- Update when focus is lost.
		do
			Precursor
			if mouse_copy_cut then
				editor_drawing_area.disable_capture
				mouse_left_button_down := False
			end
		end		
		
	ignore_keyboard_input: BOOLEAN is
			-- Should key event be ignored?
		do
			Result := Precursor or else mouse_copy_cut
		end

	basic_pointer: EV_CURSOR
			-- Normal shape of the mouse pointer.

	mouse_copy_cut: BOOLEAN
			-- Is the user trying to copy/paste with the mouse?

	prev_x_cur: INTEGER
			-- Coordinate where the copy/paste cursor was last drawn.

	prev_y_cur: INTEGER
			-- Coordinate where the copy/paste cursor was last drawn.

	forget_mouse_moves: BOOLEAN
			-- Should mouse pointer moves be ignored?

	set_offset (an_offset: INTEGER) is
			-- 
		do
			if prev_x_cur /= 0 or else prev_y_cur /= 0 then
				if position_is_displayed (prev_x_cur, prev_y_cur) and then prev_y_cur < first_line_displayed + number_of_lines_displayed then
					wipe_copy_cut_cursor_out
				else
					prev_x_cur := 0
					prev_y_cur := 0
				end
			end
			Precursor (an_offset)
		end
		
	wipe_copy_cut_cursor_out is
			-- Wipe copy cut cursor out from then editor.
		local
			x_p, y_p: INTEGER
		do
			y_p := (prev_y_cur - first_line_displayed) * line_height + editor_viewport.y_offset
			if y_p >= 0 and then y_p < editor_drawing_area.height then				
					-- Wipe the cursor out if it is at a position that is still on screen.
				x_p := prev_x_cur - offset + left_margin_width
				debug ("editor")
					draw_flash (x_p, y_p, cursor_width, line_height, False)
				end
				editor_drawing_area.redraw_rectangle (x_p, y_p, cursor_width, line_height)
				editor_drawing_area.flush
			end
			prev_x_cur := 0
			prev_y_cur := 0
			copy_cut_cursor := Void
		end
		
	on_key_down (ev_key: EV_KEY) is
		do
			if mouse_copy_cut and then ev_key /= Void then
				if ev_key.code = Key_Ctrl then
					if Cursors /= Void then
						editor_drawing_area.set_pointer_style (cursors.cur_copy_selection)	
					end
				elseif ev_key.code = Key_escape then
					cancel_mouse_copy_cut
				end
			end
			Precursor (ev_key)
		end

	on_key_up (ev_key: EV_KEY) is
		do
			Precursor {SELECTABLE_TEXT_PANEL} (ev_key)
			if mouse_copy_cut and then ev_key /= Void and then ev_key.code = Key_Ctrl then
				if Cursors /= Void then
					editor_drawing_area.set_pointer_style (cursors.cur_cut_selection)	
				end
			end
		end		

	scroll_only: BOOLEAN is
		do
			Result := mouse_copy_cut
		end

	position_is_displayed (x_pos, y_pos: INTEGER): BOOLEAN is
			-- Is point with coordinates `x_pos', `y_pos' visible?
		do
			Result := 
					x_pos > offset
						and then
					x_pos < editor_width + offset
						and then
					y_pos >= first_line_displayed
						and then
					y_pos <= first_line_displayed + number_of_lines_displayed
		end
		
feature {NONE} -- Text Loading

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
			Precursor {SELECTABLE_TEXT_PANEL}		
			date_of_file_when_loaded := 0
			file_name := Void
		end

	on_text_loaded is
			-- Finish editor setup as the entire text has been loaded.
		do
			Precursor {SELECTABLE_TEXT_PANEL}
			if open_backup then
				text_observer_manager.set_changed (True, True)
			end
			enable_editable
		end

feature {NONE} -- retrieving backup

	open_normal_selected is
			-- The open normal button was pushed.
		do
			open_backup := False
		end

	open_backup_selected is
			-- The open backup button was pushed.
		do
			open_backup := True
		end

feature {NONE} -- Implementation

	maximum_top_line_index: INTEGER is
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			if not is_read_only and then allow_edition then
				Result := (text_displayed.number_of_lines - (number_of_lines_displayed // 2)).max (1)
			else
				Result := Precursor {SELECTABLE_TEXT_PANEL}
			end
		end

	show_vertical_scrollbar: BOOLEAN is
			-- Is it necessary to show the vertical scroll bar ?
		do
			if not is_read_only and then allow_edition then
				Result := text_displayed /= Void and then (number_of_lines_displayed < 2 * (text_displayed.number_of_lines - 1))
			else
				Result := Precursor {SELECTABLE_TEXT_PANEL}
			end
		end 

feature {NONE} -- Private Constants

	unwanted_characters: SPECIAL [BOOLEAN] is
			-- Unwanted characters: backspace, tabulation, carriage return and escape. 
		local
			c: CHARACTER
			i: INTEGER
		once
			create Result.make (256)
			from
				i := 0
			until
				i = 256
			loop
				c := i.to_character
				Result.put (c.is_control, i)
				i := i + 1
			end
		end

	meta_key_codes: ARRAY [INTEGER] is
			-- Codes of meta keys. 
		once
			Result := <<Key_ctrl, Key_caps_lock, Key_right_meta, Key_left_meta, Key_scroll_lock, Key_num_lock, Key_shift>>
		end

end -- class EDITABLE_TEXT_PANEL
