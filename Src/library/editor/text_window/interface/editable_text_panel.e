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

deferred class
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
			left_margin_width,
			on_key_up
		end
	
feature {NONE} -- Initialization

	user_initialization is
			-- Initialize variables and objects related to display.
		do
				-- Set default mode
			overwrite_mode := False
			enable_editable
			clipboard := ev_application.clipboard
			
			Precursor {SELECTABLE_TEXT_PANEL}
			editor_area.key_press_string_actions.extend (agent on_char)
			editor_area.key_release_actions.extend (agent on_key_up)
			basic_pointer := editor_area.pointer_style
		end

feature -- Access

	not_editable_warning_message: STRING
			-- Warning message indicating text is not editable.
			-- If Void, default message will be used.

	left_margin_width: INTEGER is
			-- Width of left margin
		do
			Result := editor_preferences.left_margin_width
			if Result < 1 then
				Result := default_left_margin_width
			end
		end
		
	blinking_cursor: BOOLEAN is
	        -- Is blinking cursor on?
	  	do
	  	  	Result := editor_preferences.blinking_cursor 
	  	end		

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

	changed: BOOLEAN is
			-- Has the content of the editor changed since it was
			-- loaded or saved?
		do
			Result := text_displayed.changed
		end

	is_editable: BOOLEAN is
			-- Is the text editable?
		do
			print ("is_editable called, status now:" + text_displayed.text_being_processed.out + "%N")
			Result := allow_edition and then not text_displayed.text_being_processed and then not open_backup
		end

feature -- Status setting

	enable_editable is
			-- Allow text edition.
		do
			allow_edition := True
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
			text_displayed.add_edition_observer (txt_observer)
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
					if not ((ctrled_key xor alt_key) or else unwanted_characters.has (c)) then
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

			when Key_v then
					-- Ctrl-V (paste)
				run_if_editable (agent paste)
				
			when Key_a then
					-- Ctrl-A (select all)
				select_all
				scroll_to_cursor := False

			when key_l then
					-- Ctrl-L (line number toggle)
				toggle_line_number_display

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
					-- Ctrl  ins = Ctrl C
				copy_selection

			when Key_delete then
					-- delete action
				if is_editable then
					l_num := number_of_lines
					text_displayed.delete_word (False)
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position
				else
					display_not_editable_warning_message
				end

			when Key_back_space then
					-- delete action
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
--			when key_period then
--				if not shifted_key then
--					if is_editable then
--						handle_character ('.')
--					else
--						display_not_editable_warning_message
--					end
--				end
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

	cursor_y_position: INTEGER is
			-- Current line number (in the whole text).
		require
			not_empty: not is_empty
		do
			Result := text_displayed.cursor.y_in_lines
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

	copy_selection is
			-- Copy current selection to clipboard.
		require
			text_is_not_empty: number_of_lines /= 0
		local
			copied_text: STRING
		do
			if has_selection then
				if not text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
					copied_text := text_displayed.selected_string
					if not copied_text.is_empty then
						clipboard.set_text (copied_text)
					end
				end
			end
		end

	paste is
			-- Paste clipboard at cursor position.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			if clipboard.text /= Void and then not clipboard.text.is_empty then
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
			w: EV_WARNING_DIALOG
		do
			wm := "Current text is not editable"
			if text_displayed /= Void then
				if open_backup then
					show_warning_message ("Backup_file_not_editable")
				elseif not allow_edition then
					if not_editable_warning_message = Void or else not_editable_warning_message.is_empty then
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
				if not editor_area.has_capture then
					editor_area.enable_capture
				end			
				former_y := y_pos
				former_mouse_y := a_screen_y
				mouse_copy_cut := True
				mouse_left_button_down := True
				if ctrled_key then
					editor_area.set_pointer_style (Cursors.Cur_copy_selection)
				else
					editor_area.set_pointer_style (Cursors.Cur_cut_selection)
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
			x_cur, y_cur: INTEGER
		do
			if mouse_copy_cut then
				if button = 1 then
					mouse_copy_cut := False
					editor_area.set_pointer_style (basic_pointer)
					x_cur := x_pos + offset - left_margin_width
					x_cur := x_cur.max (1)
					perform_changes := 
						is_in_editor_panel (a_screen_x, a_screen_y)
							and then
						not position_is_in_selection (x_cur, y_pos, True)
					if perform_changes then
						create cur.make_from_integer (1, text_displayed)
						position_cursor (cur, x_cur, y_pos)
						if ctrled_key then
							text_displayed.copy_selection_to_pos (cur.pos_in_text)
						else
							text_displayed.move_selection_to_pos (cur.pos_in_text)
						end
						refresh_now
					else
						disable_selection
						y_cur := text_displayed.current_line_number
						position_cursor (text_displayed.cursor, x_cur, y_pos)
						invalidate_line (y_cur, True)
					end
				elseif button = 3 then
					cancel_mouse_copy_cut
				end
			end
			if button = 1 then
				forget_mouse_moves := False
			end
			Precursor (x_pos, y_pos, button, unused1,unused2,unused3, a_screen_x, a_screen_y)
		end

	on_mouse_move (abs_x_pos, abs_y_pos: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER) is
		local
			x_cur, y_cur: INTEGER
			tok: EDITOR_TOKEN
			copy_cut_cursor: TEXT_CURSOR		
		do
			if mouse_left_button_down and then mouse_copy_cut then
				x_cur := (a_screen_x - editor_x + offset - left_margin_width).min (editor_width).max (1)
				y_cur := (a_screen_y - editor_y).min (editor_area.height).max (1)
				create copy_cut_cursor.make_from_integer (1, text_displayed)
				position_cursor (copy_cut_cursor, x_cur, y_cur)
				Precursor (abs_x_pos, abs_y_pos, unused1,unused2,unused3, a_screen_x, a_screen_y)
				if not cursor_is_in_selection (copy_cut_cursor) then
					tok := copy_cut_cursor.token
					x_cur := tok.position + tok.get_substring_width (copy_cut_cursor.pos_in_token - 1) +left_margin_width
					y_cur := copy_cut_cursor.y_in_lines
					if prev_x_cur /= x_cur or else prev_y_cur /= y_cur then
						if prev_x_cur /= 0 or else prev_y_cur /= 0 then
							if position_is_displayed (prev_x_cur, prev_y_cur) then
								wipe_cursor_out
							end
							prev_x_cur := 0
							prev_y_cur := 0
						end
						if position_is_displayed (x_cur, y_cur) then
							prev_x_cur := x_cur
							prev_y_cur := y_cur
--							draw_cursor (editor_area, x_cur - offset, (y_cur - first_line_displayed) * line_height, cursor_width, line_height, False)
							draw_cursor (editor_area, (y_cur - first_line_displayed) * line_height)
						end
					end
				elseif prev_x_cur /= 0 or else prev_y_cur /= 0 then
					if position_is_displayed (prev_x_cur, prev_y_cur) then
						wipe_cursor_out
					end
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
			editor_area.set_pointer_style (basic_pointer)
			forget_mouse_moves := True
			if autoscroll.interval /= 0 then
				autoscroll.set_interval (0)
			end
			check_cursor_position
			wipe_cursor_out
		end

	lose_focus is
			-- Update when focus is lost.
		do
			Precursor
			if mouse_copy_cut then
				editor_area.disable_capture
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

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
		do
			if prev_x_cur /= 0 or else prev_y_cur /= 0 then
				if position_is_displayed (prev_x_cur, prev_y_cur) and then prev_y_cur < first_line_displayed + number_of_lines_displayed then
					wipe_cursor_out
				end
				prev_x_cur := 0
				prev_y_cur := 0
			end
			Precursor (fld, refresh_if_necessary)
		end

	set_offset (an_offset: INTEGER) is
			-- 
		do
			if prev_x_cur /= 0 or else prev_y_cur /= 0 then
				if position_is_displayed (prev_x_cur, prev_y_cur) and then prev_y_cur < first_line_displayed + number_of_lines_displayed then
					wipe_cursor_out
				end
				prev_x_cur := 0
				prev_y_cur := 0
			end
			Precursor (an_offset)
		end
		
	wipe_cursor_out is
			-- Wipe copy cut cursor out from then editor.
		local
			zone: EV_RECTANGLE
			x_p, y_p: INTEGER
		do
			y_p := (prev_y_cur - first_line_displayed) * line_height
			if y_p >= 0 and then y_p < editor_area.height then
					-- wipe the cursor out if it is at a position that is still on screen.
				x_p := prev_x_cur - offset
				create zone.make (x_p - left_margin_width + offset, y_p, cursor_width, line_height) --x_p + cursor_width - left_margin_width, y_p + line_height)
--				editor_area.draw_sub_pixmap (x_p, y_p, buffered_screen, zone)
				editor_area.flush
			end
		end
		
	on_key_down (ev_key: EV_KEY)is
		do
			if mouse_copy_cut and then ev_key /= Void then
				if ev_key.code = Key_Ctrl then
					editor_area.set_pointer_style (Cursors.Cur_copy_selection)
				elseif ev_key.code = Key_escape then
					cancel_mouse_copy_cut
				end
			end
			Precursor (ev_key)
		end

	on_key_up (ev_key: EV_KEY)is
		do
			Precursor {SELECTABLE_TEXT_PANEL} (ev_key)
			if mouse_copy_cut and then ev_key /= Void and then ev_key.code = Key_Ctrl then
					editor_area.set_pointer_style (Cursors.Cur_cut_selection)
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

--	load_file (a_file_name: FILE_NAME) is
--			-- Load file named `a_file_name' in the editor.
--		local
--			test_file, test_file_2: RAW_FILE
--		do
--				-- Reset the editor state
--			reset
--
--			load_file_error := False
--			create file_name.make_from_string (a_file_name)
--			create test_file.make (a_file_name)
--			file_name.add_extension ("swp")
--			create test_file_2.make (file_name)
--			if test_file_2.exists 
--					and then
--				test_file_2.is_readable
--					and then
--				((not test_file.exists) or else test_file.date < test_file_2.date)
--			then
--				ask_if_opens_backup
--				if not open_backup then
--					test_file_2.delete
--					file_name := a_file_name
--				end
--				load_chosen_file
--			else
--				file_name := a_file_name
--				create test_file.make (file_name)
--				if test_file.exists and then test_file.is_readable then
--					load_chosen_file
--				else
--					load_file_error := True
--				end
--			end
--		end

--	load_chosen_file is
--			-- Load file named `file_name' in the editor.
--		local
--			retried: BOOLEAN
--			text_to_load: STRING
--			fl: RAW_FILE
--		do
--			if retried then
--				load_file_error := True
--			else
--				editor_area.disable_sensitive
--
--					-- read the file
--				create fl.make_open_read (file_name)
--				date_of_file_when_loaded := fl.date
--				fl.read_stream (fl.count)
--				text_to_load := fl.last_string
--				fl.close
--
--				is_unix_file := text_to_load.substring_index ("%R%N", 1) = 0
--				if not is_unix_file then
--					text_to_load.replace_substring_all ("%R%N", "%N")
--				end
--
--					-- Read and parse the file.
--				text_displayed.set_first_read_block_size (number_of_lines_displayed)
--				text_displayed.load_string (text_to_load)
--	
--					-- Setup the editor (scrollbar, ...)
--				setup_editor
--				editor_area.enable_sensitive
--
--			end
--		rescue
--			retried := True
--			retry
--		end

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
			Precursor {SELECTABLE_TEXT_PANEL}		
			date_of_file_when_loaded := 0
			open_backup := False
			file_name := Void
		end

	on_text_loaded is
			-- Finish editor setup as the entire text has been loaded.
		do
			Precursor {SELECTABLE_TEXT_PANEL}
			if open_backup then
				text_observer_manager.set_changed (True, True)
			end
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

--	scrolling_quantum: INTEGER is
--			-- Number of lines to scroll per mouse wheel scroll increment.
--		do
--			if Editor_preferences.mouse_wheel_scroll_full_page then
--				Result := number_of_lines_displayed - 2
--			else
--				Result := Editor_preferences.mouse_wheel_scroll_size
--			end
--		end

	maximum_top_line_index: INTEGER is
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			if allow_edition then
				Result := (text_displayed.number_of_lines - (number_of_lines_displayed // 2)).max (1)
			else
				Result := Precursor {SELECTABLE_TEXT_PANEL}
			end
		end

	show_vertical_scrollbar: BOOLEAN is
			-- Is it necessary to show the vertical scroll bar ?
		do
			if allow_edition then
				Result := text_displayed /= Void and then (number_of_lines_displayed < 2 * (text_displayed.number_of_lines - 1))
			else
				Result := Precursor {SELECTABLE_TEXT_PANEL}
			end
		end 

--	normal_background_color: EV_COLOR is
--			-- Default color for editor background.
--		do
--			Result := Editor_preferences.normal_background_color
--		end

--	quadruple_click_enabled: BOOLEAN is
--			-- Should a quadruple click result in the selection of the entire text?
--		do
--			Result := Editor_preferences.quadruple_click_enabled
--		end

--	internal_reference_window: EV_WINDOW
			-- Window which dialogs will be shown relative to.
			
--	draw_cursor (media: EV_DRAWABLE; y: INTEGER) is
--			-- Draw the cursor block defined by the rectangle
--			-- (`x1',`y1')- (`x1' + `width_cursor',`y1' + `ln_height') on `media'.
--			-- The cursor is black if `in_black', gray otherwise.
--		do		
--			if overwrite_mode then
--				Precursor (media, y)
--			else
--				Precursor (media, y)
--			end
--		end

feature -- Clipboard

	clipboard: EV_CLIPBOARD
			-- Clipboard.

feature {NONE} -- Private Constants

	unwanted_characters: ARRAYED_LIST [CHARACTER] is
			-- Unwanted characters: backspace, tabulation, carriage return and escape. 
		once
			create Result.make (4)
			Result.extend ('%/8/')
			Result.extend ('%/9/')
			Result.extend ('%/10/')
			Result.extend ('%/13/')
			Result.extend ('%/27/')
		end

	meta_key_codes: ARRAY [INTEGER] is
			-- Codes of meta keys. 
		once
			Result := <<Key_ctrl, Key_caps_lock, Key_right_meta, Key_left_meta, Key_scroll_lock, Key_num_lock, Key_shift>>
		end

end -- class EDITABLE_TEXT_PANEL
